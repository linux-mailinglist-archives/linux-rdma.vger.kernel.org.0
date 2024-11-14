Return-Path: <linux-rdma+bounces-5983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F69C8919
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5CB1F2439D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE971F8909;
	Thu, 14 Nov 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei6yVwAr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4B18C02F
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584257; cv=none; b=hNVMhpnU56HmrGAtd+609nwsd62+BUAC6IfY5cSSTZfPRoG50Z9I8pX1IplV0uoIhOMeG/4ZEPdWvMgsnM+D4iTENEF/JSHJ5jQTPJHnQFkg/m+MpWXr8tgqU54Dd7zeI8C/OzgOJdf8HvkAq43rf66AHkYaGMQ2sl4mT6mB6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584257; c=relaxed/simple;
	bh=+OqNtV/MAJlWFyXPjtdIWo3Hfd0IwxVxXl2uVodtHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF7fthWj/fnYGQm2fsYHgsO7W5JOp7bJ0UTGUupKNxzqb1zISmtp3NpmOkMPOc3AFmh0eoiWJvVJChCfWTJRjzJtZGXxLVvZUHSgVTiD8f/sC0C3UpMUJbB6IzQLFAKzlo2hXiqwyOc4HKKh0xvezf9DeqzPhMvpuI+o2BV7iXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei6yVwAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79659C4CECD;
	Thu, 14 Nov 2024 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584256;
	bh=+OqNtV/MAJlWFyXPjtdIWo3Hfd0IwxVxXl2uVodtHLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei6yVwAr//ol+U97poGD1BdHWwb+HyU9ung4PPwPVlSJtrTo5tQgYI6OuP7kWQen5
	 t9VmIBbQtuIyi9LxnLWpMoz7Oe/jXB6tgv9PXqbSAsIgcxjpVLkekAr61dxBMBs2nU
	 23gTdEUxDlozaLb+qXTDWgoaHmtD15wZyROVN8VD5s6ArV0snTS6Zd/dTQQu91lZLh
	 i1WqXQ0u9AnxRugSAy0UwrKXKRWOKvjZ4ssAoTI/aq6r+B6+nmKjdpLaYEZLDKEPm4
	 KUZeZTFEXmZPW9xLb4DWSFkC4GO4TYxAQx5mtF2xHcFjg97gUnZ2sLrFKCeP5U2OXI
	 7zaoyH1jIGzGw==
Date: Thu, 14 Nov 2024 13:37:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: jiang.kun2@zte.com.cn
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn
Subject: Re: [PATCH linux 5.10] RDMA/restrack: Release MR/QP restrack when
 delete
Message-ID: <20241114113726.GD499069@unreal>
References: <202411141125595650lBfwAV8PE5HVMxAr96yl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411141125595650lBfwAV8PE5HVMxAr96yl@zte.com.cn>

On Thu, Nov 14, 2024 at 11:25:59AM +0800, jiang.kun2@zte.com.cn wrote:
> From: tuqiang <tu.qiang35@zte.com.cn>
> 
> The MR/QP restrack also needs to be released when delete it, otherwise it
> cause memory leak as the task struct won't be released.
> 
> Refer to commit dac153f2802d ("RDMA/restrack: Release MR restrack when delete").
> 
> Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> Signed-off-by: tuqiang <tu.qiang35@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/core/restrack.c | 2 --
>  1 file changed, 2 deletions(-)

This is not proper way to submit patches to stable@.
Please read and Documentation/process/stable-kernel-rules.rst

Thanks

> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index bbbbec5b1593..d5a69c4a1891 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -326,8 +326,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
>  	rt = &dev->res[res->type];
> 
>  	old = xa_erase(&rt->xa, res->id);
> -	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
> -		return;
>  	WARN_ON(old != res);
>  	res->valid = false;
> 
> -- 
> 2.18.4

