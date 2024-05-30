Return-Path: <linux-rdma+bounces-2703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D3C8D4E6B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1107B281FCA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1917C21D;
	Thu, 30 May 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufpMFp6j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131717C238;
	Thu, 30 May 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080652; cv=none; b=La8of/V3thUG/sUX3y9JAj5YJPl4UVCPdp4grVnJnYu59E4iacqhlohzbbz1wrAJKX+clKMOJVA0YrbTUetXx31RtTQZbEfLhmOln197qLnSAqJl5Nz9JTsDZbCsosRcuq3Ay98+zrxUslIK00FoxA19lFA9SKsy2k1by+co3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080652; c=relaxed/simple;
	bh=ptVE2mpxshQ1mWohEQL8CnF7b6yoSVtoowN2romLikw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY5WK8MseZxuzciwMYPzRJkhPSurVO1fQ6kucdzsWxMtZ6+iL4BnGrSlSPcgNN8lPdiSJ1+/FhEbUeaiyyvugtG8hwNfaRP0zP0MBC8Rgbg3s5GMGCzNQVet3+jHhAQUdThL8wg46XWpzWhlSpNU0wLItSIBMp11Hkbu4H5hU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufpMFp6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56791C2BBFC;
	Thu, 30 May 2024 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717080652;
	bh=ptVE2mpxshQ1mWohEQL8CnF7b6yoSVtoowN2romLikw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufpMFp6jDusVEA7GxOjfyHUbx3twzNhUdhftjp+SKlV57K1s8CFeSMrnhTcIdX6nT
	 FDZO0HRNKPwv9GMb/5FiW6C46UEjW2rZwLvmsaStKzizQMQqRsOC3thE+BgUu8iRp0
	 K8+jYjw/SENIXoI9mUzurgYzVS5es+fElE0y0Vp0=
Date: Thu, 30 May 2024 16:50:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drori <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v5 0/2] Introduce auxiliary bus IRQs sysfs
Message-ID: <2024053025-crusher-affiliate-d942@gregkh>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <2024052806-armadillo-mournful-6b23@gregkh>
 <3860d55b-d1d5-44b3-8089-aba93027dda5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3860d55b-d1d5-44b3-8089-aba93027dda5@nvidia.com>

On Wed, May 29, 2024 at 09:19:13AM +0300, Shay Drori wrote:
> 
> 
> On 28/05/2024 20:57, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, May 28, 2024 at 12:11:42PM +0300, Shay Drory wrote:
> > > Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
> > > IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files. PCI
> > > subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
> > > on the auxiliary bus. However, these PCI SFs lack such IRQ information
> > > on the auxiliary bus, leaving users without visibility into which IRQs
> > > are used by the SFs. This absence makes it impossible to debug
> > > situations and to understand the source of interrupts/SFs for
> > > performance tuning and debug.
> > 
> > Wait, again, this feels wrong.  You should be able to walk back up the
> > tree see the irq for the device, and vf, right?  Why would the value be
> > different down in the aux device?
> 
> 
> you are correct, the IRQs of the aux device are subset of the IRQs of
> the parent device. more detailed answer bellow.

But isn't that already shown in /proc/interrupts?  Why show it here as
well?

> > Does the msi irq somehow not actually show anywhere for the real pci device in sysfs at all today?
> > 
> > What does sysfs look like today exactly for this information?
> 
> 
> The IRQ information of all the children SFs of a PF is found in the PF
> device as one single list.
> There is no sane way to distinguish which IRQ is used by which SFs.
> For example, in a machine with a single child SF of the PF 00:0b.0 we
> currently have the bellow:
> $ ls /sys/bus/pci/devices/0000:00:0b.0/msi_irqs/
> 41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58
> 
> the above are IRQs of both the PF and its child SF. from here we cannot
> tell which IRQ is used by the child SF.

Does that matter?  Seriously, what is userspace going to do with that
that it can not already determine from /proc/interrupts/ or /proc/irq/?

I know it's /proc and not /sys but duplicating information might not be
needed as I think you already have this information.  If not, what is
missing in /proc/irq today for this?

> > And what about /proc/irq/ and /proc/interrupts/ doesn't that show you
> > the needed information?  Why are aux devices somehow "special" here?
> 
> 
> /proc/interrupts interrupt name is some random driver choice.

That's the same name you use here.

> There is
> no sane naming convention and some small few bytes of upper limit of
> what the IRQ name.

That's up to the driver to name, so wouldn't it be the same here?

> > > Additionally, the SFs are multifunctional devices supporting RDMA,
> > > network devices, clocks, and more, similar to their peer PCI PFs and
> > > VFs. Therefore, it is desirable to have SFs' IRQ information available
> > > at the bus/device level.
> > 
> > But it should be as part of the pci device, as that's where that
> > information lives and is "bound" to, not the aux device on its own.
> 
> 
> Auxiliary bus level SF device is using that IRQ too. So it is
> additionally shown at auxiliary device level too.

Your aux bus devices are using that, it's not generic to ALL aux bus
devices.  Along those lines, why not just put this info in the aux bus
devices that your driver is bound to?

> > > To overcome the above limitations, this short series extends the
> > > auxiliary bus to display IRQ information in sysfs, similar to that of
> > > PFs and VFs.
> > 
> > Again, examples of what it looks like today, and what it will look like
> > with this patch set is needed in order to justify why this really is
> > needed as it seems that the information should already be there for you.
> 
> 
> full example:
> in a machine with a single child SF of the PF 00:0b.0 we currently have
> the bellow:
> $ ls /sys/bus/pci/devices/0000:00:0b.0/msi_irqs/
> 41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58
> 
> with this patch-set we will also have:
> $ ls /sys/bus/pci/devices/0000\:00\:0b.0/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> which means that IRQs 50-58, which are shown on the PF "msi_irqs" are
> used by the child SF.

Please document this in the changelog if you wish to persist with it.

> > > It adds an 'irqs' directory under the auxiliary device and includes an
> > > <irq_num> sysfs file within it. Sometimes, the PCI SF auxiliary devices
> > > share the IRQ with other SFs, a detail that is also not available to the
> > > users. Consequently, this <irq_num> file indicates whether the IRQ is
> > > 'exclusive' or 'shared'.  This 'irqs' directory extenstion is optional,
> > > i.e. only for PCI SFs the sysfs irq information is optionally exposed.
> > 
> > Why does userspace care about "shared" or not?  What can they do with
> > that, and why?
> 
> 
> If IRQ is shared, userspace needs to take it into account when looking
> at IRQ data and counters such as interrupts/sec.
> Also, If IRQ is shared, user better not mess with the irq affinity of
> such irq it as it can affect multiple SFs.

But the logic of "shared" is at the irq level, not at the aux bus level.
That's where that should be shown, not in a random bus subsystem,
otherwise you would have to look across ALL busses to properly determine
if an irq is shared or not, right?

thanks,

greg k-h

