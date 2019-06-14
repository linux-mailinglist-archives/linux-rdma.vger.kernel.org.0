Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC04643C
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfFNQdD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:33:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:20061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfFNQdD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:33:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:33:03 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2019 09:33:02 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGX23O060993;
        Fri, 14 Jun 2019 09:33:02 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGX0dP045070;
        Fri, 14 Jun 2019 12:33:00 -0400
Subject: [PATCH for-rc 6/7] IB/hfi1: Handle wakeup of orphaned QPs for pio
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 14 Jun 2019 12:33:00 -0400
Message-ID: <20190614163300.44927.3466.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
References: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Once a send context is taken down due to a link failure, any QPs waiting
for pio credits will stay on the waitlist indefinitely.

Fix by wakeing up all QPs linked to piowait list.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/pio.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 9190086..2f32d53 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -952,6 +952,22 @@ void sc_disable(struct send_context *sc)
 		}
 	}
 	spin_unlock(&sc->release_lock);
+
+	write_seqlock(&sc->waitlock);
+	while (!list_empty(&sc->piowait)) {
+		struct iowait *wait;
+		struct rvt_qp *qp;
+		struct hfi1_qp_priv *priv;
+
+		wait = list_first_entry(&sc->piowait, struct iowait, list);
+		qp = iowait_to_qp(wait);
+		priv = qp->priv;
+		list_del_init(&priv->s_iowait.list);
+		priv->s_iowait.lock = NULL;
+		hfi1_qp_wakeup(qp, RVT_S_WAIT_PIO | HFI1_S_WAIT_PIO_DRAIN);
+	}
+	write_sequnlock(&sc->waitlock);
+
 	spin_unlock_irq(&sc->alloc_lock);
 }
 

