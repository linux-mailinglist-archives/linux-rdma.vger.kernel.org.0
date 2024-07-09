Return-Path: <linux-rdma+bounces-3767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C692B98F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 14:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F350F1C220C9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A6115A842;
	Tue,  9 Jul 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btCB88XE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933414EC41;
	Tue,  9 Jul 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528400; cv=none; b=RtYACBQiE4hcD2pWZbhoBvtWW9GxvK4IthUfvMlqWylfV9d5+XU8x4sQMYDx1L2PStpRYjzgJmvomNb02jGxHuGfJe5Jx+jPaRUKscToyoDL0//JKdedT88uqw9wBSySO/E1QwNk2t2tfOj++aPjkC7oON+cgYQWLUq+XLGr26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528400; c=relaxed/simple;
	bh=MPZMscC3wZUlcb/1vJzFlGz4ugVMJAHuXwVzs78cA8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNUMc+CHs4oylOB7xFY+87JEfPlgOwyzeOplMTeL2LsacTQVDMmq++Md2ZxHhTYNhMEYgEiogHPwLS7/QK5+/umxExKEpBXXPUvn2A51xJ5JBqgTREFfSvjqPCMUNFyBrvPRQt19+PkDTeVk/CjozVbGmlQIs06xlR4sXxFLk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btCB88XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2BAC4AF0C;
	Tue,  9 Jul 2024 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720528399;
	bh=MPZMscC3wZUlcb/1vJzFlGz4ugVMJAHuXwVzs78cA8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btCB88XEKyHVwFUk6kcXxnIG3vzKi6LL11ybZDx2MMssGswSZ6DXWDgLqP6/bGdfQ
	 PGEbHxhjpvvAXUvxKf7JnypmgeLGCnFAQs1ACMb7kL37e8iMAc6OJE89QqdL1xorVk
	 sQ2MNgUkCvnFMW4/5PBfLPVLxpv78iXOZ16nPudE=
Date: Tue, 9 Jul 2024 14:33:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <2024070933-commerce-duress-935a@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <2024070910-rumbling-unrigged-97ba@gregkh>
 <20240709122547.GC6668@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709122547.GC6668@unreal>

On Tue, Jul 09, 2024 at 03:25:47PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 09, 2024 at 12:01:06PM +0200, Greg KH wrote:
> > On Mon, Jul 08, 2024 at 03:26:43PM -0700, Dan Williams wrote:
> 
> <...>
> 
> > > It sets common expectations for
> > > device designers, distribution maintainers, and kernel developers. It is
> > > complimentary to the Linux-command path for operations that need deeper
> > > kernel coordination.
> > 
> > Yes, it's a good start, BUT by circumventing the network control plane,
> > the network driver maintainers rightfully are worried about this as
> > their review comments seem to be ignored here.  The rest of us
> > maintainers can't ignore that objection, sorry.
> 
> Can you please point to the TECHNICAL review comments that were
> presented and later ignored?

I can't remember review comments that were made yesterday, let alone
months ago, sorry.

greg k-h

