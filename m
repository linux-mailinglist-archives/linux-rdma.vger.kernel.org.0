Return-Path: <linux-rdma+bounces-9223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C95A7F5A4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 09:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534023B6AC4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73AE25FA17;
	Tue,  8 Apr 2025 07:06:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41766217F5D;
	Tue,  8 Apr 2025 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095985; cv=none; b=J6Dq7CcKu1VIfnkBsHko5YuuMc+wBw5GJpNbm6p8fC2rCR7D2QaeoJutJ5cPnF6mSf+JPUK3Mit8s5I4PzkmE0dOUBZw1IxoxEvYx5yC9ZqZK64oMhp+jAT5ZRRYXHptGMSj58tYh3CZztyFBeLlEQBPfVJjDnBTkJHYqS7bYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095985; c=relaxed/simple;
	bh=i+SH6NrltKs2n1E0agdH8rfYxvPrzIIvE/KB787JoXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn8x6eU89P8Gcshecfkl+ErVv6Mdxxqeg6eg5kLPZMLRHx4Vokn0F9HDAkHl4R/Waxp2nRNe/XD6MgmKKxPFv8r7yEqLNTXmv/V81vrKMCt3ky4N8H47VK5HBoiS6pQjXRscSWNq1s10Rh5WO8lC4rX3zhIv/FCb2wdAbD05oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201604.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504081506064651;
        Tue, 08 Apr 2025 15:06:06 +0800
Received: from localhost (10.94.17.24) by jtjnmail201604.home.langchao.com
 (10.100.2.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 15:06:06 +0800
Date: Tue, 8 Apr 2025 15:06:06 +0800
From: Charles Han <hanchunchao@inspur.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
CC: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <lariel@nvidia.com>,
	<paulb@nvidia.com>, <maord@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] net/mlx5e: fix potential null dereference in
 mlx5e_tc_nic_create_miss_table
Message-ID: <Z_TK3uIIlJ5y3fWy@locahost.localdomain>
References: <9ae1228039dcba4ff24853ac72410ad67-4-25gmail.com@g.corp-email.com>
 <2bfd9684-7ef0-40b0-b35d-abb0a3453935@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2bfd9684-7ef0-40b0-b35d-abb0a3453935@gmail.com>
tUid: 20254081506071e55cc4f74c8ee590d7e9c7350ba31e6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

On Mon, Apr 07, 2025 at 12:29:22PM +0300, Tariq Toukan wrote:
> 
> 
> On 07/04/2025 10:20, Charles Han wrote:
> > mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> > without NULL check may lead to NULL dereference.
> > Add a NULL check for ns.
> > 
> > Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
> > Signed-off-by: Charles Han <hanchunchao@inspur.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > index 9ba99609999f..c2f23ac95c3d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
> >   	ft_attr.level = MLX5E_TC_MISS_LEVEL;
> >   	ft_attr.prio = 0;
> >   	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> > +	if (!ns) {
> > +		netdev_err(priv->mdev, "Failed to get flow namespace\n");
> > +		return -EOPNOTSUPP;
> > +	}
> >   	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
> >   	if (IS_ERR(*ft)) {
> 
> Same question here, did it fail for you, or just saw it while reading the
> code?
I just saw it while reading the code.
I've been working on code vulnerability scanning recently.

