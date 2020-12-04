Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951862CF34C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 18:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgLDRnj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 12:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgLDRnj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 12:43:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32438C0613D1
        for <linux-rdma@vger.kernel.org>; Fri,  4 Dec 2020 09:42:59 -0800 (PST)
Date:   Fri, 4 Dec 2020 18:42:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607103777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2nW4HbOQcfOQzFvYyMeEfW0rSTjsj1DM1mV4zkz074=;
        b=UPob0GtV7W9GcAaS0p5j/w3fE9bVRrAuEAzJpf2SqFkttIKf2aNKL340mmPslFoQxifo5o
        d3XRNjIV1tzqnprHy7GMoMtvzWkdLmZfsTYeMp9pnc8jMnbXmKa5+r7ghJsT0LX2QAIT30
        bgm8QAsRtgm6jN7ewtImQGElnwFUtRiTDgARmDlV2lYNdM1Mwnb0BnX62xGBsVSVmr9Lfc
        ubG799cxpNXrenRmi0pqk9ISP2b23ZzXNHcmhYJoWzwEUv8xmac7VRkuOEO68qGnIc3IvE
        2Yyp53C6p5NbTh2E+ejJBALgrdiN6LpAvxOJ7ZSJCfNRlNJx29pLVkYkGYiv+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607103777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2nW4HbOQcfOQzFvYyMeEfW0rSTjsj1DM1mV4zkz074=;
        b=GR9vmdrWnUf1CjbjmwUfO4M827TnH7H8G2oXuxzbc8XVOj7VwFvAzo5kwDBGsQg+TBZhMQ
        YA8pDA0541lId5BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <maxg@nvidia.com>,
        linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH v2] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201204174256.62xfcvudndt7oufl@linutronix.de>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
 <20201127130314.GE552508@nvidia.com>
 <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
 <20201127143138.GG552508@nvidia.com>
 <20201203135608.f67bmpopealp7xcm@linutronix.de>
 <3cf15ad5-4c44-f9ca-4a16-1c680d3e265f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3cf15ad5-4c44-f9ca-4a16-1c680d3e265f@grimberg.me>
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
call chain to do so. Remove the goto label and return early now that
there is no clean up needed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
---

v1=E2=80=A6v2: Remove the goto label and return early. Suggested by Sagi
       Grimberg.

 drivers/infiniband/ulp/iser/iscsi_iser.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/=
ulp/iser/iscsi_iser.c
index 3690e28cc7ea2..72fcccb459872 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -187,23 +187,14 @@ iser_initialize_task_headers(struct iscsi_task *task,
 	struct iser_device *device =3D iser_conn->ib_conn.device;
 	struct iscsi_iser_task *iser_task =3D task->dd_data;
 	u64 dma_addr;
-	const bool mgmt_task =3D !task->sc && !in_interrupt();
-	int ret =3D 0;
=20
-	if (unlikely(mgmt_task))
-		mutex_lock(&iser_conn->state_mutex);
-
-	if (unlikely(iser_conn->state !=3D ISER_CONN_UP)) {
-		ret =3D -ENODEV;
-		goto out;
-	}
+	if (unlikely(iser_conn->state !=3D ISER_CONN_UP))
+		return -ENODEV;
=20
 	dma_addr =3D ib_dma_map_single(device->ib_device, (void *)tx_desc,
 				ISER_HEADERS_LEN, DMA_TO_DEVICE);
-	if (ib_dma_mapping_error(device->ib_device, dma_addr)) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
+	if (ib_dma_mapping_error(device->ib_device, dma_addr))
+		return -ENOMEM;
=20
 	tx_desc->inv_wr.next =3D NULL;
 	tx_desc->reg_wr.wr.next =3D NULL;
@@ -214,11 +205,8 @@ iser_initialize_task_headers(struct iscsi_task *task,
 	tx_desc->tx_sg[0].lkey   =3D device->pd->local_dma_lkey;
=20
 	iser_task->iser_conn =3D iser_conn;
-out:
-	if (unlikely(mgmt_task))
-		mutex_unlock(&iser_conn->state_mutex);
=20
-	return ret;
+	return 0;
 }
=20
 /**
--=20
2.29.2

