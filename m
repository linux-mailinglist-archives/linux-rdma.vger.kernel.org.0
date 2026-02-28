Return-Path: <linux-rdma+bounces-17338-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEYVCEEbo2lX9wQAu9opvQ
	(envelope-from <linux-rdma+bounces-17338-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 17:43:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD441C463F
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 062393019817
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16122F28FF;
	Sat, 28 Feb 2026 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HTRzyeLT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41F156F45
	for <linux-rdma@vger.kernel.org>; Sat, 28 Feb 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297020; cv=none; b=DcuQp/2p7koCNi0C0xG/9m9J6DvwX1DAuAmOmYkjmhMA7xWCGv/+5r0lSswZcEGvE3rc1iC3t7/9FXrpXAo4HoTijh8rZyV6s404mGmoGj1hoRLD/SJzt9ekd+Lt8gF4kExYUwPOvtupvqXUmO5MEcSZiLFlZf5IT7abLHLRo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297020; c=relaxed/simple;
	bh=OeqrZNXsCfXeu5hJBm6orYbAKwq8hZPj0psBIugU8zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz7wRQKKyMC/FRykxtJKHKx0xUSZjsXi7fjnv7snA5tX+Ti9SDQBo1zkpns4rvSS6clw02r/qRqUBi2MxFnpHQCKzpzfJH3gNXPOfsKBijzvQOSth6wWxbRQ6kEzdkGK2X1w8+P3fJ+c45y+1CFQECgme7WrMrPJv8Nn4r1Eke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HTRzyeLT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6f21c2d81so305653085a.2
        for <linux-rdma@vger.kernel.org>; Sat, 28 Feb 2026 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772297018; x=1772901818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CyB85AxGLgD2+Nh9B1vgYQQvBxMNCtrPeDhIzsClTY=;
        b=HTRzyeLT9Gq4TNe6RT4VNLUgaXrr1vbP6VDn6qEkj8KYeHnwzHDEV/FYmSJrZQSXkF
         lV27NRwkIlV/wNT5B/J+As+bYxWIORriYKM2nrvxfRahpUsma3ChOw7Bqf+WGy2OMW3f
         nddAjxfAyBAEVW8xpmUSG0tu2bmojJknJlqwn7KPzids4xJuoaokG747ja9kTp+Ux0RM
         g3rfSawFMDQpEbrnp97Y5TgFO+jzdLGpvC7WUbMieGMHGVx11+JkD5BcR79GHTv1Z8RC
         BDZylKKpPuZ6v1lxJadCNffJkooQMwV4K6ArUkA3bvaXUS9YVD2GKcR495bUyTn/9vA9
         4nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772297018; x=1772901818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CyB85AxGLgD2+Nh9B1vgYQQvBxMNCtrPeDhIzsClTY=;
        b=ZF3pe1Y9AcTe8tpRn3wuHwcO3CHhqNF7aDAxYjpCqhxIPrUqbru2GSYnusznt8AKL1
         mZj+p0veT37Q2iH084MQqGyLat8GGrr3jXQTFT5v8og7RKWRx8lSNoBgx739LWQjhiVe
         F0Tiy+zmLXMUoN3Fimk/IY9QhZtpeOaO+jTUJzbOiBqwf03JbZ+RK82BAyuAFYLpQCYU
         Tnf2K2GbS+zE6Fg3P4L85r7O4tdPlSsLS1vgBx7RRKIPCxMPxFIR6DMsr2PiLs/yHe6E
         S/ZXgiwbbV0Aye+yUjg+zTDqo3loR2gblGxgHQ/zi+UTG0+QazOTuw1Y0L84VnEP/bnb
         RhAg==
X-Gm-Message-State: AOJu0YybLedhC3s2QJawmDp4SOKIXTGzaUjLr3J/PCKDuOSDaC/cpUnx
	xU7Iiy553UeGxeu9E/30oOcbI2rMIthwZqrlLzA+/Afp9XnMjQFESOZvduHLAUulTtkxXAd/NSX
	jkObi
X-Gm-Gg: ATEYQzxPDCDzzOOKIC+Tkch0SQO4SjLWePcAoreHyojf0UNAqrp5bnvG0GbnMSw/tDw
	5acL2tl50nzCB/NbPl/YhMmwzaKZe1hXqllVGeoQCx8cv7f68PUHCtuFHVKbCxeeH8a/R6Nj7Ze
	Kdh7SHw2x2PvQBH7AfzyAZKPgDX3HyQ/4LUbRnd7jTBDkCq9diwXnIbpG87fAIaDyLld5SP8e1v
	2UER5Ws7vR6UhikMxxvpYg8XmqOOeUSOYXiUYx9Pv91zpQGawKIWK23Q/GGlBvnliOB/jSttCC1
	HNlwUVUyYs8UdNzNsaVOAO/E2uDXnRilRFbUYTNgb68pMfLaHeZFdrwWqSBodhUepgPuSTCumsA
	gK34G4fsxouY4c59ua/jLCQ4OXZNUHPy6eQ+m3oeD/Grx126cwNzdrT0HY7NBceoDvHGCkiPqPF
	U9EKROpFPCCj1SSTnxhhckqzwk29ENTAiOCUkmWo5UaanxdCcaWyhxmzqdeNxCOIbI3q7MXCAY/
	+4bEKP+
X-Received: by 2002:a05:620a:46a2:b0:8c5:e166:fa14 with SMTP id af79cd13be357-8cbc8f5112cmr900568585a.73.1772297017828;
        Sat, 28 Feb 2026 08:43:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf716207sm888082485a.34.2026.02.28.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 08:43:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vwNPk-00000001ctz-31Qp;
	Sat, 28 Feb 2026 12:43:36 -0400
Date: Sat, 28 Feb 2026 12:43:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [rdma] "rdma link del" operation hangs at wait_for_completion()
 when a file descriptor is in use.
Message-ID: <20260228164336.GQ44359@ziepe.ca>
References: <cc96166a-a469-4bc9-bfbe-de6f40dffe97@I-love.SAKURA.ne.jp>
 <d800131b-d257-4dc7-adcf-7c35e7a223d2@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d800131b-d257-4dc7-adcf-7c35e7a223d2@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-17338-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: ACD441C463F
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 03:07:29PM +0900, Tetsuo Handa wrote:
> On 2025/12/04 17:26, Tetsuo Handa wrote:
> > I found that running the attached example program causes khungtaskd message. What is wrong?
> 
> I found that this is a deadlock caused by "struct ib_device_ops"->disassociate_ucontext == NULL.
> If the thread which called ib_uverbs_remove_one() is unable to call ib_uverbs_release_file()
>  from ib_uverbs_close() because it is blocked at
> wait_for_completion(), it forms a deadlock.

That doesn't sound right at all, the wait_for_completion is waiting
for other threads to let go of the context before closing it. rxe/etc
that syzkaller is testing don't support disassociate so they need to
wait.

If the wait gets stuck that is a different issue.

Jason

