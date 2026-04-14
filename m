Return-Path: <linux-rdma+bounces-19332-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP7EMnUa3mmFnAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19332-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 12:44:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C803F8E5C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 12:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4082D30FAA1A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB73D6CBA;
	Tue, 14 Apr 2026 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKPWgq5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C93D7D9E;
	Tue, 14 Apr 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162955; cv=none; b=IhjRXKZzxjEZ1dt5zD2qOoTYy3R4c2a9NlSMKDrDA7p1uIc1CvKQZtpnrAbP0wViFF2MDGr43t7qeXNUHn9ve2UxhyKt0tVqJYVCJcOO5tZTuErU+uLf75v7tx1eRG/wUseAvB/Mg8Zjk652yGtpnig5a2WCTywc2Nas+6ckEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162955; c=relaxed/simple;
	bh=SFNQ0GUXZDmko3umJzr38nltBojjjdV+yz2yRE036ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdADOrCscmrROw+Tl3h7gGZ0Ak637JZxJJNH13rGl+JLxqGyJSKSjul4cKtDudITEIEi47/tul8bMmZUO17bwvtHvH/xIw/c0uxPqa/QkVdMQRC9AWBMN0jr5KsyOetv3WCpPrQAemWgKQnoaToCQGABfKeJcB7cRBSQoEphZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKPWgq5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B61C19425;
	Tue, 14 Apr 2026 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776162954;
	bh=SFNQ0GUXZDmko3umJzr38nltBojjjdV+yz2yRE036ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKPWgq5yvXTwdm6Mn7ddnAlqSEEiLBiWHTaX5mT5aGATcja8JjLui6ZcqNanm6scd
	 CvXrq5dpTAh4lfYq1EVZUX4GCculXV6aUZ8B2O66uXnN4hL8M3IpV0q1QnBYf/Cgl2
	 uXmzZTnbW+Tg8K5+cr8iHrkx2+6e8RjuZe77W4iUy0UXTXGq+qIpq/A/xcKV1UjzsD
	 tSBo0NXcGq1hWol0n071OCMjHVTW3JNe8xQS1eQwar0Cs0wcpqFjwIeRuJfCLbea1B
	 MZfrvQ0InJkZRVLl5oIPVYvATc3jjlfrLG2y30pSPcM877QPNc8FyNTCL8ekqjzoew
	 0U2KV9PxBXr2w==
Date: Tue, 14 Apr 2026 13:35:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhiping Zhang <zhipingz@meta.com>
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414103547.GA361495@unreal>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19332-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77C803F8E5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 05:30:09PM +0800, fengchengwen wrote:
> On 4/14/2026 4:57 PM, Leon Romanovsky wrote:
> > On Tue, Apr 14, 2026 at 09:07:23AM +0800, fengchengwen wrote:
> >> On 4/14/2026 3:19 AM, Leon Romanovsky wrote:
> >>> On Mon, Apr 13, 2026 at 08:04:10PM +0800, fengchengwen wrote:
> >>>> On 4/13/2026 6:01 PM, Leon Romanovsky wrote:
> >>>>> On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> I'm writing to propose adding a sysfs interface to expose and configure the
> >>>>>> PCIe TPH
> >>>>>> Steering Tag for PCIe devices, which is retrieved inside the kernel.
> >>>>>>
> >>>>>>
> >>>>>> Background: The TPH Steering Tag is tightly coupled with both a PCIe device
> >>>>>> (identified
> >>>>>> by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
> >>>>>> user-space
> >>>>>> applications to fetch and set this value securely and conveniently, we need
> >>>>>> a standard
> >>>>>> kernel-to-user interface.
> >>>>>>
> >>>>>>
> >>>>>> Proposed Solution: Add several sysfs attributes under each PCIe device's
> >>>>>> sysfs directory:
> >>>>>> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
> >>>>>> device specific)
> >>>>>> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
> >>>>>> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
> >>>>>> operations, e.g.:
> >>>>>>    Read operation:
> >>>>>>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
> >>>>>>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
> >>>>>>    Write operation:
> >>>>>>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
> >>>>>>
> >>>>>>
> >>>>>> The design strictly follows PCI subsystem sysfs standards and has the
> >>>>>> following key properties:
> >>>>>>
> >>>>>> 1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
> >>>>>> devices that
> >>>>>>    support TPH Steering Tag. Devices without TPH capability will not show
> >>>>>> these nodes,
> >>>>>>    avoiding unnecessary user confusion.
> >>>>>>
> >>>>>> 2. Permission Control: The attributes will use 0600 file permissions,
> >>>>>> ensuring only
> >>>>>>    privileged root users can read or write them, which satisfies security
> >>>>>> requirements
> >>>>>>    for hardware configuration interfaces.
> >>>>>>
> >>>>>> 3. Standard Implementation Location: The interface will be implemented in
> >>>>>>    drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
> >>>>>> attributes,
> >>>>>>    ensuring consistency and maintainability within the PCI subsystem.
> >>>>>>
> >>>>>>
> >>>>>> Why sysfs instead of alternatives like VFIO-PCI ioctl:
> >>>>>>
> >>>>>> - Universality: sysfs does not require binding the device to a special
> >>>>>> driver such as
> >>>>>>   vfio-pci. It is available to any privileged user-space component,
> >>>>>> including system
> >>>>>>   utilities, daemons, and monitoring tools.
> >>>>>>
> >>>>>> - Simplicity: Both user-space usage (cat/echo) and kernel implementation are
> >>>>>>   straightforward, reducing code complexity and long-term maintenance cost.
> >>>>>>
> >>>>>> - Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
> >>>>>> specific to
> >>>>>>   user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
> >>>>>> kernel's
> >>>>>>   standard pattern for hardware capabilities.
> >>>>>>
> >>>>>>
> >>>>>> I look forward to your comments about this design before submitting the
> >>>>>> final patch.
> >>>>>
> >>>>> You need to explain more clearly why this write functionality is useful
> >>>>> and necessary outside the VFIO/RDMA context:
> >>>>> https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/
> >>>>>
> >>>>> AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
> >>>>> right ST values.
> >>>>>
> >>>>> There are several comments regarding the implementation, but those can wait
> >>>>> until the rationale behind the proposal is fully clarified.
> >>>>
> >>>> Thanks for your review and comments.
> >>>>
> >>>> Let me clarify the rationale behind this user-space sysfs interface:
> >>>>
> >>>> 1. VFIO is just one of the user-space device access frameworks.
> >>>>    There are many other in-kernel frameworks that expose devices
> >>>>    to user space, such as UIO, UACCE, etc., which may also require
> >>>>    TPH Steering Tag support.
> >>>>
> >>>> 2. The kernel can automatically program Steering Tags only when
> >>>>    the device provides a standard ST table in MSI-X or config space.
> >>>>    However, many devices implement vendor-specific or platform-specific
> >>>>    Steering Tag programming methods that cannot be fully handled
> >>>>    by the generic kernel code.
> >>>>
> >>>> 3. For such devices, user-space applications or framework drivers
> >>>>    need to retrieve and configure TPH Steering Tags directly.
> >>>>    A unified sysfs interface allows all user-space frameworks
> >>>>    (not just VFIO) to use a common, standard way to manage
> >>>>    TPH Steering Tags, rather than implementing duplicated logic
> >>>>    in each subsystem.
> >>>>
> >>>> This interface provides a uniform method for any user-space
> >>>> device access solution to work with TPH, which is why I believe
> >>>> it is useful and necessary beyond the VFIO/RDMA case.
> >>>
> >>> I understand the rationale for providing a read interface, for example for
> >>> debugging, but I do not see any justification for a write interface.
> >>
> >> Thank you for the comment!
> >>
> >> As I explained, read interface is not only for debugging. It was used to
> >> such device who don't declare ST location in MSI-X or config-space, the following
> >> is Intel X710 NIC device's lspci output (only TPH part):
> >>
> >> 	Capabilities: [1a0 v1] Transaction Processing Hints
> >> 		Device specific mode supported
> >> 		No steering table available
> >>
> >> So we could not config the ST for device on kernel because it's vendor specific.
> >> But we could configure ST by it's vendor user-space driver, in this case, we
> >> should get ST from kernel to user-space.
> > 
> > Vendor-specific, in the context of the PCI specification, does not mean the
> > kernel cannot configure it. It simply means that the ST values are not
> > stored in the ST table.
> 
> Thank you for the clarification!
> 
> I agree with your interpretation of "vendor-specific" in PCI spec terms—it
> does not prevent the kernel from handling TPH in principle. However, the
> real problem is that the kernel has no standardized way to know where or
> how to program those vendor-specific ST values.

No one here is opposed to you implementing the appropriate callbacks or
extending the existing in-kernel API to support a device‑specific mode.

> 
> When a device  reports "No steering table available" and operates in
> device-specific mode, the method used to set ST values is entirely
> device-specific and not covered by the PCI specification. If the device
> is taken over to user-space by UIO framework (e.g. VFIO or IGB_UIO), the
> generic kernel cannot infer the proper programming sequence or registers
> for each vendor-specific implementation.
> 
> In these cases, the configuration must be done by the vendor’s
> user-space driver, which is aware of the device’s private programming
> model. But such a user-space driver still needs to obtain valid,
> platform-provided ST values (from ACPI _DSM), which it cannot do
> without a kernel interface.

The objection applies to this point. The PCI device exists in kernel space,
and the kernel is responsible for managing its internal state.

> 
> This is why a read-only interface to retrieve ST values is still
> needed: the kernel holds the valid platform tags, while the user-space
> driver handles the device-specific programming.
> 
> Thanks
> 
> > 
> > Thanks
> 

