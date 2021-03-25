Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605603495A5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCYPdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhCYPdX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B9C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r12so3620984ejr.5
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqG/ZKYs7wDVx6d1FSRXmVCq5VuyNsPulySovN98UTs=;
        b=bzIoWQi2uIeK5xN/1doTzNBij08Vl/iNQYtk6hczm5CucXmI0aBlh4OwHzyilco+0P
         Ezk72G+TSWSrL6xEZSKUcKi8nvem1qgmNF6Vp86xh9XZTCed4IbhBK30XFHDOxbmnvL+
         RFfnsrrX1AJXcObXV6suJNXGnrF55Jwn6tcrnJtuUGYpl+waiWmjqD3rdAQX2w4q72we
         7xtSOA3OVJOWucq5JSOAhz9n2VMGYQ9a6i8au4ICTz2mMIPDdqPUTGAsOanPRwSeR/nc
         t+gPB8L/nQL926s+6wkJhVFuA7ZdVf54p/nGQks8Z4BtpzLrBfttHJTAltPszVz/+jX+
         p0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqG/ZKYs7wDVx6d1FSRXmVCq5VuyNsPulySovN98UTs=;
        b=BEpLRSrweM8yQa0Y0QV4q09ez0XfcaZhW8+V8Tp1uaxLEvZsqoxeddq3apCK46Dmnf
         Q0XoNBglwo2RTfDw3rO4a/y3Oxo+mWLXJuEisW3+8C7pRCemxYbHWte289Oae4GH6FAd
         W5VRJqU/FyJ352kvdY9vc0ErjyIiHEXB9X+5tKFxVVp5tvyAIZ74oVsBOM5YFbOccLV4
         0j9No/F8aJueGbq/buV8eu7TGDSlAp3p6H0AVDMMO7rb5LQdoKHZpIRumX4d/a7DvU3k
         2tC3JL3Ouv/cwajtBs7gwwsz6DZDT8xNhw97yfU4Y9DKx/nCsvI+zf/P1hOaBDXHIQZw
         JsIw==
X-Gm-Message-State: AOAM5320PbN2fK+I343gW1zS/vooLLOazLldAdNpXSnFIYTXJoYWP7IJ
        AhhH18iNwHPXCStL+KAvlJQdrBAKwixl/18B
X-Google-Smtp-Source: ABdhPJw2heM9wNxgP6Ztgb0oervugZlk5TMSUWZrxhTlWy0Cbt6e+ISu6bd+Et0+5+ccxZyFPPx2Fw==
X-Received: by 2002:a17:907:162b:: with SMTP id hb43mr10210520ejc.41.1616686401202;
        Thu, 25 Mar 2021 08:33:21 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 10/22] RDMA/rtrs: Cleanup the code in rtrs_srv_rdma_cm_handler
Date:   Thu, 25 Mar 2021 16:32:56 +0100
Message-Id: <20210325153308.1214057-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Let these cases share the same path since all of them need to close
session.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index e9998e40f2f7..c0a65e1e6fda 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1913,13 +1913,10 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 		rtrs_err(s, "CM error (CM event: %s, err: %d)\n",
 			  rdma_event_msg(ev->event), ev->status);
-		close_sess(sess);
-		break;
+		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		close_sess(sess);
-		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		close_sess(sess);
 		break;
-- 
2.25.1

