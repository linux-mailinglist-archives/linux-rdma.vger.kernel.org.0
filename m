Return-Path: <linux-rdma+bounces-18205-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHwtOOZUuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18205-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:07:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2429F83B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DFF73016EDA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63463E8C52;
	Mon, 16 Mar 2026 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWmygqKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2363EE1F0;
	Mon, 16 Mar 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688028; cv=none; b=oc05SLCAc6djfWGvKkaLLfF8FF4Wwtuitn4lUpZLqYweNRNBiRx6CZiM4tCkk6g4Bn3vtOwog/99q2x4dCEgh2P0Us0E7bD/aitkeAk6QW+6lF39Lpc2oodrALAWNknaNedalkl4LW/S9BEdi4yoBJVBA8t8tnOKWZVsNcvFCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688028; c=relaxed/simple;
	bh=BSXcvjYYI+K8eMOu0kcX0bUqyqggIH8za3wTFUV/fRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rgLeU2T5JUlGowN1nm3f9CamEEMqDTnr1kwLY6vcUihX7l2yqlamTnjX7Q3hBz4svTBxa9v45Y2L1wtDLtiYrwbjz8N5FWKCvIEWc8xuihUbzdp2vFgg317vRiw/JGhaXK37dXAkjc6UwoRA3B/QNqu/V9xYu94I4Y/LkK38uRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWmygqKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25585C19421;
	Mon, 16 Mar 2026 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688027;
	bh=BSXcvjYYI+K8eMOu0kcX0bUqyqggIH8za3wTFUV/fRI=;
	h=From:To:Cc:Subject:Date:From;
	b=MWmygqKMf5IukIzyE0mKREyeicovCoeVR64iIVzD/t0+K7KBI5RvzMPxKz/LoHb7x
	 xOHXIZ35Rt6sF53pc0zOVPn3frwe6PNiz+hfwCDaysJ0ukJP5/95D+6yNtmBpk4Bbm
	 w6o1s8KKmA2UyWAdUnxBUfYwgJyG5hnjBpOjB8OK/7X3U3LXNz1h5XGezAtPbB3D79
	 eMEHi81CfmmIIyk96FzF+FY7i/uyjM1oGTs4oAYO9rXntJXyFZV3ez7eZpaJgqvH5M
	 uwSBnECwVz4eYc/YVKIJB8co//nPy4WwlgS8dBUToeWtn+SQS2G60403HC9Trukn0I
	 6IQCI2/vdISBg==
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
Subject: [PATCH v3 0/8] RDMA: Enable operation with DMA debug enabled
Date: Mon, 16 Mar 2026 21:06:44 +0200
Message-ID: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18205-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59C2429F83B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark
mappings that must run on a DMA‑coherent system. Such buffers cannot
use the SWIOTLB path, may overlap with CPU caches, and do not depend on
explicit cache flushing.

Mappings using this attribute are rejected on systems where cache
side‑effects could lead to data corruption, and therefore do not need
the cache‑overlap debugging logic. This series also includes fixes for
DMA_ATTR_CPU_CACHE_CLEAN handling.
Thanks.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v3:
- Enriched commit messages and documentation
- Added ROB tags
- Link to v2: https://patch.msgid.link/20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com

Changes in v2:
- Added DMA_ATTR_REQUIRE_COHERENT attribute
- Added HMM patch which needs this attribute as well
- Renamed DMA_ATTR_CPU_CACHE_CLEAN to be DMA_ATTR_DEBUGGING_IGNORE_CACHELINES
- Link to v1: https://patch.msgid.link/20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com

---
Leon Romanovsky (8):
      dma-debug: Allow multiple invocations of overlapping entries
      dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
      dma-mapping: Clarify valid conditions for CPU cache line overlap
      dma-mapping: Introduce DMA require coherency attribute
      dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
      iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
      RDMA/umem: Tell DMA mapping that UMEM requires coherency
      mm/hmm: Indicate that HMM requires DMA coherency

 Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
 drivers/infiniband/core/umem.c            |  5 ++--
 drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
 drivers/virtio/virtio_ring.c              | 10 ++++----
 include/linux/dma-mapping.h               | 15 ++++++++----
 include/trace/events/dma.h                |  4 +++-
 kernel/dma/debug.c                        |  9 ++++----
 kernel/dma/direct.h                       |  7 +++---
 kernel/dma/mapping.c                      |  6 +++++
 mm/hmm.c                                  |  4 ++--
 10 files changed, 86 insertions(+), 33 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260305-dma-debug-overlap-21487c3fa02c

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


