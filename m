Return-Path: <linux-rdma+bounces-12693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA2B2470F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BD2188C2E1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9D21256B;
	Wed, 13 Aug 2025 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J09Ty+2d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801D212560
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080205; cv=none; b=dsJeCk9EiQ85dBmj7R4Jr1lL2lIrqL0c7bfg+Hc+yYjDAVO2UIP/Bk/EqtMbwNnCGaHvXZQ92gR2aTrU7gqVOJCVI0I09itN9F6491MAa7zj3+P1gSCVlnWyrY1MgFIZwUdzb9YwUnKSwCajtrQp6YR2wCDuocf3NMJdMA5Tf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080205; c=relaxed/simple;
	bh=6z+EAbQnTWk4TwQY+yffmkphd1H+JmVJYGh3CS6uoQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c1Q7Kiu9wl7TdmaBtlCVM7ZRZoKqjVvqjzyYwKpuF4lJ0D5Ivm4lXmA4IKqxz36RzU3J1icx4fKgi54XleqEO6CrQAoXdX0tjtp6gmyHGXaHpa9fCc6ODAlznS9Pwa8CZw0FxJZ0aRWVbHbMSDd5PlYcx2opz0UwrdYftOgyydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J09Ty+2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C46C4CEEB;
	Wed, 13 Aug 2025 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755080204;
	bh=6z+EAbQnTWk4TwQY+yffmkphd1H+JmVJYGh3CS6uoQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J09Ty+2dnVPp5K7isiRVei//5W/YXfhDWWGJ+Bioi5dgzlDEXyC0NCNb1ouZvUX7j
	 vw7szZgulAhHePbhyE8yF5N7jutLoB/XytSpF0ncBANw9ylCI6S1IR+Os7w87ZGaTY
	 DPfukHzWnr00XBsjs14BqApYMLVsQdkTsEFG7u8oNXYCQI5iwIed6MxdTvQpR3iS7n
	 L+0ZT7TsAID9TrTB452UE4P1xXKrG3HTSdXU0jrxOnirrrlDxVFpRMtSnOU/qOLfxJ
	 ghdk/oO7Fo0zMA8pcAe+LnJoVXUrLo5yJ5tQKb0frBv+Kj3xaaKFGjkV/z3q+NKYe4
	 fOlVHX0Yj/jMw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>, 
 Or Har-Toov <ohartoov@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1751279793.git.leonro@nvidia.com>
References: <cover.1751279793.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] IB service resolution
Message-Id: <175508020122.5827.6166664812592145571.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 06:16:41 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 30 Jun 2025 13:52:30 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> From Mark,
> 
> This patchset adds support to resolve IB service records from SM. With
> this feature, the user-space is able to resolve and query IB address
> information like DGID and PKEY based on an IB service name or ID,
> through new ucma commands.
> 
> [...]

Applied, thanks!

[1/5] RDMA/sa_query: Add RMPP support for SA queries
      https://git.kernel.org/rdma/rdma/c/ef5fcdb7300aba
[2/5] RDMA/sa_query: Support IB service records resolution
      https://git.kernel.org/rdma/rdma/c/a892a3e74fb4f6
[3/5] RDMA/cma: Support IB service record resolution
      https://git.kernel.org/rdma/rdma/c/a6404823fe20e0
[4/5] RDMA/ucma: Support query resolved service records
      https://git.kernel.org/rdma/rdma/c/810f874eda8e49
[5/5] RDMA/ucma: Support write an event into a CM
      https://git.kernel.org/rdma/rdma/c/a3c9d0fcd37155

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


