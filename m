Return-Path: <linux-rdma+bounces-4260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3994C9A9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 07:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7457BB22B9A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 05:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88816C68D;
	Fri,  9 Aug 2024 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ja+Tlyoq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FD17BBE;
	Fri,  9 Aug 2024 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723181874; cv=none; b=jFxxIrKS7c2TqeEpYUCIZlYhkmvdMd7RJauJEqiuFUL3AsHX4IOaOxRsXCvuCydsuE+gUCws3VkJTm9Zdo+OOWNFPP0O9W1tdzEC+2JeP+0vFDgDcVGWxOxysEq5jKJG7klsoev93YLSTjcWhYnx3q1+GuImX2e9WkxoNTXEbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723181874; c=relaxed/simple;
	bh=lOZtihui0k4mla/fwJ1SNSDDA5JTGeFOJpE/zRPr7lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Suqifntg7j3mchvTvB+9/eUm931N5XADPkMp/iqX+oz5vYjQVljwP+Ls+bCEEt2HtuloiEcr5fGUVov2Af8g2lUHgVXmk2tBnC/F+7YLTkzIWk/rnA+yNrIYiqWR9G1vgnuPL1qkUJo/8VoABTItfvySL/Uq07qP5t9v0L2itO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ja+Tlyoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4CEC32782;
	Fri,  9 Aug 2024 05:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723181874;
	bh=lOZtihui0k4mla/fwJ1SNSDDA5JTGeFOJpE/zRPr7lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ja+TlyoqL0I/er2EtwIN4JTQMRt46xrIy6SHLUTkaWucveylKEtv6fCgp0QsIIu5S
	 uW4JUdOXIRUDPwYg4E+zaaRKkDuEvZ5QX7qgMMmCVmTFai624T1WvUNvhtA7Nd6oXm
	 UqGTQUWNWrx4jf4K3Y5ja+D4LIc6uc/g6u9n6F30=
Date: Fri, 9 Aug 2024 07:37:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 1/4] kernfs: add a WARN_ON_ONCE if ->close is set
Message-ID: <2024080933-jazz-supernova-9f3a@gregkh>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808183340.483468-2-martin.oliveira@eideticom.com>

On Thu, Aug 08, 2024 at 12:33:37PM -0600, Martin Oliveira wrote:
> The next patch is going to remove .page_mkwrite from kernfs and will
> WARN if an mmap implementation sets .page_mkwrite.
> 
> In preparation for that change, and to make it consistent, add a WARN to
> the ->close check.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> ---
>  fs/kernfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 8502ef68459b..72cc51dcf870 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -479,7 +479,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  	 * It is not possible to successfully wrap close.
>  	 * So error if someone is trying to use close.
>  	 */
> -	if (vma->vm_ops && vma->vm_ops->close)
> +	if (WARN_ON_ONCE(vma->vm_ops && vma->vm_ops->close))

So you just rebooted a machine that hits this, loosing data everywhere.
Not nice :(


