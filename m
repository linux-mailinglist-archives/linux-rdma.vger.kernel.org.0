Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C44D8410
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiCNMWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbiCNMVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 08:21:20 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748FBCE2;
        Mon, 14 Mar 2022 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RuD1BVzbEda8F+Un6qYX3KLD/xKWdDV4fX2GPJgJb/0=;
  b=CrHqblnl9/dRx0dJriP/xP5xsyJVMAQsVA11bAQolVqIcp/kUhJ1TGdj
   RLWsMt/Pa1FGb1c5OpPIkr5SLuGgYw/Ch+9K4goYpIAwtvyAurkPD7P9X
   qE7by25tjiJprAHm08PzjFj7a5naR7akiBjqlg2SfKlTbYIjDDYXeqx3j
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997356"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     kernel-janitors@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/30] RDMA/hw/qib/qib_iba7220: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:46 +0100
Message-Id: <20220314115354.144023-23-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/infiniband/hw/qib/qib_iba7220.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 80a8dd6c7814..37b628a162e0 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -634,7 +634,7 @@ static const struct qib_hwerror_msgs qib_7220_hwerror_msgs[] = {
 	QLOGIC_IB_HWE_MSG(QLOGIC_IB_HWE_PCIECPLTIMEOUT,
 			  "PCIe completion timeout"),
 	/*
-	 * In practice, it's unlikely wthat we'll see PCIe PLL, or bus
+	 * In practice, it's unlikely that we'll see PCIe PLL, or bus
 	 * parity or memory parity error failures, because most likely we
 	 * won't be able to talk to the core of the chip.  Nonetheless, we
 	 * might see them, if they are in parts of the PCIe core that aren't
@@ -2988,7 +2988,7 @@ static u64 qib_portcntr_7220(struct qib_pportdata *ppd, u32 reg)
  * the utility.  Names need to be 12 chars or less (w/o newline), for proper
  * display by utility.
  * Non-error counters are first.
- * Start of "error" conters is indicated by a leading "E " on the first
+ * Start of "error" counters is indicated by a leading "E " on the first
  * "error" counter, and doesn't count in label length.
  * The EgrOvfl list needs to be last so we truncate them at the configured
  * context count for the device.

