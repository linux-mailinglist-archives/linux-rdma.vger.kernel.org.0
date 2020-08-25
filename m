Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC021251DE8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHYROG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHYRNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 13:13:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE78C061755;
        Tue, 25 Aug 2020 10:13:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s20so3286391wmj.1;
        Tue, 25 Aug 2020 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Riny6p9pEfEbUEaJydyX6asNeCvKfEsCe02s6uvHVuY=;
        b=L7n2r6PMY7XKRAv85llMXUyXYNZfRdoE5QPoVPrFzUqAEGtoKH67JxkL0n+V405EXC
         igS73bqxFSuqkn59kWh6WpoRPEB3dxTXKPbQtVqGbJ0CX2VngKjGuKVL5a74OWf+svH4
         21CvYLZAWY8c9caYLkrP+WjkRO8qUqBix98uaKRDvaFeQSTtLq/5yQ7CwsWq+gbm5K7T
         aWeSp1NKgncnA/0GYph66p8FXu6uSHQDKXBCmqF9NoHmHAb3lY89jm+1hZRnepPRhol4
         G59dUtgzCHYZccTOu93aG5h2zqkU9eto5ZB26jYsKcqVLb8hWY/bq5D3kaZxoCA1EnIG
         xn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Riny6p9pEfEbUEaJydyX6asNeCvKfEsCe02s6uvHVuY=;
        b=OoTZpiuGR8TPQnS8LAX1ra9Lvg1yhoVGn382kkl5+bU2lyseOB6/iXGipqfTra7BBS
         pfSBifQ2I5KiRk7U3sAzS/PRInn98l6krnJa0cvwkNP/pXqBiJD8F5WWZLjmSh4MM36w
         H9JioIbuXC6WY0OzlCEfH25f8F76fS/53Dk+VOzut3Bk16Q6EcCGN1xa7Ev+BtA1zpjl
         0hEKdH3f6oiy+l20O1KR/qISTDxsKnh5X9dM+qGNUpmhYoUJxSvnzuU4y4GxwSo+lNfA
         wDvoT+yvrNkx/LQRGGx9dmdVRT5ElA33X/YYtG0aV7fB+QyTTgtjYqwqEiWxT0qsPvzw
         AWQg==
X-Gm-Message-State: AOAM532iDjvM+HEO4D4AHbB6CADD2nVLtp21vUirreYBi1VwWbL/1S/x
        LqXFjo1vfQ7pvfC0MM+h2og=
X-Google-Smtp-Source: ABdhPJyCwwprTPUNi+5DZtz2fU/Y/szoI5vPcNV6HnTgpbPBndJXrU1MQ5kSAbjTaYbFG3uLUJgB7g==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr2776863wmc.149.1598375630849;
        Tue, 25 Aug 2020 10:13:50 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v11sm33135194wrr.10.2020.08.25.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:13:50 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     alex.dewar90@gmail.com
Cc:     dennis.dalessandro@intel.com, dledford@redhat.com,
        gustavo@embeddedor.com, jgg@ziepe.ca, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mike.marciniszyn@intel.com, roland@purestorage.com
Subject: [PATCH v2 2/2] IB/qib: tidy up process_cc()
Date:   Tue, 25 Aug 2020 18:12:44 +0100
Message-Id: <20200825171242.448447-2-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function has a lot of gotos which could be replaced by simple
returns, making the function tidier and less bug prone.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/infiniband/hw/qib/qib_mad.c | 50 ++++++++---------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index f972e559a8a7..f83e331977f8 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2293,74 +2293,50 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
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

