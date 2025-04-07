Return-Path: <linux-rdma+bounces-9200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E7EA7E925
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 19:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44B33B8ED9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16E21578D;
	Mon,  7 Apr 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyJbCYNA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3C1FCFF1
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048474; cv=fail; b=fDxuPQZPyZhhEEX7IGG7b8FVMc1ycC1r5Qqf/ehsN7hkUKi0Zld0to8PLsnKJdGw5vzPwQYDQ8Z6pQ/dpOWF8Q2FHQ13cbqHRFFJ1utSvewpYq2o9qax9Ev8w0Vh0IWcNglQwZxlgINFcKIQ8Z/ktdB6d3OckUnhV3mUg3Q2jC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048474; c=relaxed/simple;
	bh=ETfwNJs0fyXuFT1UEvl3zDJU5kp/rq/PlgrQktVIOGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8rZNbN2LfZC8mYmEcoz/aCuO9LRDh+0V1HjD+BBI30VDmyvYSD+otGTt+E3VEJhfWEw1fdhsMI0IxwV3bflQ8mNWxH3EgRWzsdn5LE+RpEVJH+WkstSzWk38d10A0MJZwMRB9oANBBqqu3jSwCh0tNGm1e20UhakHaoGFwsZtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cyJbCYNA; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA01MeP9f2LbQUdgP0iPP6EOvkhLjQmFHgrBuzrc1CJBIWRNuAtLdiK/xm70o9Dm2oM9it/FHaaFuRYwtIcaXATuQY0wyxazOm295tZ/RuTiAbhUVJ0jF57y47okkwRIAXHo21wrtJ/YYrO1aOiGeeeKqFoQUQwUBgCweezI1Vs6A5rniVowmGmJrOWMJHX2U3e68r9sLUpEKknUvmUKwmBpsUWXNnCDIZvMTJIHqtB1iz9h0zj8LNgiNKxeD9fdlmqE2n49hYE41CwFramxffvVak25CeNAQM9vEsWHBq5Rjyp3NnUPcBC4nZT1x5GLjULmyAXBABwdCrA817NkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8S/NRc+gnLE+dnL4cb1OGSHZC+Ar7Xsox4EkK5eIA0=;
 b=mIgOZazI/dUv5Vs8OrYEn12L+QLfkw7oqdpLMxZFbVnrmAG0gP2UskIQQDOD5xWMrJFM1+krFtnGK5EB1zlDFsR0313iEXex9GDRNgZqGioYB/E61BuX1cBgeC1S+r6qYcCQs9i7lsGo/bkWjfIEHq20mZnHFYZS7PkUbFwRaaHpxAbOrgbCQpiSXQjq+GH9/KJsUv66aAtohPNYtCL/6EIlXq9qnAR6/NRFlq1t2UGQhKbagEkyZezzStkNua0QZy6f6ulTEYHwHpsME8UDtH7twoP182fBO0z5LS11CCyo7mB13i8nXhiFoZtq7kIid0x+FjN+1hRcNqqNyO9/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8S/NRc+gnLE+dnL4cb1OGSHZC+Ar7Xsox4EkK5eIA0=;
 b=cyJbCYNAVBElAshTn4QHq5wJedd/2tOO5Hp+6ld6IgdmxrxHGSxtKOVCnlb255UpgN1c8wo5PHwSWftyYZxzQOI12aaJo+4BkolcoDAiwBDTwBmHpPrQodUDUN+IMvHDH5xB7w9rH50d4huJiXbp6GjcXgDD9fbZ8XMTCkfKG3WUFF3ttJ0n1hxzM5D/gMmH00NgF/R8Ze4KunMr5Xhxfyd0sShyfpJpnmTEAj3SQWcPSJY//E0BFTLCtwqczv3UiDUEKEUsuWvq3slGes/iaQ0oKVeSZMqDFYip7VYIk4lL7X7tnIY8PN2cfYX4089xYblmQ7qF7kpmqHz1yB801g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 17:54:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 17:54:28 +0000
Date: Mon, 7 Apr 2025 14:54:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Fix budget handling of
 notification queue
Message-ID: <20250407175426.GA1729789@nvidia.com>
References: <20250324040935.90182-1-kalesh-anakkur.purayil@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324040935.90182-1-kalesh-anakkur.purayil@broadcom.com>
X-ClientProxiedBy: BN9PR03CA0738.namprd03.prod.outlook.com
 (2603:10b6:408:110::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2ceabc-e87e-46bf-7aab-08dd75fd3d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8MwLNSw42DYWRZ8L+LgeCAwHLen7PhbkYlJHqmWimzdumtMhGYhyM2I5g9W1?=
 =?us-ascii?Q?ufmXKSOCr8qYeHINq6pW/yXwHadnARQHskjixjJsJj1tWRbCyUvuE4iJfvhp?=
 =?us-ascii?Q?a4hcKRJNLEzMWsbFsGGh2F6mecz7zCmDbi23zjoJg1Od546EXTP5/j00KbKD?=
 =?us-ascii?Q?MiQbNOQxlDPg1e65FMQTMrIXD81IBfdYH3qSyPacp7BPe3hnZ7fsQtiYeMTI?=
 =?us-ascii?Q?e+MAHWKbo62oUCc3DKgU7PTdXZ4Pk8RejaZkx73s5At6LqCRxEIsMg5GzUg8?=
 =?us-ascii?Q?g6L6THqukM7IWoushOKKNDhlg+TOZp8xSJM+d2RNP2HJnwgpZL/D9uM2r9jL?=
 =?us-ascii?Q?C/tAQEy03O7yQKPN+bn4NVJaViOjKvwFzgPp5E54iWI0w9BFdnZunHXATCl/?=
 =?us-ascii?Q?hgERLOp4hG6CdnZiL/H/WWEy7m0nNzMZ1xP0cJoTHpJKC/gZSalNI8pjkHhW?=
 =?us-ascii?Q?NaORT9ftXMI+sk8OcOqiFLZpAnUm4S1hHOO3TIHSr9zKPj7rd/b0uQ7Feg7Y?=
 =?us-ascii?Q?p4r4iaUP413Ur/BdgcBwcmYLv5yyxqHG/p3vLAFljLpL7EBFK79LPWLFCQJz?=
 =?us-ascii?Q?KjLwaEcxa7kE1YQ184/BuYNF0uiWbn8xiLLOkfQAApVuTvcPTzH0wddI3fLA?=
 =?us-ascii?Q?2mV8NH4mbEFJDI3T7XNgZR1dZN0JTMvE+pMYzSO6YLEsSapKH1gR71H0RTyW?=
 =?us-ascii?Q?IFynR2Iu9bT8fKf3dYBg2/LS3uDP96zjmbia9RQwPF942FbP3wvWUuYNwgjv?=
 =?us-ascii?Q?tjqmGLr9uu80oH7YghKTXMYGimyPvack14uLVi8f9nggefoIMIU/V/63CoT/?=
 =?us-ascii?Q?sVUTh4gu3ppCN9Rd+c5WPRvhQRB55OKeP+ydOikVemwJRAJoP+4aUAlSm15n?=
 =?us-ascii?Q?gIrUwyoxncZFMcQPZP7+f96i7teESCcZodimlTNeKBwfrC1tPNaoU6AVFsoj?=
 =?us-ascii?Q?ouHCWndSWxFDUuqytnOALgDhrcuZkqFQQOmKfUnjivfesaoelq0d2V6ebc0v?=
 =?us-ascii?Q?KWPYuzzGn72KAEJsdvlSXjmy8wmJlNdQu04OYbcnST/FbwhGXSgV2LSHK4w0?=
 =?us-ascii?Q?oKsoLNMGIeDWSgbfVEhjXfLKIMdNmEv2B15UcFPF286PLTO6Y8y0jBlAE1ei?=
 =?us-ascii?Q?Eh2w5kp9bFtXxz4+MtutEwezI1RpwRczcMSUPmEFASiuJdgOsHA3CWAuDtV/?=
 =?us-ascii?Q?OMLrIv1LHpOz1uat4BAj/k+V7PnaOciI1PogeUZykJouYK/Rl5pcfNACR6Ll?=
 =?us-ascii?Q?fNWBGeVnK0AzUEL2l9+lTWD4URFUAaXuYRkTzs9p43AqIXnl1Cotn82JaByf?=
 =?us-ascii?Q?ltnUiauWkkSf/ClvXvMzn9mwhW/jCKoYtowbtEf4EJJcYLUKmYWfSM4Z1uuG?=
 =?us-ascii?Q?T0/lnMdA9OpTvP7ltJlNDDrvKGzX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?koa4TnxamTuZk2QliiRU6hnr+IBv2dCY5klUZ3kgBwPaRYQEoRTGQ4FBHM+J?=
 =?us-ascii?Q?fKyozSUcU2yMGBJ3WJzfOmG8Np1zy3Cu0YHnsiXk7MVanXT6ZnKIkwspjftR?=
 =?us-ascii?Q?YjW+j3OwiXBPcfDVX+tcAiYGeRKSYhWf5WK7/OM7Ufiul1KL0MEjYM7Y84EC?=
 =?us-ascii?Q?MVYME6+CzRNH+yuajK4Uyh9NEiKyLMX0dAn91XQ+VqqJTW8BpJBmIZPj72EZ?=
 =?us-ascii?Q?3Z5AnFz8xY34rlcgr7PYiz71+4vGk6HpJEswYH3jtp0eelWpK/RVE2aDZlE+?=
 =?us-ascii?Q?fI/KsfSCZtkByyW3P6Zb64YdTpAawrMTK/XE4DHubo2bcRhMrONIIhV47/IX?=
 =?us-ascii?Q?0/k1+kUWmS1feXkGkvAM5+XS93VPkSdwsVb7maaCBV1ypoclqI5L+zwm6YRi?=
 =?us-ascii?Q?Ke3fkbmKdoXxH9e3ztzb4W+EiZhFiQqa9A5En1uwMvgmQ/J4TbkpnH7ISoY7?=
 =?us-ascii?Q?fZENIGmHowT3f9iXRgO3c6pO09DAqkw/KVlTkKIvS3Xgdg/6FBWSj4kf15WZ?=
 =?us-ascii?Q?HPLzYWK2t/rp3hjKfLNDqmN26Wh0tbt+sEh3fFbZZbkWO2Mg2xWk7x2rxRMl?=
 =?us-ascii?Q?gtrZldOGvY7yyedXKGzgLxGu1HzX8VSr2Y58HSkZn8T9R/gZFEH73cI59QnK?=
 =?us-ascii?Q?Qdh/fko4t1w3vQKYpCyeqfdxkjPu9gd2Z7WPK0E4FB4SRTvZklABZC33H1u3?=
 =?us-ascii?Q?SBAEAmBDagz3wP0795tJEBU2nibFm417QR6g2KK69ifPHlomoFcjkbp3b3A3?=
 =?us-ascii?Q?4mKLJUdaRsrKRwsOrpbntQz19ZLC2Ko8x5SFcDr4RWArICzuBIP9gu2KjPZo?=
 =?us-ascii?Q?/y3WiuLKDm8JXVM7KIMNf9LDofFabW1wiK6LprIERXg1koN6HlUbnQp+QlWo?=
 =?us-ascii?Q?Ho0smHr37iabw44jANnwYmydIDAxV0dEHw+HGVGYvUpaHpijiVYFd7NQ+AC5?=
 =?us-ascii?Q?ubYhtUt3GTS+tXTraQ5yS9rqW1FGdKfXmcXNLYYxt3SE6JdfEKoqAMp8Z7MJ?=
 =?us-ascii?Q?OzHO2Ei3Om+Crevdfz5FHPb9jwABTmSyiPms+mtTenHriYIcN0U7S/N5Xg0c?=
 =?us-ascii?Q?AjP17+qFPcz+OJnFlaKqPkMvUptvFeOp/WaIBSmGAf7rlcM9BTo/iiPLPao9?=
 =?us-ascii?Q?iVd+1cKvD+2gDe5Y8vmRdpBvnSTo3q9OpDfdp2+mO2YUM7Sdp07VDL96hB0X?=
 =?us-ascii?Q?ki7o0jtb1haPiHlOkZZrpXc4SGsMByzf/gJtqWQOPbwOq5D9Nk6WE+R0Eld6?=
 =?us-ascii?Q?5BDNibOpelPbG9UUmYICE9of80MJrzLMEb9EhBHu6CS7mGqF8LPLKoIpXmaQ?=
 =?us-ascii?Q?Ci2oxUM1QueXeLyMviCRfhur/kYIliAAHG8WYw4qoJmsfb/SdlAdIjXMpoTX?=
 =?us-ascii?Q?MaOAmuXdfY2hV1lAjrUelMN+ka2ZO32W+hnmzmdoSRq6riwwoMN8yEHdQOjt?=
 =?us-ascii?Q?dsb6ivV+g4sbWrLTAXDWh7AvRFbp+5viNO3uSf0GZi25j9DO7uNtDIKFdUgf?=
 =?us-ascii?Q?0z6WWamtT7Ay+JIAwoQWoJbV6KuBsSsac+E24YlNpM4D9vbnxHLU0AEw7YLU?=
 =?us-ascii?Q?3y3yJSOqbnVoAEVfYnL+2vh2B1aGzt5/oI8/pAut?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2ceabc-e87e-46bf-7aab-08dd75fd3d9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:54:28.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0yKzOpCWc9KGDFLh0JX8tyIZY1kgCLZQMIwlW79rBZlOjFoEYTLIGoI/HT54RWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

On Mon, Mar 24, 2025 at 09:39:35AM +0530, Kalesh AP wrote:
> From: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> The cited commit in Fixes tag introduced a bug which can cause hang
> of completion queue processing because of notification queue budget
> goes to zero.
> 
> Found while doing nfs over rdma mount and umount.
> Below message is noticed because of the existing bug.
> 
> kernel: cm_destroy_id_wait_timeout: cm_id=00000000ff6c6cc6 timed out. state 11 -> 0, refcnt=1
> 
> Fix to handle this issue -
> Driver will not change nq->budget upon create and destroy of cq and srq
> rdma resources.
> 
> Fixes: cb97b377a135 ("RDMA/bnxt_re: Refurbish CQ to NQ hash calculation")
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied to for-rc, thanks

Jason

