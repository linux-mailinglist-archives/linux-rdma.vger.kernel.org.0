Return-Path: <linux-rdma+bounces-4369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93182951E68
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5EE1C22787
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6021B29D9;
	Wed, 14 Aug 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DGCAjS/H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A12D7B8
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648791; cv=none; b=GeYarfq40X/efRnqFNnk8aCI5cWZ3afiMe3dmjysiKrdMQKAX141+srk+4+e1SGYePy6UrLPSwlQZGyquzHHe8YbfxmTzvsmzjkKcye8hDNok/5hk07UhhCjhRySxjohqzgzCFvTYwVYv+A6Fn3lZ34j+4qIK9bRLi008MdB/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648791; c=relaxed/simple;
	bh=XGuhBnv/MQQll+NCKqoo61KE0fgOnlHZWsz6TSQEtNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J317K7FLvy5ExMZD66ZclGfMVsY4U3AzF7W53wDh0t3v2c4QyqFHmngz6dTdJt7Cx6yx4ukzrd6i8XLC0+YRovlkg318mWU9/yhxjJBZ4W4U6dcwqmV76CTUsnGnjs8T0BmAYv//OFg9szMcO6LD4nD4AVcWCYbMunIJrSWkgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DGCAjS/H; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so66520a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723648788; x=1724253588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTi7bYjYTGMEWGbyKlWoq2Paz7kIbeWFkJUp3rdie2E=;
        b=DGCAjS/HoeJPconZgbWhtB1sEzhgKIS8J9nDlWQYlHCplwHkTW5/kfTAWzTdbEuYZX
         UK/Q4AuOTeXeYJgtkK3yUmOPwvqsUNYb4si6qkuhzppSk3GtX7LZPcdT7To6LmIfDbKW
         6ZwYNN2DOkNPXJj/YAcxAl2da9Vch5fbYQgPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648788; x=1724253588;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTi7bYjYTGMEWGbyKlWoq2Paz7kIbeWFkJUp3rdie2E=;
        b=WTmsdN3QI50kxBGd2vQdYClhOcD8v4W7Edhn/b62wNsimceSSmPkWNAnlt1NW5SsGI
         60pdOyn+/3j5+GZpI0t0eXH/4yI1hoqpn52mBlo5aANVr7bLt/OWIcDzDOQR9q/wlrPZ
         /aA7LNar4GeObvaVNlmHmLIDihlt97IQHadPOkPSuKXgAcOI76DHEGIO7fZ/Afxyhyz+
         j+NSNCjj0++nbXkcQpwFctMQAOKgWWmD45noBkgH+OmZBmunpT9twFZDYZ3nB2ykVG2s
         vKazQ+HOtM2s/La+FZmzuTdQ9amEM7MBD+IWtClwfQqRVvbZ/nbt5UjI8kHziOHj/o43
         mjEg==
X-Forwarded-Encrypted: i=1; AJvYcCXrda6zpBRH0Fp49RIZ62ucUbR3AuCZQbNNhidteFoRumuYODR4VNiStWeFxlb9nlT2fDEOOU0ptRsqRMLaMCm1ucuA/NnBwpoV1A==
X-Gm-Message-State: AOJu0YxD9OPtkJfTCVO1QRvCvTWv7CoKsJEe/zOdww3sesOIHg4Ua2ZE
	IOEkGetNXO7nTar6YjEruIuVSi6wLdHOE6ekNmJYj2d7rRwASUbCd/jN2AQsU/A=
X-Google-Smtp-Source: AGHT+IFvDOsbuKJOT0XL/TM+iXA5EFj0BhRg1ts5WGvw7A2g2cgRk9L2pdTDRxwV8rDbcUIbgQvSeA==
X-Received: by 2002:a17:907:d5a4:b0:a72:40b4:c845 with SMTP id a640c23a62f3a-a8367006615mr221312666b.51.1723648788188;
        Wed, 14 Aug 2024 08:19:48 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e127sm183820466b.150.2024.08.14.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:19:47 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:19:45 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several drivers
Message-ID: <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240813171710.599d3f01@kernel.org>
 <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
 <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
 <20240814080915.005cb9ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814080915.005cb9ac@kernel.org>

On Wed, Aug 14, 2024 at 08:09:15AM -0700, Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 13:12:08 +0100 Joe Damato wrote:
> > Actually... how about a slightly different approach, which caches
> > the affinity mask in the core?
> 
> I was gonna say :)
> 
> >   0. Extend napi struct to have a struct cpumask * field
> > 
> >   1. extend netif_napi_set_irq to:
> >     a. store the IRQ number in the napi struct (as you suggested)
> >     b. call irq_get_effective_affinity_mask to store the mask in the
> >        napi struct
> >     c. set up generic affinity_notify.notify and
> >        affinity_notify.release callbacks to update the in core mask
> >        when it changes
> 
> This part I'm not an export on.
> 
> >   2. add napi_affinity_no_change which now takes a napi_struct
> > 
> >   3. cleanup all 5 drivers:
> >     a. add calls to netif_napi_set_irq for all 5 (I think no RTNL
> >        is needed, so I think this would be straight forward?)
> >     b. remove all affinity_mask caching code in 4 of 5 drivers
> >     c. update all 5 drivers to call napi_affinity_no_change in poll
> > 
> > Then ... anyone who adds support for netif_napi_set_irq to their
> > driver in the future gets automatic support in-core for
> > caching/updating of the mask? And in the future netdev-genl could
> > dump the mask since its in-core?
> > 
> > I'll mess around with that locally to see how it looks, but let me
> > know if that sounds like a better overall approach.

I ended up going with the approach laid out above; moving the IRQ
affinity mask updating code into the core (which adds that ability
to gve/mlx4/mlx5... it seems mlx4/5 cached but didn't have notifiers
setup to update the cached copy?) and adding calls to
netif_napi_set_irq in i40e/iavf and deleting their custom notifier
code.

It's almost ready for rfcv2; I think this approach is probably
better ?

> Could we even handle this directly as part of __napi_poll(),
> once the driver gives core all of the relevant pieces of information ?

I had been thinking the same thing, too, but it seems like at least
one driver (mlx5) counts the number of affinity changes to export as
a stat, so moving all of this to core would break that.

So, I may avoid attempting that for this series.

I'm still messing around with this but will send an rfcv2 in a bit.

