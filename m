Return-Path: <linux-rdma+bounces-8142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E2A45FB1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915EE3A3E85
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49408136349;
	Wed, 26 Feb 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvoPRg9+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B520DF4
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574058; cv=none; b=hO1j9aj2QCndefKQmtyz8WurHz2GXP/jPey8gIJ3Fg2e/NQQGm6WX95gks6v5mH/KL4Onclinqkt8Mo4ecwrCaqalZ85s69tWxptwcyANiKkDYdDnFdlFErpDDzp9DhWHkcGn6ZNBqrrkt5K47Fb4hF+wGRfToVho8LSyffQiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574058; c=relaxed/simple;
	bh=puobF/R8zDsp1iSScoESGmzJg+3IB5BF8b9K/IkGA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlhEmRBle6bIway2Wa1MDgBm4MGARPW0odh30ElhD2uA+RABPD1LLKPfIIOnzqy4nmXgibZqKbGWbXoS7vmf6jD5CAhETMXUYnpCWsj1TOALwhusikVgK0a05VVxpJMCt15ptSpL20gp9gx1z/UXYHjRTtFfq2X4c/hAr7YZXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvoPRg9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D102C4CED6;
	Wed, 26 Feb 2025 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574057;
	bh=puobF/R8zDsp1iSScoESGmzJg+3IB5BF8b9K/IkGA+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvoPRg9+uzietJIw62McEukSTAMrPmt+QKCHuTkAsCHWEVautRB24LUxCNhK7UHW+
	 k1sXOUmjxDQ+EwAaaM8UEF4L+ZOcl/J8RdgchpZHpuWN2u+ZPxTOTKm2LRjfqIAzuc
	 CHoq9lBrr1NVPmf6b0d+Ov+NATfWShJIxq072p7SfquinXj4tULdv4nUJfrG8WALxv
	 V20nnasuX+2xTanVQmGDQHIBf8QvwZb7Arg/Zdihm5+3hIwKxjeGl2x1KJDwqDiZi4
	 8dAFvbB2GB3k/KarCJeOmo831lwxNAjGwYFjcGrp02uhX29P32ItOqmOcpbtwQF4sn
	 I7pqkIeD2xf9Q==
Date: Wed, 26 Feb 2025 14:47:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250226124732.GJ53094@unreal>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220141059.GV3696814@ziepe.ca>
 <f5e1b589-d9a6-04c4-dffd-9aa3d2e77ab1@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e1b589-d9a6-04c4-dffd-9aa3d2e77ab1@hisilicon.com>

On Wed, Feb 26, 2025 at 05:46:12PM +0800, Junxian Huang wrote:
> 
> 
> On 2025/2/20 22:10, Jason Gunthorpe wrote:
> > On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
> > 
> >> Driver notifies HW about the memory release with mailbox. The procedure
> >> of a mailbox is:
> >> 	a) driver posts the mailbox to FW
> >> 	b) FW writes the mailbox data into HW
> >>
> >> In this scenario, step a) will fail due to the FW reset, HW won't get
> >> notified and thus may lead to UAF.
> > 
> > That's just wrong, a FW reset must fully stop and sanitize the HW as
> > well. You can't have HW running rouge with no way for FW to control it
> > anymore.
> > 
> 
> I agree, but there is a small time gap between the start of FW reset
> and the stop of HW. Please see my earlier reply today.

So stop HW before continuing FW reset.

Thanks

> 
> Thanks,
> Junxian
> 
> > Jason

