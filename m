Return-Path: <linux-rdma+bounces-19384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHkcF0Kc4GnokAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 10:22:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07540B77B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 10:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 914ED3013845
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000E38F64E;
	Thu, 16 Apr 2026 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY70BlwA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK++YzT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A5378D9E
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327636; cv=none; b=uJ+K1zc0LsNdWGYBn/kKOI29QrzY4L+YZ0D4gCahoDQ/V2GiKFL+rq164/29aaDLMd9jrOFFK6NgT35/h5/HNuun+oojrOCCk5bi9I3c1gVSXOU6AKZlvKeCxAA39JpkgDYOci3skxEtNF62J0A88XaAgV1oDRgfzhtPfhYtlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327636; c=relaxed/simple;
	bh=jKVD7gcqSOI/d89shuIq0QcEvDTqxrAavgJ4nLtzFb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swHZ7UeIVz9yLfWftfiBphunMUHyEeH2JNfhlEaPq7k+Pk3rcD0s+CHnxJKbET8Sjpd57JjsWotJ0HYNwVH8017XZXwR/C4pvSUYco8imF2B0v6SjcqqoEtiC54592MiCtKZ0N2mjHOssqiN+o0pAgCjfAHFoSY4+CwMBp4wjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KY70BlwA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eK++YzT4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776327634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o1lXFcqNizTAH/JWCRzanFNBvkMTtJb4hA4booKnh8=;
	b=KY70BlwA5F7YgBJFn6G+gttnTtWeveDG18fG5GvG0RBB2/Eku+rtR2M59wDD+EDydjUjA/
	O1VuFjhTBrdFlqEfcGU9g+//YE5oN88NyCRW3ZJ796RueGGr4kqUwPJBU1+KqiqX4UwVTX
	ULRaEmsj8RXlojlCKY5hVWa1GlYYsLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-b80-h5YyPOKTqIyijDCUhg-1; Thu, 16 Apr 2026 04:20:33 -0400
X-MC-Unique: b80-h5YyPOKTqIyijDCUhg-1
X-Mimecast-MFC-AGG-ID: b80-h5YyPOKTqIyijDCUhg_1776327632
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cfb72377bso6635312f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776327632; x=1776932432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0o1lXFcqNizTAH/JWCRzanFNBvkMTtJb4hA4booKnh8=;
        b=eK++YzT4DupNvloihQ2ZGZ5y41XHgodmDoOW/rn6N2CtOP4+xWrcnCLyuMGObdUSKZ
         q6qlnoDkQk6NeLjaYk/7p5LWA15lOsjEZAYsypIpzR2KO/8tKuxFoe1rsMn9ddNLgWXe
         zMvFrdJ10zuRI0A3EdVusKvHrtYTtgvIjlYb4qx5Ff/dJxt7IZtj1bywKDrGtmJsZJEV
         9Dzpl/vzp836g/5NDFqKL10MpnM6JmPWWgGJvrMeIBHujMa0cQemWMhvkhIKQfXWA8yu
         dEN/U7DbBvvF20XpK33TEIvhNOUXSXvqPVsq0ZApAsBqFxvLsraqTqvdvZfaUqLzUsN/
         y9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327632; x=1776932432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0o1lXFcqNizTAH/JWCRzanFNBvkMTtJb4hA4booKnh8=;
        b=qSE4IyEkoGWYUBdzcvxCNfGgxUU2V0xcWOhx0sHMR0DPxZIIdzTkBk88XrXVmvAZIb
         hoxDF9la168twqb/dR3uBM0Vq7pv2XTy2wTRgz8yQN5+DY8OhKYQsg9NBQSpEgkCanGO
         ZY/cq1Gu6r6Ws/MzCuJb05q75oAACjVX/hz8Z/diQmw7CUmRgTE0Ha3oPIt1pCLvpJQP
         83vpkH9d2caZFHQ0BXX06c8KSNOA2dn6jc2qCGlgaHpNcON7cqDkz/si1wO70hxqUAxw
         ZIx7lXDguvWG2g03GHpWNKNAd8plIGqzDkYmVwvSRXahhxuAy8RHXEOzE4naXGupJepS
         e05g==
X-Forwarded-Encrypted: i=1; AFNElJ9Gw5x4WoUH4rx51n/QP4QN0EFVtO/OscPaBOgNazHxBZTyq9q2E/PGEuXD0+IQbFKEt/7+U4yvl78e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yLR16sTHxPWhUjbSsd3dLVI4NzNq0QI7vv1TsnEdxY2vuVMr
	1oJFUAL+Q2R9LgICYS9qRUb5nodhwILx4xxpBlSHZ626O8lmVZFQy3E/o8Xm4XmjrduNeTAQRLa
	C8LB0QeOjUHiO9+fcw8ogX4x5YG708TbeFO/rJdjbyIUskLFirMAJorrvr4PNjdBZ8QvDxpQ=
X-Gm-Gg: AeBDietFIviiDfYYUDSkkJ8dyCpwBP4yw7HLmzYhy2w2KNVcYFsPLo4vgSUCvMLqHdg
	fnm1nGtocN6PD1mWuR2O4lc86y6fru6WFBm/w1BQLUOkyCiWZj6rES/hubJD9ezHjGGZRYyD5TA
	lqGc840oBoM80WEgtzx7JyeU7z+r5Zm7Xn3IPVLX9ifbevgDdDnT129j8cGy3VOpQmijt8xc7cj
	J8suUJ70UlMqzmCl0bjRaDLh2OUdSS+PD6j/f+Ege2QUNDYu+CY0A5AZMYUv0FW1aftUd5Bj/bG
	i2YsQE6lffY8iif/t3u16gnYsHOClNkM5/Uk85QKRNvE1JhfvvIXoJtvdaWj+0YLbT4Aozz1H05
	SoRAwfv1Ruap/EYw0yZAa1qIHIos8C7rgpqBHZTtAwyan68KWErO/Tr/aP6V/7Tl1KDQ=
X-Received: by 2002:a5d:5d84:0:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d642b6a47mr40994719f8f.29.1776327631726;
        Thu, 16 Apr 2026 01:20:31 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d642b6a47mr40994653f8f.29.1776327631147;
        Thu, 16 Apr 2026 01:20:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d670sm12883172f8f.2.2026.04.16.01.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:20:30 -0700 (PDT)
Message-ID: <d0e820ce-2a79-4443-ade5-a03d16f712bb@redhat.com>
Date: Thu, 16 Apr 2026 10:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] RDS: Fix memory leak in rds_rdma_extra_size()
To: Xiaobo Liu <cppcoffee@gmail.com>, Allison Henderson
 <achender@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20260413070005.15272-1-cppcoffee@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413070005.15272-1-cppcoffee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19384-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E07540B77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 9:00 AM, Xiaobo Liu wrote:
> @@ -595,11 +600,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
>  		 * nr_pages for one entry is limited to (UINT_MAX>>PAGE_SHIFT)+1,
>  		 * so tot_pages cannot overflow without first going negative.
>  		 */
> -		if (tot_pages < 0)
> -			return -EINVAL;
> +		if (tot_pages < 0) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  	}
>  
> -	return tot_pages * sizeof(struct scatterlist);
> +	ret = tot_pages * sizeof(struct scatterlist);
> +
> +out:
> +	if (ret < 0) {
> +		kfree(iov->iov);
> +		iov->iov = NULL;

Is this really needed?!? AFAICS rds_rdma_extra_size() is invoked only
via: rds_sendmsg() -> rds_rm_size() -> rds_rdma_extra_size(), and the
rds_sendmsg() error path already frees any non NULL iov.

/P


