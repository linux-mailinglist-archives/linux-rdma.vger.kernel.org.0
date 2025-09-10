Return-Path: <linux-rdma+bounces-13232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0FB513C9
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B67B555E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535C22154B;
	Wed, 10 Sep 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDRZruSh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3592DCF55;
	Wed, 10 Sep 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499780; cv=none; b=mpv1pfnEc9I4RcLxyBYjewS+At6RqyHo7YHynp4RKhLDlMiVwLP3uNU2IyOrtgImFRUzqDbLaE3EbVQ0RancubKB2pDtUaPfG8ORlORQxCIwJ/yj7+3K7saK9MGtHJlLGfLAuE4gLnd8wpCqe1BQyeKFd59mxeSiSrmM04p7AtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499780; c=relaxed/simple;
	bh=cci8FBP5oFeYz9yLMjoMZ35yzN03vgg0F6ebk7eIsi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPi6lwD/BvHSIbHLV+HZFAJMZTGMDm1i2ZSKIiawlGuWv4BJcnNOr3xOXlG/9NYvvCh7mKng//g1AlBXmmrL9T26dfizME3cnGAdHSEh6RisomR+X7ANxxcI40OADW6kCQtB/Q6aqwR1KlsqcZqtgDnrHd4Kxw+KfeVadFfzWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDRZruSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82E9C4CEF0;
	Wed, 10 Sep 2025 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757499779;
	bh=cci8FBP5oFeYz9yLMjoMZ35yzN03vgg0F6ebk7eIsi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDRZruShKjhHZoJTXNHXIYfOcRr1DoZVXqSQxslDqsRXN/1YwAvtuyEsVja1lJYuq
	 EC4gCJuHob8Imo2oOEST5R1EaMTvmWILH76C8wMPwv3ur+y1yyjqlUD5cSQjSZUnpw
	 0f6RooPWUGACQFQBsSPIC++msWkNT91fczeelOq6s1bZVhHlj0hrTVDqVJpQllDzpH
	 mYLb2EaA5ZUNJoAffUt9JTiU+7M/XoVyUcXmQLwoRo9/J7y/lLZDcFoa4SEQm/mq6/
	 U27d3bsjAXnBl+dbPWjbKqg8dLtziXc2VKAWwpSOLtxGmyXkVQAL+rfp4x484SNRlA
	 Zrqhvh8ICN9gg==
Date: Wed, 10 Sep 2025 13:22:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, brett.creeley@amd.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
	andrew+netdev@lunn.ch, sln@onemain.com, allen.hubbe@amd.com,
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [External] : [PATCH v6 10/14] RDMA/ionic: Register device ops
 for control path
Message-ID: <20250910102254.GO341237@unreal>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
 <20250903061606.4139957-11-abhijit.gangurde@amd.com>
 <98538e34-c329-4785-8380-7932a284a515@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98538e34-c329-4785-8380-7932a284a515@oracle.com>

On Tue, Sep 09, 2025 at 07:37:32PM +0530, ALOK TIWARI wrote:
> 
> 
> On 9/3/2025 11:46 AM, Abhijit Gangurde wrote:
> > +/* admin queue v1 opcodes */
> > +enum ionic_v1_admin_op {
> > +	IONIC_V1_ADMIN_NOOP,
> > +	IONIC_V1_ADMIN_CREATE_CQ,
> > +	IONIC_V1_ADMIN_CREATE_QP,
> > +	IONIC_V1_ADMIN_CREATE_MR,
> > +	IONIC_V1_ADMIN_STATS_HDRS,
> > +	IONIC_V1_ADMIN_STATS_VALS,
> > +	IONIC_V1_ADMIN_DESTROY_MR,
> > +	IONIC_v1_ADMIN_RSVD_7,		/* RESIZE_CQ */
> 
> typo IONIC_v1_ADMIN_RSVD_7 -> IONIC_V1_ADMIN_RSVD_7

I fixed it locally

Thanks

> 
> > +	IONIC_V1_ADMIN_DESTROY_CQ,
> > +	IONIC_V1_ADMIN_MODIFY_QP,
> > +	IONIC_V1_ADMIN_QUERY_QP,
> > +	IONIC_V1_ADMIN_DESTROY_QP,
> > +	IONIC_V1_ADMIN_DEBUG,
> > +	IONIC_V1_ADMIN_CREATE_AH,
> 
> 
> Thanks,
> Alok

