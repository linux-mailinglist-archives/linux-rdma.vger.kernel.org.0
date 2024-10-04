Return-Path: <linux-rdma+bounces-5218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E7990900
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 18:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6109B1C21FDB
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796F1C75EA;
	Fri,  4 Oct 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDhogYdp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A81C303B;
	Fri,  4 Oct 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058948; cv=none; b=F2vMSoiZcJTV74X7fk7mJRx3/zcApXZscxOqKssdA2p21TdSAnaMYHkI8iUVlxMD4YwWA+kmy3j//+0t94HU8vkkBqsaNiqolk5EMkxVka4eGuiY9WturusNNYfG1XH9/jHS0jp4pnx/Onxbje8g2tgHyxtnAg+l8zfxjooM8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058948; c=relaxed/simple;
	bh=YB1a8wOwJLhAqIe6duyZgwM93LIZHutIryJ+TLjttiY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqpc/MyvTCOIqfiH/t638ssHXFEHKXZewIOm9np85LN73cOn1QODrzcamE2yQfHJKELMpqWedMLvF0IC9ooFzo0qUCsL0F07IRbsX5LpCQmyc132eM6SHW7SBKsB8Y8dDoIZVOykMXkPa8zhH1UGopY+CqEc3Pb4AxprTPJ+qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDhogYdp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so1949778a91.3;
        Fri, 04 Oct 2024 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728058946; x=1728663746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiKLndcyYH7rIY6+ban5HB3XSyx5eEP2bPfLFhg1KI4=;
        b=cDhogYdp7rYQrp8JdXO9ieyoR1YOwRzumxIswQr12XJX9gb2L99XK7GEra8511jxhS
         FlaoMCZxMBPM7Ib2K7tShCaYZHndi4fM7GYUAigU8OaMrvu9clLc1mda61KImIqR806t
         dwS+BdvvdBOKzj06uAIsZQRj2Xdc17YvPME3VboA0ZGQXVj6o2zdHf4byznrpY5XMpre
         BVhexbD+HeqA+j/1L56he/5bNeRXZQPbm51UvhT0uXmapez87On8MjLCAG3IT7+QtC7Z
         uIqr/BTG5guwMX2Wf8qaGI78OBKgsgNepTui31i+wAwgj7loQbmE8++E4o82ASnZDNRf
         H9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058946; x=1728663746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiKLndcyYH7rIY6+ban5HB3XSyx5eEP2bPfLFhg1KI4=;
        b=JDDXz0FXF9u0m1QDfFjWHglp0V9t2KxdHwyg2aWUeTMJK+l1bzAAN9zEXqHe0CFPYV
         o6xN9aFdU0YeWDlJwMUznk3ugv8Y+LA5Hem4on66SOoEtSBZ0Qlh/z5gxW0GqFHvhCIN
         Y8LQqFwhIYVmo/typNPXa9or+vHDKhLjt8dnhsVJLbn3bFuJo2pNyUvR6/G4sJwV2DOz
         7d7h+Efj39Xd+PiLJdddh2haEHBzgKHUYCOYir2Z0kS+pkzVESZhex0PZWavoXJNfaLp
         RqUn92iv4lgoji8WfEqDGUxyq1RDq40TMaLlBn50KgtI4PUHbVkyY4Qle4T1XboWXT1q
         1gcg==
X-Forwarded-Encrypted: i=1; AJvYcCU24yMH/d6uOFYVvCNvvmYs40I2Cwy9MszoXQYbmw83nSZvuXKlb1eUGdTWDxWzCgmVfnysggMS@vger.kernel.org, AJvYcCVjTJ4O7jMwdCy+b941Nna3vOkxlJP84C2X9VXD+bRibZtg4CTAhD7mnrRCamPwKS8Po5SddyrqmjcUmOV1@vger.kernel.org, AJvYcCW0Rz2eBz8IjZQXZwkS14dIsbq8yhg4ceG7QLH5QOa4ZEIFMr7iYDJiMqEW9/Kl4nuxWcLAZ//rm9wlOw==@vger.kernel.org, AJvYcCXTFT5d22wZS2Sp0Hzt+oEL/2CY2J3Ffgqo0dj0f/n5RFc+ck7UQBiw19UrsKzQXDy20vAdtqY2bg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlN5lGx2mNTEAhJSGqJMLnQ0iO4ZcC1kP6pB1fd0o75mzHuTD
	kF4tjFSVPeuZ8uj96Z1wxf7Jczze2yHCKzMy7Z5bNO/oWim+Tb4=
X-Google-Smtp-Source: AGHT+IEI6UcOl2z3NwD/Obevru63AVasNN95GSKu0sNmL+CypXsezoR8vxwOcZjTy/7iJ1GELnSOLA==
X-Received: by 2002:a17:90b:d81:b0:2d8:f3e7:a177 with SMTP id 98e67ed59e1d1-2e1e620db58mr3188386a91.6.1728058945894;
        Fri, 04 Oct 2024 09:22:25 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86aa36dsm1806025a91.53.2024.10.04.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:22:25 -0700 (PDT)
Date: Fri, 4 Oct 2024 09:22:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Daniel Jurgens <danielj@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v4 0/9] Add support for per-NAPI config via netlink
Message-ID: <ZwAWQCpSbb4sn0LX@mini-arch>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <Zv8o4eliTO60odQe@mini-arch>
 <Zv8uaQ4WIprQCBzv@LQ3V64L9R2>
 <Zv9UA1DkmJQkW_sG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv9UA1DkmJQkW_sG@LQ3V64L9R2>

On 10/03, Joe Damato wrote:
> On Thu, Oct 03, 2024 at 04:53:13PM -0700, Joe Damato wrote:
> > On Thu, Oct 03, 2024 at 04:29:37PM -0700, Stanislav Fomichev wrote:
> > > On 10/01, Joe Damato wrote:
> > 
> > [...]
> >  
> > > >   2. This revision seems to work (see below for a full walk through). Is
> > > >      this the behavior we want? Am I missing some use case or some
> > > >      behavioral thing other folks need?
> > > 
> > > The walk through looks good!
> > 
> > Thanks for taking a look.
> > 
> > > >   3. Re a previous point made by Stanislav regarding "taking over a NAPI
> > > >      ID" when the channel count changes: mlx5 seems to call napi_disable
> > > >      followed by netif_napi_del for the old queues and then calls
> > > >      napi_enable for the new ones. In this RFC, the NAPI ID generation
> > > >      is deferred to napi_enable. This means we won't end up with two of
> > > >      the same NAPI IDs added to the hash at the same time (I am pretty
> > > >      sure).
> > > 
> > > 
> > > [..]
> > > 
> > > >      Can we assume all drivers will napi_disable the old queues before
> > > >      napi_enable the new ones? If yes, we might not need to worry about
> > > >      a NAPI ID takeover function.
> > > 
> > > With the explicit driver opt-in via netif_napi_add_config, this
> > > shouldn't matter? When somebody gets to converting the drivers that
> > > don't follow this common pattern they'll have to solve the takeover
> > > part :-)
> > 
> > That is true; that's a good point.
> 
> Actually, sorry, that isn't strictly true. NAPI ID generation is
> moved for everything to napi_enable; they just are (or are not)
> persisted depending on whether the driver opted in to add_config or
> not.
> 
> So, the change does affect all drivers. NAPI IDs won't be generated
> and added to the hash until napi_enable and they will be removed
> from the hash in napi_disable... even if you didn't opt-in to having
> storage.
> 
> Opt-ing in to storage via netif_napi_add_config just means that your
> NAPI IDs (and other settings) will be persistent.
> 
> Sorry about my confusion when replying earlier.

AFAIA, all control operations (ethtool or similar ones via netlink),
should grab rtnl lock. So as long as both enable/disable happen
under rtnl (and in my mind they should), I don't think there is gonna
be any user-visible side-effects of your change. But I might be wrong,
let's see if others can come up with some corner cases..

