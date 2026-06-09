Return-Path: <linux-rdma+bounces-22030-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l1jSGctjKGq0DAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22030-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:04:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D0663810
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=FvK1HmZ1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22030-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22030-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51BE5302759C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FED3CF1E9;
	Tue,  9 Jun 2026 19:04:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B03859F6
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 19:04:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031880; cv=fail; b=ExyIWVZ7HQsnnXbUiss/xWnZBU+SayzmMFtYgYmI1CphMnuhLSyeJvVM2YayblsBvjsYNHTODLOEP3u7689nrogxU4MBcM8Q0PoG/bjWsucHmsCrGpK+/KWFwlB9AJXR6vHMwRppxEqNxUqnVfcvBmPjprzF8XzlRCsDXDp1jEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031880; c=relaxed/simple;
	bh=StNu5we6LC7ucu2RN+Nvjo1AjbXfYPL+/jQEm9XgKK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LB017qkki3aI72/7Uty9POsZwuNyyRIe+cDyFERkk6SOyV8OHoiA++zO5XBn+G32jsgPkV1pIPdsJtxRMe0+P+sE5A0RABaH6AItpN3+sPK+ut6pOf0jVFsqI5wF5pA8f+wqdr4vmAWHNXqb3VNN+0gz5rB01ayWtN+KwNP102g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FvK1HmZ1; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJ7JE1wjv6WfR0usu3PP55bjkMQwTrOSrVU4j75NTMgyjYvNVM75+PXwN+fdI/AKWmm5J6N2ixnP7s+PyiyNyFHA1CzHDLz1ASI4UtyBrCfJ+SeYgbdhiC/Ow4S0upETNlxJN+zDhewqA2Z3geDo7PM8OiXiHQ/uPcecRujAb+nz6uC0eJyxD0jwvr5nEWqhBTx2yU2cjVfSYEIOGkGfgdFOrz6yk1J0VjZ9/iSiiqPcn/ahSI3TNfk7X1kwVHVO1dSrkfSMuCrjybelmiyVbAoRbxHJQU///yYUfBoQx37Jhdf0lMHIuAp1uGxJ4pd6ucdz1mzxRxLkdIL5GrejXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R34Q/ZjgYeK1xYBlH/Rpll9a6dg5XQYWj64TpX0uKBw=;
 b=bIofG0wYrWsMBBW6EQ2QTmjnGbHCt4hwmFFYa1w9OzGU3mPCp6UP1y40jKwqfUxb8HvwOmxrlpbZV6ohD9gSgjlX7qg/S9mm4VAjELza5mihR3ipS2xU7CTba1Pef1Ga6rmiRYWqAxozHKgn59eCo2HLk5SIgPl05Bj8AozK0k+99R0HIVia879jVzMRzxRc2XaqzicXPRX/S44OTjYBngOMCXAyYzujffkjMpxTQOcFlU+6jF3ygq3QaaDfdKDdGXeDv9RDwnLvJZqQ9nqBAZglTmUic5pM1czfEI7c4flPEXd7a62ZG1WzeDIai/HQFu0mIF+83339HTV8h76w1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R34Q/ZjgYeK1xYBlH/Rpll9a6dg5XQYWj64TpX0uKBw=;
 b=FvK1HmZ1CpStiLdJsKWq+jw9qDUxK8l7PCRZGtyG49LuxUFwjISKPqH2gY918+AW/Ucn/t6pPODvy1DRgAZNd0twNp6wOLy1oaR+m8h2UmK02Nl9w6OfAl2N1osQJUaq2ks5QGr7LcARhjz3z4uygCQtHVGGUu+ENLxFk4SSCTQptqHQz0UTyZaejOHPCR9eELKQoxz9X0PhLd/p2J31KJlZtR6/+/Q9/Hy1k4k+D4oWUqc2SmMSf8hts/bha2/ICOQsrK3kC2SEkhowNucBTXM8OhL1y7mJzMdNrtO+iG78bN5xzIVdLc/MFiTK5TPqPn3Zo03HH83TNzGpiduvIA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 19:04:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 19:04:28 +0000
Date: Tue, 9 Jun 2026 16:04:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tom Sela <tomsela@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Report 800 and 1600 Gbps link speed
Message-ID: <20260609190427.GA587646@nvidia.com>
References: <20260608083736.48454-1-tomsela@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608083736.48454-1-tomsela@amazon.com>
X-ClientProxiedBy: YT4PR01CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e41f7b-4e87-4165-dbf6-08dec659ee55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HmvMe+GmOysZAvkvkCX7GN31a7jBKKsVLWIjdF3gojBt+MaydvXK5rqPfhGcQU8l3ML5aMj17h7C7QHFH1snAPL1E2lTdRrhqcPL20t88Siw4+vjj2RV9UY1dRa4vkr3bR6ZqD2PyVE0CDZH0b/wJ8lUgzdUTQQ4CEYOkXXo1cByLHS81y9mHxFCdzwDBHRSeG9qc+nuJ/v+lV0CFzmA1LUhIbIjnHYniy6WxTBQiS/UdvNflq0JCzYpX3Ejc8r5wMrsv7B40FnhWljlfJFRzox/gFECrJ8gTDvSZ/4bZ8tp2O5Y4AhlMZXro+BSoyUwdp3KTI5zz+eXStGfuT8pL+8VwvyDtFp7yp/yjTzEh+hUNcDAAs9TEnQTIwNpgSJI46kGmMADAooRFicmJy5k8DYVyP8bivpgKI+aWI4vrsc2qPZyfe2/AXMeD2KCm2n3F8SX5fF9ymJ3rWD6BoWTHraBEdnLxL1aPTrude0OD8qZmn0hXUZyuvShf6eF0d9P+F0Igg5OD2TdaNvjmxYcFbqmS3Qvl6jpp+dWWmt9h6UMPuyBML9bif4tme6PtkXVrDBMWCOu5fkjrbS0tsnQOPJhWC5HiPRifNWZrZWFRxsXg28YE7MsKtQoEMT08xW0X+mPymeKv5XjANQJOnGZq5/aRPrGU83926vglvB/6DCnIZxmVlQy2C8+QZZJQ9JX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1PiwTaE49rPXdHHA9BVev7hvaeLce5oeqmQd9Dy1doS+5caO1/EpnpbuNkmf?=
 =?us-ascii?Q?G9vzd/E3EZs1TPuzMAb2hvFNt2j/X2F6XAt3pbt1BTqRip1KNq4dmBPYwSVg?=
 =?us-ascii?Q?8iQQ5FO1G6K1hOhUsYMHpCl6T9ELZD53HT5qRfzRlyGkuUQcOzF2Y4gLtg2t?=
 =?us-ascii?Q?94J2XH2IFL4XPacLmxpG0NCfCeWmPqragd58FOIBT2B1MgSHYys9DrwzvPwd?=
 =?us-ascii?Q?Wq/17kbpnXcAFdRAb1cFS1WYBl2pVpq7YRKlrVBgO2OaHtFkwzFcgUrerwbw?=
 =?us-ascii?Q?aivFpS6yI1p9GvB62SbWKqEtSlNLMN/Uv74pQvKRqVn0K3TKI/7PeVkBRTWB?=
 =?us-ascii?Q?26gMPx7K/B6SdMvStL6y+JbfW9jWbBJ20ZOmnJrl7VJ4xgBhx6Qdq9DyqeHx?=
 =?us-ascii?Q?nrhHxI+o9pHfWvU+9p4orwTBOud2dwlf3dOvLsl7umvtKXCuWkNXzpL5tfT4?=
 =?us-ascii?Q?ANfvf2q393gIB5C1ppUuvoVq93IRvSHq2i9RUOzlXoz4fAOvnApJdWtFsmE5?=
 =?us-ascii?Q?6kwc56CPepqGqWoGH9umGF1HjGTcCPirv4//SJFRaMt6xuVZYM3SWbZrveTd?=
 =?us-ascii?Q?/7l2ap27SQiVpeNP+Ei/DLI2o0bXWc0U25Nt+ublAJAdpO185FagxIeU7IoY?=
 =?us-ascii?Q?Ru3FsO83+4e8+GxyZmlyzxOn43QOJ/lmz240OjY+GpLD1c+YYBJmOBupAxcf?=
 =?us-ascii?Q?kVDIADpLX+gBp/plWH100osaYa2xxHszrxAAfzAG8xig6FFHrIiN8DqJHA5e?=
 =?us-ascii?Q?srlEOYIQE18OGKeRPHTnev8fStkTRxV5cEltqNcN+jaIGHvB87r9NuYYGDov?=
 =?us-ascii?Q?DNEuFZHKwXgnlx/VrI8r9Y5nfGimY3I7kl0fCYqYOaIo44S8GCQcfrflFaem?=
 =?us-ascii?Q?ZsHXhbtJwRrRAIBgdscOj3gucCLp6OnUk6OFRDdj+NC7siOFQ8BhWn2il3tl?=
 =?us-ascii?Q?V2aGIpRqO0CjWalca4IpPSkXNSE8ml2Igmdyt5u67Tan9kaXqH/8Ha9OAZXC?=
 =?us-ascii?Q?kE7j09P8IGBI6KB9c6JJC4t2w6LMW0Xf6Ftswx9IPWf9+ihjkwFd06Kk/EBX?=
 =?us-ascii?Q?RV6kjtiWD9Ebj2/SH6crIe5IqJhH7tBlkxfk5IdvjT/hQcXJz25TniqqiqoT?=
 =?us-ascii?Q?+ZyNK5iNmZHeHIcB7GBZqdcQuStk8cK/hgVFUvTEGzrwfDYQ02sM593+l78M?=
 =?us-ascii?Q?0cIntHDCOa/2hxxXFHNlGO49SU0fin4MqIlAWVoy0HRgL+kcUaknSvabDCec?=
 =?us-ascii?Q?eJe7Pi3MZb9bcOkeX035DJz8C6Kj+Rgv4CtGhIH4V6CT1R70toSdA06maBTS?=
 =?us-ascii?Q?a6uQt8mujAzx5na8lUTjx2b/chiMCW93EhmkWo67d+t5rf7LXPErTWvlozHR?=
 =?us-ascii?Q?XtLaa0x9MBeMHqiVx0F2YnGvopkJbhbPU5Grgu6vqGpwcGl1ydKvST6Nh4do?=
 =?us-ascii?Q?BMeAGyTSkCC8RHeC0oM7qQMF6buYRcRcXSb91swop2UrX61lJtu143DWGKfq?=
 =?us-ascii?Q?8sTNmRYSUqo1lGrsCyJy35QO1unxYi7YfazizHo9sXfT7TjYJyKh3eCiXHW8?=
 =?us-ascii?Q?IHnebWvJSoRSBEZVbNjGLb5NGWaX1sE9Pe70AZ6tEo+BGMUoWmvXuYA28Tg7?=
 =?us-ascii?Q?0HcK7BKeMa/fwP9Vgm6UFOpS8spSXFhDGFI9yN2OXQN0AxTl/webZl/XeuXj?=
 =?us-ascii?Q?AXqJU67UBxltp2aPdxPlu//0FiGN4jjgexd1kr68hanMBofC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e41f7b-4e87-4165-dbf6-08dec659ee55
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:04:28.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXB8S70G0TnEQEPJ2h9aGz00fZ/zyjKISFZBQ1fDm/sgiSQYn7EbprJ9c7vF4+O2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22030-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tomsela@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D91D0663810

On Mon, Jun 08, 2026 at 08:37:36AM +0000, Tom Sela wrote:
> Add support for reporting 800 Gbps as 8X NDR and 1600 Gbps as 8X XDR
> link speeds.
> 
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Tom Sela <tomsela@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied to for-next thanks

Jason

