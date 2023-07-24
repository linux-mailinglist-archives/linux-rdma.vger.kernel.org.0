Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DCA75E939
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGXBtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjGXBsJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 21:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BFF19AC;
        Sun, 23 Jul 2023 18:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2AA60F01;
        Mon, 24 Jul 2023 01:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0B4C433C7;
        Mon, 24 Jul 2023 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161629;
        bh=vFnoPmcemCx7cbUhqaGYMFZCKWha1HLUSZN0iFBdRoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fh6oxf2Ups+6kdrTs6d12aTX/mOzEZBwFLyn3xdUquyGIYPUyKZUbCLSm4NiYAlsE
         bVuNOKSf/g1sIltKXZ81W4NojZRnc2BMcxSt0KJlseaJ1+5HM1KpOvdZfwEHO9DDGS
         mZoEY7tZpa+N2hLJ2GDBf+i1M9LKQ6N3E0Ic2hV0KcXM9MkgTtn3MYE+hpUgPjyBDy
         qIW654PH29VNWkhcmW5KyDMjTlQE4V27RccYqLv3efp4Lyi0IiXhhsSBF6Zd4sFhWQ
         2PT9FMpjY4416DLbAgQkSHvcWFQSwOB8yIGm8q/1HRsfe9cgy76/v19NCGZ6kKldRP
         4XhXdT4l5zAMw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 47/58] RDMA/bnxt_re: consider timeout of destroy ah as success.
Date:   Sun, 23 Jul 2023 21:13:15 -0400
Message-Id: <20230724011338.2298062-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kashyap Desai <kashyap.desai@broadcom.com>

[ Upstream commit bb8c93618fb0b8567d309f1aebc6df0cd31da1a2 ]

If destroy_ah is timed out, it is likely to be destroyed by firmware
but it is taking longer time due to temporary slowness
in processing the rcfw command. In worst case, there might be
AH resource leak in firmware.

Sending timeout return value can dump warning message from ib_core
which can be avoided if we map timeout of destroy_ah as success.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-14-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 16 ++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  8 +++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  4 ++--
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2c95e6f3d47ac..eef3ef3fabb42 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -179,6 +179,8 @@ struct bnxt_re_dev {
 #define BNXT_RE_ROCEV2_IPV4_PACKET	2
 #define BNXT_RE_ROCEV2_IPV6_PACKET	3
 
+#define BNXT_RE_CHECK_RC(x) ((x) && ((x) != -ETIMEDOUT))
+
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
 	if (rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 952811c40c54b..6a086c42f85f6 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -614,12 +614,20 @@ int bnxt_re_destroy_ah(struct ib_ah *ib_ah, u32 flags)
 {
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
 	struct bnxt_re_dev *rdev = ah->rdev;
+	bool block = true;
+	int rc = 0;
 
-	bnxt_qplib_destroy_ah(&rdev->qplib_res, &ah->qplib_ah,
-			      !(flags & RDMA_DESTROY_AH_SLEEPABLE));
+	block = !(flags & RDMA_DESTROY_AH_SLEEPABLE);
+	rc = bnxt_qplib_destroy_ah(&rdev->qplib_res, &ah->qplib_ah, block);
+	if (BNXT_RE_CHECK_RC(rc)) {
+		if (rc == -ETIMEDOUT)
+			rc = 0;
+		else
+			goto fail;
+	}
 	atomic_dec(&rdev->ah_count);
-
-	return 0;
+fail:
+	return rc;
 }
 
 static u8 bnxt_re_stack_to_dev_nw_type(enum rdma_network_type ntype)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index b967a17a44beb..10919532bca29 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -468,13 +468,14 @@ int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 	return 0;
 }
 
-void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
-			   bool block)
+int bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
+			  bool block)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_destroy_ah_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_destroy_ah req = {};
+	int rc;
 
 	/* Clean up the AH table in the device */
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -485,7 +486,8 @@ void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 				sizeof(resp), block);
-	bnxt_qplib_rcfw_send_message(rcfw, &msg);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
+	return rc;
 }
 
 /* MRW */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 5de874659cdfa..4061616048e85 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -327,8 +327,8 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 			 bool block);
-void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
-			   bool block);
+int bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
+			  bool block);
 int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_mrw *mrw);
 int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
-- 
2.39.2

