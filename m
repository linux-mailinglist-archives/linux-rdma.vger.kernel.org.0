Return-Path: <linux-rdma+bounces-9635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0106A950C3
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C8C1893FD2
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9CB26462A;
	Mon, 21 Apr 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU28blmn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44926139A
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238019; cv=none; b=nH0yRNnRNoSsRYidYqYJGdpShThKW+m8g+LkyLX+BzJ3+dQHUw+KtbzT3RUjCQ81hDnxmdXNylvtCs5ANgMNZdXvSsQnIpUX2/zWZUF5XGvJ6PtuLdZOiMU1CfVm63LYGxxKHri65dLKrLXIju3vNFWp3QduTCxGB/oBX+Q9Z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238019; c=relaxed/simple;
	bh=DVJVNO/WyP8D/lekr0j0AnDUt/0+wie7RXk9PT+WkpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw6+XCVNpe550ucnBu6oYIeqNIlIkIAr+TxolmTQohgE3ymuE+EoCSJj95m5BjYgl5gh7d5BReKZJJL4N5z35+R4iRYwPsnatCxboZs9kodXii3ehIcc2uRuGPXjp2WXOCEldEkAWypGAF6VJaIARHAhAS9B23DhqPaA8Q3njqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU28blmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E33C4CEE4;
	Mon, 21 Apr 2025 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745238018;
	bh=DVJVNO/WyP8D/lekr0j0AnDUt/0+wie7RXk9PT+WkpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU28blmnoZq7u4Q9z/iuU5X7z5610AOXZCbDnPqTpGYhM37H1gWqffiQzWE0UrPVi
	 88NVbWwUKj1EsiVweGEY4FEgfRdgiTJoFwqSgSCVD7Bi+WiP02Tv4jbc1yM9dWxMr+
	 3RJlY2wV4UonMGYdaZNW1rkurQnm2bYa47JBz3LQ5WJlrZnqOYEdpP7V+v62YcZssB
	 bdlp/sNA04MbzO1r7kF0N9X1xK1YRtlk6Qi+lv7b+QdDKPak94LwMTUIjuI8srMODz
	 4bzrS5F3PPeDwrlnE9+8zrc27kWEEKEqseGmMF5DkUCfLy8N5wMOldJtCnh9WsCpju
	 w/8Rdt0ZGB+EA==
Date: Mon, 21 Apr 2025 15:20:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/6] RDMA/hns: Add trace support
Message-ID: <20250421122013.GB10551@unreal>
References: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
 <174515167383.720316.10548192191975881376.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174515167383.720316.10548192191975881376.b4-ty@kernel.org>

On Sun, Apr 20, 2025 at 08:21:13AM -0400, Leon Romanovsky wrote:
> 
> On Fri, 18 Apr 2025 16:56:41 +0800, Junxian Huang wrote:
> > Add trace support for hns. Set tracepoints for flushe CQE, WQE,
> > AEQE, MT/MTR and CMDQ.
> > 
> > Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
> > otherwise there will be a compilation error when hns_roce_hw_v2.h
> > is included in hns_roce_trace.h in patch #6.
> > 
> > [...]
> 
> Applied, thanks!

I dropped this.

Thanks

