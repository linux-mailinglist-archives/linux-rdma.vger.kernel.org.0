Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312FB31F8A3
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 12:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBSLvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBSLvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Feb 2021 06:51:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252E3C061756
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 03:50:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v22so9336047edx.13
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 03:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXMFOzhf6BiRDoEIQw0Iyje74L4hk0/kocBi/SN8CkM=;
        b=eRKcfJQ16/vOpNDoRa4GOqX48M6/rp+FAv/xfQmjLoxmtf7nq1ehBthZLGJGfuDuxS
         y3jjgSxIK1E4wGJFTV98+rZ/ITcIOPksrfynEQy53rCFxbBGGkTRMAlpDOzWWQ/QiicA
         qMVn3GfZz5INHIP9Q1xb+Ew37/vbRJlGwgjXWPVD+x/aE2Go55iYQWlZJK4OAek4Rijc
         I5TE6K8jskGkOabIHNJG/zlKtK4PXK/qT6zwvUEvA8TZfmEu3fcZhYalWNm6ZjqOBmpE
         q1qVINZTpGEY0xhJ3nHxk/HCMM3z1VChCtxc3f8Jq9vA/FEXqIwmi0HhfU1wh13vYw0d
         dekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXMFOzhf6BiRDoEIQw0Iyje74L4hk0/kocBi/SN8CkM=;
        b=h4L6KQwWMyidoB3NwdSRNS0GRnEPtCyyRh3bl1re1+JO31XN6lI9RSrZ1bVZlErWmH
         JBqN8BiXCU6W4MWBGmnk68LV6V98ZJxWbanIOWlobtGEzj8kQvWhX0Ri5ENya44HXNXu
         JHQD67Lqs5UfWWpv9sFQqqJacBicM6I+/6M2SjEOZbpZjf5fAyvtRv19crQsKLqZ8S7k
         4gnq4F9muDy1AIjFRHLkyiEfH2uBLV8HEVuHd9WoawedoqkH/2/fmc3m+H/glLGrlk+P
         oLtFgjIS6+UzIRnfay3hJPMJuPF4oiOzkoAVnEWZxXe4SMhwYEAultYVgclhEdF0zoOB
         ydxA==
X-Gm-Message-State: AOAM530XrEM/ph37r90wnu4Vij2qWl9FjnhXMQI41F2ysYtsOm2d+7+6
        C/cvxcj1k/k0L3ZePum3hijOSZN2DExmKw==
X-Google-Smtp-Source: ABdhPJzwyVRswuHmg4hQs7XlmY7ZKfb2wGKNObNo8vbIpqv1601gJDaC+qSF9dgieVABjszifo4cPw==
X-Received: by 2002:aa7:d315:: with SMTP id p21mr7220161edq.300.1613735420749;
        Fri, 19 Feb 2021 03:50:20 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:496a:1b00:d976:bb6f:c5ab:7b14])
        by smtp.gmail.com with ESMTPSA id ia25sm2544099ejc.44.2021.02.19.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 03:50:20 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH 2/2] RDMA/rtrs-clt: Use rdma_event_msg in log
Date:   Fri, 19 Feb 2021 12:50:19 +0100
Message-Id: <20210219115019.38981-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's easier to understand string instead of enum.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4e9cf06cc17a..f95955fc2992 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1853,12 +1853,14 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		rtrs_wrn(s, "CM error event %d\n", ev->event);
+		rtrs_wrn(s, "CM error (CM event: %s, err: %d)\n",
+			 rdma_event_msg(ev->event), ev->status);
 		cm_err = -ECONNRESET;
 		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-		rtrs_wrn(s, "CM error event %d\n", ev->event);
+		rtrs_wrn(s, "CM error (CM event: %s, err: %d)\n",
+			 rdma_event_msg(ev->event), ev->status);
 		cm_err = -EHOSTUNREACH;
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
@@ -1868,7 +1870,8 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		rtrs_clt_close_conns(sess, false);
 		return 0;
 	default:
-		rtrs_err(s, "Unexpected RDMA CM event (%d)\n", ev->event);
+		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d)\n",
+			 rdma_event_msg(ev->event), ev->status);
 		cm_err = -ECONNRESET;
 		break;
 	}
-- 
2.25.1

