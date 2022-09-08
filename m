Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A865B19AC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIHKJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiIHKJe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 06:09:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078126541
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 03:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD4D6CE1ECE
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 10:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC5C433C1;
        Thu,  8 Sep 2022 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662631762;
        bh=UeD5bnbqTWzbRzNQ7Fa7H8/J32dFktl3W/iwI97tp7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ph45leHzlfwsfnYx3jpgkLOGJ7AK2/J9JP1Pzziu50mjT+I5DKaBJkZnDrAU/WU4j
         JzEyBgnj6ohVg1Dhnwx6fEvx2VjzmQFQQMHoRzG72eFrPrARLo+KP3IHkKI/NoKbs9
         +cCvVGVx6AaHa8YhTILWuw65543sX9Cbf+5E1x+b/Nlhcde1B5TRpOwEHHFJej4WgE
         kgzJRkCJK7KjiaVXORJh5K3xff/E1pP6j+3iO+7hJw347pGZ1eWpy0JqWnYdry9XPe
         bZqEaNrosgKz7nEcsU5Ql6PkZGVonhUScvMSGqXJbEh0FqmRwApJCSHhdPpYjg1KD4
         7umQ29TX/1GTQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 4/4] RDMA/cm: Use DLID from inbound/outbound PathRecords as the datapath DLID
Date:   Thu,  8 Sep 2022 13:09:03 +0300
Message-Id: <b3f6cac685bce9dde37c610be82e2c19d9e51d9e.1662631201.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662631201.git.leonro@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

In inter-subnet cases, when inbound/outbound PRs are available,
outbound_PR.dlid is used as the requestor's datapath DLID and
inbound_PR.dlid is used as the responder's DLID. The inbound_PR.dlid
is passed to responder side with the "ConnectReq.Primary_Local_Port_LID"
field. With this solution the PERMISSIVE_LID is no longer used in
Primary Local LID field.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c  | 25 +++++++++++++++++++++++--
 drivers/infiniband/core/cma.c |  2 ++
 include/rdma/ib_cm.h          |  2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ade82752f9f7..1f9938a2c475 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -175,6 +175,7 @@ struct cm_device {
 struct cm_av {
 	struct cm_port *port;
 	struct rdma_ah_attr ah_attr;
+	u16 dlid_datapath;
 	u16 pkey_index;
 	u8 timeout;
 };
@@ -1304,6 +1305,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	struct sa_path_rec *pri_path = param->primary_path;
 	struct sa_path_rec *alt_path = param->alternate_path;
 	bool pri_ext = false;
+	__be16 lid;
 
 	if (pri_path->rec_type == SA_PATH_REC_TYPE_OPA)
 		pri_ext = opa_is_extended_lid(pri_path->opa.dlid,
@@ -1363,9 +1365,16 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 					      htons(ntohl(sa_path_get_dlid(
 						      pri_path)))));
 	} else {
+
+		if (param->primary_path_inbound) {
+			lid = param->primary_path_inbound->ib.dlid;
+			IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
+				be16_to_cpu(lid));
+		} else
+			IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
+				be16_to_cpu(IB_LID_PERMISSIVE));
+
 		/* Work-around until there's a way to obtain remote LID info */
-		IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
-			be16_to_cpu(IB_LID_PERMISSIVE));
 		IBA_SET(CM_REQ_PRIMARY_REMOTE_PORT_LID, req_msg,
 			be16_to_cpu(IB_LID_PERMISSIVE));
 	}
@@ -1520,6 +1529,10 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 
 	cm_move_av_from_path(&cm_id_priv->av, &av);
+	if (param->primary_path_outbound)
+		cm_id_priv->av.dlid_datapath =
+			be16_to_cpu(param->primary_path_outbound->ib.dlid);
+
 	if (param->alternate_path)
 		cm_move_av_from_path(&cm_id_priv->alt_av, &alt_av);
 
@@ -2154,6 +2167,10 @@ static int cm_req_handler(struct cm_work *work)
 				       NULL, 0);
 		goto rejected;
 	}
+	if (cm_id_priv->av.ah_attr.type == RDMA_AH_ATTR_TYPE_IB)
+		cm_id_priv->av.dlid_datapath =
+			IBA_GET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg);
+
 	if (cm_req_has_alt_path(req_msg)) {
 		ret = cm_init_av_by_path(&work->path[1], NULL,
 					 &cm_id_priv->alt_av);
@@ -4113,6 +4130,10 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		*qp_attr_mask = IB_QP_STATE | IB_QP_AV | IB_QP_PATH_MTU |
 				IB_QP_DEST_QPN | IB_QP_RQ_PSN;
 		qp_attr->ah_attr = cm_id_priv->av.ah_attr;
+		if ((qp_attr->ah_attr.type == RDMA_AH_ATTR_TYPE_IB) &&
+		    cm_id_priv->av.dlid_datapath &&
+		    (cm_id_priv->av.dlid_datapath != 0xffff))
+			qp_attr->ah_attr.ib.dlid = cm_id_priv->av.dlid_datapath;
 		qp_attr->path_mtu = cm_id_priv->path_mtu;
 		qp_attr->dest_qp_num = be32_to_cpu(cm_id_priv->remote_qpn);
 		qp_attr->rq_psn = be32_to_cpu(cm_id_priv->rq_psn);
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index a3efc462305d..7eacb23165fc 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4313,6 +4313,8 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	}
 
 	req.primary_path = &route->path_rec[0];
+	req.primary_path_inbound = route->path_rec_inbound;
+	req.primary_path_outbound = route->path_rec_outbound;
 	if (route->num_pri_alt_paths == 2)
 		req.alternate_path = &route->path_rec[1];
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 8dae5847020a..a2ac62b4a6cf 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -348,6 +348,8 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 
 struct ib_cm_req_param {
 	struct sa_path_rec	*primary_path;
+	struct sa_path_rec	*primary_path_inbound;
+	struct sa_path_rec	*primary_path_outbound;
 	struct sa_path_rec	*alternate_path;
 	const struct ib_gid_attr *ppath_sgid_attr;
 	__be64			service_id;
-- 
2.37.2

