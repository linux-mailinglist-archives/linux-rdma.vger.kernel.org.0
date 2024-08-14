Return-Path: <linux-rdma+bounces-4365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F1951A9B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9509284161
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219B1AED44;
	Wed, 14 Aug 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ER91I/pA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012851B0111
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637534; cv=none; b=nXZQX6JJDGrZ2bCGqKUI+VYEiW+tUit5hFNPMWSj3tte/nIahTW71yzM5JMYvJzcqGzpJ1O1FtODoLiSkR8fgt50D3ty7ZZ+sjT/jy6eYHu4lmw0hmSWGMLqQctXFNgtFMKnsoPcdEvrfRedaxqJN3g399KZZ+5YgV2NbXN3eB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637534; c=relaxed/simple;
	bh=MQ57xcNRnx2hbtvSnDnW9ALhWFVxGf3zZIIpvn2IVqk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF0LzcWRh54JYt6Nm36StsYsGgHUMUXKYiY9JaqIr/IOlaA//8rWV0tspdzi4GmPWJUh/OcvR4bm3+DgRjEFtJg64KZTPdGI2ymSxEw+1zC33lXqZL+CFZPnOHSWFZvFI99FtweWh3BXWrjlZRXfrA+XAVUD16PIND1UJ4c3EMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ER91I/pA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428141be2ddso48234805e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723637531; x=1724242331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PG9e6JitvYXoqzSTP8p6u30qXecQWEzNyRf8++iwfzg=;
        b=ER91I/pAUCKFn6ndSuySZNLG422z4clo57ycN76odiFyCjcH0QMFJQp2MN2KmlXIo9
         /UIISX3qwXpFZT0GEMPLg8kDii+imqwHiSvzq3KPDu+rHcXwilLPLGqqpGZR/7qSjLJ8
         Xns+oN5HGUECJ2zb3vkHnQT3nPtPVY03X0LNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637531; x=1724242331;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG9e6JitvYXoqzSTP8p6u30qXecQWEzNyRf8++iwfzg=;
        b=s40zIXKHrvS1blol6ctp8bqS0Wsi8+UxwSxD0EQH3SBCbfODtMeytgFNyQYjgNQz6A
         uj/sCGO9dzmSwTsgjKS0jOZVKf8aRn4k53vztmBOw4XrIPB5xCqy+zh1miuIURiDGEtx
         1Xb2/1Tve5GoVDMR1c4zL9j5R9mN0PtawFTRmpJlSfiSlNCmMa/R2CHUGYAkc77iGB5r
         2T90qcQ5lIHn7Sm/CEcO2Vmhar0bEClQZnvjXRf08UAFopiTaJQt22Bf6I0KIMpBrgi4
         Hiqb8Vp7MnkK3JWx27bppfP33rHu3gGRSE3B/ud/mTqzHPdP4duFnw7M7nwuFfiMNurr
         5cfA==
X-Forwarded-Encrypted: i=1; AJvYcCUs8Bb7+l6LhCA8R/wS/wi7BLPDsqJKiCDCqLBdtXMnnfSfBCmu5iIkSS5oGjpx7u7U0DDbGGNFQ82tdLwjzqUWspgvMmtc9GxWXw==
X-Gm-Message-State: AOJu0YxtxO4+Us2JfS0e64wVWYhNcslGhSaKBthFLf4jgrsFMqYwG0ex
	6GukrbmgduPHLI8/7hpasXJVjguQA5MNXN10IqmZnmMqsioFQxO6l+U7SRoXPhM=
X-Google-Smtp-Source: AGHT+IEXQhc1DRLmbpucvwdmK1QHHySaNdm9iIXPW0P1dXOgYRVT3R+EtoisglPADmrSMdzG+PAwVw==
X-Received: by 2002:a05:600c:4710:b0:426:62c5:4741 with SMTP id 5b1f17b1804b1-429dd22fe4dmr18421295e9.2.1723637531117;
        Wed, 14 Aug 2024 05:12:11 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded1e3f7sm18267235e9.4.2024.08.14.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:10 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:12:08 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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
Message-ID: <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
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
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>

On Wed, Aug 14, 2024 at 08:14:48AM +0100, Joe Damato wrote:
> On Tue, Aug 13, 2024 at 05:17:10PM -0700, Jakub Kicinski wrote:
> > On Mon, 12 Aug 2024 14:56:21 +0000 Joe Damato wrote:
> > > Several drivers make a check in their napi poll functions to determine
> > > if the CPU affinity of the IRQ has changed. If it has, the napi poll
> > > function returns a value less than the budget to force polling mode to
> > > be disabled, so that it can be rescheduled on the correct CPU next time
> > > the softirq is raised.
> > 
> > Any reason not to use the irq number already stored in napi_struct ?
> 
> Thanks for taking a look.
> 
> IIUC, that's possible if i40e, iavf, and gve are updated to call
> netif_napi_set_irq first, which I could certainly do.
> 
> But as Stanislav points out, I would be adding a call to
> irq_get_effective_affinity_mask in the hot path where one did not
> exist before for 4 of 5 drivers.
> 
> In that case, it might make more sense to introduce:
> 
>   bool napi_affinity_no_change(const struct cpumask *aff_mask)
> 
> instead and the drivers which have a cached mask can pass it in and
> gve can be updated later to cache it.
> 
> Not sure how crucial avoiding the irq_get_effective_affinity_mask
> call is; I would guess maybe some driver owners would object to
> adding a new call in the hot path where one didn't exist before.
> 
> What do you think?

Actually... how about a slightly different approach, which caches
the affinity mask in the core?

  0. Extend napi struct to have a struct cpumask * field

  1. extend netif_napi_set_irq to:
    a. store the IRQ number in the napi struct (as you suggested)
    b. call irq_get_effective_affinity_mask to store the mask in the
       napi struct
    c. set up generic affinity_notify.notify and
       affinity_notify.release callbacks to update the in core mask
       when it changes

  2. add napi_affinity_no_change which now takes a napi_struct

  3. cleanup all 5 drivers:
    a. add calls to netif_napi_set_irq for all 5 (I think no RTNL
       is needed, so I think this would be straight forward?)
    b. remove all affinity_mask caching code in 4 of 5 drivers
    c. update all 5 drivers to call napi_affinity_no_change in poll

Then ... anyone who adds support for netif_napi_set_irq to their
driver in the future gets automatic support in-core for
caching/updating of the mask? And in the future netdev-genl could
dump the mask since its in-core?

I'll mess around with that locally to see how it looks, but let me
know if that sounds like a better overall approach.

- Joe

