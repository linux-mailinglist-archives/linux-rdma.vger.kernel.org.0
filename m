Return-Path: <linux-rdma+bounces-2458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63248C4545
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81329B2099B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FFA18C3D;
	Mon, 13 May 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQZSbtyi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2B17C95;
	Mon, 13 May 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618924; cv=none; b=JJmcV4BknBUEiZrnqCMHX366HZtt3w6TkeyPNxxbJCYQIJbR2K0oR5GFqpc0fRarupRtD06Y3Q6BB3riFi7L7pv4e/Ovm+0SfLbnCYselpYNEQn7lJwXbLI/x4xOHePjnr0j4erzg0cw28aelPxicZi0/1ys5ZCCNCGxyr8oqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618924; c=relaxed/simple;
	bh=VZYkjSb6DWCUJwKCbLxr+IJcvhEU6M6GYKRNUvCOrHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkEx0oo+oJwf1tVxpU3oTRlLXACYsfhqmbbMkKP1NJNB1+bxvBK3dTgQdt4xUoomG7MhpFXNkHU3A5xldB39uyOK+pNKQO7KfUhuZSeN+SWjsu0I4SlmMO00EmEj/XEoF00g5Naoi+y4PfvJqt5RGt5gyaxopnXQ1Roh6yb87eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQZSbtyi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ecddf96313so39384005ad.2;
        Mon, 13 May 2024 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715618922; x=1716223722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kac4Zeh2cIXzitZj+a2ebGBL/xE0N7jX70xodaorgd8=;
        b=gQZSbtyi+pUIN3Cn+G8Hd5eN9V5I6LYCnfXRXu1miPdWGJUiz+9pDE4KvoftK692Bt
         MFN10HkvOEFtUUlh3c6xLKP4gnLavfgkymEXCKVcs1MmRHhqCKdEbdkUIQUnwQRoj2Kl
         33N6JRmy79g6yT1+MvEriogUQDnQXz7oryPNLytRua4tRCoW00FEAskdKRGbK0SUdjVQ
         PYdUgpukhvEsZR/hpUcIDVQZY8IeAsmC9TuxR8/9AuZGy0WMK1IMoZ5tdDh5OdqFU4sW
         9nl6uCQUXZqP7mNtlmwy7ERPkygrckFcHdOQh8TIC4Lg/7kV8SxOuvZENx+ud975EiH0
         exbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618922; x=1716223722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kac4Zeh2cIXzitZj+a2ebGBL/xE0N7jX70xodaorgd8=;
        b=lOLSk3ZwuUH7Me0VV2I8+86DUUY7xqPWNTbKojQT0AmxwGLFAe2e+Y1CL2WbPU4CRG
         M+NTxb4cwS8RRN3d8yQiD5TAa06hIXPR4/NqY7KtZaFx8yf5j+6J87AfXrrq+FSdzfIN
         BK7arCRXD3XK1TEKsBmtgEgxgI9k26gBr6jiTotmmXAW0GEdYnY0fxm9UFuRyuV2c5vd
         MxpqmBejmc41xkMQFK5ky5oRcvL4jCirxCoHiIUfywv7vVvAzcW7GDLp7s9vz6LmiD26
         dVXl51Wsu15pn6BJiXpLXzCSkVWnLfSkcJZ3JH6A6pdImplLiuUJM9zipOOUr4vqyzif
         J/0A==
X-Forwarded-Encrypted: i=1; AJvYcCUbXFknM4tP27OBVnYVtT+G6q6evRpaBkETgOzawMmprTiqTDk+ekhDQl52QHcSi8h85cfgkxG1Hy96IxYqMugkUrEtt9P5PkgkmE6XFfdLsDu6T3jcs8PJgixWNvOVDo9wtyMn
X-Gm-Message-State: AOJu0Yx6+xTIxw1g+chi+Pp/+T3MAHCHUpR35SJUBd/mNTGjCkc4nG1C
	RTBfMlsd1CNMwXN1l1jeXxgM/5/fnbpjrpLhgPeYT/nASz0g5mFG
X-Google-Smtp-Source: AGHT+IGe852ziRhP3hKGzTtryZAf7Y23teDVSjb2hjIYcr8OLeHRzwFp7mMVdV7volkrj8d33sTYHQ==
X-Received: by 2002:a17:902:b18b:b0:1ea:3798:e404 with SMTP id d9443c01a7336-1ef43d2ba22mr123930565ad.31.1715618922079;
        Mon, 13 May 2024 09:48:42 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1368desm81802925ad.233.2024.05.13.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:48:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 May 2024 06:48:38 -1000
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
Subject: Re: [PATCH 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Message-ID: <ZkJEZuNRqIVUGcSn@slm.duckdns.org>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <20240513125346.764076-2-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513125346.764076-2-haakon.bugge@oracle.com>

Hello,

On Mon, May 13, 2024 at 02:53:41PM +0200, Håkon Bugge wrote:
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 158784dd189ab..09ecc692ffcae 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -398,6 +398,8 @@ enum wq_flags {
>  	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
>  	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
>  	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
> +	__WQ_NOIO               = 1 << 19, /* internal: execute work with NOIO */
> +	__WQ_NOFS               = 1 << 20, /* internal: execute work with NOFS */

I don't quite understand how this is supposed to be used. The flags are
marked internal but nothing actually sets them. Looking at later patches, I
don't see any usages either. What am I missing?

> @@ -3184,6 +3189,12 @@ __acquires(&pool->lock)
>  
>  	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
>  #endif
> +	/* Set inherited alloc flags */
> +	if (use_noio_allocs)
> +		noio_flags = memalloc_noio_save();
> +	if (use_nofs_allocs)
> +		nofs_flags = memalloc_nofs_save();
> +
>  	/* ensure we're on the correct CPU */
>  	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
>  		     raw_smp_processor_id() != pool->cpu);
> @@ -3320,6 +3331,12 @@ __acquires(&pool->lock)
>  
>  	/* must be the last step, see the function comment */
>  	pwq_dec_nr_in_flight(pwq, work_data);
> +
> +	/* Restore alloc flags */
> +	if (use_nofs_allocs)
> +		memalloc_nofs_restore(nofs_flags);
> +	if (use_noio_allocs)
> +		memalloc_noio_restore(noio_flags);

Also, this looks like something that the work function can do on entry and
before exit, no?

Thanks.

-- 
tejun

