Return-Path: <linux-rdma+bounces-1085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE685D59F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D89A2819C4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9B5231;
	Wed, 21 Feb 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzL5mMQG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA903D7A;
	Wed, 21 Feb 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511651; cv=none; b=V5MzZ2vfIqm2ybeoD7cS+ziOYhqVLmBwHoaLdI5yNs3PjTkMtGreF5Sk5MOHB6pjlsMXkqWBVkbj3DkQDgwu5WEpECHvZCxNMTO+MZrW1ma3MqCbF/kFFEQJ543PwUSX18PducUy9cxY4bzGcDprLmOBx/a6GlT6NDl6VE0FApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511651; c=relaxed/simple;
	bh=GSkRDVfIjVHsNcttujsc8mwyn+uCTaExgB7via05rEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1EnAEXO98je051i4HkP/gBfSM6bjXph0X8lnU7gPJ5I+XF93zVcTaDb3AfS6srm+V1Jksm7k117xqd7d3Iu7i0hZjBJF97oV9wQ/Zjw5LirySZXFobpp3z4B9wtD7zEs73iElOWvpzkK0Fw/+lMk/x++l9CE7WRYKLB9xmvTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzL5mMQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F246C433C7;
	Wed, 21 Feb 2024 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708511649;
	bh=GSkRDVfIjVHsNcttujsc8mwyn+uCTaExgB7via05rEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzL5mMQGlp3PbrQ1Ylw+OfIq2MwK/jgW/Ue4fLsAvRD0qZiFZfzcuPHdPINZOm2IY
	 yJDr3Zi4Mn1N2ymLbIACJl28nC7w5Irs33HlUkxp/3j7R5yOhdBQFSyT9AdaebQHww
	 RzrsPHLzNDg32aE8jHTB/aDQviPD9kfqtwcx44aXwhoZ9HsdJmplamD6GYfTHaHI4f
	 q6v9XtJY0t/NUNCOFAA8Buwdn/RzN7L9HRmyjv3F02SJJDBDjGRDDmVN+Ky4rJez6W
	 5MvwyrAyTYD61XejjCg9+HGVSXXo7575dscdSnD4LmLvPlSRNJ1XML9XCujb/0YbJp
	 NtYp6wXM+Z6Kg==
Date: Wed, 21 Feb 2024 10:34:04 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>,
	Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] net/mlx5: fix possible stack overflows
Message-ID: <20240221103404.GB352018@kernel.org>
References: <20240219100506.648089-1-arnd@kernel.org>
 <20240219100506.648089-2-arnd@kernel.org>
 <20240220080624.GQ40273@kernel.org>
 <726459a9-c549-4fec-9a4d-61ae1da04f0a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726459a9-c549-4fec-9a4d-61ae1da04f0a@app.fastmail.com>

On Tue, Feb 20, 2024 at 09:11:51AM +0100, Arnd Bergmann wrote:
> On Tue, Feb 20, 2024, at 09:06, Simon Horman wrote:
> > On Mon, Feb 19, 2024 at 11:04:56AM +0100, Arnd Bergmann wrote:
> 
> > Hi Arnd,
> >
> > With patch 1/2 in place this code goes on as:
> >
> > 	switch (action->action_type) {
> > 	case DR_ACTION_TYP_DROP:
> > 		memset(buff, 0, sizeof(buff));
> >
> > buff is now a char * rather than an array of char.
> > siceof(buff) doesn't seem right here anymore.
> >
> > Flagged by Coccinelle.
> 
> Rihgt, that would be bad. It sounds like we won't use patch 1/2
> after all though, so I think it's going to be fine after all.
> If the mlx5 maintainers still want both patches, I'll rework
> it to use the fixed size.

Ack. I agree that this patch is fine if 1/2 is dropped.

If that is the case feel free to add.

Reviewed-by: Simon Horman <horms@kernel.org>


