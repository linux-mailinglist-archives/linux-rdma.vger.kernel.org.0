Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC42C5D0F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 21:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbgKZU1v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 15:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbgKZU1u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 15:27:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB15C0613D4
        for <linux-rdma@vger.kernel.org>; Thu, 26 Nov 2020 12:27:50 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606422467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7m9gr69hH9Nnt195vzsgdSKx6rE/zcggT1rPSFAyNZw=;
        b=KWmnJqiSuyftrT+RWGW1GCXO23DGnzKNGQlSqxHsnLxAIGArBMjjzTaf4BOcnVMFZfSqoq
        XW3MCCZIXREt1Fdsbq9wQ/lae4LCRPrH/4GlFqz39nIhVPY73faYliwrj5FAyRX50+YRRA
        QOQLa3WbZ8HzY/Nov4h6NG/x050dZJzihxjjXf1Q16t8P/a0FL7twTcRqv5k3SjkX7sGVL
        Mpe/Fk2S85pRmUVuJ07A7G7scTWC3RRqiq6AkSYZ+fawLUa9C9t5zLmCwDYBJMfOeOSYxM
        BAPXysx/rhvWpRw7ydj6M+7h9K7xhOnZBQa0HN4Mtm/UXiYdEpIAASyLDVDNRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606422467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7m9gr69hH9Nnt195vzsgdSKx6rE/zcggT1rPSFAyNZw=;
        b=vNRFHfFh6QnYKw5FOc2gdzfLALy78vhEAue38Dq45P/1OlT40DSwAGljOE3Z2TSyLKaSJ0
        Zutxs56Ssgqf9HCw==
To:     linux-rdma@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] IB/iser: Remove in_interrupt() usage.
Date:   Thu, 26 Nov 2020 21:27:20 +0100
Message-Id: <20201126202720.2304559-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

iser_initialize_task_headers() uses in_interrupt() to find out if it is
safe to acquire a mutex.

in_interrupt() is deprecated as it is ill defined and does not provide what
it suggests. Aside of that it covers only parts of the contexts in which
a mutex may not be acquired.

The following callchains exist:

iscsi_queuecommand() *locks* iscsi_session::frwd_lock
-> iscsi_prep_scsi_cmd_pdu()
   -> session->tt->init_task() (iscsi_iser_task_init())
      -> iser_initialize_task_headers()
-> iscsi_iser_task_xmit() (iscsi_transport::xmit_task)
  -> iscsi_iser_task_xmit_unsol_data()
    -> iser_send_data_out()
      -> iser_initialize_task_headers()

iscsi_data_xmit() *locks* iscsi_session::frwd_lock
-> iscsi_prep_mgmt_task()
   -> session->tt->init_task() (iscsi_iser_task_init())
      -> iser_initialize_task_headers()
-> iscsi_prep_scsi_cmd_pdu()
   -> session->tt->init_task() (iscsi_iser_task_init())
      -> iser_initialize_task_headers()

__iscsi_conn_send_pdu() caller has iscsi_session::frwd_lock
  -> iscsi_prep_mgmt_task()
     -> session->tt->init_task() (iscsi_iser_task_init())
        -> iser_initialize_task_headers()
  -> session->tt->xmit_task() (

The only callchain that is close to be invoked in preemptible context:
iscsi_xmitworker() worker
-> iscsi_data_xmit()
   -> iscsi_xmit_task()
      -> conn->session->tt->xmit_task() (iscsi_iser_task_xmit()

In iscsi_iser_task_xmit() there is this check:
   if (!task->sc)
      return iscsi_iser_mtask_xmit(conn, task);

so it does end up in iser_initialize_task_headers() and
iser_initialize_task_headers() relies on iscsi_task::sc =3D=3D NULL.

Remove conditional locking of iser_conn::state_mutex because there is no
call chain to do so.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/=
ulp/iser/iscsi_iser.c
index 3690e28cc7ea2..b34a1881c4cad 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -187,12 +187,8 @@ iser_initialize_task_headers(struct iscsi_task *task,
 	struct iser_device *device =3D iser_conn->ib_conn.device;
 	struct iscsi_iser_task *iser_task =3D task->dd_data;
 	u64 dma_addr;
-	const bool mgmt_task =3D !task->sc && !in_interrupt();
 	int ret =3D 0;
=20
-	if (unlikely(mgmt_task))
-		mutex_lock(&iser_conn->state_mutex);
-
 	if (unlikely(iser_conn->state !=3D ISER_CONN_UP)) {
 		ret =3D -ENODEV;
 		goto out;
@@ -215,9 +211,6 @@ iser_initialize_task_headers(struct iscsi_task *task,
=20
 	iser_task->iser_conn =3D iser_conn;
 out:
-	if (unlikely(mgmt_task))
-		mutex_unlock(&iser_conn->state_mutex);
-
 	return ret;
 }
=20
--=20
2.29.2

