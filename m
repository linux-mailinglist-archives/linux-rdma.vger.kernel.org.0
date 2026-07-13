Return-Path: <linux-rdma+bounces-23085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JMQKDpWSVGplngMAu9opvQ
	(envelope-from <linux-rdma+bounces-23085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:24:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2757480B1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="he5Tv/j7";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23085-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23085-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B663029ACE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E214F70;
	Mon, 13 Jul 2026 07:17:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0B35A3BF;
	Mon, 13 Jul 2026 07:17:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927048; cv=none; b=O/Sy4TYnZ/DP2WPl6ItXW0zt/8JQfY57gHnFrJhmGBUx7H8u+P5k+EIGFD7p0nnElZj8Hg7R88dbTWvYN/HhN5OMp/J51gGdGEa7hJmFZPRUHIemntAxAmoyyfrbpc7xbCuVZVLxeXwUUPlTApfV5nc0zmH7DCs/ca8STemZLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927048; c=relaxed/simple;
	bh=3aMpVNkIfCpNjyvsoQXjAGPkKSP0K1S4+Hi4PRHTbec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tG0dvpx7z/ZUPpzGGjJLIOmHvEsL/fnywhTT+/HWYQe80QmSMGDBrihHrPYxwIokgE+phw2fteVRks/gaMsA6ST1Jkcn+Uvt2mTL8zR64CM2kjNvU+ogkq1nW2rZQNcis/LO5BRgtjmBtOaPB9HL5K2Hx9JOsnZf7qTI3z0llSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he5Tv/j7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BCB1F000E9;
	Mon, 13 Jul 2026 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927046;
	bh=fwA5EpywXnBLHbH1Cr7rvC6VIBFsJ89S1zKzZ9uxu9I=;
	h=From:Subject:Date:To:Cc;
	b=he5Tv/j7cf3zzOFF47BF5dVhJt/X5kCa24N3c52eT8BHbY1t0kZ4lsYFZbV9vUrhx
	 AZvs71m9CxHplrEPXkiso3D1O4Rmy+cU8viW9XHnJsbrrbOyqIjdn+rFAw7A+h7PMb
	 TKUHscFL/5MvI6sFQFSc/yeudYs3k8SLDfuYsg2lxDUcUrFMTpZ2wMaZepgCa/uXvx
	 jKwUpdXiZ6NLweDj9z8bjCYNyN3AEPOqievSC5pB7aTB+ceLStoBEqdCP1k6BzH0Ju
	 lbGrgl6zuqLu1YCxoIXEo/CxNSZEncKtqEpGGqZONcJwBKnzMTSPfhQNeNPXmiwpbe
	 Dy1O+vMvMTxzQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/5] RDMA, IB: replace __get_free_pages() with kmalloc()
Date: Mon, 13 Jul 2026 10:17:21 +0300
Message-Id: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGRVGoC/0WOyw6CMBBFf4V07Zh2rE1w5X8YFm0ZoD4KmSLRE
 P5diiYuz819zSIRB0riVMyCaQop9HEF3BXCdza2BKFeWaBEI42S4DRw/bCgtcFjidiQMmJ1D0x
 NeG1Nl+rL6emu5Mcczw5nE4FjG32XpYxZ7kIae35vDyaV47+xw39sUiDBOo3ON7KmEs834kj3f
 c+tqJZl+QByGhutyAAAAA==
X-Change-ID: 20260610-b4-rdma-44625922fe16
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23085-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:rppt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C2757480B1

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/rdma

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 

---
v2 changes:
* add comment to keep markers for sites that need "fast and as large as
  possible" allocation helper

v1: https://patch.msgid.link/20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org

---
Mike Rapoport (Microsoft) (5):
      RDMA/umem: ib_umem_get(): use kmalloc() to allocate page array
      RDMA/mlx5: replace __get_free_page() with kmalloc()
      IB/mthca: mthca_reg_user_mr(): use kmalloc() to allocate addresses array
      IB/mthca: allocate mthca_array memory with kzalloc()
      IB/rdmavt: use kzalloc() to allocate QPN-map pages

 drivers/infiniband/core/umem.c                | 5 +++--
 drivers/infiniband/hw/mlx5/odp.c              | 6 ++++--
 drivers/infiniband/hw/mthca/mthca_allocator.c | 6 +++---
 drivers/infiniband/hw/mthca/mthca_provider.c  | 5 +++--
 drivers/infiniband/sw/rdmavt/qp.c             | 8 ++++----
 5 files changed, 17 insertions(+), 13 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260610-b4-rdma-44625922fe16

--
Sincerely yours,
Mike.


