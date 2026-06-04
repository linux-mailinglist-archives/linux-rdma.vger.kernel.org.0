Return-Path: <linux-rdma+bounces-21769-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IgwlDDhqIWpMGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21769-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:06:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6463FB11
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:06:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21769-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21769-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hisilicon.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24D53026331
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43F41B347;
	Thu,  4 Jun 2026 11:52:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9A407590;
	Thu,  4 Jun 2026 11:52:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573959; cv=none; b=VCakU8R02crojhJtKF5bIxVk42++Y3PmnlO28w0gGOMkBZ6DHj8tFnJ9f4YePV7LZ9CirLLFWBL7VFSquX6QwLKDgrxm/8M5B1TZ+J9mkej2b8c3Z66bR/GIwLg4+LlXD0q21YobIMg9snK2taLV0NXvlSvNZdWz68ULQ221bP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573959; c=relaxed/simple;
	bh=RrmVB/mCZfX1fyWpF6MZnMCjB4n+8IhsSMa/dz75u6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sVSFlKCp1RpzWxsnGO9O87dHfKJYPq1vxzwH0Sodw9sN8O1yQrHlGiTxP0h5dfHQvK4MWpI5croqrPBH+NCzK8UamZkPuqGkNkAhUfCxQZs4uL1/0e83pQ7lXf7GNfgPSbhZiikby+v0L4TZbF7eh83wJ6/gCTErF0dYl2CwCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gWN5m3lNTz1cyPx;
	Thu,  4 Jun 2026 19:44:44 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E41A340563;
	Thu,  4 Jun 2026 19:52:33 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 19:52:33 +0800
Message-ID: <fb093af7-43fb-b719-145d-49fc79c80483@hisilicon.com>
Date: Thu, 4 Jun 2026 19:52:32 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Misc patches
Content-Language: en-US
To: <hginjgerx@163.com>, <hginjgerx@qq.com>
CC: Chengchang Tang <tangchengchang@huawei.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "open list:HISILICON ROCE
 DRIVER" <linux-rdma@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20260604114510.2955010-1-hginjgerx@163.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20260604114510.2955010-1-hginjgerx@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21769-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,qq.com];
	FORGED_SENDER(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hginjgerx@163.com,m:hginjgerx@qq.com,m:tangchengchang@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hisilicon.com:mid,hisilicon.com:from_mime,hisilicon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AE6463FB11



On 2026/6/4 19:45, hginjgerx@163.com wrote:
> From: Junxian Huang <huangjunxian6@hisilicon.com>
> 
> This patchset includes changes for RDMA/hns: Misc patches.
> 
> Chengchang Tang (3):
>   RDMA/hns: Fix hung task when drain qp failed.
>   RDMA/hns: Fix missing CQE when UD QP use different SL
>   RDMA/hns: Support setting GSI QP SL
> 
>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 30 ++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
>  drivers/infiniband/hw/hns/hns_roce_device.h  |  2 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 23 ++++++++++-----
>  4 files changed, 49 insertions(+), 7 deletions(-)
> 

These patches are still under development and were accidentally sent.
Please ignore them. Sorry for the bother.

Junxian

