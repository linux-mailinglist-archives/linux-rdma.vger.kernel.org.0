Return-Path: <linux-rdma+bounces-21239-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDqUMjhfFGqgMwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21239-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:39:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE55CBCE7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1F3E3004F3D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C73A9DA4;
	Mon, 25 May 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGcI4LOJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4664381B13
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719990; cv=fail; b=PDgCa9bC1vdcH5lPcusIYtQn0ZY6/WAreGt3qG9Ix6iZhXgSAMQSM7Q8aY0R5qn9jVHW5hK1bbQICrgbx1+Tq2xB63+f9Vc7TvilNkx3eMP0M9QSsyU3QBgoey7CHIeEdfV9R9a5HOnHkgzhzZPv4iGJlzrRpKO4ODYAjfH74+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719990; c=relaxed/simple;
	bh=H6cy0qzuobYWXnifuu78Ens21MwxbLhIpOPqkXuEUjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhlFZotrRLLTLZDecoCPxN57eOt/GZ0GbdxqpbccajeBf2LCgnh2X5U6cdxCMylnEwIlGMnB3LhR9r2GueeO/W2zNaXTYfEdQ61AAyYDkANeKtF/cvhc8XWhhAFExQpFQdukSxpvWSPY4AO8vmpJ1sYtpg8jJHt7mO8mrxEQ17c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGcI4LOJ; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciQUksOj5Y88w7ErePpkMh5fyFcGMJPSNz6qokzAHhgVOIZybDdO37ORUamDJboiaxP01hIpRlD7/ep9mwoEehbaPaC1gE8qmvycF0stUv9J8pKZUDKiQlWfUNv7Y15l1h6W/VN0uWAgjbLBnCg8G3M6klZ8xHwHSOAqJOq3vK18lr6K40fRXvqt2XDCBdaFPctHVFjwVeOlSN0i47x9hXMBMbMYrDApOWcnHgV5gRRxTSxiDR6jjB7QR9hD4UFTgzK5J/7LqcKvW796qanJBu5jxwNAgy/2z5N/XhSlDee7XZUi/FJN6k5qtO4I0iCuDuiqvTZ1LGELTomj/3e8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hvGMW4SMUHqokrOkkGjyQTpilqsMfkDubkcYkcYWWo=;
 b=M0oNUrAiV0jhBRp55jMihTnb1gVW2BumGzYodK+RlIznlQmowtWLpv0nZcMRwtbhsNcIhjhdCG4af/D7gbr3Tps8S3Wov5TJyyE2UGxNLjWpm6VKg0lF5hx1K60teWmJ5dkNZB7pdLtiRdVtrDhgqaKB8MpxSlDcIbUvuGUlCcWLTZeUP7Kkwuhjal4Q2ZZcZy1qnwGZA56ybVP/u4t5mPfuZaoeGLvWtsewj4oByGkjRx2053eljeIX2G4adY3t1t0jY1aELxgg93qFYjzMi/rh2HnH1YXn59PlrY9ww4+8p06c8pqcCJdFV6HXX1k1iyFpJsKy+CXKLH461HH4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hvGMW4SMUHqokrOkkGjyQTpilqsMfkDubkcYkcYWWo=;
 b=aGcI4LOJRrJB0FvOaSYHF/uSV1niBmpy+LcbPxejdxA2uSnOC07H4sZa57DomSuOYIVkxZ67cFa0j+ImLmMd79p+Y7cYm04m/VV+cNaLkrL2MElurNqCXQ6gRE8nvQgEhV2q2Mtkmv3mTa4zVTfSdsRRFq7OoSWIQcidfYoEufGX3TxH47pj1up6e83P1OTO7UCwIPjZm/TAfGbq+bhMR2HIFc9zJAx9qxefYVzcBpsE5BCT4ms9QuY/4a/RQAkcw6Oipt8Ww3aYwzDBniMkKrIYtWv/xbi3aVnTKWw2e+rvZwec6Nvc+81M4oABXfv9cGsHfHsjHy6gmC1g+kx5ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:39:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:39:46 +0000
Date: Mon, 25 May 2026 11:39:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-rc 0/3] RDMA/hns: Misc fixes
Message-ID: <20260525143944.GB2457236@nvidia.com>
References: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: YT4PR01CA0422.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f9b527-179f-4987-8e57-08deba6b7743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bKRwDwpbcy/P1pdN8sPMFyAV2Syrkf0oadWN4F/ltSAcSOcnlXI815sILzFTzTeOq5NGwI7mmhn8ZCubRaaqHyUomVhy2KWOq8g5ejcfLg4uc8qt0CVKdlUP0f7r9NbksYQwDwbl5B4c1k/ivHIzwTVIfEhXsnP/VRpZ0jHvo+h650kQ1yQaXyc+F/Ufzzv9lBOokMhhwwFxBF0dPZI+Pc45mVylYyQnmehc9UVUYEkK1dyoAha/p7ohYWOhpN5yyfqooR7CEPTGbu/dXBKsJNMF0OBMJmJV0hPXOn5XJQhiY0fZ8DdDRu5VVSj3sHjUP3lgMOnKAwf4ok0zYTW3OO40FbtmHiDU0wBTnMJucyHTwiBtDqi6JAeriXgDNFtEYnRDKU3p4ndtU6YshbsUARCT59ctKraSRCHeInNn9gIrpqMLXJ10sd2+K1iFCVX0jAko11Nw4iorDmGD16/FuqbaHiJs1pNZS8xYf5O47pCus0pLnL1dpoG1ibD3ock6cG+mSpH4ZKBVQr+Ist8iWxOW3DOkm46M9iObwGuD3wosZBAuPoCylwbPpEY9jNlQ6WtAg3bufpGDqErg6Olui0f5zOFGedF1EafBXv4eaTFQ+ydpK/xJvJreyHVpJQ7NOTVM1+MnBfQ59KIRAmLNGGmzEb7qdttkq0mTwI/nV3rViSFjLZB5fDZRzp1gp/Rx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhuKAW6Yo/PytOSGczK+F7LKwy1QCNl66+tSESVbz9u7BvmLi8fmDC5uVkS5?=
 =?us-ascii?Q?zvXJk+oK7KTthmrgSLZIDRovtCRkgin7plsjHP6SZ96bRgR6oUbT8YFXymaE?=
 =?us-ascii?Q?Pk7d9U8T7SRsSmZiJt8D6q18nWZE/RtzKXOJ/PiijVlV405PBTwnAkQrakHH?=
 =?us-ascii?Q?xutsHU3KRKNKLgVbOABdjYSI30+y+O/Vwjc2l90C1+jLG4vOLL0pNG87XJ12?=
 =?us-ascii?Q?f7dKDdu+3I3QGUlPOT5E83sC2gKh1QuYLhXHhDTTmTrSwOIF7gXYjVhQssw1?=
 =?us-ascii?Q?EJFiEac1lpgm02TqOqFu/wdBI2hATGY//tn4kV4Ql7AOsFe6vaZRwhU/yihc?=
 =?us-ascii?Q?ANvlkcorJMH2FCpeAJswh0zBH9/gtcRCaZp7zfs2VHmbDV5qcOoHNbBAJd6X?=
 =?us-ascii?Q?RXDTHaUWqU9gFopbsO2meBH5FzfnYgvY11HmDczh44h7L4t1/4Yk9gsY79Zx?=
 =?us-ascii?Q?ZwPL1cpwJXFIVKsIpRxCI63WCXtxFZSfBeFq1HhwMSOoyN6R2188kNjb+luf?=
 =?us-ascii?Q?imHuMmZtqCE+lTONG4SUAk+yazemgaAeojmKXFC4K3EK1bXlpnX7eVvG1ATM?=
 =?us-ascii?Q?N8glKRFVyj+wPAcM6hsfD9JhXjRZpEGS4ArUavS2U9OUOj/MwPoDMrGpXQ2A?=
 =?us-ascii?Q?goeT3dfcsmLwu6qZ4TXqjN8mwJfOJqf1Oyv75qa43s1o2pDzId002i3d4lQ7?=
 =?us-ascii?Q?T9o2F0ZyMkGzYEdoC8Gh06no5nkkjBT+YQtExLq7tjcdYpB3UO3+NgGXyO98?=
 =?us-ascii?Q?i72yYidlD+KnuT4esWHDLRUBF/xSR1dsQ5jQaGMFoC8LuR+9Mfhn8F6cHXZv?=
 =?us-ascii?Q?hBJHYD1v4HCligyIXB0q69GYdYkCdaPYhf64N9YI6PxZXrYJh628Tji/efyj?=
 =?us-ascii?Q?Jeq6U+jHRqKyIGIwHLy6F5wnHuqarkTb7S4beqDmjT+KdR14PHZERPA+cdTK?=
 =?us-ascii?Q?xwI+yTalGjPrTD0BhpMZfLUHxif8gO5mETlcuOLfL2kp/BxawE0fTVrEXCXo?=
 =?us-ascii?Q?ktq4DcEY7uNLp/3+SpPOEWgmVIExkLH+mT8I/Z053yWl2VTrWT8xA3ij/mXI?=
 =?us-ascii?Q?xH4nAZkh+L7DFmFKag1DJ1HL38HlXt5Ogh7/N8/rOfGrCDOcoa2uwbAse6P4?=
 =?us-ascii?Q?p8uh4vnoTLzUlrPZhHv+SBo9+jfRecEZzPMt0cslDXqZdccRTfzEtZXRUY7c?=
 =?us-ascii?Q?JvLZ4+X8/BmdUPfiHGOmlBAaNdZN0JTjNcw0vC9akhZrbsOB9YX59CU0fIgv?=
 =?us-ascii?Q?l1AIs4vEir4M19KkhXSG12DgEs2y9hBSnCoXNHB3uddjea9jRLDG9Op/0QbV?=
 =?us-ascii?Q?GkXUUJzH7+Iq2c6LWF0dL7I6Gjdwl1c2zAc0w0pSOPUNpA3LR+sgcVmHMhZz?=
 =?us-ascii?Q?oZZBoLyRfWrlGZZ+7dO9EwkGJ8thtD2HqKSSxdFDGjRh4eUdDcGmiLi7R23F?=
 =?us-ascii?Q?drZqp830tMYeMhGN8BUuIVxPZxOf6Zo0JonpApfN+ohawRHXgW2WGdmUbYba?=
 =?us-ascii?Q?r0tAV3DCgoNhXBbBHz0Ib0Fd1zZxTIrbYA2f9/n3/Hz25XAsFeapIrfxMG2H?=
 =?us-ascii?Q?UFEBaHs0D9A0HmdPOwCrrxmMGmBSK3nay4sfnN6dMW7hlBhe7aVCYVsjru2D?=
 =?us-ascii?Q?bmCJu+FWDhxtmxdBOKkivvsANWfs0hoG9TyyZuW85tGdkQitvPoCAAItuyhB?=
 =?us-ascii?Q?FYBNUPC4aeqjkafM5aENUGoxcT/WAdJL5J/M5jtLRbIEcxAl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f9b527-179f-4987-8e57-08deba6b7743
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:39:45.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8df8Zu0Didm1dcGjVQPaoYzAUgkt53N/KRZHV4y6/wa7lEYTKd1IK/r4RtI2wqS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21239-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6BFE55CBCE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 01:57:56PM +0800, Junxian Huang wrote:
> This patchset contains servral fixes for hns.
> 
> Lianfa Weng (2):
>   RDMA/hns: Fix warning in poll cq direct mode
>   RDMA/hns: Fix log flood after cmd_mbox failure

I picked up these to into for-next

Thanks,
Jason

