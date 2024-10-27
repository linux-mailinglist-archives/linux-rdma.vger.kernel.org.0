Return-Path: <linux-rdma+bounces-5562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933B9B205E
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 21:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD81F21E61
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AC1779AE;
	Sun, 27 Oct 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmCZo5iF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43578538A;
	Sun, 27 Oct 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061061; cv=none; b=j0tko1hJPeYlmYhAhGSrwBC1KGr6A+KzDDf8DYZpbUMjMd5jCFHvu0kLLMfq6GKE4eM3zKfTfZj4KkCRKkmiw5bUsjwgWnWWMtYC7b4m23SmqyHWBWQiFXV1DdeFGBGaj+Ubu5C5cciFzPjKUt1nNHNOlWyW5hPS9moC3Zg7jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061061; c=relaxed/simple;
	bh=g0qOuu9oBMe1flwJbOj0ETqlrVdC6doUvyj6Y4MWIJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxR9T6Cf8NhMXSKTuByRYZOOTsn1KL8RtmT80REs88fBd8vAVByGtg5OlBD0jGimrgCdpw0aOmOt8FCDi44Bh4hweS1D1kW2FdJUzNW0Vjaa6StGv4MsRhNnaASnZZQE4ZVBa00f7e5jNxR2ooSBlVW/hvL4koAdtX36eSmAWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmCZo5iF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA11C4CEC3;
	Sun, 27 Oct 2024 20:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061059;
	bh=g0qOuu9oBMe1flwJbOj0ETqlrVdC6doUvyj6Y4MWIJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmCZo5iFGA1y+uL3wW/0bcrnhx1UBxEVoEJpLLcF6HTtG2VUBSjSbG3NzcEqzMKA0
	 k8chJH5+oGGqHo+I7nZNxn1dud9nhRvQqo+jqsU/Zh4FxAWWbJfLc1wyTiuyaTNcVb
	 PD+tXn3iIzdRyQJ/QmHMGIsShKIMA6k9wJatpXHVeBJmFjTpyk0VITjmsfp7GKuuED
	 l9HaDBCa8SjI0qty5uX7/ykAVZA4JQDcUrWnO3E3jNE9/5FnP6R+kF7OTGkkaqkpwC
	 i5j0wkoefJKYLi8ZrexHXbW5uGiKfILdA8ttSdF65bzOLVVc76CYIfx/gJiiP4kzWA
	 8Y7WOBQDlzHNw==
Date: Sun, 27 Oct 2024 22:30:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241027203054.GB1615717@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027201857.GA1615717@unreal>

On Sun, Oct 27, 2024 at 10:18:57PM +0200, Leon Romanovsky wrote:
> On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:
> > Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> > alternative to get_netdev") introduced an API ib_device_get_netdev.
> > The SMC-R variant of the SMC protocol continued to use the old API
> > ib_device_ops.get_netdev() to lookup netdev. 
> 
> I would say that calls to ibdev ops from ULPs was never been right
> thing to do. The ib_device_set_netdev() was introduced for the drivers.
> 
> So the whole commit message is not accurate and better to be rewritten.
> 
> > As this commit 8d159eb2117b
> > ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> > get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> > ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> > device driver.
> 
> It is not a correct statement too. All modern drivers (for last 5 years)
> don't have that .get_netdev() ops, so it is not mlx5 specific, but another
> justification to say that SMC-R was doing it wrong.
> 
> > Thus, using ib_device_set_netdev() now became mandatory.
> 
> ib_device_set_netdev() is mandatory for the drivers, it is nothing to do
> with ULPs.
> 
> > 
> > Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> It is too late for me to do proper review for today, but I would say
> that it is worth to pay attention to multiple dev_put() calls in the
> functions around the ib_device_get_netdev().
> 
> > 
> > Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")

Honestly, this patch in Fixes line doesn't look right to me. It pokes inside
of ib_device to get netdev index. For example call to smc_ib_ndev_change()
will return completely unpredictable results, due to races.

It is bad that RDMA ML wasn't even CCed back then, we would say NAK to
this patch.
https://lore.kernel.org/netdev/20201201192049.53517-6-kgraul@linux.ibm.com/

Thanks

