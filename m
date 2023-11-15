Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5E7EC727
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKOP2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKOP2B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279A181
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso10605100a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062077; x=1700666877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQqIrb54h0DMj/KbzsRVn/beLRIDs48LlOFxYh9J+hc=;
        b=XCKOe+dSprctWvh/VitzHxzNn9vyO9iArDOqNdcpeD+/id/HjVjAFqDjdU9mRdkst2
         8fk2Ind8BPAGy6D/LMnQUVstIHtKfY5DXxuc/xRkmgPBzoxIiwcImGIXmZwUBvx0jIAv
         Gf4xRRDMlw3Oj/J89j0KEhT1z+e+B8nSRyFy24PpJP5ZDwG9bzf4V/sj3WVekDZS05Fz
         dpNhydI8ptvKg2U2bAjfwghoZVBa6CDJfJ9oI1HkiUs9c/vsvDH4/xABNR7kQ5OL+I7+
         9XwWb4jQA+CltGvDT0L6BslBMEZJUkLxBHD804bCNLXUFvTa+crFt3z/o0GH15S9na1O
         FejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062077; x=1700666877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQqIrb54h0DMj/KbzsRVn/beLRIDs48LlOFxYh9J+hc=;
        b=Iw/Yj9eguNZ16R/+nJrJuwBnfMyNkBjPXBeD23BQgxRdUNW8lnM3KTqpMI3fdd7GhL
         r7bHeq5tRlS3frqMe1lVKM3Ih9+B96WcYp6wbG3iyiCXjpazB6opBCBGo1Sj+sCweoA+
         GaivY2VMk/59BkG4+X59spEoL5RrzXhr1s/gcClhevCSUcVBWsSfKRY1zR1PhjpnR3HI
         FduxiWVbyZjm9AMhOJ24iLvI4dY3Yc1GCb3M2UGb21g3Ay8IHnxSiqbIvFt2f+sK5x7F
         vhjFBx1iuiN923NqSYp4IB90n6tgn0yCyage2nevy8IQ2WvhgaScbu01k9AwIoiIjngg
         m+og==
X-Gm-Message-State: AOJu0YyBF96819s73J2T9aStFMxQi4kXPZC0tTzd4cluMZ86gkQF05gi
        YLdPQ3LQQrUi/hjMSR2n20aE5U5MzDnxY9gY/qk=
X-Google-Smtp-Source: AGHT+IHjY/r1KGkFXBxFP7fcaa/vVQj/KwIB9v+CXa1QvdELX45vSAvUYUz959j421l2IfKlte7LFA==
X-Received: by 2002:a05:6402:1507:b0:543:4ff0:4fd5 with SMTP id f7-20020a056402150700b005434ff04fd5mr7833088edw.39.1700062076697;
        Wed, 15 Nov 2023 07:27:56 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:56 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 1/9] RDMA/rtrs-clt: Add warning logs for RDMA events
Date:   Wed, 15 Nov 2023 16:27:41 +0100
Message-Id: <20231115152749.424301-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some RDMA CM events can trigger connection close or recovery for a
certain rtrs_clt_path. Such close/recovery triggers should happen after
an appropriate log message, since they can lead to IO failures.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 07261523c554..984a4a1db3c8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2025,6 +2025,8 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		/*
 		 * Device removal is a special case.  Queue close and return 0.
 		 */
+		rtrs_wrn_rl(s, "CM event: %s, status: %d\n", rdma_event_msg(ev->event),
+			    ev->status);
 		rtrs_clt_close_conns(clt_path, false);
 		return 0;
 	default:
-- 
2.25.1

