Return-Path: <linux-rdma+bounces-21924-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SlhLG1S0JWrsKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21924-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:11:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEAE651357
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="WXnG1/ja";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21924-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21924-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFEE6300DF45
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85019C54E;
	Sun,  7 Jun 2026 18:11:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4A31327D
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jun 2026 18:11:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855881; cv=pass; b=Ntw4w4vj2VWMPw21DSuzqhWAqan/Qe2kgwTCRVXpvaIQ/kYIIy3I3NsRtd7o8QXMcMSPE/4lS8qGiDCd8b76s3UwZMAQXk3MHpg5TFJUOVsToK4fhv8hFn7ph4D8jWu/ioxAdir2rNc1xFG3UCnGK5FPCR4V6s1fzrbN0m8y+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855881; c=relaxed/simple;
	bh=NsCwZGmg5H7s42g9hbQh/NsDLVrnqm9r9v4MIl+ABNQ=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unLwtMZTeioOfTJd/4Y2+UEvyVEOIQ2PSmQ/P9a5qPi+tv5rlMaDzBdQbZjCW2Wz9RShLt7yFGvRBiU0WxZ00xnXvuJxwu7txX0CZJkJg7qtMRwS9QYfea5pN6jEL8BERZrIUud6syVCFla4qTv77fPeVqfCi4j+S9HycTtICuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WXnG1/ja; arc=pass smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1828583f8f.0
        for <linux-rdma@vger.kernel.org>; Sun, 07 Jun 2026 11:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780855878; cv=none;
        d=google.com; s=arc-20240605;
        b=L1NoxGELFASYbZ55RFZUYR/uGvyRgoi2UsEpXm5H4wlPP3f3dIXiBBccbktgYSZYev
         ZgNsa9j/TWQ+OqI/xibIx2bUP0rgPZVeSoG8Z6O4jgblSFrH0acIoTWxpNL9NyGRPOi4
         WLtQ99D1i1q/XBsrTGvBtYFoZDmn6hu8cb053gsl6fsuCrEqIPbEaMQvIUmPSXtnyn7l
         Q/vCYwVk7Df0oSd61tfTGAHJ4B4rhEKRCpP91IBXF7Wc84jbNvzhe7vDzCZd67+CB1sz
         1nqjy3YymN0TfmPQWe1fM+MNy3eomWPwo5ABYf/cU+V8t+Gl6NSq+St7FeyhQxMvgR+0
         prxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=V2dxyk081x1MpYrLgdjAI7OK69gzCevFIsf/WudvfOk=;
        fh=Kcw5s5h5w8xcjKzujxw2pDkFc1Flj9ZRkOqv8omfnUA=;
        b=RZJL3jKIelF6GygEv7KEz6E9bUKAwXMkWY9o7l8X23VZ7KepsQ4W8bRWVWMgdLNaAA
         hlXuLFbc4p4sjLLJBuDiKv1pur5hhxYX/1AMGdt0MfFbmGJFLBgsNPXminG9qhJyL/EB
         7/cJBTI8Liko0R3Mc5YpNGVghnu4NiNjRW5cjUzs3LXXWqPA3W6buS/tRairuxEsQuwD
         JKVyzW+YtMXRKNToNHnSzQexOaHmoMDI7IgmJovhXU8oRUhzvfvzZ2Tnfncn4YPr3EJ4
         aUn4UJ0b96xVvRzlNq2oCx15TmqDYvl3vHV++Niat3OSAnEZcCMA4wjMm8F3KIDh6H9t
         hU6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780855878; x=1781460678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2dxyk081x1MpYrLgdjAI7OK69gzCevFIsf/WudvfOk=;
        b=WXnG1/jaSTaU+zTuFmMe80BqoDJr8Y3t9yYV3iWofBOyfhHZ9Am4WQZ6J39hasUiER
         /NLO1Qhfh3/df2zlXYLjqiw3KjYn8Vu1haK345fHFQ/wxRajWUacVkvr30w2+WeYKVD2
         sm9NpMajUCoRZM0E3AyMK+U8sCUFi16RUbhOHl9SagdVRKMubWYgssftpkaXGensekGK
         Xg6r3SlBWbBzkz2eqgImj4AVsuN+ZY9+Km4uWBtACpcnx9rUZ5KK3h5yT4bI41EOZmEy
         5GzQxcuSNYUv1oU0AaJjM6Zl0KYDTcwIcbHG8CuAyMG+A0VQATnqCZQm88xi1JZTWTNd
         04Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855878; x=1781460678;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2dxyk081x1MpYrLgdjAI7OK69gzCevFIsf/WudvfOk=;
        b=U4u09swG2w9P03ItZzghdQAysmRnKly/kGuo/n0Tjl4VJXb2BRuMV3X7leCDzbQmms
         LQN1d6BISl7Q++c6K84JS+iQybPe6EolWX+Yfi8IFicFoETldjqb1jyAWlWV3NRirTaI
         gTrKqhPDHNmGA/A2xh3ZkDTZMl33+8Oqsyr+e5L/UfRbVdGX4TLF9kueZa6DndmnwkIG
         rWDUmOXQkShalzA6K3Lv2AiubNvpmygNr7Ld8et0TL14h4f1+gOljUAtcG+WX3xN2qZr
         uCSDkBe2/ie0THqKDC5xs+DRQlID5C9kNR8uwjuTXHAHr8YCjB1uWm0A6Q65TjrwynLe
         mY2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Lqe/h7EM7+z65g/yNrr2QKyr0BuD1aFFBjlk3BAH1AIduWbx4bmDQ1+nChXoDZGZx2eFK3TtRmpJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YySDaOhm203XBT12TQZZ1wxNezER1zDM+w5IPwfhFBPUDW8kDlV
	FsUjAe910alnnbCz5Pz5hGKuqJSgn7Z/Sw4lG0u1fbMLUSkf5pWSnt2O39GheuwZ60Y6sNySigm
	7VqdYHkM/oVToygF94zSbGc3g8rbjIorBl3HPGBovKg==
X-Gm-Gg: Acq92OFOVXfJ/UC0TQcFkRg8PiKifzviuErAR5GV3w0Bw3QCFkG5nYCvPg9cNtTXdTH
	rqQ54ODMWgm+36Q80nle5wbiddqJXYezjSsJP41s13NaBAPwhsJE9vsqZ3fp0MNqwJSxebQJEk8
	RVzxvoCQk0kInnXrdEdGtEyve8R17PznKwT0qSQukoEx3tuUjlkMObfSbKtCZAouVQ9enBmahSG
	VCqo3wgybZsPT1f2XxaGbsH+WvA/xKG+wVkg+rdRs0tNC5rOGBEPpku/Fz0ld3MHOtoDEK1LGqz
	zlt81iIHbjFpNkbCXKhG2hpUYeo=
X-Received: by 2002:a05:6000:18a5:b0:460:1967:abed with SMTP id
 ffacd0b85a97d-4603063c55dmr18750198f8f.39.1780855877749; Sun, 07 Jun 2026
 11:11:17 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260606035722.83175-1-cel@kernel.org> <65a2cdb132b0c28e69a29955e3bd37e7@mail.gmail.com>
 <096a2b91-7a19-48da-a06a-dc60e7150956@app.fastmail.com>
In-Reply-To: <096a2b91-7a19-48da-a06a-dc60e7150956@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMa29E4u4Im5YIb7ViXmqyooY1UyQL8EEwvAkqTvJezjWPcAA==
Date: Sun, 7 Jun 2026 12:11:15 -0600
X-Gm-Features: AVVi8Cdu0VGe4NEPfyxatTz0Fl-QTK-ZRK4b4WC-NSjqjAgiAL9y3iGuEEgGWKc
Message-ID: <511ac3ff2c4bd019aa2670b2dd1bb0c8@mail.gmail.com>
Subject: RE: [PATCH] svcrdma: Cap Read sink allocations at PAGE_ALLOC_COSTLY_ORDER
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21924-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DEAE651357

> -----Original Message-----
> From: Chuck Lever <cel@kernel.org>
> Sent: Saturday, June 6, 2026 9:18 PM
> To: Jonathan Flynn <jonathan.flynn@hammerspace.com>; Mike Snitzer
> <snitzer@kernel.org>
> Cc: linux-nfs@vger.kernel.org; linux-rdma@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>
> Subject: Re: [PATCH] svcrdma: Cap Read sink allocations at
> PAGE_ALLOC_COSTLY_ORDER
>
>
>
> On Sat, Jun 6, 2026, at 1:35 PM, Jonathan Flynn wrote:
> > I tested the PAGE_ALLOC_COSTLY_ORDER change on the same setup.
> > Unfortunately, it did not improve the regression. Throughput was
> > slightly worse than the previous GFP_NOWAIT test, measuring 25.4
GiB/s.
> >
> > Current results are:
> > Original regressed build: ~30.3 GiB/s
> > GFP_NOWAIT build: ~31.0 GiB/s
> > PAGE_ALLOC_COSTLY_ORDER: 25.4 GiB/s
> > Commit reverted: ~73.9 GiB/s
> >
> > I added the results to the shared bundle. (including flamegraph)
> >
> > The GFP_NOWAIT and the Original Commit flamegraphs are nearly
> identical.
> > The dominant stack being:
> > svc_recv()
> > -> svc_rdma_build_read_segment_contig()
> > -> alloc_pages_noprof()
> > -> get_page_from_freelist()
> > -> rmqueue_buddy()
> >
> > The PAGE_ALLOC_COSTLY_ORDER flamegraph is different. Time spent under
> > alloc_pages_noprof() is reduced, but the reduction does not translate
> > into improved throughput.
> >
> > The following percentages were observed:
> >                                                    Original
GFP_NOWAIT
> > COSTLY_ORDER
> > svc_recv()                                 76.09%      75.99%
> > 78.44%
> > alloc_pages_noprof()             58.07%      57.99%
40.29%
> > folios_put_refs()                        7.15%        7.19%
> > 16.06%
> > svc_rdma_read_complete()    7.18%        7.21%               16.08%
> >
> > In other words, the PAGE_ALLOC_COSTLY_ORDER change reduces time
> spent
> > in the allocation path, but a larger fraction of CPU time then appears
> > under
> > svc_rdma_read_complete() and folios_put_refs(), while overall
> > throughput decreases further.
>
> The two failed fixes demonstrate that the current folio allocator is not
up to
> the task -- the problem appears to be on the release side, where the
> individual pages have to be merged back into an order-4 compound page. I
> don't yet see a straightforward way to make it work.
>
> Since we're right up against v7.1-rc7, I've added a patch to nfsd-next
to revert
> 18755b8c2f24 -- it will get pulled back into 7.1.y as soon as the v7.2
merge
> window closes in three weeks.
>
>
> --
> Chuck Lever


This sounds good.

Thank you for taking the time to investigate it and for working through
the test results with us.

If you continue exploring this area in the future and still see promise in
the contiguous allocation approach, I'd be happy to help test additional
changes as time permits.

-Jon

