Return-Path: <linux-rdma+bounces-10856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73073AC6F37
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 19:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ABC1888E9A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEC20102B;
	Wed, 28 May 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tikM35sT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34F1DE881
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453068; cv=none; b=FVrknAqJMHatCMQg5sU082AjevTvtW3uJe0VVLtpHIhp6bgOjWUkPotCHaV90YsX6VIIr9YboEFfjOALIHNdyvvg8iLBvtkLydZjDPdIZRVRZ39GuXV5RS4SO0YYQWOw0ovvB//pfLbl3UaxAZ8zkzBjudSEnKmTkPqMdLhLAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453068; c=relaxed/simple;
	bh=VyChyN7sCyPX3t5wg/RBTfD+9kZ8f7+CTYD5/Tc1KMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0b5OzIPNOf0aoUuWxgHBSLbeoCdkNVJt0iNLc3LTLf0Nq692tnMX1KanXXctfqa61Ja1hp6rwQ2mqvXAHkUlAI+qriVoJfdJO5DZkOFU17wUXgK8kSpLXdckX70rTIDf0tJud/qvqfgp8FLE1OycWkmUau2/6khhqWjCtnQjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tikM35sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969F4C4CEE3;
	Wed, 28 May 2025 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748453068;
	bh=VyChyN7sCyPX3t5wg/RBTfD+9kZ8f7+CTYD5/Tc1KMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tikM35sTuAfcTQZjtQGymInkuIS3b9IFYcSAkXLuo0lPUSIyhYTdFdXZpI8KAOPSL
	 jwB2Pg2xWqGMthGDUrl7IELXgt8JveohOdqPcD54kfIB98GEkw1CKzTEvZAXRtWfKn
	 FVFHP+Wd5Tw6rlSutjyovgx39RPP7zNZANWAwR30mEaJccf/F843fQP+7piXC5R/TS
	 zH4ZbETHaLKT0vgB5ld4dJmTIcTxjEt4Jni8dpMQJHgenhPgV0+CbTdFOXr1t1hDt3
	 lXt2XfG7xuEwGAHtd0MabDohE2SNNxyR9qFNLbzCqDi0sBZ0vwtYt1RAqJkO/YkAL1
	 YqcX6u/U+XoTw==
Date: Wed, 28 May 2025 20:24:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] Remove ancient qib driver
Message-ID: <20250528172423.GB7435@unreal>
References: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
 <20250528121132.GA7435@unreal>
 <a52bb580-4ebd-4e82-b584-a597483da862@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52bb580-4ebd-4e82-b584-a597483da862@cornelisnetworks.com>

On Wed, May 28, 2025 at 10:32:19AM -0400, Dennis Dalessandro wrote:
> On 5/28/25 8:11 AM, Leon Romanovsky wrote:
> > On Tue, May 27, 2025 at 11:46:02AM -0400, Dennis Dalessandro wrote:
> >> Time for qib to go bye-bye.
> > 
> > Thanks for doing this, it is too bad that you sent it during merge window.
> 
> No rush on this. I meant to send it a while back but kept getting preempted.
> 
> > BTW, can we get rid of rdmavt later too? Do you plan to reuse it?
> 
> We *could* wedge it back into hfi1 but I don't think that really gains us much
> and it will actually be expanded as we begin to add Ethernet/RoCE support which
> will be coming soon.

At least from my side, "rdmavt" removal is a nice to have, but definitely not must.

Thanks

> 
> -Denny
> 
> 

