Return-Path: <linux-rdma+bounces-10300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961DDAB3599
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391903B2A7E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A228750C;
	Mon, 12 May 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhlloJwG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D92820D0;
	Mon, 12 May 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047917; cv=none; b=ucFfK7gaRrXa8jBdQPsn13xJqTI7HxO+4waRDXxwSZpJ11s81QcFzQ6Hzfdt0kvyZRqALEHVaW6nDlAF+LyrPYnnGfAFtigbtCO2dMdFoNtVG7DpMWmVtEcHgieByEd6qbuo4JiRhLKBJ3JRfVkJpfG04nsKiGdkUnN1aXMS520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047917; c=relaxed/simple;
	bh=bGwW0OOh62fnvhyZi/8+qwdRHweF1/FWio8WHTAvCEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUZ2aNosYqOO0YDXOwNQXHzh760RukIMSgaU2EzCNmY9TNVGHsld9RbeVjFJoiHuSQKBNnxVko1mzp4QUfiwt8HaTMluLE59/mYN96V0FBFC0ca+8FEn8koAmWTkN8cHyD3//AhX5kVb8MOQkC6GJEpIwfiTygOohjALLA5uUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhlloJwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C898C4CEE7;
	Mon, 12 May 2025 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047915;
	bh=bGwW0OOh62fnvhyZi/8+qwdRHweF1/FWio8WHTAvCEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhlloJwG3hVQ/nWL0K4M5AHZtooEGdSnYvhMJ1HS0cUEHIuzPX7N+EpU9yIfB+IZw
	 R2BO9Z2Uh0wj70f1U8lVs4/lV3Fo7uDoS2qfy740gmX3TAxEiyEcNuLrJdG/jpoorn
	 PhkMO/zBMJ3L4zSaZhUJwNGq5oODi4uj1fyO/P8F6dDUQp671MQ89TrSC8WpGRwetp
	 RtWTeW58/zin5k0tIq7kQyWtcB9BwDtvy4igCi3IXBn80jpovzAuhWs4+d3j3nUAXW
	 Rz1/9g1m+UOcLUbTJqAnjP3YiRpxF/4+EeZtequ73s1ZYawJLOQh5KtjH4RjVy5Yrg
	 cDOVa310GElgA==
Date: Mon, 12 May 2025 14:05:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	tatyana.e.nikolova@intel.com, david.m.ertman@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next,rdma-next v2 0/5][pull request] Prepare for
 Intel IPU E2000 (GEN3)
Message-ID: <20250512110511.GD22843@unreal>
References: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>

On Fri, May 09, 2025 at 01:07:06PM -0700, Tony Nguyen wrote:
> This is the first part in introducing RDMA support for idpf.
> This shared pull request targets both net-next and rdma-next branches
> and is based on tag v6.15-rc1.

RDMA part look ok, nothing that can't be fixed later.
I'll wait till Jakub merge this series to netdev tree and will merge it too.

Thanks

