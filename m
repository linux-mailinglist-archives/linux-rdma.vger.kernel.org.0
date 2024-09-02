Return-Path: <linux-rdma+bounces-4690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FFA96807A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06D21C22022
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8757185B4B;
	Mon,  2 Sep 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSuQsw+s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB43183088
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261698; cv=none; b=SzIh+kiU/t2SXCFwGNuVjVvpjz+KVzi4euk0ciikTzlzPgxzJDUw//EZJUfoGihUjj4cYi3Gxw30vjJt0jRO4mUBRAkYb+uVvDdombz3baVphs4MA9uyF+ALgHiMZdw3Z9riKWwjUETQrJ/zymnJOeShSk5blQZY6pxMM/xgLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261698; c=relaxed/simple;
	bh=8bpkUCUWNWDMIWEA1xw8uGSnP7VdcK8N3Tb7nSFzMlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeIkczSdWa4pveK4LzHKibHABSyPtqUGV01H5NvMyv1odL2Ze+6izDhfcOp+ZrFd4aekaFoaEh9wbB60cRDfWnV2eMGuYEOnulGvsXaA7BPqXSma617Ypjahan05EE/s0sEn90SvinlbGPHvD3uqDpIqxzgV9Rv7VB8augHVqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSuQsw+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C399C4CEC4;
	Mon,  2 Sep 2024 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261697;
	bh=8bpkUCUWNWDMIWEA1xw8uGSnP7VdcK8N3Tb7nSFzMlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSuQsw+svzI8a1ifnqzVMtvQCIW4HCUY7HV3KIyj0ksRmXZWK7hGUT9TCy3zUeKeK
	 thmiC+wmiM9oSnczxnOI+bNAzddR0e7lPr1iAIlk1kjFzvUM34D44BRDFl84osFWyz
	 sO9SuJ1bE/TjGfs074EWWAJ+vNi8K4M1dr4aZY6HCEqFWra93rc1nDCxiKnDQS0Xat
	 ULO7BKmrsqEv7V83BEF96ND4cCf8UKjpntaCz9saC8gZ+SWCmyqLe4KaLyUteYrFV5
	 BQZlo+O3/Uq8K80Bl/QX8APgQNvi/iFDZ0YWsKpRv4PiuGwiHM4Fsuwx4TZZRASJVV
	 JOjxyb/SsoFsQ==
Date: Mon, 2 Sep 2024 10:21:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe
 process more robust
Message-ID: <20240902072133.GC4026@unreal>
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
 <20240828060944.77829-2-chengyou@linux.alibaba.com>
 <20240829100955.GB26654@unreal>
 <e4649d6d-8265-054c-24fb-ca641716856b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4649d6d-8265-054c-24fb-ca641716856b@linux.alibaba.com>

On Fri, Aug 30, 2024 at 10:34:42AM +0800, Cheng Xu wrote:
> 
> 
> On 8/29/24 6:09 PM, Leon Romanovsky wrote:
> > On Wed, Aug 28, 2024 at 02:09:41PM +0800, Cheng Xu wrote:
> >> Driver may probe again while hardware is destroying the internal
> >> resources allocated for previous probing
> > 
> > How is it possible?
> > 
> 
> The resources I mentioned is totally unseen to driver, it's something related
> to our device management part in hypervisor, so it won't cause host resources
> leak, and the cleanup/reset process may take a long time. For these reason,
> we don't wait the completion of the cleanup/reset in the remove routing.
> Instead, the driver will wait the device status become ready in probe routing
> (In most cases, the hardware will have enough time to finish the cleanup/reset
> before the second probe), so that we can boost the remove process.

And why don't hypervisor wait for the device to be ready before giving it to VM?
Why do you need to complicate the probe routine to overcome the hypervisor behavior?

Thanks

> 
> Thanks,
> Cheng Xu
> 

