Return-Path: <linux-rdma+bounces-19982-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aICEC0VP+WkV7wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19982-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 04:00:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4264C5DF2
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AA0301F9DB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F53612C7;
	Tue,  5 May 2026 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DCPDZonI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A217BA6;
	Tue,  5 May 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946429; cv=fail; b=Y6TTAhVbnhhY2leCiK7b97gJhNvyTIQ7YbvbUJGIiVbYj9p2L2d19o0Tz9QEK1Qf7nBmX1FC1CfPYE0dgh00TTIT1SE5Ifm2AOwQTcRURHUHJ1CIjmUHw9CIq7reH2v7ckTdL8D1pA9PQ9VceLhQY1zZqdBMULo12K8zQLGvnzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946429; c=relaxed/simple;
	bh=tSK7otiJQAHi4rUHxTYBIAu/CeRuOk3cOG82w2tr4zc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IKcySDXZTB9AyxwZf804tvfDqbMDwGQik2g/G07edXylg5bRp2wfqc/Ug5q6yWiTKLJX1/sFR71e1JsCtisDqUZZIND/FXTCqNywqF32LzxkmpbvDUeFXe/og0m6xoUN7VmHFQBTIAU1h5eVmq6kpkpgNCn5kv+y4EsP58YuEP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DCPDZonI; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=warsFdt/8tGCouFISRsJlZRz1ICVucW4aZp1EXaMDm9BzuWxkOy+QAN61RI/2D+Pf32wBTZVrxEFVZUXyJinzSRLEX1fVmRk+a5AbrD/r9Qzc+Ax6y1FG9jgr4Hdcf5u5kfBLvsflromJfWPV67xjHBJzeVwCE43auJUoX65BaRQ8exSH6P6OZ4ir9wH5ravDkJOUmIEtS5QsUi2maJT7hmbfw6qOE2l2kFdbAmQ8jqntmyGac0G2ahjRWox4BNJMbJNGGyC1/63uSJkHheI3xX2fZL4tFupEbziaDCEm2iusuG8oVhS9cEUuHw4K4A0qIw3aghK5m5a+3Q7u0JjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGzUAZiJjBc5oyYN/o2oslefisn1Mad3AM9z4/sn6TI=;
 b=WvLXQG342STlX32Piyvk3kqXrwBHQXucBCmDArOtWShaJPT7S8CkaCdlj203+Atgi0pZ+7N2a8hqG1Frk5m2UN0IawLmu5naqbR/Rvme/sGHr7K+gGoGPJXSWV00nt+jFQf45ReCsJsPDSmGI3gZdjvZJu2J0VixHPCvyaZtX2dMaxszKxAkxl5Hg/NKXpRK9M+0n2bYj7/47/80WH0dxkryXLM9q3J6qXIfp9WgYHfVdFydvvqv2c6LzSJE9DwBulS5S4CTrXVk0L3n2BAwgUUh4cAuTXOfoWfvFDUuCjfvz735XSkxwk21FPLziZrGs5yfbF8skvtY02rXx8snhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGzUAZiJjBc5oyYN/o2oslefisn1Mad3AM9z4/sn6TI=;
 b=DCPDZonI/nlJ4Pox2xjA/fPPLmyyKlAnc3z10/1/O1ae0dj/bb795D50Q2xf0CIVrxlrqmVfJ3/qGyrvTcS5anqPqjckePdfU9RxJovfmM8c0TCzvetF2G/IflQ3+ae6opiEuhZKKRVtTq3nvxBv5N2iQCiurfKYXQYYHwWZ/eER8DduBPt9p+wGqw2jSXAtsyGHDLqnqlAqw2GrkiEtAPK9LT4XPJsubUsO7usbWNyN83CST7mdoRfTrvELI7IjbJQPevPQwAHy8Dr7Lv59rV+vdzuGbso67E+l5+iLdAz/x8jWogxPVrg6DrJyXj6b9rpC6h7gkNq7SbYFCpcadw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 02:00:23 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 02:00:23 +0000
Message-ID: <9f73036e-32a8-4060-a347-cae05269b85f@nvidia.com>
Date: Tue, 5 May 2026 05:00:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 7/7] net/mlx5: Add profile to auto-enable
 switchdev mode at device init
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Moshe Shemesh <moshe@nvidia.com>, Kees Cook <kees@kernel.org>,
 Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
 <20260501041633.231662-8-tariqt@nvidia.com>
 <421e8885-5849-4390-8956-9bc344fa0bf0@nvidia.com>
 <20260502184153.4fd8d06f@kernel.org>
 <cc01cca2-0e5d-4db2-81e4-7ea9fe525320@nvidia.com>
 <20260504182122.08efb41e@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260504182122.08efb41e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9335bbf3-c9f3-42ab-11e5-08deaa4a113a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jMgMB47wwp2O+maRsmPMkBTaZge5iwV1UwIRtShZBobzTgKCDoCCbt0QzAKw511U58IMhEoPQULDf9i9Nor1M/10MOicJaLWGqozg6NAnNk649XIuAuEP78QatWGw3z8yMCvyaMK5GIQ34BJIEm9ZdqDuBjrxac9GYF29BF4Zp6Y2TuahAx5heiviD3EAo//sl3VL4PoLOG7wVCCw/8uAYLiHtv+j6t8VguVRmfgxUvTIvIerLNelBL0pH3PsGOpx78Sl0vpdA1wPDqjewkgOYbGWI3I2pN13m2YMUe8pOFtnU1fmvt8zChe/hdvNquqjOkXzB2DWKar+BU31b26lDlIQcuF1PcHisgl+eqn4pvcgT03OvE6ei9LZg3BPZ9de0D0Oo8meEWPqOr3cZVVPzqpr+tiL0UQ+Sa6toifgWVZ+Mf9rRP4YJiji8girUqbK9rWOY1OUwc3Edn+ES7nxNDQVWc7fVsDS1UvvOf7x7ap6u/18EPYKP1kmJiqAaTeLoC/F/5yI8v1mC+qCNyUiTZ0g3XBkBpl6iP6ie0P6UuKwV+FeBC9MITGAiH+3NqYvl8Sjf+toO8s0MxegTVI35f7A41wd0fKhpZt4vB1a6nzTVgabi/4w/BlAqccLsDL31DNNzZt180vUcUf1XaQLtB4ZF0RBM1yhOwUUh8sQxHkMMYONZoysKr1eiqJttlj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVF1TUVrc2Iyc05kRUdUNjNJRlpXMEVtM0JZdEo3MXMxS0pwQWM4ZTlaMThJ?=
 =?utf-8?B?Sk02TWlJQzl2emFxSnZjbDNTdWRhTnBJVU5pdWZiYkNvTzhPT3ZTZ1JRWDRu?=
 =?utf-8?B?eWtDdTZKenBTaUpCMUhURFdBY2hwd1prZ3N2Y0xjR3luY3lqQ2hRcllFa1Fu?=
 =?utf-8?B?USt0WU1NUWIwNkdKWVJ3UTBocnVaSUNGN2tndHVwR1phenJFSmh1WDZsYWhH?=
 =?utf-8?B?V1VrWVJKU3I1NllKZVMxU2E2d1AxTWNtMi81aTdGMjd5MWJRUlh3NTJzdStn?=
 =?utf-8?B?Y051SEQwNWlIQ0dBVEFyM0k5dExTQUhXOUZEdVFhb1Y1eDU0eHY0UU8xM0F6?=
 =?utf-8?B?MDNpQ2lYUXk2T0ZaT3BNZDlzVGZVb0d6TEk3MTJYbzFkQUdsYlZ1R0tQTm1O?=
 =?utf-8?B?UmRyeE9UazU5VFUxZzZoYXN0QUEvckpMRTJJa3ZNck1DZUZpNlJxUFNoNFZh?=
 =?utf-8?B?RVF2VGovc2lZVHBHYzBLTU9wT2hiZFo1ZllSTXMrWEkyOWJmVnFTSVBWcHJ0?=
 =?utf-8?B?YktrYWhzRytySnl1UmxvZkFRbnY5TlVVNGNweEdSd3hCNXFYTzg4ajB6QVVI?=
 =?utf-8?B?L0dHU1cxU1dNU3M5YVBTNCtMQ202eHBlY0tWVS90TGlsNHZnWTY2cUJlL2Uz?=
 =?utf-8?B?V1Q0Z0FnYVQvalc1cUd5Q0gwazBkK2xBekxwamQwczhnWG55MkREeVg2OUhW?=
 =?utf-8?B?QTZoV2Nlc0hHbWtnTXRkaHpKb2ppQmRCRG9RVFp6eVBoeDBYaGlsckhtK2tY?=
 =?utf-8?B?NVVkTEhuQmducGo0R0lTNFlCQm1sTE5tMFp1bi9nZEx4QVpxcmlWQXczekxG?=
 =?utf-8?B?NWZhZ1pScG9NbXBDak4zTUFkaHh0Q3hBeEhIb243MktmWkJJSlFncWRXUFRQ?=
 =?utf-8?B?MUpLZzNSNHd1NnlLTmo3K21yZGx5aG9Da3hOaWFuZmZsU0NNVXorSnQ4TUdH?=
 =?utf-8?B?NjdEbkpkTFNJZlNEd3licWVYbXNPUXdTSGthVkkvek0wNlIzZnl5dWZ6cmhQ?=
 =?utf-8?B?cGhFaGRvMmhkdktDbmE4RHY1TGhVSEVGRkZqQk9nYlBSTlE0ZnlCMTNMYmYz?=
 =?utf-8?B?U0VtNFF0Y2VpZXpVUDRSRktYZXFQTm5XZXpnVW4xQVFkMHdTd0xCQWNlT2Fo?=
 =?utf-8?B?bzgwMWNWVmR4L0lqeU1aTGJnRmFZWHpQQUdBTzZMNG9hMG13Q3BKdlRnZWpp?=
 =?utf-8?B?dGlpTzVlRXBaeUJtV2tkMUc1bzFJYVAvWjF2Ujc4OE4yTVlYcWZjS3JSNmNk?=
 =?utf-8?B?T3o5K2JSY0JpTDYyQkk0Uml6RkdibDF4cmVKaGgySERuZkhZdXNuZGtBL25G?=
 =?utf-8?B?NnZDaDVocmNLbnFMNUxlaUtScjlvTWowTDRzMDJHWlhMVDdETmpDREVBdWhz?=
 =?utf-8?B?TUJpaGt2ekhRYk16L1k1NWt6S2FseU5NL3BzbEJEOTgvRFZUK2FFTEFjWDY0?=
 =?utf-8?B?SmkzTUt3V2EydlRXakZVQmNyYU1uYXNPbnpMZGN3UlZrdDZQYUo2YUMzS0NS?=
 =?utf-8?B?a1pCNkpMazZHYjl3dHRNQXhtR0JvdDdrd25BV1VTMDNZSmZ2TkRQMmR0T21y?=
 =?utf-8?B?R25JREtPSDNnd1JmREVIaUFTZFd3blVnOUhDYm02WDdFWWI1TXZPRVY1N3p0?=
 =?utf-8?B?QmNNbVgrQ29SaDJva0pta3NVYTl0TUlIc29vM3BSckloa3Fud1BxSkNteFRB?=
 =?utf-8?B?QjlDK1Z5RDljc0xJU0VlMHo1czJ2Nk4wcE85V1VaTlBtd09qR3cyZ0QwdW9D?=
 =?utf-8?B?MTFKUmM4OVIzbmJRdjNHei9ScTdaWC9EUzdvUmxOK01DYXNxMmZLamtSbTFh?=
 =?utf-8?B?U0I4bFR5RkZiaWJzSmpmNGljTnI2MFZUaDRqT1c2US9ORFF3dkxza0FBelFS?=
 =?utf-8?B?T3dYYUlMYVNnM3ptYUdqdk9KckR0K3drTVlJUDF2V2Z5NFdaMy9jd0NqeFhO?=
 =?utf-8?B?TU5mRlZtUDVYbjdxeWkyMGJSUExvVmRXVThEYk1kcXduYkovOFkrNE42ZGRT?=
 =?utf-8?B?L29RVnRQZHJmNm5BRlBYTTZSQWpkUmJmd2I2VHl0c3JBYTZUQU1kYXE1MTlh?=
 =?utf-8?B?Y2h6N1IrSzhpMUFselMyWE9aa21MVkMvWUVOZS81bGJBRXFiMVd1N1pZMWor?=
 =?utf-8?B?TWt1R1E0VWhBZ1l0RDBoSVBTZy9aSUxrSU9MRlhYc1VoZWVsTVBoSzFMUlBn?=
 =?utf-8?B?cXl6YlpTR0FpKy9WZk1wSTVRa1BkcDVTWC9nNFgwRWJCVWVrVTR6REtGWW1O?=
 =?utf-8?B?S0xDM2xEN0Y0TFl0T21WRVNqSDU5dDNyMDhienhrKytXM1dqZURqZkdzSEln?=
 =?utf-8?B?M0VsVE9CaHdycHc1YXU5QUNDcWk5R2xHSHg1Mk04aDZpbzdhcmU4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335bbf3-c9f3-42ab-11e5-08deaa4a113a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 02:00:22.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXFD9V7SQMKXjAo9LC7hd+oENAplC4J8WUo/5NlNUPMfAedUFsQWgbxAQCP8bkyx/tuHBEGGFQxsXmUG5yZWWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
X-Rspamd-Queue-Id: 7D4264C5DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19982-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]



On 05/05/2026 4:21, Jakub Kicinski wrote:
> On Sun, 3 May 2026 10:51:06 +0300 Mark Bloch wrote:
>> On 03/05/2026 4:41, Jakub Kicinski wrote:
>>> On Sat, 2 May 2026 23:08:43 +0300 Mark Bloch wrote:  
>>>> Before I respin for the unrelated MR_CACHE cleanup, I’d like to confirm
>>>> whether the opt-in profile approach is acceptable at all. Regardless
>>>> of this last patch, the first 6 patches fix real representor/LAG locking
>>>> issues and are needed independently, so I’d like to keep those moving toward
>>>> acceptance as soon as possible.  
>>>
>>> For probe-time config module param is probably our only option.
>>> I'd obviously prefer to have a devlink-level knob for this, instead 
>>> of a mlx5 specific one. Can we come up with some format that'd apply
>>> more broadly? devlink=[$bfd:]flag1 ? so devlink=[$bdf:]switchdev-mode ?  
>>
>> I’m not convinced this is really a generic devlink knob problem.
> 
> I'm surprised you say that. Anyone using switchdev mode could benefit.
> Having the probe in one mode and switch adds to boot time. Whether it's
> a DPU or not is quite secondary.
> 
> Unless there's another deeper reason which makes the DPU incapable of
> running in the non-switchdev mode. But not sure that squares with the
> code you posted AFAICT.

No, there is no deeper DPU limitation. The device can probe in
non switchdev mode, this is only about the desired default for those
deployments, and avoiding the extra boot-time cost of probing in one mode
and then switching to another.

What I meant is that I am wary of putting too much policy into the kernel
command line. A generic devlink level switchdev probe mode knob sounds
reasonable to me if we keep the scope narrow. More complex policy, such as
changing multiple defaults still seems better handled by userspace.

Would adding only switchdev/switchdev_inactive for now be acceptable?
I will try to keep the code generic enough so it can be extended later if
we want.

Let's continue with v3 as posted and please give me a few days to put
together an RFC for the devlink part.

Mark


> 
>> A device should probe in its selected/default configuration. For DPU
>> deployments switchdev is the expected operating mode. mlx5 just made the
>> wrong default choice historically, and this profile is a way to move away
>> from that without forcing it on everyone at once. I expect/hope to move
>> quickly from this flag to simply making switchdev the driver default for
>> all DPU configs.
>>
>> A generic cmdline format also gets complicated quickly: vendor-specific
>> flags, ordering/dependencies between flags, hotplug timing, and whether a
>> BDF rule should apply when a device is passed into a VM after boot.
>> Userspace scripts are probably better for that kind of policy because
>> they can carry real site specific logic.
>>
>> I’ll drop this last patch from the series for now so the representor/LAG
>> locking fixes can move independently and we can continue the default
>> switchdev discussion separately. I can always submit that as a standalone
>> patch later in the cycle if needed.
> 
> SG


