Return-Path: <linux-rdma+bounces-2993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286490045A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134A61C22BA7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AF1940B9;
	Fri,  7 Jun 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpkQ0Qu1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F85194093;
	Fri,  7 Jun 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717765964; cv=none; b=LQQyeY4TpwRXQ4aF49U751FTHvrmOoTpcgM18Djqv/6p1HurM3irMTNcOn+EOXARnR8D86NcG+28ptwFyiZWF4cJTnGy7w6SUbWKgHcmLGCSJPdP8FI3Iz6z0MRp11bR4N5zj9Ghsb1tRi1rjPImxi8Ep+rF3yeXDee3ghkOWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717765964; c=relaxed/simple;
	bh=rylabSzu0yYyi1X2s18EQkSMYt2TEokMK9Pw9zKgDUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmbrHSAmvnL+dQSeo/R5ksOy4QTpAM/ijZCMenlYqv7ExabkVw3sfZCrmU/sXBfmTtT8CaHR/zBgjh2zw4gswzGMvAFW/ub3xjzKu3BVWmj8eBNCvtusgOh5Ql2Cpv8YRvtlW1b9tQfK19+MPP5uZbeqyWiWoAOymZ8Un53M4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpkQ0Qu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA32C2BBFC;
	Fri,  7 Jun 2024 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717765963;
	bh=rylabSzu0yYyi1X2s18EQkSMYt2TEokMK9Pw9zKgDUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpkQ0Qu1JyafVZSOx6jiVmcGI8gLjw4vC1PitwTH2tvGUmHx/DrnAI9gcWO4wJwB7
	 +VBQVDOi9ga0CE/9OZVBBoFOdpCQRmLloNGr1R6e0Hppmo8B1UkCx5ZFbB+GMASJSi
	 sXtLirT7nIbLK4lUQ6opmT0uwiRLNo0srrnTq5g+0GfwafcC0wNDN2kBabLZLBXEjQ
	 BXa68v9b65NKWLZNDKyEfCEmaKdrmaSuccyr9g4udMGrAB7zGe7x4qoYW1hE4mbN1A
	 DQFrDQbE239GsB5vDkzzavPJubM3q9VbMX6WtAi+RAv3vvl6KSWOGDrLUseoPrSXlS
	 egpex+6HRQ9wQ==
Date: Fri, 7 Jun 2024 16:12:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240607131238.GI13732@unreal>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240606085033.GC13732@unreal>
 <66623409b2653_2177294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66623409b2653_2177294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Thu, Jun 06, 2024 at 03:11:21PM -0700, Dan Williams wrote:
> Leon Romanovsky wrote:
> > On Wed, Jun 05, 2024 at 09:56:14PM -0700, Dan Williams wrote:
> > > Jason Gunthorpe wrote:
> > 
> > <...>
> > 
> > > So my questions to try to understand the specific sticking points more
> > > are:
> > > 
> > > 1/ Can you think of a Command Effect that the device could enumerate to
> > > address the specific shenanigan's that netdev is worried about? In other
> > > words if every command a device enables has the stated effect of
> > > "Configuration Change after Reset" does that cut out a significant
> > > portion of the concern? 
> > 
> > It will prevent SR-IOV devices (or more accurate their VFs)
> > to be configured through the fwctl, as they are destroyed in HW
> > during reboot.
> 
> Right, but between zero configurability and losing live SR-IOV
> configurabilitiy is there still value?

For the users that are using SR-IOV, it is a big loss. It will require
from them to use two tools now instead of one.

My point is that we need to try and find best solution for the users
and not "compromise variant" that will make everyone unhappy.

Thanks

