Return-Path: <linux-rdma+bounces-21657-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zzqfL+1aH2r4kwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21657-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 00:36:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE746327C2
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 00:36:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=emMgrcx4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21657-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21657-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C5243008C81
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C43C062C;
	Tue,  2 Jun 2026 22:31:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE603C769B
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 22:31:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439517; cv=pass; b=kWi1o79R0S6E8nm/sR9J623wOriRZ7E+sMpmVeR4vhX5y2EQmQvhENbJiMTGZIgUzNPTNb5/XfNQaGD7B6RJTi8lgbMsTugRp55UFRYBheGaKbZcMexuYtARgLnHTJax4ek3sK+pr/EsTM+ltNMHJSF956IBHpWHqxh8E1fVgqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439517; c=relaxed/simple;
	bh=F8hTP47ikKsPAHLkN0/ccW56UYyMMfZo9RM12hPsVNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJrv9ObSUQg3qVIdlyumr8p5tFDFDHQF+Ca7Bm6rU95U3rV1Ug/d+lscZan+YWp5wbj6G6uSVyCsqSqsYWcPYyQftORM9ur7i3QFfglI7HhcPzdh5q974OfoLBRkwetMzD5sEOpU1s1t+BIXpOOn19pRBGFeBmQ++dm18OOqQQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emMgrcx4; arc=pass smtp.client-ip=209.85.160.52
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43d08bc82deso1718568fac.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 15:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780439515; cv=none;
        d=google.com; s=arc-20240605;
        b=HV+suua6n0XOAw6QzejgDAuH1Bee4ZwyUxzs5FDK+jIhN5aa62a2Xf+DJJuDrI3Sjp
         h6gtxiL7gQZDVLm2Hi99PZAY8m3TNhFuQitEy9gZVGZWtibybksEK7HcjMmLLv18LhbZ
         yCDgHn28Gf+uQIc0z3jgXXbd/YS9r3YPGBdiexCq9gcst1+yros4c2j4JMiDk5ole7MS
         JqPYp48AjZN/x/WuRyeu5xU8N/cp6Iq2SyD8f2if0ZF5tj1vnHrxve8f0xUCScCBr+9T
         rlXF74qWQp9aDTFSecWWZIbiAUHuWn+C0W2ZiHqvyOukUvIV9ZaAHziS1M6mGpVRcE4C
         ebZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F8hTP47ikKsPAHLkN0/ccW56UYyMMfZo9RM12hPsVNI=;
        fh=+FKnfzEx8Zpi/4CgwMaDhADDVrV24aqJ1dxRLSaiIyM=;
        b=R8fE63jUaIxE2aJXzpdrrW4ecO8ZacJneojWQs0YR/Kq2+YN+N6x7fNnNgNTWKfXaW
         9acFJ3eEMhTAuI3wjDKrkbiz1Aw0mdRvjLJVNIDQm3pZkUv/6AGOM/TSX5BLNxlG96XP
         P3j68OhJ3mrFoEDDJetOQXyWGxLinq4TFlkKZ+XiP8Inz6sgN6lqfqcMVi+GlSxP+LXq
         Hn6qYNMwMKbHzqa+l0hi4Y9isxdsXdARGl4ns4P9i1gG8c/RKqvELDVk0muaXLNk3ZVs
         BoWx+fH5LgVxTNZfzpxx5ta+Z+1OTJXPvRcIs1zW5eqfQJbAMWiBKU9PDf5rzSLuwOtH
         RQTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780439515; x=1781044315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8hTP47ikKsPAHLkN0/ccW56UYyMMfZo9RM12hPsVNI=;
        b=emMgrcx43CrLmkdQ2/TuNqOvmZoUiGWH7H+rM/Tz4Qfgjdo5Sx+nHf7ksoVe4grQwD
         XTY61uZfB1gWKWqyIxyxjlbZwVUGXydDW2RfvjBPM1zS7f9u4twpwr7r8A1h+WO0H2KD
         DFpjOwdnLQEFSL+zu04bLIT5+wX1SVLWmVT36ITX3DVYRvnG6UYsfU2ZFJvmeLTvpn4r
         Szt8koD76Kd0/jF9rPKbTdxVVdEwBiI3Bpc87+KZF+B0/l1oKazt97LESpRTHwWtVKMP
         VWmBhLCvluF4JeU6mBojtNYbAU9LA1hr35OhxGMIbMih5RMzjiJaQ4vmiYmHzd8dUozM
         Zq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439515; x=1781044315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8hTP47ikKsPAHLkN0/ccW56UYyMMfZo9RM12hPsVNI=;
        b=Kjz5TqLa0/3L9cmOrcAYKZSlW6RevFV5s/p11J5fdOGVU/FjSouBsHO6kPWGIM5ZnY
         ieEIxr1xNP8Q1vu/zxu/OSWxOHX6sXM/vdKNxtYeZ+0Kr6LVqLOg3Hvch6+2hBcWQEL0
         atKk+zh5sKQMJXy69xpVd29W/7VLPXPYYPfMmJg2HhgaT9QHln96ocbOrudsCevfFk5c
         u235BorcIOhcCia3oVV1UUnP2nZFlnHVlwV9SK7YHCI+LKDlu+4bShGSsGqkDoho9wdL
         mlNLe5YjW7VTZqp5tzhDHbPtrA6YCVquXWPFGaCNk1k6L7gYFCON853NWwIb1BSEZrIZ
         /IRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tfkcnKXHwM8ppCimeVLsGt0BdrHpEDJhL1KkER2Bd147jVQMMVLfOZ8Oi5Xi8RcVNaj22R/WIs4f2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqd5L0IWnoc2Eyfaor3YX0TPYCycxBbLR5bK2w97r5jHjVbfZU
	4LDhC00gAeAFo2tHPd5yeftjgkyvMjhvCHHLPTBjgk10sfYuBKTH19dT6Pl64xcLH5HqORfM6KL
	bL+Z2MzifV6INbio1dSMgRgzQNpETJJTS1QMXpfdhOKsYbmXUlqOri0F49OU=
X-Gm-Gg: Acq92OE2qaqkg5iCAYOTRyKMjrjTp2VUGGDa0bsNXtLYMuxBdlnbiKPYlIpE1uzrYt3
	BZipjAsVGQpD3Drm1YQxpB+sSW6rtI14uZl8+1WsNCg4geqIxaBPc+H8u8yuK2OdiE9ldmk+/vg
	VLYw16KblqV+SAfs75dRQaY+59ZmB/dz7RajjBTncBYkhAzC6cZYifFwFio9FfjcCrbGibJFLMs
	axcvqJHSUcQNJk1pntlG08yQczOI/6c+94eHjUi2RGVIje3RId0nHTPYtDb6YmW/uPCnto3rdLc
	8XiBMnrC9rf1KuO2AmUm9VyFODKrpyXRNZ6/sJtvTe+f+gI5
X-Received: by 2002:a05:6870:96a6:b0:417:2b13:f2cd with SMTP id
 586e51a60fabf-440db6deee4mr641061fac.10.1780439514408; Tue, 02 Jun 2026
 15:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahjB87k54bYdFbft@grain> <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
 <CAM5jBj4LPZxejjq2VFJZiwPWkZf3_rNxBRcT-8yrnfDXFSot-A@mail.gmail.com>
 <CAHYDg1QH=tMy8xbYn4D-L9iyp9iCVCEU190H9_gFLTWMABqhpw@mail.gmail.com>
 <20260602182503.GI2487554@ziepe.ca> <ah9TH5DNspLIXYWz@grain>
In-Reply-To: <ah9TH5DNspLIXYWz@grain>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 2 Jun 2026 18:31:43 -0400
X-Gm-Features: AVHnY4Krl0G_99H2lKXe3sLSHli6ioAiK_mxndBwIlb9z4bz6LnL7Qr-t901kIo
Message-ID: <CAHYDg1SengqQBTnbY5AfjTZM=7HUR47jkBy2f90QAdv9X3ioRQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gorcunov@gmail.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21657-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCE746327C2

Sorry, didn't mean to open up a can of worms. I personally would like to
move in the other direction - let's get all of these fixes upstream :)

> i'm loosing completions on posted operations when
> hardware in reset mode

I think this has come up before. For example, I vaguely recall an async
VF reset during heavy RDMA CM activity resulting in some timeout firing
(cm_destroy_id_wait_timeout), which I think was due to completions
getting lost.

You may be on to something regarding flushing that WQ. I'll give it a try
on my end.

- Jake


> At
> moment I suspect that we need to *flush* queue here instead of cancelling it

