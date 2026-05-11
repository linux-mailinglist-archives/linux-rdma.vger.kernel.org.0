Return-Path: <linux-rdma+bounces-20389-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP6PNLbLAWqgjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20389-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:29:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42E50DC8F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED4D303D576
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83038F950;
	Mon, 11 May 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+vdxR7j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A6381AFD
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502238; cv=pass; b=NPqTyZtpu2w625DL0JyXqAHgtRayAWEaTfE9Qhg51IxMUyxaO6vLKbqYH/EVzocgJPP8TOdZtb1AgMRZP3T/FpOhjA+xbpHP4Ls6Rm4/CWXJqDEQ9ZYhaO6twXbN+910wuLWtdx5HyhORIFOrDDsV8MMkQvsNDXffJhzieptUtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502238; c=relaxed/simple;
	bh=pynHm+TV4xPu6H0Rf6/PSKTgNJKz8F1tctCvdZi9xl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKP9DAVPX+Qw9k22ydM2+Yt1uZdi28tLRTxOpmr6QGzCz0DUx/2u9h0AxS3njPCmpf5HMLEK9f471dngFqKBq3g97rtY+oUzdyssD3Of3YU6JlSTWCrQ/Emegz2k1j21hDrZVjEJ6I/DuPQvgj+qyutoOnFBoT3/YTpAE9U9HJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+vdxR7j; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530287803cso4133623d50.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 05:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778502235; cv=none;
        d=google.com; s=arc-20240605;
        b=OcLb59dTnbSGjhAaKo0S1fl9b1svag+UYUsheX9wxLXaQVTUY0Aq4OTz9Se75cDjaL
         xPWCimkMW7xN+YmuQQNRw4vQLGRdv0Pb/aD+hVvGOX3C/vJ8DEQyIUEkBTkfNnqIyKp9
         Dhy4t2cPVwe2I/za+/eAVlo6BRndoCXoFKMreiCXvVxhXgyQnvlsXsrJfB340lWtKHTo
         tPY6lt1n+eHj9Oxrdzi+yLFwQO2pzyTcLyK3+xkZDxqtt8TMS3s4AWp7iVKmKPLwfPQP
         MblrJz5JmkQljr4NI5oMNabCcelAjXKQ2+rVQra0mKpbFL/Oiyc0zo/GCFEffNiwozbs
         ZwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pynHm+TV4xPu6H0Rf6/PSKTgNJKz8F1tctCvdZi9xl0=;
        fh=lvERuYwH7dpd3UzuFu832r67fexyrkXekpZzFSoFsGs=;
        b=W4mnkDpVoR1VSLhJ3rEdKnSbnNncyQNNSvLsmg6dsaP0lzvX1deqKw7JQTlgqZu0ji
         wWzdpha/dguIkhL3Y+VgHg9wyNyXRS5GmAhv5rRNFJ93v0UvOdozStpMOHMGSt/Cr6jc
         4c0b1+7B+nxExj5DlXEybjtJoRhvF+C2G9WJHr3arkds/xmL+C/AsJ2EHltRjg2uSvU8
         osv/Y0HeTN34NYEl9ytvQkj7SARG5X9Ggn4FiUWKVeul67wNJyznqXZkJZBrgsslT9qd
         /52pAM3VDQfTXOQkwkWlQY99w1r8SIYtFl7oj0/zaj//b4UXI1qimmcasQiR84jycEGY
         8iXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778502235; x=1779107035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pynHm+TV4xPu6H0Rf6/PSKTgNJKz8F1tctCvdZi9xl0=;
        b=V+vdxR7ji0Z4bjpq8aZ0KEd46W6W0KtBDa2jsIQKV7sGpJP1s+1E1UGMrJKTt+R8aY
         87rrbX2NuDbuzSGueSIjLmEIXFBsX3gdAQcpuW4+B1y8rn5fupQHYauhMRW1aqAS/Nh6
         IqRVrPeP+o0DyWd87tuxuqaqQ8WYx6C5KN06kIGIIBPtGGkvHq8FgQsARLBYJrxFtrlq
         753byaCw+MEfX3hSIuXVjOYhWIFb4F2KitItB0LKyXZ1eHej04eMb8girrNQNuB8RgFi
         Va5E4XxRWVMr8X+1ZC+nqfjAUEyTqII8Q9VvMPRs5L1ZzeH5xfqHvtpeZ3QHGLiMVCSX
         zkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502235; x=1779107035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pynHm+TV4xPu6H0Rf6/PSKTgNJKz8F1tctCvdZi9xl0=;
        b=fyxqWrmZy46U8VRJL2OIOHtke59GRnN7CMZ8mWMCnmu/AqFCLAMWA/AMG8get0HMlx
         PVWToksfh35cpArv8yLs8K6CWKNfC59KqtmjD95yPv+G2tsrtoPYNPy6O/0hPJu+q1yS
         KnoTCEhLp3NlfsKQ7jSgdBd6dwwPE9274A775uWjL0BPuqCHyr63n+zU9c0VMLT7vZLe
         7Eu+7q1S3rUI+W428wGRButgL+Xh0sUtfjFPoMeb1O5M3cdkNMcIJS68rdpeujOwFjdd
         /gOXb9xoIN7aVExdGZQ4zFSs9vck7PAZyVNXBovq2CpMhikaqHz1+9QclhHUkgzwxF+U
         K+2Q==
X-Forwarded-Encrypted: i=1; AFNElJ98yID1MlgSf861Q/0HKseQ3M02eoSNnF6rCGrkIQF1Dy10W/rhFGdNUEunDaFfhtqlojig362BWOxb@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvYoED8zA2drTC9DVlHi8a+q5ohuM6rwZy4+ABzxzKwKYSNl3
	YmNDUomLWzbLrc7vpGI6Rai9On/ctpZbObF2uB8dTdOk26ZJLWktwXE8nEyzuPyoPSAMQFxNAuS
	cqjeTj3VMKBsSpiHMcrOHjqcoaYasCQ0=
X-Gm-Gg: Acq92OFgft+BPkv11uNqpal/KFCBe+kLgvATvA5ajRKX+h8fuhJ8USMe2/gtP12GVp9
	QI4eHHCc1WzY0VqmVGTzAlhF50dEOHPtjScU78Gj2Sd3pSb2MLvYKyWB03v/hTZUTdtScIapshP
	LFXEVoqlwq5ctpbehoRmUu5ewGDWdozJPVgxQR8Dwg7b2pHKvYzKuKL4+N3c3x5tAfVoFvo06ud
	tRdfSF9kTkWPUHGLeWq2eVkgbVQRPyGFO4K3ft2sBtuBFnOPNG4Cc9qJLCSwA5wjnh+Peg3pcs2
	qlKRH3kv
X-Received: by 2002:a05:690e:1699:b0:657:b16e:f63c with SMTP id
 956f58d0204a3-65da8431d8fmr9622685d50.28.1778502235556; Mon, 11 May 2026
 05:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428163014.379069-1-lgs201920130244@gmail.com> <20260511112243.GG15586@unreal>
In-Reply-To: <20260511112243.GG15586@unreal>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 11 May 2026 20:23:44 +0800
X-Gm-Features: AVHnY4IMn1VVwfbd5sakhbZpx5mhLXvUc7EjUmJHkI6YikK9Lf-dM35XUia1wkU
Message-ID: <CANUHTR8-1r358LZUsC5w2L4kftZgwERZS=hLhRqHDoQx=cR_Eg@mail.gmail.com>
Subject: Re: [PATCH v4] IB/mlx4: Fix refcount leak in add_port() error path
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Roland Dreier <roland@purestorage.com>, Jack Morgenstein <jackm@dev.mellanox.co.il>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4B42E50DC8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20389-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Leon,

On Mon, 11 May 2026 at 19:22, Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Apr 29, 2026 at 12:30:14AM +0800, Guangshuo Li wrote:
> > After kobject_init_and_add(), the lifetime of the embedded struct
> > kobject is expected to be managed through the kobject core reference
> > counting.
> >
> > In add_port(), several failure paths after kobject_init_and_add() free
> > struct mlx4_port directly instead of releasing the embedded kobject with
> > kobject_put(). This leaves the kobject reference count unbalanced and can
> > lead to incorrect lifetime handling.
>
> AFAIK, you should call to kobject_put() if kobject_init_and_add() fails,
> but in other case, you should call to kobject_del().
>
> Thanks

Thanks, I agree. I will address this in v5 by splitting the error paths:
kobject_init_and_add() failure will go through kobject_put(), while later
failures after a successful add will call kobject_del() before dropping
the references.

Thanks,
Guangshuo

