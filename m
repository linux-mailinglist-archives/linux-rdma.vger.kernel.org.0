Return-Path: <linux-rdma+bounces-7856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116BAA3C249
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 15:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7303B3EBD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD31EEA5A;
	Wed, 19 Feb 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpEhs4KS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487F1D5CFA
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975728; cv=none; b=JEUc7S+AXqUSZoWsihzTo3ZK+ILYLnTTOoGAZxC0iWYd1PSqBKWNpoR00hF5l8kOUbBRVNBpuvrPS0VvYMRI/Fee60qGsbP6WSsADD04gqbRnm7oISSzewVITAtAzni5BP1vH1vEHiVXWGz85f5rx7kNDWs2U+ZOsyZngYuESiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975728; c=relaxed/simple;
	bh=V6jor6/kTB8SwmLwmKC53Z1NSXucOIOmt++2cLKih0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYEcB01LCdkVostIUBW5ctNVd8E2PrYThjrQKpw23qeQHpNUQD5VcFwsOXQPfN7g8PtnTRrOHbF2MAZOhE3by+eJ/9l16yv1bpiX83DRop7jY3K1Zkrr4qso4IZ54e/YZLfLXAamkxPpFxwCUmxeBQ1ud3+jVKTG2YXgzkRxBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpEhs4KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B807BC4CED6;
	Wed, 19 Feb 2025 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739975727;
	bh=V6jor6/kTB8SwmLwmKC53Z1NSXucOIOmt++2cLKih0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpEhs4KSkWLnaGDIgTuCe+FKokDyvtK1IsAwlQBtzm/iSCbPMUvb5ZEDgO31/0LMx
	 VL9odqS4UBNXgvfkHji2rZ2qb7GEDGR6e+XBaqzaXxYmsHpmlbAIWB6m+dNdxJUc/5
	 HKzIZP1tEHLvIktWz+q5P4st6LKqZ0cej8KLiOeH9FdSD/7Alsjm4WcUBUzur8CzGy
	 XK7qfKXyTxZ+w5skHrMqpSU0e1h07OMTO8vNeW4UZPrT1fHpPLP6eZWK5jJyqBG2wz
	 Hd1G/Chrn9zVYiK6/CDGDZMNS2aulVTLK29YfcNxkV/lRWmTgWPcjLLNo0bdfCzZe7
	 7ilJd/Ldv+PNg==
Date: Wed, 19 Feb 2025 16:35:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250219143523.GH53094@unreal>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>

On Wed, Feb 19, 2025 at 09:07:36PM +0800, Junxian Huang wrote:
> 
> 
> On 2025/2/19 20:14, Leon Romanovsky wrote:
> > On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
> >> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
> >> to notify HW about the destruction. In this case, driver will still
> >> free the resources, while HW may still access them, thus leading to
> >> a UAF.
> > 
> >> This series introduces delay-destruction mechanism to fix such HW UAF,
> >> including thw HW CTX and doorbells.
> > 
> > And why can't you fix FW instead?
> > 
> 
> The key is the failure of mailbox, and there are some cases that would
> lead to it, which we don't really consider as FW bugs.
> 
> For example, when some random fatal error like RAS error occurs in FW,
> our FW will be reset. Driver's mailbox will fail during the FW reset.

I don't understand this scenario. You said at the beginning that HW can
access host memory and this triggers UAF. However now, you are presenting 
case where driver tries to access mailbox.

> 
> Another case is the mailbox timeout when FW is under heavy load, as it is
> shared by multi-functions.

It is not different from any other mailbox errors. FW needs to handle
these cases.

Thanks

> 
> Thanks,
> Junxian
> 
> > Thanks

