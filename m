Return-Path: <linux-rdma+bounces-4860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7697385D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4133282F70
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F076191F9F;
	Tue, 10 Sep 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSLyMo1o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86A524B4;
	Tue, 10 Sep 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974018; cv=none; b=OIfAFxfezzEeqYSEkEdIdImAe8iIXrk03YhJ0zLDZSoV4KFhn3FjZsb3TAklMrUxSEEAz2yuQS0vZbFAvdq9bADbv6q6Mwxg8VDNbKgMmygTIqHD0M6f3KSofEs1PbLLCQ0ffYi9tDyxCG2iIOXCysk1EAOV6o+5FOeB2ENpFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974018; c=relaxed/simple;
	bh=uGo6k4OAIYTYxKEoxQ9GjKss84Fepmbx9YP42wZQ/iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmXUXDCgs20kpH5bl2+Oq8aFgqLZwDwaFdVJRroa5YU3PU/KlIQNUjyCfaOkddKs8pCC8P69oH1voHGCqWvYNBEz4RGHDzFf2PgPi3bt2fiS5kaTjFcgC8NPkGfHwNsnMHR/1mhiipOAAyKS728a9wv6I1ncyS3fRf928qb3NWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSLyMo1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226C0C4CEC3;
	Tue, 10 Sep 2024 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725974017;
	bh=uGo6k4OAIYTYxKEoxQ9GjKss84Fepmbx9YP42wZQ/iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSLyMo1olyHvzG3qBu/mDwA2auj63+ZdRRopp5xKlLKpOXlxYvPN7nTLNjRmz1aRt
	 iUSoSve5lZzybSpAoL0f0Y8JWyi2GO3a0tyypXmVOvurSo/BAGbJY1gFsMmPROs+wn
	 92P4qMTqsAogcZKjBkjuSrMRXKi7iGiQyI/7+I/PZMC8PiK+2iwPnuwuQvUJWOiubP
	 y1Bw+LMEn9DefXfMH7PEMUbr35/JAD+OgaxdoSk6ipNQpqlB5EDVZ6x1oty8CCc4iq
	 eVTI45Ds1rfZpcoZE22u9vDtfCOs3DmS/foVoTyG2ItsyndYZBhmtfkVVRyUQ+pJUm
	 g839GAGj9pzng==
Date: Tue, 10 Sep 2024 16:13:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Bugfixes and one improvement
Message-ID: <20240910131333.GC4026@unreal>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>

On Fri, Sep 06, 2024 at 05:34:35PM +0800, Junxian Huang wrote:
> This is a series of hns patches. Patch #8 is an improvement for
> hem allocation performance, and the others are some fixes.
> 
>   RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
>   RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS
>   RDMA/hns: Don't modify rq next block addr in HIP09 QPC
>   RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
>   RDMA/hns: Optimize hem allocation performance
>   RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
>   RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

Applied

>   RDMA/hns: Fix cpu stuck caused by printings during reset
>   RDMA/hns: Fix different dgids mapping to the same dip_idx

Need some discussion.

Thanks

