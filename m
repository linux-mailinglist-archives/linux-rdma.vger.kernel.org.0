Return-Path: <linux-rdma+bounces-5205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7B98FC5B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 04:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7C91C22174
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DA11C92;
	Fri,  4 Oct 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZgPUkvRf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62961F943
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009226; cv=none; b=K7Q7RQ+8ZsdbQhoeK9cDa0mZAhTDNKxaz6aDz4qKJRnUKcJLHD6v6jAY7qOYHcHljpFLoo6AOo82AwkyLha1ZO/UuqKt6fEWqwZmQCfe1XEgzwB7GLwD/mtmzD592XLmwhabIAbK57xpiStasenzNROW7RRLnJJZhGHvL8O16dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009226; c=relaxed/simple;
	bh=1iJnEbdsiNl3GTWvx5w9tGzoQRxZUIi7Ftyexx/+bg0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7Qqupe2FaGBXXNutxHFK730TkB3jVyFRCyrFYwbyyFv+EzO8hthwUSA6EsHK0OZ5PaBR53Z87jnI+4EXOSDcJx1yT7v4/qdpRA+E1e8FGHDI/xC59KnMNCsTVDnlx3dBGhlUFwLxn8ykMPCLWw346VnahCFT/qKkuVG0Qexyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZgPUkvRf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ba8d92af9so12332325ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2024 19:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728009224; x=1728614024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9H4D+WZl8jML+ibwIYSpYRCghKODZjSTjCYZIURMulA=;
        b=ZgPUkvRf8SZFa7XHwC32up2IYzkcAB8nrf/JjF5oX6Gk2jRzxagvtgl0NSPnUJp/wV
         1s/AFsGAUsja6BBzDZc12fzGSGW1buPEQhOLu3ajpmtzvF4dOr08AjpC2uakXz4zEwEY
         YbxmM4qImziu+ynaSzSePJHjPlC1SfKEZG03c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728009224; x=1728614024;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H4D+WZl8jML+ibwIYSpYRCghKODZjSTjCYZIURMulA=;
        b=OBMY7GI5C7ZVakyIFxoV3nDdGWGDlSaFmNMjoact5zUOOSEZlivRj/YJJmOHMdWwZH
         HghTSYW37do4vj39sB4LnZErj7RIsoJ3uTJ+wm6Hw2tOm9/Jg7ZsUzHa2VNY8GddbkRR
         RCgyuexL3nb5E9MC0OYWxtXOnVV/WJNaKLkbYU1BIwW41sM5vqNPdzFszw4G3JhQycqH
         tW6zoOvkomtbtyn8H9jC5j8wiq1xWK01Yu2xBBkIyz8QTE+Z0x8WdSlYuxiyEEqnLPv0
         y8q/vqOl39Wl2cHr0CGLCVF4iYZW0MSHvG/c/qo6V/grD999BBNud3O9Y51cO/ApiV3g
         Yb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3MnWQiIGJ6Bc6cU98CmdSfAKonbHK7o6K8lPy/OQTjd+r+xdkLETfWYjHupADL+j1oIOtaliFdFHw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5DtN7VjhEnIGSF3W70ka16S5jp/91oCoG3j1IPpgLsVyeKm2
	QuW/768jVWyvtBq6JlR2esYCEq9/3yBpiWTFUtewma6EOsBBnDTzJUSPfeT2wDw=
X-Google-Smtp-Source: AGHT+IEda9b9DeMXqjPne8SvGPfaIWpvZM2WaGMC+2rBD3ZG/loQ372RspkJp/s9zdDN5H7i2x/5ng==
X-Received: by 2002:a17:902:e849:b0:20b:a10c:9be3 with SMTP id d9443c01a7336-20bfdfe4834mr17933695ad.21.1728009224150;
        Thu, 03 Oct 2024 19:33:44 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8eb0csm15268325ad.165.2024.10.03.19.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 19:33:43 -0700 (PDT)
Date: Thu, 3 Oct 2024 19:33:39 -0700
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
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
Message-ID: <Zv9UA1DkmJQkW_sG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
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
References: <20241001235302.57609-1-jdamato@fastly.com>
 <Zv8o4eliTO60odQe@mini-arch>
 <Zv8uaQ4WIprQCBzv@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv8uaQ4WIprQCBzv@LQ3V64L9R2>

On Thu, Oct 03, 2024 at 04:53:13PM -0700, Joe Damato wrote:
> On Thu, Oct 03, 2024 at 04:29:37PM -0700, Stanislav Fomichev wrote:
> > On 10/01, Joe Damato wrote:
> 
> [...]
>  
> > >   2. This revision seems to work (see below for a full walk through). Is
> > >      this the behavior we want? Am I missing some use case or some
> > >      behavioral thing other folks need?
> > 
> > The walk through looks good!
> 
> Thanks for taking a look.
> 
> > >   3. Re a previous point made by Stanislav regarding "taking over a NAPI
> > >      ID" when the channel count changes: mlx5 seems to call napi_disable
> > >      followed by netif_napi_del for the old queues and then calls
> > >      napi_enable for the new ones. In this RFC, the NAPI ID generation
> > >      is deferred to napi_enable. This means we won't end up with two of
> > >      the same NAPI IDs added to the hash at the same time (I am pretty
> > >      sure).
> > 
> > 
> > [..]
> > 
> > >      Can we assume all drivers will napi_disable the old queues before
> > >      napi_enable the new ones? If yes, we might not need to worry about
> > >      a NAPI ID takeover function.
> > 
> > With the explicit driver opt-in via netif_napi_add_config, this
> > shouldn't matter? When somebody gets to converting the drivers that
> > don't follow this common pattern they'll have to solve the takeover
> > part :-)
> 
> That is true; that's a good point.

Actually, sorry, that isn't strictly true. NAPI ID generation is
moved for everything to napi_enable; they just are (or are not)
persisted depending on whether the driver opted in to add_config or
not.

So, the change does affect all drivers. NAPI IDs won't be generated
and added to the hash until napi_enable and they will be removed
from the hash in napi_disable... even if you didn't opt-in to having
storage.

Opt-ing in to storage via netif_napi_add_config just means that your
NAPI IDs (and other settings) will be persistent.

Sorry about my confusion when replying earlier.

