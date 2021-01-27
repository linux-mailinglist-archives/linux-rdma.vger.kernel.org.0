Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FC305F0A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhA0PDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235213AbhA0PBS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4BE20897;
        Wed, 27 Jan 2021 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759626;
        bh=Co6VhMiC9BCjdu0+ONGcyQqTlXLqwG6owhsOYXJQbbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nlgk9ZQpgkALWLJEM5xu2VTgEINvnvUjYruxwbX+DkiqtpoeiBTZY0tgtVM7j1s/l
         MRSOBvWsx4kE2137V6SiC93HNEHEptcU5tjH8hYTa6e3zfmaDgPQnUs7wnCBVSXVSD
         fYFTK7ibjstDwm8Vl96w9MmoZ53St+71YpvkGTD2lFnhqwLA3PvANgTWcPT7c4I9D9
         +Kivy6coyNBaoyO+26XvHOa3j9EvjnGXelwYwRvBF1MMKvcL2i7zXw56Tx/EVCwr5J
         dcqMEek0csECSu/LSYyNI6B6VYdbHjj/rWY76O39874QpLcGHGcqJh2mNJ8eKEMzpK
         HaAgoFB265rKw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 03/10] IB/mlx5: Support default partition key for representor port
Date:   Wed, 27 Jan 2021 17:00:03 +0200
Message-Id: <20210127150010.1876121-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Representor port has only one default pkey.
Hence have simpler query pkey callback or it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5765f30f1788..6f2c03230c49 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1398,6 +1398,16 @@ static int mlx5_ib_rep_query_port(struct ib_device *ibdev, u8 port,
 	return ret;
 }

+static int mlx5_ib_rep_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
+				  u16 *pkey)
+{
+	/* Default special Pkey for representor device port as per the
+	 * IB specification 1.3 section 10.9.1.2.
+	 */
+	*pkey = 0xffff;
+	return 0;
+}
+
 static int mlx5_ib_query_gid(struct ib_device *ibdev, u8 port, int index,
 			     union ib_gid *gid)
 {
@@ -4217,6 +4227,7 @@ static int mlx5_ib_stage_non_default_cb(struct mlx5_ib_dev *dev)
 static const struct ib_device_ops mlx5_ib_dev_port_rep_ops = {
 	.get_port_immutable = mlx5_port_rep_immutable,
 	.query_port = mlx5_ib_rep_query_port,
+	.query_pkey = mlx5_ib_rep_query_pkey,
 };

 static int mlx5_ib_stage_raw_eth_non_default_cb(struct mlx5_ib_dev *dev)
--
2.29.2

