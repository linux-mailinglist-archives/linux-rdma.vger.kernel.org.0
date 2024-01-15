Return-Path: <linux-rdma+bounces-632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C958582DA7E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 14:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749082813DF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F9171D4;
	Mon, 15 Jan 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bCq2m7rz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95817547
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jan 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7831be84f4eso619357985a.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jan 2024 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705326429; x=1705931229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUjKD2gi6SVwWe2jyucClOjDBm7lQHBOV+7/9YdX/qA=;
        b=bCq2m7rziLTY7k70j4gxHWHhBSbtniIeLwaGT6UMDvpfYEwef1ie5wqBCtsH9C3b2v
         BzqNQKBbqfe8aOZZ/+Vs3iGq6xQXtsSaACWKOdM+Gn1uKQgLSo88gxOVZfiih339visE
         x7EgMerJzE13C/GiqeBocZFJqd1OxYRFnYEp4rCRJN/a7oOo2eV893AEzn34nSFb5Jyj
         HhPWSyes3qbqiFWp5Zu0a9kMMtWrFZYIBaRlayKKlKma9UWsLF9BB7BBsW3Fl0+ZY9P0
         /qMFISgFc2IdsjEQ1EgtNjVyDaRH5hgrLOqv8RD/5sbJzoODF13k+Mu3Q5g6IoUbneXj
         1MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705326429; x=1705931229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUjKD2gi6SVwWe2jyucClOjDBm7lQHBOV+7/9YdX/qA=;
        b=mwAWYIcHV9XkbqSilmR5ssY5sjY+dyt4bOZ/I7k6J5nrmTi8qK6ppr/4fBUHTM4Ok4
         f0VxQ47LcmYIEosYbMJcmDqoV95NQ3pZ3N/43/bvDSZmuTwA6oJ0jnKBd1uQ5dRaSQs2
         winI0yfm1DAssCiilvX6V+EqQdwwUgA8qDTv1GWFgsdhvAVq84HtAQBmLTB7ti+r+5ng
         bPtRkohWb3C9rNyHjaJhYAWgsD+aiEJ2qeo6rPDebQNUyLA89uevxcPDa5vP75wzdgYq
         9bp7lWAvWzU66rONfDd//fbjw7S6UgTVmnE0gY5cofhvFcCGkuRKgbURBD0UJ87ERr3F
         10pQ==
X-Gm-Message-State: AOJu0Yy3VAGLtalCv13BOtTnQgHTA8WdvuciX5gm0e/QIRrD0PKvHCag
	SzrjXebskhiInmukCk9kpmbJ07DmqYi9BA==
X-Google-Smtp-Source: AGHT+IHVG9P9HwOAxQuxFEaZKddUs9t4LC756MtBH1eEeRojjN31fU8iG4j/1WmbacAwtlztEWup5A==
X-Received: by 2002:a05:620a:3908:b0:783:14a9:3065 with SMTP id qr8-20020a05620a390800b0078314a93065mr7912816qkn.5.1705326428869;
        Mon, 15 Jan 2024 05:47:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id vr28-20020a05620a55bc00b0078199077d0asm2945492qkn.125.2024.01.15.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:47:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPNIx-003qJf-2i;
	Mon, 15 Jan 2024 09:47:07 -0400
Date: Mon, 15 Jan 2024 09:47:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>,
	Shifeng Li <lishifeng@sangfor.com.cn>
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Message-ID: <20240115134707.GZ50608@ziepe.ca>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
 <20240104123728.GC50608@ziepe.ca>
 <e029db0a-c515-e61c-d34e-f7f054d51e88@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e029db0a-c515-e61c-d34e-f7f054d51e88@sangfor.com.cn>

On Sat, Jan 06, 2024 at 10:12:17AM +0800, Ding Hui wrote:
> On 2024/1/4 20:37, Jason Gunthorpe wrote:
> > On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:
> > 
> > > The root cause is that mad_client and cm_client may init concurrently
> > > when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:
> > 
> > That can't be true, the module loader infrastructue ensures those two
> > things are sequential.
> > 
> 
> Please consider the sequence again and notice that:
> 
> 1. We agree that dependencies ensure mad_client be registered before cm_client.
> 2. But the mad_client.add() is not invoked in ib_register_client(), since
>    there is no DEVICE_REGISTERED device at that time.
>    Instead, it will be delayed until the device driver init (e.g. mlx5_core)
>    in enable_device_and_get().
> 3. The ib_cm and mlx5_core can be loaded concurrently, after setting DEVICE_REGISTERED
>    and downgrade_write(&devices_rwsem) in enable_device_and_get(), there is a chance
>    that cm_client.add() can be invoked before mad_client.add().
> 
> 
>         T1(ib_core init)      |      T2(device driver init)        |        T3(ib_cm init)
> ---------------------------------------------------------------------------------------------------
> ib_register_client mad_client
>   assign_client_id
>     add clients CLIENT_REGISTERED
>     (with clients_rwsem write)
>   down_read(&devices_rwsem);
>   xa_for_each_marked (&devices, DEVICE_REGISTERED)
>     nop # no devices
>   up_read(&devices_rwsem);
> 
>                               ib_register_device
>                                 enable_device_and_get
>                                   down_write(&devices_rwsem);
>                                   set DEVICE_REGISTERED
>                                   downgrade_write(&devices_rwsem);
>                                                                     ib_register_client cm_client
>                                                                       assign_client_id
>                                                                         add clients CLIENT_REGISTERED
>                                                                         (with clients_rwsem write)
>                                                                       down_read(&devices_rwsem);
>                                                                       xa_for_each_marked (&devices, DEVICE_REGISTERED)
>                                                                         add_client_context
>                                                                           down_write(&device->client_data_rwsem);
>                                                                           get CLIENT_DATA_REGISTERED
>                                                                           downgrade_write(&device->client_data_rwsem);
>                                                                           cm_client.add
>                                                                             cm_add_one
>                                                                               ib_register_mad_agent
>                                                                                 ib_get_mad_port
>                                                                                   __ib_get_mad_port return NULL!
>                                                                           set CLIENT_DATA_REGISTERED
>                                                                           up_read(&device->client_data_rwsem);
>                                                                       up_read(&devices_rwsem);
>                                 down_read(&clients_rwsem);
>                                 xa_for_each_marked (&clients, CLIENT_REGISTERED)
>                                   add_client_context [mad]
>                                     mad_client.add
>                                   add_client_context [cm]
>                                     nop # already CLIENT_DATA_REGISTERED
>                                 up_read(&clients_rwsem);
>                                 up_read(&devices_rwsem);

Take the draft I sent previously and use down_write(&devices_rwsem) in
ib_register_client()

Jason

