Return-Path: <linux-rdma+bounces-19278-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP79FN6/3Gn5VwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19278-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:05:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE53EA2CF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88391300A3B0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910813AE1B1;
	Mon, 13 Apr 2026 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEQIE6k0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4D21D3D6;
	Mon, 13 Apr 2026 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074517; cv=none; b=Yrzv1WVEDJNO/pmwblf2aGu3zvrNwBebCqzA7PREn0/S0GHsPmUg1MvP5iWFsNJFQKfT6jw8fqtBiVNcnJE4Udi8GKRTxzRg2ybVvn30WO7cKqlXMb94LDR6Eu1SNFzGN9MLR/o7JxMfTEdNO+QW1JYonPSoJEoSarMTY+8aTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074517; c=relaxed/simple;
	bh=mlzyEmNbjtIL7vKwRnpEy6oi+2Tn09KmOp9o8MEUcZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnehmNwgjPMo1Wxyr2wJvcKHKS4LLx+Wo6xeuQHDQ4KN2qiPtJGH+ivlzWp/MnQDYL7YEThK67AFDb3m8MKYa9xjlIanYQBUjJf6rlWbx/lZruaas04i1k0+25aiS1hoN5jSRcyaG3ytnfmNaDsb/wXdFDuOj+mrmlXI9Br2DTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEQIE6k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926B5C116C6;
	Mon, 13 Apr 2026 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776074517;
	bh=mlzyEmNbjtIL7vKwRnpEy6oi+2Tn09KmOp9o8MEUcZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEQIE6k0EkCZR5gvUuRtGYRFHxBpBCUa0TuPqj77hqQrjQpnn6rBfnWHoQSbph/bT
	 Fe9B/oOgXmRvwX+hiH5/hWAIYcDMNdMw79ZbZGOSTMtKIUvqhLT0R0/n6jPiz+O0wP
	 W6KpUg4uQUk/Y2lnUKta40eTICc/PEDstDblrgFksvzKk99GaAmVm1wCBHteXSnAWr
	 vB+VVor/EgXH1A/WtlIOe1Ts5XuCXa+acSf9oXu9ey5ZE0khuuLLTa22AfdJzlPcPd
	 u9LhjZ+/zXvgbyeZqyXzvQnzLOJGnfd3b0lr15uLDAPgu+5x102R9LYktMfEHh/7ZA
	 ELny7wvyWc3oQ==
Date: Mon, 13 Apr 2026 13:01:52 +0300
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
Message-ID: <20260413100152.GG21470@unreal>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-19278-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: A8BE53EA2CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
> Hi all,
> 
> I'm writing to propose adding a sysfs interface to expose and configure the
> PCIe TPH
> Steering Tag for PCIe devices, which is retrieved inside the kernel.
> 
> 
> Background: The TPH Steering Tag is tightly coupled with both a PCIe device
> (identified
> by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
> user-space
> applications to fetch and set this value securely and conveniently, we need
> a standard
> kernel-to-user interface.
> 
> 
> Proposed Solution: Add several sysfs attributes under each PCIe device's
> sysfs directory:
> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
> device specific)
> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
> operations, e.g.:
>    Read operation:
>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>    Write operation:
>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
> 
> 
> The design strictly follows PCI subsystem sysfs standards and has the
> following key properties:
> 
> 1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
> devices that
>    support TPH Steering Tag. Devices without TPH capability will not show
> these nodes,
>    avoiding unnecessary user confusion.
> 
> 2. Permission Control: The attributes will use 0600 file permissions,
> ensuring only
>    privileged root users can read or write them, which satisfies security
> requirements
>    for hardware configuration interfaces.
> 
> 3. Standard Implementation Location: The interface will be implemented in
>    drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
> attributes,
>    ensuring consistency and maintainability within the PCI subsystem.
> 
> 
> Why sysfs instead of alternatives like VFIO-PCI ioctl:
> 
> - Universality: sysfs does not require binding the device to a special
> driver such as
>   vfio-pci. It is available to any privileged user-space component,
> including system
>   utilities, daemons, and monitoring tools.
> 
> - Simplicity: Both user-space usage (cat/echo) and kernel implementation are
>   straightforward, reducing code complexity and long-term maintenance cost.
> 
> - Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
> specific to
>   user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
> kernel's
>   standard pattern for hardware capabilities.
> 
> 
> I look forward to your comments about this design before submitting the
> final patch.

You need to explain more clearly why this write functionality is useful
and necessary outside the VFIO/RDMA context:
https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/

AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
right ST values.

There are several comments regarding the implementation, but those can wait
until the rationale behind the proposal is fully clarified.

Thanks

> 
> Best regards,
> Chengwen Feng
> 

