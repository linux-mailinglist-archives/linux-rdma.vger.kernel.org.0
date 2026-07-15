Return-Path: <linux-rdma+bounces-23274-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vzD8DQtpV2qDMwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23274-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:03:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C70B75D448
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZT3NwXFh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23274-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23274-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85828300F26C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC3423EA7;
	Wed, 15 Jul 2026 11:03:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FC2931D7;
	Wed, 15 Jul 2026 11:03:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113404; cv=none; b=gZL7g4KcnqLRjofq9oYXZr6N62g8Rin3OUg74MPZc7yJhp/MlLdnj8PgKR3ogo3/3NkptZ+2P2HBjvxCPUmBtoz6oFzDzz3L283KYkK/9iuL3wIf8wXMG/5AyPZZpmq033/Q+VdWT8W/rWhfflv2Acxj1iVwdIxBzbrnxKk/cAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113404; c=relaxed/simple;
	bh=/BdL2GdqmmuQJc6XwqHfslwjJuI/zwzwUFcf5QOwiA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wesg/k9bsV2852YkBWTJNCR4JwCHzlJUjL6v1M+nY9942eNhrmNPrTMBwxmnPbi4fIXQvuwahsMBsRKg/TZzggw5KKUW/XD1aFgZCzbQ7V9ZML4CAWbYGm6/ArIMPDCxg4YANGfwVQSYRHetPMEiHk3gb1U3jQReQcMz/LmsYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT3NwXFh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898911F000E9;
	Wed, 15 Jul 2026 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113402;
	bh=DUu0AwG90AaRxrH2GEjGVf9+wVO5GoWg2E/q2g7TGv4=;
	h=From:To:Cc:Subject:Date;
	b=ZT3NwXFhfc34+ushvad6IE3yVD/l4ytXkwcLI3uxwB3Rp1oJQyUoIiOcBFLo2qzjg
	 GJUZOyBB0iISiEAqPrCN/OPc0J6sLZq/N/QgZ4WHBQ339VePOoGng2KyE7ynJlQt65
	 fHosFDYOco1JOTAJiyjBhwdYcgoPGP1VN9P5s0tV9Xwy/XVaqPmxD3nNat6zkB6/AC
	 XdqupT5J7tqneJjWdgB5NyvG1Ir08PiiAKLFC0K7Jp6Z6sgNUVf2F9KtSmlX2O7L1X
	 4+8s4sekleGVQdWx4Wks2gGu/aIbB7oIqwKwGmshBj1Zoh8AxYNHND6N52KoF35rMp
	 g/2H+aV9skjnA==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH rdma-next 0/4] RDMA: use kmalloc() for remaining scratch buffers
Date: Wed, 15 Jul 2026 14:03:08 +0300
Message-ID: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260715-get_pages-to-kmalloc-fff6f623114e
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:jgg@ziepe.ca,m:yishaih@nvidia.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23274-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C70B75D448

The series [PATCH v2 0/5] RDMA, IB: replace __get_free_pages() with
kmalloc() [1] replaced direct page allocator use in RDMA buffers that
have no page-specific requirements. Continue that cleanup for the remaining
scratch buffers in cxgb4, mlx4, usnic and mlx5.

Use kmalloc() or kzalloc() to retain the existing physically contiguous
storage and alignment while avoiding casts and allowing kfree() to derive
the allocation size. The mlx5 patch converts every allocation tier in the
shared UMR buffer allocator so its cleanup path does not mix allocator
families.

Allocations in qedr, cxgb4 and bnxt_re that back userspace mappings are
intentionally unchanged. Those buffers are passed to vm_insert_page() or
io_remap_pfn_range() and must remain individual page allocations rather
than slab pages.

[1] https://lore.kernel.org/all/20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org/

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (4):
      RDMA/cxgb4: use kmalloc() for the PBL address array
      RDMA/mlx4: use kzalloc() for the fast registration page list
      RDMA/usnic: use kmalloc() for the page pointer array
      RDMA/mlx5: use kmalloc() for UMR translation buffers

 drivers/infiniband/hw/cxgb4/mem.c        |  4 ++--
 drivers/infiniband/hw/mlx4/mr.c          |  6 +++---
 drivers/infiniband/hw/mlx5/main.c        |  8 ++++----
 drivers/infiniband/hw/mlx5/umr.c         | 11 +++++------
 drivers/infiniband/hw/usnic/usnic_uiom.c |  4 ++--
 5 files changed, 16 insertions(+), 17 deletions(-)
---
base-commit: e952e079d226209a132110acc1de96a099701292
change-id: 20260715-get_pages-to-kmalloc-fff6f623114e

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


