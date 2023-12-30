Return-Path: <linux-rdma+bounces-508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252848206DD
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Dec 2023 16:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D27281BFD
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Dec 2023 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD38F5C;
	Sat, 30 Dec 2023 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOBp67Vb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46625BA27
	for <linux-rdma@vger.kernel.org>; Sat, 30 Dec 2023 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20378C433C8;
	Sat, 30 Dec 2023 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703949812;
	bh=beOCRPNesQBX42ODsZ9cyI1HX5cjLABu/HHOFPM9Zzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OOBp67Vb/Vtr7OO/VDF0MdaT3iJJrJmIhV2umI+zPlQsBcOBcDIxeA1bMHniaBYIa
	 ETp2Y6AIoqilen4FXLrx4gd5SpSW94zAc/nUvvchua9mz9BoVQVHyBFgIg9Uz13QWw
	 gE0+I6Hf2NT9z84NoOA+RZXKu16N60NQh/H776ObfK5e9djL+xASDQ0EuUkBWgrl7H
	 xyv3N72cABN3/EWY0/lT7ia06SzWxZw0rDOgwoefcYUP8xQ4Qp5xp45xEAkZXNhLpX
	 U7xi7O2cm20tEdI+0VoUbZtly5j5gE7F9uReKk9zM4ogGLFbnpvNGTXKHN8Twrn7zj
	 0jEveP9OfjrkA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc: linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20231227084800.99091-1-chengyou@linux.alibaba.com>
References: <20231227084800.99091-1-chengyou@linux.alibaba.com>
Subject:
 Re: [PATCH for-next v3 0/2] RDMA/erdma: Introduce hardware statistics support
Message-Id: <170394980851.347343.2110504876266809028.b4-ty@kernel.org>
Date: Sat, 30 Dec 2023 17:23:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 27 Dec 2023 16:47:58 +0800, Cheng Xu wrote:
> This small patchset introduces the support of hardware statistics.
> Statistics counters can not be put in CQEs due to limited CQE size. To
> address this, we provide an extra dma buffer to hardware when posting
> statistics query request, and then hardware writes back the response to
> this dma buffer. Based on this, we add the hardware statistics support
> of erdma.
> 
> [...]

Applied, thanks!

[1/2] RDMA/erdma: Introduce dma pool for hardware responses of CMDQ requests
      https://git.kernel.org/rdma/rdma/c/68cf9d82f75c07
[2/2] RDMA/erdma: Add hardware statistics support
      https://git.kernel.org/rdma/rdma/c/63a43a675cb90e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

