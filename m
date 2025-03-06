Return-Path: <linux-rdma+bounces-8404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA2A544D1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E928C7A5BAD
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DB205502;
	Thu,  6 Mar 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3Wt/Wj6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F8204F9F;
	Thu,  6 Mar 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249607; cv=none; b=rpnMgml+EPQejbxbzSVICz68JvY+Dojk+r3hV1mSKGPCKTW32ChPeKhPoRZEHgBinrNbCdm821pc3bCedInw2fogerdHOr7y2HmFic+mRggwlZAtJ2cXRDjCoZMJ0TlhT18czgTDiz0yrGVNvQATnarWLS1b4+AFKQBhe6hoEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249607; c=relaxed/simple;
	bh=BAEE/F596/ncBBnSny168loHlhskbfbt10Rij9lOuZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XSHLEH7IyANPPBLgZznoyn01pwCDQ4rOvsv5vMxJlQvU48+a0kFUY3E7DwSgdkBreo0V+79OlceVXe7st23fBl623DG/hpeQqEoG5+IPiyEsDfSNczVcKfIOCUmX7S9dTjtQ396SyI8SzxSMUlWG+Yd5tdFR3EF38KFz4J2LX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3Wt/Wj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2546AC4CEE0;
	Thu,  6 Mar 2025 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249606;
	bh=BAEE/F596/ncBBnSny168loHlhskbfbt10Rij9lOuZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O3Wt/Wj6Do8TSZ8vkRPc9pWx5r9sEJT9UQoKVlVroMUe1SNGeqCWYHc4pBoOl/rCH
	 9bFaMIlZdFXSA9W/s0W59sBiubGM0SM7uAzFm/Y9JCondq/Jbi1fLlNcsmST1J4jag
	 GNc+s6zsFDXf7v0lNukvfixurVppzq4uETNiTcCqacBS1a7RATAP0MJSimx4nlxb6Y
	 51+5PXBg3VMgIEI0sEYHlJ/BrOM27dSS+O+nVZ7o+rlZEOh9WqsJYG9dRg3gcxC9u/
	 p55rkAIApCdA8NixnJdJrBcApUREU/cwEzE6An9QVJzWhKMYQCiKT3aNSuYr3fJ3Kr
	 Y/xfJzUP4m8rQ==
From: Leon Romanovsky <leon@kernel.org>
To: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, jgg@ziepe.ca, 
 linux@treblig.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304215637.68559-1-linux@treblig.org>
References: <20250304215637.68559-1-linux@treblig.org>
Subject: Re: [PATCH] RDMA/vmw_pvrdma: Remove unused pvrdma_modify_device
Message-Id: <174124960309.256845.12532897660776532517.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 03:26:43 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 04 Mar 2025 21:56:36 +0000, linux@treblig.org wrote:
> pvrdma_modify_device() was added in 2016 as part of
> commit 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
> but accidentally it was never wired into the device_ops struct.
> 
> After some discussion the best course seems to be just to remove it,
> see discussion at:
> https://lore.kernel.org/all/Z8TWF6coBUF3l_jk@gallifrey/
> 
> [...]

Applied, thanks!

[1/1] RDMA/vmw_pvrdma: Remove unused pvrdma_modify_device
      https://git.kernel.org/rdma/rdma/c/0b27b0e4d43aff

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


