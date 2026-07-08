Return-Path: <linux-rdma+bounces-22878-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CWmIK38rTmrvEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22878-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:50:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C6724817
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:50:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cbg0RvvL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22878-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22878-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B121D3023C17
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3042E8F1;
	Wed,  8 Jul 2026 10:46:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA5426407;
	Wed,  8 Jul 2026 10:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507593; cv=none; b=kfz2xqVdNGV6/v1KRPrJ9+TQlU6CjtHcLMRVrEGCJ1UfUXmBUBRWceYnmwumLw+JRFP/yccTQS33AoBTxcuu9S/e75g7GpMbDj64F8lh9ZLSo7OD7zxtjHEjBiIANLeJiYgSDCrxbWjUjPUvIg5KpK5Yso5sfd8sojPNshi6aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507593; c=relaxed/simple;
	bh=PE0K7deRmx+g/mtQOSFJYB4tapESD9+NQsj189oagYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f+IPUKKpULUiLjGMkVWSPoSUzp/gFdgklsLzYMqMF9NkNY+t5Sd4y8ydZxekQhGg6Lu7jBd2aSmLeA2cs/ZYTcghswrOVeJl1UztPvdYt6JR17u2z8yKIgvXYpcwsPzqucoyH4GltU4wRv3Ak3MRBGh48hmYKdMlAWgl9JQ72WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbg0RvvL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CD21F000E9;
	Wed,  8 Jul 2026 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507584;
	bh=8jQlP2AivLKAlkNsQAQ6Q/UWCLRJu5fwXwK76FmCHfU=;
	h=From:To:Cc:Subject:Date;
	b=Cbg0RvvLWfIrFNfS6/OTMNi+ddIMvQ2q9Yv02TcafEQ4P4WxgaopohtYK2djjo8wl
	 FvCmppV/O361RmBeC0WFjug4TkjNfQsicikYZuW//Z+iFAvDRxFKapgoUvqgGrhvLL
	 7ddRTZO2OAYpizWGdJ2lGk8ggP8UyfpdQTdjPuK+hiLYuYfIscqv05W2nfQS3XfEAB
	 NJEzyC9zAhDpIsBXf954KGjWyG2uXDWSsn+TWrRRjsaoiewT0NBgdxsBQIQGTJOltc
	 k/C6YS1NR2Sa8tJF4KvwA4f8K9KETlc7pOvwJJ+CE2g1t+ZR0sqpITh5Rd1JFutw0K
	 FzSHVBrgVtrDw==
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
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH rdma-next 00/13] RDMA/hfi1: Make init_one() a sane counterpart of remove_one()
Date: Wed,  8 Jul 2026 13:45:38 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260707-clean-init-one-hfi1-e02835d239ad
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:iweiny@kernel.org,m:dledford@redhat.com,m:willy@infradead.org,m:grzegorz.andrejczuk@intel.com,m:mike.marciniszyn@intel.com,m:sadanand.warrier@intel.com,m:michael.j.ruhl@intel.com,m:dean.luick@intel.com,m:sebastian.sanchez@intel.com,m:jubin.john@intel.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dennis.dalessandro@intel.com,m:dawei.feng@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22878-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD5C6724817

The hfi1 PCI probe path, init_one(), has accumulated years of ad-hoc
error handling that no longer matches how a driver probe is expected to
look. Rather than unwinding each initialization step as it fails, it
allocated hfi1_devdata up front, ran every stage, and then funneled two
unrelated failure values (initfail and ret) into one combined cleanup
block. That block kept the device half-alive "so diags can be used",
created the character device only to remove it again, flushed a global
workqueue the driver never queues onto, and diverged from the teardown
in remove_one() even though both release the same resources.

The result was hard to reason about and easy to break: a failing stage
released either too little (leaks) or ran cleanup for resources that were
never set up. Two real leaks were hiding in there, one of which was
reported in the mailing list.

Thanks

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (13):
      RDMA/rvt: Return NULL after port allocation failure
      RDMA/hfi1: Preserve unit 0 on allocation failure
      RDMA/hfi1: Remove redundant PCI device ID validation
      RDMA/hfi1: Pass PCI device to hfi1_pcie_init()
      RDMA/hfi1: Drop device data from hfi1_validate_rcvhdrcnt()
      RDMA/hfi1: Create workqueues before device initialization
      RDMA/hfi1: Free RX data on late probe failure
      RDMA/hfi1: Allocate device data after PCI initialization
      RDMA/hfi1: Remove redundant NULL checks in create_workqueues()
      RDMA/hfi1: Stop flushing the global IB workqueue
      RDMA/hfi1: Defer device creation until probe succeeds
      RDMA/hfi1: Initialize debugfs after probe completes
      RDMA/hfi1: Align probe error unwinding with device removal

 drivers/infiniband/hw/hfi1/chip.c |  21 ++---
 drivers/infiniband/hw/hfi1/chip.h |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h  |   4 +-
 drivers/infiniband/hw/hfi1/init.c | 194 +++++++++++++++-----------------------
 drivers/infiniband/hw/hfi1/pcie.c |  32 ++++---
 drivers/infiniband/sw/rdmavt/vt.c |   4 +-
 6 files changed, 108 insertions(+), 149 deletions(-)
---
base-commit: 5f9576c6734abca88a02db72c466e09d2eddf160
change-id: 20260707-clean-init-one-hfi1-e02835d239ad

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


