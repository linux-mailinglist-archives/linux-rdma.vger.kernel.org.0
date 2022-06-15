Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E754CCDB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbiFOP26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355265AbiFOP2h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:37 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F814F1C7
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=YhpO3TS14LMHOHwZO8jxbCVr+5Hbr5NLcdR2reS5xI0=; b=sVu08+VQYulrzVz/0J6kc/tidV
        8jMQqywzuNXFrV5rx9HPyTQA7MY1+9EDTs1uv+IZav/n/8dnmf38Th53pb7nbp/Lck6IY/DRCKKZR
        0UQb6cRs/fRTc9ZISoqMLc2LUrCCYcvF5puq4DHrcsH3ibHVuxD7XCCX7c73yyKcHZIKrnFpjD4Z2
        pNvIBgFxOxSG+RLZ82qqkTJhAkmR/rRxl/DBjmn0vCOtFAwpTfYzlIH09FjzN72393myJk9eed+Ic
        DfzjJlHso51Y+TFoTtPBA8DnwaoES7uIdBcUY04i/P3YTC31CF7pIaqup5GqiI/o0Sz+pzWF2Jyjl
        M4JMqCQkJGwfQtxo6acadq1+3dEOatC2+jxBCGGVLig671gEmkQA/XlVByH8ANFojGfzb8Juvzxax
        Z9SitMB0FJ+fKoc3ULS9DvCLbeLSTqew04QxLVugbOltZpS1t9YDP5fbAgaGRzLNT5dGLLyNghgwq
        VW/04eW2nuNL4TSTuJ3R0wdI;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uvn-005ru0-01; Wed, 15 Jun 2022 15:27:43 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 06/14] rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_MPATIMEOUT
Date:   Wed, 15 Jun 2022 17:26:44 +0200
Message-Id: <6854531a411a17e34efb2fe012f45fabd27c7d14.1655305567.git.metze@samba.org>
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

It's easier to have generic logic in just one place.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 31 ++++++++----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 3160f3fc4ca8..56c484f85160 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1126,31 +1126,16 @@ static void siw_cm_work_handler(struct work_struct *w)
 		break;
 
 	case SIW_CM_WORK_MPATIMEOUT:
+		/*
+		 * MPA request timed out:
+		 * Hide any partially received private data and signal
+		 * timeout
+		 */
 		cep->mpa_timer = NULL;
+		cep->mpa.hdr.params.pd_len = 0;
+		__siw_cep_terminate_upcall(cep, -ETIMEDOUT);
 
-		if (cep->state == SIW_EPSTATE_AWAIT_MPAREP) {
-			/*
-			 * MPA request timed out:
-			 * Hide any partially received private data and signal
-			 * timeout
-			 */
-			cep->mpa.hdr.params.pd_len = 0;
-
-			if (cep->cm_id)
-				siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
-					      -ETIMEDOUT);
-			release_cep = 1;
-
-		} else if (cep->state == SIW_EPSTATE_AWAIT_MPAREQ) {
-			/*
-			 * No MPA request received after peer TCP stream setup.
-			 */
-			if (cep->listen_cep) {
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
-			}
-			release_cep = 1;
-		}
+		release_cep = 1;
 		break;
 
 	default:
-- 
2.34.1

