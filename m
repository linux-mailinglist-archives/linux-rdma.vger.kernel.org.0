Return-Path: <linux-rdma+bounces-2589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D48CC4F6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 18:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04FFB21F1D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9421411EB;
	Wed, 22 May 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvNIz+RM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2826AD7;
	Wed, 22 May 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395837; cv=none; b=Rtl7Pu8jl4pvGJkyDXO2+F2X3amMQN2lH2OojrBBThnKLwD5X/xz1hBdKxJ3PyNI5DOmq7HV029ieuX8VMkbmPppSk3z5TDPFSfnBYpDv7PX1qpPVZHqi7/Hp2aXreAYLQRgIKpKv8EAigyzJodu2MCx9kpjHcC2d7JEWoXUyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395837; c=relaxed/simple;
	bh=OPRA3FUZBoBovwiYjKJevz+MzGYuVGCZhkXsOEfajWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmgFOM50uaeJwcKX/l44sshmm9hanpKDXIIFICelyCvJ97aSjjnBb+JYZsUbiAuucBg3bOL0NDGGhne0XDZ+BBxE3YeyEuJkNwgPdhklnsoPr51fhD3ScLt0WrmntjnBNH5wMGBXYvj6xTRoRM0Ra7a8OFOQdTw1yIn2/G0dGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvNIz+RM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f447976de7so2478044b3a.1;
        Wed, 22 May 2024 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716395835; x=1717000635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fLC3+2/b8athVdAjNdAdtF6LJlJTIZGeSogYFaPPNA=;
        b=WvNIz+RMTssQIqK/92L1ML1KhSoEFSUkxGHmtevwR6MZwMoTNJhuU3ooRXeCGQiFIh
         aJNZZQrPRTK+wGTkUPXrjMUxUEl3mACQIil8bC/eyN5eVG3lc+R1ihffG3PR1NMlvZrR
         e1EssjC4MpFUT/uCyRnif0B2jKStrOBUxce7bYrQJRHzigqJ/Po7JPtMyFVDrjGO3/6b
         858iQKxYLzL8Y1Ul+rAmu05kmT4HSmdlArn+qpBd/6AYzG5Wru4xcHbMNREDnLGDNmNB
         z1hIqiAB7kVKn+2WBfVox2v6CLVMxylo0iyfBJWgNnnAcQw0uBca+xeo5s9UrLuNHdGI
         3ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716395835; x=1717000635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fLC3+2/b8athVdAjNdAdtF6LJlJTIZGeSogYFaPPNA=;
        b=Nm/Ldw6Z6mUk2Fp+jN7uF3J8IgLV06Lj7fN96t4Kw5QDH+c1U4+AuIl/ApjsOPieZj
         kfmZiZnAi9Q1CzlFLiuchnZuJLG3GTV9OZoT2z/RpzqoKI4+0h8nhDcBEVZC7UC75q6J
         zTugcvWIHVHJlnH1qQHN4e3tFnadSXKJr9iqQtzu+Kl9r4ZFu8SQmD0ofnbC8rMhFJom
         pEVVM8nTOxPa1wf8wu61DCBgm092Lt1nJJwifIKkLLn5kFoMf0/WEK6xcVpRuzL92p0l
         KzefCzuzkw1gquZVukFZ9HwLO257BHrfHlmVOpJ7m6uDF0r1UCusSjx7PDDsd85MFwIZ
         4LVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTG1BirEnnXqXNYYud8NBmof9+r6+jlhQndLolubalUFEWNk8PYLnKg1VvOFhMmrvapVGNKvOB7OzEpblkzeiZGqU1kheVkwomwG7pLqJsV2Vpt2UVuIzv3k4HPgh8xIzniIq5
X-Gm-Message-State: AOJu0YwvW8dUenJTt9ng/t5l4rhugA1T7t+HEF/apHYcrP+d33XrlgNv
	j8PGv7uUIO9BOurpqXzOdjDsm49Mw89SMsi4rzwfd3gwxXjmQjYk
X-Google-Smtp-Source: AGHT+IGsNVFpNsjJl6nkL6TcIWCfQ9Nnc1YXfE65lJq1XVOE0KT/iyLfgR5YJyvil4mu7PUBbhaJSg==
X-Received: by 2002:a05:6a20:431c:b0:1af:cc48:3e25 with SMTP id adf61e73a8af0-1b1f874d86bmr2766603637.10.1716395835293;
        Wed, 22 May 2024 09:37:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada410sm241322635ad.69.2024.05.22.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:37:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 22 May 2024 06:37:13 -1000
From: Tejun Heo <tj@kernel.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v3 1/6] workqueue: Inherit per-process allocation flags
Message-ID: <Zk4fOU8NCn755vv3@slm.duckdns.org>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
 <20240522135444.1685642-3-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522135444.1685642-3-haakon.bugge@oracle.com>

Hello,

On Wed, May 22, 2024 at 03:54:34PM +0200, Håkon Bugge wrote:
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -406,9 +406,18 @@ enum wq_flags {
>  	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
>  	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
>  	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
> +	__WQ_MEMALLOC		= 1 << 19, /* internal: execute work with MEMALLOC */
> +	__WQ_MEMALLOC_NOFS      = 1 << 20, /* internal: execute work with MEMALLOC_NOFS */
> +	__WQ_MEMALLOC_NOIO      = 1 << 21, /* internal: execute work with MEMALLOC_NOIO */
> +	__WQ_MEMALLOC_NORECLAIM = 1 << 22, /* internal: execute work with MEMALLOC_NORECLAIM */
> +	__WQ_MEMALLOC_NOWARN    = 1 << 23, /* internal: execute work with MEMALLOC_NOWARN */
> +	__WQ_MEMALLOC_PIN	= 1 << 24, /* internal: execute work with MEMALLOC_PIN */

Please use a separate field w/ gfp_t. You can probably add it to
workqueue_attrs.

Thanks.

-- 
tejun

