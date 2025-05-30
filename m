Return-Path: <linux-rdma+bounces-10909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DEAAC85C0
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 02:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2911BA29DE
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 00:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D416933985;
	Fri, 30 May 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/1oTXcJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C2FBF0;
	Fri, 30 May 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748566159; cv=none; b=RWJLU7bB0Xg1k/NIYUd8VFmR78WxhYT7wXajzhhuwCI5vz1oqjNcfkPIX2ZgwHf6OiuRPyTJGvHFpA8G2/ecdhcCcZGXV56FRkgxnuPMmqHsTuybAc7N5c4UBEouNTcrKxI0MQsdK5B0WpQmUoUDpcXIZx0ah1IwrdmuuImfPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748566159; c=relaxed/simple;
	bh=8Bl71w9e4E6Qo6rtxryDax3y08LU+Nx9kHzGp2J0tEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqCnpl9L8ZHC9rcJxwxzaSjeA7taBRLa9I3cXlzijBoN02ua+to4kDSykMajx9wRpy9epw+y5xb1xz81ahZ2Fvq/7tvRxfUV2+8HeAQqD5mJxpyh5x2u0yrqXZkNcngzOln9TzHuBy48kWL4rIR1npMn+huByg+br6GUyrrQsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/1oTXcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D524C4CEE7;
	Fri, 30 May 2025 00:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748566156;
	bh=8Bl71w9e4E6Qo6rtxryDax3y08LU+Nx9kHzGp2J0tEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/1oTXcJfmrJCGtkYZhcTh5rIRqFiCd1irrdkiqp+Y9mefG/2ac0qSvw0Siko8rua
	 nkWTbjqN2s0i9vCAzlyfo9hgqUVVST/i0soLWxMWm4yQjizSGOXk60eYH6ZwA9gJo6
	 msmtC3+9MnNrYGQlmDNGHFCkGVQQGq8RIj0S5Yda/uLOFsYE213XkUgtCGmPje2a/i
	 nJd9uNugpY/u0gfYejO2l96XH7tkBD1HPcsSg/Db/NMqAqynIl3Osi86IwwxKaHs/C
	 O4wBg4PoQsi8v2s94WAEuZbI5Pi3nUZx9xV0csl4K6W3CCPBHPZxn0r9/DU8BDQdqh
	 /pMKhYRPE4aHg==
Date: Thu, 29 May 2025 17:49:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v4 1/3] dpll: add reference-sync netlink
 attribute
Message-ID: <20250529174914.179c1a34@kernel.org>
In-Reply-To: <20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
	<20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 19:26:48 +0200 Arkadiusz Kubalewski wrote:
> +The device may support the Reference SYNC feature, which allows the combination
> +of two inputs into a Reference SYNC pair. In this configuration, clock signals
> +from both inputs are used to synchronize the dpll device. The higher frequency
> +signal is utilized for the loop bandwidth of the DPLL, while the lower frequency
> +signal is used to syntonize the output signal of the DPLL device. This feature
> +enables the provision of a high-quality loop bandwidth signal from an external
> +source.

I'm uninitiated into the deeper arts of time sync, but to me this
sounds like a reference clock. Are you trying not to call it clock
because in time clock means a ticker, and this is an oscillator?

> +A capable input provides a list of inputs that can be paired to create a
> +Reference SYNC pair. To control this feature, the user must request a desired
> +state for a target pin: use ``DPLL_PIN_STATE_CONNECTED`` to enable or
> +``DPLL_PIN_STATE_DISCONNECTED`` to disable the feature. Only two pins can be
> +bound to form a Reference SYNC pair at any given time.

Mostly I got confused by the doc saying "Reference SYNC pair".
I was expecting that you'll have to provide 2 ref sync signals.
But IIUC the first signal is still the existing signal we lock
into, so the pair is of a reference sync + an input pin?
Not a pair of two reference syncs.

IOW my reading of the doc made me expect 2 pins to always be passed in
as ref sync, but the example from the cover letter shows only adding
one.

