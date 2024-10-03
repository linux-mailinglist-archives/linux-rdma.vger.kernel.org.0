Return-Path: <linux-rdma+bounces-5202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7D98FB32
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 01:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41181F22724
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4D1D049B;
	Thu,  3 Oct 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vNJy90uO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3591BFE01
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999599; cv=none; b=hbm4+cDHOBkZNDaOUgXKhUCxo1oClCXZo383fh+kWx85Dg8cqpIE/JdoB8sfUoneOPXL2Xgvz4p03E+wIgzPHpJ7WP8EVDOpi+0ekkQknjDss9n0eVHIvB9Z/DDN3zoE57EqJLHytcZOUtkqDKkWvls2mlg6PLRQV5IVGoPEX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999599; c=relaxed/simple;
	bh=GzAathxYkC8uI6l+NrPvM061Qz0CwHqH7iz9J9uA/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX7jp75TQfJ/mgjFuNGfX1VLghtJnSpDuGDEFPLlS31uwWHhX/RY89yHenZoWR43UrdZUDmxTqgSBnpj0vGnFJnKnGd6fTs5yb2I0KKI0PM1MU+NYuDzCo07eKGMrWkZ7AnD9TX/m15Y7VMGSV2CEYtyQiBl92ZjLmho4K8JjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vNJy90uO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so1186333b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2024 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727999597; x=1728604397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to5UESfoGJJK2TcGhffLq8Xvshlbs/BIWcOtCWTyRfU=;
        b=vNJy90uO/+wCEOTKqeNg+81U8xfWbr2RJzNeMJeW872P4JZGCzfKRPswC3jwAotVmz
         mN62T1I79l4TMVIntHJkiFM5hUSqCl9noXafw7lI3Kjj5Nc+8qKLVLu/Qic3NvlRPKZ7
         6A1+lk9Qz+fn7YPFyLpRdTNhZuyxehLXf54q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999597; x=1728604397;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to5UESfoGJJK2TcGhffLq8Xvshlbs/BIWcOtCWTyRfU=;
        b=IY+yc95sIZBKPISc9HsRrrTwLMFH1Dof3AXc5FS9sUtZujheHcwxERTS2eb4z7MGcX
         Q7JpuIxK3lsr1zTweXDwIEmswZIwCSbmWD+aUZUCaKnML38yqops4Qq0rxp5qyu6fSH4
         4SaSFQye/YHnEmKowNaNVqojqajjxzD+2uDc9yjcsahBCKLExBxiIkRWdLoFWhfgm6HA
         gn+tbF9uhh4eNDi8OnwhK0mxXaUkqql/GIPztxFI4Vo/a7G8/nP2nQLtgRbg3puk4cCN
         WB3QWu5OC9dTgR0Uy4xFi7Unb8VZRO7D7cUPvCDUO2Jm8cyXP2M72nT/0FxUPrbuQ96L
         ETAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLTv63RFyM40Jvu1A+a8Qk37gHnfES6CM3AV0yFnPsyXSSXlCau5ti6264HIH75HIeP1N5xutuOo6n@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5+DDtO8Uh8FF3gcUBgeEcTM2Bhv/axbtt2ascpwB/QWY/g5p
	QlWbkE8pquwfpYn8cDlF7cwfD3KN9C5CuuFHWtUp9FSbPbSYQ5URLQ1XHt4Wons=
X-Google-Smtp-Source: AGHT+IHFFJEXCsS7CL3SCEq6Zn2fPKDty4P7fGrgnhTy1s2+ZG4Kz84QJLtn4fcPKjIeGqhkJ9NQCw==
X-Received: by 2002:aa7:8e0e:0:b0:717:9897:1405 with SMTP id d2e1a72fcca58-71de2439b2dmr1040349b3a.17.1727999597631;
        Thu, 03 Oct 2024 16:53:17 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df57ddsm1970234b3a.184.2024.10.03.16.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:53:17 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:53:13 -0700
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
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
Message-ID: <Zv8uaQ4WIprQCBzv@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv8o4eliTO60odQe@mini-arch>

On Thu, Oct 03, 2024 at 04:29:37PM -0700, Stanislav Fomichev wrote:
> On 10/01, Joe Damato wrote:

[...]
 
> >   2. This revision seems to work (see below for a full walk through). Is
> >      this the behavior we want? Am I missing some use case or some
> >      behavioral thing other folks need?
> 
> The walk through looks good!

Thanks for taking a look.

> >   3. Re a previous point made by Stanislav regarding "taking over a NAPI
> >      ID" when the channel count changes: mlx5 seems to call napi_disable
> >      followed by netif_napi_del for the old queues and then calls
> >      napi_enable for the new ones. In this RFC, the NAPI ID generation
> >      is deferred to napi_enable. This means we won't end up with two of
> >      the same NAPI IDs added to the hash at the same time (I am pretty
> >      sure).
> 
> 
> [..]
> 
> >      Can we assume all drivers will napi_disable the old queues before
> >      napi_enable the new ones? If yes, we might not need to worry about
> >      a NAPI ID takeover function.
> 
> With the explicit driver opt-in via netif_napi_add_config, this
> shouldn't matter? When somebody gets to converting the drivers that
> don't follow this common pattern they'll have to solve the takeover
> part :-)

That is true; that's a good point. I'll let the RFC hang out on the
list for another day or two just to give Jakub time to catch up on
his mails ;) but if you all agree... this might be ready to be
resent as a PATCH instead of an RFC.

