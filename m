Return-Path: <linux-rdma+bounces-1153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29E868ED0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1212B24CDA
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3C13959A;
	Tue, 27 Feb 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHOX5rpX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA91386C9;
	Tue, 27 Feb 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033412; cv=none; b=sNbKLKvn4TgeFFZiIyWsqwv90WaPwHyrAshXn9HC14e9zfAnPx7pZoTxpr9ND6kjgycmMWc5SXi+V0SpY7+tnXu60PxNMTmZXM/MJexDt8Jj6jS2RaqOMk7xkr0zTTZl8l1hqV05XM2AD/xXjPI91zDILiE5vE5nwt9dczaaa8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033412; c=relaxed/simple;
	bh=kdrZaX0aMKIkA+JGeMkKBVsvA05i0ftiJZuPnMvGgP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js4DIajju1KJZEHmVOziuy/WBDS/8RNC4nI2VEuCzyCv59vMzAR1Vzrz2rlUHl+iUXXMbf2TVkdKkUj16DTxftaWHW6nECIJ9Bal1bs2niydrCTRUW2cltTPjA7lRjlLHc+Ao+BUNhRPaMQlSlEYX3AMZF2OfDlp8S66Zf0mfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHOX5rpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D62BC433F1;
	Tue, 27 Feb 2024 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709033412;
	bh=kdrZaX0aMKIkA+JGeMkKBVsvA05i0ftiJZuPnMvGgP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHOX5rpX6BtMKfbOHHkQRkSOBZi6bLMMy0wao6khQStgIZm1d1qkcj1x7f+WTuxf2
	 t43rqIOoAYCXZXM+0z28Q5aPOzeDTgrDf9auFw17UX/gJPb0dNe+sW7vEtU+Bd2lCR
	 sUIzylUAVVqEdhvwpWRcUZ3y4swv8UWZVcbLz7ksl4blN9rGrURxyv44peMxBrf5FO
	 V8THu/sFza5RyopfTx/5+7sw2YjmKOR+/jdtWjQ+9WjUl4FnyIEOhk5DkrVl0WKV/H
	 LLJ89HcJ0hcwesqoGZqet+1jKymjr/gArdqFGkoz5ckIpfFcBNbSNwTkfUZQsiX0t6
	 MH2MMNrhR9Mog==
Date: Tue, 27 Feb 2024 13:30:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Message-ID: <20240227113007.GD1842804@unreal>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>

On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
> Hi,

<...>

> In order to create a good platform for a concrete and meaningful
> discussion at LSFMM 24, we plan to post an RFC within the next two weeks.

The code can be found here https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split

Thanks

> 
> Required Attendees list :-
> 
> Christoph Hellwig
> Jason Gunthorpe
> Jens Axboe
> Chuck Lever
> David Howells
> Keith Busch
> Bart Van Assche
> Damien Le Moal
> Martin Petersen
> 
> -ck
> 
> [1] 
> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
> 
> 
> 

