Return-Path: <linux-rdma+bounces-5201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333F98FA6F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 01:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5D61C22663
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E721CF7BD;
	Thu,  3 Oct 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mARgVRjn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440E1CF2B1;
	Thu,  3 Oct 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998181; cv=none; b=AkQgSsPS71olJfeWxF5t9Q3/FoXgbbXB4lTHElNohb/CSmKazSclRtuy4TIqgop52GNEA1T1DVGmtS0PmHyHLJ4R4GUwW8x16TgUD3lyacluvZN5YbTCyWJAeTIxIUwvfpq3mDiI3uDmBtzLGpkZTj13IYRAOO9Xl3jrgtQNeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998181; c=relaxed/simple;
	bh=mJtFrfre42Mt9eobC0iG8th1OV5j+wuKcJnSwi//4c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIUsN5NgdwnOnb8KjAweitA748075iqaovlCj17WPoSbsI+D6IT7ho+7p9lKY8hiRDXEVNGBINb4AKm8e/rp595JiAszX12i4Y57UJHttfCAoiLiNjhID/Z6dpfC+r0iOrM9s8tGl9q5yb13tAdkrNS0ocCHdj9XOdBSEIks4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mARgVRjn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718d606726cso1195443b3a.3;
        Thu, 03 Oct 2024 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727998179; x=1728602979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJJfYTsJBD1YUpbtaYyu99p9PsYf+XDP7HfTuVlkPL0=;
        b=mARgVRjnQdmcY/CHUG7um0qjb6S4/8kvc3F8DKMf8ayxTisAm66Zz4NiNdDcxr3BFQ
         blHZyE0Usz8U6ppFumA9zZ7aSSM/9vdzFhI+uWmswOuterYOoB9j02+osF/VjhAjCNUO
         OdbKzDxc4CmCatfQimXeXH+vbuddHYJV4ILhSkWSX4rU36SstKlgAv/TcbB6N4sIXT7O
         hes5X6/wQY5ldm65ZDKEg6na6WUDFAH8riRVfwbOJy9FymwyHZ5aDY8viMrzfnv0La8m
         ipKrphsO39QZqiJNvoldM9jPUfxWOWmS2jSqXXTv5X9+S+tTf8vEdtlVm7g3qWE425cK
         8/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998179; x=1728602979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJJfYTsJBD1YUpbtaYyu99p9PsYf+XDP7HfTuVlkPL0=;
        b=r0Qx/UEqyX5n4e4J0wQrvJ0kiydzUFuKmahgxt8eaIPFG7lw/tk87q0vT8SsxDj/Fa
         6dVdvfwAdA17DaKiKLusjMyxVahFuB/Kr1FaBddH5N0rGb1GgpInWL/F0P60yRfQFiqD
         fRx7jMWHfylWm4IdoLFoJBNgIE8iYJHRNGXHYP9TdJj1U+AxK60gBlZCoE+l9SLaw/wt
         4d8Dwd97XcI72+DxvUDEcUEz7x3TOZ81HP0R39MurW52t7xqoAdv6WxGe4Im13hCNTP/
         Ee+CsXY1kVdw50L9cqd1oHPX9V9nCjiyCzHdFNoHfCttyzdKTUigrwyTDkq0r6P0sR9A
         Ap2A==
X-Forwarded-Encrypted: i=1; AJvYcCUFSRGdqYjdF/QwHxPhXruNhYUlZlUxdFjy0IW3A9rZO4JdGhxJQTANPyeU8dINeFqqGsjI0LAypW8=@vger.kernel.org, AJvYcCX5JifCwYQBp+YprvnVUWgiysQSS9UOLLPdmfRAEJ2DZHwwUb/MRvzgRM47UXyM8j6lY30iG+JqQ+vl2g==@vger.kernel.org, AJvYcCXcr2TQ6oPlptOreOrPu6yZKgqeP6XUGcjDlh/dh85tRJXtprwjAbOgMaowszcx1y//1mnWEV937LoJZhMj@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdmZMjb+u19hdvLcsndbmPTTjKhaovr3VUyPPTswRPzPeCeaO
	F9FJa8J7XGqKbBedZEQxGJSES1z8Ya8zxsczzibGngBpByuerm0=
X-Google-Smtp-Source: AGHT+IGvaV40ffnh+bcHsRNWNaFU/gWd5N//USCwZyNU/5JM6pBgrlCZqQRe3DPLD2Ps7suX/tnyoA==
X-Received: by 2002:a05:6a21:3489:b0:1cf:2aaa:9199 with SMTP id adf61e73a8af0-1d6dfa35eb5mr1378179637.15.1727998179000;
        Thu, 03 Oct 2024 16:29:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9e0809bsm1932509b3a.201.2024.10.03.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:29:38 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:29:37 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>
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
Message-ID: <Zv8o4eliTO60odQe@mini-arch>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>

On 10/01, Joe Damato wrote:
> Greetings:
> 
> Welcome to RFC v4.
> 
> Very important and significant changes have been made since RFC v3 [1],
> please see the changelog below for details.
> 
> A couple important call outs for this revision for reviewers:
> 
>   1. idpf embeds a napi_struct in an internal data structure and
>      includes an assertion on the size of napi_struct. The maintainers
>      have stated that they think anyone touching napi_struct should update
>      the assertion [2], so I've done this in patch 3. 
> 
>      Even though the assertion has been updated, I've given the
>      cacheline placement of napi_struct within idpf's internals no
>      thought or consideration.
> 
>      Would appreciate other opinions on this; I think idpf should be
>      fixed. It seems unreasonable to me that anyone changing the size of
>      a struct in the core should need to think about cachelines in idpf.

[..]

>   2. This revision seems to work (see below for a full walk through). Is
>      this the behavior we want? Am I missing some use case or some
>      behavioral thing other folks need?

The walk through looks good!


>   3. Re a previous point made by Stanislav regarding "taking over a NAPI
>      ID" when the channel count changes: mlx5 seems to call napi_disable
>      followed by netif_napi_del for the old queues and then calls
>      napi_enable for the new ones. In this RFC, the NAPI ID generation
>      is deferred to napi_enable. This means we won't end up with two of
>      the same NAPI IDs added to the hash at the same time (I am pretty
>      sure).


[..]

>      Can we assume all drivers will napi_disable the old queues before
>      napi_enable the new ones? If yes, we might not need to worry about
>      a NAPI ID takeover function.

With the explicit driver opt-in via netif_napi_add_config, this
shouldn't matter? When somebody gets to converting the drivers that
don't follow this common pattern they'll have to solve the takeover
part :-)

