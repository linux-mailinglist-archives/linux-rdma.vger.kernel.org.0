Return-Path: <linux-rdma+bounces-2637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AB8D22DC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 19:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79671F24AE6
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4545C07;
	Tue, 28 May 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IvMn314Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551C48781;
	Tue, 28 May 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919038; cv=none; b=Dc/hIM4fuEdkuVzI8U7IlKbd0bHqhlo3r9Jn+P5tO150zTP+R3Mcj9BushBSZpD1YHhemtSiBhsvqB/xPz4rLwKCLO3rb1gjCgYy8xGIkpagYyHGs0HDMz1ZLeUEe1gj2Z0Y0JFnGl0CCP8Ao+KM2TukVettqWBjqhEW6vhneYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919038; c=relaxed/simple;
	bh=UElZkq4qpCK3zCVRc9jcd5OyfnQZO4JqaDi62I4WnCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV60/mAht673CQbM7Op5mXOvGjqYVMyrkoGLO/9MisFurbK7U+nvZmwnEAtV+RXOPUh5c5pBeGj9ecJiGBENCs4QBZwO8JCGDfElCS5iede+s6aoJOQvtB3RrkSx/GzgnYESbGIf0bwvhgLIVDntzXSrDZpcXqfTqEqcy+Ot/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IvMn314Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E9C3277B;
	Tue, 28 May 2024 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716919038;
	bh=UElZkq4qpCK3zCVRc9jcd5OyfnQZO4JqaDi62I4WnCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvMn314Qln82wrUv3HDPSK2V81ZLxf3kUcFpYYXnlCfHRczm+0cRVlw1cyfZ+CKgw
	 52iLC+vBKdjki5740l3YNVatv6byjLre+TbCxC1a9HrAaoysMKZ6eY3xuOJLCfZSyt
	 7fe2mHJSXhckADrCnchfGdJd/Z3QCc22t8g6aXcs=
Date: Tue, 28 May 2024 19:57:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v5 0/2] Introduce auxiliary bus IRQs sysfs
Message-ID: <2024052806-armadillo-mournful-6b23@gregkh>
References: <20240528091144.112829-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528091144.112829-1-shayd@nvidia.com>

On Tue, May 28, 2024 at 12:11:42PM +0300, Shay Drory wrote:
> Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
> IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files. PCI
> subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
> on the auxiliary bus. However, these PCI SFs lack such IRQ information
> on the auxiliary bus, leaving users without visibility into which IRQs
> are used by the SFs. This absence makes it impossible to debug
> situations and to understand the source of interrupts/SFs for
> performance tuning and debug.

Wait, again, this feels wrong.  You should be able to walk back up the
tree see the irq for the device, and vf, right?  Why would the value be
different down in the aux device?  Does the msi irq somehow not actually
show anywhere for the real pci device in sysfs at all today?

What does sysfs look like today exactly for this information?

And what about /proc/irq/ and /proc/interrupts/ doesn't that show you
the needed information?  Why are aux devices somehow "special" here?

> Additionally, the SFs are multifunctional devices supporting RDMA,
> network devices, clocks, and more, similar to their peer PCI PFs and
> VFs. Therefore, it is desirable to have SFs' IRQ information available
> at the bus/device level.

But it should be as part of the pci device, as that's where that
information lives and is "bound" to, not the aux device on its own.

> To overcome the above limitations, this short series extends the
> auxiliary bus to display IRQ information in sysfs, similar to that of
> PFs and VFs.

Again, examples of what it looks like today, and what it will look like
with this patch set is needed in order to justify why this really is
needed as it seems that the information should already be there for you.

> It adds an 'irqs' directory under the auxiliary device and includes an
> <irq_num> sysfs file within it. Sometimes, the PCI SF auxiliary devices
> share the IRQ with other SFs, a detail that is also not available to the
> users. Consequently, this <irq_num> file indicates whether the IRQ is
> 'exclusive' or 'shared'.  This 'irqs' directory extenstion is optional,
> i.e. only for PCI SFs the sysfs irq information is optionally exposed.

Why does userspace care about "shared" or not?  What can they do with
that, and why?

> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
> exclusive

"exclusive" for now, but again, why?  Who cares?  These are msi irqs it
shouldn't matter if they are shared or not.

thanks,

greg k-h

