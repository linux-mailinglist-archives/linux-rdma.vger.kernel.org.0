Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5115F2805D8
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbgJARtE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbgJARtD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:03 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3141C0613E2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o8so6326193otl.4
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T3Wkw5kn/NaubmiIUIn5KnbZxsuaZTT2cqCWA5dwL8M=;
        b=Ca7mI3MB0TpFBF1lmA1HjQ08mifKg4u6UKWFy9NTXThIeLKrp9OTS/ppRqK/7hK0ME
         vwc22FYLxRvE4/eMa7+SY1b1i7cAz9f062ByepTC7TOXkaHCmchDmANVdU7Wt8+oSEsu
         Wghcni1rLklvqVySxr+0AyqkSVypMqr+GI3kXXosV1Yq562ONBC41cfIt/PjIdcUWdGs
         +v0+Ih5Qmj0UDjtKwWH5RoyDt1m0kZi9mvMhQMxTcfcjI5G7ijHNL6iqFtNeVSphyORe
         TDoi3mL6S206HOyeXi0V9iB+mgjZijpG2kCqMYJbLCDfLSmwwwt14gYmGWeykKIDNDes
         JsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3Wkw5kn/NaubmiIUIn5KnbZxsuaZTT2cqCWA5dwL8M=;
        b=Yd5WWK4J6I8+Rql9Ncfh+ISdFvS87mV5UhXUaUx/9+5WDj8kYJOjV3FSYJH38X1plq
         TMsxF0UEHTsxWxZQL13/wPU2gCb77I6AyDy7OR0qDiBWMmROMO312CH6VM6i/sgxQZ+A
         C7SL+SPZYZinONAhswzfYWWc+2sPWg5KNh04O3m6h8tdofeYR+sjmCJTvAPgHpb01NQK
         +MD3vHfqC3W7eflLi/ZsA2jzS1DUpGVG6V4dyGLK3S2plPHJHhos061uCJwO9hZ5a6yB
         NyvOvOAJD+KagJ+JLouLJrZFAEB00P66EYHwnrlKTR0xcO4LyxIEso/YI59i4ftAgKze
         3eVw==
X-Gm-Message-State: AOAM5338xsjoX1QleCOba8Q9kIwKWt6R/ySoGhPVJtVrQLmT+K3tmlbe
        vEcZB66DSAFOHy6/A+Txhtk=
X-Google-Smtp-Source: ABdhPJzepuxuyhjeZc/4XqgNfLFOSeDB2eCS3GtLQVf4hnpqw/aJXzFjCpe/UeZNr/MrluTk5jMIMQ==
X-Received: by 2002:a05:6830:1f09:: with SMTP id u9mr5270818otg.175.1601574542997;
        Thu, 01 Oct 2020 10:49:02 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id o205sm1196061oig.8.2020.10.01.10.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 10/19] rdma_rxe: Add support for ibv_query_device_ex
Date:   Thu,  1 Oct 2020 12:48:38 -0500
Message-Id: <20201001174847.4268-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to initialize new struct members in
ib_device_attr as place holders.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 101 ++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c |   7 +-
 2 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..ecc61f960c58 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -40,40 +40,77 @@ void rxe_dealloc(struct ib_device *ib_dev)
 /* initialize rxe device parameters */
 static void rxe_init_device_param(struct rxe_dev *rxe)
 {
-	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
-
-	rxe->attr.vendor_id			= RXE_VENDOR_ID;
-	rxe->attr.max_mr_size			= RXE_MAX_MR_SIZE;
-	rxe->attr.page_size_cap			= RXE_PAGE_SIZE_CAP;
-	rxe->attr.max_qp			= RXE_MAX_QP;
-	rxe->attr.max_qp_wr			= RXE_MAX_QP_WR;
-	rxe->attr.device_cap_flags		= RXE_DEVICE_CAP_FLAGS;
-	rxe->attr.max_send_sge			= RXE_MAX_SGE;
-	rxe->attr.max_recv_sge			= RXE_MAX_SGE;
-	rxe->attr.max_sge_rd			= RXE_MAX_SGE_RD;
-	rxe->attr.max_cq			= RXE_MAX_CQ;
-	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
-	rxe->attr.max_mr			= RXE_MAX_MR;
-	rxe->attr.max_mw			= RXE_MAX_MW;
-	rxe->attr.max_pd			= RXE_MAX_PD;
-	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
-	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
-	rxe->attr.max_qp_init_rd_atom		= RXE_MAX_QP_INIT_RD_ATOM;
-	rxe->attr.atomic_cap			= IB_ATOMIC_HCA;
-	rxe->attr.max_mcast_grp			= RXE_MAX_MCAST_GRP;
-	rxe->attr.max_mcast_qp_attach		= RXE_MAX_MCAST_QP_ATTACH;
-	rxe->attr.max_total_mcast_qp_attach	= RXE_MAX_TOT_MCAST_QP_ATTACH;
-	rxe->attr.max_ah			= RXE_MAX_AH;
-	rxe->attr.max_srq			= RXE_MAX_SRQ;
-	rxe->attr.max_srq_wr			= RXE_MAX_SRQ_WR;
-	rxe->attr.max_srq_sge			= RXE_MAX_SRQ_SGE;
-	rxe->attr.max_fast_reg_page_list_len	= RXE_MAX_FMR_PAGE_LIST_LEN;
-	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
-	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
-	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
-			rxe->ndev->dev_addr);
+	struct ib_device_attr *a = &rxe->attr;
 
+	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
+
+	a->atomic_cap				= IB_ATOMIC_HCA;
+	a->cq_caps.max_cq_moderation_count	= 0;
+	a->cq_caps.max_cq_moderation_period	= 0;
+	a->device_cap_flags			= RXE_DEVICE_CAP_FLAGS;
+	a->fw_ver				= 0;
+	a->hca_core_clock			= 0;
+	a->hw_ver				= 0;
+	a->local_ca_ack_delay			= RXE_LOCAL_CA_ACK_DELAY;
+	a->masked_atomic_cap			= 0;
+	a->max_ah				= RXE_MAX_AH;
+	a->max_cqe				= (1 << RXE_MAX_LOG_CQE) - 1;
+	a->max_cq				= RXE_MAX_CQ;
+	a->max_dm_size				= 0;
+	a->max_ee_init_rd_atom			= 0;
+	a->max_ee				= 0;
+	a->max_ee_rd_atom			= 0;
+	a->max_fast_reg_page_list_len		= RXE_MAX_FMR_PAGE_LIST_LEN;
+	a->max_mcast_grp			= RXE_MAX_MCAST_GRP;
+	a->max_mcast_qp_attach			= RXE_MAX_MCAST_QP_ATTACH;
+	a->max_mr				= RXE_MAX_MR;
+	a->max_mr_size				= RXE_MAX_MR_SIZE;
+	a->max_mw				= RXE_MAX_MW;
+	a->max_pd				= RXE_MAX_PD;
+	a->max_pi_fast_reg_page_list_len	= 0;
+	a->max_pkeys				= RXE_MAX_PKEYS;
+	a->max_qp_init_rd_atom			= RXE_MAX_QP_INIT_RD_ATOM;
+	a->max_qp_rd_atom			= RXE_MAX_QP_RD_ATOM;
+	a->max_qp				= RXE_MAX_QP;
+	a->max_qp_wr				= RXE_MAX_QP_WR;
+	a->max_raw_ethy_qp			= 0;
+	a->max_raw_ipv6_qp			= 0;
+	a->max_rdd				= 0;
+	a->max_recv_sge				= RXE_MAX_SGE;
+	a->max_res_rd_atom			= RXE_MAX_RES_RD_ATOM;
+	a->max_send_sge				= RXE_MAX_SGE;
+	a->max_sge_rd				= RXE_MAX_SGE_RD;
+	a->max_sgl_rd				= 0;
+	a->max_srq				= RXE_MAX_SRQ;
+	a->max_srq_sge				= RXE_MAX_SRQ_SGE;
+	a->max_srq_wr				= RXE_MAX_SRQ_WR;
+	a->max_total_mcast_qp_attach		= RXE_MAX_TOT_MCAST_QP_ATTACH;
+	a->max_wq_type_rq			= 0;
+	a->odp_caps.general_caps		= 0;
+	a->odp_caps.per_transport_caps.rc_odp_caps = 0;
+	a->odp_caps.per_transport_caps.uc_odp_caps = 0;
+	a->odp_caps.per_transport_caps.ud_odp_caps = 0;
+	a->odp_caps.per_transport_caps.xrc_odp_caps = 0;
+	a->page_size_cap			= RXE_PAGE_SIZE_CAP;
+	a->raw_packet_caps			= 0;
+	a->rss_caps.supported_qpts		= 0;
+	a->rss_caps.max_rwq_indirection_tables	= 0;
+	a->rss_caps.max_rwq_indirection_table_size = 0;
+	a->sig_guard_cap			= 0;
+	a->sig_prot_cap				= 0;
+	a->sys_image_guid			= 0;
+	a->timestamp_mask			= 0;
+	a->tm_caps.max_rndv_hdr_size		= 0;
+	a->tm_caps.max_num_tags			= 0;
+	a->tm_caps.flags			= 0;
+	a->tm_caps.max_ops			= 0;
+	a->tm_caps.max_sge			= 0;
+	a->vendor_id				= RXE_VENDOR_ID;
+	a->vendor_part_id			= 0;
+
+	addrconf_addr_eui48((unsigned char *)&a->sys_image_guid,
+			    rxe->ndev->dev_addr);
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 807c9a3b22ea..2695b286cd8e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1150,7 +1150,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dma_coerce_mask_and_coherent(&dev->dev,
 				     dma_get_required_mask(&dev->dev));
 
-	dev->uverbs_cmd_mask = BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
+	dev->uverbs_cmd_mask =
+	      BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
 	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT)
@@ -1185,6 +1186,10 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	    | BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_MW)
 	    ;
 
+	dev->uverbs_ex_cmd_mask =
+	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
+	    ;
+
 	ib_set_device_ops(dev, &rxe_dev_ops);
 	err = ib_device_set_netdev(&rxe->ib_dev, rxe->ndev, 1);
 	if (err)
-- 
2.25.1

