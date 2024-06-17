Return-Path: <linux-rdma+bounces-3200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3690AD48
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 13:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33BA1C22DA1
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCB194ADF;
	Mon, 17 Jun 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoW/inhH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BB1946BC;
	Mon, 17 Jun 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624904; cv=none; b=T37BaCb3uXcoKin2GM2fH6xKhJTYNxRzKsBquN7hdYXOnuk6x1dmeD1S4ppSwUonLC7QEzOcWoaTfEVUxP13pk8PWKZ65p+XC8rlR7aDy2DdlQ1TmCIlsdRsoaR8hzoRv9AzwrE/gOxyWLtsD0SmKYeila5ZUrTmfLHhcE2QK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624904; c=relaxed/simple;
	bh=8mrUC6mVjItynfICh+9jvCqG2bG3xJrYYmUAT7/n2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unyqdy9mPtvpUXA8iOnbWBMUVOg+9grMfPf0DfDe+WDKNwOfhKvoqJ3ihfjgJEuXP9hBIcxwMoqPSjsGuIYTdJVukEnmPhXMM4/LJvRWmejhOhGg1YuJSgW4rg7+PlLXhASYTwrI2H8k0fMKllC4RCSdwPisOi+ObttEh3ByCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoW/inhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE404C2BD10;
	Mon, 17 Jun 2024 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718624903;
	bh=8mrUC6mVjItynfICh+9jvCqG2bG3xJrYYmUAT7/n2IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoW/inhH3vClfVH+2Jv1vfwiBJ+oOejjBQaGAKozdbZyzVsQfT41G4jOgBGWGUmsE
	 I2TkMLU1k5TV2j5tsigmEtLKVypaS+VxXB16NtGzAMTHpqYXPe/qt2+AwSPBtcn8VP
	 ZTlDYratz4D87W7TTh3X5vk+mfQOhrXKFH/mIl0ngcJ5sOYMxUMMyas7hfcl0syk2u
	 FwQY1hlG6rcehnkHnslreqdRxOlnW198B37fcEmgNc6SB3VzA9Vb70dUnUEBpOjoX8
	 igGRNvt7TJUp3wOFU/ZTtWU7/fn17gsri4/VA00Vbqjyx2ueheGeLqfOeFno8YFV2P
	 3dWgY5OVm9vZA==
Date: Mon, 17 Jun 2024 14:48:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 01/15] net: hbl_cn: add habanalabs Core Network driver
Message-ID: <20240617114818.GB6805@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-2-oshpigelman@habana.ai>
 <a0e8f31e-fa12-4f48-853d-16c78bce1d76@intel.com>
 <83a6029e-1e45-4ce7-99bb-a3643ddbf8ab@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a6029e-1e45-4ce7-99bb-a3643ddbf8ab@habana.ai>

On Mon, Jun 17, 2024 at 08:08:26AM +0000, Omer Shpigelman wrote:
> On 6/13/24 16:01, Przemek Kitszel wrote:
> > [Some people who received this message don't often get email from przemyslaw.kitszel@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On 6/13/24 10:21, Omer Shpigelman wrote:
> >> Add the hbl_cn driver which will serve both Ethernet and InfiniBand
> >> drivers.
> >> hbl_cn is the layer which is used by the satellite drivers for many shared
> >> operations that are needed by both EN and IB subsystems like QPs, CQs etc.
> >> The CN driver is initialized via auxiliary bus by the habanalabs driver.
> >>
> >> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> >> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> >> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> >> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> >> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> >> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> >> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> >> Co-developed-by: David Meriin <dmeriin@habana.ai>
> >> Signed-off-by: David Meriin <dmeriin@habana.ai>
> >> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> >> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> >> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> >> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> >> ---
> >>   .../device_drivers/ethernet/index.rst         |    1 +
> >>   .../device_drivers/ethernet/intel/hbl.rst     |   82 +
> >>   MAINTAINERS                                   |   11 +
> >>   drivers/net/ethernet/intel/Kconfig            |   20 +
> >>   drivers/net/ethernet/intel/Makefile           |    1 +
> >>   drivers/net/ethernet/intel/hbl_cn/Makefile    |    9 +
> >>   .../net/ethernet/intel/hbl_cn/common/Makefile |    3 +
> >>   .../net/ethernet/intel/hbl_cn/common/hbl_cn.c | 5954 +++++++++++++++++
> >>   .../net/ethernet/intel/hbl_cn/common/hbl_cn.h | 1627 +++++
> >>   .../ethernet/intel/hbl_cn/common/hbl_cn_drv.c |  220 +
> >>   .../intel/hbl_cn/common/hbl_cn_memory.c       |   40 +
> >>   .../ethernet/intel/hbl_cn/common/hbl_cn_phy.c |   33 +
> >>   .../ethernet/intel/hbl_cn/common/hbl_cn_qp.c  |   13 +
> >>   include/linux/habanalabs/cpucp_if.h           |  125 +-
> >>   include/linux/habanalabs/hl_boot_if.h         |    9 +-
> >>   include/linux/net/intel/cn.h                  |  474 ++
> >>   include/linux/net/intel/cn_aux.h              |  298 +
> >>   include/linux/net/intel/cni.h                 |  636 ++
> >>   18 files changed, 9545 insertions(+), 11 deletions(-)
> >
> > this is a very big patch, it asks for a split; what's worse, it's
> > proportional to the size of this series:
> >  146 files changed, 148514 insertions(+), 70 deletions(-)
> > which is just too big
> >
> > [...]
> >
> 
> Yeah, well I'm limited to 15 patches per patch set according to the kernel
> doc so I had to have this big patch.
> Our changes are contained in 4 different drivers and all of the changes
> should be merged together so the HW will be operational.
> Hence I had to squeeze some code to a big patch.

Submit your code in multiple steps. One driver at a time.

Thanks

