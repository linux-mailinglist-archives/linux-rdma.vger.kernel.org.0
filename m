Return-Path: <linux-rdma+bounces-22879-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Gw9FforTmoiEgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22879-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:52:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D513E72488A
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:52:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SxgLZ64n;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22879-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22879-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F5DF3025883
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81542848F;
	Wed,  8 Jul 2026 10:46:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FE3F4DE7;
	Wed,  8 Jul 2026 10:46:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507604; cv=none; b=l6YAHiwUkDZbVSHbfE1ut+uynMz4BIQ9KUc0/ZvRJf1bdBPsAkhqz+al1njg3Ro1766Wn7GN1k1VlBRyOd5i6RSFfBWu8LxkgvuXdjTcg069+UcOHl8E412mKuzzItyZCY2NgU2Q8Oe2iOSSU5SoDLB13jJ4iXcYHokeJGjadUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507604; c=relaxed/simple;
	bh=SIkVnsrF37UFvEE2T1hyUULY/RT1TlVLVlxcz/s9DQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLY6rlSkdBp8q6+jj8iy0DTrTCzZ8AF5xeAHkdkDtJXLrt7+3HAm33CmSfaROWzhVMuF1P9M/Pn+e688O/hLNAJ2NtitoUBvwyPb6VkyVok7OIAlWWkvgEzvLLTyO+rc10yuWQZs728fOLYGr+wn36hWUff9SoumuYSfqyaq2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxgLZ64n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F64B1F00A3A;
	Wed,  8 Jul 2026 10:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507589;
	bh=1n4AdS8vEoszlVzUktAfAp0DGIlgAbsYbugaArfNbuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SxgLZ64nlgSJzr9pqPoSXPcfO4z86XWn2kWZZ9oXTRpM1DgkDFIPtrtEfYNUbYzhi
	 dFHRkicGIUEsq/JGU7FgJmYCiGE1IzAwzZ1magKc7noFb3nt+eZK+OZZDgKETuPvi/
	 dETdfpTQriO0nlfmSoX1RghCSpIninI+DinuYjLJkyy2ULFUbaoX5kQXg1XSL9qKwv
	 NumYMKSCsQ7H5RPq6IvuUvPjptN7bRGlEsZhn/4E0gCj+RobGigARvnztytT2VGRth
	 +D0LV5Qy6l0lpOo8ep53i1Z36ANikZF9zQLIFXbtuKhilHC4WecRhEQP49y5/WeiMM
	 JvY+eQvQCDfOw==
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
Subject: [PATCH rdma-next 02/13] RDMA/hfi1: Preserve unit 0 on allocation failure
Date: Wed,  8 Jul 2026 13:45:40 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-2-b9e9641268a5@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22879-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D513E72488A

From: Leon Romanovsky <leonro@nvidia.com>

hfi1_free_devdata() assumes that the device was inserted into the unit
table and unconditionally erases dd->unit. If xa_alloc_irq() fails, the
zero-initialized unit remains zero, so full cleanup can remove an
unrelated device from index 0.

Release only the rdmavt allocation and return immediately while the unit
table has not acquired the device.

Fixes: 03b92789e5cf ("hfi1: Convert hfi1_unit_table to XArray")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index b7fd8b1fbbbd..3a408399f9ab 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1225,8 +1225,9 @@ static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
 			GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
-			"Could not allocate unit ID: error %d\n", -ret);
-		goto bail;
+			"Could not allocate unit ID: error %pe\n", ERR_PTR(ret));
+		rvt_dealloc_device(&dd->verbs_dev.rdi);
+		return ERR_PTR(ret);
 	}
 
 	/*

-- 
2.54.0


