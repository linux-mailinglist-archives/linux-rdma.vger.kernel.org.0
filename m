Return-Path: <linux-rdma+bounces-10263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA35AB26EF
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96B61897331
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89B19DF4D;
	Sun, 11 May 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTqELk7E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D5224EA;
	Sun, 11 May 2025 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746945847; cv=fail; b=kybvI3o8YrcCK6O6iwi9sitOsdEe9k2+DacV4aye32weafN5EinBOP3jRi/yZYq/rRGfliiLCOl17sfvbRDj2CcyUqLkpnuIx5moPbFjolM7DGhz7iJdmVmzPaXcnFbdxMdiz4owrzyofvsbJBZJTzb0CTsp1LgjVc6NZeHOFv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746945847; c=relaxed/simple;
	bh=Ws1EfGg+Iupgtnrre2afKKV8AHlwSwev3dyoUzaPeg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbhmM49rsDyJKGDiASB0w5RSVPaw5ITa1MtzW7z4vY4jlxgXaTo/yg0Q+GRFXbPYYD+jWEln+dMseSl6M3QszZtrkfHgWPqpvJ+jPARuSKNm9CLHTaqDRpATm0Z53AQ/H8nzETXHIvErEhe4VUiFl626Iw8Aywknncu142d2UAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HTqELk7E; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFdzOS5xI7wxCrXeG/JqzJ4RlbZMg79HBOauIwtoOVcnHNkMGzM1JK1xpMq7m5pRIcqfLI8eokXN4dqGKWT2W6laBe2Gy5jaO8LbZdSY+FoOoeliS/8WYiBfzahG+F6wOJtdS7HOSzJf0jLY5wOvkY2JssfCLcT5j/CUBQOsoO3Xg7+gYbGxqRLkTw65+KdiGkGpTNFRMz+2y95TGw80ThPW0nR6BFEcwpP4rH6HxMrD2hxUT4wI08FUhTBtJR0S61er5pBkyF85f79OBfKfaSxiKJ0q6J2xpWPT0+XoNr+b9cCavwWQ60qtOBoprC03OKW/9WqER5Zmtf/+Vxd2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQghASixu0jy9YOpeAl7+koT2n7HIpEUA0szGRJK+sQ=;
 b=LO4wg/9oalyphAT0U8se7YWZL8z70HNd5xTqRlJoqKk0IM+AOogxX6GxXltoMLQdYpwGOWncXNS47pqRC7Fz+t+4cD+uxRP1A6KnpFo7s33hN8Qcgl2n6pWp1sFi4t6BVdWoFXZr/WcXFvi8+m45MTkYHKjcqEYYx6FMYLSbB42Fjy25t1HWOZMuxzNQfMIcWVs33VEACciqrB8+xbQBv52ZtXIkxut/EMkE+J4RPtW4jsfT+Bdtyn1IJRMgiJthw+SpJbBou8XiMZ4gv8uZs9kuQ6nUHDSUqyAtWHdLSdH8FMu9IM7mwhh/6I8a5EcuW2SvNaDf6/ckoNdQbE+9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQghASixu0jy9YOpeAl7+koT2n7HIpEUA0szGRJK+sQ=;
 b=HTqELk7E9nECO9bKbWN2yAgQYI3a+18uiBwA2DygKOMgcs4OEUHDkUegXrUSxHxA02KXg5y0k/4A8iPzh82hi7EgUubyB2ZgtxMBnvPYajgj5bxdP9p4TNwTVY+y25VoN7r3F7qSE+pAm8Z7cDlmJjkv9KjKJgG3+/BmoZpWcr+QgEdb2FR5W43klZ1rbt/e6GoBdEXjeJ1o3MwQSr39uSSJaNb4a3o7RpP6FKdToj0hQZN9X8mpXvbe45a7GlQIzvYI0zYMvcXs7ti2hJoQ6IZSLMXdQoN2bEgthoBxxBUeqfg6K7cB3W1eHriCpRPvnmZvxI8DOQtoDPf4pMC4iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 11 May
 2025 06:44:03 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8699.026; Sun, 11 May 2025
 06:44:02 +0000
Message-ID: <652b710f-b3da-460e-ba88-a66f733a17a0@nvidia.com>
Date: Sun, 11 May 2025 09:43:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V9 1/5] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
 <1746769389-463484-2-git-send-email-tariqt@nvidia.com>
 <20250509081625.5d4589a5@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250509081625.5d4589a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bebb7e2-782b-40a7-4166-08dd90573799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STR4ZktXRHBaWFpnbkJpaUZJamhMVkJMNlU1ZUZkdGZXNmtrb0pZRnU2SC95?=
 =?utf-8?B?SXV1UjB2NGZ6bDNNQTNEdldOTWtnY0JjU3kyTHA3WVVBaUU1aXREZlp1MEI5?=
 =?utf-8?B?MWplVHNieldhLzcvRGlLVEFVR0dMbDJrb2Q5U0l0L21MVnJRNVJ2WGxSSW00?=
 =?utf-8?B?MlRIVWhtM28yMktzdkJVd1pSOHI5SXRTbmZ0by8vY0tmb3VCcDVLbmRNUllE?=
 =?utf-8?B?QUlxTDZsVzNnS2E3N1B6TUwzU2NNem5obUd1RzlVKzRZdVNOUGJwSGNIOFF2?=
 =?utf-8?B?TERUQlFsTUR3dWxLd2hCdzl2aXVEREkxdENySGRadDhDRWNwOStQN1d0aDZO?=
 =?utf-8?B?M1R0MFZwdEJLYTJKbiszMEFVYWpJazhHaVV0MzI4ZDRWcEdvU01MTy9TbXlG?=
 =?utf-8?B?U1BpMU8yRG1uSmsvRDN1MGM4YjJWaXc2OHZkZ2JYUzBGWlNWNkFENXVtNmFS?=
 =?utf-8?B?OEZQSXVGNjMzaXY5RUZwR1AvV0dSaGltanBaZTlZNFFndWFJMjVvRHZWaXNa?=
 =?utf-8?B?SURDTlNaR1hMaEtLdDd6UWhXT1dJdzhBemRDajVxRU8zZGJpOE80cHFteTlo?=
 =?utf-8?B?L01XaHdWNU9kTHhCd1hXL2piVXdQYkl2a2JnUWNOMkppVVA5OXhrM05yK2do?=
 =?utf-8?B?SWpiU0hQV0xCcVVKVzYxWVowV1k1WjRMemloQ2M1Q2lFNm1teFNlU2RqNldp?=
 =?utf-8?B?U3dvdkU4ZE9PS2laRU4xU0pQU1JPUEdUcTBNZHlubzZSTUY4QndnVG5HWHlL?=
 =?utf-8?B?QWNFQ0UyalQzWnpjOTQrZmJadTdaY045YU5wSW1oY1V6L01WL0JLN09GSncx?=
 =?utf-8?B?d3ZFL2Ftd21kZ0g0SDdqQzQvUGpKT2tWY1JtZ2RrZGFsN3VBNTNTNjBnUjBT?=
 =?utf-8?B?bCtRbmNXVVFoUVMwNTlzZVJPZ2lXWlJtd0F6YUE1cmVqckVDdGdwQTZvT21L?=
 =?utf-8?B?NlpGTVN2QUREaGx3QjZDbDRHeWRRMWhnNXduVkRGM2hWTVRlWUoyR3BhRjMv?=
 =?utf-8?B?NU1xM1k1Z0J3Nk1ua055dTBrSWlvSXpMMzJFSG9BcUUzM0ljbVMrWmFMZDhX?=
 =?utf-8?B?aXpCT1hMZFcrdmxrT0wyRVIybDN3ZTFkTGFlVjkweml0aE5DMk1JZjVtVm1u?=
 =?utf-8?B?b2Nha3NJTTJTVWU0Qy9BclBwU0pOekF1UHBhRU5aT0JxZFUvZ1hoNEJsRzdX?=
 =?utf-8?B?RDB4a3pYYWtrV3hRUmJiSElNbGUzK0QyOWZ6NzRSWHNpZTArdk5pVm9Od1hi?=
 =?utf-8?B?Zi82SDM2d1BZMlRmdlJVcDBWWWY0Z09aVnhIVUhKRlNiMHNDYitvVFA1ellr?=
 =?utf-8?B?a0xEZS9kbENQdjI3ZjVaTVg4bGJkR0xvRnJ5TVhiVnBhR3pWYU9xbC85OGtN?=
 =?utf-8?B?MlhxczZ1cTExa3BFRDRIVjFZQkMwRi9hMEIycnk3MUowZ1czOW5xc3NFR2kx?=
 =?utf-8?B?YTJ2VzVTaXBMUzZvVDYyNWlZdFBXTjBxclJYclg4MWJTSUlXVWNpUlFKMjcw?=
 =?utf-8?B?OGxjakRDMGRZQktEdGlWWlV0c1dVUGMwV3Y3b0dsY2NnbmR3SElXelhhdVA3?=
 =?utf-8?B?eDVBaFFwYzgxakN4bnZSNUNVcUgrb1RwSzhiN294VlBJWTZacUJ1U21DNW11?=
 =?utf-8?B?Qk5WT3lPdDFicHVlK1VzZjM4Q0dFaTVKNmIxTmVGdGRyWFVZRUtUSjFCS0xI?=
 =?utf-8?B?K3BPbnFGMmh4NldnWm16RVAwVnVlSm1VMHJlK1J0THhxWTVoTzR1MzQxWGFD?=
 =?utf-8?B?T0ZKdjEydFFsR2JaOHRjV3Y0NGphRnZuRzJSV0RvMnNBY21nNlN6UjdNYXAr?=
 =?utf-8?B?ajlqRmlINnlYOFMxWjJINitUYmVXZjFHYWw0c0NrdGR1UGl6MDk1UFFTVS9B?=
 =?utf-8?B?c3J4NVlrMWJXaEtVUnZWU0FEV1Rxd29pNjVNcmNZcjRkb21ibG85QlBTSUpJ?=
 =?utf-8?Q?5Q7NDwEEOgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhTa2J4TldyaTY3MzhMRm1GQmlFY1JaZnpRVlFqMG1qajFhb0Q5aGdnUlJW?=
 =?utf-8?B?UndVYzd5QzRYUGIrT00yVFR2bFNaWXJjVi9mdzYvZW5pK055L1YwaExwaFNh?=
 =?utf-8?B?RjE5L25uM2JmT1I1TEtXWVV4U3ZFalIrWjVtdmtXK2VHWEVhQk5Rd09ZbUZT?=
 =?utf-8?B?ekc5Q3ZmYnFIYkVwcjZkQjNCUXBWSFlWTFVPVGFsOG1GNkxWSkhqYW1NLzNv?=
 =?utf-8?B?Rm1QUHhnemNMTWNWWjBJbDlteGY5NjhyMUhDMTFDd0l0Y2ptelc4VXFTVEFZ?=
 =?utf-8?B?OC9YKzI5QkxLY3IxZW5wM3JENFZ0aEJZak95Wjc5UWZicUo1dDZ6Nm0yNitu?=
 =?utf-8?B?cHZ1L1ZsZFp2cGZydStSNm5QYTYwTnlvZmhudmJkYi93cTZQZVRhaFh2WjV4?=
 =?utf-8?B?YzJJL3FialliUktHeURjRWlKU0JDZmN3c0tRbzU5Sk9TLy9qZjJCRnovM05P?=
 =?utf-8?B?clcwMVMvcWxIWU1KaXd0OHYxVGhnSGo4eWFzMEY5b0RmenNDUGtNbGNwSnJl?=
 =?utf-8?B?d2pRSHg4ZmtHZDB1LzVrMjdVSkVpYVJvQTJEdnpuNC9zV29FOEllOFBrZzdO?=
 =?utf-8?B?OXM1cVk0eVJYdjBqbzR5N3htYWhldkIzRzFCMjlwOXFQOFNrRXhsOE1tcEhS?=
 =?utf-8?B?Ynl0N0VkZlN6cmIrVVNmdTgzLy9YYzNIRllGZXBHbzE2emM2ZkZoSGhlL3lw?=
 =?utf-8?B?SzB0ZGJOMldxZzI2T3BoV1BzUUd3Z2RFK01aeERGWE9KNU5DUThLTXY1UTZ3?=
 =?utf-8?B?ZHd3T1B0V3JGeVJBUi95Vm5VbUVjWm1INkd2dWdzT2RJOW5JbVdsc2xXekll?=
 =?utf-8?B?Y0tHeUNVWVc4WGljeXZNdTkxZ0FYQzhINDZzeVZsK0lNdTk3OVZzNktrVUxi?=
 =?utf-8?B?bkpoR2RSakp6aDR4TGxVNkgveHZrSGY3RVBVWTBCQTU4YnEzWkF3aHBhOWkz?=
 =?utf-8?B?VmFXUlN1cXpDcUhjQWdyMlRGdEErZ3pkRi9McWxHcFp2bzJpMFZCbHQvZFNC?=
 =?utf-8?B?ZzRDN3dvc3VYeVBFU3VYa281MFN5QTFkVHNzRUtLYWZmV1NVYmgwdE9weTdm?=
 =?utf-8?B?bHlTQy9md3FXZDdNbGwyZWZ5ZXFGMjJFRFVMbndQdUxpY2JqSE9DWXJxeDdX?=
 =?utf-8?B?SWtlSW9LZ203YjZ1TCttNDlKTEo0MWRRWEhiTjV3b2tCZnYvK0lSL3hyRGdV?=
 =?utf-8?B?TlFWcnhmQ0tBKytTcW5wUSttdVNRUWc0RndjMzJOUHd2VVJNbzJ5VCtCb0hQ?=
 =?utf-8?B?ZE1GOFB5WG1CSHNmZ2E4QWF5ZHNTM0RTS1luTFVHM0U2T1Y4cnZJM3I2Tysv?=
 =?utf-8?B?Z1ZJdU9FQmI1RHhaUmZLUXhxd2NhMmhHYmNKY2I4UVk4dEtDdGppZzFsN2pw?=
 =?utf-8?B?aXZyeEZCa1VUN21BdWlseGJFZy9jTDlrZ3NKekUvZkE3aG1oTi9PUmhwb2JT?=
 =?utf-8?B?T2g4a1JRS2lrdlpGbFlOZzJLWHVjamRPT0xKN2dwdDhzV3MyLzBickVrQ0NH?=
 =?utf-8?B?b3l1OGM5ZFdZL1BNQmZEWmVzRzhyU3pjUHdxaXpxd3FiZ3A2NmpxOXJ3UnVn?=
 =?utf-8?B?L2Z1dCtxYzlKU1U3TTgwRGFra2gxWWV3RkdWK09OYW5hMWlZQ3E4aG9DYndC?=
 =?utf-8?B?YWtzQzRpN0tUcmtaTmhjT201TG8vYWp6dUlVYjRsdi9MS3dFV0htQm9wcElj?=
 =?utf-8?B?bTVxdDY3Mk9tbm5TNXdER0hPeTNEUXZvdEIwMUphTHB5TmJhTlJZZzIxU0tS?=
 =?utf-8?B?NndlcXJYOS9yQk1ZUlVObHZOdkM5SVVwdGFzcjBNSmx3dzVZbWpWQitBcFBz?=
 =?utf-8?B?b3ZPZDlvcXI3TkUvM3ZSaGh1bitRc3hjVDdBbkZyV2pZdjRWTWNqMXpQbkxl?=
 =?utf-8?B?eXo3aGo2bzBRL2h3cWlwWVNITkFIMlI5cGVhMkxGY3BlQXZ2aU9UT2s1WFEy?=
 =?utf-8?B?R0V1N2dyWVZ3VWlaZXB6N0RXaS82TEViSGE1YUFrTHZUaWQ5UEFlSDdRcmJG?=
 =?utf-8?B?eG9uNWFPUVZuMkF2eEZFRFpoM2JDOEVBYzU1ZnNHbVhIa3gvVjZPNWRvWmlZ?=
 =?utf-8?B?ZSt1Ly9zOVNuRktYNk1QbUpZdS9KU2pYZUI4ZGQxMUQwQllabzBtVGlXNUYr?=
 =?utf-8?B?S05UbFlrd2JkeHBmaFNqZWh0ZTNKWjZCTmFiOXpzcDFpSkhudXZlbWpMVU9D?=
 =?utf-8?Q?IfA3XF2m0J9kGDt+rZFIsnRvqvaCS42Uuhs+xjgYPspv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bebb7e2-782b-40a7-4166-08dd90573799
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 06:44:02.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0HCaMNtTifA4WlTBbsEpW+ztX+Da6h8lvW3aU5Z6mDXMEpooZ5ok7DbmnWWByCpMXJamyYs9gMes/5Z7j6FuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169



On 09/05/2025 18:16, Jakub Kicinski wrote:
> On Fri, 9 May 2025 08:43:05 +0300 Tariq Toukan wrote:
>> +  -
>> +    name:  devlink-rate-tc-index-max
>> +    header: uapi/linux/devlink.h
>> +    type: const
>> +    value: 7
> 
> Ugh, still wrong, the user space headers don't have uAPI in the path
> when installed. They go to /usr/include/linux/$name.h
> But for defines "local" to the family you don't have to specify header:
> at all, just drop it.
> 
> And please do build tests the next version:
> 
> 	make -C tools/net/ynl/ W=1 -j
> 
> I'm going to also give you a hint that my next complaint will be that
> there are no selftests in this series, and it extends uAPI.

Noted, working on this. Thanks for the guidance!

