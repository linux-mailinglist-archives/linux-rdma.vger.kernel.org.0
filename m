Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51ED458DE2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhKVL5O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239451AbhKVL5N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 06:57:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17AD760240;
        Mon, 22 Nov 2021 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582047;
        bh=+WfgAau+hYSje8yRBW+PXBBqEqMtRy+awEinDB0lNqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/UYotcEdAIuT60s2//IGh0yXjT9kOBkL3XCNpFqjbcUtt2xsLnE6J/dxDf4sC0qG
         NEsPBbI1l19Er68hoTNwlDVviYqgdWlN59DS7P6cGlEIYHpspsGAb7X/O7Up0U2tNr
         IW/8WCMo1n1j3MwNNnqTeKPp91p5Wf/Al8x+4Pf+AdCv238FkcydeS8pIxzcED/TC6
         aE8f3Iim21PchGDeElJvoAUgESfC3C5K+8rNgsnWufsFTPj+1pzIdre5By5tv3cVbk
         CJHb5YiIkn0GtE/iOKfTFEtAX2V6UsHc1YpuJFpXQaW5OF87VUGBd9kukBLkJCLAta
         Zh/Ujlf8EOLzw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH rdma-next 2/3] RDMA/core: Let ib_find_gid() continue search even after empty entry
Date:   Mon, 22 Nov 2021 13:53:57 +0200
Message-Id: <aab136be84ad03185a1084cb2e1ca9cad322ab23.1637581778.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637581778.git.leonro@nvidia.com>
References: <cover.1637581778.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Currently, ib_find_gid() will stop searching after encountering the
first empty GID table entry. This behavior is wrong since neither IB
nor RoCE spec enforce tightly packed GID tables.

For example, when a valid GID entry exists at index N, and if a GID
entry is empty at index N-1, ib_find_gid() will fail to find the valid
entry.

Fix it by making ib_find_gid() continue searching even after
encountering missing entries.

Fixes: 5eb620c81ce3 ("IB/core: Add helpers for uncached GID and P_Key searches")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 22a4adda7981..b5d8443030d4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2460,8 +2460,11 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
 		for (i = 0; i < device->port_data[port].immutable.gid_tbl_len;
 		     ++i) {
 			ret = rdma_query_gid(device, port, i, &tmp_gid);
+			if (ret == -ENOENT)
+				continue;
 			if (ret)
 				return ret;
+
 			if (!memcmp(&tmp_gid, gid, sizeof *gid)) {
 				*port_num = port;
 				if (index)
-- 
2.33.1

