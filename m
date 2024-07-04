Return-Path: <linux-rdma+bounces-3635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F76A926D24
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3726B1C21857
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B89457;
	Thu,  4 Jul 2024 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk8nuN+d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635532581;
	Thu,  4 Jul 2024 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057305; cv=none; b=QJ26qxNCGxlltobXoa64Eq3h6dekH/ewSm9FWOoTaJIznsqztkoLQZzbB8XCi1tAnCPnPoL2QQPgAnSljNpevwayFRk7qkuJW4zuc6NRinpl43FHLMyTksxMUijLaLGo8/kUmXUrVKrBpAMqvIgP92Bt31yHehcw0MDsx1eZ2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057305; c=relaxed/simple;
	bh=x7Hf/tllTlDBBa3y/YrnYgYV/HhyT5DXOrpAPUTqH08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2LmO+++5TWV2BmlRn1QsVZxMORFNOHZrCttYWiEwOxuz12oh5L2FTHbWh1FA+AflpFKF4lzacNPlIbjeNeHA7lRYWYWiUzi63a9mu6HPdJB/dv+vLKHTB/ca0+LsGoCUBLkZYy7UhxUvYdN67xCDZe7LI9DMgCAgD0BWvG+rzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk8nuN+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517A8C2BD10;
	Thu,  4 Jul 2024 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720057304;
	bh=x7Hf/tllTlDBBa3y/YrnYgYV/HhyT5DXOrpAPUTqH08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vk8nuN+dWNVKc5e7F2nsakHaZz+GOxj1SyRqTRGR8h3iNHBhAUrqvd0QDw9UN2uAo
	 sHphAAsMLDOereCBasn9Et4bWIYPUAZLe0CINZrQfHxD/5r5d/qiu6UEFI8F57Z7Fh
	 0U63yzc+BQMyHFTsQ5CPK/yU3rbfSODn+IbIkxlfJJ4a9q14fG+EQC/SODtMcqcmsa
	 tmHdQj4c1xXhjUwn/WR+KVNMxW3gGFQ+5NqO4g+3hboVcAz8lET/NQPsCHbhSjth8l
	 w1FWEbCVhAPJCDkuj03HlIDwfeix5E994k34NFoDj+XAazwCO7Uln4KfwG5f+foukF
	 kkSW59MZJXURw==
Date: Wed, 3 Jul 2024 18:41:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
 kys@microsoft.com, edumazet@google.com, davem@davemloft.net,
 decui@microsoft.com, wei.liu@kernel.org, sharmaajay@microsoft.com,
 longli@microsoft.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Provide master netdev to mana_ib
Message-ID: <20240703184143.3340207d@kernel.org>
In-Reply-To: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 05:58:54 -0700 Konstantin Taranov wrote:
> This patch series aims to allow mana_ib to get master netdev
> from mana. In the netvsc deployment, the VF netdev is enslaved
> by netvsc and the upper device should be considered for the network
> state. In the baremetal case, the VF netdev is a master device.
> 
> I would appreciate if I could get Acks on it from:
> * netvsc maintainers (e.g., Haiyang)
> * net maintainers (e.g., Jakub, David, Eric, Paolo)

Would you like us to take this via net-next?
 - it doesn't apply cleanly
 - the patches should be squashed, they aren't separate logical changes
 - please find a better word than master

