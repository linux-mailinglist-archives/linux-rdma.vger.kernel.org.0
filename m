Return-Path: <linux-rdma+bounces-2998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BD900994
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51128B21075
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE815B97E;
	Fri,  7 Jun 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="I1XLcZLe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B71990CE
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775449; cv=none; b=eAc4W7QMWCBLFMd//6Lj6Ra2O65WS4/xFAkqJzo+LWzh6bxcEfenZedDBJ9ZNB1N1yYp0otD+2Ko29Pga3RlKg7Re1oEiSdJU+3uPmLiFv64yTT9HCT2voMKj38VGlTWrppiNpoiuo6X6PUiKX1Bt+xJFUK9hFEEELX7MKADRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775449; c=relaxed/simple;
	bh=uZQQT0tWMLKpHLzpjA4+4RgpjpRE41cd6g0mqVVjBlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA0Z1HZ39QFko/g5I1mBZF6GY4Zpktt+zGYnmn2BqVDQN4wmQ8CZVoKHQ0A0aEioCw9QJgVJoBaDk0RucER+GqbR505TRvCZ8Q2mwdLJYtDVqqEykDaMXsuAlR6J4MxA2ml95/L4v5fek/vYDivKz/RGcHSMhvYlUT/xDNdc7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=I1XLcZLe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4214f52b810so26969665e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717775445; x=1718380245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mLYWZnKH+z6ueZhuJkRBxm2z11CPZmpPTaPGv2cuj0=;
        b=I1XLcZLeVsc6OMmjnn3QqWOxgtjpnis4rLhTWWXsO0wpAwNVCuza3LAeAv54Ln7tiQ
         +x//nMH0a9fvHdDOfoHj0nMjAW8YahPWgsfBT76DOZHFJJneyfrkklHHsKbw5CaVlaJM
         mPQO9SwxNlpW0lfy2nTnV7Dk/gwxaFQeT8fWjjIY/iVKPmBqmujoFsbfbsKTuT1TMHBl
         hVV5glIw2QbN/MA5F/OmoGnFoqBobPxholl2UOsQULEKwqiGQsHKTot1S1JN5CV6aahL
         Rc+TBVXagqrGgZBdAF5RNOScsYrEajkgo4bzCryBrIM3V8uH+3Bu/BjMsaqgK57hBIvp
         AIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775445; x=1718380245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mLYWZnKH+z6ueZhuJkRBxm2z11CPZmpPTaPGv2cuj0=;
        b=sVyyp0WcHlfxjHcHNnYE4CGyccWm4TP4wOCIbwPmnM74MT8kHXy37Dq6CblwaKqBID
         pe3eBvAladVLt92hD9N0L13hoC6q1ugOYc/6Yzr7byZlRtOWxa6SyuQArOpgtY/t7kSh
         Visnqw8bQysPpTKCu4NDLiler8w/YbDZWKuhc4UPsCAkULIFsO+lKTc5sVm5v8nVqN7w
         4sClVDRYEijMdSLN4wr5U0MT7hyCBKikrYvJOR6XdO8bGldC+MonQKpmOT4maaMJ4plg
         4nr5H8ySCTQtijfnZpaNvy500o76sv4CDTF2GgU+MMsieowW5/nsJlPrqRgjJf6VgYut
         fGsg==
X-Forwarded-Encrypted: i=1; AJvYcCU7mbXb5E7ng0PNjc5OjUeKHU54dwGWZwQ4wToqBkiiE0KJCGJYUZKTfjtK3nSNsyI3tgyD5nFuWeQac7TF7mapkzGiDsddrYxXgw==
X-Gm-Message-State: AOJu0YwIW5Mx1iReG5bkMueYYLpG5GR+oNABC8lYREro7OmhYw3el/Ro
	R9QduhOalzJLJM0+xYYIU3V8m3skbudvIsE4M/DwbU0cEIbmdhrpoxQUONAc4hA=
X-Google-Smtp-Source: AGHT+IHG8WszpcEWn5y0Ergt20tKhSOz5/rJxXqP/p8U9bIooclfDP/A70icjjOiWOdZ+5jrSUBNHw==
X-Received: by 2002:a05:600c:3496:b0:421:2429:7e46 with SMTP id 5b1f17b1804b1-421649fbb46mr33986435e9.13.1717775445415;
        Fri, 07 Jun 2024 08:50:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66cf6sm4237732f8f.49.2024.06.07.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:50:44 -0700 (PDT)
Date: Fri, 7 Jun 2024 17:50:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <ZmMsUYFvUOndiX8g@nanopsycho.orion>
References: <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
 <20240606144818.GC19897@nvidia.com>
 <20240606080557.00f3163e@kernel.org>
 <4724e6a1-2da1-4275-8807-b7fe6cd9b6c1@kernel.org>
 <ZmKtUkeKiQMUvWhi@nanopsycho.orion>
 <887d1cb7-e9e9-4b12-aebb-651addc6b01c@kernel.org>
 <20240607151451.GL19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607151451.GL19897@nvidia.com>

Fri, Jun 07, 2024 at 05:14:51PM CEST, jgg@nvidia.com wrote:
>On Fri, Jun 07, 2024 at 08:50:17AM -0600, David Ahern wrote:
>
>> Mellanox offers both with the Spectrum line and should have a pretty
>> good understanding of how many customers deploy with the SDK vs
>> switchdev. Why is that? 
>
>We offer lots of options with mlx5 switching too, and switchdev is not
>being selected by customers principally for performance reasons, in my
>view.
>
>The OVS space wants to operate the switch much like a firewall and
>this creates a high rate of database updates and exception
>packets. DPDK can operate all the same offload HW from userspace and
>avoid all the system call and other kernel overhead. It is much more
>purpose built to what OVS wants to do. In the >50Gbps space this
>matters a lot and overall DPDK performance notably wins over switchdev
>for many OVS workloads - even though the high speed path is
>near-identical.
>
>In this role DPDK is effectively a switch SDK, an open source one at
>least.
>
>Sadly I'm seeing signs that proprietary OVS focused SDKs (think
>various P4 offerings and others) are out competing open DPDK on
>merit :(
>
>For whatever reason the market for switching is not strongly motivated
>toward open SDKs, and the available open solutions are struggling a
>bit to compete.
>
>But to repeat again, fwctl is not for dataplane, it is not for
>implementing a switch SDK (go use RDMA if you want to do that). I will

switch sdk is all about control plane.


>write here a commitment to accept patches blocking such usages if
>drivers try to abuse the purpose of the subsystem.
>
>Jason

