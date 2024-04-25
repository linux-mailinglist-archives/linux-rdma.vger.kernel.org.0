Return-Path: <linux-rdma+bounces-2075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D178B268B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BBA285597
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2F14E2CA;
	Thu, 25 Apr 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Bw7sa1OQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0714D71F
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062680; cv=none; b=tuVCD3Zh+rSzk+gaCJyR3j2WBlkU3y6BmKylHJGNX0l/T7xpMtpz3jl7Pmg7HN/YIywIVJWtHZSlEIsfjft/mFuDYPlGv2xmNLTe0Mkd2kIRjQR9MM/xisFbI4G/xf0naAOIv/7uaZ5+tVR3JgxD/qWB64Vx+k79UtIvmKce0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062680; c=relaxed/simple;
	bh=+WK1EsPbKaLW4xZIO0RiFVArQ9u/eVK7/399NjWW13s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpPlIGiJ/CGO95i3uk6tcQFo+gkBubsdNuTcH8vPFQ6sbGMjcffJ5Dq+MSnfW1JCHZkCiPAY7QwAn9gGRomihYa3DxNdiqI0EOP5iuFwkx/75JnjmsHNA2Mljnkrwb4TAu4i2XwogVYT/rGIOAO9I4XmD34nVOeYm8Zt/nh6ytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Bw7sa1OQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e9320c2ef6so8761785ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714062678; x=1714667478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tBrT3OfOkKuIv1xzAscKnKl0pQQOx5r5vdyc5h+6Qc=;
        b=Bw7sa1OQ59JGMgxhj5YPLnuiZolwB/J01tsphie180JM5HjcmSFq9GrbO+/zJn7xAP
         TAj+mbc0b2jhZ21719B2PKWFNnpC+QxYuUYAPgqPKyTZLoFm44giEZoJEhh2ztAJ6r29
         aQqvCZOnX2hq8F8N3f8EgeOr4VTmGngKW1/RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062678; x=1714667478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tBrT3OfOkKuIv1xzAscKnKl0pQQOx5r5vdyc5h+6Qc=;
        b=IyVFRQe/xxNFBgxZpci3zT5EPILAu5ByUIPJnnlr3s+RcrpIQ0OrkMwLb5yTWTlVWo
         v3k1dHJKhgOxZgIefZLaoVHIylySJpDvF9+lwkjVi5EGtNozx90GzAh/1ppDp1IU7oLo
         aA+Shc60XPTtC5eOh3zeokfPC09Re8xbWMdwTO9D9j5ejQEgdvZKflvfg1GzQe7o8IZz
         BlBRGc0vZlNOGikUgLzKhX5DCEmCVQk7h7Dwq/eE7JwY6VvzC2P19DC1NmKCgXmTd/vn
         eMrdFR0V2Mjk45ljX9XPCzcJqHH7XWrTQ+Bexha/l4dSF9igUuLpLLLK+EM3+lWtSGnZ
         yXJw==
X-Forwarded-Encrypted: i=1; AJvYcCVXWMdJAvHsCcfdf74mCvR8sNmW4PA5epDto9FGXNzg5QUnpVRw17+QvuBMLYp/1+CsrK+UZ3QedpZqLeAJQ5oxRis/KfvAWCNTdA==
X-Gm-Message-State: AOJu0YwDEevINx/vfgb4aGJ8S6hifxiHRXJDvXxDsA8PGeMhSZX6pFap
	VRV71fpeK+yLOiGudFDjr8LiJvCsofGcp1YmsV4A27nMDa2+eQmRHxOu0yGV/Co=
X-Google-Smtp-Source: AGHT+IFI8B/FpZnCIi16W6FI7UF//hJoZYmyMQZUHVbe3lEDRf1IN/LCHqefyDBGqNGNw/h8FhfkgA==
X-Received: by 2002:a17:902:d883:b0:1e6:3577:1912 with SMTP id b3-20020a170902d88300b001e635771912mr35663plz.25.1714062678031;
        Thu, 25 Apr 2024 09:31:18 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001e2bb03893dsm13940883plf.198.2024.04.25.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:31:17 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:31:14 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <ZiqFUs-z5We2--5n@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
 <Zig5RZOkzhGITL7V@LQ3V64L9R2>
 <20240423175718.4ad4dc5a@kernel.org>
 <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
 <20240424072818.2c68a1ab@kernel.org>
 <Zik1zCI9W9EUi13T@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zik1zCI9W9EUi13T@LQ3V64L9R2>

On Wed, Apr 24, 2024 at 09:39:43AM -0700, Joe Damato wrote:
> On Wed, Apr 24, 2024 at 07:28:18AM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Apr 2024 22:54:50 -0700 Joe Damato wrote:
> > > On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> > > > On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:  
> > > > > I realized in this case, I'll need to set the fields initialized to 0xff
> > > > > above to 0 before doing the increments below.  
> > > > 
> > > > I don't know mlx4 very well, but glancing at the code - are you sure we
> > > > need to loop over the queues is the "base" callbacks?
> > > > 
> > > > The base callbacks are for getting "historical" data, i.e. info which
> > > > was associated with queues which are no longer present. You seem to
> > > > sweep all queues, so I'd have expected "base" to just set the values 
> > > > to 0. And the real values to come from the per-queue callbacks.  
> > > 
> > > Hmm. Sorry I must have totally misunderstood what the purpose of "base"
> > > was. I've just now more closely looked at bnxt which (maybe?) is the only
> > > driver that implements base and I think maybe I kind of get it now.
> > > 
> > > For some reason, I thought it meant "the total stats of all queues"; I didn't
> > > know it was intended to provide "historical" data as you say.
> > > 
> > > Making it set everything to 0 makes sense to me. I suppose I could also simply
> > > omit it? What do you think?
> > 
> > The base is used to figure out which stats are reported when we dump 
> > a summary for the whole device. So you gotta set them to 0.
> 
> OK, thanks for your patience and the explanation. Will do.
> 
> > > > The init to 0xff looks quite sus.  
> > > 
> > > Yes the init to 0xff is wrong, too. I noticed that, as well.
> > > 
> > > Here's what I have listed so far in my changelog for the v2 (which I haven't
> > > sent yet), but perhaps the maintainers of mlx4 can weigh in?
> > > 
> > > v1 -> v2:
> > >  - Patch 1/3 now initializes dropped to 0.
> > >  - Patch 3/3 includes several changes:
> > >    - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> > >      valid before proceeding.
> > >    - All initialization to 0xff for stats fields has been omit. The
> > >      network stack does this before calling into the driver functions, so
> > >      I've adjusted the driver functions to only set values if there is
> > >      data to set, leaving the network stack's 0xff in place if not.
> > >    - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).
> > 
> > All the ones you report right? Not just zero the struct.
> > Any day now (tm) someone will add a lot more stats to the struct
> > so the init should be selective only to the stats that are actually
> > supported.
> 
> Yes, not just zero the struct. Since I am reporting bytes packets for both
> RX and TX and alloc_fail for RX I'll be setting those fields to 0
> explicitly.
> 
> And there's also a warning about unused qtype (oops) in patch 2/3.
> 
> So, the revised v2 list (pending anything Mellanox wants) is:
> 
>   v1 -> v2:
>    - Patch 1/3 now initializes dropped to 0.
>    - Patch 2/3 fix use of unitialized qtype warning.
>    - Patch 3/3 includes several changes:
>      - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
>        valid before proceeding.
>      - All initialization to 0xff for stats fields has been omit. The
>        network stack does this before calling into the driver functions, so
>        I've adjusted the driver functions to only set values if there is
>        data to set, leaving the network stack's 0xff in place if not.
>      - mlx4_get_base_stats set all stat fields to 0 individually (no locking etc needed).
> 
> I'll hold off on sending this v2 until we hear back from Mellanox to be
> sure there isn't anything else I'm missing.

It's been a few days and I haven't heard back from the mlx4 folks, so I
think I'll probably send my v2 later today which, hopefully, will fix most
of the above issues.

