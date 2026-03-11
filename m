Return-Path: <linux-rdma+bounces-18014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOriEpq+sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:12:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DD12691D1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E665323E00E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29333603FE;
	Wed, 11 Mar 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb4QW1PQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796363358CF;
	Wed, 11 Mar 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256138; cv=none; b=HZuJdOURAozHKg00jdsb3uTqMJUmTZp3RV92CgG0vcMzfopTe2vq23MBld8kJxB7XyIsTb0L66sR5dCJydZPcYnCNO/9qmdra8BhKV0CpDl7bUb61fhSL1P6aVIWNNRzbke6NySSks/OlHCPJnvHosfGr2Zd9hqXqUj/rER9CUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256138; c=relaxed/simple;
	bh=f7E3DQ4/Vk970iebVcsUS/bkixZlPLpqM/qiyDK5W3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VxJJu1QMMfMtj7erraEjoNooB09hPscwXqvBE6Kg7N+P+Hd2Yqk1s6VaG6NKaVh3RFya49SS1xC7tKuzKvWX2/V8Eq4Yts/tOV+dxirDov4d/flwJbM1gpyWvOFNJHalTYJaGClxTX0d/s1n1saHHW8aBTX4AJLUtXNDEsrKyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb4QW1PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851B1C4CEF7;
	Wed, 11 Mar 2026 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256138;
	bh=f7E3DQ4/Vk970iebVcsUS/bkixZlPLpqM/qiyDK5W3U=;
	h=From:To:Cc:Subject:Date:From;
	b=Nb4QW1PQGCc2fuhrBudNL68gub3pnJT1NUoZY20WoiF06/aAWkB0JKBldKjUQbcRt
	 nDYj2YYMWFjAY7olA0WlQoBI4NSNuyOjPJ75Bz2oxkhP7am4qxvXzeWiyyVH5vDH9r
	 lKR1FEnE1nYADxDgwgP14Z9yf6E+MVHsrijqzElNoggbAPxZnGB6pg8vPdFIMuz5Yw
	 UtnoyNdW4/fqY7gaYkOX/Az/87C7pEWxS/GBeDwt/47J8Ba4kioTIIzhXOgywbmIZC
	 bQCr8sOvI70l79lbyysrSMvTOR5WpM0ykLLg2lpiCyxRInx7Lq0qFAoFt/Z8C3Uuzm
	 1U2j29BEVTnHA==
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
	Leon Romanovsky <leon@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/8] RDMA: Enable operation with DMA debug enabled
Date: Wed, 11 Mar 2026 21:08:43 +0200
Message-ID: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-18014-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3DD12691D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark=0D
mappings that must run on a DMA=E2=80=91coherent system. Such buffers canno=
t=0D
use the SWIOTLB path, may overlap with CPU caches, and do not depend on=0D
explicit cache flushing.=0D
=0D
Mappings using this attribute are rejected on systems where cache=0D
side=E2=80=91effects could lead to data corruption, and therefore do not ne=
ed=0D
the cache=E2=80=91overlap debugging logic. This series also includes fixes =
for=0D
DMA_ATTR_CPU_CACHE_CLEAN handling.=0D
Thanks.=0D
=0D
---=0D
Changes in v2:=0D
- Added DMA_ATTR_REQUIRE_COHERENT attribute=0D
- Added HMM patch which needs this attribute as well=0D
- Renamed DMA_ATTR_CPU_CACHE_CLEAN to be DMA_ATTR_DEBUGGING_IGNORE_CACHELIN=
ES=0D
- Link to v1: https://patch.msgid.link/20260307-dma-debug-overlap-v1-0-c034=
c38872af@nvidia.com=0D
=0D
---=0D
Leon Romanovsky (8):=0D
      dma-debug: Allow multiple invocations of overlapping entries=0D
      dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output=0D
      dma-mapping: Clarify valid conditions for CPU cache line overlap=0D
      dma-mapping: Introduce DMA require coherency attribute=0D
      dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is se=
t=0D
      iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute=0D
      RDMA/umem: Tell DMA mapping that UMEM requires coherency=0D
      mm/hmm: Indicate that HMM requires DMA coherency=0D
=0D
 Documentation/core-api/dma-attributes.rst | 34 +++++++++++++++++++++++----=
----=0D
 drivers/infiniband/core/umem.c            |  5 +++--=0D
 drivers/iommu/dma-iommu.c                 | 21 +++++++++++++++----=0D
 drivers/virtio/virtio_ring.c              | 10 ++++-----=0D
 include/linux/dma-mapping.h               | 15 ++++++++++----=0D
 include/trace/events/dma.h                |  4 +++-=0D
 kernel/dma/debug.c                        |  9 ++++----=0D
 kernel/dma/direct.h                       |  7 ++++---=0D
 kernel/dma/mapping.c                      |  6 ++++++=0D
 mm/hmm.c                                  |  4 ++--=0D
 10 files changed, 82 insertions(+), 33 deletions(-)=0D
---=0D
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808=0D
change-id: 20260305-dma-debug-overlap-21487c3fa02c=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

