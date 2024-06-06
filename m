Return-Path: <linux-rdma+bounces-2942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC68FE598
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F5E1F26288
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA441957F5;
	Thu,  6 Jun 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxluKUId"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2664D13D2A2;
	Thu,  6 Jun 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673976; cv=none; b=fWmmYRGPWKhWyXSrzJQIMm8iGvu2UsTJcdXT2O6BmrYYB1KYI3czDAq4HLfk6tttMmnAEeJX6LdXd34lBTO/vHGHCTlQQKiTFPiyTHSwsdauBa6GWkNjC9SHkN8FGzBrCXLuqvOYg5IQfPcdqa7zTYIGxoXFU+pH2BWERSWYUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673976; c=relaxed/simple;
	bh=p8wXrhQRix7YyGimgIgbUuipMII47I8TqUv3RdMezL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naU0BAQdXSj1gT/eZ0w1lZHuzU3SyobSxZWSLFB25RBeSY3PkF2T7pZGdnC3m02SGKJbBIRAmQC7mcvIo4ObUHqzhQ5dlAk3nNBLhVT7k+UHBvg9wNBLkKKKFbajn+FGxLxBSKCafkOUpgBZJ6DidOE/adOB/XJYdcVFFRvQR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxluKUId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270C8C32786;
	Thu,  6 Jun 2024 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717673975;
	bh=p8wXrhQRix7YyGimgIgbUuipMII47I8TqUv3RdMezL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxluKUId4GjYQC8dsW1AOb0RjdQbh1NXSyqlZtJoxvIcRyf14R+TlveN6Lcs1Uh2N
	 +Jzd2EU2gJmZhjJYNBARNqSGiDC4r474yF/rmdVZ5/0OgQlSIlQzfxQWshjkEVBacV
	 OVgPa1/3ZcRm7Oyi2eINvLeLpk1YVT2cwhKTRv61YLCU8CYSOEonRglAWUrh8schYj
	 nyM3MXWanslqZjSZoxi9KM9F9HaCruvI99/jgfNiF07F3BRfAIT0JQprGZkBfYzFxr
	 Y/98qm7aAd8nFtgRneD4B2OWDfjZRqb6okrLgZP4Xi4/AwOCR/37N17F2YeDbPJusX
	 ifVl1oZkRDmhw==
Date: Thu, 6 Jun 2024 14:39:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Message-ID: <20240606113931.GH13732@unreal>
References: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB307116D097353657259A7BB1CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
 <PAXPR83MB0559158B879C008258BC7B6AB4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559158B879C008258BC7B6AB4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Thu, Jun 06, 2024 at 08:30:06AM +0000, Konstantin Taranov wrote:
> > > Ignore optional ib_access_flags when an MR is created.
> > 
> > Can you add details on why this is needed?
> 
> Do you mean to the commit message?
> If we do not ignore these optional flags, the reg user mr fails because the next 2 lines:
> 	if (access_flags & ~VALID_MR_FLAGS)
> 		return ERR_PTR(-EINVAL);

I took this patch as is.

Thanks

