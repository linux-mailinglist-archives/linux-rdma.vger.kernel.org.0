Return-Path: <linux-rdma+bounces-19331-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OB7LEgK3mnRmQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19331-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:35:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3053F7FE6
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E3F030C83AA
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1323C276E;
	Tue, 14 Apr 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="R4myZ29U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BF3BC69B;
	Tue, 14 Apr 2026 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159022; cv=none; b=oD3VbJlq5B49+RaZlouNyUgW6zclp/tP+MM0w6XjeV9yO8U4itUlgloee2BsRfXe4mltO7sjiPb3XlztEou6bovZB3KHZ+jPxAqc9jRO8Jm46luWuf7VnuAoKBNlwjbjQjBrAHmX8WzbMvKbBCLedZRTEmscj7/OU+iMXPJn8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159022; c=relaxed/simple;
	bh=bTBTTe/w0yMM8S9FdfWKBQPu1IxqEkwS7U/9mbEhmNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rVNzGqmE0l6m79X0Fke8LS+jFvQQF7tC+WjExgYsY3zYr/C2Jjuic9s/HBPEpX3naYRp9Ae0zr7MG6zviM+48Qf0459MbHWmLiqvihh015mkgeoVMZIspcVtZrmRQQHn4vVWDztKGb1jvOsS47+1w6VIoffRmgrRVfxLkBdLBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=R4myZ29U; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oBf86KO0dP/D4BTnJnsUEGyTRtXUodAVosgtNdHk4Io=;
	b=R4myZ29U+VAoxhb7ITArO4R+UBzokNSpy90umPdVsTg5ZlSIhlBMhWpjNYLuh37OSzvuR6AWG
	jJoHGYYPB/go4A4pqlkzehjY5YmoNsl5rJmyU0gKEfvTC2YtH3mBiZBv/nYP+LYQZXgv3l7htG3
	zvyMUpxBnupiUoZk+TqIX9I=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fvzNn4GmSz1cyQg;
	Tue, 14 Apr 2026 17:23:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 83BE240561;
	Tue, 14 Apr 2026 17:30:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 17:30:09 +0800
Message-ID: <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
Date: Tue, 14 Apr 2026 17:30:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260414085723.GR21470@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19331-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D3053F7FE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 4:57 PM, Leon Romanovsky wrote:
> On Tue, Apr 14, 2026 at 09:07:23AM +0800, fengchengwen wrote:
>> On 4/14/2026 3:19 AM, Leon Romanovsky wrote:
>>> On Mon, Apr 13, 2026 at 08:04:10PM +0800, fengchengwen wrote:
>>>> On 4/13/2026 6:01 PM, Leon Romanovsky wrote:
>>>>> On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> I'm writing to propose adding a sysfs interface to expose and configure the
>>>>>> PCIe TPH
>>>>>> Steering Tag for PCIe devices, which is retrieved inside the kernel.
>>>>>>
>>>>>>
>>>>>> Background: The TPH Steering Tag is tightly coupled with both a PCIe device
>>>>>> (identified
>>>>>> by its BDF) and a CPU core. It can only be obtained in kernel mode. To allow
>>>>>> user-space
>>>>>> applications to fetch and set this value securely and conveniently, we need
>>>>>> a standard
>>>>>> kernel-to-user interface.
>>>>>>
>>>>>>
>>>>>> Proposed Solution: Add several sysfs attributes under each PCIe device's
>>>>>> sysfs directory:
>>>>>> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
>>>>>> device specific)
>>>>>> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
>>>>>> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
>>>>>> operations, e.g.:
>>>>>>    Read operation:
>>>>>>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>>>>>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>>>>>>    Write operation:
>>>>>>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>>>>>
>>>>>>
>>>>>> The design strictly follows PCI subsystem sysfs standards and has the
>>>>>> following key properties:
>>>>>>
>>>>>> 1. Dynamic Visibility: The sysfs attributes will only be present for PCIe
>>>>>> devices that
>>>>>>    support TPH Steering Tag. Devices without TPH capability will not show
>>>>>> these nodes,
>>>>>>    avoiding unnecessary user confusion.
>>>>>>
>>>>>> 2. Permission Control: The attributes will use 0600 file permissions,
>>>>>> ensuring only
>>>>>>    privileged root users can read or write them, which satisfies security
>>>>>> requirements
>>>>>>    for hardware configuration interfaces.
>>>>>>
>>>>>> 3. Standard Implementation Location: The interface will be implemented in
>>>>>>    drivers/pci/pci-sysfs.c, the canonical location for all PCI device sysfs
>>>>>> attributes,
>>>>>>    ensuring consistency and maintainability within the PCI subsystem.
>>>>>>
>>>>>>
>>>>>> Why sysfs instead of alternatives like VFIO-PCI ioctl:
>>>>>>
>>>>>> - Universality: sysfs does not require binding the device to a special
>>>>>> driver such as
>>>>>>   vfio-pci. It is available to any privileged user-space component,
>>>>>> including system
>>>>>>   utilities, daemons, and monitoring tools.
>>>>>>
>>>>>> - Simplicity: Both user-space usage (cat/echo) and kernel implementation are
>>>>>>   straightforward, reducing code complexity and long-term maintenance cost.
>>>>>>
>>>>>> - Design Alignment: TPH Steering Tag is a generic PCIe device feature, not
>>>>>> specific to
>>>>>>   user-space drivers like DPDK or VFIO. Exposing it via sysfs matches the
>>>>>> kernel's
>>>>>>   standard pattern for hardware capabilities.
>>>>>>
>>>>>>
>>>>>> I look forward to your comments about this design before submitting the
>>>>>> final patch.
>>>>>
>>>>> You need to explain more clearly why this write functionality is useful
>>>>> and necessary outside the VFIO/RDMA context:
>>>>> https://lore.kernel.org/all/20260324234615.3731237-1-zhipingz@meta.com/
>>>>>
>>>>> AFAIK, for non-VFIO TPH callers, kernel has enough knowledge to set
>>>>> right ST values.
>>>>>
>>>>> There are several comments regarding the implementation, but those can wait
>>>>> until the rationale behind the proposal is fully clarified.
>>>>
>>>> Thanks for your review and comments.
>>>>
>>>> Let me clarify the rationale behind this user-space sysfs interface:
>>>>
>>>> 1. VFIO is just one of the user-space device access frameworks.
>>>>    There are many other in-kernel frameworks that expose devices
>>>>    to user space, such as UIO, UACCE, etc., which may also require
>>>>    TPH Steering Tag support.
>>>>
>>>> 2. The kernel can automatically program Steering Tags only when
>>>>    the device provides a standard ST table in MSI-X or config space.
>>>>    However, many devices implement vendor-specific or platform-specific
>>>>    Steering Tag programming methods that cannot be fully handled
>>>>    by the generic kernel code.
>>>>
>>>> 3. For such devices, user-space applications or framework drivers
>>>>    need to retrieve and configure TPH Steering Tags directly.
>>>>    A unified sysfs interface allows all user-space frameworks
>>>>    (not just VFIO) to use a common, standard way to manage
>>>>    TPH Steering Tags, rather than implementing duplicated logic
>>>>    in each subsystem.
>>>>
>>>> This interface provides a uniform method for any user-space
>>>> device access solution to work with TPH, which is why I believe
>>>> it is useful and necessary beyond the VFIO/RDMA case.
>>>
>>> I understand the rationale for providing a read interface, for example for
>>> debugging, but I do not see any justification for a write interface.
>>
>> Thank you for the comment!
>>
>> As I explained, read interface is not only for debugging. It was used to
>> such device who don't declare ST location in MSI-X or config-space, the following
>> is Intel X710 NIC device's lspci output (only TPH part):
>>
>> 	Capabilities: [1a0 v1] Transaction Processing Hints
>> 		Device specific mode supported
>> 		No steering table available
>>
>> So we could not config the ST for device on kernel because it's vendor specific.
>> But we could configure ST by it's vendor user-space driver, in this case, we
>> should get ST from kernel to user-space.
> 
> Vendor-specific, in the context of the PCI specification, does not mean the
> kernel cannot configure it. It simply means that the ST values are not
> stored in the ST table.

Thank you for the clarification!

I agree with your interpretation of "vendor-specific" in PCI spec terms—it
does not prevent the kernel from handling TPH in principle. However, the
real problem is that the kernel has no standardized way to know where or
how to program those vendor-specific ST values.

When a device  reports "No steering table available" and operates in
device-specific mode, the method used to set ST values is entirely
device-specific and not covered by the PCI specification. If the device
is taken over to user-space by UIO framework (e.g. VFIO or IGB_UIO), the
generic kernel cannot infer the proper programming sequence or registers
for each vendor-specific implementation.

In these cases, the configuration must be done by the vendor’s
user-space driver, which is aware of the device’s private programming
model. But such a user-space driver still needs to obtain valid,
platform-provided ST values (from ACPI _DSM), which it cannot do
without a kernel interface.

This is why a read-only interface to retrieve ST values is still
needed: the kernel holds the valid platform tags, while the user-space
driver handles the device-specific programming.

Thanks

> 
> Thanks


