Return-Path: <linux-rdma+bounces-6500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC229F01A7
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F34A284A99
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59117BA1;
	Fri, 13 Dec 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBiqZCWH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD753BE;
	Fri, 13 Dec 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052296; cv=none; b=TefjFHuu2RZ0gDsQmZPxaMQWfyh99+GwsN4P9P8O5iVrWODUOGv+tCGz1hV4AqH7aC2banQaU01FCJwmOw5MoVmII6eBq+XyCwfL8qvtOjrslJrF8JkHE086N1ZKdD+BIA8cN0Be5uSyIFIUP8OOlof1c0SPVzuGdBtq3F+4fys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052296; c=relaxed/simple;
	bh=mBQgaAZqDPlNmiCqczWwxTN4WHwpUuQ8rF5+Uhg/xcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAU27IJV62LTXNz+v06XaP5kDFJBIT1D/a3gzT0/etXpvNWZg7eEphYUGE5I4OzexuQVmN+Nm1i2SRLy9l3PQG8swkYohnTKffQqol4DAdhEh0wsDACecEtXaHi7ACr2gdPS78vIqkFtyiUM16Th4w8ljBCOHvvHBAQv0yhXl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBiqZCWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA59C4CECE;
	Fri, 13 Dec 2024 01:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734052296;
	bh=mBQgaAZqDPlNmiCqczWwxTN4WHwpUuQ8rF5+Uhg/xcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sBiqZCWHG/zjPPBB/wF0B/dEgyZk9FKD/VXsr7IIrhjrHAHGY6HVvogHj+WSs5/pc
	 Dnft5+/FPRydaHWtGmacerbTT4J9WF2FYnZjW7IfRctKgWunVjQu6IbggsGuOaR3mp
	 xsDyMCt5Uc1IwjKT1zZMf/9zz+wfg6GtZhk2SBbMfGTjUU6g25SvZvj2+E4o5gDm1+
	 H32zt87L5Zt4XTl088LJsfd6xJHwzOUGR4iGlV4w43dWWT/wq2eOp11hv6iqXYnS2A
	 OtwWFOLkpttu1opriOjtvTxgOzrd5JS/6jICLyUEFZ3q/jKfIEohC1yWOIbZjP5hUM
	 ksG2/PMtrmqxQ==
Date: Thu, 12 Dec 2024 17:11:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>, Yevgeny
 Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
Message-ID: <20241212171134.52017f1e@kernel.org>
In-Reply-To: <5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
	<20241211134223.389616-11-tariqt@nvidia.com>
	<20241212173113.GF73795@kernel.org>
	<5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 20:31:30 +0200 Tariq Toukan wrote:
> It requires pulling 4 IFC patches that were applied to
> mlx5-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

What do you expect we'll do with this series?

If you expect it to be set to Awaiting Upstream - could you make sure
that the cover letter has "mlx5-next" in the subject? That will makes 
it easier to automate in patchwork.

If you expect the series to be applied / merged - LMK, I can try 
to explain why that's impossible..

