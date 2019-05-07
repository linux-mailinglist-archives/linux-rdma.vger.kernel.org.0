Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FF164B9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEGNis (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:48 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40363 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726632AbfEGNis (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:40 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdF9021865;
        Tue, 7 May 2019 16:38:40 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 09/25] RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
Date:   Tue,  7 May 2019 16:38:23 +0300
Message-Id: <1557236319-9986-10-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Explicitly pass the sig_mr and the access flags for the mkey segment
configuration. This function will be used also in the new signature
API, so modify it in order to use it in both APIs. This is a preparation
commit before adding new signature API.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/hw/mlx5/qp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d430f455ed04..a44d5b32492c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4567,17 +4567,15 @@ static int set_sig_data_segment(const struct ib_sig_handover_wr *wr,
 }
 
 static void set_sig_mkey_segment(struct mlx5_mkey_seg *seg,
-				 const struct ib_sig_handover_wr *wr, u32 size,
-				 u32 length, u32 pdn)
+				 struct ib_mr *sig_mr, int access_flags,
+				 u32 size, u32 length, u32 pdn)
 {
-	struct ib_mr *sig_mr = wr->sig_mr;
 	u32 sig_key = sig_mr->rkey;
 	u8 sigerr = to_mmr(sig_mr)->sig->sigerr_count & 1;
 
 	memset(seg, 0, sizeof(*seg));
 
-	seg->flags = get_umr_flags(wr->access_flags) |
-				   MLX5_MKC_ACCESS_MODE_KLMS;
+	seg->flags = get_umr_flags(access_flags) | MLX5_MKC_ACCESS_MODE_KLMS;
 	seg->qpn_mkey7_0 = cpu_to_be32((sig_key & 0xff) | 0xffffff00);
 	seg->flags_pd = cpu_to_be32(MLX5_MKEY_REMOTE_INVAL | sigerr << 26 |
 				    MLX5_MKEY_BSF_EN | pdn);
@@ -4634,7 +4632,8 @@ static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
 	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
 
-	set_sig_mkey_segment(*seg, wr, xlt_size, region_len, pdn);
+	set_sig_mkey_segment(*seg, wr->sig_mr, wr->access_flags, xlt_size,
+			     region_len, pdn);
 	*seg += sizeof(struct mlx5_mkey_seg);
 	*size += sizeof(struct mlx5_mkey_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-- 
2.16.3

