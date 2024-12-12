Return-Path: <linux-rdma+bounces-6471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353C9EE711
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 13:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AB21886D41
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF1213E8F;
	Thu, 12 Dec 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsa9J2at"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499322116EC
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007782; cv=none; b=aVz5Z8e9USgCSnYal5FcwwLbCRww66o+1Q58gBwNnH68ytvWk0D7YF9oULjlMj65OoKL/TKWiQQEDYKBg8cetjzQ6f7x8xiUriMmrb3fhNRC2EH0UuIlhXCHz6nGet/QCLmGomcLQEwF4gzeVwlHElH1C0dnrA0ipmVgpIWOLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007782; c=relaxed/simple;
	bh=YyEpl48QgjEe2bn12JUr/hGhuZXIyNMzlFs8mERZ05k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFc/q1qucv/FH/heP4bEcPzUvF/Dr7qY+e1mTvsp5fgBjRhOkjVYi5PQtRrgW8oe6QiVsDICIgy19fVdC1XdwHzj0IKsB3zpe6Wj12A27Aiepv7jo5FdcEferPwdecBeU7Mf7NjdVLuOU9leomUYtal3Plb2ZUDe/bNp9Dg2Zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tsa9J2at; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734007777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
	b=Tsa9J2atuW/LZ7VQrhheeXKfen7SHJ3qT8V7x8qmC9PnE5mc1twapGdyA/y1j//Jtwrg0B
	xzIHaVTAEW32ElyZGUGaPtHcjKcZa9gK/+/ghzpv4P3EinzIyd32Qomcx9bFb/5b0/Ldp9
	mhG/Qj3tpDYhMizBarlathL7GPBByL0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-Q0h5dcDsPxeaBodH5uVm0Q-1; Thu, 12 Dec 2024 07:49:35 -0500
X-MC-Unique: Q0h5dcDsPxeaBodH5uVm0Q-1
X-Mimecast-MFC-AGG-ID: Q0h5dcDsPxeaBodH5uVm0Q
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f14fc179so16184926d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007775; x=1734612575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
        b=obewHAcKmErgGl6HG5vUf5Gtdfra3Ow122CPBzZdRVffSC2SkjjTSXYNsSKEN/BHWQ
         py71555tx9jSc2S4Z2BqainYhfiOAwvPR23zpdq/Ot2erSRHBthvbe4i41gGhlHjkvaO
         5zkxD3zMyQuZHNSk/408Vme22lITGyVw+Tc4dhm6xQkT39Hh4AZunx4j2kl9hvBU/RZs
         vfXO0IIfXkdGbhMBxE3XQ3TCSv8/bRLCQxPzJ73XS/l7YhtpI7cdpaOcz+5gVaUBPSb1
         FCKsKSOkdLLBiC4+3oVOKB/BnIuX7LfuPQIvFjklpez4efs+TQSWRd+RYku6jyyQWocl
         ltbA==
X-Forwarded-Encrypted: i=1; AJvYcCXV/5+fqJd3u9c5m/I7K0MLkGV2jiKfR+lGatfNXEvhIBEiTyg1KBQUidbgQOxL3vCLZuJknq8sxbjD@vger.kernel.org
X-Gm-Message-State: AOJu0YztxXxD86g/ASrEzLZe0RK+UoMWvR6So1DI9m1y+aK3XTvcvPXJ
	mmsyi72QTG3WCd9RYIQwdx2Yka1XZBhB790ZFNrBWiqDiyS7Q9YylbKFnNU9ArE/NhrfN62f1rI
	b26s5+RpvvsOTmShRJ5zplH9/VKnhKsAa/uxuQuKDnokHUNv4JUnhq6Nx0H+I5vrlSGxCiw==
X-Gm-Gg: ASbGncvt77TwnZlH7sTFlDWVGVhttqiXupw8Y3NdVKBX4fbQQ3dR/VUYqlT3YP9mIpx
	P1sNqpbLtDM0cmoLHmk7Fy+byKSaiFWybeDFxGzoLSgA+8/YWhKV9Te+Vzg/RF8L6j9HhoTaF0T
	DeZsKQGBqR8kNmiXjjrQyrkiHa8x9tqXTyuzf61c6ZxAnvOqE9uR6NQSPeARNGLWLs/Nin1PYlK
	fErSBsCQbbrh7EYhwQO+B4JCbxjFpb7AI3LTrCKtYxwnWGI9zoftG6100xJqU3gY/01zKhnUDDv
	nLq7khI=
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44458285a.12.1734007774848;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Ag6lWJ9NB6/EzRTpVTPEefZcnvZ6mnIYDz3+GXqvWUtfKmm+Nj3KJ0262kDPgAuHx0vVcw==
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44455085a.12.1734007774551;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm327709085a.52.2024.12.12.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Message-ID: <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
Date: Thu, 12 Dec 2024 13:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped ipv6
 addr client for smc-r v2
To: Halil Pasic <pasic@linux.ibm.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
 <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
 <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 19:54, Halil Pasic wrote:
> On Wed, 11 Dec 2024 10:30:55 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>> AF_INET6 is not supported for smc-r v2 client before, even if the
>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>> will fallback to tcp, especially for java applications running smc-r.
>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>> using real global ipv6 addr is still not supported yet.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> Sorry for the late remark, but does this need a Fixes tag? I mean
> my gut feeling is that this is a bugfix -- i.e. should have been
> working from the get go -- and not a mere enhancement. No strong
> opinions here.

FTR: my take is this is really a new feature, as the ipv6 support for
missing from the smc-r v2 introduction and sub-system maintainers
already implicitly agreed on that via RB tags.

Cheers,

/P


