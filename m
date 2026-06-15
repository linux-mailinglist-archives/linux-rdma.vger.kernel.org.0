Return-Path: <linux-rdma+bounces-22231-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qMRoDPDqL2oAJAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22231-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:07:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4C685FA3
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:07:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=drKHsFtb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22231-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22231-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C628E3016EFC
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C13E5A00;
	Mon, 15 Jun 2026 12:03:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DC3E3D9A;
	Mon, 15 Jun 2026 12:03:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524994; cv=fail; b=FsORCzoEYnKi9CiJmS7B3zOfkLRvf9SZcFrQkXG3uhY2EFP+UK37kiYPrcC1puPgiU0n/XMVvLZstNKlZ60EAWqMgFJEq9XAKcY6DMXkp3R0VEaUeP8K+8vpR9xnxsSBCfz3lHpL4HbAjjSyzoYTLjOlaw0v2xtO6lhMzX8bWSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524994; c=relaxed/simple;
	bh=BEyQEwqi4zacXmb3ad2vAKdv23Mj/Uuuu/LFIIlYEkg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bGcNq5jCFx75h1TZ7U7RQCfSrwSeBGmodXClotv90ev1p1p/NftUs9+tR3oSXfB5qSGsGI0liSgCwg1xfBrMOIXMM3VMCMr5J/OFEWTiB18HXtinfLnuLSjuXeigU770GAkDiR7+DcjKTEh8RGWBoBcO4EH3na/zxhAMWz2BKvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drKHsFtb; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEro0hrt2dsz7+n6qlTBhi7yR2d+VUG1owGBdE7mAoKbvvWbvz1au4ZaO+ZsssPxjyMa82EfYjPtUNd5EExsPBlC4wD53HrUM+GdbsNZspeiR7UhSm4DSjjX5YSLODY+tMlzXCnH2i+uzT+3kH1ZGsXwpcsRGLRbk93kvNjO+zaShzF3HBb1K3zgzdoJb34S/et5ptuw5C0O8VLVG2d1gKXHdZkGNwwbj4FkX+hkbqTllkgRztJbYr9JA/ZOOYdNfDOaC4Ee5ukz2oV4sboeKmd91tBfe3CuXFerSbSZNKARDfZJ9mKVhJpkzyWviHhZtagCOhoox2iwe7A9aK9f9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6msL3WKf7vn/sLz0ANyPMxjAH283pOFfY24lajfuwww=;
 b=oeTPktrJdtl0RNVbGfywlSPdGgAC+P9EHH65YdryPQqu+rwrU5banlc93aeaFjTlf2xNFpZ+21HL/RvjMbNpYFEZP3mwNSaWTocJqalMwsHX80p9YxiYohlLpupj81UY9gtF1wn+7ISOFuu0en6tjrPLPjXTm2Z++M2JNy6/9r5IHdkHLec/hrOp+kUClvJJL2lETlsUopwk+U26lCjm5kS8EwYhzdW/uq3INt13gCpIGxLOF4J5h6VJYX6QNIdNhr8D9sh6OlnyCabbKHrgLzeVMaPxil7vqrI3sWcfSsB8G6TbQz7Fh9EwSYQ08ceZ+InI5IwGJEfXaScZHWzo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6msL3WKf7vn/sLz0ANyPMxjAH283pOFfY24lajfuwww=;
 b=drKHsFtbj83vj6szIwvhFM0KrlOgJkadK02tZ8eN365rVVriWH0Rv969KPN5DyLThQ/Rk7OolRocaE6aDmUR77Ptwx7y495F2ZTrSom9uk+tPzdp4Syo398IsqK97v2Cr9o+yq5RQVVk47BGGgxruRA1lmU96iEzOglx0N3J1yQaiHj1WEtBxqaEM/lHn6JEkEl16X3mFZXfoVrVPHrCcFIklp15Qw4vMMLmP5KcmqTxSA9al+n1PyhNXkJks9wjfHyrXi7tgCTh1uKNNmt6chfCsYckXtEs5EQu1O2Q5Fp9JD72NO+w9CjNKJK6sDjT3XSMuRJ67K2pbEbRFzOK7w==
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:03:04 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:03:04 +0000
Message-ID: <054e047e-84a3-4dab-ad5d-604d16fc347d@nvidia.com>
Date: Mon, 15 Jun 2026 15:02:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Fix wrong register access in
 mlx5_query_mtppse()
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613153654.1810-1-lirongqing@baidu.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260613153654.1810-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6391d7-77bb-4d6c-4c89-08decad60e34
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|921020|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	+CkD6SzHVZT+4R/hXMQA8+r5hUwsNuXIJZHJKirKDsukeJWJnWPXbTSrQx9+LkgN+NPmEGv1JW94qPol1E4mytoHfw7PnzetCoUk5G9D7Vx7oQar/WhFvXIkpTusEnrkgcOON3RiniCGm2rUvJO30xOYoIR9F9BYRglbCd3whFy14iRqNYB70+QOqUbgAcsc5b4SNBtRHIv1sEIu9b61rt4KlquOOEttoGdVYqjN+Lk2uuEnGfP12ssmvcYC8M7nmhvFTEENUU1f8xN0zU8ink4HJChn8iG0dm4R617BbbWwNG1Erenwr8EcPZn7wDiRIPxlJqvxZ3YMPqD/GCd280TPJwV+43HA5avkT6ZSsKVit6cz/wsZ1NQdC1MGbmydWPHB0gRh8QY1Rm7dDO7xJfIFHiYjt6cZ2NQxv2gTV4xmuOI5iHOx0S8+y7UcemywjRlB6sSZt2sXnLpBnxMiIzGj73qVMf9hIjl8D7agTioex+Inng+jaly1s4nHRO5Ry99hiw9C637iQyP551fFk29Ugifw1VrO//Uk2QzdXgc2JGdoeFmb8I2JGFTeftoJbxYx4sc3r+5cs+MlP4D1DUP3A9VKrzucV9lCkU9t+OcSg44aqj3JQrY4OR3abIytegSyiviYgkeU1yXrlEkM4ZwZRL8fx7jIk7XzNnLHwNiZFXzbTZA3RGssdiHI+jzJNi+mJ+2uCemiGorZi8e3nCnpQnUUoNbEEvn2hwTR2XU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(921020)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THErb0hTK1FRYWtTbGFuQ0JVUVVGQXVTOVR2Z09memhaMDU2K0ZJMmJJVUhC?=
 =?utf-8?B?V2V3OTVYL044TllRV0paQVM1NVpSUjlWa09uTHRvTU9Nek9UNjNGVXMyTnl1?=
 =?utf-8?B?a2R1dHYwREVmSnRTWFpjcG5DOFVkQUhrY3BWTmppUlJWVTlTbkxBUnAzcVg4?=
 =?utf-8?B?b1BNdm5teHYvaUJaMW1ibVpBWExTWDVZMlV2UDlaR3dtV3h0ZjQ0MWR1QlpT?=
 =?utf-8?B?WlIyOHNCQ21vYWNVMFA5cWYyMDY0RTMxR2g3cG1vZW53OG94S1MzM0wyMHZM?=
 =?utf-8?B?MkNlS3UvZjhVUjZSTHA4dFVWNGZPMGN0Z1d3RTdYVWFVT2hWak9qMG0wYTZ1?=
 =?utf-8?B?UkI5YUpLM0J5em5MaGxUdy8rMnpnZHVVa3JXS0dWc05qQXRrMFVQVWVBaFoz?=
 =?utf-8?B?LzhjTjFtbkZTNGZOMUliZE4xT3RTL3ZQSW9ST3VMTHNqQlRJYjdPYTgzcy9Y?=
 =?utf-8?B?Y2twLzd3QnRFS2hKM0tOVFNWYnEzLzhtQktpMFpJMk5OOTB2KzZmM1dvelhH?=
 =?utf-8?B?K1RKekMvSWpmbWo0Zm1mNytOZjNZbjJkZ2N3ZEN3cG9HMTljejJGcU93bDNH?=
 =?utf-8?B?Tkt4a0xKWVdNOUZjR0hxVXlTTlgwTGlEMTlQYVdOKzIzSEt0TlFhTXZXVExN?=
 =?utf-8?B?ckV3REloM0FjdGV0UUVuVWVXWVlKNi8xand4NkZlSEdSUk9tU1hxYklOakNo?=
 =?utf-8?B?VllNMHJrNDVwOVhST0p2TTB3ZFo2NDgrQ00yS3JwS3FsMzRrUUxrSWU2NVUz?=
 =?utf-8?B?WUxBdEtlMytkTnFjdTYvUVpGQ1RzM1RJNDFvMnZlM2FXdkNRRHFrQUkzcDZE?=
 =?utf-8?B?UnVaRTNBMnRhemhiVWFZcmNneG1sdUxaY2hSZVpSL3dhMWkxVGFLUlUzQmdi?=
 =?utf-8?B?S1hvWi9nU3JTOEZvcGhEenRmYkExcFVFbG4wOCtaMnozTzUxTWNqRmVlUkxU?=
 =?utf-8?B?QTNCRC9adG94VmkyTGU4V0R5WmhwUmdxTWFxZGpLZXFSdEcwTkFCcStWVkht?=
 =?utf-8?B?bjBzNk5HbFU2VVA1b29WUFVDRHZIRklsemxnVmxLMGRURTVxOTNWY2F1ek5Z?=
 =?utf-8?B?dGFTTlVxeXFuTnVyWGV5Tld3S04xOWVSYzlOTzhIMkxOVjlFTXo3ZGxjSkc1?=
 =?utf-8?B?QlJXSGd3dStPd0JiSWF3eTJ1MmRHUTJJVHJTKzB4dGcxZXQ4dndoWEMvWEo0?=
 =?utf-8?B?aGgrOFRNbGtBUDZ1ZXJIVXZnZXVuL3pBYjhBNkN4aGY5VFRMVVNNWXlNOFJ1?=
 =?utf-8?B?Q1gwRUpWMVpoS1dwbW9idXBUS0ZIYi9SQzlFcUFjeWtKZXN6a0NsTGZ3SUFs?=
 =?utf-8?B?L1B5dDdSUjFMOGg1SkhTbVV6MGR4YjNXM1JnMUp6ckNwSi9UczNCTFd6Qm5S?=
 =?utf-8?B?ZVZpRnV3TEZKZFhnU3dick1NeTNUNFN2bUdmUHpWS2tIYndtYzBOVDZTdmJ0?=
 =?utf-8?B?NEh2M1k2THF3ZEgxWmZsTStQTnBvNDFZUWRVUEVaZ0htWjVXMlFERXNHaXNH?=
 =?utf-8?B?SGU3Mlg0YVYxblF4Q21IbE1tN3lBR1FiQVl0U1lROG5jMzlCTXBuaW1Nemo5?=
 =?utf-8?B?dFpkRGk4YzBJbnNvSytNSEJhRy9sQk4yZlp3UVdIZFV3c08yTmRoNWNzWlB3?=
 =?utf-8?B?TEJUWkt4R2dkdm1kUzBRY0E5Z1NyTldDalRBck95a21Jcjl1VmZia2R5M2t4?=
 =?utf-8?B?ZjM0aGhPb3YyYWVzV0pwRzhOUTVVMXZsYTNaMjl6N3ZqUCtjcS8xaG40RXVi?=
 =?utf-8?B?Rkk5a0RFbFA4MGhJSlNaZXp1cW14bGhRVWZ2V2pRbStBeHNoQlF6dStweXhJ?=
 =?utf-8?B?M1ZHck9hTDNadEQ1dnhjKzFGeUpJODd1MnRYWTlzdnlRVzRxRnViRE1MZ09z?=
 =?utf-8?B?c3JQaXhNTjV4TUkvcG9IY3FoVVg3cmtlL1pncThWdHY3eGJzWkJFUzgxaEdr?=
 =?utf-8?B?dlVzRTFKK1QwQ0lJU1ZPOFI3d2ZTaG5hOXN5WFNDRnVNandWNkZSbUpoSDBH?=
 =?utf-8?B?cGRyKzM0RjNoNjhhMkY2STJFbG5jbUJlQkNkS2dYbWJpUHlIWDR0N3BTWGtJ?=
 =?utf-8?B?U3pPR1ZWeVZUWWYzbTFxOGNQNXlBc0N6ZjhaNUpGaG1pWkVYZHRndWRvN3ox?=
 =?utf-8?B?aUZQM1hQS0lyWlpsdzZoRkF4MHVKM3p0RHA3ODFiK09FeGhHTUlwSmpuUHZk?=
 =?utf-8?B?elJuSlVwU0RHVU5SU1pHN0pXc2pwaW1NWmFaamY0bTEyTnhSUWEvZ21keTgx?=
 =?utf-8?B?QlZLYmpaZHljRjBUV21UY253bDZjOWMwUGVxV2hVN3hhYjU1UFdEbUdMS09B?=
 =?utf-8?Q?B+eUQ5Fdi+fkZEogxR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6391d7-77bb-4d6c-4c89-08decad60e34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:03:04.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7V8SvBxmlRu4Co6Q2hYBBlD5LRr5gEHQuxRMoK5LcdebFx86EeaY9k/uevn+EXn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22231-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AA4C685FA3

Hello Li RongQing,

On 13/06/2026 18:36, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In mlx5_query_mtppse(), the result of mtppse_reg query should be read
> from the output buffer 'out', not the input buffer 'in'. The function
> currently reads event_arm and event_generation_mode from 'in', which
> contains the uninitialized query parameters rather than the actual
> register values.
> 
> Fix by reading from the correct buffer 'out'.
> 
> Fixes: f9a1ef720e9e ("net/mlx5: Add MTPPS and MTPPSE registers infrastructure")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> index ee8b976..2ab6a6a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> @@ -921,8 +921,8 @@ int mlx5_query_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 *arm, u8 *mode)
>  	if (err)
>  		return err;
>  
> -	*arm = MLX5_GET(mtppse_reg, in, event_arm);
> -	*mode = MLX5_GET(mtppse_reg, in, event_generation_mode);
> +	*arm = MLX5_GET(mtppse_reg, out, event_arm);
> +	*mode = MLX5_GET(mtppse_reg, out, event_generation_mode);
>  
>  	return err;
>  }

This is clearly completely broken, which pointed me to the fact that
mlx5_query_mtppse() is not used anywhere.

Can you please submit a patch to remove it?

