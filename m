Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DB32D2A1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhCDMJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240179AbhCDMIt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C52864F0B;
        Thu,  4 Mar 2021 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614859689;
        bh=jBO/wjl0WKOo+LTLgpQ1TGh37my2c50DGnD/JXKcuFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIzCLkb3cnb4jdgLsWt58SQf3HlFS6EgihWqXemQRYIlDrzYWjSaAZ0e4S+ISRHTR
         hV6ylGB3jNLK/wCGalSVo/6rTgOMO6i4lLPNbzbnQVq7hk8gV+lJmntBWD7UiGJycU
         xucU2PiSkmBt6bPpVDuyaRgWEeQaJ3GdgFLCoIkAcuhKvah5bE8FpuOrBmbdRUOmac
         H2YkKjEinj3S1PNLCImK0weFFkR32t6F4GzGXebxzgD//ZVqloXJkPNItVbgBLpof1
         3GrFABLAF6P62HJp+pFWHsxAAriNjixwKBEKQB6v6/P21PRxgM4r4xH3EZwyG1fSbG
         phBho3ukhrUyQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/4] RDMA/mlx5: Use a union inside mlx5_ib_mr
Date:   Thu,  4 Mar 2021 14:07:43 +0200
Message-Id: <20210304120745.1090751-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304120745.1090751-1-leon@kernel.org>
References: <20210304120745.1090751-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The struct mlx5_ib_mr can be used for three different things, but only one
at a time:

 - In the user MR cache
 - As a kernel MR
 - As a user MR

Overlay the three things into a single union with the following rules:

 - If the mr is found on the cache_ent->head list then it is a cache MR
   and umem == NULL. The entire union is zero after the MR is removed from
   the cache.

 - If umem != NULL or type == IB_MR_TYPE_USER then it is a user MR.

 - If umem == NULL then it is a kernel MR

This reduces the size of struct mlx5_ib_mr to 552 bytes from 702.

The only place the three flows overlap in the code is during dereg, so add
a few extra checks along there.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5bfd14c438c1..03deca79c9cf 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -657,7 +657,7 @@ struct mlx5_ib_mr {
 	struct ib_umem *umem;
 
 	/* This is zero'd when the MR is allocated */
-	struct {
+	union {
 		/* Used only while the MR is in the cache */
 		struct {
 			u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ea8f068a6da3..54fd38b01a7e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1929,7 +1929,7 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 static void
 mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 {
-	if (mr->descs) {
+	if (!mr->umem && mr->descs) {
 		struct ib_device *device = mr->ibmr.device;
 		int size = mr->max_descs * mr->desc_size;
 		struct mlx5_ib_dev *dev = to_mdev(device);
@@ -1943,7 +1943,7 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 
 static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	if (mr->sig) {
+	if (mr->ibmr.type == IB_MR_TYPE_INTEGRITY) {
 		if (mlx5_core_destroy_psv(dev->mdev,
 					  mr->sig->psv_memory.psv_idx))
 			mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
-- 
2.29.2

