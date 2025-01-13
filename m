Return-Path: <linux-rdma+bounces-6974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198F1A0B5E9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 12:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B597A7A156C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38522CF1A;
	Mon, 13 Jan 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCkpRe53"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237522CF03
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768482; cv=none; b=WEXxjQ+V8/1UZKJMXN8/OBDwsNDlZBpZjH4BWUr3bBkAFtu4p8fKujmqQNbR7ARnbYs97yDwQRhU83qnPH+PxSrVJV5HJYvqLASMkv06E/zWkh6VXshw31APX2qQRy2saJ2gOJGCd6cS2DCKWrCTxyn/VaiSib83GfaEgDg8fWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768482; c=relaxed/simple;
	bh=z/ab7zLck2dEZCSsEgpJUhzk5jP8Kpin978K+Ut/VbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tyIqVwdjeEkbgUkJUGpNqNZk7dmIBZhGs9vH6rU0qcsd+HubUcb22y5Ft3HutJG5wgjFx2EkVJur/12U5tyWR3cmrWMB+zHQZSuyCHk0NjhAtidrwsg4TcTgr71k4ji11OL55tIWD9xzMQF3CogudzVDSOIesmswpgazrA3TNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCkpRe53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A264C4CED6;
	Mon, 13 Jan 2025 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736768480;
	bh=z/ab7zLck2dEZCSsEgpJUhzk5jP8Kpin978K+Ut/VbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uCkpRe53xFvSuVAYpmfqivi62wJWm7b9edvfi6DnJSRBJ7m1N6b8wdyEdw8vN6EfA
	 zpBaBV4Odq6HQYRajdxvE9kh/tBaHcvftLDwHC8cIhE65IDHuVT/3LHL8Wp9Oh19Jp
	 9FyT5gqzZV5F0v72zwhfTWsqq9Fli12CTIrTsuPbvmxy49RSwSmpmMH+lO/HFsjrEz
	 TU6rxAnLBCmoo3Gn08vPsx+CuZgt2EPxFybfnq+9bxlVcA3R4q+W6sW7jOZwKMNL4A
	 eMdTFWTN2wMGPNcVqagCNqQdWK5+VTRCunrV4UAUMw3vNr+CR1CmfIgjZw4+YQrpBo
	 wbYV8cesU6RAA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Michael Guralnik <michaelgur@nvidia.com>, 
 Artemy Kovalyov <artemyko@mellanox.com>, 
 Artemy Kovalyov <artemyko@nvidia.com>, Doug Ledford <dledford@redhat.com>, 
 linux-rdma@vger.kernel.org
In-Reply-To: <86c483d9e75ce8fe14e9ff85b62df72b779f8ab1.1736187990.git.leon@kernel.org>
References: <86c483d9e75ce8fe14e9ff85b62df72b779f8ab1.1736187990.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix indirect mkey ODP page count
Message-Id: <173676847742.1192217.3416930342466465012.b4-ty@kernel.org>
Date: Mon, 13 Jan 2025 06:41:17 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 06 Jan 2025 20:27:10 +0200, Leon Romanovsky wrote:
> Restrict the check for the number of pages handled during an ODP page
> fault to direct mkeys.
> Perform the check right after handling the page fault and don't
> propagate the number of handled pages to callers.
> 
> Indirect mkeys and their associated direct mkeys can have different
> start addresses. As a result, the calculation of the number of pages to
> handle for an indirect mkey may not match the actual page fault
> handling done on the direct mkey.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix indirect mkey ODP page count
      https://git.kernel.org/rdma/rdma/c/235f238402194a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


