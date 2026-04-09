Return-Path: <linux-rdma+bounces-19173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOzvJ1S412l0SAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:31:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA43CC0DD
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7BF73008C30
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7033B1BD;
	Thu,  9 Apr 2026 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CaGFnYuU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0B387348
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745105; cv=fail; b=dSNt08DLD/I0sdn5t88xDnxZ8mZoD11kpVBIj/gAluGoON6nPHwRpIIlsQdiAyQyKYTMdkyH8VFioYxsEWzgRh8lZ1ARgqVLuOaZYemsHlNfqbGP0qyUX7ljD1luVsW+bmzshOuuTfB64EkSS0BICeP4SnVUC3nI7wQExVMsHcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745105; c=relaxed/simple;
	bh=FpAdNHwlpjaPxmj87TXuwCuAEWaixD1T8NtegDQ1Axo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QcjHURCdU5deqD3cEFHmnxkfUx7ondCJrFo16Vj/5E2RQvz1SY60I30JZZfY41nZtI5urLh7IwDEV7xTjl1dazh1rSgx5OzQgQ2Rdrgl1BRt1VP0G0AJQ+jcunJifUxB70Yu+kjEayd6qZb7GHZ0VGSHUbf2wChtrbHrrrCD+JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CaGFnYuU; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVPamq2Ux3+IccYroavCQv5RhMlKhLqadzTgcebv/9VyzLXPYwRreim9l3ix0RgLb5vAOFzbuTc2uo2wTaEt7gdU+gmBm9FA03+HktvJtoPuh9h04d1qaS0HYYnXzqNk/xPeNIL7PswrlGK4lVf1igtA3Ff4HNHpV8Vy6QaYhOJ4ax8VH3ls3NTzbh/EthKM97cMm3fjDjXM/L1W+fTpAM39ddAjT9311wcUjYJK+Wz0ORhXlhRdNv3W1033B94WxSiFCEayHmd3YL3w0cloCxCJ8nRyAsvGrnQMiYeVvfEQCTRWzfMcVlgWKSBpTIMt9YissMZEMKHVGXmFH056Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNrcHT8S8SvRwUutFuGnKMFts3h/lFxbLbVAbmRQi7A=;
 b=OJW7AfIk1bDirkAhtjUnuee2J5ak9lb+neqb3hCS0IZHmMrboha5/rTG4qzIGwBGFx7rXjF+gWgX5Q6bSCgrwedwZGRcs4Q+Qjs2kfpDWv48HOch2y3FsUJGuNm6NvoEY9ym4guZUh042hGHNDzWJdWz3HQr72yBeeY6mVxp+yx2RXARh6xvPH1fCbofUsBpoZORJBnLgoZhLmFKqRvb+yGa0m9cBxIsKe+1fTBlARKWFHG+uVoaCfTzJ8GEuZqH1bItOX7AG3FCSU62xZcVWTu3ep3IbouEAL3pQFkosB8tDIdFWhAkWdgOvoWf5wQSFhElu7QPzV8ryUTYhJq92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNrcHT8S8SvRwUutFuGnKMFts3h/lFxbLbVAbmRQi7A=;
 b=CaGFnYuUpWHSkT5EUoEmgYDK6wvHhzzRSFQFEH1sieH0RABOzPTLVOPhAs9oxRrFkRaxz0WoAGtX9xUU5M5sx6hRTyq+/Kr8oe61rblmm7e6nNZaEw/mgCDbCRxQeLWikL8aXD9oyOEV8lV3YqjhESmHFWKQB+zM0PC6HPRdB9rH5q7HTZYomWQTrKhtffzLfllkZ6WMIEJCrgVtYBoo4vf8DqOiA7YqsEmqQtDuoIGS5jjoBsgLHJL+DwwAOm7CCwn1kksEqTRvfaRqaWcFoVmpbqmxgF7znW7zCxR/sxEeNE0Vo3tFZQHos9M3DhxfrSqPBO/KHk2Uw9andlXupg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 14:31:37 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:31:37 +0000
Date: Thu, 9 Apr 2026 11:31:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
Message-ID: <20260409143135.GA1931061@nvidia.com>
References: <177516078937.637585.1447184858924347033.stgit@awdrv-04.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177516078937.637585.1447184858924347033.stgit@awdrv-04.cornelisnetworks.com>
X-ClientProxiedBy: BL1PR13CA0243.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::8) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0ef4bb-147b-485c-dccd-08de9644b4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3GGRxe5Msh3JWJPzD3Lu7etlU9esMvcb6Kdik4xHrcUpVM8x0yzWqo7nakp8qZ1WrELkuMrrcKqQSVhqurgnKrK+rKUuES+HE0RGgxpMOyD/FrDwzJBuj3LWXciREAwQrN3SRlL6UuXI2QTt+lQ/UrxkP7qfIDWT8FEtwvfXMcYUipMQLFK3H+eNU1CAPWxdaRuuewzeB9Z6kK2qXx+aS7haXkGQQCF2AnfOtQEnuXJWgXhudE6S71C68pBzD7CzYzbrNwvVmBhp6Tu2jHW3UbptBo7IeXcCFBQngPxNZjJpj7VFglY3mBlFsoAF/oW0dX1rjwxY6+miKYH8W59TKWubZg1Mj0wh0wqHpf+FtNfXIXC4x/I61yNVopfruNqb2C5y3LTKEx7aglbVDpxRjHW4yXAaTqfapmmhLAQkK6oKa2AzSsvrQ4T4LazxcoIDrT47X8JbxDQQyrfcaNlJcdwagI8MMuEd6CoB6e9po34H8Yxq6ZmuG7k+FPC+dJUjiIydXxB6sGexnigbWyIQQRXHTgYIwzvvVAYW4slSig/N/dYTDvjhmn2JqtsekYnDMegjsliid5VJ9iwFqtgS9Zn9NTCzM4+gB3PVHRw0HGN0gyupYSq+O74lpkG0yJ3wbBN+HK0SSFeMLhMJeOSAK8KshKVvZUGoDjt81OZApg2+URJtRXoGyQVjYmI40RCbDTfbYX8BPMuq+6Hnya+fDpPWVJeMgByv3ankFO9EcUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7ER+FIjQNBt8xxkzJyCYOCPhb5zy+7rgmo40uvVsm4bySGv6WGBBlqTSygH?=
 =?us-ascii?Q?xXW0PW8Hz3VWBczsRdd/Ny3nUSskyxDNnRhs/nVVqQkKdDcTErAQcZ0r+2aC?=
 =?us-ascii?Q?0voYW+tEhse8kEaF/6WQWzWspULif3Te8sPH08zSPIVDqd8TjLovhwgIQMtc?=
 =?us-ascii?Q?1dLxb6d4/iM/jqSFkbSuTD33WJILCQHqCRoG6Z9HU5PEdncs7GevUlCz8CFZ?=
 =?us-ascii?Q?EB+MXD3EdzlWeoxZDLw1lRfZRrM2ff57GLGf5ix5hvq0USKLa6PhhNOxDFut?=
 =?us-ascii?Q?r52cAf8DabU0YMuNSnAP/42xczZ8O8FYBcaV6HpHqMZINGlToSdqJQUzo/qA?=
 =?us-ascii?Q?V0TqSKPtu3XKlM2FZ4vyX7GWsf2JRyFssFT9ftePX9o6xQoUXiI4S5ZfoMyH?=
 =?us-ascii?Q?zUfVTOihOTzioaM1cQSmxB95dmVwHCbn9h8sVysmsZTo+5bqNz0OEte9yizv?=
 =?us-ascii?Q?tuTKSCoIWbCtvsaaEadJdQHshsG2pzJ+PlESimpaRmpxctNhan+w1ZN1vBbQ?=
 =?us-ascii?Q?RBzmKvs+gRx8VjHvIcATgx94Kw8yPgI4pfORCjiPD+stcT2eIlBr0g979ZKD?=
 =?us-ascii?Q?YMVX5UjTc0/+nc3iANQJCufORLKNNA08BhorVILUrZ9EvvsEAmJyc781ptsd?=
 =?us-ascii?Q?PTg4s2VBKQ0MrqgK8AG3Utn4gBWSFOIIzOCZqN2ZQ1kFM6lkJIWWI0VbWoSn?=
 =?us-ascii?Q?ePTUmMgwfxcEQvF9ybg2DBcvCM+8YwlkIvCZlHVzfwXzHQ5707AfY/gp3eU4?=
 =?us-ascii?Q?HmnBiDT7ChmPjNuE7IPHA+4rHk/nVPOzyW3HS6hQe2kIgwCDRAAVfhYo3Lyn?=
 =?us-ascii?Q?6FmjqSpO9iqP/fl/cJRsDJ8R/phuY/WDr7IZrYqaAGXxu/uXsWUs/3UEYd8+?=
 =?us-ascii?Q?ONijQQOD+Ixnt1hqHc4JUih+3344U6KkIYui47UroV3yne4OvTNydTavklHf?=
 =?us-ascii?Q?IL/T0/TqBbT8GxfsMu4Yv3Fh2pkeV9AE9ShvTB21HZ3cJlCoP8rqJ4MwfubS?=
 =?us-ascii?Q?SbF6cCdBprlBjmPL6+sC6MC6xbQ0WyiwVch3kaDXgun1deBs6DDJ/njiPCOa?=
 =?us-ascii?Q?+yLEwCxPTqw1RCoXvwr3cOLwITTsLa0/yWKcT8wxG1gumKweOpbgAMNZcxkC?=
 =?us-ascii?Q?6mEd4OhBZsvYYU+yqe3Nt2cwAjmiw1vxL3dbI7Deroqk4+mp7yVwNbNxx7hC?=
 =?us-ascii?Q?UpUVfwRkKwC4VKkijvQHXJqi3n7Qook7iuDvJr1+vvRdX7pW1C9vr5LVFT0h?=
 =?us-ascii?Q?00woine/kCRqFfxS9p93XO+XvuvlhsRlVIvrQXPtt5tia9nDhYEd3U5gZYKr?=
 =?us-ascii?Q?3j+9kz1hzxri0RlJAkVEUYzowPoUdDl60WDSoL2xj5cmn4My54ugza8hfv7H?=
 =?us-ascii?Q?HysGiDaZFyTfiiNZ13NX/0TEzXSSTDaqbz5Awh8jPwFukBak5sS7OozF8BnX?=
 =?us-ascii?Q?X1/JrMpDSrI+QYk95Nxiy37GbuWUmNwR4gl6UIam7fhwHpdtUzrBpD0yo31j?=
 =?us-ascii?Q?Oa1MOGWeKrOQZXTpeYTn9lE6ZqjgVBcWnLXhtIjISqgAXZvabHAh0oifiZYX?=
 =?us-ascii?Q?CTwkNSR5W3io/PzpoAfzKYSLbW752+5bsJTL1MDkecLTr+vTQS7WrQ30X9UE?=
 =?us-ascii?Q?cvm5yzwu7LmUMBCAl5sJttEtupUolYc6GzEnlyr1/WNx//jJ2Gl8L62cRy1D?=
 =?us-ascii?Q?M8uoDPK5SnGd/VOrTmHVgriWCJa3s9R13hXEayUVOu6sAh2L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0ef4bb-147b-485c-dccd-08de9644b4f8
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:31:37.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTGjfYyBbmXwVGfdi3WGVt5iIOVaJQ2YdM8JBaJUWkSLZs+w/oOVMcSEr9Z6gyAG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19173-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 46EA43CC0DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:13:09PM -0400, Dennis Dalessandro wrote:

> diff --git a/include/uapi/rdma/hfi/hfi1_user.h b/include/uapi/rdma/hfi/hfi1_user.h
> deleted file mode 100644
> index 1106a7c90b29..000000000000
> --- a/include/uapi/rdma/hfi/hfi1_user.h
> +++ /dev/null

> -/*
> - * Set of HW and driver capability/feature bits.
> - * These bit values are used to configure enabled/disabled HW and
> - * driver features. The same set of bits are communicated to user
> - * space.
> - */
> -#define HFI1_CAP_DMA_RTAIL        (1UL <<  0) /* Use DMA'ed RTail value */

How is the userspace going to work after these are removed?

Shouldn't some of the drivers/infiniband/hw/hfi1/hfi1_user_compat.h
stuff be here instead?

> diff --git a/include/uapi/rdma/rdma_user_ioctl.h b/include/uapi/rdma/rdma_user_ioctl.h
> index 53c55188dd2a..263cace86f8f 100644
> --- a/include/uapi/rdma/rdma_user_ioctl.h
> +++ b/include/uapi/rdma/rdma_user_ioctl.h
> @@ -39,47 +39,14 @@
>  #include <rdma/rdma_user_ioctl_cmds.h>
>  
>  /* Legacy name, for user space application which already use it */
> -#define IB_IOCTL_MAGIC		RDMA_IOCTL_MAGIC
> -
> -/*
> - * General blocks assignments
> - * It is closed on purpose - do not expose it to user space
> - * #define MAD_CMD_BASE		0x00
> - * #define HFI1_CMD_BAS		0xE0
> - */
> +#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
>  
>  /* MAD specific section */
> -#define IB_USER_MAD_REGISTER_AGENT	_IOWR(RDMA_IOCTL_MAGIC, 0x01, struct ib_user_mad_reg_req)
> -#define IB_USER_MAD_UNREGISTER_AGENT	_IOW(RDMA_IOCTL_MAGIC,  0x02, __u32)
> -#define IB_USER_MAD_ENABLE_PKEY		_IO(RDMA_IOCTL_MAGIC,   0x03)
> -#define IB_USER_MAD_REGISTER_AGENT2	_IOWR(RDMA_IOCTL_MAGIC, 0x04, struct ib_user_mad_reg_req2)

These general lines shouldn't be touched right?

Jason

