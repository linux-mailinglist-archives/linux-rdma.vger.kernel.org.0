Return-Path: <linux-rdma+bounces-6018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A69D02AF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 11:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AE4B240FD
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A786A84E0A;
	Sun, 17 Nov 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LebczgXL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D738C;
	Sun, 17 Nov 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837722; cv=none; b=RYa+J8n9A9r6EXnYHdLhj5w2lTOe4rxSXQCWwMyCNleg3AA90rKIz24nR+cZS5rCF1Wh8N6hcXT9M7yXXi4GzmHyoWJDRGTDQTCzaG2dE3OfjmbnKb4O5VfDAyabtPfZNIoQgZfRnED/nzQ1PunZL4uvP/4KGO6bkfKALn44p2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837722; c=relaxed/simple;
	bh=GDy6m6BY4EGyXxc2N9r+tnApMzC68LOdmdCnQ6PdhHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPthTiMGAadOG7MrR4tivHekhfP1J5LsBSZLb54ANRqISgMDfi0btUOWf69/4Ev6sgiElGY3+X78c9mKBq4SXIa9FOEu+qvlkFMgsWwzphpeIwWKykpa7C1W0LitEMGeEth6/0SfFQm56DbtbgqVlbcxnFaM/DHbsGyfOADgbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LebczgXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD5BC4CECD;
	Sun, 17 Nov 2024 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731837721;
	bh=GDy6m6BY4EGyXxc2N9r+tnApMzC68LOdmdCnQ6PdhHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LebczgXLzB7bS4cwxNexnHpB3sIg+Qps8p+Da/insm+RxuMlE5Xj1O/G8cwiODmnj
	 Vn8pyhm31oezXFTWaG/3KvoNseUbHJE6r9qzqZxs3JBAxppDl2UZPtotPGP1xRIKcT
	 gf5CnoK1zOUJUoCBiojv4J0POtQxW5du3OX0etKs6iJpkD83cg7/9a+sUdZ+xYx5lc
	 r5YF/jZoes6tAu7d4TrxNPUn2IRL47ziqlSZ8Uaw2f5YUVlxBvBYgENJMXkaWIK4Dy
	 D/Pz7EsiI63/4NiYpvkwgMnav2CU6CJSsBw2kPkdH/eMbxp44MgUMl+c8rgEtRoao3
	 jJKVji4avjE9Q==
Date: Sun, 17 Nov 2024 12:01:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux390-list@tuxmaker.boeblingen.de.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Run patches also by RDMA ML
Message-ID: <20241117100156.GA28954@unreal>
References: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>

On Fri, Nov 15, 2024 at 06:44:57PM +0100, Gerd Bayer wrote:
> Commits for the SMC protocol usually get carried through the netdev
> mailing list. Some portions use InfiniBand verbs that are discussed on
> the RDMA mailing list. So run patches by that list too to increase the
> likelihood that all interested parties can see them.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d157621b44fb919307e865e2481ab564eb17df..16024268b5fc1feb6c0d01eab3048bd9255d0bf9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20943,6 +20943,7 @@ M:	Jan Karcher <jaka@linux.ibm.com>
>  R:	D. Wythe <alibuda@linux.alibaba.com>
>  R:	Tony Lu <tonylu@linux.alibaba.com>
>  R:	Wen Gu <guwen@linux.alibaba.com>
> +L:	linux-rdma@vger.kernel.org
>  L:	linux-s390@vger.kernel.org

Why don't we have netdev ML here too?

Thanks

>  S:	Supported
>  F:	net/smc/
> 
> ---
> base-commit: 519b790af22e705ee3fae7d598f1afbb3d1cfdd5
> change-id: 20241106-smc_lists-b98e6829b31c
> 
> Best regards,
> -- 
> Gerd Bayer <gbayer@linux.ibm.com>
> 

