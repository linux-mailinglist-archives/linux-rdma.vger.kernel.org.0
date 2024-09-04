Return-Path: <linux-rdma+bounces-4731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23B96B373
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CF31C24598
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053315B0EE;
	Wed,  4 Sep 2024 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi9A6PLo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51368121F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436244; cv=none; b=RZX6Vf+12NvOx1gfPT9TdcOqO+ZB5K4L64kg6efQjOIjYqFaNo4l88UNftec4Sjst2cLOJcSVMWsqBPp60UoOfekxdDCtRBAHmrOFOwZr7ee+qpXh+cO+gZWG7XaNt3/KOabR9+IGtgHPtH450B9BBo7GR+K0BNJ6RdRFio1eZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436244; c=relaxed/simple;
	bh=owrZz2I4LdQ3v+2RJuTXaZ+wZcL+hiE2+XVc2FEbvsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a6kFTpQRtZViSQ6bjKUh6c97mnleHsMSO7jQfez5FnVS8ZlMicYTuFfqmTU7YOTLus4kTzoeRb/rkggdPRQwsfrNZCNBLOxg9oZOPasWvmIcN/5mgVUtUMLE11RbMJZth1zmyl7Ha2glbOFJvqSvJV0SQcdG6eJI5EZDVix+YHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi9A6PLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6762C4CEC2;
	Wed,  4 Sep 2024 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725436244;
	bh=owrZz2I4LdQ3v+2RJuTXaZ+wZcL+hiE2+XVc2FEbvsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fi9A6PLo11jZKPi+XAXRHLIMRwcpUlI4rtLBlPatsy9oGOTWWlK8MJzca8x2RRpjB
	 5LYZI3WzuBIXk4NZUMUjs1ZSc8PeiWvXP6g76vJLpYp/obcRi86SFE//1620Ff7M6s
	 40g4sT1QgcBjoXoGrebXsUC/u++hLZFavKzsXeeWxcOPmDeU6hLsuJ9OMsQSk6TXW6
	 bw0hpEG5FO57nJsWGTuWli+K1lEZsyZ+lNz3tvdxp4GsvBa/dZODl1H1qadu9+9Djz
	 vUwbIRJXbGOLqPNE6TzQcc0RiH+OOcggCkowDBoIvP9X6VhvPtE7J1J1NQlRIv0UFS
	 sLaNFt7gThHsA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <79137687d829899b0b1c9835fcb4b258004c439a.1725273354.git.leon@kernel.org>
References: <79137687d829899b0b1c9835fcb4b258004c439a.1725273354.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Fix ib_cache_setup_one error flow
 cleanup
Message-Id: <172543624040.1199574.14580657397418905376.b4-ty@kernel.org>
Date: Wed, 04 Sep 2024 10:50:40 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 02 Sep 2024 13:36:33 +0300, Leon Romanovsky wrote:
> When ib_cache_update return an error, we exit ib_cache_setup_one
> instantly with no proper cleanup, even though before this we had
> already successfully done gid_table_setup_one, that results in
> the kernel WARN below.
> 
> Do proper cleanup using gid_table_cleanup_one before returning
> the err in order to fix the issue.
> 
> [...]

Applied, thanks!

[1/1] IB/core: Fix ib_cache_setup_one error flow cleanup
      https://git.kernel.org/rdma/rdma/c/1403c8b14765ea

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


