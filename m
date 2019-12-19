Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCD1263F3
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 14:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSNsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 08:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfLSNsw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 08:48:52 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96572146E;
        Thu, 19 Dec 2019 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576763331;
        bh=qZ8BpbzDVUtR21LRY1faoJePKh7QKahCuIt2qEWdf3E=;
        h=From:To:Cc:Subject:Date:From;
        b=jw8x2AeZkepjfDsO3DTYmWJoaHShEtK8Pn0AenNOs4gD1PxdO9/dgrK55nvVtDnMW
         12UW0MHi129fo9LYMz4fvNUCRQLqrHTdAq5/bIaZepmQhJ9AtjyP0YoJkc2zn3Qsf8
         jedotTqnesEl1asrJeZF+/S9fZebrruh7HSpG3/k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Eugene Crosser <evgenii.cherkashin@profitbricks.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx4: Redo TX checksum offload in line with docs
Date:   Thu, 19 Dec 2019 15:48:47 +0200
Message-Id: <20191219134847.413582-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Eugene Crosser <evgenii.cherkashin@profitbricks.com>

Ingress checksum offload was not working for IPv6 frames because the
conditional expression that checks validation status passed from the
hardware was not matching the algorithm described in the documentation.

This patch defines L4_CSUM flag (which falls inside the badfcs_enc
field in the existing definition of the CQE layout) and replaces the
conditional expression with the one defined in the "ConnectX(r)
Family Programmer's Manual" document.

Signed-off-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
Reviewed-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/cq.c | 18 +++++++-----------
 include/linux/mlx4/cq.h         |  5 +++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 306b21281fa2..72eeb9a85bc5 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -568,18 +568,13 @@ static void mlx4_ib_handle_error_cqe(struct mlx4_err_cqe *cqe,
 	wc->vendor_err = cqe->vendor_err_syndrome;
 }
 
-static int mlx4_ib_ipoib_csum_ok(__be16 status, __be16 checksum)
+static int mlx4_ib_ipoib_csum_ok(__be16 status, u8 badfcs_enc, __be16 checksum)
 {
-	return ((status & cpu_to_be16(MLX4_CQE_STATUS_IPV4      |
-				      MLX4_CQE_STATUS_IPV4F     |
-				      MLX4_CQE_STATUS_IPV4OPT   |
-				      MLX4_CQE_STATUS_IPV6      |
-				      MLX4_CQE_STATUS_IPOK)) ==
-		cpu_to_be16(MLX4_CQE_STATUS_IPV4        |
-			    MLX4_CQE_STATUS_IPOK))              &&
-		(status & cpu_to_be16(MLX4_CQE_STATUS_UDP       |
-				      MLX4_CQE_STATUS_TCP))     &&
-		checksum == cpu_to_be16(0xffff);
+	return ((badfcs_enc & MLX4_CQE_STATUS_L4_CSUM) ||
+		((status & cpu_to_be16(MLX4_CQE_STATUS_IPOK)) &&
+		 (status & cpu_to_be16(MLX4_CQE_STATUS_TCP |
+				       MLX4_CQE_STATUS_UDP)) &&
+		 (checksum == cpu_to_be16(0xffff))));
 }
 
 static void use_tunnel_data(struct mlx4_ib_qp *qp, struct mlx4_ib_cq *cq, struct ib_wc *wc,
@@ -855,6 +850,7 @@ static int mlx4_ib_poll_one(struct mlx4_ib_cq *cq,
 		wc->wc_flags	  |= g_mlpath_rqpn & 0x80000000 ? IB_WC_GRH : 0;
 		wc->pkey_index     = be32_to_cpu(cqe->immed_rss_invalid) & 0x7f;
 		wc->wc_flags	  |= mlx4_ib_ipoib_csum_ok(cqe->status,
+					cqe->badfcs_enc,
 					cqe->checksum) ? IB_WC_IP_CSUM_OK : 0;
 		if (is_eth) {
 			wc->slid = 0;
diff --git a/include/linux/mlx4/cq.h b/include/linux/mlx4/cq.h
index 508e8cc5ee86..653d2a0aa44c 100644
--- a/include/linux/mlx4/cq.h
+++ b/include/linux/mlx4/cq.h
@@ -130,6 +130,11 @@ enum {
 	MLX4_CQE_STATUS_IPOK		= 1 << 12,
 };
 
+/* L4_CSUM is logically part of status, but has to checked against badfcs_enc */
+enum {
+	MLX4_CQE_STATUS_L4_CSUM		= 1 << 2,
+};
+
 enum {
 	MLX4_CQE_LLC                     = 1,
 	MLX4_CQE_SNAP                    = 1 << 1,
-- 
2.20.1

