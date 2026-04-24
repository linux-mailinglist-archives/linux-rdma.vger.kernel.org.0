Return-Path: <linux-rdma+bounces-19527-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJe6Gmp862npNAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19527-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:21:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA9460216
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293B83031E9E
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B83DC4BC;
	Fri, 24 Apr 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igpKv7ta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5B3DBD72
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040366; cv=none; b=odfwS4Q39IKLxBYZ4aKHS8evFjhIWEtWq+1nZV9vuqpmHLeGJVgefz9yT2QpoDGiMFl+5e/WItaoaqhOmOIMpwMpQyOyRRWZN/chrjKTz7Q0Yc8BbTrqHI0Am0QLwy8MWuxMxkN2tswZmDXaAwAHyQitWwadEGXQPTMkjbmpjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040366; c=relaxed/simple;
	bh=sR29cvVWWj1zEvLPCnOluGKLlUo6GPJZv7ipVNXVONw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gopqhzNz1mtsFMJrBZ38wvtrihPJvVwy7I3L4p0CDsL0mEy/Dv3ULsnzHZOiHyQ9PNpHQMbx2Pre49jiTu1QK9DeO2IFA1jedhPNPftVhEQAfu92GzcCiWuuYcnmhctRyVdaRIcLJ3PzsmIK86rZxLfDNIzc30NwsyPPG6Zpb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igpKv7ta; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6201fc9ac0eso955328137.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777040364; x=1777645164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV0Gq4Db+XurRwmLehRl8plU7HsCQBBchm2UxZdn8eA=;
        b=igpKv7tavJsOoMZy48+l67X+sKqw4fGrLFlfTwBT8xEv50hjj/UwxHNUnf6A7XM62x
         6SO9kz0XzK1vDDn1Fw1/WKyMSl4z+tC1/eqSsCRIpe2RiqDq2/uHMMKjUOH7fnKEYoV6
         m4GWv5P5pMeL4gPkHQV4216zlJVaxS4kVcC3kwsVW/FfqTCKIaVt8hiEaaf9iO4v0gdB
         YeTTXCdYGuPMDVBEYlVxdNnSGim+WPSH2z22x/JCLWF1KqQHsC2FqQnEEao6vrYN1GCO
         +UtOJC3nva1hzI0OMrjCuvSu0Q9pxqVbXYH4JVx7vv1Ysw6H7gkDMjw7KhsYQ+vfetw1
         spWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777040364; x=1777645164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV0Gq4Db+XurRwmLehRl8plU7HsCQBBchm2UxZdn8eA=;
        b=FgL7IMSWeNJZtFKL3JJ4CdPEmicZzYJPtywk6euAoszkC+FzW7t2yiACCWYjIz/kV6
         oG4eHQ2FRIP1Hz/WV0eUTsZlnhZudW42j1U2NPU9c5XIVy5YBCsDVYRgXVBsU14aeM50
         eHahJ2pwNe65crW5lJVNZT7ht01fS+8tEglYU0WV7my4DZcNAKqKAE9GtrEAn69EmzPz
         ONNBOvRgct/6+itrCA4XcL47tBhEfzmmBZ9qZPePC/DFpKQR1GhBEE3gfKgQW9mBOHL/
         D1y8wnrEhBTA6HqAomiMFsnvOptPo1QeL/AJr0M0IZXsnxSyjYHYV194tgB9ZWeZNMJ6
         KuoA==
X-Forwarded-Encrypted: i=1; AFNElJ+T5Z65xMrqDhrju5gEgSqQbabM/Jz1Ztkbz5CH1RUblK/4EQ133bmIcYDcKxlQei9x43KPUPIzfQ3A@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1v3MR5enrNR849ky45BKzVQNQyW0BbmFQ1t/66MRqZGi+/Wo
	yzO9xeaj1rDJWJgNAzwVT5QV1ZZhkANaytLsxfHl8MBto7mOgXITlJ6vfNpZ7SE0BCY=
X-Gm-Gg: AeBDievx4wqsBvc9O97m74cRJWcriSktAR2LUEJP3Ncci2FInUtHmwm8LXaPl/uzojO
	Q250CWVHxhGgyhC95LN6jDovXTg3Fve9l960H1JiC1G2seXqEOHJDkObXEVUL7OFIt/lWulGcsz
	2WsE+8HrpLDz+/C4xNTZSA29HhQoLcz1O4bwNkcymSfjpqlUypBMN+zDoC2mYEkPtQ7gqV1b7or
	ugRIHqPeynDMSdIGRse2EnEhkETUYa/jF8TMEEfyHQNaYLaRD5wXYPbN1LErkGdhgWP1m2mxJEJ
	kDJj9wyqB8wJ53oS3ZxLnQKpmi72PvAyf6hZMVaDmvd1UfrBYP60YdMH8SHZNd0hPaukXO9DkKv
	r3/uZHMPC1YEzO21OYbJgjTxy6q3NJCSEje+ufSpJ1TEa84EhrY+FvM0YdHpRxY9Fw41eYvuw7U
	AcbKj0WCD56/lLYDPJ2BhSacdf/nBNHVdc9nlpzTvz9lOCawhUUszOhpfQlUogucpWFijjfFMva
	KKlbaPA0r8ePkYU
X-Received: by 2002:a05:6102:6cd:b0:602:6784:3eef with SMTP id ada2fe7eead31-616f90e6f07mr16856701137.28.1777040363554;
        Fri, 24 Apr 2026 07:19:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac81a9dsm186723106d6.21.2026.04.24.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:19:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGHNK-00000002j9p-04Ph;
	Fri, 24 Apr 2026 11:19:22 -0300
Date: Fri, 24 Apr 2026 11:19:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260424141921.GA3611611@ziepe.ca>
References: <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <20260423140950.GE172828@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423140950.GE172828@unreal>
X-Rspamd-Queue-Id: C2EA9460216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19527-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 05:09:50PM +0300, Leon Romanovsky wrote:

> > > Leon mentioned that different firmware revisions would have different
> > > parameters for a given opcode, and that one would need to inspect
> > > those parameters to properly filter the command.  Is that not true, or
> > > am I misreading or misunderstanding Leon's comments?
> > 
> > They are ABI stable, so there will be rules about future changes that
> > old software can follow to ignore or reject future things it doesn't
> > understand.
> 
> It is wishful thinking and applicable only to mlx5 devices. No one
> promises that other devices follow same ABI rules.

Well, I will definately kick them out of fwctl if they don't.

Jason

