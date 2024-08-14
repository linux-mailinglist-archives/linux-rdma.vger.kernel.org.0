Return-Path: <linux-rdma+bounces-4371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1F99521C2
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5823E1F21C7B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA861BD02C;
	Wed, 14 Aug 2024 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZTD6ismn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C401BBBDC
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658507; cv=none; b=uQfbl1cqQAqXOW/C75Xne90YLTqqK2svFA2BaMCDHVHjfWw5E0tZb9Eamj8bJPg0kPoz/mkO8u6CoC40pgCwKGTG5yEXKnOhEPb4yovOUzZRf10QOBge53rjfL4VDukCr6hA10iYEGm7Z0YE8QnGGiR3v32sg6m7CWnBa+ljrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658507; c=relaxed/simple;
	bh=VKidP+OQljS2EXJyioas4CypU+BVrUWJoPUVdLvxkoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlbQnEtWOF1xkDBlvSShJt8cu7Y5gZNtYE6D6Uxq1KzJf1LQiHG9ifcbnUQ0CLX9v+dx7ZpCsD3UdOvgB++rkQytQ/DTWsmbTH1jrDXaXnakMcfbxkP+JmkzhU8YBDW47PKAYfIFS9ClRxiOc6MJeRuJrewmLGP4WrEVw2/OI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZTD6ismn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3687fd09251so112086f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723658504; x=1724263304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKG1BA6nZA/+iN2W0nGROx4tq6HJetKTMlW3JVQELg0=;
        b=ZTD6ismnXgkRbK6WF3IeepqWr8YZY0DolpdxJ6Xq/AmWZY/mdBcpLeqeHY3MmmJL7S
         N8AsNXVlWrK7UlqUg1gSlgUBD0ULB3V85WnGYrlrUjFZrOyWp4ubQPy4TwpVD7xIsfOO
         ENKdhuYLXKIFaLaG2SED8fxQZLfL5KztqKa/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658504; x=1724263304;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKG1BA6nZA/+iN2W0nGROx4tq6HJetKTMlW3JVQELg0=;
        b=n1o2MSuzDgrDFUQw2kxUdhegJ0vU8ZPDCfH2cUd2vMaPTqcQEeTznANURYRzysPtfm
         iTh64HdclKNKr+YeOmThiaYNpQVDJDcmvtLTZENZ5YY8DAUJgNJLisky/Zzaqhvm420/
         EKTMPWvRoC5WpsGi1wf/s4ARVWcAe8quhmUuu5ZML5XW653L7IE1raaHIE7tYgWIt3l6
         zUMBjuMzHT7kOE5tfkaJQ7hkkPLCjeTLHeIzHRdHH6RXTNsl9vT30BbxffhI22xn9ukO
         u+mQUOTQ6pyfsx6gaG0s5tu7pIxWtiQuzMCcxd5dq1Ck28NbJVEsUVduawoLU6rUmaqJ
         /1dw==
X-Forwarded-Encrypted: i=1; AJvYcCUmjvyqRKGJgimThfbU612ktXuoZEKqm8x8JvSOf2l0DIMMDao6duC7gj4GQaFOJ9OQowhc21m7NWpLgSqy7v2OLm0tXB5aCn0tYQ==
X-Gm-Message-State: AOJu0YwC4KJDqgFOYKzgZjV9hzP7WGE/TV4YsGWS81SPK8gMJl8VqLCj
	IppJFANv7vCBYDuBNPM/zqODk+drGGEO5vzGaLd3vfgjqLwoBy8f93vlxabZOqI=
X-Google-Smtp-Source: AGHT+IGCmSIjhxSRM6zFrHvolmN2wXREY83zZw95/jXyk6UpHYC0uXJzFqUFz4BGJeihuJswIDQe0w==
X-Received: by 2002:a5d:59a5:0:b0:36b:357a:bfee with SMTP id ffacd0b85a97d-37177749bc7mr2760473f8f.1.1723658503541;
        Wed, 14 Aug 2024 11:01:43 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718479c332sm548792f8f.87.2024.08.14.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:01:43 -0700 (PDT)
Date: Wed, 14 Aug 2024 19:01:40 +0100
From: Joe Damato <jdamato@fastly.com>
To: Shay Drori <shayd@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several drivers
Message-ID: <ZrzxBAWwA7EuRB24@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Shay Drori <shayd@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
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
 <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
 <701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>

On Wed, Aug 14, 2024 at 07:03:35PM +0300, Shay Drori wrote:
> 
> 
> On 14/08/2024 18:19, Joe Damato wrote:
> > On Wed, Aug 14, 2024 at 08:09:15AM -0700, Jakub Kicinski wrote:
> > > On Wed, 14 Aug 2024 13:12:08 +0100 Joe Damato wrote:
> > > > Actually... how about a slightly different approach, which caches
> > > > the affinity mask in the core?
> > > 
> > > I was gonna say :)
> > > 
> > > >    0. Extend napi struct to have a struct cpumask * field
> > > > 
> > > >    1. extend netif_napi_set_irq to:
> > > >      a. store the IRQ number in the napi struct (as you suggested)
> > > >      b. call irq_get_effective_affinity_mask to store the mask in the
> > > >         napi struct
> > > >      c. set up generic affinity_notify.notify and
> > > >         affinity_notify.release callbacks to update the in core mask
> > > >         when it changes
> > > 
> > > This part I'm not an export on.
> 
> several net drivers (mlx5, mlx4, ice, ena and more) are using a feature
> called ARFS (rmap)[1], and this feature is using the affinity notifier
> mechanism.
> Also, affinity notifier infra is supporting only a single notifier per
> IRQ.
> 
> Hence, your suggestion (1.c) will break the ARFS feature.
> 
> [1] see irq_cpu_rmap_add()

Thanks for taking a look and your reply.

I did notice ARFS use by some drivers and figured that might be why
the notifiers were being used in some cases.

I guess the question comes down to whether adding a call to
irq_get_effective_affinity_mask in the hot path is a bad idea.

If it is, then the only option is to have the drivers pass in their
IRQ affinity masks, as Stanislav suggested, to avoid adding that
call to the hot path.

If not, then the IRQ from napi_struct can be used and the affinity
mask can be generated on every napi poll. i40e/gve/iavf would need
calls to netif_napi_set_irq to set the IRQ mapping, which seems to
be straightforward.

In both cases: the IRQ notifier stuff would be left as is so that it
wouldn't break ARFS.

I suspect that the preferred solution would be to avoid adding that
call to the hot path, right?

