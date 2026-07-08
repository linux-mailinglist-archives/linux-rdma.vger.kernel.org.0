Return-Path: <linux-rdma+bounces-22891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jiJbEo4rTmr1EQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:50:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE5724829
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=npnZxVaH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22891-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22891-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA263300DEFA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE84434E5A;
	Wed,  8 Jul 2026 10:47:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9A42E00F;
	Wed,  8 Jul 2026 10:47:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507668; cv=none; b=PeK6ApmKBUOLnwXhZn0F7LTVMsIuMyiWdozsxGymU2G+mJ7HgTLZsQE+CYrGyoM739jeihnwMEoFqgwk+xSo1lslVT45DcG62Giiopd79tS8ejgOyX6YDb/XTIppBKXfte6nn2Wwn8mfFfWmo1Nq/KOEfikjhtVmHIYDiUqC0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507668; c=relaxed/simple;
	bh=ey3QISzMcWJZcFy8+5+iVmdEAQSegMqJZwmO3rn/yxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNwHHwR3iN5D+0+7aDqMUrZ39JafOTRf0rofi7H5hMKL3BNM19HN6KwqjU7xR+5JmA9ETHmvKnIoKHLLHuXpfROECa//gQBcDrzvmES+UAgM8wKXVwL/HxIWkTpLuqEeRhPSyNoLlnkUSLu1hxLS2+3O7WxRz82dSw3Ma+GSYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npnZxVaH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFD21F00A3D;
	Wed,  8 Jul 2026 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507652;
	bh=H0ZPnChJetr/ev1Yw4qYNcMvsvS2Bw12ArYx4uLDnd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=npnZxVaHGIx508hHeYyzWzKJUq/18j1vH44btr4HwHIGPznFgIN4nb5OnQBRXTwgW
	 4zBDrLs6Z46VyuehAcbcfcWaWklZlQTk8oZK1Evuv6MdV3vXZ42fg4czeruhjdcEcS
	 MZIGiVvxpakpAad0KLAkSqPkjTxHXeC6BaO1rlS/ICcY7SHc7Tc4t/u55Ca/yrHjDd
	 fTdzyH0uuE/gTXIF6KF3eQG4IgLgvTZA9PCmDnge/mlsb6JuLgk+nSpBnWs2yNbs0F
	 +ulOBMGpcxaLf1saSDBAaMTP8nSJkrqvY6jcxik+CO1PY4F/IvZeccpZEt5ltzyGYC
	 R063bjk4+qpWA==
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
Subject: [PATCH rdma-next 10/13] RDMA/hfi1: Stop flushing the global IB workqueue
Date: Wed,  8 Jul 2026 13:45:48 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-10-b9e9641268a5@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-22891-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2CE5724829

From: Leon Romanovsky <leonro@nvidia.com>

hfi1 does not queue work on ib_wq. QSFP and link work run on the per-port
link_wq, while the remaining device work uses hfi1_wq or dedicated queues.
The probe failure path destroys both per-port workqueues, and normal device
removal flushes them in shutdown_device() before destroying them.

Remove the flushes of the core-owned global workqueue. Waiting for
unrelated core or other device work is not part of hfi1 teardown.

Fixes: 71d47008ca1b ("IB/hfi1: Create workqueue for link events")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index ae30f6dd944c..6c642b68ad86 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1650,7 +1650,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (initfail || ret) {
 		msix_clean_up_interrupts(dd);
 		stop_timers(dd);
-		flush_workqueue(ib_wq);
 		for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 			hfi1_quiet_serdes(dd->pport + pidx);
 			ppd = dd->pport + pidx;
@@ -1721,9 +1720,6 @@ static void remove_one(struct pci_dev *pdev)
 
 	stop_timers(dd);
 
-	/* wait until all of our (qsfp) queue_work() calls complete */
-	flush_workqueue(ib_wq);
-
 	postinit_cleanup(dd);
 }
 

-- 
2.54.0


