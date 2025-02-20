Return-Path: <linux-rdma+bounces-7882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F38A3D262
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 08:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62383AAB05
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74221E5B7A;
	Thu, 20 Feb 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+5TUdJb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C02249F9
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036742; cv=none; b=Ppg1/W8M0tC36ronTzSZvLd9cI7CBnQqyAqR9I6VOZJBaP2VoLTgu3T0+croiTfhEpimqf2Sv+Mk1+PRI9fwlK+34jbuN/c50uq6PBEn4iaz4oIX4MD3dkz1kIoDvzGzVcGL8WFHM/WqibmSqrl4rW5nuYusUInYHOpVznhzTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036742; c=relaxed/simple;
	bh=CKkXNJbQLMnOWGJhi7GVX/0OqGhdRkTVKUxZWzOmEcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuIZUmnronru9bxMhO4mEYx3UWF3ylBPNgdPoHb/5tvwFH0efu4TAgS/L/1L7EqNvpZhjCTndoNb/zyPnv6nK4rpGxMhXFynsPDCMQ5FzoTmEzEcBqAxnYfbGSppJBw6Fe+b/utTZTGLyIyeaxFr6hR4I+792iISHduTn91TNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+5TUdJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32869C4CED1;
	Thu, 20 Feb 2025 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740036742;
	bh=CKkXNJbQLMnOWGJhi7GVX/0OqGhdRkTVKUxZWzOmEcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+5TUdJbZiKAo7ZfQu4TmpQIwvrpHTgw5PzXCljELV6mBPRyqI4nofW6Nan/cQawy
	 z7WzJ/FGTydqPh27JC5Qt654cTlETS8UEWtpFAc1+zol0LTWJ3uYr8KaC7AStGIc96
	 H8MOdoRm6FebZlwwDeDAoV2E0DosU281jJEwt1xUxMsZebQVkSb0N8U6b3cL96ygkY
	 M6eJkYDEwpo5KS9MLv21hW2isGto+bKsAgE4Hcj+vhPgVDoFdqg1+wK32+wyE/dgJ1
	 LajlU6hFpwWfzT+iEkN61sbr84I3F5IYa9kGA2oPYq+kcIUWKajXonnpusl2BPDxAV
	 9FyN/DfNZ9oJw==
Date: Thu, 20 Feb 2025 09:32:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250220073217.GM53094@unreal>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>

On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
> 
> 
> On 2025/2/19 22:35, Leon Romanovsky wrote:
> > On Wed, Feb 19, 2025 at 09:07:36PM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2025/2/19 20:14, Leon Romanovsky wrote:
> >>> On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
> >>>> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
> >>>> to notify HW about the destruction. In this case, driver will still
> >>>> free the resources, while HW may still access them, thus leading to
> >>>> a UAF.
> >>>
> >>>> This series introduces delay-destruction mechanism to fix such HW UAF,
> >>>> including thw HW CTX and doorbells.
> >>>
> >>> And why can't you fix FW instead?
> >>>
> >>
> >> The key is the failure of mailbox, and there are some cases that would
> >> lead to it, which we don't really consider as FW bugs.
> >>
> >> For example, when some random fatal error like RAS error occurs in FW,
> >> our FW will be reset. Driver's mailbox will fail during the FW reset.
> > 
> > I don't understand this scenario. You said at the beginning that HW can
> > access host memory and this triggers UAF. However now, you are presenting 
> > case where driver tries to access mailbox.
> > 
> 
> No, I'm saying that mailbox errors are the reason of HW UAF. Let me
> explain this scenario in more detail.
> 
> Driver notifies HW about the memory release with mailbox. The procedure
> of a mailbox is:
> 	a) driver posts the mailbox to FW
> 	b) FW writes the mailbox data into HW
> 
> In this scenario, step a) will fail due to the FW reset, HW won't get
> notified and thus may lead to UAF.

Exactly, FW performed reset and didn't prevent from HW to access it.

Thanks

> 
> Junxian
> 
> >>
> >> Another case is the mailbox timeout when FW is under heavy load, as it is
> >> shared by multi-functions.
> > 
> > It is not different from any other mailbox errors. FW needs to handle
> > these cases.
> > 
> > Thanks
> > 
> >>
> >> Thanks,
> >> Junxian
> >>
> >>> Thanks

