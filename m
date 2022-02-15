Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC474B78E8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiBOS23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:28:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiBOS23 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:28:29 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F946E01A
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:19 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id l8so7747465pls.7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMH8dcwDv/ki8RH7g8nrSOp4PHbKmDL9GmjKUJZMDQQ=;
        b=O0KbEhhpU+O0jxQCo3jknHx0j46sJqs2UgnqTwXiKqoaYhxCu6/MmE0WRTjZwmVbtH
         Dn6XZ7njjwrL8vUM0sKh1CHiuNxotN79tO/8aakS1WWxW4vXtl1Nt0OPGTzHvQFiLDdW
         OYt4pwBi77vTOlMqmue4gZAmM5nEsqjcP8WMcMJ4J7vvd3OZWXYQ7Bc3F+w3GaoXb2PV
         p+U4Ye2mrWqxv3I+n5pFtoLaI7XGXghCIC6VE3pvBygXzrOx3XK3VWfo8GTR1qKQf7Nr
         VG2MW9f7nfXd5GQJAjxh3oMShGeeb+jH0bXETMBB81hUG+gMhz9zKAc+LC8O1NgpYSFY
         g4ig==
X-Gm-Message-State: AOAM532NzaQZ+EOTC44gpwz/t7jPFpIagtknXQcIsP+mM02Yq3twbCeV
        iWbQ2Sn4/ZTXahqHXpS8iGo=
X-Google-Smtp-Source: ABdhPJynHy1kgtmvjmwncN4TDbDG3zVauc5LVc5FBPwHZO8RzW3a0uKxM2T90yU+Oe/7fpLlZLLBBw==
X-Received: by 2002:a17:902:db08:: with SMTP id m8mr283423plx.25.1644949698653;
        Tue, 15 Feb 2022 10:28:18 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k13sm43896746pfc.176.2022.02.15.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:28:18 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot+831661966588c802aae9@syzkaller.appspotmail.com
Subject: [PATCH 3/3] ib_srp: Fix a deadlock
Date:   Tue, 15 Feb 2022 10:26:50 -0800
Message-Id: <20220215182650.19839-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215182650.19839-1-bvanassche@acm.org>
References: <20220215182650.19839-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wait on tl_err_work instead of flushing system_long_wq since flushing
system_long_wq is deadlock-prone.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Fixes: ef6c49d87c34 ("IB/srp: Eliminate state SRP_TARGET_DEAD")
Reported-by: syzbot+831661966588c802aae9@syzkaller.appspotmail.com
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2db7429b42e1..8e1561a6d325 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -4044,12 +4044,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
 		mutex_lock(&host->target_mutex);
 		list_for_each_entry(target, &host->target_list, list)
 			srp_queue_remove_work(target);
+		list_for_each_entry(target, &host->target_list, list)
+			flush_work(&target->tl_err_work);
 		mutex_unlock(&host->target_mutex);
 
-		/*
-		 * Wait for tl_err and target port removal tasks.
-		 */
-		flush_workqueue(system_long_wq);
 		flush_workqueue(srp_remove_wq);
 
 		kfree(host);
