Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40E85B19AB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIHKJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiIHKJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 06:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE676341
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 03:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD0361C2C
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 10:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9502DC433D7;
        Thu,  8 Sep 2022 10:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662631766;
        bh=nISOS98JMW+00iHH/Ze7hXS4D0jwb9famwNqqp/Jqr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lw4kCAbLbLEuHwfieVhAMDEZTsLZtTyMT1b85QFJYhv+qWTy08JLgae4jK9h2XmwG
         ejbv3xOvL7d7t4qMgSV8HHKMon5Mi+1+kYp1Tb3uWtiN2JA1IbuZmNuS0KyLW1zclt
         qYCeMOa5zkTHqfCo9a8pnYAPE/wlFAPE/5qJwIFAPcjAXECcKQWdYXuhlMKg6epIf4
         /7AzUAT0p/938+TKDoGX86ctsO+g73dKsHcQjqsfgRwWmvtBbfl/Qw9Oo/e9InkDem
         CGIWmEX7/zhZ/s8dPvsGCXEP28f/1j6GzUUOUxizzoc6FawBGoHYxXXpCIO13/F+kK
         2r0lRXD4G/3ng==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 3/4] RDMA/cm: Use SLID in the work completion as the DLID in responder side
Date:   Thu,  8 Sep 2022 13:09:02 +0300
Message-Id: <cd17c240231e059d2fc07c17dfe555d548b917eb.1662631201.git.leonro@nvidia.com>
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

The responder should always use WC's SLID as the dlid, to follow the
IB SPEC section "13.5.4.2 COMMON RESPONSE ACTIONS":
A responder always takes the following actions in constructing a
response packet:
- The SLID of the received packet is used as the DLID in the response
  packet.

Fixes: ac3a949fb2ff ("IB/CM: Set appropriate slid and dlid when handling CM request")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d7410ee2ade7..ade82752f9f7 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1614,14 +1614,13 @@ static void cm_path_set_rec_type(struct ib_device *ib_device, u32 port_num,
 
 static void cm_format_path_lid_from_req(struct cm_req_msg *req_msg,
 					struct sa_path_rec *primary_path,
-					struct sa_path_rec *alt_path)
+					struct sa_path_rec *alt_path,
+					struct ib_wc *wc)
 {
 	u32 lid;
 
 	if (primary_path->rec_type != SA_PATH_REC_TYPE_OPA) {
-		sa_path_set_dlid(primary_path,
-				 IBA_GET(CM_REQ_PRIMARY_LOCAL_PORT_LID,
-					 req_msg));
+		sa_path_set_dlid(primary_path, wc->slid);
 		sa_path_set_slid(primary_path,
 				 IBA_GET(CM_REQ_PRIMARY_REMOTE_PORT_LID,
 					 req_msg));
@@ -1658,7 +1657,8 @@ static void cm_format_path_lid_from_req(struct cm_req_msg *req_msg,
 
 static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 				     struct sa_path_rec *primary_path,
-				     struct sa_path_rec *alt_path)
+				     struct sa_path_rec *alt_path,
+				     struct ib_wc *wc)
 {
 	primary_path->dgid =
 		*IBA_GET_MEM_PTR(CM_REQ_PRIMARY_LOCAL_PORT_GID, req_msg);
@@ -1716,7 +1716,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		if (sa_path_is_roce(alt_path))
 			alt_path->roce.route_resolved = false;
 	}
-	cm_format_path_lid_from_req(req_msg, primary_path, alt_path);
+	cm_format_path_lid_from_req(req_msg, primary_path, alt_path, wc);
 }
 
 static u16 cm_get_bth_pkey(struct cm_work *work)
@@ -2129,7 +2129,7 @@ static int cm_req_handler(struct cm_work *work)
 	if (cm_req_has_alt_path(req_msg))
 		work->path[1].rec_type = work->path[0].rec_type;
 	cm_format_paths_from_req(req_msg, &work->path[0],
-				 &work->path[1]);
+				 &work->path[1], work->mad_recv_wc->wc);
 	if (cm_id_priv->av.ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE)
 		sa_path_set_dmac(&work->path[0],
 				 cm_id_priv->av.ah_attr.roce.dmac);
-- 
2.37.2

