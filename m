Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBF740AD0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjF1IK5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 04:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjF1IFt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 04:05:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888C2D73;
        Wed, 28 Jun 2023 01:04:15 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b44b5adfd3so4480533a34.3;
        Wed, 28 Jun 2023 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939455; x=1690531455;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcRIZBylUodGg6xfwSa+s03103SVj3Aromni82wUePU=;
        b=B0FEtoQpRUb3J8puVJuM9Z+DAcx79qLsl1w20PIMSoW4+yRiYUaQN3bn7R0yXE5ZAz
         l1ymLC0TymQw8OU29lcj3ntJEgUZm2u6v4pJb75KJ91bmJqVF9hvi4Go5HQQMBy8pOdf
         /JE6w+szmm4YpDn5Q+r2m4gbhlXHf2JsT/PAz31EoUWmC37Pw/aOwWu4BswTB27Z6eRq
         Xw4pzqweeQgSy5nvfh7ITDDkQjQokZ0dPImddUYfsazUy4PnLb6PnQ5dZZUmPYcTC3VB
         ZczUvJQra1SOR5flzQ6qs/bDl11iyD67i7V1lUJ9+nZOT0zOqq+pXjElrRyE/NpRlhrJ
         NjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939455; x=1690531455;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcRIZBylUodGg6xfwSa+s03103SVj3Aromni82wUePU=;
        b=dx+rmfYEVZySYxLfSDrMPy9b2RpcvyN0W97+/2UBpYOd15zjIFrkO9eXSnFg9+j6wG
         pjlZnq2ZHQV3n99WYdKUybmiGHMVKjah9n/QIZv5moPHRS5/jQk5i021cqZYkzxaeqM8
         5F+MoLJf7ItSlZmYSxhEdLCjs7I4cjzG8ogN22U5jsE3nM9krxJTt5K0dkhMVtMwdEvz
         RspK9W5nSZUAUIAN9jUoR/jZJ2KxVceU1g6K+50EDn/vYCjHusZEPSmMFzETz6WNYw+Z
         eJ7uel6nQCmS7HbWXxTtfg1BXuowdgKXAcNFAP1OFN8UM9ErPRwKT1ZtMAUj0hJl6PDf
         lKew==
X-Gm-Message-State: AC+VfDzYVJWzkRFJrgsi7Vn8SXxw1I9nGOMv6sauHshbBwe0MBeQE3nI
        4/fufVo2sIOYri8jABNZhCF8qZDA8bnOSw==
X-Google-Smtp-Source: ACHHUZ69UkxxcYAdA4L9SDk4thCu0zc7lIFPY7os8Def0ljO2ruAnk0fEj1EBnbrR/THYFgq4CYG4A==
X-Received: by 2002:a05:6a20:914a:b0:10b:8e96:561 with SMTP id x10-20020a056a20914a00b0010b8e960561mr26061871pzc.62.1687928408592;
        Tue, 27 Jun 2023 22:00:08 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001b80f3717d5sm3544632plz.123.2023.06.27.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 22:00:07 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] IB/hfi1: Fix potential deadlock on &sde->flushlist_lock
Date:   Wed, 28 Jun 2023 04:59:25 +0000
Message-Id: <20230628045925.5261-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As &sde->flushlist_lock is acquired by timer sdma_err_progress_check()
through layer of calls under softirq context, other process
context code acquiring the lock should disable irq.

Possible deadlock scenario
sdma_send_txreq()
    -> spin_lock(&sde->flushlist_lock)
        <timer interrupt>
        -> sdma_err_progress_check()
        -> __sdma_process_event()
        -> sdma_set_state()
        -> sdma_flush()
        -> spin_lock_irqsave(&sde->flushlist_lock, flags) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index bb2552dd29c1..0431f575c861 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -2371,9 +2371,9 @@ int sdma_send_txreq(struct sdma_engine *sde,
 	tx->sn = sde->tail_sn++;
 	trace_hfi1_sdma_in_sn(sde, tx->sn);
 #endif
-	spin_lock(&sde->flushlist_lock);
+	spin_lock_irqsave(&sde->flushlist_lock, flags);
 	list_add_tail(&tx->list, &sde->flushlist);
-	spin_unlock(&sde->flushlist_lock);
+	spin_unlock_irqrestore(&sde->flushlist_lock, flags);
 	iowait_inc_wait_count(wait, tx->num_desc);
 	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
 	ret = -ECOMM;
@@ -2459,7 +2459,7 @@ int sdma_send_txlist(struct sdma_engine *sde, struct iowait_work *wait,
 	*count_out = total_count;
 	return ret;
 unlock_noconn:
-	spin_lock(&sde->flushlist_lock);
+	spin_lock_irqsave(&sde->flushlist_lock, flags);
 	list_for_each_entry_safe(tx, tx_next, tx_list, list) {
 		tx->wait = iowait_ioww_to_iow(wait);
 		list_del_init(&tx->list);
@@ -2472,7 +2472,7 @@ int sdma_send_txlist(struct sdma_engine *sde, struct iowait_work *wait,
 		flush_count++;
 		iowait_inc_wait_count(wait, tx->num_desc);
 	}
-	spin_unlock(&sde->flushlist_lock);
+	spin_unlock_irqrestore(&sde->flushlist_lock, flags);
 	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
 	ret = -ECOMM;
 	goto update_tail;
-- 
2.17.1

