Return-Path: <linux-rdma+bounces-3763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D4392B494
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1141C21E53
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEEC155759;
	Tue,  9 Jul 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wca/OejK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CD149C79;
	Tue,  9 Jul 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519269; cv=none; b=CIP1stV+1Robn6f6zfDCXGqTx2DTxx6d+Mrpjla/nZHA5hch1y/T8YWRdBaKyroVQ8AQyzEDuSN2Nqvr5KBe/lDpSIX2nUUWyWFBX2FaOYZMZZ/JRyQFXm7WUd1WzrY6R5e5c0T/xRZ2Tstcm9Avt89m/xAzpGm44Duo3QkXN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519269; c=relaxed/simple;
	bh=ui8XHzfOQJ8J4zxO9mnLpxuTi3HJgK//7LeJrv4Io0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmyqCWST6o9fC2JZsp7JRKArp+VWTEtOKQK+f4U5k5bcIO7UbXLlfnbNi7OshTjaMIj4zh+yiZJaFNIRmUB8g8l/x3l8qXAk/UfN/VumY//juqAWkNzfeUGyvIsXoGC448RBP9qxqWnJZPsVFx0DXXL5H/O05WIeGg2sqx9A390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wca/OejK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77256C3277B;
	Tue,  9 Jul 2024 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720519268;
	bh=ui8XHzfOQJ8J4zxO9mnLpxuTi3HJgK//7LeJrv4Io0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wca/OejKLoc2PQwILBcdNGYrfLZ3cxvnQYN6dtC5HXPgrG9UZVNOcwL/rVckQvvOL
	 mNlyD+2T9/ZvyQIRioEUoZZFoF2uzysmsxh6DdJJzSisyX7/NaJfPAGbUHsXBbR1uj
	 TY6hAhb/SkaZe4z/UVCZNfN59EiJh6Hv0FycLP5A=
Date: Tue, 9 Jul 2024 12:01:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <2024070910-rumbling-unrigged-97ba@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Jul 08, 2024 at 03:26:43PM -0700, Dan Williams wrote:
> Enter the fwctl proposal [1]. From the CXL subsystem perspective it
> looks like a long-term solution to the problem of managing expectations
> between hardware vendors and mainline subsystems. It disclaims support
> for the fast-path (data-plane) and is targeted at the long tail of
> slow-path (config/debug plane) device-specific operations that are often
> uninteresting to mainline.

That's not true at all, device-specific operations are very interesting
to mainline, and I would argue that the "slow-path" is the most
important thing for the kernel to manage as that is where the security
and unification layers can be properly enforced.

Vendors that think the control plane should just be allowed to be
accessed by userspace "blindly" are not saying outloud that they just
want to circumvent the security layer entirely like they previously were
doing by directly accessing /dev/mem which is one of the strongest
reasons to keep enforcing this through the kernel as Christoph points
out.

It's the cumulation of multiple vendors of semi-alike config paths that
allow us to standardize them to provide the most important thing of all,
a unified view to userspace where a user does not care about what type
of hardware is running, which is really the goal of Linux as well, but
directly goes against what a vendor wants to have happen.

> It sets expectations that the device must
> advertise the effect of all commands so that the kernel can deploy
> reasonable Kernel Lockdown policy, or otherwise require CAP_SYS_RAWIO
> for commands that may affect user-data.

Yes, this is a good start, but it might still be too "vendor-specific"
at this point in time.

> It sets common expectations for
> device designers, distribution maintainers, and kernel developers. It is
> complimentary to the Linux-command path for operations that need deeper
> kernel coordination.

Yes, it's a good start, BUT by circumventing the network control plane,
the network driver maintainers rightfully are worried about this as
their review comments seem to be ignored here.  The rest of us
maintainers can't ignore that objection, sorry.

> The upstream discussion has yielded the full spectrum of positions on
> device specific functionality, and it is a topic that needs cross-kernel
> consensus as hardware increasingly spans cross-subsystem concerns.
> Please consider it for a Maintainers Summit discussion.

SHould be a fun discussion, thanks for proposing this.

greg k-h

