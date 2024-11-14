Return-Path: <linux-rdma+bounces-5984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B69C894C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 12:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63590B23392
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B021F8F17;
	Thu, 14 Nov 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/UuOO+1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF81F8F0B
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584508; cv=none; b=qskUtSxySWaS+8lvGBcqNlzXGjkkSWVRwx6kFUOVnZre4PbHHHA12W9wR2VsAMpFotcm1eP6wPGuuqxF/m2vQIGru0UHmao9UGPMAl6UGtxry2ASU1B4Z8ee9jAp+dorDq1plng70FlAX32mZKTThvGR8X1q7UTNrOWUh1x/BVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584508; c=relaxed/simple;
	bh=gLgSyFYZ3SCU8+lxwN27I+1S8Wg6qKlEwHT6pGuDXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdWo4eaXpKwI9OsXgNh61Ekn5G2MzdKaPjuMVaZJEY02eV6A3+h9wmD7d4gSkOBk5qFqzo5f9pwnMfKLUlTvW7obOvVjrSadlgQF5ExIBbje20E+pG+Hq6w0mfVC2rqej9EWj8fH6VMjceBioNHdRoBDo21yXWm+YHWPrywG8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/UuOO+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB59C4CECD;
	Thu, 14 Nov 2024 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584507;
	bh=gLgSyFYZ3SCU8+lxwN27I+1S8Wg6qKlEwHT6pGuDXAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/UuOO+1dHRbtiUQMAwHdUHJyMyGDRV4dkOpY36fx+0/c41RlLNuOT9n7EyKRAHjv
	 1Svy29btIjERuHVKPAlsKFyixzc4brgcqssEBNtqP6e2OzXgCRWnkAp0Am3+Cv3bJS
	 qv9tB2kEBsbbib/7SNXL8LHzXIXGAYwTZp40ZtbHtd5VM/e1uZrmny66c8qkLfx2OM
	 SjHsx/njLH1oH/sZGaWoO54WdpiRcGsSWAP1OJ591H6BWslbfdEwaPhh4FFsbO/zBR
	 yRUOluZaAE9qtHdyg4BKVMjAuKLvFQWJ4AVKogX25M8V+HuEe3M3RxB4HLoIx94gaP
	 DpU6qv9pVnQaQ==
Date: Thu, 14 Nov 2024 13:41:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	ynachum@amazon.com, Linuxarm <linuxarm@huawei.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	wenglianfa <wenglianfa@huawei.com>
Subject: Re: Why is the DENABLE_LTTNG compiler option in rdma-core disabled
 by default?
Message-ID: <20241114114141.GE499069@unreal>
References: <8fe49262-98cf-6b43-4f55-b09a8ae449ca@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe49262-98cf-6b43-4f55-b09a8ae449ca@hisilicon.com>

On Thu, Nov 14, 2024 at 02:57:21PM +0800, Junxian Huang wrote:
> Hi all!
> 
> We've been working on LTTng tracing for hns userspace provider
> recently, and we wonder why the DENABLE_LTTNG compiler option
> in rdma-core is disabled by default.
> 
> If it's due to the concern about performance degradation, we have
> tested it on hns and found no significant performance difference
> when the tracepoints are disabled.
> 
> Or is it because it introduces additional compilation dependency
> on LTTng library?

Yes, this is the reason. Most rdma-core users who use release version
will never need trace library in their life. They don't need an extra
dependency.

Thanks

> 
> Thanks,
> Junxian

