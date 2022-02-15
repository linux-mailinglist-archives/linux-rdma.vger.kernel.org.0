Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803744B79A0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 22:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiBOVFi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 16:05:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiBOVFh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 16:05:37 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966612A722
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:05:26 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso315354pjh.5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNa/UJIkkqDSsgbLIfRsaSWY+2asHcRhTiyN3yW7ZOg=;
        b=PywRJXG8C6RPiYEXG34nudb+3lFH+lXkM4w1WldhlJwhj9Yjm6iloqgJxSoZgkB4pH
         4b4NC9QvcfM9DalBDqzzblAGBaCjVxT7sARFy5ODsY4TkL9rHosezQxjXTrRMuGirNQ3
         bz8L+gMkUhUmHUGgi12YAKp7S4E587HipQFvc9O5gargtAT3CLWV6uV8qnEy/8xGRHnc
         7GOB3wg0zvsPXs6PlTmI+0L4HAYIus2wRDg0C8uvNOpVnNXOLXZynGb9NDahPk6a3Knb
         rj9qqD7abD4RGPvb0SGL0W9tKZIrzgl8ls6NQN6hhnamPDQMQGFvXv0GatWuSvOLW/+O
         uNeQ==
X-Gm-Message-State: AOAM533DVP6/TvNpefvSyJCjByBLjizTzAIUrqcffjh14FdIN9CIUefM
        3YvbHiHiDuXR3jI8L7BA9NQ=
X-Google-Smtp-Source: ABdhPJwpbhtH+T0K6ZFS5WARw5sn3wX4vO/ql7jcUR0Cf1kcgIcZGBZ0bKgHIaL9uy7aMx4sekWD6w==
X-Received: by 2002:a17:90a:4d0d:b0:1b9:8ebf:4c36 with SMTP id c13-20020a17090a4d0d00b001b98ebf4c36mr6606343pjg.130.1644959125989;
        Tue, 15 Feb 2022 13:05:25 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id i10sm19223888pjd.2.2022.02.15.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:05:25 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot+831661966588c802aae9@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] ib_srp: Fix a deadlock
Date:   Tue, 15 Feb 2022 13:05:11 -0800
Message-Id: <20220215210511.28303-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215210511.28303-1-bvanassche@acm.org>
References: <20220215210511.28303-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the flush_workqueue(system_long_wq) call since flushing
system_long_wq is deadlock-prone and since that call is redundant.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Fixes: ef6c49d87c34 ("IB/srp: Eliminate state SRP_TARGET_DEAD")
Reported-by: syzbot+831661966588c802aae9@syzkaller.appspotmail.com
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index e174e853f8a4..285b766e4e70 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -4047,9 +4047,11 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
 		spin_unlock(&host->target_lock);
 
 		/*
-		 * Wait for tl_err and target port removal tasks.
+		 * srp_queue_remove_work() queues a call to
+		 * srp_remove_target(). The latter function cancels
+		 * target->tl_err_work so waiting for the remove works to
+		 * finish is sufficient.
 		 */
-		flush_workqueue(system_long_wq);
 		flush_workqueue(srp_remove_wq);
 
 		kfree(host);
