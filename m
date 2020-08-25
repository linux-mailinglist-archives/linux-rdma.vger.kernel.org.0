Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD2251CAF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHYPwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYPv7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 11:51:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128AC061574;
        Tue, 25 Aug 2020 08:51:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y8so1412528wma.0;
        Tue, 25 Aug 2020 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2WWaSZZuXloXF3hXA39Q3ZCHpRit+wqprTZANU5AeMQ=;
        b=rw/DxH6GxN345y2h6nelqrvVSJ+WYtUojlJ1ozoP6zQI7IOifGBqQkEy+dFuQPezPW
         /jGm5n2pHyYB3wWTxGMSzkBGy7/LHnlOcL+6NNfFL/ZvkdoaAtUQgyrnY04r7jzXp87/
         3g5GAsYiHOlRTZxhIE1fApeF9j334HZM++zkr2NMItqSo7CBW8r5EhfERPFzW7wOFbdN
         QyvCwTntdoKisqeKhwXP+VT6BgmqDZQ7GMizaQad0yuP81CL86beJv2CtmZmMkC5KHgi
         JYpl1hTjw3tTOCKmCoEIsUBcy5M5TqBBTPAIwmZlMKEbOG5lwKcKIDockt8QMICJ9Zfw
         4O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2WWaSZZuXloXF3hXA39Q3ZCHpRit+wqprTZANU5AeMQ=;
        b=pJfTbk54qWMuwYwUAzIjzhpkHOLunNqGBxsuGPfwzj3xhfNwl2uG5R/bqcPAhHBoZW
         fiZ32pg2ldmLNX6FiEFdQ/XqCuy+FhtLCQUzuOk07G+oGjMjJqcmvXpFfqnecGFx2VHT
         aS4xomTHbnBGoEhFdYHpgiw4CDG9m0mGhfRfBZdrIgNY6TwRZLMVJ70b31Kqx0Bn71mU
         NGcBXLjhcZgoKjjh78xlWB2YbmteQvKieOFGtgQiMAXJKgHNAxHkQdVf82Vc1mMJ4zdq
         rFU5exjJFiGy7e/V3FzVg4UBquAkFuNVd2Zg0EYuv4vVnoEawh7RDMjikWEnKR0USA4l
         Cwwg==
X-Gm-Message-State: AOAM533fJS5DX+NSs4pqRALHmrCHXuI+IFiFJ9zuVR92/GlF9j9mStYN
        7aiakNaobuq5nEuq5hR2wjM=
X-Google-Smtp-Source: ABdhPJxbzjMYznH2bknIDMu+vaMPZmI1DImIMLu0bptCORhJT3lHHQlr6j84R6N4o63i7k8DOxxCkA==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr2819350wmi.161.1598370717236;
        Tue, 25 Aug 2020 08:51:57 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id 33sm32511492wri.16.2020.08.25.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:51:56 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roland Dreier <roland@purestorage.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/qib: remove superfluous fallthrough statements
Date:   Tue, 25 Aug 2020 16:51:42 +0100
Message-Id: <20200825155142.349651-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
were later converted to fallthrough statements by commit df561f6688fe
("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
warning about unreachable code.

Remove the fallthrough statements and replace the mass of gotos with
simple return statements to make the code terser and less bug-prone.

Addresses-Coverity: ("Unreachable code")
Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/infiniband/hw/qib/qib_mad.c | 52 ++++++++---------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index e7789e724f56..f83e331977f8 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2293,76 +2293,50 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			struct ib_mad *out_mad)
 {
 	struct ib_cc_mad *ccp = (struct ib_cc_mad *)out_mad;
-	int ret;
-
 	*out_mad = *in_mad;
 
 	if (ccp->class_version != 2) {
 		ccp->status |= IB_SMP_UNSUP_VERSION;
-		ret = reply((struct ib_smp *)ccp);
-		goto bail;
+		return reply((struct ib_smp *)ccp);
 	}
 
 	switch (ccp->method) {
 	case IB_MGMT_METHOD_GET:
 		switch (ccp->attr_id) {
 		case IB_CC_ATTR_CLASSPORTINFO:
-			ret = cc_get_classportinfo(ccp, ibdev);
-			goto bail;
-
+			return cc_get_classportinfo(ccp, ibdev);
 		case IB_CC_ATTR_CONGESTION_INFO:
-			ret = cc_get_congestion_info(ccp, ibdev, port);
-			goto bail;
-
+			return cc_get_congestion_info(ccp, ibdev, port);
 		case IB_CC_ATTR_CA_CONGESTION_SETTING:
-			ret = cc_get_congestion_setting(ccp, ibdev, port);
-			goto bail;
-
+			return cc_get_congestion_setting(ccp, ibdev, port);
 		case IB_CC_ATTR_CONGESTION_CONTROL_TABLE:
-			ret = cc_get_congestion_control_table(ccp, ibdev, port);
-			goto bail;
-
-			fallthrough;
+			return cc_get_congestion_control_table(ccp, ibdev, port);
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
-			ret = reply((struct ib_smp *) ccp);
-			goto bail;
+			return reply((struct ib_smp *) ccp);
 		}
-
 	case IB_MGMT_METHOD_SET:
 		switch (ccp->attr_id) {
 		case IB_CC_ATTR_CA_CONGESTION_SETTING:
-			ret = cc_set_congestion_setting(ccp, ibdev, port);
-			goto bail;
-
+			return cc_set_congestion_setting(ccp, ibdev, port);
 		case IB_CC_ATTR_CONGESTION_CONTROL_TABLE:
-			ret = cc_set_congestion_control_table(ccp, ibdev, port);
-			goto bail;
-
-			fallthrough;
+			return cc_set_congestion_control_table(ccp, ibdev, port);
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
-			ret = reply((struct ib_smp *) ccp);
-			goto bail;
+			return reply((struct ib_smp *) ccp);
 		}
-
 	case IB_MGMT_METHOD_GET_RESP:
 		/*
 		 * The ib_mad module will call us to process responses
 		 * before checking for other consumers.
 		 * Just tell the caller to process it normally.
 		 */
-		ret = IB_MAD_RESULT_SUCCESS;
-		goto bail;
-
-	case IB_MGMT_METHOD_TRAP:
-	default:
-		ccp->status |= IB_SMP_UNSUP_METHOD;
-		ret = reply((struct ib_smp *) ccp);
+		return IB_MAD_RESULT_SUCCESS;
 	}
 
-bail:
-	return ret;
+	/* method is unsupported */
+	ccp->status |= IB_SMP_UNSUP_METHOD;
+	return reply((struct ib_smp *) ccp);
 }
 
 /**
-- 
2.28.0

