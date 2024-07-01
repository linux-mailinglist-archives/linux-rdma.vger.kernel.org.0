Return-Path: <linux-rdma+bounces-3581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50A91DE1C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B393EB25043
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D9C145334;
	Mon,  1 Jul 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIdI/28J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D210143C4E
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833544; cv=none; b=gcyOxNbzyd+y29FKOA3/t4Z1NTedmRDUqcrBez7f/kwc72vJaUbQpKSUj3qwTRaxr7CS3Z8OC0kpTCvhJa40bC+D3LO6ZdsdT+pRIAf/eO1Uz7h+g/1dcUzm7/kdBJ5tPnM3OlL4aQq6M5Q3yj9p2mVUPrEhvKeIFxWn9RoIGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833544; c=relaxed/simple;
	bh=p1zRmRqZbrJ1O/+CG6UoBlYZIarvaPtP2kDNPedDiiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tDxe5b7DcHDNYsThcVNX6h0/AmPnj33RtjH6CHv/N/i1hwFO6NDLBiimg5X1XSSCdzVc7x2ApzYkwA4w6lE1LhzUt8lsSiH2zZbpV3aF576WhhXcGRRwaVqRl4C8KL+Czod+IJDRmrZwD/ukfK3HMQU/MH8HGSFf2NGY7Iz6vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIdI/28J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D66C116B1;
	Mon,  1 Jul 2024 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719833543;
	bh=p1zRmRqZbrJ1O/+CG6UoBlYZIarvaPtP2kDNPedDiiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GIdI/28J1FZNX9+worY87EpVYfrAqu6XTr3B866HEpeMe/NLs1XQIV+Yc99RzFO0s
	 bmGausGL+/6evAz3p7pXTvNbNJvVMOURPavHoJqChoRV4tznc6sxLTKwZyMAYKq3XT
	 D2ciNpoSDw2XZi+LjHFObnBg6GjPZpSKbh1/KJfeYX+2ZXWzccU12Wl6t9yPSHJ2bp
	 hqQmZDzBOVwWAOIr7BYrySFg/YsIzlQEfq0FCTanKSf/Dp7/uwyVXORM9yCnSSpfxm
	 Xmb/rul3hCSxTh4krlEy8/tpcFbCb6x3AvskNkBI0iFaKFd7pVZYgDVEE66zpFd/Hs
	 Ug4Jpivrx5HHQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <022047a8b16988fc88d4426da50bf60a4833311b.1719235449.git.leon@kernel.org>
References: <022047a8b16988fc88d4426da50bf60a4833311b.1719235449.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/device: Return error earlier if port in
 not valid
Message-Id: <171983353994.59738.7067848456702730242.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 14:32:19 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Mon, 24 Jun 2024 16:24:32 +0300, Leon Romanovsky wrote:
> There is no need to allocate port data if port provided is not valid.
> 
> 

Applied, thanks!

[1/1] RDMA/device: Return error earlier if port in not valid
      https://git.kernel.org/rdma/rdma/c/917918f57a7b13

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


