Return-Path: <linux-rdma+bounces-2694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76268D4DEC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480DB1F23336
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D6617D894;
	Thu, 30 May 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQPm0zkX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4E17C211
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079162; cv=none; b=tm8CDzM2Pa9KtvqBl612pBcM0BS1KdKzHSzMTDxgdYY5t8kJTsGaenTBpQt+mVGnR+/6pVDXLfIS+Ve8jDkMn4XeEj2cnLbvnFHM2W3tMtyvi/kaNP9hlEgi9LjFrdHnRgArDiqR5/1HSeUkRuQ32arpwBjMStNb1YEIhe55pFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079162; c=relaxed/simple;
	bh=h97DZILZj/ATOtMuePhXGd2GT8xsDoWpqvNq/802eHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o2dGO4cbpLYbI2iK9fCtPQYnZ3Kqbr1OVjVtfVjBCtyQlRAiD6lGQHQQJtVjQ8g+qkY8HFHmuEudz8PSCWAPvwBOPOEJIeOHkWGFgCi5rAPu/IN5Zykp8JL8nnmVdDCAkyj3P3fjo9+rR97MkwY8rkBvsvGWZzpOwQGZxCteI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQPm0zkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6557C2BBFC;
	Thu, 30 May 2024 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079162;
	bh=h97DZILZj/ATOtMuePhXGd2GT8xsDoWpqvNq/802eHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kQPm0zkX+YTKN+Ul+pr7q++AAdFF7MsgXoJVAsyUN9iBKnQbjq9A1GKkk4cJKqZqL
	 bGzyd95uw8/8AcFyxSxnlbNcFSxh9mH88mGS+bFW/Ud2sEpxsMDGC1Q+keJ7wgcf6M
	 kmXcv3XeoX3eWlCQLAo6r3qucGKpNywW+3KqQY4niTEqzGVC4CkD/ManGe06AxaswX
	 z38WKZAz2NIOdlvgowyUSL7FUuYrQdW+du3YHLFSwgYZcCTc90ccHWZCS0+cj29kIY
	 ueSVa0aDMkH7MjaT7ysJpsqlG7MMDw2bww8zwl3UVQh1jE42jmo10Asx95fQnUP0Qq
	 HjOg0sKw07X8Q==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Daniel Kranzdorf <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
In-Reply-To: <20240513081019.26998-1-mrgolin@amazon.com>
References: <20240513081019.26998-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Fail probe on missing BARs
Message-Id: <171707106301.114410.11492729341060932573.b4-ty@kernel.org>
Date: Thu, 30 May 2024 15:11:03 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 13 May 2024 08:10:19 +0000, Michael Margolin wrote:
> In case any of PCI BARs is missing during device probe we would like to
> fail as early as possible. Fail if any of the required BARs isn't listed
> as a memory BAR.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Fail probe on missing BARs
      https://git.kernel.org/rdma/rdma/c/435cdbe9f7a879

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


