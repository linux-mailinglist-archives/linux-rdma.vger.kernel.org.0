Return-Path: <linux-rdma+bounces-5753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4679BC49F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 06:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE9F283060
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 05:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E701B85D3;
	Tue,  5 Nov 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxQuJIkG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F56383;
	Tue,  5 Nov 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784157; cv=fail; b=dgARr3HdKGINhWAD0+0oNPSkxiOCP6vR8Kf4FxX7HyENzvJfvqJ1OWkKEqJKqV0/8TGMKysUCjWCAY4O87cpw3RiMm+lZTqjRRLxlMupTEXIwnpqyHTgXn4SddRgj/Ck3O1VXE9Uu7cANhrgKE0QYVSTBl3uxD9Mguq+0KOCBNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784157; c=relaxed/simple;
	bh=n29BU6u875JsLzAE5UVa2+YiC40ExO6rC7veXPEmwSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EqVDa4VyuI70YPfKvcvsRRTxRmcGGAv6ou1KIvle7iEMqFSz+al7O7whYd2UXTfQFKTdZs26e74JC4PUE6XFtGlFoFokLIcyNpKp2LOtzqeu3XxyMB/tW5JdyumBwoYiTS7PtA3/83lv7sjYVGfon72bQaRhhjVPFt0PHFtRdPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxQuJIkG; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1UHSwGVvcTnDHy9WJzJo2LteDgi8fuetkYE+p8U0WJnp88O1Taz5HSGJZ+tngKbvyyx4l43CwirVa6uLdggWwdD/mq0VARYgZAkWqLZxhZviybbXRR+KjYo7gfq4IA/XKocKhIcBHxiQLK7X8SX3+hDL1/2/cbHrOzXTU8fUHCDpAj8LN5MpCfl6vO+/QohzlUMsGaRExAvU9HsCy/ezIX+ODvHtSrOvJ6rTdkNGYPgzbhoUXoRetMyMCFmdyn0w5ym9rUnJAKXNNRr+Zl/Ng2Yud7+QavMwpjA6mq/jk6l5SrDt5EnTh5p6s4BBlJSN4osPE0/z2lbWcboY8o7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n29BU6u875JsLzAE5UVa2+YiC40ExO6rC7veXPEmwSk=;
 b=HGvLEPa4qJsfiiRcPIt4opYRyxgrnDgHpxyT00G2meq9jG6/F9tIeCGyWQ0ljnwZFAZbZkdwPzw8ZWWpF3HpS3lmrz8ZsxMbv6n9L1MQ530pvtnxb1egaSQoe6SQM5KMIQ7Rpn4DmF0ewnvM2WP9Yma9uvQUO70laCnROQS8SXFl18JDAVH5KEASsvB3hmrANopib2daxSNZGaYWEAmb9Af4fwp9KQs9FdmhFPOBECO8hCUlHR9bKqLX0lw9owhX2A+b8PbnjhKpj6rsgLFRcZcbvHC/+qOAS9jlmV1U+57gja7e+sFQ4HOZ6sP57Aqom4FZMdj6V5T2MbEL5/FvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n29BU6u875JsLzAE5UVa2+YiC40ExO6rC7veXPEmwSk=;
 b=GxQuJIkG1pS8gW4B/PhE3H7/wK9ROGHt/oKMHaTuDb2YfRR8xEhK1ZBSy0AMltDNQjIAKM2dU1TMbDnFTCUdcP3ed4LWcT/FjpKIrHfjM6f+mk3Hf9os+KYY8gv51NLu7BjbhFQ4NIV2PQ/K3sCND4fXAIvEtOF375DwhztdAJdqgpd+bULTLw4ol8qvXgPAyX9nKUGHMMIAb/4s3nr+1fIQnzTKHK3mLy+IajMHdgMZyYlNFKyfx2IcIWPFmOAD+IIxiOkSjtuJYMBzNIwpzT2eMsekSyINgGAOtzvi+NQib8PkgflQSMW1FL+uQ3r7B7QM1eLvRJC5Y7CrRHU07A==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:22:31 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 05:22:31 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander <csander@purestorage.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Topic: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Index: AQHbLBDvBoxTaznD+0G3MAKMk1HOTrKk6zPQgAE5WoCAAgfKUA==
Date: Tue, 5 Nov 2024 05:22:31 +0000
Message-ID:
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com>
 <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
In-Reply-To:
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB7234:EE_
x-ms-office365-filtering-correlation-id: 14e6306a-ad2d-4f5e-2179-08dcfd59d8f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1dpY2oxeUFkY3ZHVkkwRXI1RHlJRFVBeVV6TzNuS2ZNTFFhU0pMZVcwcGwr?=
 =?utf-8?B?Q3d3d0RJN09UOG53bnJWaHpIeWNlRlBmM3BBSHJPbTBtUkNlT1pKRUNmV0Vy?=
 =?utf-8?B?ejVEQi83OFNaNGJtWFQ3RE5WSXZiTFJRUlcvdE1DUnQyTWJjNE5WY25KS2xw?=
 =?utf-8?B?NGpsNTg1TjNFK2M3VFBzdS94SFlEZkhUVGJMYVJRamhIdm1nNkxuVDh3RERX?=
 =?utf-8?B?cGl0Y3BicDVTVGxINnI0aUNYT3FZMkdZcmlzdUFiUUt3eXl5N3RNbS9idDZL?=
 =?utf-8?B?cG1zYVgxNHBVUitmaXc2RGJndmRIemNXVWw1c21CbzB5eEhDTm1VcmZ3UjNB?=
 =?utf-8?B?aExPRnYxZ1hNUS9UcmVvbW9uVUlSeENUSnA2NkV2RUNiYlRCU3M3S29YK2Ns?=
 =?utf-8?B?RDc0ZUIrMjlOUlY1QXNyWElOa2JuT0xTb3FDeWFuOTJuWENmVmR5WXRrdExT?=
 =?utf-8?B?aUs3WjRPcnRIbnFLa2R1L1ZsUUhXQ2xhNzFlTmhCM0owUDVHdmF0L3kraGZt?=
 =?utf-8?B?ZUNkczRZUVZaSmR0cVJtUkU2NDRXVHlZL0V4S3dxM2xlcWhHL1pGOGVwOWpY?=
 =?utf-8?B?SEFUcmREWTQ0VkM2WTdITE5EdURMdDNOUHoxcDBEUkRtSWg2RHVueEorY1dM?=
 =?utf-8?B?S0d2SUhyZXlRelRtNHRkZWpZV20yQ1ZqVVdoeTdyS0RyQ01iQm81ZDhkNUt0?=
 =?utf-8?B?ZllYRGhTSDNTbUpMVXhiakZjeDBFMzFMZUdhMUFmenpQaFBxeHgrSFZvYnpv?=
 =?utf-8?B?S1VrOVNndUJLelYrS1lML1pUM1hGYUVXZzdNT1Z1aFpCaEpidm1BdWxXSi9C?=
 =?utf-8?B?S3YvTUZCMlFMVWhsbnFaNXo0OHpkZW9lZjVSd0d1QkZsUjkzR2tQS2lNYlo1?=
 =?utf-8?B?Y3FuODQwTENhU2J4eGcxUkF2V3kzMkRyVW5ETVo4VGs5OHM3c3UyQkZhTGVG?=
 =?utf-8?B?b0hsR2NScTFZYlFZK0hHN1RPVW9aS2JLOVJSWW5XZm40YUVrc0dwaVJrcXR3?=
 =?utf-8?B?NG9EYXhwNmR0NVhrNVVBMlpWa3R0ZkdzOWcrMktTTVJwVm1PTFpWQkRWNVZS?=
 =?utf-8?B?b3FVd1ZDZ1ZjSGkyTU94NU52UitKWGc4YnRBZWtJY0U3WG1hZVNDQTJBSVRZ?=
 =?utf-8?B?NWpMV3RPREtWTXNHMCsyYWZTSCt0dTdXeDQ0SEFSakZDeXh4ank4TjRwUTdh?=
 =?utf-8?B?QVlIRjlJSkNacVRPdmZCUVhxWG1oNTVnNUt0aDF3SmU2ZUhYZVE4TDl2ME1E?=
 =?utf-8?B?NGNqd2U3SVluaDgyNmdvbnE3R3QvYmUwcFVTc2UrRXVxVEwvQ1dSZ29nUXJ0?=
 =?utf-8?B?T09yUTNVQmpXUERkTmxzdVlqY3VRcHJtSTRaZzdLS2c1ckNUbDFkOGZsVGdE?=
 =?utf-8?B?ZnNjdG95ZldKT1B3enk0VDA1Vi9EOTc5MUN6aWlKbkhEaU9pa0g0SWJGNHFp?=
 =?utf-8?B?d0pBcVhUaEdJcUpaa2pDaE1VY29NMmFiU1JzVW1wd1BwSXBjNkgreTQ3elNW?=
 =?utf-8?B?UWJ0OG5hcGozMm9wZXAyUDg0TmxneU1KUUdKbFMzakxQWHEwM1c2dnUxTDJE?=
 =?utf-8?B?OUxQZ25iQVpVcjZxcVMyZXF5dGNkYXZJYTlENUhxRHBZZCt5ZnZndjZXZGpm?=
 =?utf-8?B?LzJWNklSSFhKSGNQdmF6SGhWUFZYZGpWNTBubTI4VnFwOEU3SXBSUXJyckov?=
 =?utf-8?B?SU1FRDNlT0VWOUZUdWRaVWVxMGU3clZvME1yMDdUL1d6bnR3cjF4RXdLZ3RO?=
 =?utf-8?B?N0pBeGVQQXVHSks3T2VucndianVObmlncTFBR2RDelloVGJVc1lQb3BuMkF3?=
 =?utf-8?B?YWVCcEJVcjRvUzF6MG1kMG9wV0JWYU5Vb1Rkanowdkt1OHAyamU4bGV3dGpq?=
 =?utf-8?Q?TmnNCqvotF1g0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmxCbjhxTnJNL3J4bXVsVjhmY3ZnRE93TDRpVUFHajJVTS9hVWJKS3RBVCti?=
 =?utf-8?B?b0E5KzNzb0tPbFBtWUJSd04zMDZSeisyMFRsQ2d2NmRzUEpDUTJuVi80QUgy?=
 =?utf-8?B?dGViMlY2dU9HNzUwaEtvY1gvS2lWa0VWY3BYZnpJdWJ3b3NvSVZ1azF4aTJB?=
 =?utf-8?B?ZWNUbXJpQ3I1VVlVM1JKN2x5UWp6UkhuWWlReWZRMHVFOFBaQXM0L2JKaXBX?=
 =?utf-8?B?b3ViT09kclhjRGIyUHJKVUVyZ3hTQUxkZVN5ZCthcm5IWGl3MTJPaXQzbTlO?=
 =?utf-8?B?Z1FVVVFXNi83b2d6SW10R1RNOXNZSWxtNExNbDU4SmFnanJHY3RSNVNxK1lv?=
 =?utf-8?B?MzQwRUlzSDFTQ1RkUG5ZTjh2dk83bVBSTGgzV3ZGVXR2Q0U2VldxZnkrNnNk?=
 =?utf-8?B?Mml3aFNCSEtGcVZYYVdtUmQ2NTZlVElPY3RkbTZESkRENmV5WVJRclRpSEdz?=
 =?utf-8?B?WWo4aDU1M1p6YUpHOENVQ1UxbHcvZ1VhaGdTQk56SnlFam85TjBXTkdUMCtN?=
 =?utf-8?B?Wnlha0V0SVk2S0FETE5YZVdxd1E4Ri9yaFBrZXV0em8wUGFiWWFSeHh4OHd4?=
 =?utf-8?B?cUxtaXhSWEtER0VRZ1lpcXRkMnMrR3RhWlBVbjJKRDBxNk4zQXBGVFVLb0Yy?=
 =?utf-8?B?UUZPK1ZDTE1wbDNKTFQxQWhUR2pmZlBzWmFoQ2VFT0poMG5NNlFmSDNzaURw?=
 =?utf-8?B?RmZiWitnTnR5SDk5QzVOdjUwOUVTQ0p6Q25lTjJnQXdOWkNRdk14a3J5Snp0?=
 =?utf-8?B?REdGaUZNN0Fzb3hMVkgwTVRqdmxsUlM2NXhrT3BIRGhVclNRelh0b1M3dVI0?=
 =?utf-8?B?bGRwVWNCV1JYeld1VDFFL0RGNzlHRkF4SlJpSEJPZ1A0YnhJUzUyUVVUZUhB?=
 =?utf-8?B?Q1BFNUJhZUpDaHJFMmh3clJYL2RoQmhsSVN4d0NnZW1RdjNzZm9ZRjFST2ti?=
 =?utf-8?B?a2VwekwvV2VhWGVacnBUV01rWis4ckNlL3BSVWNYSDVsTXhuV2c3MU42OGgx?=
 =?utf-8?B?NTY2dE5sTkM0NjZMUTVqWFcweUlvN3BnWHRmMXd0dWt0bGFLS3ZVZFFHcmNs?=
 =?utf-8?B?Yy85QWsyaWo5REIrVSszclFodHpIWTM4dU1PViszb2hHR243MUJkL3k3VE4z?=
 =?utf-8?B?RzlycDFPMWtOREMrTDEzL2U5S05zdnRKNnhDRTRVeTJnQzFKUXI1VWdOSFVy?=
 =?utf-8?B?bERTamVIYlZWWnRnZWRvaUVQaFB0cGtwd0RHbUZHMW5vNHpZY3FEcys2ZmJn?=
 =?utf-8?B?cG95RkZ4VXpKQ25Ma3hJQjRGRWNzbFVKUUVRRFlzZlM2eFNUMC9mNHYwTDhy?=
 =?utf-8?B?enJXYjZzcXlKWEp1RUNEbTdXbDRlSWcyUzkxcjZQdWFvMWwzU2ZqekZ0Zy9B?=
 =?utf-8?B?bDNNSy9yMUVZL3ZVMWx2QWlpRlZyUE9NTGpDb0tZRUFPT2laeGxrb0dOV2dC?=
 =?utf-8?B?RmpLMDZWNk9SdldFb1hYMDdSV1VsSmwyWWRySlQrRCszOXBKQTdTYUNHaHM5?=
 =?utf-8?B?UURabzBRTTJaNkphWGRxcmw1N0RjTU04ZlJXeHh2cXk2SzNpeGd6TjJFWGE3?=
 =?utf-8?B?MzJiWTQwUU8zUW9UZ3FiYThaWmp1aWtTcEdGZHN5T0JLTTB0Qk5yQ2RKN3h2?=
 =?utf-8?B?MVk5MXZJUnZDdDFqQjJLN3dINUVmMVZqNVZ0S0R2aDhIb3ZzemM0WFYwbVFm?=
 =?utf-8?B?QXJETENMZnRuWGwyc0hIYUJLd2ZmNnp1aVFTTjgvdExOdldsaHdST3Q0RDNI?=
 =?utf-8?B?UFQ3c0pmWXZzODcwdmxJTjNSQ2M2YTdyYTVEMFBkMURCYkVXNmpIdkNYeDE0?=
 =?utf-8?B?NkJmYnVmVGhoMmQ2QlpKemxvV05xempyek9nRjlVYnBvLzc1WWt6bmVwWXhO?=
 =?utf-8?B?TC9Fdzc2bzVGRzhuZFhqNU1WQWxMbWxyWEs1UzZHVm5OcDRGL0RXMFZ3MVNq?=
 =?utf-8?B?dEM1aDMrSSthWDFLdERyOGNSNlBEREFxekZIcE9XU0JRM2JvM21iMHVQYzhI?=
 =?utf-8?B?cFQ2U0w1Q2lRRnVoN1NtaXQrY21heUEwVjlWS0lFd2ZhTGlRMU5Nem85MDhy?=
 =?utf-8?B?NUU4eFFFb29LWUVtOHlXeGhtS0dhMVcycVFiS1NsQ0Fzb2tYREZoM1FOQWpP?=
 =?utf-8?Q?QXcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e6306a-ad2d-4f5e-2179-08dcfd59d8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 05:22:31.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7APzrNwE4D9KJe93sJwKGvdNpftIHjfM0xyFcZXDvbDqTOgpRRdH7vdFs0xqFHK3CiNdTABz13+IZdsyaQtgrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

DQoNCj4gRnJvbTogQ2FsZWIgU2FuZGVyIDxjc2FuZGVyQHB1cmVzdG9yYWdlLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBOb3ZlbWJlciA0LCAyMDI0IDM6NDkgQU0NCj4gDQo+IE9uIFNhdCwgTm92IDIs
IDIwMjQgYXQgODo1NeKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiBGcm9tOiBDYWxlYiBTYW5kZXIgTWF0ZW9zIDxjc2FuZGVy
QHB1cmVzdG9yYWdlLmNvbT4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwgMjAyNCA5
OjE3IEFNDQo+ID4gPg0KPiA+ID4gVGhlIGxvZ2ljIG9mIGVxX3VwZGF0ZV9jaSgpIGlzIGR1cGxp
Y2F0ZWQgaW4gbWx4NV9lcV91cGRhdGVfY2koKS4NCj4gPiA+IFRoZSBvbmx5IGFkZGl0aW9uYWwg
d29yayBkb25lIGJ5IG1seDVfZXFfdXBkYXRlX2NpKCkgaXMgdG8gaW5jcmVtZW50DQo+ID4gPiBl
cS0+Y29uc19pbmRleC4gQ2FsbCBlcV91cGRhdGVfY2koKSBmcm9tIG1seDVfZXFfdXBkYXRlX2Np
KCkgdG8NCj4gPiA+IGVxLT5hdm9pZA0KPiA+ID4gdGhlIGR1cGxpY2F0aW9uLg0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IENhbGViIFNhbmRlciBNYXRlb3MgPGNzYW5kZXJAcHVyZXN0b3Jh
Z2UuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL2VxLmMgfCA5ICstLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VxLmMNCj4gPiA+IGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VxLmMNCj4gPiA+IGluZGV4IDg1OWRj
ZjA5Yjc3MC4uMDc4MDI5YzgxOTM1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VxLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lcS5jDQo+ID4gPiBAQCAtODAyLDE5ICs4MDIsMTIg
QEAgc3RydWN0IG1seDVfZXFlICptbHg1X2VxX2dldF9lcWUoc3RydWN0DQo+ID4gPiBtbHg1X2Vx
ICplcSwgdTMyIGNjKSAgfSAgRVhQT1JUX1NZTUJPTChtbHg1X2VxX2dldF9lcWUpOw0KPiA+ID4N
Cj4gPiA+ICB2b2lkIG1seDVfZXFfdXBkYXRlX2NpKHN0cnVjdCBtbHg1X2VxICplcSwgdTMyIGNj
LCBib29sIGFybSkgIHsNCj4gPiA+IC0gICAgIF9fYmUzMiBfX2lvbWVtICphZGRyID0gZXEtPmRv
b3JiZWxsICsgKGFybSA/IDAgOiAyKTsNCj4gPiA+IC0gICAgIHUzMiB2YWw7DQo+ID4gPiAtDQo+
ID4gPiAgICAgICBlcS0+Y29uc19pbmRleCArPSBjYzsNCj4gPiA+IC0gICAgIHZhbCA9IChlcS0+
Y29uc19pbmRleCAmIDB4ZmZmZmZmKSB8IChlcS0+ZXFuIDw8IDI0KTsNCj4gPiA+IC0NCj4gPiA+
IC0gICAgIF9fcmF3X3dyaXRlbCgoX19mb3JjZSB1MzIpY3B1X3RvX2JlMzIodmFsKSwgYWRkcik7
DQo+ID4gPiAtICAgICAvKiBXZSBzdGlsbCB3YW50IG9yZGVyaW5nLCBqdXN0IG5vdCBzd2FiYmlu
Zywgc28gYWRkIGEgYmFycmllciAqLw0KPiA+ID4gLSAgICAgd21iKCk7DQo+ID4gPiArICAgICBl
cV91cGRhdGVfY2koZXEsIGFybSk7DQo+ID4gTG9uZyBhZ28gSSBoYWQgc2ltaWxhciByZXdvcmsg
cGF0Y2hlcyB0byBnZXQgcmlkIG9mIF9fcmF3X3dyaXRlbCgpLA0KPiA+IHdoaWNoIEkgbmV2ZXIg
Z290IGNoYW5jZSB0byBwdXNoLA0KPiA+DQo+ID4gRXFfdXBkYXRlX2NpKCkgaXMgdXNpbmcgZnVs
bCBtZW1vcnkgYmFycmllci4NCj4gPiBXaGlsZSBtbHg1X2VxX3VwZGF0ZV9jaSgpIGlzIHVzaW5n
IG9ubHkgd3JpdGUgbWVtb3J5IGJhcnJpZXIuDQo+ID4NCj4gPiBTbyBpdCBpcyBub3QgMTAwJSBk
ZWR1cGxpY2F0aW9uIGJ5IHRoaXMgcGF0Y2guDQo+ID4gUGxlYXNlIGhhdmUgYSBwcmUtcGF0Y2gg
aW1wcm92aW5nIGVxX3VwZGF0ZV9jaSgpIHRvIHVzZSB3bWIoKS4NCj4gPiBGb2xsb3dlZCBieSB0
aGlzIHBhdGNoLg0KPiANCj4gUmlnaHQsIHBhdGNoIDEvMiBpbiB0aGlzIHNlcmllcyBpcyBjaGFu
Z2luZyBlcV91cGRhdGVfY2koKSB0byB1c2UNCj4gd3JpdGVsKCkgaW5zdGVhZCBvZiBfX3Jhd193
cml0ZWwoKSBhbmQgYXZvaWQgdGhlIG1lbW9yeSBiYXJyaWVyOg0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjQxMTAxMDM0NjQ3LjUxNTkwLTEtDQo+IGNzYW5kZXJAcHVyZXN0b3Jh
Z2UuY29tLw0KVGhpcyBwYXRjaCBoYXMgdHdvIGJ1Z3MuDQoxLiB3cml0ZWwoKSB3cml0ZXMgdGhl
IE1NSU8gc3BhY2UgaW4gTEUgb3JkZXIuIEVRIHVwZGF0ZXMgYXJlIGluIEJFIG9yZGVyLg0KU28g
dGhpcyB3aWxsIGJyZWFrIG9uIHBwYzY0IEJFLg0KDQoyLiB3cml0ZWwoKSBpc3N1ZXMgdGhlIGJh
cnJpZXIgQkVGT1JFIHRoZSByYXdfd3JpdGVsKCkuDQpBcyBvcHBvc2VkIHRvIHRoYXQgZXEgdXBk
YXRlIG5lZWRzIHRvIGhhdmUgYSBiYXJyaWVyIEFGVEVSIHRoZSB3cml0ZWwoKS4NCkxpa2VseSB0
byBzeW5jaHJvbml6ZSB3aXRoIG90aGVyIENRIHJlbGF0ZWQgcG9pbnRlcnMgdXBkYXRlLg0KDQo+
IEFyZSB5b3Ugc3VnZ2VzdGluZyBzb21ldGhpbmcgZGlmZmVyZW50PyBJZiBzbywgaXQgd291bGQg
YmUgZ3JlYXQgaWYgeW91IGNvdWxkDQo+IGNsYXJpZnkgd2hhdCB5b3UgbWVhbi4NCj4NClNvIEkg
d2FzIHN1Z2dlc3RpbmcgdG8ga2VlcCBfX3Jhd193cml0ZWwoKSBhcyBpcyBhbmQgcmVwbGFjZSBt
YigpIHdpdGggd21iKCkuDQogDQo+IEJlc3QsDQo+IENhbGViDQo=

