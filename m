Return-Path: <linux-rdma+bounces-22882-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Jb/Je0qTmqaEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22882-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:48:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D824724788
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:48:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="h7DNob/M";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22882-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22882-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56636302CDA4
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D7399CE9;
	Wed,  8 Jul 2026 10:47:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A23CB8E6;
	Wed,  8 Jul 2026 10:46:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507620; cv=none; b=LQI8zV+KQY743wPk4/lceCcOdKsjMui2Kik5BFKaPHedTyUfjcKWnMD49FwpxBz+bB4Z3HtkiSSDERdsKEcSk8ZFbqMjLUwcBCVBVWSw3PA+xIQOWpcGVBJ9T30MHz2UtVwoN/j6J0i0xumO0RdPpYg0craN97/aJJMazSNnuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507620; c=relaxed/simple;
	bh=aus6qNogRYgvYlyLybVdEkoyuqbtn+gqe7FLZI1mYJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/tPTOiCjvH14se4S7+RpeWFD38AIUKkNGLuK7borD5/AhKeclU0+Qcnxk28J1dUJPQQh26egNcruZtnUli039QEaiNm4M43qVfj5/qWqZvQhh83yPKIhxi1yl+3Z+gQgcKrm8pQMY+5fDDe1XOQSRIox6RLkiifrp7aouDV5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7DNob/M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E201F00A3F;
	Wed,  8 Jul 2026 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507611;
	bh=acoaJdtzQwhMjQNj0oamnWFbIW6Ngk1SJ1yqZEbaSNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7DNob/MaWZNx10BEmOIzd2rG4VqPVXW0MG5NOrv/gBEoKLOUZWWGUqmlHnVHju/z
	 x6jGKaF0SKlB1n3fgcFT5ojzySS+wmyULoU79e8paZyM4gd0wbj0TjHqmcj8WbojI8
	 QXiwwHhLaZuJjJOY/lQ1W+vAk5qnN/zKxJLLUsqp+xPz8L4JVM/Jb1KA3wv78EUiCX
	 d+EwPt+tPVjSxz8oRMCPttp2kc+NatY6TduEVT951CykMSzzyz8YISdi8jI6QxUCvT
	 m7Eb8Y2PTcjevkBs2VfeABiPq/ulOwiluaQCjWssW6UzUq49iA6NZPA97EQ2HFd41o
	 JfIiVeurHZw2Q==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Sadanand Warrier <sadanand.warrier@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Dean Luick <dean.luick@intel.com>,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Jubin John <jubin.john@intel.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH rdma-next 06/13] RDMA/hfi1: Create workqueues before device initialization
Date: Wed,  8 Jul 2026 13:45:44 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-6-b9e9641268a5@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
References: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:iweiny@kernel.org,m:dledford@redhat.com,m:willy@infradead.org,m:grzegorz.andrejczuk@intel.com,m:mike.marciniszyn@intel.com,m:sadanand.warrier@intel.com,m:michael.j.ruhl@intel.com,m:dean.luick@intel.com,m:sebastian.sanchez@intel.com,m:jubin.john@intel.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dennis.dalessandro@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22882-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D824724788

From: Leon Romanovsky <leonro@nvidia.com>

create_workqueues() only needs fields set up by hfi1_alloc_devdata().
Call it before hfi1_init_dd() so a workqueue allocation failure happens
before chip resources are initialized.

To keep the reordered error paths safe, make init_one() own hfi1_devdata.
hfi1_init_dd() unwinds its partial setup but leaves the allocation for the
caller to free. If device initialization fails, destroy the workqueues
before freeing the device data.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/chip.c |  4 +---
 drivers/infiniband/hw/hfi1/hfi.h  |  2 --
 drivers/infiniband/hw/hfi1/init.c | 19 ++++++++++---------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index a41dd67c50bf..592e330e74bf 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -15008,7 +15008,7 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 	 */
 	ret = hfi1_pcie_ddinit(dd, pdev);
 	if (ret < 0)
-		goto bail_free;
+		goto bail;
 
 	/* Save PCI space registers to rewrite after device reset */
 	ret = save_pci_variables(dd);
@@ -15263,8 +15263,6 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 bail_cleanup:
 	hfi1_free_rx(dd);
 	hfi1_pcie_ddcleanup(dd);
-bail_free:
-	hfi1_free_devdata(dd);
 bail:
 	return ret;
 }
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 95f86a002a3d..80d480c4fc6a 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2024,9 +2024,7 @@ struct cc_state *get_cc_state_protected(struct hfi1_pportdata *ppd)
 		/* waiting for an urgent packet to arrive */
 #define HFI1_CTXT_WAITING_URG 4
 
-/* free up any allocated data at closes */
 int hfi1_init_dd(struct hfi1_devdata *dd);
-void hfi1_free_devdata(struct hfi1_devdata *dd);
 
 /* LED beaconing functions */
 void hfi1_start_led_override(struct hfi1_pportdata *ppd, unsigned int timeon,
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index fd91a4b4812d..076ea9527b6e 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -629,8 +629,6 @@ void hfi1_init_pportdata(struct pci_dev *pdev, struct hfi1_pportdata *ppd,
 	ppd->sm_trap_qp = 0x0;
 	ppd->sa_qp = 0x1;
 
-	ppd->hfi1_wq = NULL;
-
 	spin_lock_init(&ppd->cca_timer_lock);
 
 	for (i = 0; i < OPA_MAX_SLS; i++) {
@@ -1161,7 +1159,7 @@ static void finalize_asic_data(struct hfi1_devdata *dd,
  * It cleans up and frees all data structures set up by
  * by hfi1_alloc_devdata().
  */
-void hfi1_free_devdata(struct hfi1_devdata *dd)
+static void hfi1_free_devdata(struct hfi1_devdata *dd)
 {
 	struct hfi1_asic_data *ad;
 	unsigned long flags;
@@ -1624,17 +1622,17 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto bail;
 
+	ret = create_workqueues(dd);
+	if (ret)
+		goto free_devdata;
+
 	/*
 	 * Do device-specific initialization, function table setup, dd
 	 * allocation, etc.
 	 */
 	ret = hfi1_init_dd(dd);
 	if (ret)
-		goto clean_bail; /* error already printed */
-
-	ret = create_workqueues(dd);
-	if (ret)
-		goto clean_bail;
+		goto destroy_workqueues; /* error already printed */
 
 	/* do the generic initialization */
 	initfail = hfi1_init(dd, 0);
@@ -1687,7 +1685,10 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-clean_bail:
+destroy_workqueues:
+	destroy_workqueues(dd);
+free_devdata:
+	hfi1_free_devdata(dd);
 	hfi1_pcie_cleanup(pdev);
 bail:
 	return ret;

-- 
2.54.0


