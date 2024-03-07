Return-Path: <linux-rdma+bounces-1309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2247874AE5
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 10:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D6C1F283F2
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7BD83A0D;
	Thu,  7 Mar 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoQHEjfI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BC6350B;
	Thu,  7 Mar 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803981; cv=none; b=OM78A/0Z9HwgnnA/iWjPYa8v4vA3+ePigJFUCcGrkzunaIQtf1vXi0hhfjU9Hr9xo50PROFwy7+UX5dS6QcPOKGe8ksEpeQ8Ictm37ImaM3hOqWUAFurlv8OYA8KjKSZxeOBqdtT1l6T3N4ERYfWyKH049nPHa3r6UVMTSFvjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803981; c=relaxed/simple;
	bh=TbHczZlPBD3G4U8vgeyYJgRyiPHXMuYIf8EG8WxAuaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sjLe7HHKAl2XmUYOaf9sAPdpHoftZoqpX2guuLY6YAXggh3womkvc5sE3bk5TxtoBPOUPayGm1fym7gKTlkYRffzNjhAyAu1q1fQe87zyCG09/hcqSqDcAPB5jewm2SQeXcek/18e4+y5836fO+9e7B0ZkzBadWCfnngiRndS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoQHEjfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA1C433C7;
	Thu,  7 Mar 2024 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709803981;
	bh=TbHczZlPBD3G4U8vgeyYJgRyiPHXMuYIf8EG8WxAuaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JoQHEjfIJzV0hClmtf0M3fT9/pJO2D8Qs5sARInDbx4Xz0A0/KP2ZKG4ZndUJvUdi
	 4y/BKZckyueDrxj6p5utDBVrYhEGLVf985anyv/XZUch87Hf11sd7Beq5DeMrVi5gy
	 1uhZcklx/dwrI4BE9K/vi3YafiuLKflwlqJWwiT+LYk1KchRM720Iuz0GkCaVqkv5W
	 AySza4O96gCbtB//akwUrmcquHvkiJI8qAJ2ktgwhcq2aU1hg4s33U/LJoQ7k0zja6
	 udlnia5o1o2NlmmQJpj5cYTU1m0OQ/0D0yMi4T7elJy5UK2VuKoNc0jjyuwfotO2ns
	 r/YZZ+TF7Az2Q==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1709560361-26393-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1709560361-26393-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v3 0/2] RDMA/mana_ib: Improve dma region
 creation
Message-Id: <170980397781.112869.7049742674464362128.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 11:32:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 04 Mar 2024 05:52:39 -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series fixes an incorrect offset calculation for dma
> regions and adds new functions to create dma regions:
> 1)  with iova
> 2)  without iova but with zero dma offset
> 
> [...]

Applied, thanks!

[1/2] RDMA/mana_ib: Fix bug in creation of dma regions
      https://git.kernel.org/rdma/rdma/c/e02497fb654689
[2/2] RDMA/mana_ib: Use virtual address in dma regions for MRs
      https://git.kernel.org/rdma/rdma/c/2d5c00815778ec

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


