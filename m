Return-Path: <linux-rdma+bounces-4733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5596B375
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 09:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACB61C245AE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A0155730;
	Wed,  4 Sep 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6MGbzL8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F215443C
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436253; cv=none; b=jnOey6As8BC1+bbLnBKo0Cb8/1pkmaUUbhbdKxRVd8rDEmUhQjdKlyP21eDJ6HWcIkNTb9dtmKkkX8zwr8TCEmQEsH5aA7WxHyXAsFOw6xu0kAe8ocnTm0SiPvAMGDTGlR7KgFQJFZ8mnHIVay1xIlOez5UaaK+EADrqbyBc8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436253; c=relaxed/simple;
	bh=L7LMCND3DI7kwKvyfjxPDSBeHWj7imiAyPBsL2InHo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ebhk0QvcmsLH2VlXnLA1TS5mC4nTdujfC9mvny3AToHn5xErODbq0ugc/NQWzIG3CalSRZXy9rQbBgJG5YubH93U2GAP5qCXMwM/1oByAtKmQwxJ0+gXrqxXWH4ETrZXMpxxQ38NMRAQUcP04MEDojAKQZ7X3KymBnWsv6InpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6MGbzL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5F8C4CEC2;
	Wed,  4 Sep 2024 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725436253;
	bh=L7LMCND3DI7kwKvyfjxPDSBeHWj7imiAyPBsL2InHo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H6MGbzL8k+3hPh/6gY8hohzCohQjn1D5jFZtX1nJrCC1UOtTzhdpZnOEqrsxZo6J6
	 CsWngq51TIadyfOtVrKiryATaOKZBMAyTMccnpkrQS4e04FOPKd9SJDxlS+7DAas+R
	 inHHfuonIQy2d0hkkRjXpd+YPsWnajxqdD5oKyN6fhDLPYdK6EN3AeDcz4vQv6DUqe
	 MPYWzo0MKmN1IA/luAIA4gKoKwyfgD9xN6KKnwxKhmtgIwI4w20JyX8qWdtA8X+1C6
	 AFrKM+rvdpTWVX+/nozDlNyBxR4pyUKm5Ie8YurI8YVJrLrsDDjea9YUEAjwBIQcAn
	 hjJls9K+R7QsQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc: linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20240902112920.58749-1-chengyou@linux.alibaba.com>
References: <20240902112920.58749-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next v3 0/3] RDMA/erdma: erdma updates
Message-Id: <172543624910.1199574.15523727146624745781.b4-ty@kernel.org>
Date: Wed, 04 Sep 2024 10:50:49 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 02 Sep 2024 19:29:17 +0800, Cheng Xu wrote:
> This series has some updates for erdma driver:
> - #1 refactors the initialization and destruction process of EQ to
>   make the code cleaner.
> - #2 adds disassociate ucontext support.
> - #3 returns QP state in erdma_query_qp.
> 
> v3:
> - Remove patch "RDMA/erdma: Make the device probe process more robust"
>   for internal discussion.
> - Remove __GFP_ZERO flags when calling dma_alloc_coherent in patch #1.
> - Eliminate __GFP_ZERO by calling dma_pool_zalloc instead of
>   dma_pool_alloc in patch #1.
> 
> [...]

Applied, thanks!

[1/3] RDMA/erdma: Refactor the initialization and destruction of EQ
      https://git.kernel.org/rdma/rdma/c/2ffc67aeb99105
[2/3] RDMA/erdma: Add disassociate ucontext support
      https://git.kernel.org/rdma/rdma/c/05572fa5268ec6
[3/3] RDMA/erdma: Return QP state in erdma_query_qp
      https://git.kernel.org/rdma/rdma/c/cf2840f59119f4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


