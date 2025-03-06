Return-Path: <linux-rdma+bounces-8429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBFA54C28
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5001D1885320
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1420E319;
	Thu,  6 Mar 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP2NnN1l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08D20E309
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267717; cv=none; b=kSgaCLPfEVXHDb3v7ZhrR7HCtVHNvOBuAzAuCQENgIH6v0lTjYf/MxqqLov5qKYn/2KGeu6xCN31WJxtGsUKcClVhnbzY6d3fyI/xObqhDDrYwE0MTzCKmtq4Z09rLBRrv7J0Z4vDmh3OFxCoYvkUSBi12LoBpYybGLi+CRQGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267717; c=relaxed/simple;
	bh=SclYw0hWjNQbylhUxJDUXc0lpbZoVOc0TqCEB2fRKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob4nlOfmzFcnMVPBWWfA44iJc6H4ZM2h88TAlT6SefhJVOgqa3fSAc5bAup+p6J3uJughGMEz+J3HyZjlOC6ghQLP6sRun2moVrMbjj45f9JxKUt5zyaqZk8VEJSErhjIatNL8DnvUO/ZXGEQKMWIlQxVGDF2LFVRvJtkPqWlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP2NnN1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F6C4CEE0;
	Thu,  6 Mar 2025 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741267716;
	bh=SclYw0hWjNQbylhUxJDUXc0lpbZoVOc0TqCEB2fRKDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JP2NnN1l+Z5yY185K7GRn6qqhZ7denOrqg9ZWTlq3g0P1If0XaA5VU4RiwyCEXyT9
	 7HClfSyW6iBgfwtDvLhM47/IWYF/1nxQ+E9Q3HcumYw6AEMnqBhaqVHfsdRfoRa4xN
	 Hb4NAPe9n5TpRNoo9/Xpu0VvUQggHjPdZ/LTaVMWubYHfaiUIBuP56aR4kFj/Ha1h5
	 gPO2aF0KEnk8Xcvrb9dtv/FjmUWdCrX9VUJQKdFZd9RJz/5MdUQ9jmHVSwqsHVBl2a
	 tkc8z+5C5skuivLTi5g1kJOJ2XGfodAcFflFPI2XjDS9pWD9LrFeQITIUGPx0gvy/y
	 Gpqq4hx3jAhZg==
Date: Thu, 6 Mar 2025 15:28:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Message-ID: <20250306132831.GT1955273@unreal>
References: <20250306120440.72792-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306120440.72792-1-chengyou@linux.alibaba.com>

On Thu, Mar 06, 2025 at 08:04:40PM +0800, Cheng Xu wrote:
> After the erdma_cep_put(new_cep) being called, new_cep will be freed,
> and the following dereference will cause a UAF problem. Fix this issue.
> 
> Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_cm.c | 1 -
>  1 file changed, 1 deletion(-)

Applied as is.

Thanks

