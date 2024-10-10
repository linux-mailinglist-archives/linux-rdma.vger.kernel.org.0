Return-Path: <linux-rdma+bounces-5344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C0997B2A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 05:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F19284178
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C318F2FF;
	Thu, 10 Oct 2024 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNBTouai"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE868F6A;
	Thu, 10 Oct 2024 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530273; cv=none; b=VMau+UDAlSqmLyf1fN523euI33iXsia1sPnmzDlIIlCyS+XMIbeE/t80ndgpHqMoYN04hQM3MKgfkXwrhrof+L2ljSlT/SPt8UKL9Jw/boerBSRemm3qJxmRf8hjYOXXJto4ZGD5+fZGgxAWeoAsATW28pYDnUE+WpXTbcIKNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530273; c=relaxed/simple;
	bh=AjLHVrEVVrVsEb7N4x+s+AExpp1a7t6vZOUU+9aw58E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mauMLxKxi8+j+3pTaDqffDg9Y44Pc+Hf03arEDgbLXBYindhGAV15WI7R3jQXPUlyPDaoVEgs02Tfq4jx8Jbh1sZeZIhuG/U5W9ktc0dSTQdaCmX9iHiYguYqbQS1tFuMP3HEAAsEC8vwIxlY4Gk+i2aYy/EozyGzJzTTJCXTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNBTouai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC76C4CEC3;
	Thu, 10 Oct 2024 03:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728530272;
	bh=AjLHVrEVVrVsEb7N4x+s+AExpp1a7t6vZOUU+9aw58E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNBTouai6ON6V2/sK5bbjlRvY/0Ln2tV9ugfBHEwMmK5L4PJ5xxvcyWBco95i4W+9
	 3DWqfRqHrzVj13yAxw7ToQvmg1ZqXXUNFh9SMPcEZlPp9cU8CZnuuBLW0Q2B4Tsc//
	 mfRoGsIBlFZtwr1Vm7RLvF95FxF49g7Ox5c20aywJGcjtLi2AbGruI6tmaGaf0EN+f
	 GfD9O4HYAmHATN6oT73L5yRwwXc9n3tIpjvu6a2fRnl5124+/0kpL5u8UdW3JIzw56
	 UZpfGICVKooX1X5pNsPqqVCHKeiZ1w/ybghfqNskLBslUwWcYfUrRyD3ogZtbxS9AV
	 fCNuMkbWlnCDA==
Date: Wed, 9 Oct 2024 20:17:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>,
 Daniel Jurgens <danielj@nvidia.com>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Johannes
 Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Kory
 Maincent <kory.maincent@bootlin.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list), linux-rdma@vger.kernel.org (open
 list:MELLANOX MLX4 core VPI driver), Lorenzo Bianconi <lorenzo@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Mina Almasry
 <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tariq Toukan <tariqt@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [net-next v5 0/9] Add support for per-NAPI config via netlink
Message-ID: <20241009201750.2cf56a6f@kernel.org>
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 00:54:54 +0000 Joe Damato wrote:
> Welcome to v5, the first non-RFC version of this code! See the changelog
> below for more details on changes between revisions.

I'm probably going to end up applying this but just in case:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Very neat work !

