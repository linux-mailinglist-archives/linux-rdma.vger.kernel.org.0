Return-Path: <linux-rdma+bounces-2514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54A8C7A5C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC18F281E21
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB301514D2;
	Thu, 16 May 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TibPwk7S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B241509BC;
	Thu, 16 May 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876980; cv=none; b=mPrb5r+PRL9CkEuEtohE0c4eOR4jfpom/gCptkYqc2MDckFu3StE7FiX9DZ+iMXE+uxG1n4nQN3nEaTxON35dUDvhSHtznPm8up7rrZWyQIEUJRRKnbfVq1KVLnvCSbRMari14MfMX1xkaXNUkQGRs4N9rRcR5pMrFyWoBB0pUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876980; c=relaxed/simple;
	bh=lY+7S4A6XSmJq1CdWc9SPvUyzxh3QRd8mgOGmumG8w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhSwoYn0/6VL8x5qs2nEEeLn8f/ExEbzJkup/xmyXLLrS8RsAFg5LK5XXA66+Lz2xwebfYhY5pOzQhZbISzQeB2J7W3UuOnpCR6KfXWTtUezeM4kPgo4xgQQXYGyQGg25iyfs7/8dskgifVXSUa0Tlk/BwJ4xkJm4Dw5B9sey0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TibPwk7S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ed0abbf706so61765135ad.2;
        Thu, 16 May 2024 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715876978; x=1716481778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCM0vLqYp4D0LsdwKJQuyqySBeLV8hOPzh1mYzxab6U=;
        b=TibPwk7SwXwBkqnqnN4wCILAFaPmj6p0GuOdXjyvAvzpKD9rLIo6AFG0vLeiWOjuDx
         TMBdDYSvEVlkyPG5ZPZllRnfBh/ej73hEskaC1TzJRRDg49/ylg5UVbOnczcJj7sOR5z
         muR855P2HL0OIAb41CTbpGFqfUXx2KLpAfyTTpYgFyvA5jEyaH7wURNjnBSst7qT7cWq
         tXJHy/A57czsVGyE0nUYbGITaUXTy8n3SMnXoyhGPTr+vIEljSYQ95S6y7yFRZ2cr6Uc
         DoxoJ7g/OTUL8zNVAtiOkquWvF48T7eEe9KdcwxEB22RD/RVHfTevKYnLpK9HpzO3ukP
         Lb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876978; x=1716481778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCM0vLqYp4D0LsdwKJQuyqySBeLV8hOPzh1mYzxab6U=;
        b=cwxid7mfPH3ylpDMly4GLfGpROT1kqJgaxHCm1RKrJjaI62iwNunJKnSclBzHqP8li
         hWi0x0fCTzKRRVjpWqi87sbdQPXBh6uRgSm/wRftr8GRmn2hLtoQxxlJ5xPG80RH4FYm
         rfTjKP64jkrMy/bS3ueXhkd2lpvY5zUjfIdhGfYw9tiyJOsmk6uUDZJzESTxqIb5o4oh
         cA63MfEpQZ/BsszylBnf27+lwJgxz3TipX4vvDxcOnXqy+NVoleMpIi+mgckZzOTrFZ1
         /bkkiByzEDS+sDT+I1w8wxmdDmmeFfh9i8d8c0jzpSir0AV7CzcrgE4MsgyFpU0XTcVW
         sF9g==
X-Forwarded-Encrypted: i=1; AJvYcCUInG6fnSk9p58YIKkJU/Qpk/V2TCYtNX/gHGSV5x1BTbd5RpwbLxX89v7cqmHzNr5YS46D82UqFeOC01E2JPfZfR3KvjjYKuxboM9Gr8gPmk81ygloRSLlK210u90/CJ3B5vVq
X-Gm-Message-State: AOJu0Yz2luYjbVdjtnN++Dbteeut2PknwT8fcBSRC7DWBhNvaLz15uQb
	CRdHT+4q3sHHTHeJPvYGYdS8xRnSCr83kxtHg+oePE692F3IcKk/
X-Google-Smtp-Source: AGHT+IEKSm615OM2jZEEZXeRy8N6csz1RX69uyZnxpvohc49WnXZe704AwFWfI/zi975MB8nCXBC9A==
X-Received: by 2002:a17:903:230b:b0:1e6:7731:80 with SMTP id d9443c01a7336-1ef43d16e69mr252547495ad.11.1715876977933;
        Thu, 16 May 2024 09:29:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c09sm140439565ad.130.2024.05.16.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 09:29:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 16 May 2024 06:29:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
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
	Chuck Lever III <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Message-ID: <ZkY0cIiFOmkwzn5G@slm.duckdns.org>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-2-haakon.bugge@oracle.com>
 <ZkTos2YXowEFS2fR@slm.duckdns.org>
 <D9786636-CACE-47E1-B4B6-26AB2C4244C3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9786636-CACE-47E1-B4B6-26AB2C4244C3@oracle.com>

Hello,

On Thu, May 16, 2024 at 03:27:15PM +0000, Haakon Bugge wrote:
> > So, yeah, please don't do this. What if a NOIO callers wants to scheduler a
> > work item so that it can user GFP_KERNEL allocations.
> 
> If one work function want to use GPF_KERNEL and another using GFP_NOIO,
> queued on the same workqueue, one could create two workqueues. Create one
> that is surrounded by memalloc_noio_{save,restore}, another surrounded by
> memalloc_flags_save() + current->flags &= ~PF_MEMALLOC_NOIO and
> memalloc_flags_restore().

This is too subtle and the default behavior doesn't seem great either - in
most cases, the code path which sets up workqueues would be in GFP_KERNEL
context as init paths usually are, so it's not like this would make things
work automatically in most cases. In addition, now, the memory allocations
for workqueues themselves have to be subject to the same GFP restrictions
even when alloc_workqueue() is called from GFP_KERNEL context. It just
doesn't seem well thought out.

> When you say "deal with gfp flags directly", do you imply during WQ
> creation or queuing work on one? I am OK with adding the other per-process
> memory allocation flags, but that doesn's solve your initial issue ("if a
> NOIO callers wants to scheduler a work item so that it can user
> GFP_KERNEL").

It being a purely convenience feature, I don't think there's hard
requirement on where this should go although I don't know where you'd carry
this information if you tied it to each work item. And, please don't single
out specific GFP flags. Please make the feature generic so that users who
may need different GFP masking can also use it too. The underlying GFP
feature is already like that. There's no reason to restrict it from
workqueue side.

Thanks.

-- 
tejun

