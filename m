Return-Path: <linux-rdma+bounces-16743-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGqBDKHei2nKcQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16743-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 02:42:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E341207DE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 02:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D30A7302A6C5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6FF29ACD7;
	Wed, 11 Feb 2026 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cpnpJHA9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542D299928;
	Wed, 11 Feb 2026 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774146; cv=none; b=qfJA4ECFVxL8Jugu7c940U4rYY0xCVdI3vAw6tjnaMhx6DbRNf8jxTNdX2Ap4Sd5niDVCNQJwGSxGn7T34ididj9TJZSMGe7S3Zbc6VpKZNncFxJHAplGAfrqgusyTB7vdudUg6y1eBOJ/VbBf0aY5JGszsF4wIXKG93cpPMSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774146; c=relaxed/simple;
	bh=Mb/VVCf9egOkjMeEWPeLRLzaJhnewiNqQzmQDrfKFxk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DyWdmsD1pwJBa/kmWkQMPTWeBjg8wkGf2q/lqXRcysMdNK/+L9kHHsJ3G3va1oewZAVPu4QwQ0nx5sqWAMm+3MGQVjpQ8GNzputMsY+CMqW4ik7TwEliz2JEQh9r7/GeDRMGotl9culCWelWPPvc8uN9yp7bu4ULRVF8DGNI5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cpnpJHA9; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vBIPSGp/KOTP7s/IpoishNommYTUSUwig6I78qJaThE=;
	b=cpnpJHA9QP5X2Nhx+lFuku1kaRAW1Mexf6hmrkg67zLBp2eHaOP+reYiLg010zmV8JPxPYnFw
	SqnBHfEVziGATGExTDBtdyU8djXPzkXM8JpcxXFMPyppIq+fTY25bbNWe9u5dJP+epkFfma3JDJ
	1D/mu8EvuJOghowXeV3Y5yo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f9gzQ53zCz1K96N;
	Wed, 11 Feb 2026 09:37:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F34540561;
	Wed, 11 Feb 2026 09:42:14 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 09:42:13 +0800
Message-ID: <1a37e361-a791-4d28-a389-e3e04faec655@huawei.com>
Date: Wed, 11 Feb 2026 09:42:13 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Amir Vadai
	<amirv@mellanox.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dcostantino@meta.com>, <rneu@meta.com>,
	<kernel-team@meta.com>
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
To: Breno Leitao <leitao@debian.org>
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
 <49fe0af5-7dcf-42e0-bd73-0bd42c067d26@huawei.com>
 <aYtIrl01U0uHo7RP@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aYtIrl01U0uHo7RP@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16743-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8E341207DE
X-Rspamd-Action: no action


on 2026/2/10 23:18, Breno Leitao wrote:
> On Tue, Feb 10, 2026 at 10:19:46AM +0800, Jijie Shao wrote:
>> on 2026/2/10 2:01, Breno Leitao wrote:
>>> When a PCI error (e.g. AER error or DPC containment) marks the PCI
>>> channel as frozen or permanently failed, the IOMMU mappings for the
>>> device may already be torn down. If mlx5e_napi_poll() continues
>>> processing CQEs in this state, every call to dma_unmap_page() triggers
>>> a WARN_ON in iommu_dma_unmap_phys().
>> Hi:
>>    My comment has nothing to do with the changes made in this patch itself.
>>
>>
>> I am more interested in this error itself.
>> 1. If there is an issue with dma_unmp, does dma_map in tx have a similar problem?
> I suspect that dma_map will succeed in such a case (when the DMA maps are
> gone).
>
> dma_map_single/dma_map_page creates new page table entries — it doesn't look up
> existing ones. Even if existing mappings are gone, new mappings succeed !?
>
> I haven't seen this instance on the TX path as well.
>
>> 2. Can this error be detected by mlx5_pci_err_detected()? If not, does this mean that all PCIe NIC drivers might have similar issues?
> mlx5_pci_err_detected() is called for the device under DPC — that's not the
> issue.
>
> >From my naive view, the issue seems to be timing: there's a potential race
> between DPC setting the PCI channel to frozen and the error handler completing
> (which eventually calls napi_disable_locked).
>
> During that window, NAPI poll can still fire and process CQEs, triggering the
> dma_unmap WARN_ON storm, and crash.
>
>>     Do other drivers need to do similar checks?
> I really don't know, honestly. Are other drivers solving the problem
> differently?!
>
> Thanks for the question,
> --breno

Thanks for the reply, and I will continue to follow up on this issue.
This change may require further confirmation from the mlx driver's maintainer.

The code look good to me.
Reviewed-by: Jijie Shao <shaojijie@huawei.com>



