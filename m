Return-Path: <linux-rdma+bounces-6013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1329CFE1E
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 11:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112B7B2BB65
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AD198841;
	Sat, 16 Nov 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w2R/8Fg7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A918A931;
	Sat, 16 Nov 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731752726; cv=none; b=GAhY0PqrC7rHgFw60zQrD2Zql1MoaZ0pZhsEmooSTJnwIjN++XVAPgJj6uhDBkZmfX15HRP9P8F4JGiQOAHOXT9YoL31E06ULNd4GA7/SuUZQfT3W+P32mv0+IvkhubMp2NtaYqQDQztwPvND/9bCd9D4s/PGZ42I78FFkE+odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731752726; c=relaxed/simple;
	bh=y5zEVIHRU1Ienk4jpIdcZKKYsZ5e8Z5k2u/HhcX4v3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvUPO9m45iWscSaZQVWzpI4cCMvXcBGzX3RUQqW9SYDLqIMkIRGXxWex9iuH94yOoq2VkjjDiyihZ0pGPuCjIkIpHrThTqBbvW3iUl6k0j3DiNRlRfzG4eD0ANIUijtgORq9s34ExPh2CR6c4GNUT2tCo54BW4Ryl9xLn5c9Tmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w2R/8Fg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7705AC4CEC3;
	Sat, 16 Nov 2024 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731752725;
	bh=y5zEVIHRU1Ienk4jpIdcZKKYsZ5e8Z5k2u/HhcX4v3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w2R/8Fg7SsnkucZfSpfDpzN9R/lTdlPiAramZR4UJcSjxeNIp8WAaghqH0fpxA+Dx
	 MzVxdEqJWyJINENrSEfqsfz1yqZXruBMHO86mB882KkrFOMIKD1NyuPmZMHY1DQoW0
	 EGoYy5LJNHzy+1Z7SoMZJklnZNm8iCCFH7SSaXdk=
Date: Sat, 16 Nov 2024 11:25:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jiang.kun2@zte.com.cn
Cc: dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn
Subject: Re: [PATCH STABLE 5.10] RDMA/restrack: Release MR/QP restrack when
 delete
Message-ID: <2024111642-backside-reach-7ec3@gregkh>
References: <20241116175748571awvOCFyR9lCLwe61IhOXL@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175748571awvOCFyR9lCLwe61IhOXL@zte.com.cn>

On Sat, Nov 16, 2024 at 05:57:48PM +0800, jiang.kun2@zte.com.cn wrote:
> From: tuqiang <tu.qiang35@zte.com.cn>
> 
> The MR/QP restrack also needs to be released when delete it, otherwise it
> cause memory leak as the task struct won't be released.
> 
> This problem has been fixed by the commit <dac153f2802d>
> ("RDMA/restrack: Release MR restrack when delete"), but still exists in the
> linux-5.10.y branch.

Why don't we just take the correct fix?  Why is this needed instead?

thanks,

greg k-h

