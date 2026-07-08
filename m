Return-Path: <linux-rdma+bounces-22885-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0fBCEBUrTmqqEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22885-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:48:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B47247AF
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:48:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GhQhzeHy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22885-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22885-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D27D1300EEAA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874BF430316;
	Wed,  8 Jul 2026 10:47:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DC427A0F;
	Wed,  8 Jul 2026 10:47:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507633; cv=none; b=d30Dc5AKbgxV1wJppJPPpzTTY03T0tLfJnZZajjP8MF4COtszy4KupeZTGNXdApyiX1WBQIxY+MImFIXL77z/BCPoQDCa7XX33AcRzBMo1mUMGUUZaFqli+JX08tC5zhUYSVzYu/V1PDq1VZXLPyVgcKUudLcLQus6DrnFZfqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507633; c=relaxed/simple;
	bh=QTEpX5+VEa3Q68rBAv+nEgFWU1X3aCV+CT6RYQtN1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX9EdsiytcXT8qrpmrujs4I8yWZJBxKfgp5awZtYv3l7dDcAyj0xSMVnwJ0UZXGBWRif5jctHcKjlYsos5AtOGguXpKPdUG+dqvzie1nQLRTlq/aPgFCndlPLD1n9lHQeoYx2PeF2H4KxHGLGT2fiZRvjMZNaVhNCbvd58TRSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhQhzeHy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D731F00A3D;
	Wed,  8 Jul 2026 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507627;
	bh=1DZ1auoBgF4zM/BywSq303vABTGKlgQb3ejIquGJ2BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhQhzeHytMIPnvkosjLK2DM0KGY5zEf3VfhsPJWv5yOwRjnrGbPOyWck15BXYCmHZ
	 wN9H3iWmCT/Yt/V/QYaiuFHMJkpn27fpQ6UOXq0eaYF+i6oP57fpbNyJdrqdXiXdQT
	 f35m1fqHoIa3X8NdPPuYF3YKzdqLQRFF0ticcsKOgwBiOAUb/AUGL95Q4/5/GTb92I
	 VJu0626jKLXV+NevmuxZZ19m1SLkMN6hozHbrAEtWcb8QGs8oreuiC0o8jnWDZqZf8
	 ga0gvEngROBJaOBFin5UT6CIiut20SmeVY+ozw6UXioEP5fu3d0RNRXc3MOH/63M48
	 MmHQsssW9qz4Q==
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
Subject: [PATCH rdma-next 09/13] RDMA/hfi1: Remove redundant NULL checks in create_workqueues()
Date: Wed,  8 Jul 2026 13:45:47 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-9-b9e9641268a5@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22885-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F19B47247AF

From: Leon Romanovsky <leonro@nvidia.com>

create_workqueues() is called only from init_one(), immediately after
hfi1_alloc_devdata() returns a zero-initialized hfi1_devdata. As a
result, the per-port hfi1_wq and link_wq pointers are always NULL on
entry, and nothing modifies them between allocation and this call.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/init.c | 56 ++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 0545180b5a11..ae30f6dd944c 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -738,31 +738,27 @@ static int create_workqueues(struct hfi1_devdata *dd)
 
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
-		if (!ppd->hfi1_wq) {
-			ppd->hfi1_wq =
-				alloc_workqueue(
-				    "hfi%d_%d",
-				    WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
-				    WQ_PERCPU,
-				    HFI1_MAX_ACTIVE_WORKQUEUE_ENTRIES,
-				    dd->unit, pidx);
-			if (!ppd->hfi1_wq)
-				goto wq_error;
-		}
-		if (!ppd->link_wq) {
-			/*
-			 * Make the link workqueue single-threaded to enforce
-			 * serialization.
-			 */
-			ppd->link_wq =
-				alloc_workqueue(
-				    "hfi_link_%d_%d",
-				    WQ_SYSFS | WQ_MEM_RECLAIM | WQ_UNBOUND,
-				    1, /* max_active */
-				    dd->unit, pidx);
-			if (!ppd->link_wq)
-				goto wq_error;
-		}
+		ppd->hfi1_wq =
+			alloc_workqueue(
+			    "hfi%d_%d",
+			    WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+			    WQ_PERCPU,
+			    HFI1_MAX_ACTIVE_WORKQUEUE_ENTRIES,
+			    dd->unit, pidx);
+		if (!ppd->hfi1_wq)
+			goto wq_error;
+		/*
+		 * Make the link workqueue single-threaded to enforce
+		 * serialization.
+		 */
+		ppd->link_wq =
+			alloc_workqueue(
+			    "hfi_link_%d_%d",
+			    WQ_SYSFS | WQ_MEM_RECLAIM | WQ_UNBOUND,
+			    1, /* max_active */
+			    dd->unit, pidx);
+		if (!ppd->link_wq)
+			goto wq_error;
 	}
 	return 0;
 wq_error:
@@ -1658,14 +1654,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 			hfi1_quiet_serdes(dd->pport + pidx);
 			ppd = dd->pport + pidx;
-			if (ppd->hfi1_wq) {
-				destroy_workqueue(ppd->hfi1_wq);
-				ppd->hfi1_wq = NULL;
-			}
-			if (ppd->link_wq) {
-				destroy_workqueue(ppd->link_wq);
-				ppd->link_wq = NULL;
-			}
+			destroy_workqueue(ppd->hfi1_wq);
+			destroy_workqueue(ppd->link_wq);
 		}
 		if (!j)
 			hfi1_device_remove(dd);

-- 
2.54.0


