Return-Path: <linux-rdma+bounces-20331-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBwXC5E2AWonSAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20331-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:53:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49345070FF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 971723002881
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 01:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52323AE87;
	Mon, 11 May 2026 01:53:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A67195811;
	Mon, 11 May 2026 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464398; cv=none; b=W+SG5NMiE5sCTOkwmB8bXnjKPaDHdsFS9b7mmOoShqcHhOMCSMfkouWrQwPtoy//1UlJjaNTGCpKqWfa0x/Wbn8+e6ZENPysNAURMlKr5yhF2OTIkLatqmG55vo9Cirfq7KqbkXXN9+0OYqLqYwZJa2T35h7E9qQGoeOG8G70qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464398; c=relaxed/simple;
	bh=BlG3fqXifabH/cFn2TTTomewZHooJOWEoO8Acx9G+fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rcuAQTlCR9+P9VD8DG5PgXjEeC5CsDTeGYauqPKPAlhDdSIk4dpBCPlQEl+Qib9/AUUPZq/jzde/2Xdp0aa9wy6lgEH8oLh13j/rA4xWJ93/kOVC93CkxBJR3h1VWxBBmQltAuWXbHPWw7xbF54LFhpGumm6kaPnJBIujFupBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gDMxP1M1rzKmZR;
	Mon, 11 May 2026 09:45:29 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 4395740572;
	Mon, 11 May 2026 09:53:07 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 11 May 2026 09:53:05 +0800
Message-ID: <944777a4-7f44-76ab-9cb4-47a02cd1c077@hisilicon.com>
Date: Mon, 11 May 2026 09:53:04 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMS/hns: Use named initializer for pci_device_id array
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Chengchang Tang <tangchengchang@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260507075437.2669363-2-u.kleine-koenig@baylibre.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20260507075437.2669363-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Queue-Id: A49345070FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hisilicon.com:email,hisilicon.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20331-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action



On 2026/5/7 15:54, Uwe Kleine-König (The Capable Hub) wrote:
> While being more verbose using a named initializer yields easier to
> understand code and doesn't rely on the two hidden zeros in the
> PCI_VDEVICE macro.
> 
> While at it, also drop the explicit zero in the terminating entry.
> 
> This doesn't introduce any changes to the compiled result of the array,
> which was confirmed on x86 and arm64.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> while being a cleanup that can stand on its own this is also a
> preparation for making driver_data an anonymous union that requires that
> .driver_data is initialized by name and not by list order. The union
> allows to make better use of the C type system (see
> https://lore.kernel.org/all/20260507074102.2654314-2-u.kleine-koenig@baylibre.com/
> for an example), but inifiniband won't profit as no driver uses a
> pointer for driver_data.
> 
> Best regards
> Uwe

There is a small typo in the patch subject, it should be "RDMA/hns".
The patch itself looks good to me.

Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>

Thanks,
Junxian

> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 32 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index fa36700d0db2..cfe5269ba6a8 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -7249,16 +7249,30 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
>  };
>  
>  static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA), 0},
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC), 0},
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA), 0},
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC), 0},
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC), 0},
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA), 0},
> -	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
> -	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
> +	{
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA),
> +		.driver_data = 0,
> +	}, {
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC),
> +		.driver_data = 0,
> +	}, {
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA),
> +		.driver_data = 0,
> +	}, {
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC),
> +		.driver_data = 0,
> +	}, {
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC),
> +		.driver_data = 0,
> +	}, {
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA),
> +		.driver_data = 0,
> +	}, {
> +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
> +		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
> +	},
>  	/* required last entry */
> -	{0, }
> +	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

