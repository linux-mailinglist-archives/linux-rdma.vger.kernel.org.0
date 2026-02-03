Return-Path: <linux-rdma+bounces-16457-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB77Mfz9gWk7NQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16457-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 14:54:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29120DA323
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E04F6309B19C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5639E6D2;
	Tue,  3 Feb 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLmEfxnJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EE38E11F;
	Tue,  3 Feb 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126694; cv=fail; b=aHDjwZEpIHCiNAN4VwOMwlptSzFey7XNB6zR/NbyfpKlFOc8yOjTf7cjS3HpGG9CzXSwLCM2KWpHJPsQ2q9+qdmSNoMuE1iv5S4PBTVttQtC5g4uE9C0+tjWFhVJIDP4mJ6wdlGlnKM++2j2hAsTn+eF0q6MB40MQLDybglTSeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126694; c=relaxed/simple;
	bh=SA3EjZp1dvmzf0TKClc9NhhqniYUmJ4Nh1XD8Kanbu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LBl+WYxmOgL76zNrek4hSxZi2ZnUuv4eirqHgEonN2FDuWGiE9Y8tYjtJe6FQdZ8++n0s2uZ8ltGGHCo1C5+M9pvlFuHNJY4HrsVsVRuQW1Ont+aQxp9zhK11Bt129zf41ApyIoHkk1ZmZMfvnxEyPdIriT6RUp99oJdYaU6Ok4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLmEfxnJ; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fg9A5wLP9OkMg+JPhIUH3MjEasI1hOuVHBK9KoSqyA9sdAKk4fbpFA7uTZO4EkXYYQhCRBOKTBwacsoh/UTaTk8eO8VJN7v1C4QNjuEPUDbTKiJbfICQ3DUGp4vDac93ORQJr2Z+UX/oooLg8cn0BbS6PA5bDe4YU+VAkmdyt/SaaHQ32M62qIo2qNUmFJFmQ1vr7xN2fs/JWOiTTMMQGUK+/m1oo4wmm1k/BFM0/+2jSr5e4VTWIVIWV4FQUFHJMR4XKhX7hGe3PSCWE/ujpKd9qraV8iezaylpzHEGPpghJ2+jy4D4NWeMPlJy6Qyex/4+evdZr+hUjcz4frhDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU8fNIOkDFpRzeeXWBZ2UTMXQVDbtGUke449lshQxD8=;
 b=WG23BWWy5tG/R0aB1v6x9vARG9yIrPS7Eieqy3ANgpo7t5nPbDrtHxe/VtPRNn2x0IH7wThhTRKzC4I+9S5XYn+UN//D8gXfl7yFxmde593XNAXjEEVNJc/dPJEXOQAyK/sFlwjkHKPUzbF0zSM0KwmuGvUBQCaEpXKUNfjOAiPmeG8bCG4OUf51wjMbGLz0rGWsaUTbLPTaHa+7hrQVKGdKkD6xZng/dgqRnMU2/wbBEmLsUqraCWQFaXryM3rJgdL42VeOdIoKUXNyMX+w1FCvSlqqJMzZyHwT/TsLVinVsJD0zB9CzZiwnesgA11VxmO2jWa8n0goFcxVnVpt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU8fNIOkDFpRzeeXWBZ2UTMXQVDbtGUke449lshQxD8=;
 b=hLmEfxnJuXqVh8Ta44Q7+3PxTmpmvDagPG2mJmzjqkiJVXhaq/qZJg5/2WoWt9GjcFWH2a+ZhDLi5QQX3HpjVdPcTalN7zlsR4aTIzjWvSm3hXt/0LTWyP0eJnoXBSqvjDknBYppc22F4aghFWSIpqpGcBb8dCfGBZ/j0RlFCOTWV/Aq5ti+GLXYcSqQiJovMN3WgBZ1WOhuWNLD6XAAiwjMBTrejO2qVu5NmGhEgY9e2AHdy+PLlO4xuGg14c3VZyzikhGY+nWtiiQK9V0B6miOISxhQce+9R0H1Dxwz51nzZ6zjDi5yGjXcrgEuHYIBKkyQuFLvY9bbdU97YZpPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:51:29 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:51:29 +0000
Message-ID: <ae132d54-6fb1-40fb-b172-d5683a872ae9@nvidia.com>
Date: Tue, 3 Feb 2026 15:51:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] udp: gso: Use single MSS length in UDP
 header for GSO_PARTIAL
To: Alice Mikityanska <alice@fastmail.im>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Igor Russkikh <irusskikh@marvell.com>, Boris Pismenny
 <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 linux-rdma@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
References: <20260125121649.778086-1-gal@nvidia.com>
 <20260125121649.778086-2-gal@nvidia.com>
 <willemdebruijn.kernel.218d53621fba7@gmail.com>
 <fb617b34-7760-4e3f-903f-c7380d28ed40@app.fastmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <fb617b34-7760-4e3f-903f-c7380d28ed40@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ded1648-4843-4415-b5fe-08de632b54c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjVRZ1Vpd3hiUDlFQ3dFa041ajgxSmlyNUlqVXBSRnlkVjJlem0wVW1TREFW?=
 =?utf-8?B?b1NvTVdtYkQ5dEF3ZXV0MjQ2a3NUY05oWXV4ZDA4ZWxHR3JLeElUOURlOGdF?=
 =?utf-8?B?RGRHMlBPWm1vUUFRNU9uajIweFFyVzdLOVNwdXl1OHRXcDdaUHdFbGsvTEpW?=
 =?utf-8?B?bExPeFZoYmdIOWxRNkVpRjBIQ3JTSnJRT0tyUElQRFNLYk5IVzFMYTNPNXhE?=
 =?utf-8?B?cEZJR0ZMbTFsYjVzMkJoM1ZDRSttenJYRW1FZ29QQTRJVWRRRGovK0ZYd3FE?=
 =?utf-8?B?YU5IK0dYMEloOGErb2MvREdFTTlFcks5clJaZC96Ty9LWSs2a2pyZXkzdHBY?=
 =?utf-8?B?ajkzU2N1VjlKNmkwcDFrMFVQL0cyRHhWanhPa0hlVUdsTDVwT1NEU1VXbHhP?=
 =?utf-8?B?U0hhV0MwaFVZaUxuT3NZak81Wkh6NXdRUHRiWnRyUCtkcVVDYmY0V0pIWHVY?=
 =?utf-8?B?bjZibGYweXJxbmZHMGdtQmFWU3ZJMUtUMVpkRGtkMlJ5UUtONnFENHhBekFU?=
 =?utf-8?B?ZURuS3hKMmw5cTBreVZta0NyeHpmOWhFeTZnbnhaYkgyZC9vZVFyc3dyWm5o?=
 =?utf-8?B?b0FDa1Y0V3UzWE04SENLcXJlYWh3TWpUN0ljY28vMm8veDlpSEJ4SzloL1pI?=
 =?utf-8?B?MU5ESnIyYi9aWVo1WlR0dEh5eGZMaE9jaTcycENMckYzVTQ4MTJhMUJybm9q?=
 =?utf-8?B?dGRlS0FUS2hRcmpkR0ovUmpsQlVCNTJSMHRTalpqUU9JT1JCNGdqMmVjdHRu?=
 =?utf-8?B?MFVyeGdXNkxtcW5lVXJFbEdWeFFtWkpTRlR5Y3NjbE1mV2txQzYxR2ZqQkds?=
 =?utf-8?B?WGJabjd5T28wRDI2aUYyemNzNlI3bzU5czRFR3NXaUtWR3AwMVEvMXNDbWxq?=
 =?utf-8?B?S21GUnROQVZleG4wTDhLM1IzUXRHL3NOVEdXRmZCTnhBMmsyMGk5RWhWNFJ6?=
 =?utf-8?B?dmYzbmd3VEo3Wkh5a2s2aENCUXByVWc0OFY5Nm04cHZvZTBVenRWSGpTNy92?=
 =?utf-8?B?UUtielhVSlhWNFp6UXdmdGU3b2pvNGR5OUwrTktmelNmbFl6SXAvOEo3QVh3?=
 =?utf-8?B?YzUzVGhacXpSc213TGhyTEx6L1hWVXhIZno5dEx6MzhhTUY2Y0RFWG9Ub2JV?=
 =?utf-8?B?aTFScUpxbk9pOXhCclVzTmd2TWh0bVZKeDJVelhUK1RJMzIvbTBRYnBCSVBZ?=
 =?utf-8?B?TGYrdGY4cW5TWmdLTStSUUNtUjZhZkVyVythZ1BDNjkrZWxVeW1zWFlTUDRC?=
 =?utf-8?B?RGF4enZ3SWNITHJVdG9JcEx4UjcwWFYrWS8wRDNnK0xoU0lYSHdDeFpWcHp3?=
 =?utf-8?B?NHIwc1RsSzZWSkxUSnZpTFpvUTltVjhDdEdQUWR1Nkxvd0xxY0xLYWtubUlo?=
 =?utf-8?B?MFZEK21BYTZCUlhwd3phMXJhTVJYbyt5SGpVZlFvZ3U0Tm5taWY2OHNjaE1W?=
 =?utf-8?B?U2VFYTBRYXU3YzJiMElPRlBQekNDQmFaQ2hob1J1TnNNL211R0lMNDM5ckdO?=
 =?utf-8?B?bDZiZE1OWVpRTDJMNlkwVTNaYVpBb3E0Q1Z2dVdxMWV3R1hQTm1uUC9hdFE3?=
 =?utf-8?B?d0NsUU8rTkFlclZJSUZFMHZiNkpzRlV2K2tHVFNWRHdXQ20yS25ROTluWTRw?=
 =?utf-8?B?MzFhREwxb3FGNEtJR1lyQXJ1Wm53ZnV3SlZCTjhPRkYyVVg5NHhjYk9KMGJ1?=
 =?utf-8?B?Wkx2dHN5dllpTUw4WTlLa2FmZncxWFB5UE1xbTFoU00wRWR3eVZVcDBNZzdr?=
 =?utf-8?B?Ykg5NThEOHFSaE1MN0dSQnIvZktvc3Zhc2Y4K2ZDL3hNSzNwR0pEd2oxcEEx?=
 =?utf-8?B?NWVuVTdFdWxvZlJGTDdEdU5QR0FGdHdaeCs1UFpIZUg0SCtIa2dvK2NsUHdo?=
 =?utf-8?B?RGh4S0p4WmdTcmlQb0hTVVFmMkxzNDQ5TnR4cjdyeXI2Q0g0c1RqRlQ1TkFl?=
 =?utf-8?B?cWtaaWt1eXdGMXUrd3ZlQ3lWSGNhWDlKcVViU1UzRkFac3FVQ0ZVZjgxb05w?=
 =?utf-8?B?MFc1MlVqOGFYdjA5M2I5OGNaYU81YWppWnZNU3EvWWx3VUlzWjdUUDg4aHZT?=
 =?utf-8?B?ZWJUS3BXOHZaUTNCQ2U0eVRpWlVuQjZBc2pyS1cwbFFVTHAwUndOOVBLYy9Y?=
 =?utf-8?Q?dghI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9xYkd1SWU4Kzd2R05xN1kydHRPL2JPZGNvQlRRQ25lbGtYMEpJbUorWXZw?=
 =?utf-8?B?QjdCWllvL1lDL2NzaDllYmZoUDJPWVJ3aThDYVl2d3hzSFFSdktQcWFTeHQy?=
 =?utf-8?B?d0NOMm1LRzZSTzhuSnNhd0xIa0FZMTh0aXhSOFpDdTMyVld3cm53QytlTEpp?=
 =?utf-8?B?WHdiMHZTR1B5alZncXNTcHd1Tkl1NEtMbEg1ZGw3UFhla3BXWmVrNTVhcngy?=
 =?utf-8?B?Um5hNDBUaDh0d2ZLc0RTQzNWWjBFK0ovRElGMkdhVFpyWWlJdnJ3SHJNZTlm?=
 =?utf-8?B?WUlBTmpxdWZMOThIZXJJaGF5b3hZODJWcHk5ZWhLcEVZNk9ZaFlveXZTY0o5?=
 =?utf-8?B?cUxyYU12bENjTFg4eVR2R3ZQVXNQUzljcStJekh4cWFPS3F1aHhzcGVpQkZz?=
 =?utf-8?B?RDVGY0tHRFpMSWlUTmROaFIwWGtocjZBcWZLUmU3QjMzYWEzMWhmS1cvVHk3?=
 =?utf-8?B?OEZXWVFFc0E4Z21WWG4wdjZ6Qmhvak1SYUZWd0tQK0hDN2g4MHROUllkQmhS?=
 =?utf-8?B?QUZpZnVlTkFSWWo4eTk0M2xFZ2Q3RXA2RU1pTjNSdk82aDNhcVFvazVjNWFx?=
 =?utf-8?B?Y1JhOEJsUW1kdDhqNGI4WmNlTmdxbTBmajlXazNQT2ExcXJndkErSzQzM3FG?=
 =?utf-8?B?cC9Fb1B1bDl3VUJLUjNtdGVBZmRWaTNxeEdqK2s3NHpBY2lKWkswUFVqSzFz?=
 =?utf-8?B?LzFTVVJtOGNEejVGMjYvNS9RdDU3Qnd6blNWUWpIOGRiVG9NcFNmZzdkMEpX?=
 =?utf-8?B?UXRRNGMwYUlZcTFwanZBSnBVaTJQa2pNZXJCb29wV2duVVpXNlFBSnJJZDJr?=
 =?utf-8?B?TUdYUncxWnJSa1hOMmFhRWlkZUgvYVpOMm5MN0JZMlpuWERkTElEaFdoR2dq?=
 =?utf-8?B?L1QyN0ZPVlpFazFPQS93UlZRM0JudUlHVUxHd0I4RytUSVBMSDRKOXN6QW5x?=
 =?utf-8?B?WlUvQmhVd09vaVk3WFpkRXpOblF1Qmlkc00rdzZkRWM5MVQ3K3ZGSUozUUVC?=
 =?utf-8?B?alhBQitWR2JUTzMvM3daSmd2YzM1UGlnOHZRME42UjZOYUxUaWlzcmF4N2tq?=
 =?utf-8?B?cVNiVGpBSzJSRHZwRERzdWF2NE9sNmFDY1E0QmhhZGZzSVZ1N256T2pyQUZC?=
 =?utf-8?B?Q1gxbDBVa01TWnE3b215QXJGazBVN0MydjdrR1BJanJTblpZSkFjQ3I4ZUhs?=
 =?utf-8?B?WHUyZG5IR3VDaGVWYTRmaG44WlZXTWFsbm94UmNzeVUvdno3NUI0QWc0cTZy?=
 =?utf-8?B?S3lPYnByZGMzL0NlWk90TmluS1dqTlZTaDQzTDZMeFlONmxkVCt3NlBZRWFi?=
 =?utf-8?B?NGdkb3QyOW9lSkVKKzJOa1NYRkc0OXI2UEtXMW5sNjJ5bW52TjdTaXM2ek8v?=
 =?utf-8?B?NkNjMzZMY1lua2VSbk1ublFjdjVqWW00dXRLR2VhMGhJcWpBMW9pa2NxdTI1?=
 =?utf-8?B?OS9LY05ERm10anU3eVcyS2taK2hGL1ZlTEVkSzN4Y0hESytEdmZrU1BHbUtp?=
 =?utf-8?B?TDVvT2xjNjdUSktlM01DOXR1MEF6UWQ2THBBQ0dOZGR0L2czZEJlcjIva0Vo?=
 =?utf-8?B?VnZMUlJ2cTNtUUxIWjBwSXBJMFRzVzhEeWhzT0hWczd0VEl0cksxakloY09X?=
 =?utf-8?B?cTJLWVlrRDBaK3pIcllCY1NqVGJTOS8xVDEyUnNkWFF1aml4b09Ua2FuL3Nl?=
 =?utf-8?B?QjhLUU1WRkxhcnlTOFNkQlM1L1BJS1VVa0MzMkFBMEF3K3Q4UVhkVE4vaWh5?=
 =?utf-8?B?UGV0QkJ0R2Y3czJsSlpNSmptcTNWYXJ1VWNmQlJTSWpQQ1BoTlIyb0VESExp?=
 =?utf-8?B?QlZxSjk2a3NsTXdYNCs4cC9HQWRHTU1IZnpFODlMcHlDaC9salZWb2ozQ0N0?=
 =?utf-8?B?UkJHOE9Rd2NGL0ptNmMvYkN5bnFnUTRMbnR6WDdzUzhoWDlSUDl2YlBnT1NQ?=
 =?utf-8?B?cW1HMlF4N0tOa0VoUXJ2R2pCNnhnSHR4c3F2K3RDNVg4TEFSWFNncjFsQ3R2?=
 =?utf-8?B?QVhNTGlaSHUxb1Y3bTYyT3ZSdy9COWFNQ01CTU9KdVBIVmZ5Q2NIQ2owdlJl?=
 =?utf-8?B?bS9ENm04c3lnMUlYaHBCczNwREJLT0RQdjZTcy9kb0I0V2pTN2hIQkt1QjFY?=
 =?utf-8?B?RmxPQzBsWnlVcFl6dnd3ZzJWdGtTTXFua3Q0eVVZcE9ibndXSUxKZXRCSU9k?=
 =?utf-8?B?Y1c0QVJKdDlheCs4cFZLaWdyTHA0UE1hcmlQSVErSE1mTVJtYklDRUpsbU5U?=
 =?utf-8?B?NWhLdm9CR0E5ZGUvb3dJYW04UlB4bWorZi9EN3QrMW52WVF0TGRpL3JRaUFJ?=
 =?utf-8?Q?E0u5qIOnAf8gVU3bem?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ded1648-4843-4415-b5fe-08de632b54c7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:51:29.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl6JOfQ4tau/fK0OGIdVTmwzCt+1xGl2DMofWVHSWlzhFZnrrh23tf6v+1ubMATB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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
	TAGGED_FROM(0.00)[bounces-16457-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 29120DA323
X-Rspamd-Action: no action

Hello Alice,

On 03/02/2026 14:20, Alice Mikityanska wrote:
>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>> index 19d0b5b09ffa..89e0b48b60ae 100644
>>> --- a/net/ipv4/udp_offload.c
>>> +++ b/net/ipv4/udp_offload.c
>>> @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>  	struct sock *sk = gso_skb->sk;
>>>  	unsigned int sum_truesize = 0;
>>>  	struct sk_buff *segs, *seg;
>>> +	__be16 newlen, msslen;
>>>  	struct udphdr *uh;
>>>  	unsigned int mss;
>>>  	bool copy_dtor;
>>>  	__sum16 check;
>>> -	__be16 newlen;
>>>  	int ret = 0;
>>>  
>>>  	mss = skb_shinfo(gso_skb)->gso_size;
>>> @@ -555,6 +555,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>  		return segs;
>>>  	}
>>>  
>>> +	msslen = htons(sizeof(*uh) + mss);
>>> +
>>>  	/* GSO partial and frag_list segmentation only requires splitting
>>>  	 * the frame into an MSS multiple and possibly a remainder, both
>>>  	 * cases return a GSO skb. So update the mss now.
> 
> What about the frag_list case? The comment says it would be a GSO SKB
> too (as I understand frag_list, it would be a linked list of SKBs
> forming one single packet). Is it appropriate to set UDP len = MSS in
> this case too? I'm not sure which code reads UDP len afterwards, I
> couldn't find any, so maybe its value doesn't matter at all (except for
> hardware, which this patch aims for).

The behavior should be the same, the structure of the skbs the packet
originated from shouldn't affect this change.

> 
> Is it possible that this GSO_PARTIAL or frag_list packet shows up in
> tcpdump with UDP len set like this? E.g., if the GSO_PARTIAL
> segmentation happens before entering a veth pipe, and tcpdump listens on
> the other end? If so, tcpdump could fail to parse such a packet.

You will see a large packet with a single MSS value in tcpdump, and
that's consistent with the behavior we have for UDP tunnels.
tcpdump parses the packet without any issues.

> 
> I haven't tried to reproduce any of these yet; I decided to ask first
> because you have more context. I'll appreciate if you can give me a clue
> whether my concerns are valid or not.
> 
> Other than that, I think the patch could be made simpler, if you just
> drop mss *= gso_segs below, and stick to newlen, which would be equal to
> msslen (now unneeded), and newlen and mss are not used anywhere else.
> I'll include this simplification in my next series, if you don't mind.

Feel free :).

