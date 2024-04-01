Return-Path: <linux-rdma+bounces-1713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603089449A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8E91C217B3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1CF4D9F2;
	Mon,  1 Apr 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra9z7+Mk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5A481C6;
	Mon,  1 Apr 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994430; cv=none; b=u4CbNzyus60IzBek3kyKdJDIZmwygevy1ngjNBL2EGXNchcCSsfXPZ/ukZsJRQJDoSpFiX+++vIP7XaYvPddU71ZqOc01CpVUqywKonhNZfVYV1ubyicJlCrzANqBrNdCFIt9cj3lpfAnnRJ7u6kCnpoMl7UUVgF34KhT5Lnd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994430; c=relaxed/simple;
	bh=KsJDpA4HqFHqybbFk4mMnc/KdyCUw208QlVKxgVl99E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVWI6wI5zXw5SN63rZKkOzPMrwfBd0H2kUMtRsR/6VhQu/JRAlBw6sSZY8H9o475hLlWdV0QLLehjtR+t1P27LeNm/hFLI6QChRp9oSInhKZkb5BAEPBhTDL/st3kqotdgG7KPwDkB3KM2odWd19WoiieQbjLFOAIJfpu2+J7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra9z7+Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB5C433F1;
	Mon,  1 Apr 2024 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711994430;
	bh=KsJDpA4HqFHqybbFk4mMnc/KdyCUw208QlVKxgVl99E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra9z7+MkqpOvjxcy1dF8N8W+Q+C2ZNIyTQ9oq8+Oh9AZ6Sz7FDGFThU1exMd6sK06
	 wxucqmeuuwOdhjyOYBLzF4Dbzv3R4nInpypgG1ULJNiAf/jj80hypRVEIQz2wk2+mo
	 fyI91SwA7btROWgGiBnQ81MKjgptDEJTWSETxXgjv0D61HrRA3L0LWokbpwt5XoIeD
	 YtQJont7ugiw7TOjmp9xipkKUKxfxnD+dd1eLPn0YW4KYw0V3VsANHjY4eosAvpPoe
	 StHr4ojfQcPKCSM3oEsCeMSUYLke9fUB7OnVA8r58/46z2Q3ONye4Mmxn98b3qfjpg
	 JSwEgDxGtlyYg==
Date: Mon, 1 Apr 2024 21:00:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240401180025.GA11187@unreal>
References: <20240319090944.2021309-1-leitao@debian.org>
 <20240401115331.GB73174@unreal>
 <20240401075306.0ce18627@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075306.0ce18627@kernel.org>

On Mon, Apr 01, 2024 at 07:53:06AM -0700, Jakub Kicinski wrote:
> On Mon, 1 Apr 2024 14:53:31 +0300 Leon Romanovsky wrote:
> > On Tue, Mar 19, 2024 at 02:09:43AM -0700, Breno Leitao wrote:
> > > Embedding net_device into structures prohibits the usage of flexible
> > > arrays in the net_device structure. For more details, see the discussion
> > > at [1].
> > > 
> > > Un-embed the net_device from struct hfi1_netdev_rx by converting it
> > > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > > net_device object at hfi1_alloc_rx().
> > > 
> > > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>  
> > 
> > Jakub,
> > 
> > I create shared branch for you, please pull it from:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=remove-dummy-netdev
> 
> Did you merge it in already?

I merged it into testing branch and dropped it now.

Thanks

