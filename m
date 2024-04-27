Return-Path: <linux-rdma+bounces-2125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D148B4346
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Apr 2024 02:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D912832BC
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Apr 2024 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198728DB3;
	Sat, 27 Apr 2024 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLTz2TqG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81B36AF2;
	Sat, 27 Apr 2024 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178048; cv=none; b=OyUVhOq2oO24bH+ZxOKuiWfRaAcD/sIVN0WPBgVWPbiaz5Yf2wcSY4lrHq3v/Ynpp+G6YndxnAVcIMH5Iqup3Y+gZMadxPb8uwx7DX1RuifQxVhmD5YVOXh3wMwrYKtdlWL0oSgv5sjOrLYwWfotmS/oLEV58+5BYkRLF1qPor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178048; c=relaxed/simple;
	bh=QOSurHx8KvEaTgm1R/FTe7IdK1kr1SKHl608kcWCsec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWxiI+RlJA41JK4Jz+h8D3945IQuppEPuHFFH1nXHkZpoT+0HR2xgKSdvyozwfXjpiZAi1J2nWI94Xhkus37Rg/BfR86sqnUi1DpMSCywfWfKxSG3V+xS+U74oPYf+hcRO3oMrQSUggDUwzZRQd/iC5wGVRbZR03CBmOOr2vPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLTz2TqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCB6C113CD;
	Sat, 27 Apr 2024 00:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714178048;
	bh=QOSurHx8KvEaTgm1R/FTe7IdK1kr1SKHl608kcWCsec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLTz2TqGGC4qRAvxIVAZfZzVvMsgGbIHXcIYLV++JSoHw911q3+Y5B/ti4aPl+GxG
	 zVHVy15rLwy4Hmp84kiJ4VhYhGC2pdWYVNpxnqe98xqJ/1bZvA2oSlDk+8n7FK6m+g
	 D82t/qPPcsyzAjYhb0azZln/qaVNuyghiceYAX3E7D0O5n8jfFV7ukQc0FnmJkYPzz
	 lh7bRJzO3CGeSIiJuhCYtm24a46QO+PVwgEo7q9lnQo4bH5xTOUjCdOXX83rHz6vVH
	 zc2O/Saatf8noA50lf/jeIpYIUqUCHSYR7AcTR+R4p941tShlIqZ9Xv5JZUbnLlhUi
	 i0xlT6R6kKOkw==
Date: Fri, 26 Apr 2024 17:34:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX
 MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <20240426173406.3b2526d0@kernel.org>
In-Reply-To: <ZixGk8dy8INWD6PV@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
	<20240426183355.500364-2-jdamato@fastly.com>
	<20240426130017.6e38cd65@kernel.org>
	<Ziw8OSchaOaph1i8@LQ3V64L9R2>
	<20240426165213.298d8409@kernel.org>
	<ZixGk8dy8INWD6PV@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 17:28:03 -0700 Joe Damato wrote:
> Ah, maybe I read what you wrote incorrectly in your previous message.
> 
> I think you were saying that I should drop just the
> 
>   dev->stats.rx_missed_errors = dropped;
> 
> due to the definition of rx_missed_errors, but that by the definition of
> rx-alloc-fail:
> 
>   alloc_fail = ring->dropped;
> 
> is still valid and can stay.

That's right, yes.

