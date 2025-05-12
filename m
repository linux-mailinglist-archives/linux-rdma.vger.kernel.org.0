Return-Path: <linux-rdma+bounces-10301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546FAB35EF
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6AA189DD1F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2C277038;
	Mon, 12 May 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNBB0uOF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96B1AAE17;
	Mon, 12 May 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747049574; cv=none; b=KVqEe0hmPDMamx4TENspapxYuDfL9dT5TbiHHXqWY9xroZdHAIat8cXWG2fh9f/GwmsYM+YmCwuFtTZB0tm49Nz0HDT3oZz9R7KjowA/S1u0MxI7kCD2+UwJ+a420Xnyt0zcsIs1HARLZliCRc3aVK06sSSr/iS2Qa8UjZst+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747049574; c=relaxed/simple;
	bh=zOMLk73PSMsU04fU5LBHuwqBVTYpG5lILfgp7VOkvVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDSunRgSgSd1qfQXUq/dtCnFSQ9veV+UsyRLPdo4CIZ8ZSyDbPAbtOW5TAQP5HpGgz39lV+QCynk5C8a2EUj3IDJucxJ+q4H2TsEnSl/dHx8Svqwm1aLQt7GZ64oFnK7F0C4vw3FuVdviD/0lRSpT6Vrv7H7oyWqFLjqJBbL1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNBB0uOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC3C4CEE7;
	Mon, 12 May 2025 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747049574;
	bh=zOMLk73PSMsU04fU5LBHuwqBVTYpG5lILfgp7VOkvVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNBB0uOFTAdqwd931+tTSsSrx++vlKq5oeJkBA4JOwiKVcs5DKw9dU9QsA6ns4Pm2
	 OqPajNBWnTAQ/nfiY+LkoWY37anPg/11AkYCWCNwzR03FwoLowWdmcXAKT+7jJt7qe
	 57H0Zn1PO7gV2Absm0II561uqnQVuay0J56yDd01VX3AZd8PftXrCY2pB2//yOzWB+
	 g+oF+V5cXhy0ZN4VwlTHped+Cp7ct4Him5J6n7PEsjjsL0SvvJws/TypLk9ErKt6Ff
	 wDAuPACHq4AyhMvmaoIHzhmahqgItlso7zx21WYVYc63zudcdvMkf2jL4/jOzixbJ1
	 K2P21hqOoBOng==
Date: Mon, 12 May 2025 14:32:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
	kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH rdma-next v4 4/4] net: mana: Add support for auxiliary
 device servicing events
Message-ID: <20250512113248.GE22843@unreal>
References: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
 <1746633545-17653-5-git-send-email-kotaranov@linux.microsoft.com>
 <01f27ba0-6239-4195-beda-bc3fea1a30cf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f27ba0-6239-4195-beda-bc3fea1a30cf@oracle.com>

On Mon, May 12, 2025 at 10:59:43AM +0530, ALOK TIWARI wrote:
> 
> 
> On 07-05-2025 21:29, Konstantin Taranov wrote:
> > From: Shiraz Saleem <shirazsaleem@microsoft.com>
> > 
> > Handle soc servcing events which require the rdma auxiliary device resources to
> 
> typo servcing ->servicing

<...>

> > +		val = service_data.value;
> 
> what is use of val?
> 

<...>

> > +static void mana_handle_rdma_servicing(struct work_struct *work)
> 
> this name does not sound clearer and more aligned with typical naming
> conventions.
> Since it is an RDMA service event handler, it could be named to
> mana_rdma_service_handle. What are your thoughts on this?"

I fixed all these comments locally when applied the series.
Thank you for the review.

