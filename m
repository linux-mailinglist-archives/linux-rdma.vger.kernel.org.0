Return-Path: <linux-rdma+bounces-2501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E248C6B05
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7BE1F2376F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258C2577B;
	Wed, 15 May 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtLiJ4b9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BF1802B;
	Wed, 15 May 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792054; cv=none; b=YSFNlPxQpKSCwfkPQsBabVivkc/vUcgO3IdelWtJ8tDemWYg60mk3CPhYZLuaYnGtclaPxLtxGAhBAAhSdHi99GrzUu0XogHpw6FZ+kyZfm/X4wQLqllkHoh8ulDSid/M2ircmNmgGgfWJw77tSBlnopRIHh21jW0/32iIe1Wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792054; c=relaxed/simple;
	bh=ztXRocSxSM/WZSEM+IHjw3F+GdmcJfnokqhzl/hw0tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1tuPfpr5B8hYXjMA3vTKRiBFL9JYs6+3oAVwfRHH33EjiDCVcf9QSBO5KwiEHl7hNee/yTvcACx83rdocyhlz0hp9pruRwjYwFuclT0YEu5JMBNMgOrCCmS57LxJGHELc1KosrjdfIlwri1vCi8dv5Z8FufLTAGll2uL24lkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtLiJ4b9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso51134795ad.0;
        Wed, 15 May 2024 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792053; x=1716396853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeJ50cYOsMUIbdy+0kSEcT3sVthjv83+PS4iIfn9wB8=;
        b=EtLiJ4b9rloK6CeJ3utu470aHTW19dq7WUj1h3FJK6LQO/OXX6EoV+Niqb35VGFha2
         NdfbNH7NLAt5ZT6jaIZrx/BJkKhIEHsLY4k0gKFM6xIW4XVJ7oUDlhy9leEFRdvGnZol
         S8tWtX2x6pEaqcteCBM3hTLdUUG1Za2MIrA4oRD3EMpGCrymduHJgSsvfi+XVzeRLx13
         y8ty6CS4AGnoZEU6l1KIXgIIMbBzvQx+YEEHDQxgEIO4iro7b4CQI8f7efcNEgS2VhJw
         ExRF2NkbShNIzH7hCRr57cS82SDAEGlxKl7fnW8Woli28crU7idQ1kp/4gwi85C2Z+hu
         64qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792053; x=1716396853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeJ50cYOsMUIbdy+0kSEcT3sVthjv83+PS4iIfn9wB8=;
        b=S1qBuo4O9am94kjhJQdpzatrySJkUmn+6akXzKFlx6YqA/Iybu+vdAtcvKx1hKpPDK
         YZ//TJMvVRa32s7PSa2v7w1PjpUNFSgC13bx9MGKokgUXCJSVgXYUSF6He64on5YD76O
         SAncWciVxfnL3wAvBFPrBFWFYX/h/F5MSHcn2UgEkaucVWvHlyD2BN6H9C3p2PP3fi9H
         7F4cwHZEvuSRp34+6IzdeHjGNdlJ5o9VmbMT97ewNAU/9lmGNxdHswu8A7h11yhIFa/C
         /IS8s7Qh+pBcttnsYAEfGO2e180WNwZ6ySsKDscar9qJ9gujMkqmQtD+oDUz04KzlCm9
         na9g==
X-Forwarded-Encrypted: i=1; AJvYcCUrXFVeVvmoiwHT6RF+J2bQuxFj3mKiNa/nB9NGNlBAum/7uwh2H1HVAATYKWbOg2TJUsHCAr7q1lHXcULHnCI/TfxcedfNNAKTKhiu8MbIja7hj5bQAA+NYcRes8TTVnUSzMDO
X-Gm-Message-State: AOJu0YxYI4vcL+7D3RbaeatDDDYU0XkvSIuUylSYfhPg4vzLOAz9VuPU
	BmMlFaInWh3VXkk+kK+4ulE2fyeV8Bjno0WSRWB5Xbc44HFlPkum
X-Google-Smtp-Source: AGHT+IFrbKFQTo/9tl2R+tjDagtwuK7RCCzKhqhw+kSduSrujAOUzv/xEE0Ml9CrO9VBTYqRD7m7dw==
X-Received: by 2002:a17:903:32c4:b0:1e4:2879:3a38 with SMTP id d9443c01a7336-1ef43f51f37mr217088535ad.47.1715792052588;
        Wed, 15 May 2024 09:54:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1658sm120548375ad.35.2024.05.15.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:54:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 06:54:11 -1000
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
Subject: Re: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Message-ID: <ZkTos2YXowEFS2fR@slm.duckdns.org>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-2-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515125342.1069999-2-haakon.bugge@oracle.com>

> @@ -5583,6 +5600,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  
>  	/* init wq */
>  	wq->flags = flags;
> +	if (current->flags & PF_MEMALLOC_NOIO)
> +		wq->flags |= __WQ_NOIO;
> +	if (current->flags & PF_MEMALLOC_NOFS)
> +		wq->flags |= __WQ_NOFS;

So, yeah, please don't do this. What if a NOIO callers wants to scheduler a
work item so that it can user GFP_KERNEL allocations. I don't mind a
convenience feature to workqueue for this but this doesn't seem like the
right way. Also, memalloc_noio_save() and memalloc_nofs_save() are
convenience wrappers around memalloc_flags_save(), so it'd probably be
better to deal with gfp flags directly rather than singling out these two
flags.

Thanks.

-- 
tejun

