Return-Path: <linux-rdma+bounces-18207-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FING1ZVuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18207-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:09:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D028229F8A6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35163049524
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256C13EDADD;
	Mon, 16 Mar 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQIpRZVj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9743ED5B4;
	Mon, 16 Mar 2026 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688036; cv=none; b=iayDY6iz1AGqX8ZNihAF1vsPExq98Z9HuZi8GSgS7wjTYoZa6DM6r3Y2GrFlHqf8AxXJwCgm4LasjObkiMY0Kuxg7z6zSLjGiM8UInqCEmavtiAODqWSUHf+q39HGGcLaIsaSVbmBYvYn6npePrcSqSfiORyKVkegQBFmUOdf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688036; c=relaxed/simple;
	bh=Y7IxYgFPwpNVvKXeK9nR1uoDv1sEB/976av/0RuDIXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDDpzLOmC5FxKWuja+bHwZ1xqgIhsJjsBIs+adnGrYE+xm6Ji9dBg2OvZE11tfEKOKhiJb3Z6P5OWt/Oo1AkgPsyc3Kdy+z+MySBdNZRZlGXjEIHxHgMPBcFWToVzSkAoXf8hTwPgd91qZZ3hQXJuZE1RNYSW02CZvf/nWgyfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQIpRZVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486BAC19421;
	Mon, 16 Mar 2026 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688035;
	bh=Y7IxYgFPwpNVvKXeK9nR1uoDv1sEB/976av/0RuDIXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQIpRZVjrncGcv6d61BCi0UIP3qGV+iU9yUSpZ6PURLBwRW7JYFCHFMYWeHe4GRIf
	 67NzuI4t53eJ9xpRRZFfeEOPe8Es5onXjA3FLT+wVEbm5aWunQunwM+Wo9mlmv6XCQ
	 dBr7Hn4O/6PSBLZz3JYlNc+m6yvDDz4JU2hIZH2IXfM+TusARyzUz0q9S+VWzUShC3
	 oVxc482tMyBwhbuiiu2S/D5giAKlSCRt6DEryHmlrEhBu0hsfKZSE/9RgYFaICUi2p
	 p8wemyHg4PTBEkUgVHopxGVm2DagRESjBhEIyJPoPhx7ObOrygks54kKAjC4oMGbv1
	 +Bc4Q+rFSZQ5g==
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
Subject: [PATCH v3 2/8] dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
Date: Mon, 16 Mar 2026 21:06:46 +0200
Message-ID: <20260316-dma-debug-overlap-v3-2-1dde90a7f08b@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18207-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D028229F8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

Tracing prints decoded DMA attribute flags, but it does not yet
include the recently added DMA_ATTR_CPU_CACHE_CLEAN. Add support
for decoding and displaying this attribute in the trace output.

Fixes: 61868dc55a11 ("dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/trace/events/dma.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 33e99e792f1aa..69cb3805ee81c 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -32,7 +32,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
 		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
-		{ DMA_ATTR_MMIO, "MMIO" })
+		{ DMA_ATTR_MMIO, "MMIO" }, \
+		{ DMA_ATTR_CPU_CACHE_CLEAN, "CACHE_CLEAN" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,

-- 
2.53.0


