Return-Path: <linux-rdma+bounces-22889-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C974MmsrTmrpEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22889-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:50:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD3724800
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BwAq1jSd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22889-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22889-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 379213034088
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C6431496;
	Wed,  8 Jul 2026 10:47:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EC426EAA;
	Wed,  8 Jul 2026 10:47:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507656; cv=none; b=FiH3pQmy6eRx810fBnELTffOUY8sckd/4cCO0OL1hS4rPRDNA3Gv2eldcc424v8TbSXbi5uWum0g2Yf4VGePJshY/y/aw+VszE6KqFUycMxhotDnHdjRzuqebKa41oGRHnpyYOX39nZPGswij6sNQt5aQYegpimZK0CObGDaJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507656; c=relaxed/simple;
	bh=xRvOYY8r2Cvqe/Iqt/4NPfA3i5oyHGb2lIYmTv4YE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdDwr8ypdBrmNeofUG70oBpiDPNvGlCUxt7yjUbvkHRcSCwcfZ+whq7PVHS9y0ZpKP0dRxCq4LSrcr3gHHLM1LZEt6EIEFCwBVIUzyEHPLSOkd0BTuCJpiLUFP6OonbkRA2ClbvgHgMm2F8bAY47XeBqPPB77f57Y3Jzpa2tJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwAq1jSd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE901F000E9;
	Wed,  8 Jul 2026 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507642;
	bh=tIBvELbqlR1WJFEOxU3HCgVI6Dx/mlb+3L3PWlgu7dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BwAq1jSdqoC29436C7cSnB45Qa4utx5jTIjdtBd8HmAw5h3OCB0vpWWGJLn+OSmzM
	 pI0cTQlVROeNx4lktvsUKWlgwXObXNHe6MOJGQSdnvngNzRAIO4DETCYZ31yRWJV8l
	 Ye6E4Jm4TgTAK/K9xXI1Jl0PT2ViATJQmj9e/ObvHDtQnLCsR97wicIb2D9p63XytW
	 TDociYMb+uwRlEj4Te5BiNq9qSGLgn9sm76I3wx2FEb/eRHf3NJLmWEJTQTL3sA3CE
	 Ab0+SCqiuYG6KqMNuYhWNUR/hA2KgAQv6PS0xxYGV6WSaX9TtjTLju9hDQOWxB8/E3
	 5PGrNOqgjV2WA==
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
Subject: [PATCH rdma-next 12/13] RDMA/hfi1: Initialize debugfs after probe completes
Date: Wed,  8 Jul 2026 13:45:50 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-12-b9e9641268a5@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-22889-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: B1CD3724800

From: Leon Romanovsky <leonro@nvidia.com>

Commit ed6f653fe430 ("staging/rdma/hfi1: Fix debugfs access race") moved
debugfs creation after device initialization and IB registration so users
cannot access the files before the driver is ready. However, init_one()
still creates them before character device creation and SDMA startup
finish.

Move hfi1_dbg_ibdev_init() to the end of the successful probe path,
matching hfi1_dbg_ibdev_exit() as the first action in remove_one().

Fixes: ed6f653fe430 ("staging/rdma/hfi1: Fix debugfs access race")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index d17f319ad9f2..9ed7c1ffc93c 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1635,11 +1635,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * Now ready for use.  this should be cleared whenever we
 	 * detect a reset, or initiate one.
 	 */
-	if (!initfail && !ret) {
+	if (!initfail && !ret)
 		dd->flags |= HFI1_INITTED;
-		/* create debufs files after init and ib register */
-		hfi1_dbg_ibdev_init(&dd->verbs_dev);
-	}
 
 	if (initfail || ret) {
 		msix_clean_up_interrupts(dd);
@@ -1665,6 +1662,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   ERR_PTR(ret));
 
 	sdma_start(dd);
+	hfi1_dbg_ibdev_init(&dd->verbs_dev);
 
 	return 0;
 

-- 
2.54.0


