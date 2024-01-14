Return-Path: <linux-rdma+bounces-627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1582D00C
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jan 2024 09:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C63C1F21ABC
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jan 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A6187A;
	Sun, 14 Jan 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7LJba52"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649A1C10;
	Sun, 14 Jan 2024 08:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F75C433F1;
	Sun, 14 Jan 2024 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705222624;
	bh=IQq5LbRYSKg2z7BCFiFP8dBEZGJ2DR2mjUblMlQToUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7LJba520T3tuPU61LFPCZjpBK6xLkjY1tNS2vQBT2y1dzGYlQaw5mInmtLSnNkVF
	 TrKxza6st4n/QLGzEVz7u+2gzaq5vfWEsLfIoq8JP2Y94T5yUTi3Oc1SrJhTvQuC/i
	 ynehVCb6gsp6lYITgWFV2siFn+RbBcdsKslqwXL86dea+dn9W2Xs+mcWLmO5Kl9U3z
	 FsihdwRR6ODz9h3bzyyR55Tv9dhJqc5o2W6TtkpWgP+R0AnCbE10hd7HSoZFOgJY7n
	 jz1b9gHT/A4KY+YLF/QITkMPLRcXSEeceWbPwyEuH2NGL4629R9GYNxYKzpSvZ+rE4
	 hCM3O/PYzpeog==
Date: Sun, 14 Jan 2024 10:56:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: longli@microsoft.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update maintainer for Microsoft MANA RDMA
 driver
Message-ID: <20240114085659.GC6404@unreal>
References: <1705017438-20417-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705017438-20417-1-git-send-email-longli@linuxonhyperv.com>

On Thu, Jan 11, 2024 at 03:57:18PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Ajay is no longer working on the MANA RDMA driver.
> 
> Konstantin Taranov will take the responsibility of fixing bugs, reviewing
> patches and developing new features for MANA RDMA driver.

Let's do it gradually.
1. Make sure that Konstantin configures his email to reply in plain-text.
2. Stop top-posting replies.
3. Make sure that his cleanup MANA RDMA patch is properly written
and separated to series.
4. Send RDMA patches with rdma-next/rdma-rc prefix in them.

Thanks


> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 463c097e01af..135471cbc144 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14527,7 +14527,7 @@ F:	include/uapi/linux/cciss*.h
>  
>  MICROSOFT MANA RDMA DRIVER
>  M:	Long Li <longli@microsoft.com>
> -M:	Ajay Sharma <sharmaajay@microsoft.com>
> +M:	Konstantin Taranov <kotaranov@microsoft.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/hw/mana/
> -- 
> 2.17.1
> 
> 

