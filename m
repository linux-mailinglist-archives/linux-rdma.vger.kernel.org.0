Return-Path: <linux-rdma+bounces-6185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA959E18DB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8DEB36D56
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0077C1DFE1A;
	Tue,  3 Dec 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6xBdlZJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DD181B8F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218750; cv=none; b=dKJ+StCtbEgV8OJXMWhTJ6KtdmrWuJ/scrJgZQ7CKhLufrxgqGHwL7MKzf0TWBZDCtuv8KHP2ldq6I00h1YAJMob4MCnF/QfFZ73TtWla8cdwqBmJVFktxP9NiC3mr8od1f8xv9ywRm/wkNPhpBOJv0Yea+CQMxVh4FQKugAEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218750; c=relaxed/simple;
	bh=f4yo24MCyvcNw5BjdCp4RT4JHWYru/YdElzMFQMZDkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XszsBSwM+X3bL7N+ODTR/XreJIEjGBw1VRXpbToPLQz5z748GRZuQjWtcUE5/1aAufz3xRk0k8dx+/Wjkk4g4u4ASgJ48NDXKqNzArsq6RHfDKyWkCC4IGRwANyRW7MvkaYRmJmyhOiSHOojOPgQkrePOhkPZaQkqv8bmxyFOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6xBdlZJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so48727175e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733218747; x=1733823547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAfAbX2jpmVWuMhv4f3fZGpU5CJs4ntFjeUeVvna/QY=;
        b=y6xBdlZJDIxUvbRYDMQ3a0rvI04pw8wKHjWx+Sn+fwkgPJn9t5rClPcmRiln8vUCev
         BDTlovrblcX/vAZpPXlOi9ca72C8bCYZDILRjYPZ+OYi1XFOF5UhBnjjxo19D3iIvsyc
         k8rpKomDLIq1Tt8RqsQ9LF4lNtBfOod5E/M1yfLs+V+jdPZRHiEE7AHSSq8eL4a65RDu
         oKExQJk5pZRLpNpdp+/Jyl1T4zemAJpHCWFZ+/G9xXL9kl9Ul9vimkviYkZipVlgQVS+
         ZNN6+YSNsB/S8n8IML5GL9zWM0i0mLHGwjP3+jTjct1gG94M5EAsWfYYlmmHca649/9V
         JrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218747; x=1733823547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAfAbX2jpmVWuMhv4f3fZGpU5CJs4ntFjeUeVvna/QY=;
        b=JoP8lerC1G6Rt67wyEH/kHEFF4iWm0/dUCLikHi4CMTds3OdnEw5fePJFkbe9XsYGB
         1y06jn54MG/YoNZr80GKt84x0YHzxjW+2H6rqA6HmkVfCdrunLGYYX7xLC/UlwrnCLrl
         6corfn6foTYDEP7PfizB6F0Dqu8wgyExxi/gfraXg0+AKOR5/ikoBMjj6e5J5xt45EP6
         bsQN9Dif3GrtBybrCYGhJd24gxFhLKCzxz/XMnoPlY3U2NniLAp1U/6+FMqm3piT1X0n
         uJpTxufZakJpaBbAIbmRUrgDWwc0IEXrPIBOWfdM8RTaENvMPCCXkkQNEvyBAdVL29vU
         aHpw==
X-Forwarded-Encrypted: i=1; AJvYcCVLiq8vq9qDb6jo3+wFbNctMt6YCIwOOLFRw6KAb48JVacxOT3DMGjrWfggN+cbv2fQ6nGJveYNHJOy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1cADsKWmY5hxzITgQMdn5vo8ucKFmFZvzuzxo9+56BvRRqJri
	RAGEu0GAVJUHqMut7g1NwEOWKASpg7r5lFFBNFJIzbO87SG51hWUsvgJ//bD44s=
X-Gm-Gg: ASbGncs7/KNHWd65ixZ+yt/TFCBSA4Z8OKy9AzbQfMXiOEIvVAJw0J5HK8O0Wt3wdb5
	fXX3ZbaEVDwRcEXywbfsaFF7VAwqcZe28cAcKyEPuWEPuhR542Ip/9zVuNoAbLL/bAPq2NqglHp
	wSjuvxRM9nkVBNDg5HTvnjgnct3gPo5spaqq8u5w/OyDvxV4bJmVVzY3Il1rgPmt5CsjTCgE/HV
	DCHAShDqQiQ0wUTwv7ldhyFs8FLFhEvIXsf3zTuPJxdr1x/G29vbKQ=
X-Google-Smtp-Source: AGHT+IFuW8hsbnPhok9NFkBE4GSNLWnfGNwEuWOJe5NvY0AGJzwDm00YwQeKFz6uXex+mAAN6s/h6g==
X-Received: by 2002:a05:600c:138a:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-434d09b1831mr16625405e9.3.1733218747389;
        Tue, 03 Dec 2024 01:39:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32589sm186562195e9.28.2024.12.03.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:39:06 -0800 (PST)
Date: Tue, 3 Dec 2024 12:39:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>

On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> 
> 
> On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > The dr_domain_add_vport_cap() function genereally returns NULL on error
> 
> Typo. Should be "generally"
> 

Sure.

> > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> 
> Please remove unnecessary space.
> 

What are you talking about?

regards,
dan carpenter



