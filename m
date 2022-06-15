Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE854CCE2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiFOP3e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356340AbiFOP2u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:50 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721004738E
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=CEgEmMjNl8BESZVo+q7Rxw8wDkgp80BAxjvFIYVn9yk=; b=sR1ZWktq+O1YG8Hla5LxeVV7F+
        ucO//3VHU8HkP8U/e4yCExnT+rAzDU5uCGlBFw8Jl/G+hk1YKgG8cOPyD9DiFzRpsGpGCHIaTl62q
        Bg7PN0sU+ZYIiWja5atOymBJZZfyLVuzy4s4Zhw/1SZe3cTE0Yz0UMrHoPpUzkM5JbQVKDbrmyx6Q
        nVMfuePLFiJ3rMBiCfzQHmns5ibAq7TsQNz/BFxK7YhSGdDdkUyZMvhf3mMJBGBj5WDgkcdVPgzfS
        16F3ETj12Q6NkFK40EwTrnHVxH7pDk9o2vMC9501R9l0rOSLxnfrR5XmMSCvS0RxlSfaN/fFc+L/x
        9l5sLqm4E6Id8nxUru5jT6LR6dsizFPE1u7MareL54kzVEmHOJTQTOQtz6HHnwI8yMceA5MZpGxZj
        e29K+KO6lLU5g1kpApJQaMYrnqiQBW4IJdcaYsrVyHE9qFiYKZBzcyMI9LEx8fznBl3+RP0E93Cdp
        R2OfTip1v8LwILzIcRbqrIZ0;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UwT-005rw5-03; Wed, 15 Jun 2022 15:28:25 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 12/14] rdma/siw: start mpa timer before calling siw_send_mpareqrep()
Date:   Wed, 15 Jun 2022 17:26:50 +0200
Message-Id: <c5e7cb3b1a47cf7862988ece3bac78c68ccfab48.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mpa timer will also span the non-blocking connect
in the final patch.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 66d90fc77cef..279f5acf84d1 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1489,6 +1489,11 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		cep->mpa.hdr.params.pd_len = pd_len;
 	}
 
+	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
+	if (rv != 0) {
+		goto error;
+	}
+
 	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
 	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
@@ -1506,11 +1511,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error;
 	}
 
-	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-	if (rv != 0) {
-		goto error;
-	}
-
 	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
 	siw_cep_set_free(cep);
 	return 0;
@@ -1519,6 +1519,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg(id->device, "failed: %d\n", rv);
 
 	if (cep) {
+		siw_cancel_mpatimer(cep);
+
 		siw_socket_disassoc(s);
 		sock_release(s);
 		cep->sock = NULL;
-- 
2.34.1

