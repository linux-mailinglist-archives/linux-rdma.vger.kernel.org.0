Return-Path: <linux-rdma+bounces-1746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B1895BA9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9951C22725
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9B15AD9C;
	Tue,  2 Apr 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc8YQdjc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2515AD8A;
	Tue,  2 Apr 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082166; cv=none; b=kqxVpoO3X/7fVCb36DzlDwMWpn1GJUFCa9eHvj+umsXwutAL44FlVfoh95IE4w5A3JmlF1AmqB+FbHbOJWX4s/kHpi2Z9sVNOfjbpM++fcJf3mR+a+pONh66y17KFxQnUpKwUkgz3AH7YCe4FJKyT6e+DzrZMHomPslqBx6XcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082166; c=relaxed/simple;
	bh=lUx1LzBorggEWYaFrZabaixibaToyBEtNNE2dEjp+BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMcYKoyGpaoSKOE7xPrMAQYsQUhE0qirKKNOdy7dJoLFAQ1eJLy3evGtGSypYkB5wHDhuZKmxH49I/F/ikHkp6asjd6PrYsIsUjDjHg3ysLTZLrgh5GYQAuXz0tR1vsWhSeJaaM+XF39Yxp9V+4KYynebBuIz5zdB3zI+3edIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc8YQdjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D3EC433C7;
	Tue,  2 Apr 2024 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082165;
	bh=lUx1LzBorggEWYaFrZabaixibaToyBEtNNE2dEjp+BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uc8YQdjcAcToGxDoK9apBGCvjg5GdtorpDvzgghqegfQCOP2bvsgtvu0jLsQPgpcQ
	 PtwjumaLsZBp2TxjolO3kVi1BaQgAe2aVeROch3yk+ziM3E4VnqEmOxIF0Z66QBa7+
	 XJYP5DQ7jU6awjW1iurDdqEUpAp2Pds+ouduTv5hE1N24Sv2wg8hi7rwZ3debsdt8s
	 GvY7Y2wyCeNiRR8WiFjCYzoQDeGyYu79kagUeUfjiaiX23aCPftKR+FRFu1TIsGTCx
	 jqIElXTYPk6jBxuZoUCrMIe7Fi+t0u4Gb1DqLWY+n0IwIDxy5BZlyhhz6E1L/f7QEc
	 oQOMGuGG1IMxw==
Date: Tue, 2 Apr 2024 21:22:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, jgg@ziepe.ca,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 5 net] RDMA/core: fix UAF with ib_device_get_netdev()
Message-ID: <20240402182241.GN11187@unreal>
References: <20240402132641.1412-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402132641.1412-1-dkirjanov@suse.de>

On Tue, Apr 02, 2024 at 09:26:41AM -0400, Denis Kirjanov wrote:
> A call to ib_device_get_netdev may lead to a race condition
> while accessing a netdevice instance since we don't hold
> the rtnl lock while checking
> the registration state:
> 	if (res && res->reg_state != NETREG_REGISTERED) {
> 
> v2: unlock rtnl on error path
> v3: update remaining callers of ib_device_get_netdev
> v4: don't call a cb with rtnl lock in ib_enum_roce_netdev
> v5: put rtnl lock/unlock inside ib_device_get_netdev
> 
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/device.c | 3 +++
>  1 file changed, 3 insertions(+)

1. You are changing RDMA code and not net code, please add linux-rdma
   mailing list to the CC list.
2. Please put changelog after --- trailer.
3. Please add to the commit message stack trace.
4. "May lead to a race condition ..." makes me wonder how it is
possible, because RoCE/iWARP devices can't leave without netdev. So
please explain how it is possible in the commit message.

Thanks

