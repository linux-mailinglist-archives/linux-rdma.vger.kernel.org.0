Return-Path: <linux-rdma+bounces-2176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23B8B7C9F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291401C20DB5
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3E177992;
	Tue, 30 Apr 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ur6kN8Ub"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7577176FA3
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493930; cv=none; b=al0gKAGNSmsOLJAA03UwnyKGMTKI/cBgzvWmpLUiRi6JFf4p/7bHAaLLurw6fw1qt/E18dcQvPvK0BB8LucFdcG1kzAgUYJ3hmRTOj/ZFVFCY/I8phtkcxCc6gqegJQWRLB0V+QlaiOq/wL/NBmH6JedJc2um4y7qYRuqaiARYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493930; c=relaxed/simple;
	bh=dhxZVD9ttOs5Y5zhEjCRecsoTpHKTChcPVAgBunFjtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCgQApnxaeAkmkaIiOTwgV1qKBahMo7JYaU4aPuQNNU3f9iBHwZ/vKGHMtMP9RP89CV3vy3Lj5NY9oyTROVXXkqlXQMz7Am8E1B4C1NDfMGt9MbpULoqXXynPYmEgtg3clPjEFv0ATkXz6DFUnMqVmAbc3wE3l+SYOUzWy4bUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ur6kN8Ub; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e65a1370b7so55143005ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714493928; x=1715098728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtM8GCl9ffUz8IFux+EMI3gTh7GpUE7BqVnafimiEpo=;
        b=Ur6kN8UbOTU80rU+mNUcuMYRvniwRu1m6sCM3EapvMX9pJQGXL3YCweFiQilakb4IU
         tspbtbaPw/h83bbqOy46fsEng11bhH3myd1OpNjdc+QqRDIQHtf3/8+o8ZbePDjMLyM9
         C9mLepjHgaxJKZOVL2lXCm6oMLBC/55uGXsfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714493928; x=1715098728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtM8GCl9ffUz8IFux+EMI3gTh7GpUE7BqVnafimiEpo=;
        b=mqG1arvB6VtJJTJgUREyAP9JGUjOAURYXj3bJ31L42sRuCHKEziF5A5V4cJSlpd1Fe
         xk/VugJe9BwMTyaIEHUbUCnqyv6jM7WlxuhfoFhadh64pxEhLcLyNIiUPhAH6+scAx+a
         00rWDrn6mwbqZRPeHrQJ5h2TJFVDepbpRZHpOyf68q7EW04Ei9zsHRIc4t91zEO23m2M
         KNIyUvT2eWY9SnDssTPwg0CM7AjsK4htK9c+EyU2CDMgxSksHnmlSEYFQ2kLj98Kza7D
         UYla2QGs4cq2u16vNW1d6on1qfubzByIB2CKiNMpNwSUWO7k/isnFgJBYyKvAAfDR2fF
         IdWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8PD8EqdTNIGGVLKJ63gX4EgdF8uWfM4gZcCD7in/f+23WRtps8mWF9OLzO8uAaY3Ew/lguM+NqoYwTBOAbGwUKE57gq+8p05GQ==
X-Gm-Message-State: AOJu0Yx3dv0aDfwFZgyOwVcoqhajwUp5RRwFznWXtRSBOfRErjISZvfu
	krXz0Din6oiIWzhctkutbV4OZBrzzsKujEK2c/IbX612f2FQ2zpPj7Ee7qKFZCk=
X-Google-Smtp-Source: AGHT+IFCuG8Cx9d1lBBx38zTJ9/bzM15VIZsHLsbIssguHfLzE76zO+GP+yHJVRnPYyRDVge2q2AjA==
X-Received: by 2002:a17:902:6b8c:b0:1e8:92:c5e2 with SMTP id p12-20020a1709026b8c00b001e80092c5e2mr14128976plk.47.1714493927882;
        Tue, 30 Apr 2024 09:18:47 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001e27dcfdf15sm22553442plc.145.2024.04.30.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:18:47 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:18:44 -0700
From: Joe Damato <jdamato@fastly.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
	mkarsten@uwaterloo.ca, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <ZjEZ5P7iBqqeqNEi@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
 <Zig5RZOkzhGITL7V@LQ3V64L9R2>
 <20240423175718.4ad4dc5a@kernel.org>
 <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
 <20240424072818.2c68a1ab@kernel.org>
 <Zik1zCI9W9EUi13T@LQ3V64L9R2>
 <ZiqFUs-z5We2--5n@LQ3V64L9R2>
 <20240430123314.GC100414@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430123314.GC100414@unreal>

On Tue, Apr 30, 2024 at 03:33:14PM +0300, Leon Romanovsky wrote:
> On Thu, Apr 25, 2024 at 09:31:14AM -0700, Joe Damato wrote:
> > On Wed, Apr 24, 2024 at 09:39:43AM -0700, Joe Damato wrote:
> > > On Wed, Apr 24, 2024 at 07:28:18AM -0700, Jakub Kicinski wrote:
> > > > On Tue, 23 Apr 2024 22:54:50 -0700 Joe Damato wrote:
> > > > > On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> > > > > > On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:  
> > > > > > > I realized in this case, I'll need to set the fields initialized to 0xff
> > > > > > > above to 0 before doing the increments below.  
> > > > > > 
> > > > > > I don't know mlx4 very well, but glancing at the code - are you sure we
> > > > > > need to loop over the queues is the "base" callbacks?
> > > > > > 
> > > > > > The base callbacks are for getting "historical" data, i.e. info which
> > > > > > was associated with queues which are no longer present. You seem to
> > > > > > sweep all queues, so I'd have expected "base" to just set the values 
> > > > > > to 0. And the real values to come from the per-queue callbacks.  
> > > > > 
> > > > > Hmm. Sorry I must have totally misunderstood what the purpose of "base"
> > > > > was. I've just now more closely looked at bnxt which (maybe?) is the only
> > > > > driver that implements base and I think maybe I kind of get it now.
> > > > > 
> > > > > For some reason, I thought it meant "the total stats of all queues"; I didn't
> > > > > know it was intended to provide "historical" data as you say.
> > > > > 
> > > > > Making it set everything to 0 makes sense to me. I suppose I could also simply
> > > > > omit it? What do you think?
> > > > 
> > > > The base is used to figure out which stats are reported when we dump 
> > > > a summary for the whole device. So you gotta set them to 0.
> > > 
> > > OK, thanks for your patience and the explanation. Will do.
> > > 
> > > > > > The init to 0xff looks quite sus.  
> > > > > 
> > > > > Yes the init to 0xff is wrong, too. I noticed that, as well.
> > > > > 
> > > > > Here's what I have listed so far in my changelog for the v2 (which I haven't
> > > > > sent yet), but perhaps the maintainers of mlx4 can weigh in?
> > > > > 
> > > > > v1 -> v2:
> > > > >  - Patch 1/3 now initializes dropped to 0.
> > > > >  - Patch 3/3 includes several changes:
> > > > >    - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> > > > >      valid before proceeding.
> > > > >    - All initialization to 0xff for stats fields has been omit. The
> > > > >      network stack does this before calling into the driver functions, so
> > > > >      I've adjusted the driver functions to only set values if there is
> > > > >      data to set, leaving the network stack's 0xff in place if not.
> > > > >    - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).
> > > > 
> > > > All the ones you report right? Not just zero the struct.
> > > > Any day now (tm) someone will add a lot more stats to the struct
> > > > so the init should be selective only to the stats that are actually
> > > > supported.
> > > 
> > > Yes, not just zero the struct. Since I am reporting bytes packets for both
> > > RX and TX and alloc_fail for RX I'll be setting those fields to 0
> > > explicitly.
> > > 
> > > And there's also a warning about unused qtype (oops) in patch 2/3.
> > > 
> > > So, the revised v2 list (pending anything Mellanox wants) is:
> > > 
> > >   v1 -> v2:
> > >    - Patch 1/3 now initializes dropped to 0.
> > >    - Patch 2/3 fix use of unitialized qtype warning.
> > >    - Patch 3/3 includes several changes:
> > >      - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> > >        valid before proceeding.
> > >      - All initialization to 0xff for stats fields has been omit. The
> > >        network stack does this before calling into the driver functions, so
> > >        I've adjusted the driver functions to only set values if there is
> > >        data to set, leaving the network stack's 0xff in place if not.
> > >      - mlx4_get_base_stats set all stat fields to 0 individually (no locking etc needed).
> > > 
> > > I'll hold off on sending this v2 until we hear back from Mellanox to be
> > > sure there isn't anything else I'm missing.
> > 
> > It's been a few days and I haven't heard back from the mlx4 folks, so I
> > think I'll probably send my v2 later today which, hopefully, will fix most
> > of the above issues.
> 
> MLNX folks were in long vacation in last two weeks.

OK, thanks for letting me know.

If any of those folks are following this thread, I hope they'll take a look
at the v2 of this series.

I was prepared to send the v3 today, but given that they've been out for a
bit I will hold off on sending the v3 for another day or two.

Thanks,
Joe

