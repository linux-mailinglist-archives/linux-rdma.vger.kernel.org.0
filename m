Return-Path: <linux-rdma+bounces-2042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD38B015F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 07:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434AB1C22A71
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795815687D;
	Wed, 24 Apr 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Kctn6Ro2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C82139CEB
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938096; cv=none; b=pMXA7eASPrVHoKtoSRwXyBGqrLnm3dY0LHsKDNx3UDs3RprHrebDkIZv0Op0TlllQzvfeO5R0Gyrz+ih0l6A/8bi+FaAxijh/vU6qiVsn7kValbK/4qoqryb4hlE8mHTuqCqEhXWGEdA0mZ9ApVeVrQhV+DGahILqpTmdcw9Qi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938096; c=relaxed/simple;
	bh=fSlQFB5Q741BlJMoGM4ZGE+J/3+Kp0MMKIppAcJsTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfpAxn42TdJIo013v6uwUT+aFbBeLuossIMa2iNvN+TFCLPIHNy6IiKMirkannaKRJYPoY3ERHYYZN37YU8rG+n7FR4oJVx8JzzfqcLktHBFWCY1JSj0Ur4/+7k4eBHVp6RuXwROnjMDqTrCu8DdPb6ZgXnMCgceGBcBbK6kepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Kctn6Ro2; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22edcfcd187so2637230fac.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 22:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713938094; x=1714542894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vm716h/E/MvmkXYl+WfP3NBFMb2+sgnZJIcF5EnCuNQ=;
        b=Kctn6Ro2VI6ZXDFtD4BIlKS50q8xlyTe7WzkzDEXtmr6jH6RWyXE0wDNot+F/kgdlz
         afjHUIAglfyd7uJJmclmzPzUj6kmFsjQyWKCacJZDBapjygtdDQB5LDQdBiMTuQ0nYvO
         UIbw8EWxOyDUhKNxR7bSJlL1JqNDlc+xi0ICI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713938094; x=1714542894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm716h/E/MvmkXYl+WfP3NBFMb2+sgnZJIcF5EnCuNQ=;
        b=fwPyG21gfFMWHY5xUg6nIoxzMB94rYQ0Mdv07UYX1sUeWcqrqq6ZzJTRya+/8UfHtD
         pV4ZGIsfV2l3C1cbBqnwfluu5SSq/rYGlrZ/KbZ24a025gnIJ9GLNILCRiaAKcZu0rDX
         kqRU4m6xHsQdHMUrvRfYbVyV3DRwFbExDXjqnlqbH46l4BOX64XSXQk93I49Jbs1EQ9R
         gSKROpbcjeEEx4hO9nPArwtz0Ccym9sQyw8r9vp28ZiX5zBEw3W55R2FzVqSxAE+2wNW
         xzd4lmKOdrZM+KEiq3oH6k3HhFy5nSukBg3vfQOKmO/r1eRILBF3LIZ+p+KVUw2Paf02
         ge3g==
X-Forwarded-Encrypted: i=1; AJvYcCVfxNwN7r4o/OTp2CMxS3Fusfwdsamdqk5EhZm7BPAZdAiSErl1DO4sewFbG4CzCnU2MGNjUd37UdvK2O+ywb+aP5S+uURHLWO9qw==
X-Gm-Message-State: AOJu0YwYQqzMPm0H4F8dAPcJz3CITozBXBJAetnQRmDvj06PdIgjAibV
	CK0uj60+8zR2ygRxH7EOVqRUUUUBfzo966yJ7/zYEj9d77+gG1Pv7/xH61QYtjk=
X-Google-Smtp-Source: AGHT+IHuU6A/3qtMx9qP55eHNDqJTaKHBKi3aC2rPbOPp4l4IO22Wu7lGZU6+ovUskgwg4UXCrMPXw==
X-Received: by 2002:a05:6870:9209:b0:22e:c4e7:8aba with SMTP id e9-20020a056870920900b0022ec4e78abamr1877084oaf.47.1713938093958;
        Tue, 23 Apr 2024 22:54:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id f4-20020a656284000000b005c6617b52e6sm9222159pgv.5.2024.04.23.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:54:53 -0700 (PDT)
Date: Tue, 23 Apr 2024 22:54:50 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
 <Zig5RZOkzhGITL7V@LQ3V64L9R2>
 <20240423175718.4ad4dc5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423175718.4ad4dc5a@kernel.org>

On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:
> > I realized in this case, I'll need to set the fields initialized to 0xff
> > above to 0 before doing the increments below.
> 
> I don't know mlx4 very well, but glancing at the code - are you sure we
> need to loop over the queues is the "base" callbacks?
> 
> The base callbacks are for getting "historical" data, i.e. info which
> was associated with queues which are no longer present. You seem to
> sweep all queues, so I'd have expected "base" to just set the values 
> to 0. And the real values to come from the per-queue callbacks.

Hmm. Sorry I must have totally misunderstood what the purpose of "base"
was. I've just now more closely looked at bnxt which (maybe?) is the only
driver that implements base and I think maybe I kind of get it now.

For some reason, I thought it meant "the total stats of all queues"; I didn't
know it was intended to provide "historical" data as you say.

Making it set everything to 0 makes sense to me. I suppose I could also simply
omit it? What do you think?

> The init to 0xff looks quite sus.

Yes the init to 0xff is wrong, too. I noticed that, as well.

Here's what I have listed so far in my changelog for the v2 (which I haven't
sent yet), but perhaps the maintainers of mlx4 can weigh in?

v1 -> v2:
 - Patch 1/3 now initializes dropped to 0.
 - Patch 3/3 includes several changes:
   - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
     valid before proceeding.
   - All initialization to 0xff for stats fields has been omit. The
     network stack does this before calling into the driver functions, so
     I've adjusted the driver functions to only set values if there is
     data to set, leaving the network stack's 0xff in place if not.
   - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).

Let me know if that sounds vaguely correct?

> Also what does this:
> 
> >	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
> 
> do? 🤔️ what's a "master" in this context?

I have a guess, but I'd rather let the Mellanox folks provide the official
answer :)

> > Sorry about that; just realized that now and will fix that in the v2 (along
> > with any other feedback I get), probably something:
> > 
> >   if (priv->rx_ring_num) {
> >           rx->packets = 0;
> >           rx->bytes = 0;
> >           rx->alloc_fail = 0;
> >   }
> > 
> > Here for the RX side and see below for the TX side.
> 
> FWIW I added a simple test for making sure queue stats match interface
> stats, it's tools/testing/selftests/drivers/net/stats.py
> 
> You have to export NETIF=$name to make it run on a real interface.
> 
> To copy the tests to a remote machine I do:
> 
> make -C tools/testing/selftests/ TARGETS="net drivers/net drivers/net/hw" install INSTALL_PATH=/tmp/ksft-net-drv
> rsync -ra --delete /tmp/ksft-net-drv root@${machine}:/root/
> 
> HTH

Thanks, this is a great help actually.

I have a similar changeset for mlx5 (which is hardware I do have access to)
that adds the per-queue stats stuff so I'll definitely give your test a try.

Seeing as I made a lot of errors in this series, I'll hold off on sending the
mlx5 series until this mlx4 series is fixed and accepted, that way I can
produce a much better v1 for mlx5.

Thanks,
Joe

