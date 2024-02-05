Return-Path: <linux-rdma+bounces-913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC7849BAF
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 14:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A851C2225D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B81C286;
	Mon,  5 Feb 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyBR9MSN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFA1BC2C;
	Mon,  5 Feb 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139565; cv=none; b=SJkHnDTKaP3NlLEJZLwK+PUcMQTFsNEvrhqpMluJY957Xjv00aVSMQdxCMhlYvzOdnANakbMyIFgiNkG7Vsl+sExvtOfgOnnx33/fSk8g1sl8VJ6QkANjxGUsxpXFM2ZbU9USulvKWbDuXqUOTTniLq+7BfFZmC3FxmAiITyZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139565; c=relaxed/simple;
	bh=q7nSmRJBI2/Cgs4/oUfpOyDiIZNOR8iZOT4OzRazNA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ+gh0ZMDac5FRUUX2JuaUmfB4yXjIv1tDUPBQPQRNUqRU2Wm7IbVxhkY+SeRWhpauA/1Epj4PcAszFA2jOka/RNRxUTh7DdwsjiF8y4xi1RB6JjsNYy5maUklOs7mn0xaZdU/D6SJ8MbGnlvwmalNYhbAtDDpoNcAT/j/1fsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyBR9MSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E911BC433C7;
	Mon,  5 Feb 2024 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707139565;
	bh=q7nSmRJBI2/Cgs4/oUfpOyDiIZNOR8iZOT4OzRazNA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyBR9MSNfeZVO5FaXWHuqEZsTw/uIniXwi0dlwiIlOBTG7cqi9gQ14zr6P+ku7f53
	 GdpB9CvayJiWiRBHqVS0wa/9V0NWwLJnWHx42Tjw5HfaQ1cKc3nj1Gk5c3j4CK2CXI
	 y6AbHYa6ByipwbcPOwRhTkM4GwoUQezbhIOsVDGEhiUkGAtjhqFbBkzVVJpUXwWxAd
	 Q3r57RolLiLnutnqC9l2GcgosquH/IW8lY2BC/QqRS6wed1eNBJ7lEfTvgMoMW+jKF
	 3d7hU1w36bTI1nMlKaEsNs+yCMdUKIYq21s56l2PkoqKhw6YWOEeoUiXAuSAFRJj0f
	 aZQwKleD70Beg==
Date: Mon, 5 Feb 2024 13:26:00 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Message-ID: <20240205132600.GJ960600@kernel.org>
References: <20231209225135.4055334-1-colin.i.king@gmail.com>
 <20231212203043.GF5817@kernel.org>
 <20231212131913.4195bc38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212131913.4195bc38@kernel.org>

On Tue, Dec 12, 2023 at 01:19:13PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Dec 2023 20:30:43 +0000 Simon Horman wrote:
> > On Sat, Dec 09, 2023 at 10:51:35PM +0000, Colin Ian King wrote:
> > > There is a spelling mistake in a mlx4_err error message. Fix it.
> > > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>  
> > 
> > Hi Colin,
> > 
> > I am guessing that you are focusing on error messages and other user-facing
> > spelling errors (perhaps you told me f2f in the hallway track at Kernel
> > Recipes).  But I do wonder if you have plans to address other spelling
> > errors in this driver. codespell flags many, including 'segements' in a
> > comment in the same file.
> 
> It'd be great to fix all the codespell issues with one path, IMO.

For the record, I have sent a follow up here:

 - [PATCH net-nex] mlx4: Address spelling errors
   https://lore.kernel.org/netdev/20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org/

