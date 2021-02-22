Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D07321A19
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 15:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBVOTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 09:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhBVOQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 09:16:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE44C06178A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 06:15:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id do6so29645092ejc.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 06:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HU191KwzVnrMuRT5oyZ+GSJPQ8LIy68Z17dK5sSyrdQ=;
        b=KFaKnhJ0tlvTgX5grj2VFGAm1HfCop+Y4pv1sbjnLQ+fI9QHSwHAB+NUsuD7RXZEL9
         6+ncTBkXaGffhGRvQkHZP3Ug55SUJyJJPml01/Pd1U9QLnP8YzkPEgyk0PHnsvuv/g8Q
         m+92ym/Lss2Y0Rq0u07ULmCjwWg8lB9VOYvpZONb3Whh1cgYIx1zrtGJcL2F3qka3GWn
         r/UI6XVKrV1Cw3Zl/qOZyOQiPa6QHWW+XpBZbaZqkSBgr2xY4DcZbEQmfiLivYScV3ZS
         D/G+iz8P0oo0KKxmjeE4LEALIdLp0gwg1wAGWkmZCRvC1pD/WsLekoOCC/Z60lG6bkRF
         J7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HU191KwzVnrMuRT5oyZ+GSJPQ8LIy68Z17dK5sSyrdQ=;
        b=QsEgSgYt8/LDOmktrgI3uCyIjcUyZCqFDYxRCAeHrPqSAw1tc2MNfsSrplbBFBbNnm
         t8ErGLENFZOqcxIgh2P5RJRSIiE9LBbeBHFRA1CC2qWzqdWVxwRskZ0J0knhX9BLlF+s
         gtWvmulRgThNLlfiT8/FJ2zZNI3hIxs4KUcKQiVFcyazDaGjtzDClSQlv/z7N8EreYfv
         E/ZW03fX6iUeMjTEHd1IEHtzogVsHl8FMzJBOA99Fm4akLryjdjfN1gHJP5lW2k+ow0H
         RoL9Wlx1N8079BoEqIcA6SK+0lSu6zCbo8/WjGcxP5nhw+JBn1TZGUaubuTR1ILp7bW/
         h6yQ==
X-Gm-Message-State: AOAM530+9cuZFvh7uSJgtJX2hxYJbBcmbyXeU8eg0D4EiZGpm8+VamDh
        +EgyJSsqMpL2PW/SNGeI/eJ5m9q0MdJQgQ==
X-Google-Smtp-Source: ABdhPJz+7Mi0eplLn8L/ERzScV5AkCFc08cwG6s/IRQzqOC3fEuOhppa+OZeQeSd3Deujne2F0Ecpg==
X-Received: by 2002:a17:907:d8a:: with SMTP id go10mr20851819ejc.403.1614003353949;
        Mon, 22 Feb 2021 06:15:53 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:496a:ec00:9029:bb23:33bd:ec62])
        by smtp.gmail.com with ESMTPSA id m19sm11615606eds.8.2021.02.22.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:15:53 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv2 for-next 2/2] RDMA/rtrs-clt: Use rdma_event_msg in log
Date:   Mon, 22 Feb 2021 15:15:51 +0100
Message-Id: <20210222141551.54345-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222141551.54345-1-jinpu.wang@cloud.ionos.com>
References: <20210222141551.54345-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's easier to understand string instead of enum.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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

