Return-Path: <linux-rdma+bounces-3205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5690AE18
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C2EB2202C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D0195F29;
	Mon, 17 Jun 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrp3m2CU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB0195B24
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627908; cv=none; b=Pm/p5cwn9SQj5BrhvHcXmOaxIpF2VRVgtKBAFaIto/OdEnobwp4wgCa401NXmKTkf6StWa2xgVTHRwShyiw+Spl6WqAI4Ezf/FnC2s0fB7CYeL06I80Ao4R1ZbLzSWGjNhxATGMwp+dSiWfaZZ/+gm9Dkzz0XS0APQ3MgjgZD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627908; c=relaxed/simple;
	bh=xu4tKGCg7a04A7Ita4bjmghv4ABn6gX+2ShDhiBtx6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7ihySYkz8Zd3Ql/+dbU1sf4/FRRwNXNzjqtM8JqwmXAs2abfktHD7piguFEjAQGM+WQLesFHjSs7ZisXxejnCXUxbDvNLEULwA/4mRtrqUCIDGGcJWzLVYLg9oRcTHIrpL6lvbak+wjYHuE4bl+HVONU1bM0fLNhYVwBIqVPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrp3m2CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661AAC4AF1C;
	Mon, 17 Jun 2024 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718627908;
	bh=xu4tKGCg7a04A7Ita4bjmghv4ABn6gX+2ShDhiBtx6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zrp3m2CUfz/Y/tA2GHFzW9smgpx5o3HKkpTVy7mdLyY9CoUR0sjjTwbR44jLPTHzM
	 eNJj6HN0ki5JmApNx4N44klS2qwrvEV/mddgtMQChybzw/cxzapYMP/dQYW/sYDfwN
	 TrkuS9g59l1BYW2g5hob3qSbSSosbK36BRTO+lkAgomlNjEC8FKVR1h2gQMPGxDegT
	 FeRDnOE9jtu4Qlnfq7ypi//Vakfkseak2aDCPtYEvaKfp6WRUU/VDjCf/XGOrWLCto
	 1YjFi90+LhxLCBAP09tpBv0YIcxOTLYd7ky+szO3KrFWf+LbV3lrgYXZFKYoNRTNqc
	 P8pEHtar/huMQ==
Date: Mon, 17 Jun 2024 15:38:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Open-coded get_netdev implementation in MANA IB
Message-ID: <20240617123824.GD6805@unreal>
References: <20240617115622.GC6805@unreal>
 <PAXPR83MB05592C30E6FEAE52F8B53E32B4CD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB05592C30E6FEAE52F8B53E32B4CD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Mon, Jun 17, 2024 at 12:11:50PM +0000, Konstantin Taranov wrote:
> > Hi,
> > 
> > I looked again on the patch 3b73eb3a4acd ("RDMA/mana_ib: Introduce
> > mana_ib_get_netdev helper function") and wonder if it is correct thing to do.
> > 
> > All new drivers shouldn't open-code get_netdev() and use the helpers
> > ib_device_get_netdev() and
> > ib_device_set_netdev() instead of storing netdev in the driver.
> > 
> > Can you please convert MANA IB driver to proper API usage?
> 
> Hi Leon,
> 
> This helper was introduced to remove a boiler plate code which was getting
> the netdev from gc->mana.driver_data. 

Yes, the thing is that probably we were supposed to move to
ib_device_get_netdev() and don't invest time in mana_ib_get_netdev()
helper at all.

> I sure can fix it and use ib_device_get_netdev api.
> 
> Should I send it to the rdma-next on the top of the latest commit?

Yes, please.

> 
> Thanks
> 
> > 
> > Thanks

