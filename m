Return-Path: <linux-rdma+bounces-14394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938BC4DDD6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D3634FD921
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8543AA193;
	Tue, 11 Nov 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZwCK1es";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPwuRNGr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037A3AA196
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864621; cv=none; b=j/RqvHcnC9WP8XBoH/2NTvs9lh/cdIISN1v6/u866ADTE7Kaiu5r3ZmLfz5g8N2LB1tc9pMWCPk+XODp6waovjRP1O9Qc/jVD2wxHzhGzIz3tx+VDA4oU17PEZHo27rBUDA+/ZGGJrS2mOq0ELUjl1mdnTjVzYwWxUCkHBP+p5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864621; c=relaxed/simple;
	bh=5dqdNo3mNkTyuVVJxOfXWQlM4vdL2fXY/f6lg8rt8x8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVUOOHn0yXS7648Y6knz/CXDaOn+f9LDtNjP7GLdfcDp6v5yRA+8nNX6sY4tWXw4NfhKVsnW2GC+jLNbm/bo3b1CEVFGH51/87BvjGUtCCv/DdC3xx0eZud7nrSv8ctPqX5wT0i5WnmJqgAiSwW3gpxdUK4SlhUtS52wK4HeiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZwCK1es; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPwuRNGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762864619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJil3CsSx+8fOj31OoVJWOQNTlYu8I58IHhwpqoKvHs=;
	b=TZwCK1esLLli0aDh7V2YSGTPgz0m4hTSIZoK4lnwbj8By0MYbmbK+3JmrxdU/EJgmv55VI
	W+EVoLXV1ux6tcniMc9G+ZsZpPNTtuifS5rtuDACfJCmkDprtBwXmclMmmaSiMWLRchWFs
	FQywiFLLWNk8K+msvj7nkg9Sm+pQvGk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-3TTDEOIbOCOPtFRF5ESy6Q-1; Tue, 11 Nov 2025 07:36:57 -0500
X-MC-Unique: 3TTDEOIbOCOPtFRF5ESy6Q-1
X-Mimecast-MFC-AGG-ID: 3TTDEOIbOCOPtFRF5ESy6Q_1762864616
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-641613171cfso838744a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 04:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762864616; x=1763469416; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJil3CsSx+8fOj31OoVJWOQNTlYu8I58IHhwpqoKvHs=;
        b=mPwuRNGraz2FloDjjZW58TFYOKa2vusLMVu2/EYH0Gymc8KlQT2pYKbbk4XC2Y428e
         lpLqp24A1/XZXJd6sOCvVp9gJgywdeDaC8f7CymMHBRegn/MrFQFC3iByhmlm8eptHu+
         ja0MhL4V+xcCybVrQa8TJ8n/mJ4xFESUQ58iNhPQQancjm9MzaHgWqTvfwTRYDIQjzxJ
         tiE6jNRCe+4Qlh8dRwYbzJ3ExmvXZsSdH4CCQ5ZmdfSnCWMLkaWIFt0SGyejFTEVb9pY
         G63DQnBVg8LM6ccu1aHLaiLxN/8uZEf7Caslm38yROvZlluqj3oPK12z3COQUfhTL9Kh
         qASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864616; x=1763469416;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJil3CsSx+8fOj31OoVJWOQNTlYu8I58IHhwpqoKvHs=;
        b=NumwebcyBLydzKFnxznvyIgRwEjEr7x8HGhAo4cJCOi8M0uw3xYQc9TR+P06vJ1wHZ
         gEF6exy5xExXVl4fZs4kx+ziW0iiJTwCDMMQIPY/6RDnqO8qs4Ls3UMQ1sIXsxbYN6Fu
         scZtgHo0nAcDcW3tspojns1yUDgOdi7m7Xy9FJUHvaIp19F9HndSmRg/fS8NNHk3R5Xw
         qSRRNxFpzajzgTjHU618MnN2kJaiefzpLB6TSVqxGacmcbGVlBx33I8yEBHYR3NIVEvu
         e5GiH+CHRzPkLiPAq2ma7oz28JAzFYWPYDDYU5GLik+/KosVP53etGqPkbkQYd/PRAjJ
         +73g==
X-Forwarded-Encrypted: i=1; AJvYcCWTT2UjKZbMrTB0SwGTIBCvZE4a+IrM1oGdiF5VfuRitaS16hxJPhqmSJv04BOAgObwO8jvuDNyvKry@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8ckuSQRlnJ42nfuiOGzfUVJQp2ynga+IIJtrFvX5RJxIWixa
	lFGvs3c7pyIf0OvBGsxF3/tyA1NBVQikqXRqPqVwRGivszGteF8x2ffBED3ur+JU812zerNjA23
	WpTPqCWtDvwjYWrnR7b1YSuWgdtCj3ZopYBju2yn++r2buvP9rWQnMlaOUyYwVB0=
X-Gm-Gg: ASbGncthB2ONXumJplRnT+nus1QmKX+tSkc7AvYsY+QcW9uVRGIAEGbCEtcJPB9NMWB
	Q1kL1ZxD6yIB0DfxOdT8OnNj7HR8X0WD5/BjoDYN02Aw5BPcBjE1YTMXsIc0IMVn3qDawL5tHWp
	y6kFPRNhVmtQ4RqYDsKcGaUVQPbLEwFWFybTcz43qo2fov/zTH7oQTBkQwCnFj9cKP9ZJnddHwh
	KNQ90fmjCV9w0+6YKhSsq2Yh8vAUNRsQb4ohIrkHUAReUApA6nnQWikJH6oDc78k0I6QSbZaj6K
	CmmBI1rjlM2rrcdMybAu3vK/2wBAhA0vcvHmCovKLG2Oi9iRuQEIyBP8gK0/1e4pW59t1I65ZS/
	csYJ25F4BdAONWrjCOZJ5z7qZGQ==
X-Received: by 2002:a05:6402:5189:b0:641:6b44:75de with SMTP id 4fb4d7f45d1cf-642e275ace8mr2893742a12.5.1762864615829;
        Tue, 11 Nov 2025 04:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfkAwSb/V5JIwU5moExHjbeMcWwrXGoX+mdVUHDtdTxf3WoXuBjDbonnmfpi475Ak1gHNtpA==
X-Received: by 2002:a05:6402:5189:b0:641:6b44:75de with SMTP id 4fb4d7f45d1cf-642e275ace8mr2893656a12.5.1762864615046;
        Tue, 11 Nov 2025 04:36:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm13449948a12.13.2025.11.11.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:36:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 83146329590; Tue, 11 Nov 2025 13:36:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
In-Reply-To: <20251111024500.GA79866@system.software.com>
References: <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251108022458.GA65163@system.software.com>
 <20251107183712.36228f2a@kernel.org>
 <20251110010926.GA70011@system.software.com>
 <20251111014052.GA51630@system.software.com>
 <20251110175650.78902c74@kernel.org>
 <20251111021741.GB51630@system.software.com>
 <20251111024500.GA79866@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Nov 2025 13:36:51 +0100
Message-ID: <87346kn3to.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> On Tue, Nov 11, 2025 at 11:17:41AM +0900, Byungchul Park wrote:
>> On Mon, Nov 10, 2025 at 05:56:50PM -0800, Jakub Kicinski wrote:
>> > On Tue, 11 Nov 2025 10:40:52 +0900 Byungchul Park wrote:
>> > > > > I understand the end goal. I don't understand why patch 1 is a step
>> > > > > in that direction, and you seem incapable of explaining it. So please
>> > > > > either follow my suggestion on how to proceed with patch 2 without
>> > > >
>> > > > struct page and struct netmem_desc should keep difference information.
>> > > > Even though they are sharing some fields at the moment, it should
>> > > > eventually be decoupled, which I'm working on now.
>> > >
>> > > I'm removing the shared space between struct page and struct net_iov so
>> > > as to make struct page look its own way to be shrinked and let struct
>> > > net_iov be independent.
>> > >
>> > > Introduing a new shared space for page type is non-sense.  Still not
>> > > clear to you?
>> > 
>> > I've spent enough time reasoning with out and suggesting alternatives.
>> 
>> I'm not trying to be arguing but trying my best to understand you and
>> want to adopt your opinion.  However, it's not about objection but I
>> really don't understand what you meant.  Can anyone explain what he
>> meant who understood?
>
> If no objection against Jakub's opinion, I will resend with his
> alternaltive applied.

No objection from me :)

-Toke


