Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D554CCEA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbiFOP3i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355712AbiFOP2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:41 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78D4338E
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=K1YBsWTlv3dUju28IUgerHcp1VUDHyN7zkNFBdM0XsI=; b=fsyaotPoeJqLxjPLN6gyv9UhVp
        z0mFvHDoQkVM1Amu77pVTtk9Sq7RtG0FNdUfEyR9gwM2HVKAdLrFYt05g5+Bm1L6OrHZmxA/46I72
        5whVAJdbC03ofFKV7D+tbp62YxmLNLqwbIbrLdMzB1dLgAwLMbqZmNNiL/l4hNAxKLYTZnH1bQ+9c
        yFexL7mc/AQhMZnRq2+kDXEQ1Zf7DHfbALxSWhPIbZr3P6ZcPPzFIRUBeW2vPFhahp2HtM7GJHU0z
        DqTZphSdAzKx6mN+eByDK3dWj7D7ZbSgEOldHGkW5Sx3HD4cNXL1DxDrxInI7yb5Q2IR/mm+cTsUv
        hLSX1zqD17og4ZW9IoDvtmz2kJYra0QOUGvArQJ7LyjNFZn/5iKRZrPw9LRBAX4+Nxgj2flQ8lP7d
        0dNokVcaHZmg9oVrLhQNFG383rmrffeVK0M7QwGoAixJMIn1SxpBNLZeyOWK2LHpu3OkdYPxuaAbP
        fFTFRCfzsI0WqmZxz+mBbMmQ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uvu-005ruG-FQ; Wed, 15 Jun 2022 15:27:50 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 07/14] rdma/siw: handle SIW_EPSTATE_CONNECTING in __siw_cep_terminate_upcall()
Date:   Wed, 15 Jun 2022 17:26:45 +0200
Message-Id: <4afcaaa2ba7bfe248f12030bd9168c70bbeb0fb2.1655305567.git.metze@samba.org>
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

The final patch will implement a non-blocking connect,
which means SIW_CM_WORK_MPATIMEOUT can also happen
during SIW_EPSTATE_CONNECTING.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 56c484f85160..80e1d5b274e7 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -125,6 +125,14 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 	}
 
 	switch (cep->state) {
+	case SIW_EPSTATE_CONNECTING:
+		/*
+		 * The TCP connect got rejected or timed out.
+		 */
+		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
+			      reply_status);
+		break;
+
 	case SIW_EPSTATE_AWAIT_MPAREP:
 		/*
 		 * MPA reply not received, but connection drop,
@@ -164,7 +172,6 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 
 	case SIW_EPSTATE_IDLE:
 	case SIW_EPSTATE_LISTENING:
-	case SIW_EPSTATE_CONNECTING:
 	case SIW_EPSTATE_CLOSED:
 	default:
 		/*
-- 
2.34.1

