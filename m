Return-Path: <linux-rdma+bounces-18858-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAyeHN4VzGnfOAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18858-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:43:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97C370223
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40BA430215E1
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27038F634;
	Tue, 31 Mar 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICvjXZQ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1838F620;
	Tue, 31 Mar 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982381; cv=fail; b=M8m02BOtB57kyRN1svAHaLA7ltOc/drpBotij7DgS3J03G5ySr19WaqFWe7uF6Gg1+On07BwONvAy/03CwJwl/QwqX6r66bKkqOPoejGlJKG8QbiLPUSi6HP15g7iv7lZihIrhPVkyyJ0UOpKjorovEwEKlEkudOgEiPep7P8sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982381; c=relaxed/simple;
	bh=2ptPcsWDJfDEZR8whTCmjGXRgymTISS2HgzzrCJw9FQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9Nmct9joAQhd/k2l0U0V+6AZCiK0CcTdQJgzrZPvUkVeM2oyomvFynOzBOrrC0YFfOR49gIsL9vAOaEbzyUBzdzCc73FN27mDfvsTbH4xBqrWMw6srImThXKvE6TTiGgcgbB6N5u6FsP5ko0QfeMa2tqfHQg4csADBdfLhGRfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICvjXZQ3; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXKIm/8gB20bU2EMZWEDbVb7UbIrVaOfbrqKxvwYMbp099/tXTLyaUV53Y2uGPxEJu8sBH6j0j7ahubyh76g9OPEc81cSobvzmIQoBOLKTAaefRcuqEQYtUNf+RZwKVzOdkdii6FhqlkuM8zEvdz/8/XQ/8tnNFrCJuSIKpKhZybKBYVmWTsUxXoynDmTuprsbnDpfUz4kwOsyyNtT8r1eMOPPxBHTMlH1JCV5V4a0+8BbOznBFdURy+oDcpDKgPYvEG/e+1v5yjAmcctjzlEfkyaeoyHMa6FjcuCxuAufUlGrNwvN8EylKSocF/g0remTV+MBdBvrT/JvoknKPzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvY8c3BjBBBwFMbzroXgRxcIatrHgjp7cCUrSfW5J7k=;
 b=RvX3mrR5UlO4jIG2y6e9iBe+SIvSD6q6L+EuFW9kJrzrWELwxbIfp/AvfTcKhNvXSVxEQXAzq2nxHHIEpQJ1DbXh3GKeoezxY8OIZGr2bzl6GumZwR+yXdGg51bUdLksTi9w3IT6PRssa2rFkZIP/8euy6cEoUpf4iil7Pxi8sHqxrjuuYiBBvdBG5z4sQtp3Lvi/LgIsjFKnLYCydRzSwf0/7OTfiNS49A1hqOvTbD3eVbVul7mM+O6w86aYJbOM3avJg1Yuc42jsS+vaQ6gEsCdeGY9hkSeSdc51PAF/Gj43UxCyg90bC9q7gD55niHjVmpcdVGLoyrsmFqnxY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvY8c3BjBBBwFMbzroXgRxcIatrHgjp7cCUrSfW5J7k=;
 b=ICvjXZQ3AqbSWARiFMSMjFiiczIjhW4oZQhgkZn8+j38gtiYJ+sLLfa0nkYdyBlsevhVzLeq2llF3tzCn19wr6L6+ET8ks30mgiZ/73pwvSDXwS/YI9Rw9NWokn/sqUz0t3A7PAMdIm27vF8sOjuH5Gkm0n/VkDVwlJfSluwQPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 18:39:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 18:39:33 +0000
Message-ID: <688a8e59-3188-4c9e-a8ed-d53b7d965e10@amd.com>
Date: Tue, 31 Mar 2026 14:39:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michal Kalderon <mkalderon@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alexander Schmidt
 <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260331180952.GA148118@bhelgaas>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260331180952.GA148118@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS4PR12MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: e0690a61-f1c4-4e8e-94be-08de8f54da23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MpaWyuh7Elo/WME7YJMXMjZmrksf0aHthIr6zK2kGdzGxKGA2jtNP81KvFdmGCr0/cvmMZGtQcgefOl/ERAFjWgpNZ4Rn3wfDZloMVw2DG1yCmvk7DXXFZv52+gwNvpL7Mh6Nz37dceYaDZHwSi+9o1cIZ/Z5rQhPEy9rFYkE9jfmehepCrFUnjDWEB09CyWUFWFGMVHcV6ZNK1YvV38AupLwQM6VEY7nGoigppz5TqcyZp524dx99i6OjGW6EpXMTAReaB26sbh0oB/qA3Jcwh9Z+NLt+Qm1zy7GFP3imS8oDlElwlKJ1vJcdVZJyV63HqdkFjGqWMjUflFmC5yEhUkU18pclNnih36chSoT8ARPfMod0KMXTsfbvAbbS56/JHsUKrcECtai/xTh4F2qEW3GyTTUiMOB7KypuH/OeHk39kM6DtZzk3wS4jQwB35d19tvcwJ0gnRDumZs9JvbOeV6SQfS8rueIgip14xPiIfXJ4KjODD0BXo0u0Hv7F/MZs4FwxzpGd35JfKfWXE4n9jYZi08xn9LWilrz5lE0UCYGlAlF1/5cqtYrF1lwlPVhW/+216c6zgaqlR+fDqjHKUWso1W0rNheV/g35eO02N0DIbZIxdtB0cJL+WALhpZcbBS54JKLK/V6GVnMSDoyCvgHdTZthfikrkpT5b1FhOLtPjqWtflGN6/+krq96U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3dHd3pwcmErVkpOQ2FqUHp3M2pZZkczSHNXeVdISWZGLytPOGZqa2QxYWFL?=
 =?utf-8?B?WGxiM056RnErOVgzQlp4U2cvbC9DbmpCREd4bUpHMG1pUTBLTjdqdm85L3hh?=
 =?utf-8?B?MGVIOUkrUEtHOGJsMlNERnpReEsvckVWanRqN09tcFM0UXZROVlTK0ZFaFE5?=
 =?utf-8?B?ZGVSZHJvR3N5NmViYkUzSGFNbFA5dFlpNjYwUFZtY0UyRmVtYWpyNnRtNTJy?=
 =?utf-8?B?YXQ5MFNHbFgwYXI4aDZCQTJNM3JGZWpsR3BIK2ZKcllvU2krZGZTazdWUHdE?=
 =?utf-8?B?Y0xVWHc3U1oySjBKUmxlMnFCNC8zY3lDcXVOdzVmN3VYSFZzWHcyeUZKTE5M?=
 =?utf-8?B?eFBSNDhjV0tCZGtFWkxDS0F1UTZFVS9Wa2xWNEVBdUNyTDA5RitQd3dOOG5T?=
 =?utf-8?B?bWRhcjRPRUhUSU9HYWJhck1zbUM2L29ULzI0cSt0Mk54ZS9hb0E3UUZLaTdU?=
 =?utf-8?B?c3ZtanNxVVpZRWs3SEJQeDk3cXd3Vk92ZnZTSmZ2NCtqMU1HS2lDWW02TVJl?=
 =?utf-8?B?NEd4Uktib3lDeDhwbHJYbHZhWEFNQXpySlhySTAyU05TTkN2WVhzRGdGYlA0?=
 =?utf-8?B?RmNwZjl3OTMwOGQzQUdNOTRIRHhVYUZzRmhVRDdzMk4rOW9XUUVUdG80dzl4?=
 =?utf-8?B?WjVDQTZCa2R2MC9neG1xbWNEbkJCNTdVcTZXWnluUzhpZDI5ajlxTTlnejQx?=
 =?utf-8?B?dTR1ZHBWczFCRU5BbVpCWDh0VjdiZWJjRVpiN3J2MzZoU0R2VWxuQ3E1UEhv?=
 =?utf-8?B?cE5EY0FXaktUeUZyYjBPZ2taOVQzc3JyNC93czltM015bjF0UVhjZlBHSFQy?=
 =?utf-8?B?eEsvblNPTmc5bkdXL0lZVjJXby9ocVI2a3FUU0pzelFPemd6UXU5Z1hWbWxw?=
 =?utf-8?B?NmZoVHAvUXovR3VJbnE0dktvRGthZWNVUDFXeUZCWUJvVXI0amV4aitXb1VT?=
 =?utf-8?B?dXZoTTZKMGw0NFhpM1hxSmZqR3A0U3loV0oxV0ovZGRUNkRjNnVwRTg2VkNK?=
 =?utf-8?B?eEdEcHlSc2YvdGtTZ1k4MkFSaHRuK2tqRFMxRThjUndjWXpld3d2dkw1UjYr?=
 =?utf-8?B?ZmJ1bHhMTnN0b0ZQRWx0Rzd1RGpFYzFHemk0amFtUnREV3ZJQU9NcDgreUo2?=
 =?utf-8?B?MEtSUHFBTldoOGVqRVU5a2U3d1llc1RRTEhpdEdCdkszbUJya1VmRDdXejV5?=
 =?utf-8?B?UHk0aEowejNnUE10VUdiUUs4NzJrVGZVdXVKSi9JdjQ5OUVWSFkyVkFSUC9L?=
 =?utf-8?B?bk9BdTVIYkZVTmduSDcrb3VKMjRxUHFMOXRjSXlpYWFBekNMUTRuNVpXcU5o?=
 =?utf-8?B?aTNqU2dJZVpyWnRhT05Dd0ZWYlY3elBQeWJSbXVSOVpndTlyblZic1N0VGVX?=
 =?utf-8?B?anA2RzhxWWphN1p1dTByUS85R2M1b21IZTJUMTZicldkZmQ2SEplcjg3Z0RI?=
 =?utf-8?B?WnFxRVI5NEVVR21uOXQrZmpqTFpnYlpZa09wSHIxTnNCaXoydzNxeCtMMVhL?=
 =?utf-8?B?eXVQTWtrUWtGOUlHNWtSNkZSejVFSTdJbWphUVJJZWhiT2xhZW96aTdjelBa?=
 =?utf-8?B?aCtOaU4zRnFQc2FIL3dMcGJ2akVNRnNGVHFkcms1b0MzZXFuYzh1RGw1T3Bn?=
 =?utf-8?B?Y1VoTFhUSEFXemNOWVl6VkNNeUt6eW9pLzdkMTdkRmhQcHRMYmVrV1dKZ1Bk?=
 =?utf-8?B?Mk5GaHkwZ3FKVVJuM21nR0JYOHJ4cXUrclBEaVZTOVprYmNMTk45ZDd3Vmc0?=
 =?utf-8?B?dXhHYVFBNXBhTC8vWUoxdXA1bjc1dmFJaDg1REtnQ3pQUktqdmlhYkhnZjI3?=
 =?utf-8?B?RDdLSDFuVmIxZDZaWlloNiszZFMxSWtDelAyQ1dObWhaeDVOUXhGdmNmejNq?=
 =?utf-8?B?RjNBcEt0Sld1YzJVeVdVaVViTXZzTHlUaVZVWWpsbmp4VTFBbUJLc0ljcm1k?=
 =?utf-8?B?RmhneGdkVWhEbjJFbXJOdDEwcHhoT29CdDlZckJWR0hPb0Y0Z05KVkFsWUVP?=
 =?utf-8?B?dGdZOGRLWHZPM0ZZWHEwSTFTbUZvMExrMjdxYVNQR0hpSVRDd0NwZFJVSWI4?=
 =?utf-8?B?dmlHRHN0ZHpxOXdvc1ZEblJ4VlNMRDY0WndIc3IzNjNLcjFFdUo5NUUzUkNa?=
 =?utf-8?B?c1Bkb2x1MjNYY2xUb2Z4d2R5Tk1jT1hoSkd4Mjhxc2dYZE5CaEEyZE00ZTlh?=
 =?utf-8?B?ajN4Ykh1ZVRHbno5dTZKazdVbVBFQjdvaTJNV21LTzZWOWZnQ0EzVUlRbGZD?=
 =?utf-8?B?OEQwWTJDak84elNUbW9GVnZ3YmUrTVlaSXEwVld5UW1rSGRzejQ2MHI5R3Ex?=
 =?utf-8?B?b3RTK3pkYURZLzE1RlA2OXlXN2JLSVcrUkg4UEJ4aGJ2VlpwdXFNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0690a61-f1c4-4e8e-94be-08de8f54da23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:39:33.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkxazRCkdsUYZFavcXR8SxFuCURQ5Jsmsm5aKgaPySBbK1gHkTtQMLDOBsxC02Jh+RbAg66aiYpMmGKjEQ7oBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18858-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,amd.com:dkim,amd.com:mid,bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D97C370223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-03-31 14:09, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2026 at 08:01:57PM -0400, Kuehling, Felix wrote:
>> On 2026-03-30 17:42, Bjorn Helgaas wrote:
>>> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
>>>
>>> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
>>>> Since root complex integrated end points (RCiEPs) attach to a bus that
>>>> has no bridge device describing the root port, the capability to
>>>> complete AtomicOps requests cannot be determined with PCIe methods.
>>>>
>>>> Change default of pci_enable_atomic_ops_to_root() to not enable
>>>> AtomicOps requests on RCiEPs.
>>> I know I suggested this because there's nothing explicit that tells us
>>> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
>>> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
>>> implemented as RCiEPs and would be broken by this.
>> FWIW, on AMD APUs our driver doesn't call pci_enable_atomic_ops_to_root. It
>> just assumes that the GPU can do atomic accesses because it doesn't actually
>> go through PCIe: https://elixir.bootlin.com/linux/v6.19.10/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4785
> What does this mean for the other branch that *does* use
> pci_enable_atomic_ops_to_root()?  Can any of those devices be RCiEPs?

Most AMD GPUs are not integrated endpoints. APUs are integrated. There 
are A+A GPUs where the GPUs are separate from the CPU but part of the 
same coherent data fabric as the CPU (adev->gmc.xbmi.connected_to_cpu == 
true). Those may also be considered RCiEPs. (I'm not sure about that, is 
there an easy way to check with lspci?) We may need to include that in 
the same branch as APUs.

You can see that we did that for a new generation of A+A GPU here: 
https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c?ref_type=heads#L3920. 
We'd need to confirm that the same works for MI200 A+A GPUs as well.

Regards,
   Felix


>
>>> These drivers use pci_enable_atomic_ops_to_root():
>>>
>>>     amdgpu
>>>     bnxt_re (infiniband)
>>>     mlx5 (infinband)
>>>     qedr (infiniband)
>>>     mlx5 (ethernet)
>>>
>>> Maybe we should assume that because RCiEPs are directly integrated
>>> into the RC, the RCiEP would only allow AtomicOp Requester Enable to
>>> be set if the RC supports atomic ops?
>>>
>>> I don't like making assumptions like that, but it'd be worse to break
>>> these devices.
>>>
>>> [1] https://lore.kernel.org/all/20260326164002.GA1325368@bhelgaas
>>>
>>>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>> ---
>>>>    drivers/pci/pci.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 8479c2e1f74f1044416281aba11bf071ea89488a..135e5b591df405e87e7f520a618d7e2ccba55ce1 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3692,15 +3692,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>>>    	/*
>>>>    	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
>>>> -	 * AtomicOp requesters.  For now, we only support endpoints as
>>>> -	 * requesters and root ports as completers.  No endpoints as
>>>> +	 * AtomicOp requesters.  For now, we only support (legacy) endpoints
>>>> +	 * as requesters and root ports as completers.  No endpoints as
>>>>    	 * completers, and no peer-to-peer.
>>>>    	 */
>>>>    	switch (pci_pcie_type(dev)) {
>>>>    	case PCI_EXP_TYPE_ENDPOINT:
>>>>    	case PCI_EXP_TYPE_LEG_END:
>>>> -	case PCI_EXP_TYPE_RC_END:
>>>>    		break;
>>>>    	default:
>>>>    		return -EINVAL;
>>>>
>>>> -- 
>>>> 2.51.0
>>>>

