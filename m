Return-Path: <linux-rdma+bounces-7103-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902BA16DB6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 14:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6111F3A4FC9
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486341E0DE9;
	Mon, 20 Jan 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h7toN3Oj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E0193
	for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380848; cv=none; b=A5OOg8esjwfw0HP5yK+RXqfAMxzaeafIThVPkuxE8OouB4gOdUuhPs+u2XKHvFxK0Z07p88hcY35my+sXj4hD5xZUJ0KAealvZ5ieqHPr7xc8pwhjBF+jnd/OGOJ8hmhf94IWDwUNmoZl4dyW25OvOY9+V037Rqc5qvDD9iMj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380848; c=relaxed/simple;
	bh=GeXzxCgGuKWx1M+Ms08i+VNSkY1XAtyqLHaEmv0yXmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2Memur/l4gfE9a5WKV8sbua5ZcvIWalIek7QCGTsxXf0fJOLwRNRWEv5J0veYqCmTvlox1/VwdG17NQ8qxqZxZU9LsUfZJyV9Gk2n4fYA7/N6Csysq7DJPpq6CackH35aMMHgAkJAF48EORhyy2BNfgfxQCSgxIxHfR2PvGs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h7toN3Oj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6eb531e13so239468385a.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2025 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737380845; x=1737985645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJBG1SauCV8VABLZVs4NNU7kMCxu/6Hdc/HxqVjIv94=;
        b=h7toN3OjpvIRrgOz0sZjcnGMLsElVgEGrzANzfrc6t3P7apcuOn1SY5MwvXs12ZlRI
         D8sylQoBxatpJjeo9RrH+BP3lBgi8KBVHROzxlHCuprKV/Xtf0yH1wys8h0Re/9kUotY
         Eh8aG7/sKWVRHkq/TFZJmfYVFZGNcAesjWKYB4bXm0g98g9qhkwdY72s8YdsOjHKLlkt
         FVBYFMi8oQm5Mbv6qcfB/kNTngMOpKqedXbFadl0izYJDiFwpXv70rfge0bSdU4mV/Hi
         WcmtD3UCw1Vi0ldc3gSmiko0PT87Vf1z/v2dqU/CPuFUpORmC1pPdmgBu5SAKuuYRdkp
         Eu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737380845; x=1737985645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJBG1SauCV8VABLZVs4NNU7kMCxu/6Hdc/HxqVjIv94=;
        b=u3NEM42+AXMbNoehAuxTl//zFrnhDKoVOzV1/sUmnrEDyM51812IH7o7gZavozHNO4
         ZDg4LW5qw1jn+JOjhMxjp5KiKJ2beQDPDecbEWudlnhEt8YKGAskMAgXUf91XvHCEFvR
         RuOYEg+q7epfbJ4+AMOP18+jjyct+vEdxA5nrC+YGKchGvJCeW/aQRZ4h1VYkC5mbw77
         BINWQgoAeg3tbCxi8qlH0bFMQijHu5GePQOA/tazkBWm5medqlOJIJCPZezxruOos/s7
         fXQ51xutXXzJaLkVBpiF+bxgNCK+t1seyrL1Bi6EK6GiSejevdsgxAeCnIiYljSQzlXJ
         Ld9w==
X-Forwarded-Encrypted: i=1; AJvYcCVt/DcqofmLekBWxkqSpJVug3r4gyv2UZGFHLqv/M8eSgugTvqEf4+6ba0RilDxOKjrmubx3XQBijsR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvgr9Zbi1n3OoKA+HElxp3N4xqySdjV7KpQHlp5kLOSa+OSRKX
	A5f/TJnS1SjpYeCfNI2TKcZi6kIxII50IrB+XptOZyATGS9yFjqpuYAla7Azvgw=
X-Gm-Gg: ASbGncvMxRPwFjA8K3KsiQYeBdbH1Yqx6wnFQ7hLK34pzPe9zf0RUj1HtNiMBFtI0wZ
	CE3371+nsL7CHGsaTPGEZmr/hr28AjM5R9KOQw/BAOrI7/jefLPgMSohzEVGupgQLPLYc1HlJnQ
	WK+0/WuohbXPSV7T08sAkTLqSAX0+XjmCNdqW2KqLeqpmYNdxBARC00Yfh+3k5uu62UzxO2YyLq
	kEpYaQitkEUVVnc8n+YdTNULRhpGX70in+MO4vb37PmwUBLnRqV068hX4oKnf1mXOsuhtsMIXXU
	YHgAlc/amTNdT6t3Ta1O1vrFkawOdX/7H78ulJd5DXI=
X-Google-Smtp-Source: AGHT+IF5A3qF3INaO0pH9iu8A2SuQIUdjjVoTY7L0AZSsMj8dCFU5Jf+YHNQ1rLqgwNMJBmUwQmQ6A==
X-Received: by 2002:a05:620a:44c4:b0:7b6:79c8:d036 with SMTP id af79cd13be357-7be631e7233mr1995927785a.3.1737380844758;
        Mon, 20 Jan 2025 05:47:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147500csm442655185a.10.2025.01.20.05.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:47:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZs7e-00000003PRq-3jFO;
	Mon, 20 Jan 2025 09:47:22 -0400
Date: Mon, 20 Jan 2025 09:47:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/mad: Add state machine to MAD layer
Message-ID: <20250120134722.GI674319@ziepe.ca>
References: <cover.1736258116.git.leonro@nvidia.com>
 <bf1d3e6c5eceb452a4fa4f6d08ea6b5220ab5cc9.1736258116.git.leonro@nvidia.com>
 <20250114194208.GF5556@nvidia.com>
 <20250119082624.GA21007@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119082624.GA21007@unreal>

On Sun, Jan 19, 2025 at 10:26:24AM +0200, Leon Romanovsky wrote:

> > > +#define NOT_EXPECT_MAD_STATE(mad_send_wr, wrong_state)              \
> > > +	{                                                           \
> > > +		if (IS_ENABLED(CONFIG_LOCKDEP))                     \
> > > +			WARN_ON(mad_send_wr->state == wrong_state); \
> > > +	}
> > 
> > These could all be static inlines, otherwise at least
> > mad_send_wr->state needs brackets (mad_send_wr)->state
> 
> I don't think that it is worth to have functions here.

You should always prefer functions to function-like-macros if
possible..

The expected_state needs () as well

Jason

