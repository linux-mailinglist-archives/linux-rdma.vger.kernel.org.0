Return-Path: <linux-rdma+bounces-9121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD4FA790BF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA867A389E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8014C23643E;
	Wed,  2 Apr 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkaeAaJd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6F38DE1
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603047; cv=none; b=jb/Y9EGDAy7SsnGEP8/6uDximNubsycqaN1OvZSvpaLoOYhka9p2+aFQSd4ntbx6KfRQXaKXoEsSBbsQxkGw9C3TjXqZYwje6MIaEjx4RZlcnbKgz68FuL2eLPpYit0meUCCaDiWu1Vy7zvZujqXF5TSSbDru9bAZF525coNzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603047; c=relaxed/simple;
	bh=4sVBulip3fTqdwge65Je6X4en2Uqs3ted+bv/OrEtiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pn4VeOAfbWd4TyhdVRzzLmsWm6QM6flTcGu6z5gpGzZmhHZ8Kvm3Uc8qAvh+EExX7LfRiPzQafLCI9PmpUuDTxSaw8XT2SHFYboDqlHsZQUb5RH6VXwwrOvx+SeBtkNEhXluPfMD7S8lwa4JAV5YHZO8HUYgauNoWYYRw/HxnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkaeAaJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743603044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbKTHiaLmAweSAwT0igRmFjsf2YylXp8ikC2EQZZfqY=;
	b=MkaeAaJde09LuOeH8hDMcDtIGFpCwVF1QAR0fMSiD1l9hy3NLkpB2UTpDCi/38dUUntav+
	eEzVu1QNdThhoN9eaB3Qt/ilXkjSqRSrFo0ZC39XXYQEt0FST0MfcCZnU/4D+MlmvRiOcO
	KpPTx8tmWTMp/m33szAfjoCEIxQWB0c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-QXFdY817OkKOLb88Fc-FkA-1; Wed, 02 Apr 2025 10:10:43 -0400
X-MC-Unique: QXFdY817OkKOLb88Fc-FkA-1
X-Mimecast-MFC-AGG-ID: QXFdY817OkKOLb88Fc-FkA_1743603042
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5499c383444so3787106e87.2
        for <linux-rdma@vger.kernel.org>; Wed, 02 Apr 2025 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603041; x=1744207841;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbKTHiaLmAweSAwT0igRmFjsf2YylXp8ikC2EQZZfqY=;
        b=HRIIPS2Yf9tEc4xQWc/vY5KLlpdEc628YxvMjez4KK0L/BAW5VrCwVn527T29mcLUC
         7sH8udRlYLxb1BauQ6rre7vnPRS/C8yBt6oUMN8lBTvWRWARRfHSBA1yi4LD1rKl6sMX
         hJNjZBNXsQxVyAhUwYGc4OMb5luCN1Q0ZJ/JjB3uskRS5fWi5pK28lRHXsKJWoQu4QdX
         tfVCsxO4ddTtnT3P57lFzjo+RrWIOnbgl6POExTPmbYHRHcF0kOwn2mvRG8vWxSSOepr
         pEkjb2+Un8czPQoLJv3FRrQs9EqnSG3qM32pjX4x7WkpHKt7vk9RtmGyu6IRXYE3jAPd
         C69w==
X-Forwarded-Encrypted: i=1; AJvYcCUxqoF0M006+MlfUdSfLgmA0L7BqSF1/teV5uRBUEJEh+Eldk2gugyQa0ILDd5H6yyCBT3S89Al1tEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+Kwjm4FQivuedKOzECx6eqMkiORtqy4io71nhC+Xk1/aPajv
	rcKwa8t6XyVnrZgN6BbYFuDOyxSB3E2NodJZqSH7/sQiA/wLUO7vtqfglhFSvpOgcrv+Eh7xqRN
	JaJQKKtIRkbCS4HwQBFslZLJaGHZWHEzk4vwo6Ro79b/eGCH9fmBUtNuKpao=
X-Gm-Gg: ASbGncs2LPZsQCf74jOc6mJwWw4zLL2aNeIRdeeNylBK+UPQFGmN7JVCS/PwDlawvdN
	CdN43Qc/s6otwsQzEQ7OCExEvC1t2RqZ4PrkRKLHdzgL7dlS785z6E2r4KNKbPxXUwJyrA82h/d
	484hRvtr9w7ZuJbBozLrUwXoOp9bZpPmuK9PqbrC/r3UuDuKe4ruvCoWv2QJfibMEQSb//LH/81
	pAfXk5BNZXM6sGxclZ4eWZ3mW6WOFyG4pyrfjhb5tF22SbqjSNUsM2xjTwexzyqtYA4nmIAQNDE
	C6n1XLdDb68c
X-Received: by 2002:a05:6512:1386:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54b111242bbmr5823783e87.43.1743603041555;
        Wed, 02 Apr 2025 07:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMxC2U1r1cpFgYr/EJLzybppo1QongF+LooghSXPmyLtE3Ffn5xOTN3LHvx9mbOxE4Ua83cw==
X-Received: by 2002:a05:6512:1386:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54b111242bbmr5823766e87.43.1743603041173;
        Wed, 02 Apr 2025 07:10:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0e703fa4sm1433452e87.169.2025.04.02.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:10:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8BCB118FD3EA; Wed, 02 Apr 2025 16:10:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
 <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
 <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com> <87jz82n7j3.fsf@toke.dk>
 <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Apr 2025 16:10:39 +0200
Message-ID: <87ecyamz6o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Begunkov <asml.silence@gmail.com> writes:

>>>> +	if (err) {
>>>> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>>>
>>> That can happen with enough memory pressure, I don't think
>>> it should be a warning. Maybe some pr_info?
>> 
>> So my reasoning here was that this code is only called in the alloc
>> path, so if we're under memory pressure, the page allocation itself
>> should fail before the xarray alloc does. And if it doesn't (i.e., if
>> the use of xarray itself causes allocation failures), we really want to
>> know about it so we can change things. Hence the loud warning.
>
> There is a gap between allocations, one doesn't guarantee
> another. I'd say the mental test here is whether we can reasonably
> cause it from user space (including by abusive users), because crash
> on warning setups exist, and it'll let you know about itself too
> loudly, when it could've been tolerated just fine. Not going to
> insist though.

Right, I do see what you mean - it's not guaranteed to be coupled.
However, my feeling is nonetheless that it's better for this to be loud
to weed out any new issues that may arise from this, so I'm inclined to
keep it as-is.

-Toke


