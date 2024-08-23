Return-Path: <linux-rdma+bounces-4526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BF95D138
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5722828239A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE11885A2;
	Fri, 23 Aug 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9zhe2zx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435A156C69;
	Fri, 23 Aug 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426288; cv=fail; b=TD+x3YvfjQsDNYbM3VBREZIr2Y0nusz3BKjsfNUo8aSYMZEMlQWAtFufmuOa74NKkS2gPsYY1VIYXXtT96FsK3vzbtY43e7d0k4vEsZlceF4WsmKzxekIVSbJl3kFqxcSR/Y7qxXpUrJFIg2fq+K+e4i4em+gwmInYO6mOs89UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426288; c=relaxed/simple;
	bh=QBftxNoCGKi6PddsT4LG/8+eXkcYK4jWIdaK4hUilBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HNG0wAum2LKkLNj1UUsJdJ6VJkkAf32PHy/l/L0m0vdyyq1gS2MKbRB2SYq31faxeCOnCkwORMzBe9/vqHnz7Qt1XaLDyelkUn4WI9I1oiXFkLYH6BL2fBHJYcdHicKleiutypyrS3b3WG8tmjrvozQA+L7johpIUDqhn78nICQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9zhe2zx; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZmMxY5wqguup+EC/6UCLs226kF3V/3d+tZ6Vw1C/39I51WoB1ZalegMi6EkEuebkZKE7MOJfxg4Epo3H9koi26xUcuxnkdRFXS0Revb+bFN4O0bszPUb13l4g7sw7/BH3JxKToFCM91g87ozns/huX0A7fMhcqbVUG+q4+hK6VVBfHLU+6wKktC+43V8tIQzDZlAPswoItACJpWeSGmG+dJ0V0JnsGfUF8mzkwQl8f5uVhyCILKG8xT4ovMHL9N3BLkkm7BjT0YngkbkFHrNiZVZsDb7PnTBOyyaobk0PqxrAl6vz5Ebr6i2lLEKGPuINB18kskHShqWvbWCYrSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN2esYQNI9dfLZUrW+gsdZiSFr8jK/bJ5m0crXtzsnw=;
 b=jERGMC/jq376Jexn8+gVXTZ8kIeLLyqF4onHWPodpFypOGxRxpHpWq5rPbm79VYBMsZ3vKdZwwJyYCvIBuYbysbdyrfrHq2/C8nAHz5sEAcuwqyW4opr1LlEU4zWQ5Wr4R332Kuy3i0lIPBx+SKldZkYMB17b4HHCcQKvsgNfgxzJM392VzOVh6He9lUw1HzuAuecHM1iDIm1X0ahnLICv6B0sVNE0Q5XX3PK9HQSSt5FnxpJ4Vuz+cglxivpdjV5kJm1MjEuznrVtrFO5J5T5Fc0KjOjDPYmS/WIzETpcXJ/OQHZxgh8jGzhNZt8swVPoFmGz+wchRyKwSan5q7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN2esYQNI9dfLZUrW+gsdZiSFr8jK/bJ5m0crXtzsnw=;
 b=n9zhe2zxnlcYDzDq/arMa+ajF1O5qDVBsmJxxk8JPNjNloMq9IfpLoN3xNiVcy3FUNCJwh8VKY7KWo07IEPpezFIAwsj3+iCs6VowKJQEMIcBwsCVatPSPsA2tGpxhAHJr2Tc2b8263NKR+HkLUmgpZMlOLFhgJ4N/KYcFix2uQlqlOEbl6cCm5etXm9BzetWCWUpH0dHmsCaR5hFy1zjWrKjp0OngvJ/C6bxU8Ym3t/jvS2YxmJcjWOOq6cB/adzMQz7OpBaA8z/X69HIQeixwIkINxOVlgo/SSzUjCpiN57SZVFfrY+0gHEtofu/Cbh/kQRAHMtnX4xlNPOyAGfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 15:18:03 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 15:18:03 +0000
Date: Fri, 23 Aug 2024 12:18:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next 3/3] RDMA/hns: Disassociate mmap pages for
 all uctx when HW is being reset
Message-ID: <20240823151802.GA2342875@nvidia.com>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
 <20240812125640.1003948-4-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812125640.1003948-4-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BN0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:408:e7::34) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: d33c5fe8-af16-46fe-a709-08dcc386c888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1v8/O8bACE4c5cgP9SYJK/zNPSPlHhQ+JaSoxRZpbfSYba1N7Q+Ua7va8QrH?=
 =?us-ascii?Q?pqEy+95S+IU4/NvEeTsHcOGmphop9tBcVeCEu9WuJTq9XKJi2KC+skfyCgoM?=
 =?us-ascii?Q?qkg/gU0KeDvpplBFpEcWjWOVkXsvu1EJJpDTshPTeCSm6KY5edzztev9Xtux?=
 =?us-ascii?Q?rq9SKxxK990wKGutLlJz4DkugUJEuR2dRT+nueSjk7WLHU0okRo1Sx3T5isn?=
 =?us-ascii?Q?yzdweIgWCZKoIN3fBIFYR9A+pJGvyr27Xm79U/SZo91AFxzWvKQdGomrMjmW?=
 =?us-ascii?Q?FS+fYTP+Azwnl61DSeMS8sk6Xrz2Ha1e5zc+3mC48Mn9Z9KoEoNxY48b46of?=
 =?us-ascii?Q?vya1oYk5JGANpZBZAD9wZZSYdgdunCoPNT9lj6bggHs0amtb0OQHAp5Tii7w?=
 =?us-ascii?Q?uv5re/WJN0SAxKIAtK8ZBgHOs7OaWtjTfo/vqbaeoz0OHGLqErvkXn+0L4O1?=
 =?us-ascii?Q?2JidKiKexaN0MamoftvvXmK6HK8vf6x2gIRbuQP1wcxLdzmXJKfJWPQnPYb5?=
 =?us-ascii?Q?s6vCDbg7gneWdvB49MaNXFjUOoYDYANnczl8H8+a1N2ikHRFsgEOpe7WY+SF?=
 =?us-ascii?Q?toH3tiP6/pvzxUDODhDM5nXurVI0aqjY9epxCCUdi7Ocfiht4adcWav7SpfM?=
 =?us-ascii?Q?IOPUGWoUhkFu5pmamC5AhAHQMTy9v2mXv/8fjA2Biq10IE+S/faazgolSIWp?=
 =?us-ascii?Q?pNS96P9V7XFIb3NeFwUwfwoVyImNjUxQgcE2n3Ml7tcL+hnkBwJB1fjJ8TaA?=
 =?us-ascii?Q?8yLyfwzbSAcNmqvmBT0OF90u3ncnLm0EknDo+MI/8YRBTFjpfguzh56igvuV?=
 =?us-ascii?Q?bHIp5M3RKfLj8K+a12IkBDwgfmHPgl+ErreImdg3X3LlamI1f21jivXStvEW?=
 =?us-ascii?Q?sE8+ttW4tCqXMOXtap21G+OHK8kOU/5nHqZFE4i6GbplwKtJlrHtnLmUbAE/?=
 =?us-ascii?Q?DOqoq/7zvawMhW2AANHLPnOoyvnvnK3312hNLxvnxGuwFta1xMWbV6n59HFv?=
 =?us-ascii?Q?M60b8xDwDI88pecXGVi3ZIe8EkmsZSULm7VTlBfTdtReuQD9zgftclXbuk5+?=
 =?us-ascii?Q?yFHdFgQsTQjYDk6lVZXnHpU/S+9GBw/2ykncSeGnvySp4LPi16jo8mtDGQaH?=
 =?us-ascii?Q?X8mMWuvoXy8IKT4JmlBx5XE7LihqlkYwPfmlA259pmdg9b6T8Vtpv9Xb0LHl?=
 =?us-ascii?Q?mFZH6dc8SEZT/3Ygz6GvB800K8Be9ObBCjHKj4q+fJv0Gw1Guj1vWTD8Uicp?=
 =?us-ascii?Q?+ZCJNkq5i/aYHU+fqN4KHPQsQja5p0xrOKtvWnliLoKCWKoETbgeL4mbmYz2?=
 =?us-ascii?Q?NlL8ahjEu6K2u/mRPgzhLVAfhNlt1G19iWugaWciogYVgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDrFLF4iaQUK/BypWmgwjtt7qKNFc1yN1xuz3JWkQcOl+spEzUffDocyVlbB?=
 =?us-ascii?Q?+y4sImIWoGKwr0SiGH+nfJ5YpOtw6PG7vJZdl7blzz/ur/9Sk11fwJnOZY8J?=
 =?us-ascii?Q?sNh4iZ72S7UN6HNnYpnWD9IGP0oc35lmj9HTsx4kvfNMzYWVNBd2qmm4bE7t?=
 =?us-ascii?Q?v0iX57cxLPnk2gKGtLDi1HbLwhA/5Kxduk9wUqsRoUkbarxTFRZNb4ijHZ8U?=
 =?us-ascii?Q?G+kW8bs+gkbEi7KPT4E2rv8MszjUmCMH2kEcATN2lLhl9EtXTOUpr2RLvt7s?=
 =?us-ascii?Q?/R5v4d+Sjsa5IRDxDZrJ9DrrcYQWnhmYL/y8MvOT/zmO2KdKPUwV8jKqhd2T?=
 =?us-ascii?Q?iF00pVSx+v9fggY53fpOT+5rLaC5g00+ydCwfYYAOMaIUCU2QXfpRlntc/i/?=
 =?us-ascii?Q?Vx1lPV9hOSQojfkSAxW4fxzpKIWwy/b4MxPmBwxMVXPPFVzLGyshShAG0uRt?=
 =?us-ascii?Q?y2jjkTZaiLx/tt/pcXBRLtNzKEacE5ghuzbPPS84Ie1sejEQJ0ci1GF8eSzk?=
 =?us-ascii?Q?aF4LEKrC1YKQMymw+/xVdnXuxsdhhesPpCLz7coIz0r4N+88Nl9cxdepcfko?=
 =?us-ascii?Q?KxIBHjpccQUlPB8Clm0ud0EWk6A86E8pXPlyOrSPE5Amf6dRIhmldZwFBw6L?=
 =?us-ascii?Q?OnRmKojrgH2gXAiuECWh2PIZ3BKNWN6VHhJTtrMIMCrCnnSDtomQshM6fsEl?=
 =?us-ascii?Q?OadGTokvhM6ok8/gxNPzycdrFCfA+QSHjlvWPz47y8K45KorOPL2J95ZM4xd?=
 =?us-ascii?Q?VsLm2mXvTtuPb4gSCutGWKF1nlntTXUWUjK1DeXVrIQ8beS/Hrkn54hz6h0i?=
 =?us-ascii?Q?gItbr1dcR+3AcWr0JUO4vPFqF0Fu4bWbtYCZ4km9bVULLCgS5sB5RQiJh0qy?=
 =?us-ascii?Q?lkTdLSTwdZ4GgV0bE+RIlZd7lc9KeAO4j7U9teP982rHWYxyUoQ/ojQ0dfRx?=
 =?us-ascii?Q?sGdqwMsdNNx5Wy+muwwV4kN5BZL0XXU2Y1F3iznIs6E8GLoSisshh3701U4x?=
 =?us-ascii?Q?jcZEqwmQzAGAPLLofXAQb3tEyvASP1H7xy2Yza3FfcERgSiALpJHfylTn8RL?=
 =?us-ascii?Q?jaN5707w1V7VfAe+rrqMuqkN1Z2a7azk9Nt/ld4x7u8wA6U5vouQqSjqX9KM?=
 =?us-ascii?Q?xvs1b8ZSKsAihSsGVUbb5VW8ost/GYAxrueGpgss3IqgTo+/TA9wszqu8J/M?=
 =?us-ascii?Q?M+S2YkTJXSYrSfygEdm+s1V6J5erdC2V3v/kdXY70NxJ42JJ03r3h8jTjst9?=
 =?us-ascii?Q?KwgYru8/JCR2sdeybZXOvzya1OWjbnhs50kb6hy7OqvuFbza2935c+znhZDJ?=
 =?us-ascii?Q?beO6VI0EGo6DCmKyHXO6V9VHRpNNMZdg1fRdmrbrjDWqGBJSY40BEt/ocPUH?=
 =?us-ascii?Q?rBhg12mjsJ7qvkWX20ff3mnLfj0fbVLOtTbjoHvHqNWaP0MwpkZ40SOj2EAu?=
 =?us-ascii?Q?cQHsDUd0xiE67ds1d8VF+iQ6Rv2RMNDpAZfw3tqzwRovscf4kMpgoqZyCF0T?=
 =?us-ascii?Q?yycP9i/TrCcemYpGxcB4IY2oyX/Dhi3kqpirVkXgtjyvc/XRG8voOJiP7K6s?=
 =?us-ascii?Q?yj0X93SVg+w5DeuVbZkCPcJVkyg0WgW+AFmF2ELM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33c5fe8-af16-46fe-a709-08dcc386c888
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:18:03.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/prKrxserdPugbKjf77EgJougg7bBkONkI2fhVSr9A3qfClGRPk7jqB6OHqhcTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

On Mon, Aug 12, 2024 at 08:56:40PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> When HW is being reset, userspace should not ring doorbell otherwise
> it may lead to abnormal consequence such as RAS.
> 
> Disassociate mmap pages for all uctx to prevent userspace from ringing
> doorbell to HW.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 621b057fb9da..e30610a426b3 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -7012,6 +7012,20 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>  
>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>  }
> +
> +static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_ucontext *uctx, *tmp;
> +
> +	mutex_lock(&hr_dev->uctx_list_mutex);
> +	list_for_each_entry_safe(uctx, tmp, &hr_dev->uctx_list, list) {
> +#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
> +		rdma_user_mmap_disassociate(&uctx->ibucontext);
> +#endif
> +	}
> +	mutex_unlock(&hr_dev->uctx_list_mutex);
> +}

I'm not keen on the drivers having to maintain a list of ucontexts
when the caller already does it.

Try something like this?

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 00dab5bfb78cc8..6b4d5a660a2f9d 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -76,6 +76,7 @@ static dev_t dynamic_uverbs_dev;
 static DEFINE_IDA(uverbs_ida);
 static int ib_uverbs_add_one(struct ib_device *device);
 static void ib_uverbs_remove_one(struct ib_device *device, void *client_data);
+static struct ib_client uverbs_client;
 
 static char *uverbs_devnode(const struct device *dev, umode_t *mode)
 {
@@ -881,23 +882,25 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 }
 
 /**
- * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
+ * rdma_user_mmap_disassociate() - Revoke mmaps for a device
+ * @device: device to revoke
  *
- * @ucontext: associated user context.
- *
- * This function should be called by drivers that need to disable mmap for
- * some ucontexts.
+ * This function should be called by drivers that need to disable mmaps for the
+ * device, for instance because it is going to be reset.
  */
-void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
+void rdma_user_mmap_disassociate(struct ib_device *device)
 {
-	struct ib_uverbs_file *ufile = ucontext->ufile;
+	struct ib_uverbs_device *uverbs_dev =
+		ib_get_client_data(device, &uverbs_client);
+	struct ib_uverbs_file *ufile;
 
-	/* Racing with uverbs_destroy_ufile_hw */
-	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
-		return;
-
-	uverbs_user_mmap_disassociate(ufile);
-	up_read(&ufile->hw_destroy_rwsem);
+	mutex_lock(&uverbs_dev->lists_mutex);
+	list_for_each_entry(ufile, &uverbs_dev->uverbs_file_list, list) {
+		down_read(&ufile->hw_destroy_rwsem);
+		uverbs_user_mmap_disassociate(ufile);
+		up_read(&ufile->hw_destroy_rwsem);
+	}
+	mutex_unlock(&uverbs_dev->lists_mutex);
 }
 EXPORT_SYMBOL(rdma_user_mmap_disassociate);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e30610a426b387..ecf4f1c9f51d32 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7015,15 +7015,7 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_ucontext *uctx, *tmp;
-
-	mutex_lock(&hr_dev->uctx_list_mutex);
-	list_for_each_entry_safe(uctx, tmp, &hr_dev->uctx_list, list) {
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-		rdma_user_mmap_disassociate(&uctx->ibucontext);
-#endif
-	}
-	mutex_unlock(&hr_dev->uctx_list_mutex);
+	rdma_user_mmap_disassociate(&hr_dev->ib_dev);
 }
 
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d6e34ca5c7276c..de9db15243c66f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2947,7 +2947,13 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
 				      struct rdma_user_mmap_entry *entry,
 				      size_t length, u32 min_pgoff,
 				      u32 max_pgoff);
-void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext);
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+void rdma_user_mmap_disassociate(struct ib_device *device);
+#else
+static inline void rdma_user_mmap_disassociate(struct ib_device *device)
+{
+}
+#endif
 
 static inline int
 rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,

