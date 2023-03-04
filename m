Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02E56AABA7
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCDRqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCDRqp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:45 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62FA1B31D
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:44 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id e9-20020a056830200900b00694651d19f6so299135otp.12
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9BoHEwgKUbosGePv1yHqss3X8jvJed/Fb/ZUDuPZtQ=;
        b=UXZPVCHU0sc1MsiO8elucDqyCGeAp/eAFWkDIhJb2jDJ2mGVDS35BkHMqnTsDV4Vm3
         GVrgWTThBDCB9tn9gC26y0bWztqF77rwOGgrEzPPtCZDpNVtMamEFt1Smb+yP/fPs7FH
         SpOLsqSZll+Nq8M3QY68afWPGl82xJ/mRnwX5w4YzJ2aaeUFmSZ2XB94ZIvMdVuYM8Mt
         lztr1aZcxZ19dCq3iW7MmXtF788aetmOHASYll+9SsS4jXzth7lynWopWnmsd5d8iIH5
         GRUYM31/4Uj+wufhEL0o+N3PbUk5P30ExxGjJ4/9XPNXj2c8lomvDZXkWbnKMJrV1swk
         MLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9BoHEwgKUbosGePv1yHqss3X8jvJed/Fb/ZUDuPZtQ=;
        b=fuVyNKcCt9BlnLtCkZRH+iNzx5Rc0+NeQRNna2UNxU8DQGP86JJRhs9ZDOZwEjf5dC
         q4EpI0iMon9jOcQ1NqsCoxeVXRLEm0GPNpxDZkmpOUZdIF2fm48yqiog5C0d0lCnX9yU
         GTupoGnDliwCnz9mrkteIzuYz2Byk+yWffaC23T7sF+NVS/1WtUGEP9Fv2oH8sCoAO3d
         ZX6BaqlHc+TVIaW8sv9G3Lqtk/2BrNLdRKZWdJM1xenoubJPqetOHmUuLNgt5UkzbzgK
         trds/SFDzr/JFp96hNGQV+6pcIqhcGAlxpaF1K2Sy7rhxpCf/7IhmWWnj/wR6PJmjtD7
         6rWQ==
X-Gm-Message-State: AO0yUKWDoczhrmERVHlf8WWtD2erRjjmEHQvsistsMSu56ZHMnL1hzXP
        HAqOouqB0QhTkrvSemX73AI=
X-Google-Smtp-Source: AK7set9cBjIlX7q/qYKZcRdaeC9/WYRWSjUzzNwbimjS3loroQr7JJe2dGot9UFnTajb7+AjXK8Ilw==
X-Received: by 2002:a9d:861:0:b0:690:958e:f0e9 with SMTP id 88-20020a9d0861000000b00690958ef0e9mr2579534oty.1.1677952004091;
        Sat, 04 Mar 2023 09:46:44 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 1/8] RDMA/rxe: Convert tasklet args to queue pairs
Date:   Sat,  4 Mar 2023 11:45:27 -0600
Message-Id: <20230304174533.11296-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Originally is was thought that the tasklet machinery in rxe_task.c
would be used in other applications but that has not happened for
years. This patch replaces the 'void *arg' by struct 'rxe_qp *qp' in
the parameters to the tasklet calls. This change will have no
affect on performance but may make the code a little clearer.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |  3 +--
 drivers/infiniband/sw/rxe/rxe_loc.h  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_req.c  |  3 +--
 drivers/infiniband/sw/rxe/rxe_resp.c |  3 +--
 drivers/infiniband/sw/rxe/rxe_task.c | 11 ++++++-----
 drivers/infiniband/sw/rxe/rxe_task.h |  9 +++++----
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 876057e3ee3c..cbfa16b3a490 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -575,9 +575,8 @@ static void free_pkt(struct rxe_pkt_info *pkt)
 	ib_device_put(dev);
 }
 
-int rxe_completer(void *arg)
+int rxe_completer(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_send_wqe *wqe = NULL;
 	struct sk_buff *skb = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 839de34cf4c9..804b15e929dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -170,9 +170,9 @@ void rxe_srq_cleanup(struct rxe_pool_elem *elem);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
-int rxe_completer(void *arg);
-int rxe_requester(void *arg);
-int rxe_responder(void *arg);
+int rxe_completer(struct rxe_qp *qp);
+int rxe_requester(struct rxe_qp *qp);
+int rxe_responder(struct rxe_qp *qp);
 
 /* rxe_icrc.c */
 int rxe_icrc_init(struct rxe_dev *rxe);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 899c8779f800..f2dc2d191e16 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -635,9 +635,8 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return 0;
 }
 
-int rxe_requester(void *arg)
+int rxe_requester(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 4217eec03a94..7cb1b962d665 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1443,9 +1443,8 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 		queue_advance_consumer(q, q->type);
 }
 
-int rxe_responder(void *arg)
+int rxe_responder(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 60b90e33a884..959cc6229a34 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -11,7 +11,7 @@ int __rxe_do_task(struct rxe_task *task)
 {
 	int ret;
 
-	while ((ret = task->func(task->arg)) == 0)
+	while ((ret = task->func(task->qp)) == 0)
 		;
 
 	task->ret = ret;
@@ -29,7 +29,7 @@ static void do_task(struct tasklet_struct *t)
 	int cont;
 	int ret;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
-	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
+	struct rxe_qp *qp = (struct rxe_qp *)task->qp;
 	unsigned int iterations = RXE_MAX_ITERATIONS;
 
 	spin_lock_bh(&task->lock);
@@ -54,7 +54,7 @@ static void do_task(struct tasklet_struct *t)
 
 	do {
 		cont = 0;
-		ret = task->func(task->arg);
+		ret = task->func(task->qp);
 
 		spin_lock_bh(&task->lock);
 		switch (task->state) {
@@ -91,9 +91,10 @@ static void do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
+int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
+		  int (*func)(struct rxe_qp *))
 {
-	task->arg	= arg;
+	task->qp	= qp;
 	task->func	= func;
 	task->destroyed	= false;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 7b88129702ac..41efd5fd49b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -22,18 +22,19 @@ struct rxe_task {
 	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		lock;
-	void			*arg;
-	int			(*func)(void *arg);
+	struct rxe_qp		*qp;
+	int			(*func)(struct rxe_qp *qp);
 	int			ret;
 	bool			destroyed;
 };
 
 /*
  * init rxe_task structure
- *	arg  => parameter to pass to fcn
+ *	qp  => parameter to pass to func
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
+int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
+		  int (*func)(struct rxe_qp *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
-- 
2.37.2

