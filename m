Return-Path: <linux-rdma+bounces-6574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E09F493A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FA4189206B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCEA1EBFED;
	Tue, 17 Dec 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CkhRfWme"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE11EB9E8;
	Tue, 17 Dec 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432736; cv=none; b=Aqf7F/4hZsMP/Cy80052gaO2mnIBUxswt+cpjR9KMKqghntiWRgQkyTLWHYZ24cPFLoxSDtsjxE8+7kbJsrSgfmDEKA9AhHx8tBzFBHfpx6gRgspf5g/uIWM+dYIb4SpE00z70r/60VmHLe+oLg1zB7isNJgvegacyGcdALeBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432736; c=relaxed/simple;
	bh=ia3GvqxjT+P91CXaTlnsbjQPa35vnkH4Dgy4Hx/lhdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s22LVExVs7CYmscVL/4++IBdz2yRqNarj5EB9tKNg/wkPo7qvOahUJKtTC6rU0qN9bu/twS+s9/1dvRkDba/LO01DHMwzDRgIY54JeddFX5/ghZZ21Z3NAsqCuWPR6JDEgb6nncMjAGEm2Sykiuq7uYaAzxiNu3ALNSYjsYwY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CkhRfWme; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pKIaSLMgzRitaeQqeBKxAj8nc5TyrOFd+OEeRdGYXPE=; b=CkhRfWmeWxL/5x2HeV77SFNevT
	xWGadKHW6ILfP+HFgtZY4mAyhk4hUPYV3TrbmIEorvoe0uU3PvgqsQiQgEfXK+R0yFwly3kMrPR5E
	8xd8/6tYYfb9dvrA44DbPxuqGO1wIcIeu8R/MOTqh0waxkni6idzCvdtPIlbA49oBMR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNVBP-000vL6-UP; Tue, 17 Dec 2024 11:52:07 +0100
Date: Tue, 17 Dec 2024 11:52:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Avri Kehat <avri.kehat@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	ogabbay@kernel.org, oshpigelman@habana.ai, sgoutham@marvell.com,
	zyehudai@habana.ai
Subject: Re: [PATCH 06/15] net: hbl_cn: debugfs support
Message-ID: <ce20fa38-0949-47fe-8c2f-635f761479f1@lunn.ch>
References: <b40391d5-66d2-44be-bc83-4ac3b7bcfe08@lunn.ch>
 <20241217100039.79132-1-avri.kehat@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217100039.79132-1-avri.kehat@intel.com>

On Tue, Dec 17, 2024 at 12:00:39PM +0200, Avri Kehat wrote:
> Revisiting the comments regarding our use of debugfs as an interface for device configurations -
> A big part of the non-statistics debugfs parameters are HW related debug-only capabilities, and not configurations required by the user.
> Should these sort of parameters be part of devlink as well?
> Is there another location where debug related configurations for development can reside in?

There are a few options:

If the user does not require them, don't even implement them. If the
user is not using them, who is?

Implement them in an out of tree patch, which your development team
can use, since these are not user configuration options.

devlink is a possibility, but developers complain it is slow to get
them merged since we want to understand what the configuration option
does, why would i want to use it, would any other vendor have the same
need, and should it be made generic etc.

You could join those asking for fwctl, which is a contentious subject.

	Andrew

