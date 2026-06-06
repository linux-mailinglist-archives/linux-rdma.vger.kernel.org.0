Return-Path: <linux-rdma+bounces-21903-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +pfYC4daJGpw5gEAu9opvQ
	(envelope-from <linux-rdma+bounces-21903-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 19:36:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E864DF80
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 19:36:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=TMOTRTXF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21903-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21903-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D98CB300293F
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B85378D78;
	Sat,  6 Jun 2026 17:35:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FB2E7388
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 17:35:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767357; cv=pass; b=A8hlkR1D0oX4QQFJ2MGy4B+ZWJkw5m/3VbHOIsAFeWwAuEfLlTQCvpz7L1+RXeHaegOc/tVFMHsbcZrIJSpAI0/WxXAoX6xwk/lipaTdCNrNawNkZ+v2kjVyZHyuHYjKNV/4hl2QKkOEY9lfDrjL7wsT8iMZDBKiqasMDCvMoVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767357; c=relaxed/simple;
	bh=kaIOlM2dR399VfkohKkulIGjRFRv1YLOvYZvYkxuEv4=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSCJL55hHmY+fZ7IRPZ8LiM42t57Bw6bEljMb3xKgBFqM1MPoK02/hFatXEBn2jPvnF2JqIk69vbLJ+nnDeZlDeBKaG/bZJ2sEWajjxf/ba73joGE35x0zNcgkLM+5Y7+pBepJZ2OyI3/fbS57kLj2R3GlsNkz/j6SDLpugZ830=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TMOTRTXF; arc=pass smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso34315375e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 06 Jun 2026 10:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780767354; cv=none;
        d=google.com; s=arc-20240605;
        b=VBak3Mb/+RTRpVa6w04o5vOHJO98roeFVmGtz9K5jsMO+YIclB62sv5vXOtuWm0aJQ
         UinRbq0SVtIJ165YRUyP3OT+MKGoLUKibh/M5fQmFALkOudkTGR/hSWPK7A2zdEKUqyg
         khn/FkfAAsWdTtayxcyI2FoErxvlyCVBeFDgswDy7/ArwB/COxiy0RnikpFguPfPbb2i
         Cgc78fYpYXTqaSZoZN+aa2obSxqbBJdfIz0AtbbWj7ofRDa0GDLDBCJIc4bbUtAyzTgf
         QW9mUjG86TcLLPFGOhovtusQ3H9arDaOvpOVodODr3pR+zmC9PSXEqtCDKVFCXn+nmIg
         7F3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=Hppu2DGhG4EZwt2QnaFLsyyEt3kmcDDCj2adKDQrCl4=;
        fh=XsEfyrBfc3YWARwOcqkt6dOnJkmaMGrxVypspOcym5M=;
        b=Q400BO4kakvhzpnE9BynwiduoLy1c2+I5XJrOAuViojNZ7hYK91mbDccvj9EP6teD0
         gFPP2+9jUt0nC3siCztM764FuoALFzb7SWA7L7Z5N/vbx8Rb2m0WPKKWmn6j7Bd0ek89
         cUu9EesVqei8fFYNKAGCg0TbaqQVGlrzcQATZEK0EsY0GNDlch1VuJfj2IAXtvGNSxfE
         /X8N3lwG4NHJY0ZJdtVnNyoGguFnQvZNNQilHp6bpk0Nkxi2uMmJ1FtTD2c3/l5oGsa6
         Wch/5nw5p3qoGx6gGLsm8jg6uztw19N9uxY9btaScgjDYXbW/913HiGqCrqA1OqaVwyD
         9I6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780767354; x=1781372154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hppu2DGhG4EZwt2QnaFLsyyEt3kmcDDCj2adKDQrCl4=;
        b=TMOTRTXFD/GN1jg5cEc55ASv/xygFpFonwc7TEeuAnBgHV3VtNeRTnVtzD2UTN6vli
         oZA7U5IxuhVmIN/QpASUBZRwsyGu8bVGwti0B7cMRoCNn2TKbblNkE+lOuTefwLcM1Uf
         TfaGALGyQwLS7STQbmB1Zys8ajSV29qeVAJwXn6qcFt//lylEnXcdWrQq/b81fFy6tam
         1TBX0qCLvmiYMzFFl4fNM5luaBFYckyYFUr7ZP1D0SVc4Uwfx32kUei4W/ZCOrCb3NZ0
         Ri/p4bz6ICkwWwmxTRDTCzun5/7l6XKAJ2BXvk+Jj9hEfxt6MYfEHY5DKS8NQ4Vw8avP
         8TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780767354; x=1781372154;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hppu2DGhG4EZwt2QnaFLsyyEt3kmcDDCj2adKDQrCl4=;
        b=EVLNs89rHqyhONJCPmr6yovxIZ9V6rPWgG4bIlp7+H9oquatbu8yCSI/LW1q834a8d
         PH/Gnn/T4PBfQtYfZVdUzwJtMIvo4YVSrGugGZvjGmMZRYqe0KkgRaBo938Ctc5592Kh
         kl1titGaPBSi5OIXYJHmzBC0LUPKjsNoqoq1OKjShreH7dki/8EpBHkywAti1k8ZRJSU
         LPgshrHz76XF53myYbd3ViWjYc1l6TgzqudYSS3EFrHlfpT1UFxWEjQK3/qVP1UhbH/x
         zgvfiru6bremUjdGHC1zq3cjye2MzHvICbZdH0rkfMhOZeOfNFmkru/0WMLtwUJV8x72
         ImRg==
X-Forwarded-Encrypted: i=1; AFNElJ+GMj+1m5duWa16o0ngk1tVBa8fKpXuJCkWKQO9cmLEhQCXZ8nfk42s8afb816l59yt7Q7BgSguJvg7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gME8xz0E3NSDQTb8yyJj+VA/kGPCVMrFgRwl9iMuJT9JFEID
	gPWV7rYPriNIKrMonnL2QFaAEqEq27G1Bu6cSyFdP5bz6vzNis0tSJ348segAYp2NPMX6kCYjxk
	6OraBbLMGanmGSLq5VIwdZ1eREBVpg7YZN5FtNwqg9A==
X-Gm-Gg: Acq92OH7x622WV5M8SxvZsmhLzZ2rSamY1nr/eoapjLcKurdajZWb3yqx/Ai6G9V9XH
	PzuyK/UeAHnjo2UqwkFrWCBNsZeq33hSKQh4cNg+tnzcJjJYDJPqqrwZ81iWQD/pMbfh+vWHXzP
	zN1XeS9vCu5RL/VEkEKrV9ml1s90UJsY2GgGLepUfZqP4h7/Y7PC/P3AyDw0YeyZCbdsoHP055J
	CKgUZh5Fh4CA00Noy5qQ+jW0Gc1fvb5ZkMNRJYG3wPnINpRjTm6NHF98yRXRZHmAMF2yt3qYUKA
	ZHTf7LVYfoSiP6ug
X-Received: by 2002:a05:600c:4fc6:b0:490:b432:6f1e with SMTP id
 5b1f17b1804b1-490c2614bf9mr144449255e9.33.1780767353362; Sat, 06 Jun 2026
 10:35:53 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260606035722.83175-1-cel@kernel.org>
In-Reply-To: <20260606035722.83175-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMa29E4u4Im5YIb7ViXmqyooY1UybO1/K8Q
Date: Sat, 6 Jun 2026 11:35:51 -0600
X-Gm-Features: AVVi8Cez9uncDsFw8DZPkODWXV4aG8-aKGtQeYnLtb6-RB7MYGS0NV-SQUjhB-Q
Message-ID: <65a2cdb132b0c28e69a29955e3bd37e7@mail.gmail.com>
Subject: RE: [PATCH] svcrdma: Cap Read sink allocations at PAGE_ALLOC_COSTLY_ORDER
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21903-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A8E864DF80

I tested the PAGE_ALLOC_COSTLY_ORDER change on the same setup.
Unfortunately, it did not improve the regression. Throughput was slightly
worse than the previous GFP_NOWAIT test, measuring 25.4 GiB/s.

Current results are:
Original regressed build: ~30.3 GiB/s
GFP_NOWAIT build: ~31.0 GiB/s
PAGE_ALLOC_COSTLY_ORDER: 25.4 GiB/s
Commit reverted: ~73.9 GiB/s

I added the results to the shared bundle. (including flamegraph)

The GFP_NOWAIT and the Original Commit flamegraphs are nearly identical.
The dominant stack being:
svc_recv()
-> svc_rdma_build_read_segment_contig()
-> alloc_pages_noprof()
-> get_page_from_freelist()
-> rmqueue_buddy()

The PAGE_ALLOC_COSTLY_ORDER flamegraph is different. Time spent under
alloc_pages_noprof() is reduced, but the reduction does not translate into
improved throughput.

The following percentages were observed:
                                                   Original     GFP_NOWAIT
COSTLY_ORDER
svc_recv()                                 76.09%      75.99%
78.44%
alloc_pages_noprof()             58.07%      57.99%               40.29%
folios_put_refs()                        7.15%        7.19%
16.06%
svc_rdma_read_complete()    7.18%        7.21%               16.08%

In other words, the PAGE_ALLOC_COSTLY_ORDER change reduces time spent in
the allocation path, but a larger fraction of CPU time then appears under
svc_rdma_read_complete() and folios_put_refs(), while overall throughput
decreases further.

-Jon

> -----Original Message-----
> From: Chuck Lever <cel@kernel.org>
> Sent: Friday, June 5, 2026 9:57 PM
> To: Mike Snitzer <snitzer@kernel.org>
> Cc: linux-nfs@vger.kernel.org; linux-rdma@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>; Jonathan Flynn
> <jonathan.flynn@hammerspace.com>
> Subject: [PATCH] svcrdma: Cap Read sink allocations at
> PAGE_ALLOC_COSTLY_ORDER
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Jonathan Flynn reports that commit 18755b8c2f24 ("svcrdma: Use
contiguous
> pages for RDMA Read sink buffers") regresses NFS/RDMA WRITE throughput
> from 73.9 GiB/s to 30.3 GiB/s on a 128-core single-NUMA-node server
driving
> dual 400Gb/s links with 640 nfsd threads. In the regressed
configuration,
> server CPU utilization rises from 8.5% to 76%, and 73% of all server CPU
cycles
> are spent in native_queued_spin_lock_slowpath.
>
> The contended lock is zone->lock. The page allocator serves allocations
only
> up to PAGE_ALLOC_COSTLY_ORDER (3) from its per-CPU page lists;
> SVC_RDMA_CONTIG_MAX_ORDER is 4, so every contiguous sink buffer
> allocation falls through to rmqueue_buddy() and acquires the zone lock.
The
> workload above issues roughly half a million order-4 allocations per
second,
> all serialized on the single zone lock of the one NUMA node. Replacing
the
> GFP mask with GFP_NOWAIT did not change the profile because direct
> reclaim never
> ran: the cycles are spent acquiring the lock, not reclaiming memory.
>
> Cap the allocation order at PAGE_ALLOC_COSTLY_ORDER so contiguous sink
> buffer allocations remain eligible for the per-CPU page lists, where
zone lock
> acquisition is amortized across pcp batch refills. An order-3 chunk
still
> replaces eight per-page bvecs with one.
>
> Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
> Fixes: 18755b8c2f24 ("svcrdma: Use contiguous pages for RDMA Read sink
> buffers")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> index efde26cac961..4546e594f2d7 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -746,11 +746,12 @@ int svc_rdma_prepare_reply_chunk(struct
> svcxprt_rdma *rdma,  }
>
>  /*
> - * Cap contiguous RDMA Read sink allocations at order-4. Higher orders
risk
> - * allocation failure under GFP_NOWAIT, which would negate the benefit
of
> - * the contiguous fast path.
> + * Cap contiguous RDMA Read sink allocations at
> PAGE_ALLOC_COSTLY_ORDER.
> + * The page allocator serves allocations at or below that order from
> + * its per-CPU page lists; above it, every allocation acquires the
> + * zone lock, which serializes all nfsd threads.
>   */
> -#define SVC_RDMA_CONTIG_MAX_ORDER	4
> +#define SVC_RDMA_CONTIG_MAX_ORDER	PAGE_ALLOC_COSTLY_ORDER
>
>  /**
>   * svc_rdma_alloc_read_pages - Allocate physically contiguous pages
> --
> 2.54.0

