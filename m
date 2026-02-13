Return-Path: <linux-rdma+bounces-16807-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAzyKtLijmluFgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16807-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 09:37:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0401341FF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578C13024949
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209B33B970;
	Fri, 13 Feb 2026 08:36:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8B33ADB7
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971817; cv=none; b=ScLunBhPMn9lQ7v8Ax3Z5HqHy1WjXrY7ipP2GmbjzYsCUpLcbnVRd28rokeiFGGPfu20F8et+XANdd4ncMJodtN8t9MoKUNPG30eM8PjDa28AQiFXKioq5EDGCUBN80mR1OnZfuj/vCo0or4DwxDC0Ep4HGx2NsK2iRTzGMUIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971817; c=relaxed/simple;
	bh=6FdbqTR1Wy/Ivrzj0MdP8Llg7qJPoCZR7DULmZs1xE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iciR75qItHtSbwXtjeGlxi+opyz07GwICQGYuMC/ukn4zyaJj+EicmazKHORlkQw/ItcFgRUBvg/bdv67aP8K9G360duGW9Vd+qmLpVE7Oqdza6RTMHd0gbsYsMIYKqGtUTP0Zvfoq0H3wLy8Iu5Jp/GGTHboX6xva+uKHtStDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fC54j2hs7zKm5n;
	Fri, 13 Feb 2026 16:32:05 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EFB94048B;
	Fri, 13 Feb 2026 16:36:45 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Feb 2026 16:36:44 +0800
Message-ID: <c22f1ad1-b8bd-d719-d0f2-9ab721134549@hisilicon.com>
Date: Fri, 13 Feb 2026 16:36:44 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 3/3] RDMA/hns: Support congestion control
 algorithm parameter configuration
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
 <20260206103110.3414311-4-huangjunxian6@hisilicon.com>
 <20260212165734.GI12887@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20260212165734.GI12887@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16807-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DC0401341FF
X-Rspamd-Action: no action



On 2026/2/13 0:57, Leon Romanovsky wrote:
> On Fri, Feb 06, 2026 at 06:31:10PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> hns RoCE supports 4 congestion control algorithms. Each algorihm
>> involves multiple parameters. Support configuring these parameters
>> by debugfs.
>>
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 278 +++++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_debugfs.h |  25 ++
>>  drivers/infiniband/hw/hns/hns_roce_device.h  |  25 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  66 +++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h   | 140 ++++++++++
>>  5 files changed, 534 insertions(+)
> 
> Please remove all these complexity, delayed work, 

Sure. Then we'll update HW immediately each time the user write a new value
to the param file.

> multiple configuration options in one file, provide one directory with multiple files> Each file is a key, which can accept multiple values and not like it is implemented now.

If I understand your comment correctly, our current implementation already
follows the structure you described. We don't have multiple configuration
options in one file. We provide one directory with multiple files for each
algorithm. Each file corresponds to one param.

* The directory structure:
# ls /sys/kernel/debug/hns_roce/0000\:35\:00.0/
dcqcn_cc_param  dip_cc_param  hc3_cc_param  ldcp_cc_param
# ls /sys/kernel/debug/hns_roce/0000\:35\:00.0/dcqcn_cc_param/
ai  al  alp  ashift  cnp_time  f  g  lifespan  max_speed  tkp  tmp

* Read the value of a param:
# cat /sys/kernel/debug/hns_roce/0000\:35\:00.0/dcqcn_cc_param/ai
1

* Set a new value for a param:
# echo 2 > /sys/kernel/debug/hns_roce/0000\:35\:00.0/dcqcn_cc_param/ai

> 
> Also, please add examples to this commit message.

Will add the examples above.

Junxian

> 
> Thanks
> 
> 

