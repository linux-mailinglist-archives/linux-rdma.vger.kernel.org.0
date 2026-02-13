Return-Path: <linux-rdma+bounces-16805-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG4uL1zYjmm/FQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16805-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 08:53:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED00F133B92
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 08:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C489730429B5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B9A313552;
	Fri, 13 Feb 2026 07:52:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790273115BD
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969176; cv=none; b=fP3NmATt8sDzM24cdcZruyOGBc2x+UQpjiyc7sXld6XZACS8e253LoZfuJAELbblW78tibxo3mr2zZzCtUpZecj83ZkVd99kMjdInMHEndWaMLMyef6S4RauhXXRi5Fn9ItWPml2oDfntvvRzxwetBJfTlmbNiLiGSzVHkVVRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969176; c=relaxed/simple;
	bh=ZYVJ7mQ38egDtlDlPSbdR+L/2EqnnaH5k/Dv2rxBLqE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=AwDpI8uj0wER3tZtP0o8yk4G9q7ialv9zXLk2FDQVGQzsdyvqUNrFRvr/uwJvjYVdhOzLu432tTfxXhwJddehiO3H/ON38eckk2UYfUiAMWPMvh+rhdOOf1Fi5x3nlRuKiHUWwvncggoxay/4ffL7LlTiXPrSnRi7/9qqpg8eO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fC4612HDLz1prMF;
	Fri, 13 Feb 2026 15:48:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5058D40569;
	Fri, 13 Feb 2026 15:52:51 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Feb 2026 15:52:50 +0800
Message-ID: <28023174-dd0a-246e-ee0d-531b0bfda873@hisilicon.com>
Date: Fri, 13 Feb 2026 15:52:50 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Add write support to debugfs
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
 <20260206103110.3414311-3-huangjunxian6@hisilicon.com>
 <20260212165507.GH12887@unreal>
Content-Language: en-US
In-Reply-To: <20260212165507.GH12887@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16805-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED00F133B92
X-Rspamd-Action: no action



On 2026/2/13 0:55, Leon Romanovsky wrote:
> On Fri, Feb 06, 2026 at 06:31:09PM +0800, Junxian Huang wrote:
>> Add write support to debugfs.
>>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 38 +++++++++++++++++---
>>  drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
>>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> <...>
> 
>>  static const struct file_operations hns_debugfs_seqfile_fops = {
>>  	.owner = THIS_MODULE,
>>  	.open = hns_debugfs_seqfile_open,
>>  	.release = single_release,
>>  	.read = seq_read,
>> +	.write = hns_debugfs_seqfile_write,
>>  	.llseek = seq_lseek
>>  };
>>  
> 
> <...>
> 
>> -	debugfs_create_file(name, 0400, parent, seq, &hns_debugfs_seqfile_fops);
>> +	debugfs_create_file(name, ops->write ? 0600 : 0400, parent,
>> +			    seq, &hns_debugfs_seqfile_fops);
> 
> What is this "ops->write ?" check? You added write callback in this
> exactly patch. It is always true.
> 

This ops is the function argument "const struct hns_debugfs_rw_ops *ops", not
the file_operations hns_debugfs_seqfile_fops. This ops->write can be NULL when
the file is read-only, such as the change in create_sw_stat_debugfs() in this
patch.

Junxian

> Thanks
> 

