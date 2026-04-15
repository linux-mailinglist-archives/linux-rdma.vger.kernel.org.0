Return-Path: <linux-rdma+bounces-19365-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMX/JFHu3mnTMgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19365-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 03:48:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC63FF8DB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 03:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D137307F21A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1452D838E;
	Wed, 15 Apr 2026 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xLjXOP53"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5D1A2545;
	Wed, 15 Apr 2026 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776217676; cv=none; b=udnJlLLUMdISgXmGhmRkPUwev1INcDwd0fFjQoPlHyu0lBie0ANrJ4dD/Lz4ubWlfE/u9EX+ofCdaekykXV/bYKzRD8KEX1iYlJ4CVRW5Aj/mM4YePHAwDV00/amxYsGgrujK3O1wO7nZfaVgp/itmHrHifkZzj3YQNwbcLwR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776217676; c=relaxed/simple;
	bh=E0hei9H/2peq0vRfhtKbeuGrksJf/kZKlMZyfM4sk0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=szl76GoByjMp/w6EOADtf8ZYd85ryITbOWRizwWGycbaIbUXFjW5Eluw+R/nrqcEZbE8C0K+MBSTbcLI1FM2iBH85L14q37qGQsXEi51JRwmBUGs9u1aluab6W+VB8Nz9amtcb0GUAOzwXC9cppEX7ycOnGL9kdJR4x/xH5AxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xLjXOP53; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FKRdkwMjOaJ50cZQVCsjgPQXyq1PmmPA+TconZgAAI4=;
	b=xLjXOP53NN9FcwooK7x1IrxXikyHDczrsdyivuYn9Orevo4EtcIBcm+uyFpOdliAshfavswN/
	W85houPnKWrTLdJe2iNWA+kSOhiffrq3D3EGt2AZGMo50leaBOHZCzwwWnMH1D3L48OZh5vGHpH
	aflpVvibp0IPSuWx0P/oWY4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fwP4l3jDXzLlSv;
	Wed, 15 Apr 2026 09:41:27 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id DC9304048B;
	Wed, 15 Apr 2026 09:47:44 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 09:47:44 +0800
Message-ID: <9a7609b7-1d8d-4758-8f3b-081658d90711@huawei.com>
Date: Wed, 15 Apr 2026 09:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
 <20260414103547.GA361495@unreal>
 <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
 <20260414151125.GF2577880@ziepe.ca>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260414151125.GF2577880@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19365-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AFC63FF8DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 11:11 PM, Jason Gunthorpe wrote:
> On Tue, Apr 14, 2026 at 10:46:00PM +0800, fengchengwen wrote:
>>    We have a real platform requirement:
>>
>>      * 1. Devices in TPH Device-Specific Mode with no standard ST table
>>      * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
>>      * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
>>      * 4. Userspace must program STs into vendor-specific registers
> 
> No, this is nonsenscial too.
> 
> If you want to control the steering tags for MMIO BAR memory exposed
> by VFIO then the DMABUF mechanism Keith & co has been working on is
> the correct approach.
> 
> If the VFIO user needs to control steering tags for the device it is
> directly controling then it must do that through VFIO ioctls.
> 
> Nobody messes around with other devices under the covers of the
> operating kernel driver. Stop proposing that.

Understood.

For VFIO-passed devices that are fully under userspace control,
we will implement the TPH Steering Tag query interface
exclusively through VFIO ioctls, not sysfs.

This will allow userspace to query per-CPU Steering Tags
from platform firmware (ACPI _DSM) for the VFIO device,
which is fully under its control.

Thanks

> 
> Jason


