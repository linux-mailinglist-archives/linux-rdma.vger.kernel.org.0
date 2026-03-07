Return-Path: <linux-rdma+bounces-17681-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPnnHUhXrGnNowEAu9opvQ
	(envelope-from <linux-rdma+bounces-17681-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 17:50:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81622CB9C
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492933025702
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A932C94B;
	Sat,  7 Mar 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjH4Se18"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB7329E57;
	Sat,  7 Mar 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902205; cv=none; b=FuC2+x6PYtm1YKnRTWEXIwEjimt+5WQTJOwCuBvnPJ2VR0QFbu2gNQndtEUoHmLxOZ+ioobK+HzqMACxGucvilK+Wp0bG4PpBCrSD/3KxdeB6vJkUWB03FTgfIMCiQWlgN1LtxjuqfAhHFvrsFBS6k0C7Sqp3FKBpMiNsrcA+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902205; c=relaxed/simple;
	bh=NhYjs89oiB+jBKV/WkSpGD3/bAZw/xiURHFubpOufaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h8OMVD34OP1wN7rWZ335qQ5I+usCBCtMd0UziGZiVbsRQNWgmEUhJ5eyI2lYPKPTb2nmFyyhBoCtbvtHJDLx7Tgkai+NYnzngxNanoCBHZBQx8Sd49dmLA1YyZMO2xnTA+eyFwc7LUs4XZeG+LeV8/6TbMgBjSq7uw54rRdkXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjH4Se18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA98C19422;
	Sat,  7 Mar 2026 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772902205;
	bh=NhYjs89oiB+jBKV/WkSpGD3/bAZw/xiURHFubpOufaA=;
	h=From:To:Cc:Subject:Date:From;
	b=AjH4Se18sfvo0497Yw1VCVR+g0VtaRyMZAGqOl8RnF7y+kEKGz6UKUTYHQbFmYbZ2
	 r8JNQs6ed5mI5R3qGB+y4qk1hRv/+9IqDvqv0fDh4+NmcJoYHH+Oe+RX0eqqG2mK0q
	 oWWMEBu4PLBn1ya2mFqqWVeDGPj8A5Ac2YtK1N7hNVirZg4Xiwy6zHC38Ch6fQHNWy
	 mn7k2tXNYedKGiuPG+p7ivW5tp1Aav16fDufcjkNQVYohvKyLepgMkcGD1Rx6yBKQs
	 PUMAVozN7LFr7YFaaqkIUoywyLZDbjJUZoVJDqz0yx8D3AV64tvz9YRV+bS5e7PVd2
	 vrq60OPaMT4Pw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: [PATCH 0/3] RDMA: Enable runs with DMA debug enabled
Date: Sat,  7 Mar 2026 18:49:54 +0200
Message-ID: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260305-dma-debug-overlap-21487c3fa02c
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB81622CB9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17681-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.937];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Fix dma-debug to allow RDMA to run in that mode too.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (3):
      dma-debug: Allow multiple invocations of overlapping entries
      dma-mapping: Clarify valid conditions for CPU cache line overlap
      RDMA/umem: Tell DMA debug that cacheline overlap is expected

 Documentation/core-api/dma-attributes.rst | 26 ++++++++++++++++++--------
 drivers/infiniband/core/umem.c            |  2 +-
 drivers/virtio/virtio_ring.c              |  4 ++--
 include/linux/dma-mapping.h               |  8 ++++----
 kernel/dma/debug.c                        |  8 ++++----
 5 files changed, 29 insertions(+), 19 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260305-dma-debug-overlap-21487c3fa02c

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


