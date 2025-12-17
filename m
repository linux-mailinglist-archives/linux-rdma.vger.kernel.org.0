Return-Path: <linux-rdma+bounces-15057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EBFCC98BE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B21FC30341D1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1B2D663E;
	Wed, 17 Dec 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gp0cQxFL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B52EDD40
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005527; cv=fail; b=c2LLzc11Rs7jkrT5FpelmJzPOhsW03VZGTKZesx5RuRQlGZ+6WEdjy4AE3OU/KEaIwZGSTKvDGQ7bBjnYT0LMoBfjsef2LqW5ffJ902w9LeND4+YGbrqb3vqGbjSS7Sj4Sj3Ni75CNwxblZrEiTuIfSaFX2Ysy3o4rGKNd0Df4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005527; c=relaxed/simple;
	bh=2jVXV0aV4RODLiuBePiB/B+flQjvnbzLsdj2MMq79lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKE9O96Mkh6Zf6EM0z4/4K87A5GdOOntTjSYQmIoRH25BW3u8i1yzotsSMIVvNCK3asn8ge/UV5PBmxPRYI4Tf8Gi24L3Ig4uRE7TEB7x8HILrIZBZE+fH4CFEMWN9nwCpDTgZElL7Sk9BXovrl8vxliP0UbT7X1n8/6Namc3ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gp0cQxFL; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDO8BB8SBaebI6QpBAiys22fNQQtAMLKdCv3efiIxygA+SBcTkFCcJ/mIzJ9tWBJVnqf20+m+sWmCHUioOBPcLVS2GhMieA4cGi8lAaSDwDjulik8FmqAGJHAwcsomYn6EWPd0BOkVXHMuHHheisOYjqrBNn5GqBIzJwWxSWwAukrU8cZVn54ZG90H2e6NtquTJIrNzQryDEaY2spT5bI9Kae/Kmm22EYQvMdP3HgxQORgLLuRKmIPb7npBzWQ8CqDv22qu5jo/5mk5Z37dnimg0B9E97EMkrdAV/fRlHBrF9qbozaP/ZIIgHdvPcNGzyXIkVv0YdUZ4CVR7tepjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLeCZ4psk3+KoRdseOnUXp9F+/5LIgkj6I1zDS+azxs=;
 b=KLn3eiQfBVUKnzMITH+I5qLXd8PbrfKtl4Efc3rXLzAUp5vHX0onAut91GkCSRxtg0sxhKM9vG1boR+FZFa9hu1kMKVhQONTIIN5NkhS0jiJQuewEB/dY7/ML+JOsXakHOGzooVV66ZLivA2bjvBDvU5qF/mhgcEhGJprHaCJFYbuOLnEXrN0NUDWWDuU6t3wvSacitCh38dj3lQPRQ3/V8oVGFlqgCBnLBabMkbw88q4SNMcQsgL7la7C0zKUCFABkk3qMgd9HNmfktAKajbGvNCYGZxb4AinaC5uuF7YLtCcE9rj9KHPFMmUA316na8/Rq5bJn10Qo6JpibCF6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLeCZ4psk3+KoRdseOnUXp9F+/5LIgkj6I1zDS+azxs=;
 b=gp0cQxFL27v4wY83iPrv13UUYzQ+/02d1Q+KvWXCdqj0RzUXD0qZq9A6WQY5pgfgeAh5qhPzUrxdQqTXUWKXyLaYcW6rcgluUypKmu0zOHkdpH5fN2AVP2ItwJsfNm0UeviTlK2Kv36LTQS+F3eFkuU65XzhDk/eG/DYEDVETYjw4eaIo9/7WQgH/TSL3LOUtw/Wg5zTzg+HDAkUNylUvmV96OyIC3hI1XwohU2J4d/Af07lFQqiYeFTQvrz8gKyMKeqCcEcH3dBYavNa/tCFywRDfTWD7QSk9u3o/MGWDwP7QTRtYEYjzo4KGzwhfG51xybWGHrYFMMoQFgsw68ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 19:31:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:31:07 +0000
Date: Wed, 17 Dec 2025 15:31:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v5 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20251217193106.GA243690@nvidia.com>
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: daec42bb-5553-45ea-0061-08de3da2d36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?OfE5uU6RvEDREXYfOkZNVNfeBhT7vNnL+PAxDzQEETOib1PeqdQ8fdj5hk9i?=
 =?us-ascii?Q?yqHQ0tRlE6RoRWbQ7B3Cc9LkhORU5ev7blxmTS2joBkPwO5OFmF5779kJfLT?=
 =?us-ascii?Q?F9KrlHCMiHGPbDyv+7E1K3HKlwxL7d58oCjja8yHNIBLSeGNTvfkqzZsohbT?=
 =?us-ascii?Q?eK7+NpYLLjFYOTIkVziYQ51s1cqq3qVkbXtmsIIRZ/7rVBA8vwPry/BqEJj2?=
 =?us-ascii?Q?RKNuCv0bF15QTrRZFLtRKNnuH8dHXsKe1zpQNudwq7rQ87McM2Arl1O1YRv+?=
 =?us-ascii?Q?4TN9QNbdvQChCC1wPGySOBdkz1pxq3OCxX35jyuJrQN/WcHb6dJw5tr0j3Nh?=
 =?us-ascii?Q?WbyCZB1DIWvQbAg+ziz1NfBvBkNmzKAPyUPIbdktqBjd0W66BieVrC3qFdfI?=
 =?us-ascii?Q?o3M+/7KHcXvj+HIiv8s7eGUVc8F9W4REX99oiZIM7ypy3UUstX/bx24EIwpg?=
 =?us-ascii?Q?8886DxPTONjwjSw6ZAgxyoKdqRJw1Ct6t/2EtfA23V5OF5YXOZNxPlmrCxlz?=
 =?us-ascii?Q?agNtSMxfxMa5fXnChnw/3dxL4C9dWcl8w074prIO+bAxT9xH7HZdipi0EprI?=
 =?us-ascii?Q?FYLpCle4jxAHK81wxJcGsym5+CLjHUYdTU9xP66Olf4IGqJtXGylzFeo7CAR?=
 =?us-ascii?Q?IN9LVffqeKkuA1bbRa2IcZJZPOo5Ma5otBQmmjUg49yngYw0v5hij6aYjb1A?=
 =?us-ascii?Q?hd3hqxLOx4SYa7lxRWTvNPFHv/KZyrLQlfpJaILqLAyrcsxrVc+cxGk5qnPz?=
 =?us-ascii?Q?m/oLNe12am2Dx9REsMc37HjUh/RImqe8AcXH+peAeKEKLTk+QjX6nL2uAe9a?=
 =?us-ascii?Q?gA3K6LFifxMt7CNft5CejDGzRiX+/4Wy9zSl9Fxk2JDBJAnmfZ9rWyxctnOL?=
 =?us-ascii?Q?hyY8cFv4AxjdzZldCIi97ktG7SjCehex2FMp01gtCUKk4QtBKIhrf6h9znYx?=
 =?us-ascii?Q?7WzfJgyL1kAN6zBJiB+WxuV+gWNoYQ6hu0H0wqnHk0xSTCutdDi9MSigavis?=
 =?us-ascii?Q?Tc+WP9QA+YXGd6YhpRleT0UxU8lO/XYjZUjI33lTi0R0Ukb1pIIt94PeYbC1?=
 =?us-ascii?Q?WVeixflTqnLoi1uKZ5mDIqBr2LNkC6Xi9RZRW6T0olDRwhGGtAsHgsek4lbo?=
 =?us-ascii?Q?Z42aWCO5iogmWXi9X6PmzTsFrGiDn/xZu+rymmcI2tYo/Y8M+Nd7SWlumUKD?=
 =?us-ascii?Q?OlK3XiGNUS6tAD4Sh2a/hvCXHvWvg9u9sflOOCG7JkFV37lg4WnH7aWn5Bux?=
 =?us-ascii?Q?BE7JBJeC3nZuZmKS1huhJ86O5o9O6yKUWJqg5P85eiwNf3eABQ8hfPs2Bio3?=
 =?us-ascii?Q?pa8GlGei7p5P6EOUG+qF/7GRsNxCvLsNtobFgPnjgGdUYKnhpl8s+71ZxvBI?=
 =?us-ascii?Q?o/LrxVnI+FWUTrZozizVmQPg44z3ze+Rr6Wd8dQkhzo3B7S69E4ry0+Aq6AT?=
 =?us-ascii?Q?BAJo73TgkHXPI3mqfAYIXNx0a0sc/8CP?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SR6EInirC8+cJHj0V3hY7AW+bNDmLumkiXSfrclTG3fVOjaS1mTgKCiyxbm3?=
 =?us-ascii?Q?ou1ZKAiNTnttxeP9Nlqa16uiMLL+Ah5iyVqxZ7qu5ilKz0Ox7+V4udnFjPHp?=
 =?us-ascii?Q?+HzdWJr4cFQ6Js6adBJAyWzlj4Akcg1HowNDumPB9Tbcw3mBglwOWFOE+TfC?=
 =?us-ascii?Q?h9P3E4Zphhwp+R5pf7yAjHxQkps568HUV4Zau0iveKBwExtQhhbLiBU9tXA7?=
 =?us-ascii?Q?JDe0AE9xh3maJDtXA9UVLbY0vA9XLRIu+NW9lsFZHdbR38/hhqIaqeXjh/GM?=
 =?us-ascii?Q?UBYHKSauEQFtQZB8SnzSS85yEXXu/W2sLaN3bhXOOEPubNQ5cfPcdWsO5Er9?=
 =?us-ascii?Q?+Mq0HjcdSCl1a+LHUhCe1/iWsxVeDyVsc+DkeqxsntK9r/OGtKox51nzULg+?=
 =?us-ascii?Q?hEfFiVthnKK8zPVbI+aDFq4afN3CJo0c8vVSV8X+IoufnVvcZmK+1paJu5Kj?=
 =?us-ascii?Q?rVObAxJL2SX4xl87iJk88g40ZNvXBhjtkBV8/6hbzGODPg/SL1hWZfibhK0n?=
 =?us-ascii?Q?L27tGOY0B7dBm4iO73AbHYaudSyaBiZrG7YFxk7v/lZ9SCrWCEdj7+jrVDhA?=
 =?us-ascii?Q?rklmHxHaVTZ3duZqYDvJ+O3ToUQpQAW8P+LOXCMkL/aqlq6S07lL9sqpZaLF?=
 =?us-ascii?Q?ve4C+q/98k8H8P4k08LIxhJR0GTmJsZF0GFiZDT2WZPvlbHSFPzNdCn42bsk?=
 =?us-ascii?Q?tqYxSUX4np5Xm2d5xSGY2Szs6t+TlD6mb9DeomX0nEP3/EPmLHzezc2hjfro?=
 =?us-ascii?Q?EqwavT3ivaDLXNC6v3RUNVK8r+fVU2ydTZFZJAosyB+xDhjR3sWmfGqAXJHO?=
 =?us-ascii?Q?zkZcrqYZtOBO6KK7UNycD64zivi1Hw2M0v4UaiRTXzQEqfikdm33/0OZF5Iw?=
 =?us-ascii?Q?fu1IcNB905ZP0BuKEGeX5p6sV7BYAMFHbd72kQXfWBdYko25LA/w8U7zwFOJ?=
 =?us-ascii?Q?R2wtiFx5cIQfJGiptOlF5GxoXPb8xUpor+5Vy61LwtUB4wxm+13O1XpKTW5S?=
 =?us-ascii?Q?lZvqlNMKpcaNwMeusADgAOLDwwXEYxViMwQ24KdtlEYFjSEGinjiaPTCahdg?=
 =?us-ascii?Q?ViF1Mqn8JhxvCO5Nf1dOB2O9z1HrnFqgQVHraFUcU9VsmF8MydnsnkLHIxlv?=
 =?us-ascii?Q?LsrqeuYDHqjqQiYDWYi36hdX9XN4y4YtLqwjs+TuxEOfCs8DNgZN9asSRYJh?=
 =?us-ascii?Q?k1DB0p5hQNdFvs/8EwwXakkTm2U6MrZXeGfdgX5ErpHpZUKGz67+CfjMi3Zn?=
 =?us-ascii?Q?j2u+mUXSt5vDbLUQVviHjgKDJbaxeB0hu25ACtVR0XDYwuCAX39NKCuimhZq?=
 =?us-ascii?Q?1RXCiip2WEhcpOv3VP3d4zOnUr4vZfrB2fanSTXEPocgdRm9z2/eHVOG2SOM?=
 =?us-ascii?Q?P6kWDgv5UdcUGKwFjQVBtJMr9AYmmf9Dqa3yQ6ynbxwJrPyJTUt0JjIc+i/1?=
 =?us-ascii?Q?h6lPIKoAtMWeGx/jKUa1/5z4LmBj9rDf++WzhkfrWhuXUz1oRISYlqXUawp6?=
 =?us-ascii?Q?MNaVRINMB+tBlsPdzeYQzQ0NR9Orz34MpZYTjZWyBDRhhvTmq+KUdrsSw7c6?=
 =?us-ascii?Q?FHWdfRwr1lawBB8cOEI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daec42bb-5553-45ea-0061-08de3da2d36f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 19:31:07.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A89DulwooC9ON6rUVXa9dv+7Gfy7yjChx38D5CZrJITKdSuYYMeN6dJU1C/HTEb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

On Sat, Nov 29, 2025 at 10:24:40PM +0530, Sriharsha Basavapatna wrote:

> +struct bnxt_re_dv_db_region {
> +	__u32 dbr_handle;
> +	__u32 dpi;
> +	__u64 umdbr;

__aligned_u64

> +	void *dbr;

void * cannot appear in the uapi headers, this has to be __aligned_u64

> +	__aligned_u64 comp_mask;

We generally don't have comp_mask in these sorts of structs and it is
never used, remove it.

It looks like it only sets umdbr and dpi, so what the other things
even for? Remove them if they are not used.

Jason

