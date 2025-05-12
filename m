Return-Path: <linux-rdma+bounces-10297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B9AB34C8
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 12:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD0917D791
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE393264A90;
	Mon, 12 May 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CypUT6e6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74173264604;
	Mon, 12 May 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045253; cv=none; b=oiIN8ebKDBpIClMfzsnPfqkvl2ZV9NlfGRQXmN7wHnyiLlBqGSFsWlt9E63vkWeNWtlCgwb4exUP2cHLOld+eCgNuf7BVXZE4wst81DSSMHsaZFiYvHbC+Dzz6hr3bRGgsrbcU2wgZ24RviSNKerF8uFivktPK7HlWLk/JnVmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045253; c=relaxed/simple;
	bh=ShaXDuMb8c02rpvKHOp6SKtZleK0+kKxr5lC0fSnF9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=meuQas3wA+sLmT2It7cG8BLmXkobdFs5cJZQNjQ43HXJAF5Fi8UQZr/zNZdyDt4q6FKY2beMlidckdhIIh5KKR6P0+uzHwWBsitncU6ASuIg2R7gc8sGeEi+6KEnolrnvfg2crH6+mDvqr20CZSYxDoVjl9XDBIkkePJMgvxOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CypUT6e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FC3C4CEED;
	Mon, 12 May 2025 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747045253;
	bh=ShaXDuMb8c02rpvKHOp6SKtZleK0+kKxr5lC0fSnF9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CypUT6e6Aj+PnL+Ws/KSyqKC1k9FY/orK8v9i/P21gR2qZy8FxpktHi0yggcRK/qU
	 SPz50BR7QmWwGRmn/Gn8md7tw7b68pUscPAqqE+XJfybWK/yUIPHmYmCuCv8ZwoDG+
	 Fkg1SrhQLpdKbu1sMdoO46uZsjWrHmByZEDmVLqfS9LRdVDPP9AQK/5E26YAk2UzAm
	 jNked6baDOz+uhuiFjQTmMToKp4V4RYhY0l15IZiyoEY/JmRCBqdJEzBpy82++NgHZ
	 uL66tdQITS1pp+qDy2mTq9c3Ch4nUwFsGJd9j9SASLdcLN1U1LFM+9da7F2cI0CY1I
	 iQmgqvkPF1H5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507131834.253823-1-colin.i.king@gmail.com>
References: <20250507131834.253823-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] RDMA/siw: replace redundant ternary operator
 with just rv
Message-Id: <174704525028.584839.4314624447518486154.b4-ty@kernel.org>
Date: Mon, 12 May 2025 06:20:50 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 07 May 2025 14:18:34 +0100, Colin Ian King wrote:
> The use of the ternary operator on rv is redundant, rv is
> either the initialized value of 0 or a negative error return
> code, so it can never be greater than zero, and hence the
> zero assignment in ternary operator is redundant. Just return
> rv instead.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: replace redundant ternary operator with just rv
      https://git.kernel.org/rdma/rdma/c/8536666a52833d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


