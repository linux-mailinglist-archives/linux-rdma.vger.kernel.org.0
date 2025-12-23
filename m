Return-Path: <linux-rdma+bounces-15186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB8CD99A7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DE63020354
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635F330315;
	Tue, 23 Dec 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca2AfIxv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029D33372A;
	Tue, 23 Dec 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499659; cv=none; b=OTwiMAkwW3lm8sMeiQCoJKduCi8OAPVnssvjL+RCqT8/l5K4mYDMFm6eHbYjOB0wkRxTVtp2YZQfyQHJzHYXHOnClIhQUbQNvqDQJgXceK2LaE9Ge8ONOh6k6Q/o/oO/9fad1yRCC90eIWyOSA0fOar55zZMKXHbUhowWmRszSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499659; c=relaxed/simple;
	bh=UCx/yr6qceENxP0vKUjE1tXTKUy1cwhMJ1SQ7YbQ5c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRMUr7cAybLB89ltbIXXMN5pmTJPZtWyOkxpw05swzzY71ULjch+os7XcsFIwGU8z+6c2UsqZ/tDICUWlYNZO6ujdWjITKpkx1fGvEuS7lghmKDRXtW4V71DAW6N7qyCr9bpYKayfYvVpVE9GbDM6ZHFdzj+H79c1hgA1QyOr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca2AfIxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66109C113D0;
	Tue, 23 Dec 2025 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499659;
	bh=UCx/yr6qceENxP0vKUjE1tXTKUy1cwhMJ1SQ7YbQ5c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ca2AfIxviTjc7mRcaE4yrx3/92aKrZ52SUq/GcQaXsTzpcprOnydPonGzR1O/SzDM
	 yQpJXqDbL7VcqSXYgZxCCOak0Sm9XdPSOj12fVeIYDN8npFXhibPrm/x+qesWlQjgk
	 PulXJ0kdCzAC18tW9Qx6hun9FU1M2brubjULW8lpxPvm51AEFpR4puYc079Sd2j4dG
	 tn059nYxcOaZ+SHaw8K6ZVQ065Yd+HkxvzZkDaK+GzjWTXmlw0FKl3ZUYq6wzSUTg5
	 07e7QC3xz9hocsR9NIjXb6T5qVd/7Uofa97a3s/j7WCP8/n1roJYGkImKB/r1tQ7Ei
	 6XRkjrBeg4QzA==
Date: Tue, 23 Dec 2025 16:20:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, zyjzyj2000@gmail.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251223142055.GC11869@unreal>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
 <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>

On Mon, Dec 22, 2025 at 09:10:11PM -0800, Zhu Yanjun wrote:
> 
> 在 2025/12/22 21:03, Gustavo A. R. Silva 写道:
> > 
> > 
> > On 12/23/25 13:41, Zhu Yanjun wrote:
> > > From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > 
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure
> > > containing a flexible array member is not at the end of another
> > > structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM) and a
> > > set of MEMBERS that would otherwise follow it.
> > > 
> > > This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> > > the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> > > start of MEMBER aligned.
> > > 
> > > The static_assert() ensures this alignment remains, and it's
> > > intentionally placed inmediately after the related structure --no
> > > blank line in between.
> > > 
> > > Lastly, move the conflicting declaration struct rxe_resp_info resp;
> > > to the end of the corresponding structure.
> > > 
> > > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > V2->V3: Replace struct ib_sge with struct rxe_sge
> > 
> > What are you doing?
> 
> Because struct rxe_sge differs from struct ib_sge, I aligned it to use the
> same structure.

Zhu,

Please submit your rxe_sge to ib_sge change as standalone patch and
Gustavo will resubmit his patch later if he wants so.

Thanks

