Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF5313F22
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 20:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhBHTgD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 14:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbhBHTfG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 14:35:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303FC061793
        for <linux-rdma@vger.kernel.org>; Mon,  8 Feb 2021 11:33:55 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612812834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rRLwXlZ4AnJ/T3GTWKZ98C1bcfYfugQq7db90OjUgxA=;
        b=EqySSq4U1N7/YDYu1ajOjw8vAnsBzy/QHdq2jCkVcg6OILTBlQsUzwX9wE1P8SToEPjQiw
        CG8rNcYjAPUcjSC2TnNmlqpmbigBicaNgjBiBFohgh+tMpIpHRUnV0/SJsDadIUMW7uCF/
        DtL/j7c3OSlrMsRWSRqk8uu0TOIEDhTkLgxY0rut8Gzl0dUzwlwG4Hd5HCBUxYXoyZG0Fk
        DJfPcz+IgDVoRCtOF6ao7iNcFK857dl4jJop3OJZVdjtlkImCkzF6iRwLH+yyVYlDFkKoV
        nLXooPLaZcd5oOiPiwO4T3nGeULuyn/rfPYDR3HDVqlKmYsmzf6c5uLLZU5Ncw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612812834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rRLwXlZ4AnJ/T3GTWKZ98C1bcfYfugQq7db90OjUgxA=;
        b=KHE746pleyXcKjf7pXONPDr7LOkWTjmBk5YnHEKCC5yNAWaF3l5StcExqf3FL2J/TBQHPJ
        XKN5Rrm0Zj1UABCQ==
To:     linux-rdma@vger.kernel.org
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] RDMA/qedr: Remove in_irq() usage from debug output.
Date:   Mon,  8 Feb 2021 20:33:47 +0100
Message-Id: <20210208193347.383254-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

qedr_gsi_post_send() has a debug output which prints the return value of
in_irq() and irqs_disabled().
The result of the in_irq(), even if invoked from an interrupt handler,
is subject to change depending on the `threadirqs' command line switch.
The result of irqs_disabled() is always be 1 because the function
acquires spinlock_t with spin_lock_irqsave().

Remove in_irq() and irqs_disabled() from the debug output because it
provides little value.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/infiniband/hw/qedr/qedr_roce_cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband=
/hw/qedr/qedr_roce_cm.c
index f5542d703ef90..13e5e6bbec99c 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -586,8 +586,8 @@ int qedr_gsi_post_send(struct ib_qp *ibqp, const struct=
 ib_send_wr *wr,
 		qp->wqe_wr_id[qp->sq.prod].wr_id =3D wr->wr_id;
 		qedr_inc_sw_prod(&qp->sq);
 		DP_DEBUG(qp->dev, QEDR_MSG_GSI,
-			 "gsi post send: opcode=3D%d, in_irq=3D%ld, irqs_disabled=3D%d, wr_id=
=3D%llx\n",
-			 wr->opcode, in_irq(), irqs_disabled(), wr->wr_id);
+			 "gsi post send: opcode=3D%d, wr_id=3D%llx\n", wr->opcode,
+			 wr->wr_id);
 	} else {
 		DP_ERR(dev, "gsi post send: failed to transmit (rc=3D%d)\n", rc);
 		rc =3D -EAGAIN;
--=20
2.30.0

