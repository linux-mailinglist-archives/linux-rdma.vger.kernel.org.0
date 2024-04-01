Return-Path: <linux-rdma+bounces-1709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA333893C5F
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223011C212A6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D24437F;
	Mon,  1 Apr 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGj9zHif"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120A43ADB;
	Mon,  1 Apr 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983188; cv=none; b=mHC+QNKe6xNeUeTczLVEtQdV7AQWC3dwzuhebuOwM6puCrxFYilpERbcNQtNOs3iMFuG6mk1OkvXK/o+w5db3ESoXHhKVYg3eeSUJFj59HIratwGkxtTPkd5Iq0ZFjbaBz+rBcUlWZqBpRlN2sFkQwp/opa0qfEn4R2UqM/SNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983188; c=relaxed/simple;
	bh=iyaoH6bcOO25NNyfcq9h4+csxLjCIbPx6O3NrMvYE/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYBhfWFPar62wrOtVUR+eIHMJE4JAQTG/KjxgGY0mZQxhQnX4auVVPNR9PT2uSjE2yfbEsjOEVXkAUTjPTwTdjDeIclG8beNQsuvTkg3Z65+O824zN4npzQEsBt8NnYYU7KC7Epfinmo78RBXsSinD9tY9EyV/eN4+pg98vwfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGj9zHif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D092CC433C7;
	Mon,  1 Apr 2024 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711983188;
	bh=iyaoH6bcOO25NNyfcq9h4+csxLjCIbPx6O3NrMvYE/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGj9zHifgURy0amXELr6RKj4/a409NOYZq+9oNUHnmDVtufl0lamiJLcrKgtH6PI3
	 389MqmebbDzTVK34fSf3lNkX0w42/gRITTi56rIFqyOsM0g+m8b+Ix11pZrd3/ky7C
	 7dFhwAI34BXRbUDr6xKBYqwIfC7OvDdQloyHcpayNRJTwZihY8epKiQEXQVbW7bVlP
	 o1a5L/DiM3zRpvT9rr3rIUKLkgLtgsfmnd7B9mbYKcpZifL0l36A6BOIYzdA9S7dbF
	 yd+P8SdMi0SkipvzD5j5yVBNU4eSKLZnKDOXvG8+t+dCUoH7w8AiuFYbNDlN+RPpBB
	 2Fh0p/+XMyEhw==
Date: Mon, 1 Apr 2024 07:53:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Dennis Dalessandro
 <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 keescook@chromium.org, "open list:HFI1 DRIVER"
 <linux-rdma@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240401075306.0ce18627@kernel.org>
In-Reply-To: <20240401115331.GB73174@unreal>
References: <20240319090944.2021309-1-leitao@debian.org>
	<20240401115331.GB73174@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 14:53:31 +0300 Leon Romanovsky wrote:
> On Tue, Mar 19, 2024 at 02:09:43AM -0700, Breno Leitao wrote:
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> > 
> > Un-embed the net_device from struct hfi1_netdev_rx by converting it
> > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > net_device object at hfi1_alloc_rx().
> > 
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>  
> 
> Jakub,
> 
> I create shared branch for you, please pull it from:
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=remove-dummy-netdev

Did you merge it in already?
Turned out that the use of init_dummy_netdev as a setup function
is broken, I'm not sure how Dennis tested this :(
We should have pinged you, sorry.

