Return-Path: <linux-rdma+bounces-1822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA389B664
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 05:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709681C20E48
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7B1860;
	Mon,  8 Apr 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CsSdaWDI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2096.outbound.protection.outlook.com [40.107.236.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25E1851
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546832; cv=fail; b=JFF8AJJbh127vJFAmiXQmg1jQiRD5REJcFpqxNEJPorNTonEDkJB9jBdbEB0H8deKjThGV31XdyDgzMeGLvrnhnrZzG3woCO6blWONW69EH/DNPeCKGlE4guV5Bk9jOt5CI4vfEmYeViTfwCANmmzFLUeYIM/cA7wQnl80h2wSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546832; c=relaxed/simple;
	bh=6BSX6OY369kG+hdsHt4B8PWRF80eUse3Mhs0vrSD4FY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnOtQ0PRaXfsMP75lfgFIJmu9I13coId+Chi7Scgkwt/NgoYwUUXU4ap4y3LvBMjgq7TL/je/gknT4pyoLM5VtEjE/uOjwrCwmTVV5YvW8+653X4dF43ar8QP4Umm6BlT+R/j4k4SQbEQBBTSJ3aSR2AsZUrDKKKiu8hoEa1OYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CsSdaWDI; arc=fail smtp.client-ip=40.107.236.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAK+fDx/w1ToGYQNu5SqIvN9mKi1ME6nwy7tNwTmTI/tIwwO73Pse5/D0bz2+pUgDAZLCC9jX5uamhEqxSjLsVeHLLPk0LWxHc0GzqpNjE2kzoJaNUdBh4gj8PL77uPHjawobgG2f8sfSUkVhy2kUHrmi6iEng7sm0yTwwaxP9nSkHGT94nQTjQngMBTd57XEXvKu332dzniTN9ztl7AJ4/kcXOwGuFfCAl+7/7dOOoY1EN5ks7Od9a1Ve+EYuouw1rzsUSeKdXLIe8le/EyHUzzpMf72ZJLRqDviElWLJ2a+IE7yYezrlhP1X9ylOyGZuYFoA9wLK3A9HP/b6cPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ/RJIqAbi5V6cen2Fs8QocX6EfjlDo3OIpsYdNK/E0=;
 b=Ws8jokXP5yr+MbJbaPH2Qgyl/bt/3G0gPy5KcWayUPaBeKvE2YkXIRfHHDO8OvKH/ChaP9aJMCZcFLNpPoWXbVPFjcDXdnqTrKwN3+R/h3fised2bR0G4PioZzHldy93Q0kadXJ8a9qjgdh7yG6r1Lb3On0hjbh/CO4/9qg/o27pQEufYx0Hw0aruJtgWd7OjWQtRPeE1Qkz6I6lPhyKZ+d0CA9wshnyuvjj+1aZSr/X09e9bJhWRVtQIq/F0qlFJtQsQMZ2wQJ/9ijCXUfDWHbgfS/410zwEPvJ0Adg3D5IXp1oMi2axS28yjDNb0w0qiwPNbUkpX0GrpIyBC/cTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ/RJIqAbi5V6cen2Fs8QocX6EfjlDo3OIpsYdNK/E0=;
 b=CsSdaWDIfgxhJ35+Ld8peQSwYVkYZWIy5HZq2dUPr8dmlGv9ClyleM1Ul4r2T6upao72eLr2YPJ/kNk7CvOCV/pKmtKubZ5Ip/Z7ROnGEoR+hhjiJ3vvRwvo08QSwXeAxNM+zF6zIllSQmSkObYQmjRux00HLlGHkwLgYPBqcXebRo4yhm9fhDPoj9OoObz2XVmFNw/XdlFAC2MBPPZWyA2u9UUMWEo1n2HMtWGB+97ilBNPfRaA0tTa7Q+KJ+ofHlUm/JXyyQk0vi7ZK1H+VGsfwYaaXQx2D30P0pQEnoeb24zrIoupcbfCWsql1VRP55Pw7crVeK2QEiUJ/XIM8w==
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:27:07 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::2284:af7b:1045:b9d]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::2284:af7b:1045:b9d%3]) with mapi id 15.20.7409.049; Mon, 8 Apr 2024
 03:27:07 +0000
Message-ID: <adc18a96-661f-4c60-808f-3a1167a20e1b@nvidia.com>
Date: Mon, 8 Apr 2024 11:26:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
To: Etienne AUJAMES <eaujames@ddn.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Gael.DELBARY@cea.fr, guillaume.courrier@cea.fr
References: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
Content-Language: en-US
From: Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0025.apcprd04.prod.outlook.com
 (2603:1096:820:e::12) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|BL1PR12MB5707:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I3cpdPziwlauU8YJ99X6zDoIWLKx+wzUXSo8OIL07M2ok5OAlfsJHJ336QemjXVWjlLQzqBJIutzL/r9p8X1D9ns3oY93+pGxRlBa6Im31tnTV9SC8HzBO10fiW8FK3Yom6T1x3Eu7pISbFSG8xImp5DwabXvRDek29/OH8ItmmfNkSNthFTHfkm4+k/rh0CKEWGyo9IXk3l7FMZodOUcPFs7FgcelImUdnUoBSpwhYVMr1gG3fEybF1bAMd9gR1VmIOKeSch9sVtmJaimDM9kca9PXGQRDBilKIZ683xj/Kf7WPIr8bq5ddfk4pkCgzROoe8NxKML7Dzsh2noyZc4aEYIyZVoQSVkhpuXBAstWyxjUiwnR8pjwiqgednHQmdT3vhiQoEQSI1rHOaS6lw1Q+KLbZ9IyAUxBGdsq0F24JMXJBJJImNbFSX1jATz+V5CqfXXC9niHDjygDagPOuDdvLqDxm+sCcf59wUkLZVL7s2L4x1Q6hCnanDHptAPTjSryB0IqN2HSO5f7l/JZQWdVXvIMfec/5EN+4QWULInmBilm5bm3w9zkRpSlKCeQuzz79jTfgTio6N9XpTpGNI+THEFD3bLAIV0MYUtztJNW0+lF59Q1APPEwZjBNXp0LWiQ01HhQgXZJe7y8YQxONTGXl9VlshJJ0JkOCTbXZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGEwTVptQTI1b2VESXY0Uk92QTlKM0R1bkhucWxxT09yOVVzVERoU2JXbmtC?=
 =?utf-8?B?U2dQVXYvRHl2dENwNURDUDhpTEJOamdYKzcvK0ZkeDU4TE4vK2s2ckZBRlV6?=
 =?utf-8?B?Ky9INytBcGoxVzN1ak1JbWN4U09SNzdZUEJyTEFtckhMMVdjOVF3TTZEZloz?=
 =?utf-8?B?TU5QelIyc1hLNnRzZXVJQ0RzYUdmZ1hsaktOT1NzUEpZSlN6UHpadUdiMjA4?=
 =?utf-8?B?bVdaeFVHVlZYYkFYNzk3SWEreFR5alFtOEtJZENoSmFYU3NMeCtnc01ZcWx1?=
 =?utf-8?B?cExYZ3UvcG1mVzY3T3lsT0xHSWYxRGM4U3JLeENuNDZ6ZkQxZmxOd2xiYmxN?=
 =?utf-8?B?MnhYZlZJQlhoQVhxUkNmb21pdUZRODl6eTFNZzYybngzOEp1bnF6Y3o0aFA1?=
 =?utf-8?B?ZUJZYjhzK2VEU09vVHppaS9pQWx1Wll0TDdOMXhQblJjZ0Yvai9oWUtJcHk5?=
 =?utf-8?B?ZmU1UTlRbGpXVW5lMXI1ck9qdThwQVlLcHRFWVhLdmVTWXk1V2IzU081SExK?=
 =?utf-8?B?U2xkNm1HSUJGTVlVYjhESytReU05OVJjaEtlaEJxejhsNFltaE42eUh0aENp?=
 =?utf-8?B?Qk9UTk1ERHl1Q3dJeWFFQ004YzlTYnBqa1BUOG53WEVLVWxIeGdkYkVmTEZO?=
 =?utf-8?B?bVpialNHTVA2dVEwTXlwcktQTTVMUzZsMU81QXlhSUxXZ3pOSTdRMytKYWdj?=
 =?utf-8?B?ODJwSlRwbWw1bUFCOUdmTWc1WlVnTWJmTlpIVHlVY2c5WEV6dERxUVg4aE1U?=
 =?utf-8?B?SzRkT3EyY0gyTUVmTEtDSGVKUEIwekIyRzFFay9UZjMvZ0xpZEwzdHZYaWhQ?=
 =?utf-8?B?YzNQMExJa1hhU2o4aFI0YkJZeCtCT0ZJUm0zcjkzYWtNWnYwNnFoUTJnWWVB?=
 =?utf-8?B?Wm1iYmdxb3FWNU9WTmRXNTN2b3hjV3pUTE5uOGN3LzEzRTBDcTJoeVJhZHpP?=
 =?utf-8?B?aUpKTUJoRlkrZHlnYUhsZXRGSndHN2RzSXRpa09GTG13ZFhQRE5Pdjh6SUJ6?=
 =?utf-8?B?VG1DUWtPbkNnZjd4TjlzS2VNZHlBcDNyT0l3blU3VWw4SnRkRkJQcnpMUS9x?=
 =?utf-8?B?amM0dXliZmpubUlKajYwWit2V1c4aWJXb3dhaEJvSy9MWWVoTkZINHJZZk90?=
 =?utf-8?B?THRaaVc1K3k1UFl3RmZDSnl5emVmNHhVcmszS09sV01SajdwWkJZQVptNHZC?=
 =?utf-8?B?YTRPRFZFV1dQbExzcDZEZVk5T1lLcXNYYVRHRzRYZWFEaDgvY3NhOG5OZFo1?=
 =?utf-8?B?TXd3SUNaR3g1QWFwVldNc1RzNlptWjVGdU8vQXpqUXhLbTUzSndwSXRURkpr?=
 =?utf-8?B?QzV6NnJ5Lyt3cU11RVVjWmJNK05abGIzT1p0YTc1U2U2YitVeVRXVDVYVk1z?=
 =?utf-8?B?N3A2T2JUeGl2Z2gzOWdheGk4VGlOVEd3VjRiQWppQi9iVkordlYyUXA0eGtF?=
 =?utf-8?B?SGtMR1luMFFvcHpISnZyNTl2ckFSWll2TlVOYkpwbzVOZjZVZjFKVHBDUzRD?=
 =?utf-8?B?SG5yVGR2ZC8vK1V0dHk0SVdiUnVvMkcyRUFYRTEvWEVrTkthdyt2SkxtSnp1?=
 =?utf-8?B?Q0xRK3VRYVd1elhFT25NbDZuSlBtTXp5SmtTUkl6bmdYbTM3RnljMS96MGs2?=
 =?utf-8?B?RXlvV3hsUDhYeFJ5UUxIWEpaU040eldWNm02QXplQXVKOXUzUzR5dzNwYTNp?=
 =?utf-8?B?R256cEVzSVRhM2FuK25RV1Q3N1U5OFd3RTRUV1NvNnhhREMvM09MQXM0dk9Q?=
 =?utf-8?B?aDdNUlhxWFpSQVcxZ0UrM3lwMzM4WXNncWdsMFZjRzN4VW9MSnFaTWVPM0hw?=
 =?utf-8?B?bjBneG55ampRaG9yczdQTUZnYTVPcXEwY0hWcnJHb2xtaVBXZkx4cnI1MDBV?=
 =?utf-8?B?TjAwQ1l3bHdtOFNIYk5kN0FFV2YzZ0FxbXp5R2lDRXdDZXR5RVpiWmFZczd0?=
 =?utf-8?B?RXpodEJVNytCUnd6TXNUZ2NPR2hrd3VWanFHanN3VUJsVGxHK1Bsbm5qVHh5?=
 =?utf-8?B?QkxnRG5uZVZUdEswS0F5dmdNb3pud2Foczg5dkorZ3BSRHorOW1neUNTdVlF?=
 =?utf-8?B?ckR1QUcvYUs5aWpqcFU3NyttenltRW1yRG9OSHRsOFRmVnl2ck1obkdhTzVh?=
 =?utf-8?Q?qlZYExX/3ztHS8DiyjTamtGgT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8b5626-8c0a-4c0c-47c0-08dc577bc45e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:27:07.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XueXVwCP9+LsVIJPtb4a4eAi+zrlECopsyNWC+6hEIUNjJI9ayQASfJJ13u6piLl+H21yQMTWT7UlEnHJSe5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

On 4/3/2024 3:36 AM, Etienne AUJAMES wrote:
> External email: Use caution opening links or attachments
> 
> 
> Define new options in 'rdma_set_option' to override default CM retries
> ("Max CM retries") and timeouts ("Local CM Response Timeout" and "Remote
> CM Response Timeout").
> 

Sometimes user-facting tunable is not preferred but let's see:

https://lore.kernel.org/linux-rdma/EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com/

> These options can be useful for RoCE networks (no SM) to decrease the
> overall connection timeout with an unreachable node (by default, it can
> take several minutes).
> 

This patch is not only for RoCE, right?

> Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
> ---
>   drivers/infiniband/core/cma.c      | 92 ++++++++++++++++++++++++++++--
>   drivers/infiniband/core/cma_priv.h |  4 ++
>   drivers/infiniband/core/ucma.c     | 14 +++++
>   include/rdma/rdma_cm.h             |  5 ++
>   include/uapi/rdma/rdma_user_cm.h   |  4 +-
>   5 files changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 1e2cd7c8716e..cc73b9708862 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1002,6 +1002,8 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
>          id_priv->tos_set = false;
>          id_priv->timeout_set = false;
>          id_priv->min_rnr_timer_set = false;
> +       id_priv->max_cm_retries = false;
> +       id_priv->cm_timeout = false;
>          id_priv->gid_type = IB_GID_TYPE_IB;
>          spin_lock_init(&id_priv->lock);
>          mutex_init(&id_priv->qp_mutex);
> @@ -2845,6 +2847,80 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
>   }
>   EXPORT_SYMBOL(rdma_set_min_rnr_timer);
> 
> +/**
> + * rdma_set_cm_retries() - Set the maximum of CM retries of the QP associated
> + *                        with a connection identifier.

This comment (and the one below) seems not accuruate, as it's not for 
the QP. This is different from the rdma_set_ack_timeout().

> + * @id: Communication identifier associated with service type.
> + * @max_cm_retries: 4-bit value definied as "Max CM Retries" REQ field

typo: definied -> defined

> + *                 (Table 99 "REQ Message Contents" in the IBTA specification).
> + *
> + * This function should be called before rdma_connect() on active side.
> + * The value will determine the maximum number of times the CM should
> + * resend a connection request or reply (REQ/REP) before giving up (UNREACHABLE
> + * event).
> + *
> + * Return: 0 for success
> + */
> +int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries)
> +{
> +       struct rdma_id_private *id_priv;
> +
> +       /* It is a 4-bit value */
> +       if (max_cm_retries & 0xf0)
> +               return -EINVAL;
> +
> +       if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT))
> +               return -EINVAL;
> +
Maybe we don't need a warning here.
I think UD also need these 2 parameters, as UD also has Resp. see 
cma_resolve_ib_udp() below.

> +       id_priv = container_of(id, struct rdma_id_private, id);
> +       mutex_lock(&id_priv->qp_mutex);
> +       id_priv->max_cm_retries = max_cm_retries;
> +       id_priv->max_cm_retries_set = true;
> +       mutex_unlock(&id_priv->qp_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(rdma_set_cm_retries);
> +
> +/**
> + * rdma_set_cm_timeout() - Set the CM timeouts of the QP associated with a
> + *                        connection identifier.
> + * @id: Communication identifier associated with service type.
> + * @cm_timeout: 5-bit value, expressed as 4.096 * 2^(timeout) usec.
> + *             This value should be superior than 0.
> + *
> + * This function should be called before rdma_connect() on active side.
> + * The value will affect the "Remote CM Response Timeout" and the
> + * "Local CM Response Timeout" timeouts to respond to a connection request (REQ)
> + * and to wait for connection reply (REP) ack on the remote node.
> + *
> + * Round-trip timeouts for a REQ and REP requests:
> + * REQ_timeout_ms = remote_cm_response_timeout_ms + 2* PacketLifeTime_ms
> + * REP_timeout_ms = local_cm_response_timeout_ms
> + *
> + * Return: 0 for success
> + */
> +int rdma_set_cm_timeout(struct rdma_cm_id *id, u8 cm_timeout)
> +{
> +       struct rdma_id_private *id_priv;
> +
> +       /* It is a 5-bit value */
> +       if (!cm_timeout || (cm_timeout & 0xe0))
> +               return -EINVAL;
> +
> +       if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT))
> +               return -EINVAL;

likewise

> +
> +       id_priv = container_of(id, struct rdma_id_private, id);
> +       mutex_lock(&id_priv->qp_mutex);
> +       id_priv->cm_timeout = cm_timeout;
> +       id_priv->cm_timeout_set = true;
> +       mutex_unlock(&id_priv->qp_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(rdma_set_cm_timeout);
> +
>   static int route_set_path_rec_inbound(struct cma_work *work,
>                                        struct sa_path_rec *path_rec)
>   {
> @@ -4295,8 +4371,11 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
>          req.path = id_priv->id.route.path_rec;
>          req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
>          req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
> -       req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
> -       req.max_cm_retries = CMA_MAX_CM_RETRIES;
> +       req.timeout_ms = id_priv->cm_timeout_set ?
> +               id_priv->cm_timeout : CMA_CM_RESPONSE_TIMEOUT;
> +       req.timeout_ms = 1 << (req.timeout_ms - 8);

So req.timeout_ms must be greater than 8? Maybe we need to check in 
rdma_set_cm_timeout().



