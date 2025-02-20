Return-Path: <linux-rdma+bounces-7887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE2A3D42F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 10:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844973B6661
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209151E9B00;
	Thu, 20 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLXPLMhH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D18BF8
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042541; cv=none; b=jVdyT0cyYW7/V9hBPEJTm/Ypf374QF+f16jE5Nh9gqZlgXGRMhetRR963bApemU41iEs8LWqh2JG2vEZjti52iiB4C4ti0QWuE6qJ0ASa4DMbW4pUwiigjEs5fq8iP4yw4frFILAejN4Y/XJ5JarrNsLuCTGM2ixebzWyvbOz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042541; c=relaxed/simple;
	bh=7H6tSuYYyEBtOYGUE4eISXFNwZyx+wbzG+JKSLRxL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGtxAp7rP2oSictev+8K9xYUe1QRmuyvjQXIMsxblRvXxdk1Kt2nT9mrZ6kIydxNmMfIUV1Lhl5hb4uEuLcFVjN0UI6cGlKnA7bAFSlcbu4yYnl3os1l8je1Y91doiorMu4Q8jbWnHfFh/UoZ0wsTkHetCuwbi39/b5mIDHtMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLXPLMhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B3BC4CED1;
	Thu, 20 Feb 2025 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740042541;
	bh=7H6tSuYYyEBtOYGUE4eISXFNwZyx+wbzG+JKSLRxL2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLXPLMhHeF0uGxybleS/35Gi3TdTo8g32rbHwAAwzBB2o62rIz4P2tMWExBSnbuBI
	 ZUc5wij6evk8Y5dAEslrXKrDx74E4t22NLBEdmNwTM1Nc3DJqJTWIZz7reu2KWToaP
	 tQaTlRQEXterlT1JjWnJPo5X/4tOcaDnaQeOizu5eF5qEjIQC9mSzXwtiMPawOLSd4
	 poKeosmf9J3VMsmhYUvu8B/DF59pk72jzJ8bxmt3ylwk092GiPN75zGiFRcXXiH1az
	 sPCIoQAIYkekC9u17xadvQphOFE55M5nPQDeBS/0yRcJGjGUPU7rQoRZidZxLAmyzd
	 Hf1nUWZ9VUXKQ==
Date: Thu, 20 Feb 2025 11:08:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250220090856.GO53094@unreal>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220073217.GM53094@unreal>
 <bdc9cae7-4d8c-4294-18a5-687e9b7edac8@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc9cae7-4d8c-4294-18a5-687e9b7edac8@hisilicon.com>

On Thu, Feb 20, 2025 at 04:45:54PM +0800, Junxian Huang wrote:
> 
> 
> On 2025/2/20 15:32, Leon Romanovsky wrote:
> > On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2025/2/19 22:35, Leon Romanovsky wrote:
> >>> On Wed, Feb 19, 2025 at 09:07:36PM +0800, Junxian Huang wrote:
> >>>>
> >>>>
> >>>> On 2025/2/19 20:14, Leon Romanovsky wrote:
> >>>>> On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
> >>>>>> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
> >>>>>> to notify HW about the destruction. In this case, driver will still
> >>>>>> free the resources, while HW may still access them, thus leading to
> >>>>>> a UAF.
> >>>>>
> >>>>>> This series introduces delay-destruction mechanism to fix such HW UAF,
> >>>>>> including thw HW CTX and doorbells.
> >>>>>
> >>>>> And why can't you fix FW instead?
> >>>>>
> >>>>
> >>>> The key is the failure of mailbox, and there are some cases that would
> >>>> lead to it, which we don't really consider as FW bugs.
> >>>>
> >>>> For example, when some random fatal error like RAS error occurs in FW,
> >>>> our FW will be reset. Driver's mailbox will fail during the FW reset.
> >>>
> >>> I don't understand this scenario. You said at the beginning that HW can
> >>> access host memory and this triggers UAF. However now, you are presenting 
> >>> case where driver tries to access mailbox.
> >>>
> >>
> >> No, I'm saying that mailbox errors are the reason of HW UAF. Let me
> >> explain this scenario in more detail.
> >>
> >> Driver notifies HW about the memory release with mailbox. The procedure
> >> of a mailbox is:
> >> 	a) driver posts the mailbox to FW
> >> 	b) FW writes the mailbox data into HW
> >>
> >> In this scenario, step a) will fail due to the FW reset, HW won't get
> >> notified and thus may lead to UAF.
> > 
> > Exactly, FW performed reset and didn't prevent from HW to access it.
> > 
> 
> Yes, but the problem is that our HW doesn't provide a method to prevent
> the access. There's nothing FW can do in this scenario, so we can only
> prevent UAF by adding these codes in driver.

Somehow HW doesn't access mailbox if destroy was successful, so why
can't FW use same "method" to inform HW before reset?

Thanks

