Return-Path: <linux-rdma+bounces-2056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416CD8B1014
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38E3288512
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C65168B19;
	Wed, 24 Apr 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wz/QSYgQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EC15FCED
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976785; cv=none; b=C2yiKamY2rFIOrXaCWEfTIYcFYNW+gqzmd1EO0yD/efepvQg45ebYnXFrAET3UlWpPC1ERy8gI65x6Wjd1Eyd3PjuSiu2x0EI7O0E+OTSM/Ztz0dRMS9u5EuSCP/DW5AYypRQqwVvymxcDyJvQJECPe/tVX5++jV2h2581Cy3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976785; c=relaxed/simple;
	bh=cLz72/mfLLmu/T9GMaeMDoV/eY7VsWrqXcnk85OgNDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0GJbFUavlR2V4MP0ah03LdSyAj/8Zxw/tqa8qT5kkpjsY17Fabjhb2Rarx6UtvcBMh9Q8td0PP8SQtCc7JMYKiiMzrwbPq4OvBZaheVZqg7qvR5R0QGbG7H41CftTV6lUP/EHRP6iULziqUryRCBAEMavpogRP1fnVfRoj8ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wz/QSYgQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so29688a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713976784; x=1714581584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PASo/dRgHX8j22tZvlPVkiBmGQk9V+5NF/jk1Eifqm8=;
        b=wz/QSYgQl5rz0XYlnApGTl42W2H7kvSKyBWnkmvVfUvtOXSQMBQ7LjEWTAo57VIY8p
         gh/jEl5YCo/3p+twLjvaP4bUSr9hZJhpAV1ACwfW8FfDR5u0Z4qxnfOlrtYzWRCNOOsV
         GUkiJ4+2kegCm6x/Uuj5E0ImX1DPOkZniqslg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976784; x=1714581584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PASo/dRgHX8j22tZvlPVkiBmGQk9V+5NF/jk1Eifqm8=;
        b=BtFoFmTunq7hOlsLdZ4BV36aZl9j1tHn+s9riyYxn8OHvAe1cUCqo491AxLXfPXoRY
         3gncT+txXh3I8E3AdvJw9ahAVUrGYMPnMvvC3ynhQSDxmn9HwW5l4X4kIkG86khVYgkK
         z9J1ciVqc0MDRQ2Dpa+Aff/iB/skAzZvo+8qSzwdnGpHUNU2lD+xyPc9ra8NKsc/JI7E
         rWCIN6R2p1SOiDmHJI1q51vb2a4bl+cq4M/O9pPaGeL1l3+2Lzn96Pkgv3W9A1z+SlKZ
         Kn7+e2C3XyNSGA0eYGxaItWKD/sTR+fujeoKjAaH3aMFvLMvMPQtnQ3K5jo0dwdpiejM
         rYUg==
X-Forwarded-Encrypted: i=1; AJvYcCVWH1lYrCA73MMmIYXkmr7C+5vvgvP8g/cQrcyRw9nDFgyKA4+YTnRpJ7R4d/TTfyJYxNj/idz2vnMuMUOVt7hT1EFnpCuWHy/iBA==
X-Gm-Message-State: AOJu0YzUrQxFOSGWDCE0DUELWm7kBxPPUojzNCJJpZilx3iyJjqsE0gJ
	IkDMKIvmXOAJ9fwFff8Ta98+TE2qI0TFCfsFG0GGvkG6uYFjDbnMgLJTC6vvVb8=
X-Google-Smtp-Source: AGHT+IGCDu+XcsaOpRX4x8SxgNOfdKQVN2qe3ye1vvGNrThMc4lGHjutBZN+ydvFYJcywxmFwAWP7g==
X-Received: by 2002:a05:6a21:1f27:b0:1a3:466d:d33 with SMTP id ry39-20020a056a211f2700b001a3466d0d33mr3162589pzb.9.1713976783611;
        Wed, 24 Apr 2024 09:39:43 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id ld2-20020a056a004f8200b006eaf43bbcb5sm11675694pfb.114.2024.04.24.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:39:43 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:39:40 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <Zik1zCI9W9EUi13T@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
 <Zig5RZOkzhGITL7V@LQ3V64L9R2>
 <20240423175718.4ad4dc5a@kernel.org>
 <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
 <20240424072818.2c68a1ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424072818.2c68a1ab@kernel.org>

On Wed, Apr 24, 2024 at 07:28:18AM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 22:54:50 -0700 Joe Damato wrote:
> > On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> > > On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:  
> > > > I realized in this case, I'll need to set the fields initialized to 0xff
> > > > above to 0 before doing the increments below.  
> > > 
> > > I don't know mlx4 very well, but glancing at the code - are you sure we
> > > need to loop over the queues is the "base" callbacks?
> > > 
> > > The base callbacks are for getting "historical" data, i.e. info which
> > > was associated with queues which are no longer present. You seem to
> > > sweep all queues, so I'd have expected "base" to just set the values 
> > > to 0. And the real values to come from the per-queue callbacks.  
> > 
> > Hmm. Sorry I must have totally misunderstood what the purpose of "base"
> > was. I've just now more closely looked at bnxt which (maybe?) is the only
> > driver that implements base and I think maybe I kind of get it now.
> > 
> > For some reason, I thought it meant "the total stats of all queues"; I didn't
> > know it was intended to provide "historical" data as you say.
> > 
> > Making it set everything to 0 makes sense to me. I suppose I could also simply
> > omit it? What do you think?
> 
> The base is used to figure out which stats are reported when we dump 
> a summary for the whole device. So you gotta set them to 0.

OK, thanks for your patience and the explanation. Will do.

> > > The init to 0xff looks quite sus.  
> > 
> > Yes the init to 0xff is wrong, too. I noticed that, as well.
> > 
> > Here's what I have listed so far in my changelog for the v2 (which I haven't
> > sent yet), but perhaps the maintainers of mlx4 can weigh in?
> > 
> > v1 -> v2:
> >  - Patch 1/3 now initializes dropped to 0.
> >  - Patch 3/3 includes several changes:
> >    - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> >      valid before proceeding.
> >    - All initialization to 0xff for stats fields has been omit. The
> >      network stack does this before calling into the driver functions, so
> >      I've adjusted the driver functions to only set values if there is
> >      data to set, leaving the network stack's 0xff in place if not.
> >    - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).
> 
> All the ones you report right? Not just zero the struct.
> Any day now (tm) someone will add a lot more stats to the struct
> so the init should be selective only to the stats that are actually
> supported.

Yes, not just zero the struct. Since I am reporting bytes packets for both
RX and TX and alloc_fail for RX I'll be setting those fields to 0
explicitly.

And there's also a warning about unused qtype (oops) in patch 2/3.

So, the revised v2 list (pending anything Mellanox wants) is:

  v1 -> v2:
   - Patch 1/3 now initializes dropped to 0.
   - Patch 2/3 fix use of unitialized qtype warning.
   - Patch 3/3 includes several changes:
     - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
       valid before proceeding.
     - All initialization to 0xff for stats fields has been omit. The
       network stack does this before calling into the driver functions, so
       I've adjusted the driver functions to only set values if there is
       data to set, leaving the network stack's 0xff in place if not.
     - mlx4_get_base_stats set all stat fields to 0 individually (no locking etc needed).

I'll hold off on sending this v2 until we hear back from Mellanox to be
sure there isn't anything else I'm missing.

> > Let me know if that sounds vaguely correct?
> > 
> > > Also what does this:
> > >   
> > > >	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))  
> > > 
> > > do? 🤔️ what's a "master" in this context?  
> > 
> > I have a guess, but I'd rather let the Mellanox folks provide the official
> > answer :)
> 
> My guess is that on multi-port only one of the netdevs is "in charge"
> of the PCIe function. But these are queue stat, PCIe ownership may
> matter for refresh but not for having the stats. So my guess must be
> wrong..
>
> > > > Sorry about that; just realized that now and will fix that in the v2 (along
> > > > with any other feedback I get), probably something:
> > > > 
> > > >   if (priv->rx_ring_num) {
> > > >           rx->packets = 0;
> > > >           rx->bytes = 0;
> > > >           rx->alloc_fail = 0;
> > > >   }
> > > > 
> > > > Here for the RX side and see below for the TX side.  
> > > 
> > > FWIW I added a simple test for making sure queue stats match interface
> > > stats, it's tools/testing/selftests/drivers/net/stats.py
> > > 
> > > You have to export NETIF=$name to make it run on a real interface.
> > > 
> > > To copy the tests to a remote machine I do:
> > > 
> > > make -C tools/testing/selftests/ TARGETS="net drivers/net drivers/net/hw" install INSTALL_PATH=/tmp/ksft-net-drv
> > > rsync -ra --delete /tmp/ksft-net-drv root@${machine}:/root/
> > > 
> > > HTH  
> > 
> > Thanks, this is a great help actually.
> > 
> > I have a similar changeset for mlx5 (which is hardware I do have access to)
> > that adds the per-queue stats stuff so I'll definitely give your test a try.
> > 
> > Seeing as I made a lot of errors in this series, I'll hold off on sending the
> > mlx5 series until this mlx4 series is fixed and accepted, that way I can
> > produce a much better v1 for mlx5.
> 
> mlx5 would be awesome! But no pressure on sending ASAP. I was writing a
> test for page pool allocation failures, which depends on qstat to check
> if driver actually saw the errors (I'll send it later today), and I
> couldn't confirm it working on mlx5 :(

My hesitation with sending mlx5 changes is that I didn't want to add more
noise than I already have with my existing errors. I figured by getting
mlx4 working/accepted I'd know enough about the API to send a much better
v1 for mlx5 reducing the work for you (and everyone else) involved.

FWIW, I also attempted to implement this API for i40e (hardware I also
have):

  https://lore.kernel.org/lkml/20240410043936.206169-1-jdamato@fastly.com/

But there are some complications I haven't resolved, so I'm focusing on
mlx4 and mlx5, first, and will have to come back to i40e later.

