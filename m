Return-Path: <linux-rdma+bounces-8709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D9A619A6
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C774616AB9E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FC204845;
	Fri, 14 Mar 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbgS9NGq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554B1519BB;
	Fri, 14 Mar 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977583; cv=none; b=C2vqYdXV0gNfW0d47SQXxts3pgaTe3jlsMeOpedELV2nfGsq5AaB05R+VuvTpddcBN5C99lB7tPMpqP2kk3yRgliwW6G7fybwzIG+l7w/LE0qEHVK+hFPaP8VdeRMEepq5tetnSQ+KDbJYbGM8+Rb9mRa88VgnS6GiNv38YtsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977583; c=relaxed/simple;
	bh=7zgCguAftdxNdNej2Op3CC4ec5C8VrxqTWVT3fgVgIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lanJMvb4ZSPa+vt+Kyb4qaIvBthwnFu5sN/pDTYx8ATxUdxjqMsF+D7pkvYCbmgNNsBufrEyuAykNmSsf/G8iMTUSiW+abjM0Ap7ERH5m34MKgAWki+fvMNbqH54z4KZBFboftCxwZz7qu4MIKFOd2JfxpjAg2IfTBbaQpUXWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbgS9NGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5548EC4CEE3;
	Fri, 14 Mar 2025 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741977582;
	bh=7zgCguAftdxNdNej2Op3CC4ec5C8VrxqTWVT3fgVgIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbgS9NGqN1xC7ev8qTLYsOBm/63Fb2yxIZ5wBeaQKsxS4X3du6COqd1Uro0XgRoyE
	 yDQHxrVL+RW9exEI8hYxtoD/oQbh8Trne23aNws7MV9L+7JhreEU5PTTZPhLa4WTp7
	 erugyyHCOgwXzMZtJOWKEEwe3FZ3iKZ3jxmXkOOeNkw8tJ9LFZO+/jA1frQdiyiTNw
	 SFuI+OhYZwrLeDe+24+D4zyc/OQUy9/datHtDZQxpvANyI3UWIWrR0S+M/Ou4Zd5Cl
	 7Y51K8xSkrNCskSVc9d0rhQZV4H1IHWzKTIX6+MwXnd1Lnu1mvELYP2VGjRM90+2yk
	 H2JcOh1ls0tKA==
Date: Fri, 14 Mar 2025 20:39:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250314183938.GQ1322339@unreal>
References: <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <2025031408-frequency-oxidant-287f@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031408-frequency-oxidant-287f@gregkh>

On Fri, Mar 14, 2025 at 06:37:11AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 13, 2025 at 12:59:16PM -0700, Nelson, Shannon wrote:
> > On 3/13/2025 5:48 AM, Leon Romanovsky wrote:
> > > On Thu, Mar 13, 2025 at 01:30:52PM +0100, David Ahern wrote:
> > 
> > 
> > > > So that means 3 different vendors and 3 different devices looking for a
> > > > similar auxbus based hierarchy with a core driver not buried within one
> > > > of the subsystems.
> > > > 
> > > > I guess at this point we just need to move forward with the proposal and
> > > > start sending patches.
> > > > 
> > > > Seems like drivers/core is the consensus for the core driver?
> > > 
> > > Yes, anything that is not aux_core is fine by me.
> > > 
> > > drivers/core or drivers/aux.
> > 
> > Between the two of these I prefer drivers/core - I don't want to see this
> > tied to aux for the same reasons we don't want it tied to pci or net.
> 
> Decades ago we tried to add drivers/core/ but I think tools really
> didn't like to see "core" as a directory name.  Hopefully you all don't
> run into that issue here as well :)
> 
> Anyway, if you all want me to run that tree as a "neutral" third-party,
> I'll be glad to do so.

Thanks for readiness, we will definitely be glad to see you on board.

Thanks

> 
> thanks,
> 
> greg k-h

