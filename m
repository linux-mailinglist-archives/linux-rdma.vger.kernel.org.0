Return-Path: <linux-rdma+bounces-22551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FAgzDgMvQmqw1QkAu9opvQ
	(envelope-from <linux-rdma+bounces-22551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 10:38:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 814836D7911
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 10:38:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hisilicon.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22551-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22551-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D16A3009CF6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153E3A873C;
	Mon, 29 Jun 2026 08:36:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFB2C2360;
	Mon, 29 Jun 2026 08:36:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722184; cv=none; b=NI4hgaY28TQ1XQoo/IfwwWnouHMHPDlNlLtG9IxLRaCCYdGRuxisSyqzNVLzE5pJUjY5QI9ayf6fUKLblbW+9JMmFKjkkj+X9hiqZzA3rArlAvZryy0HKsTA0vE2RP4Q5iXPTV5K+ggBUdfn0zbDKJunb1DiYl3yO02Ep0VwKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722184; c=relaxed/simple;
	bh=ezcv9JOLVOE1a5V/ADfu9rgrysXjNkk65WQc54LaVlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FPIdaUUxgt6bvSNCB2rQTIT60RDDSA1OhYxZHbC7VUif9IVfvh/0no4Pn+OIPChjqt6Nfc9caGn2q9dO7BF3VHnELtDc5XwU/S3eyGhDENTL8eahHtvDDX5ICmVdlhCeGO23ak21wqqikushEupzS6mGa1KbCZ3Y0CA0bLsYNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gpf4X2tthz1d0T5;
	Mon, 29 Jun 2026 16:06:36 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F6F140594;
	Mon, 29 Jun 2026 16:15:43 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 16:15:42 +0800
Message-ID: <969dc5ef-69d6-2fe4-eb4f-6cd1715099f9@hisilicon.com>
Date: Mon, 29 Jun 2026 16:15:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/hns: Fix potential integer overflow in mhop hem
 cleanup
Content-Language: en-US
To: Danila Chernetsov <listdansp@mail.ru>, Chengchang Tang
	<tangchengchang@huawei.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20260627095951.51378-1-listdansp@mail.ru>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20260627095951.51378-1-listdansp@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22551-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mail.ru,huawei.com];
	FORGED_SENDER(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:listdansp@mail.ru,m:tangchengchang@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 814836D7911



On 2026/6/27 17:59, Danila Chernetsov wrote:
> In hns_roce_cleanup_mhop_hem_table(), the expression:
> 
>     obj = i * buf_chunk_size / table->obj_size;
> 
> is evaluated using 32-bit unsigned arithmetic because
> 'buf_chunk_size' is u32 and the usual arithmetic conversions convert
> 'i' to unsigned int. The result is assigned to a u64 variable, but the
> multiplication may overflow before the assignment.
> 
> For sufficiently large HEM tables, this produces an incorrect object
> index passed to hns_roce_table_mhop_put().
> 
> Cast 'i' to u64 before the multiplication so that the intermediate
> calculation is performed with 64-bit arithmetic.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a25d13cbe816 ("RDMA/hns: Add the interfaces to support multi hop addressing for the contexts in hip08")
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>

It's unlikely to have such a large hem table in practice,
but I'm fine with this patch.

Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>

Thanks,
Junxian

> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> index 7041a8e9134b..92edec4fa61b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> @@ -836,7 +836,7 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
>  					mhop.bt_chunk_size;
>  
>  	for (i = 0; i < table->num_hem; ++i) {
> -		obj = i * buf_chunk_size / table->obj_size;
> +		obj = (u64)i * buf_chunk_size / table->obj_size;
>  		if (table->hem[i])
>  			hns_roce_table_mhop_put(hr_dev, table, obj, 0);
>  	}

