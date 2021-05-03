Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A5371486
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhECLtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhECLtY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3DC06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r9so7404197ejj.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+pKLxWbuJShMku13u5MKR81/zLr7ElHvzSuhTxiUYc=;
        b=VrNokE1wssXA0rgAWsJ3YRbLQZz7eZI68GHzJ1AZWo7Q1h25I9SLhWce+dwzwrwOEW
         hIXRHCoLJoFloRPCKI7a0NOrd3KQ2CWDUCQNsCVVwICM7vsgD+1X97J4yRMJ4NGH0WOn
         pj2GenXUcAAKPKypRWgnQ/ex3Llm03MgSUxcKIlg6hbhqmDH5lMJN5EFDVTQ9oQfSn9N
         GuzBQzDgx/ONLlgQGlynYGcqldqduEG2NjPMFgMNjIqn/S/pwbCQmZNw9f97fOJk60HJ
         viyY7XJX9PnkQ5B296gu0+hNGDOjzQceJ17+daCF9qmb2xt+evoPyZ/7k8XW2JfwqPSX
         GE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+pKLxWbuJShMku13u5MKR81/zLr7ElHvzSuhTxiUYc=;
        b=IkS6c9dOU+PKdQkxC6S1YOu87NUdQvyDvjCnJKw/Cvs636YtF3xoliZ6bqFALE/WF7
         wiMZCKO53EkKSMeHGJkSprqGdkX8CTbtqGNl/fRH2jZiySHFUuHLXrtj20ZZUDQA8/ay
         +niJeLjiitApUicSFXTZvNVooi/qI7j6Cx69gxNwUh5aRCVCTuPuOmp83OU49QETI5Hd
         x7Gj6gZGAlP61ryHyu8YHmM3CmxXbu//1d1jc+w3KogY5g7DQb6bqoveQ7utob+ybwNl
         lzOurq30eDYoPPu2ewQksD0pzRgrQtIKVBUW4mgBAFXHJ5EFyu36z6SB2XAkf6yexSr8
         UKqQ==
X-Gm-Message-State: AOAM533f/rtkvR5oZB1zOdmangZzBc/KEVmGoOmOKE7a4yO47sQhQiAm
        vn5Lx1AIruDoTXxnlW/AD8QrTUbkBLJl4g==
X-Google-Smtp-Source: ABdhPJwL29Uu7K2EBvHoyU3vOA9WfdBKJbH3AzEzt+luASC2zMF1Gzzbdh45r45aLzrJ/mQyMmxoCQ==
X-Received: by 2002:a17:906:8a51:: with SMTP id gx17mr13770477ejc.549.1620042509377;
        Mon, 03 May 2021 04:48:29 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:29 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 12/20] RDMA/rtrs-clt: Remove redundant 'break'
Date:   Mon,  3 May 2021 13:48:10 +0200
Message-Id: <20210503114818.288896-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It is duplicated with the very next line

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d9764d1fe0f4..a57b77998573 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -655,7 +655,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			rtrs_err(con->c.sess, "rtrs_post_recv_empty(): %d\n",
 				  err);
 			rtrs_rdma_error_recovery(con);
-			break;
 		}
 		break;
 	case IB_WC_RECV:
-- 
2.25.1

