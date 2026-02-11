Return-Path: <linux-rdma+bounces-16745-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN0yMeBLjGmukgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16745-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 10:29:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2118122BB1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 10:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 806A53016B0F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1D3559CF;
	Wed, 11 Feb 2026 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzOpDRGH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rIZ0Mbo/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4632BF55
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802101; cv=none; b=j2txeCzNxrEfcVWVXxMyjIZAnlNqNFuZ8ZqdstsLhpOSVisqXwodVzOUFQlrw5QM+1mByMv60qqNhQ6yy4iAf5yFopgsQ64FsvoTkjhs+HIp4UUtX4X72YTSClzckTDL22kFzU8uOe2gIT7b0DIXKr8w/a3c3800F9oN0csTLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802101; c=relaxed/simple;
	bh=UPbB9FRWnOPN8Vn7UmyocTYgvL6IlQpeN8CZSHDQVOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMBEjZx354JB5DrVxzAQBK+1L7QqF9625YGx1vHaC2OvdajikJy2iqG+hTrsyGEKI8qwRZDO+5mS6Kz/+zrIqS+5hg/ltormp6HT2SckoOJztB5VHGsl5o9cIwyisJmtiVOWvvkmNhctHGzsLzzivgieHi2HFXnoE8ExQdjRhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzOpDRGH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rIZ0Mbo/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770802098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwv4TmSM/nZBGEwsH7QgKLc13ylHJw1WSllP1Yiyomk=;
	b=VzOpDRGHR+hrGPwGRsySvKBn9pXQfvii0S1Q5BvdJ93p97yUcjbkLoxEIk+nuO4ceKW/qC
	S6+hZ7i4CP6iE/505MA4D+wBDsCdSKCss9HhZdkG4v9bYns6OmMkiPR0eUrcOuQ/TRLM4h
	7O93X6BlsKysDYi4gUkoKXxjn2+yVcQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-jZeK3hF0PfWys53CV3qd-A-1; Wed, 11 Feb 2026 04:28:17 -0500
X-MC-Unique: jZeK3hF0PfWys53CV3qd-A-1
X-Mimecast-MFC-AGG-ID: jZeK3hF0PfWys53CV3qd-A_1770802096
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so2524927f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770802096; x=1771406896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwv4TmSM/nZBGEwsH7QgKLc13ylHJw1WSllP1Yiyomk=;
        b=rIZ0Mbo/w8ZXDR39CIBvmeCqaSdd76JNbhzYCnPMSyjSHCx047oeFAyN+3+qcTAeeR
         DxP0ozfdkU+AK1mrwy/h1R2ABsVYPt9cSrFWg/JMPTj8eSK7CjNbHXXTg1dLaaD/JTaJ
         gbfKT5NLKonuDNhfE6EhZToQwUKA77GSEWwuSzgPfdC1S4JAzAUi28i3cWe34h7qGsH1
         HS++PQeCFFRCqT9lzAqhV6EKSMrvEXQJBDGZVV/khq8n12EuvAcbrk/7bk0QRjaeSPSx
         oah6k3XRctSRFHXwR9OGNkEDe2wFLQIMU9UurkAKt9nJsh2+406fyXFF/zbLPvA7lugV
         L+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802096; x=1771406896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwv4TmSM/nZBGEwsH7QgKLc13ylHJw1WSllP1Yiyomk=;
        b=MO5ExPkWzlPPdnFIwQH8fDne5qjSZl3k3BSyXKEtfR6pob3a6+BaqiW5W9T0KwhhLi
         jbG53pVCE/L1FJ3ZX/Uh9zrs9CJ/j2/S5iF7jgqum8IOyK806Kcns87n7PR1BxNpuvfE
         nbnOSwTbIyU3DX8y/EcBWmDuTLRKukhtUc7LIoVSYdEDncj7jFdev2ktKJwIRyW+fCbU
         zKa01mcKmV+y41cLF3TmVnvXUyG+8uh5mRMvp8zWuxrr8OQ2lASBriHUObpWzLhOh2OD
         9fddLfNNRhmybqnUU+Jd+EQ4KXWsH6We2e7+ECXeRrfUn9rwfMJlKZtq1h6xPIXezTox
         E/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUyX197rF/nvaR7H5GCdTOOpiCXuQWgntvFXJ5XKwDvbVJjDVrs8hUnwv1qECbvqr/L18A4jB4HG+kx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+F95TaClUlsT7xUurWnubXvckiqizuylpg8en0uCrS/y9xOTV
	RPMn8HKcp6hI579Kkpn8haCy3ONiuv8qg/704r4xegbSymc+OMYrBN6LZQQLdBBuWXiTer224su
	ati5VAdai5EI9DKsP7fsEFxG/OdeqXP0k+Sd68mIuXnyjMaXfpDKscqe+WeyQUEw=
X-Gm-Gg: AZuq6aLJgmKgimFo4GORKr3sInZjhgyTsSQLhsGzojR6367MYeFwOjUwkLkPSjKuw3j
	4CSRuBMeyhEigwMxjLX+Z9TpqUhsosQ00CtEHHDNB/EdulJeEx0hEtTzLXODDH8QCXSNThZf3rY
	EgbvV/WM2B4K1ZwFF7NXmhLRWEQ531hQ3ndwLQMSELCc0092bPecHALFDcyX9wrplASS84J1meW
	2Eo13spGVLzn4TO4ptQhtVqsAjIkGuLbllSsAMIze6iUE8eWWGU3YK7rfHrYxfvL8wsTBqIq6L9
	rSxR77ELJT0yAXFg0fuMNRiYhJGOXkY2dkrZfci4S256l1EmfeTXhaWqbvEuZ6IKlN7F00bKQD0
	b7IJhFhIpTfzLiwXVqtDI4MCbnQ==
X-Received: by 2002:a05:600c:a4f:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-4835b947ce1mr20546205e9.33.1770802095628;
        Wed, 11 Feb 2026 01:28:15 -0800 (PST)
X-Received: by 2002:a05:600c:a4f:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-4835b947ce1mr20545875e9.33.1770802095215;
        Wed, 11 Feb 2026 01:28:15 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a1c2sm174681995e9.9.2026.02.11.01.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:28:14 -0800 (PST)
Message-ID: <6d00bb79-eca1-4649-ae5d-e81462c30f1f@redhat.com>
Date: Wed, 11 Feb 2026 10:28:12 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/5] net: ethtool: Track pause storm events
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 o.rempel@pengutronix.de
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux@armlinux.org.uk, mbloch@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
 <20260207010525.3808842-2-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207010525.3808842-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16745-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,pengutronix.de];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E2118122BB1
X-Rspamd-Action: no action

On 2/7/26 2:05 AM, Mohsin Bashir wrote:
> With TX pause enabled, if a device is unable to pass packets up to the
> stack (e.g., CPU is hanged), the device can cause pause storm. Given
> that devices can have native support to protect the neighbor from such
> flooding, such events need some tracking. This support is to track TX
> pause storm events for better observability.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

AFAICS you forgot to retain Oleksij's reviewed-by tag from v1. Perhaps
he will chime-in again...

/P


