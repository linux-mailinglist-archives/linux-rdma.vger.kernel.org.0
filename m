Return-Path: <linux-rdma+bounces-5821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21029BFCAA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 03:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA668B21FAA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 02:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482AA7DA9C;
	Thu,  7 Nov 2024 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oS4IkjSs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43291EACE;
	Thu,  7 Nov 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947445; cv=fail; b=tfdtuzoE0eNsw5u8NvjlJQ3/LmY/99cDZpBxqXRBBjwD6ggZhWZoedZbULuACW3t2/Rx6+feo74AXRzm2VVMR0D6//k/EVuCzYU/RdeQvtU0gLXLKJBR5khdX+/UdpcmX9rEtGabvl0lbBVIpT0vCdQN0jk3RC50Qb7IzcpSIs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947445; c=relaxed/simple;
	bh=++DW9PIEI8Wd2d8BCode1F0Vk8iLT+XxnpcvxTqNXfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h27Pu0mZRHY9la3Ei6ecrc7Dcpy+1aCDiEVy/gJ+NPAhNsY9dUjPwimv+ujDXzzXKqsk7Wll0w9nM+7QHkFpyHEMA1VdsUC2YCH5dJr6TFsEAJZLfwdmmUA7UGxVhLOHjWz6mOsJtuAWVijBdQnNktqcvuK5UL0peHFazD8rgQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oS4IkjSs; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyBuEQathYy0887fCu3zYwgJR+X4Wp9Ldv0RbgRk1etmevHN6zmhEdsrBrQwwJAsAlNnRok9wVCjgnbXoSAZwhwdIj/+DSomerXkrgW+N+1ldBbFbxUEwgfTS0drd6b2kqxOHUV1MVD6We6DMIGr6/LRTtaAhCXWd/vpQtU0FNTyv9/9/3vlO2+LuI0rYfqE4VA7MHHJWIlA7jB7cd9cacwrAm9Hzh9Kav1YDROva6XXCdqCXXPbb75dO+dhYMOFWC8U02SVz71sYQwyPNXkoxdNYxU0/7C8av/yB8ouNYIo5ziVGbjVNDqdH0m0IG2JnECqQVeWQf6wj5plmdqeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++DW9PIEI8Wd2d8BCode1F0Vk8iLT+XxnpcvxTqNXfI=;
 b=c7ygTfWjReLZ+em1oDdWIeYABtL5ycSIaF3ceNDl5JD0ap1au2d7J1H2B/B78JnJNs/HaNlJ1Bjgux9LEXWnNepM8SPQjaaOwbQl9CYmAkjmc9XbReycAFsc4Tp5pSaaxQGqo59zO8KOxcoPvxUzqSzyhzjFZV9Yu6FfFuhlnaD+H0gBrEN81SPXZKax1RS4ZSAk+uKJZqcQ8gjkpoTp2m0zEbEQnYrj99KuV2QfFW/kZ6s5LePrYRLC1M52XCePXO4optIgbNvMu1eOcHZBzsJhKcbFx2zK1HtJH2RzBllMTpNd90L57hPiysYb/6tUB5aIvTWUdEDI78IjFB8Ivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++DW9PIEI8Wd2d8BCode1F0Vk8iLT+XxnpcvxTqNXfI=;
 b=oS4IkjSsmTw2FYRtz3IzC80woT/FPBWcot2jKCQXcGyJ28yG+Mc/LzIKxhH6Xkn18GQP/dEc7WHfTP/LBcuQyqoPRxEd9bTrYxdgMwO7GenDbCwVA0Tgs4bPGc5F2Q1tVIFgp8opSvkt5jXlU7K/rIfpDpL8PJuUN3B/rQULlwQvc96tbqf59NiHLcpNW+0D7CI5gSiNxm0aM4e44NCwooUoMzD2VqK23JZLCnIcJWA7rIq9mw+M4tCa5U/h9GJEhFTvuBI7m5Q4+A3mKaJ8gPVS2QhZ+sqGVqXjlfyNZ1JbGV6KIbS+GJYiSlbtTU/Num7eS5Xec5HbJXXWxL5yBA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 02:43:59 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 02:43:59 +0000
From: Parav Pandit <parav@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Caleb Sander <csander@purestorage.com>
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
Thread-Index:
 AQHbLBDvBoxTaznD+0G3MAKMk1HOTrKk6zPQgAE5WoCAAgfKUIAAtNuAgADi7uCAAS9EAIAAMBMAgAAB75A=
Date: Thu, 7 Nov 2024 02:43:59 +0000
Message-ID:
 <CY8PR12MB7195776AEE255FB4A156ED68DC5C2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com>
 <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
 <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZon6QbURp7TqB6dvE4Ewb_To2EDyUTQ=spNCorXDy0DbQ@mail.gmail.com>
 <ZywnmDQIxzgV3uJe@x130>
In-Reply-To: <ZywnmDQIxzgV3uJe@x130>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|BL1PR12MB5802:EE_
x-ms-office365-filtering-correlation-id: 3118090a-8dae-49a0-6331-08dcfed60867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXlXZ2V0T3ZxUEhOTk15YUlQUHV2dHBOdjZPTXJ1VldVblB5SElGMWhVaStF?=
 =?utf-8?B?UDJYaGR5L2doTVFFK0xZektkMmJFc2NhR25PR3NQSlZweno1dzJVaW56a3N4?=
 =?utf-8?B?ejlZeTI5bkJiNW1GRHpVUkEzTzFDQU41cGM4VEw4V0Vid2IyZXNaR2hBanZv?=
 =?utf-8?B?b1oxTG1NUnR5SlU4NFE0bWhYZnlWY0tQUWZST0dzV2dSMDYyU3hTZUt2NC9i?=
 =?utf-8?B?VVhUQjdKeU1aMDFqdzc2YlJNYlpqUHhvN3NWNGJFa3RVZ0RjVmJlYjlNWHBV?=
 =?utf-8?B?WkltZ0s2RUtTUm1KcmJUbWluVzFwdERCL3FOeG5FVkFlWFIwZkJKRDRJUUtE?=
 =?utf-8?B?a2ZPUEFERDlucmo2WFRkeHY1elJIMnB5S3N6QldMcFFoc2lWUG1oMEg0QUlz?=
 =?utf-8?B?cFM4cUZiSHkva3NaS0U0WEtBTDJyZ2tuZ2szcnFVWWlkMERHRHFVRGJFYXZo?=
 =?utf-8?B?a3VKclg4ajV1M09zSHg1eUViSHJiK0NTTmVxeVNlVFRHVFBVc2NaU1lsNEc1?=
 =?utf-8?B?NkhvUXgvc3JpSUpEZEtWZ2p3ZmZ6Y3dwRnMraWlsVDhLV0lXdUlKM01kL1ZK?=
 =?utf-8?B?aUx1S1BHckhtcm9lRWViTHlJQTdpMEtqaHJZN1p4WnV5cXJoMC9oellYd0cw?=
 =?utf-8?B?ajAwNTRiR0NiQlhTR0Fwc0FSWTJRNXoydy9GcFoxWERQUG02QUpsL2lLandi?=
 =?utf-8?B?UWc0QklITFNsM0JSRmVIMzQwSUdXRGRybzJ0anBnRFZBWEk1ck84M0JseFVK?=
 =?utf-8?B?L1pCQlEvWUs3UWhKb1hJbm1pK2JxR2pxYTRiQXVFMFYzYWlpVjhjNlhXZlNJ?=
 =?utf-8?B?TXdlVk9ITnc3M3Vadk8valh0Unl6eXUwakxXQ3VIeVVZdDNVMU1aYUttQkd4?=
 =?utf-8?B?M2dPQ3pjaEpMWnQ5cWtqZjhIRVgzNUhDSW1FNVl6akVIVEFCdEViaC9XL2cr?=
 =?utf-8?B?TVR0K0cwSDJpTmg3aVdUQk42Tm54M0gzVm9SbDV3T1Zrc3BrMHlGM3J5QktX?=
 =?utf-8?B?VmNKT2MxTFQweGRFdmRCei9JQStIODUxVWN6MlcxcnRsQ2M2enphcVlGK0hB?=
 =?utf-8?B?TncwdTdJMlF0YlE0SEIvRHRoR1VKbjIrNFNEVXZJajdzbXFqUlk5Ny9XV1B1?=
 =?utf-8?B?OWFVV0VZZDNodzdQREJWeWF5bXIvclh6Y002UGNOaHQxNWw0MTI4c2RpTmY0?=
 =?utf-8?B?bzdGeThwUU5YSnR2ajc0enYvelV6d3VjdWZQY0x5cHR6NTJBT0IrV2ZIVjFY?=
 =?utf-8?B?alhJOGpyaEV3bmtoNmV1eDZMd1pRTHJJKzJnMm9vMTRSSlBPTzV0SUZHZW1a?=
 =?utf-8?B?RXp2TnExWmVQY05ESUp3UndmTE9rL0ZhNEVWUkQ0V3ozY0pPUmc3TXlGUUJI?=
 =?utf-8?B?dk96c0krclJVVTR4VWZuZUtVVWpUTG9zdUdhYXhYbVJkdmI1TGJlVU5sVitn?=
 =?utf-8?B?ZkRrMUFSY21PaUNtRnlDUFIrb2NiMWZLdVJTN3NCU1hpbG9OS1VVbEhzZXM2?=
 =?utf-8?B?THhRSVo3OExsZzNIbFZBOWpQTHBNM09tMzdsMmJPYzhCYzJZTnZ5YmlybWxR?=
 =?utf-8?B?d3I1N29qcDRGSnZkV1VPOUJUV1VmQk5NTkVFcWtnUlRWSitsNXJRbmtTUlAz?=
 =?utf-8?B?QUZmT0J0S0o5NVhhMm5sSkZUcGZnUGFWYVhhMVdnUEljY002dlRYTlg5bVI5?=
 =?utf-8?B?Z3VML2NYUmlsUWFlWFVPSUhlSThDcFphakk3a0hKVjJzUlBFYU94b0puOVNu?=
 =?utf-8?B?em81RmRiQWtYdXIzbGU0bTZRRWZhUFkzbGY1K2lTYTdmSVhPOVFpL3pkU2ZW?=
 =?utf-8?B?WEhEQ1REK1EvK05reUJvMXVpVnpNR0dwZlQ1ZWx4L3VNY2I2cm9xRGYwdHNO?=
 =?utf-8?Q?TIHffwWpGlu73?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzEwVXFDbHlxLzBKMEpWbXlYeUtpaHlLSXJrR2Y5WlQzNE9aTVk2U2kyeXQw?=
 =?utf-8?B?a0tHY1FMdkZTaVd6eWROSmhCai9pc1ZoaDdualUwMXE3K2RKRTBCcWhwdDBo?=
 =?utf-8?B?NWEveE1UZFAyTVFTUGVITFBta255Q3ROdkdCWUNDWGlQV0ZmeWxJbXpibEhy?=
 =?utf-8?B?NVFlVFArZjhiNXZzNWtodVROM3dyeFBIVGpqWHV2VDJRY3VzQWd4dy9HMllv?=
 =?utf-8?B?WllwRm50dHcwMjVaMlYyMmM4dkhaMGc3V2ozWk10enVsRDdmYXlvNFFxME1m?=
 =?utf-8?B?cWZrNzJ0OFl6b3hGUXVrYUZvdDNJMkM3T2RtS0R6YnRRTHZHdmd6eUQ0OENk?=
 =?utf-8?B?MWtVU3pSenRiNEJxQTFqNmRmakZpNVhMMVRGN2IrUGhSSU1RQmNUTTlldWZF?=
 =?utf-8?B?TjQxUG1qUmp2elJaK3N2UnkrMXNsNVlFeU1TNGJ0NU43V0lTTHhqMitrYVNu?=
 =?utf-8?B?Mm1EdDY1ZnNTTEMyb2RXL2ZPZ0hNbjFXUGZYaEp5b3NQRnd5WTdTNXdBR3VR?=
 =?utf-8?B?MXBmNjJIU1NWNTNvOUs4N1JjcEdXVnRVd2pmZTFpTDBZRHRxT25OU0wzSXN0?=
 =?utf-8?B?a1pNcUYzTk9qNDE2T1RuQkhoTlpHMDhydE5tM1dPcm9LVjJ5QVlzNU1sWTdF?=
 =?utf-8?B?Zk5LVlRKajh6a0JESnVxem0wS3ZCVWFLeFBwMzlmM2pZMlRBM2dRZ3FHRHA4?=
 =?utf-8?B?ZzNzdnEyTVFEYmVkTSs0MzJJNWpuTTdBcERvWURLdnF4bGYwTkVMR2pGaGVS?=
 =?utf-8?B?aVgwMmdxVGpHSlpBTk5XQXRYdlZqYmwzY1paTnBGYXZ1cWd1bUt1RlE4ZnBG?=
 =?utf-8?B?TFlTVGMxSzNCd0J6WE9IU1F0aVlrMkpIZFRRKzdHbFN6UzBGcVNDVWlSNU5D?=
 =?utf-8?B?OUtPTEpvcExkckNLcWI5T3J1dzM2QldnQXBKUVFRS2IzeU1XOE9lSnJLQm5h?=
 =?utf-8?B?ZWpkdTBOWmd1Q2d0VFdTbG42TDdSRVFrbWx0NXdET2hOSDErakJUUHMwMFpt?=
 =?utf-8?B?Y0RWRlcwMXV5WXQyYmU5czgrbU5mU3kzcDF5cW1pc0dVSEs0UUYvSEdrUUoy?=
 =?utf-8?B?bmtnK1hRNHkxak01ak9lUFJGNzh6dms4cCtwR29RSWZyc0pSb2JCaFEwYWRo?=
 =?utf-8?B?YTk1d0ZtR3hIR0xPMFBLUUZzbG1CTWYxVVpjckxEQlQ2VkRXNi92NGg1aE81?=
 =?utf-8?B?dlFzVU1PVTVHcEdnVnpyY2JYT0pUZGZVUktMUVgvTGw3ajZsaDY0UktNZ0U0?=
 =?utf-8?B?cGlIaTJVa21ubjd2YVVUTVdZUjQvSGhKaVcraW1PWFZ3bkozeXYyLzA2V25U?=
 =?utf-8?B?Ti9uZGZ5cHJRUW5LNTdWKzQzNUlkYlhEQnJrK1ljRTgyWXRoVTNMa21SWFQ2?=
 =?utf-8?B?YWZSZVBTK2E5OWIvL2FyU21MbXZDVnQ1c3c2ejBYZlRBcE4rQXFCSXgzOC8v?=
 =?utf-8?B?K0RuTEhEVldmYXhHNmNCaFRPellldTlWbmdJT3lMTmhZN0lOVXBEaGJKa0lt?=
 =?utf-8?B?empvRDRJbXFpS2F1M0NMa1d1WXc3Q1ZEaHl3aEViWi8xQkNBaERKbW85SU1U?=
 =?utf-8?B?RUNRSWpaOVlQV1JGVWFWWVlZMDM3RUVlZ0FlQktUTGNWb3RCN1V5NFJIUjd6?=
 =?utf-8?B?TXV5VEV3Q1cwdHhKYTZ2QXBqQ08rbUxhRWgwQlBkME1JSVhHRmp3dm9aTm5B?=
 =?utf-8?B?bE9pay95Si9zZFpqN2RpeFArL2NGV21uVEN5VHJSdnV5U2VodFRPTzNMaDZ6?=
 =?utf-8?B?UGpGR2JsZXQ1ZFBTSzNtdmkyeUo5R3UrNlBrMjk4WW95Nm9taXU3TDUyZGxx?=
 =?utf-8?B?TDZEQVNJMGpjOEJoMlhnRklHdzRZM0xRU1R5TzJmOWd3clA1T0tDRFd4R1JL?=
 =?utf-8?B?VkhiVDR0MGdZWkRtL2tnVGtubU54ZFQzREhBRld4c3hXU1lJQUU5OGRvbmR6?=
 =?utf-8?B?cVFKZ3pyRWQ5ZUM4TkY5eDhTNHRTOWZQMG4wR2NQS3hadFJFamdaVTZHaXQr?=
 =?utf-8?B?QkFKMjZPTURjUFdEM3JVMmdRT2RhaGgxT0l6YWRwbkNRd0x6ZDE5QzR4SGk5?=
 =?utf-8?B?Q1RuYTBnMHNCdzI3NEd5SGVKZm82TCtyS1RwK1Mva2Jod0ZCZDdZZm9IKzk1?=
 =?utf-8?Q?GySI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3118090a-8dae-49a0-6331-08dcfed60867
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 02:43:59.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZekVRaGtntFka5E1vSgx90j5ZJ/pNa5g8x2tntCwAELjZCc1zuU+K+YAfyS3GhiLmHhXbQdKCIwjJoaYvh2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

DQoNCj4gRnJvbTogU2FlZWQgTWFoYW1lZWQgPHNhZWVkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBOb3ZlbWJlciA3LCAyMDI0IDg6MDYgQU0NCj4gDQo+IE9uIDA2IE5vdiAxNTo0NCwg
Q2FsZWIgU2FuZGVyIHdyb3RlOg0KPiA+T24gVHVlLCBOb3YgNSwgMjAyNCBhdCA5OjQ04oCvUE0g
UGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4NCj4gPj4g
PiBGcm9tOiBDYWxlYiBTYW5kZXIgPGNzYW5kZXJAcHVyZXN0b3JhZ2UuY29tPg0KPiA+PiA+IFNl
bnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgOTozNiBQTQ0KPiA+PiA+DQo+ID4+ID4gT24g
TW9uLCBOb3YgNCwgMjAyNCBhdCA5OjIy4oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEu
Y29tPg0KPiB3cm90ZToNCj4gPj4gPiA+DQo+ID4+ID4gPg0KPiA+PiA+ID4NCj4gPj4gPiA+ID4g
RnJvbTogQ2FsZWIgU2FuZGVyIDxjc2FuZGVyQHB1cmVzdG9yYWdlLmNvbT4NCj4gPj4gPiA+ID4g
U2VudDogTW9uZGF5LCBOb3ZlbWJlciA0LCAyMDI0IDM6NDkgQU0NCj4gPj4gPiA+ID4NCj4gPj4g
PiA+ID4gT24gU2F0LCBOb3YgMiwgMjAyNCBhdCA4OjU14oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJh
dkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPj4gPiA+ID4gPg0KPiA+PiA+ID4gPiA+DQo+ID4+
ID4gPiA+ID4NCj4gPj4gPiA+ID4gPiA+IEZyb206IENhbGViIFNhbmRlciBNYXRlb3MgPGNzYW5k
ZXJAcHVyZXN0b3JhZ2UuY29tPg0KPiA+PiA+ID4gPiA+ID4gU2VudDogRnJpZGF5LCBOb3ZlbWJl
ciAxLCAyMDI0IDk6MTcgQU0NCj4gPj4gPiA+ID4gPiA+DQo+ID4+ID4gPiA+ID4gPiBUaGUgbG9n
aWMgb2YgZXFfdXBkYXRlX2NpKCkgaXMgZHVwbGljYXRlZCBpbiBtbHg1X2VxX3VwZGF0ZV9jaSgp
Lg0KPiA+PiA+ID4gPiA+ID4gVGhlIG9ubHkgYWRkaXRpb25hbCB3b3JrIGRvbmUgYnkgbWx4NV9l
cV91cGRhdGVfY2koKSBpcyB0bw0KPiA+PiA+ID4gPiA+ID4gaW5jcmVtZW50DQo+ID4+ID4gPiA+
ID4gPiBlcS0+Y29uc19pbmRleC4gQ2FsbCBlcV91cGRhdGVfY2koKSBmcm9tDQo+ID4+ID4gPiA+
ID4gPiBlcS0+bWx4NV9lcV91cGRhdGVfY2koKSB0byBhdm9pZA0KPiA+PiA+ID4gPiA+ID4gdGhl
IGR1cGxpY2F0aW9uLg0KPiA+PiA+ID4gPiA+ID4NCj4gPj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IENhbGViIFNhbmRlciBNYXRlb3MNCj4gPj4gPiA+ID4gPiA+IDxjc2FuZGVyQHB1cmVzdG9y
YWdlLmNvbT4NCj4gPj4gPiA+ID4gPiA+IC0tLQ0KPiA+PiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lcS5jIHwgOSArLS0tLS0tLS0NCj4gPj4gPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRpb25zKC0pDQo+
ID4+ID4gPiA+ID4gPg0KPiA+PiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lcS5jDQo+ID4+ID4gPiA+ID4gPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lcS5jDQo+ID4+ID4gPiA+ID4gPiBpbmRl
eCA4NTlkY2YwOWI3NzAuLjA3ODAyOWM4MTkzNSAxMDA2NDQNCj4gPj4gPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lcS5jDQo+ID4+ID4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXEuYw0K
PiA+PiA+ID4gPiA+ID4gQEAgLTgwMiwxOSArODAyLDEyIEBAIHN0cnVjdCBtbHg1X2VxZQ0KPiA+
PiA+ID4gPiA+ID4gKm1seDVfZXFfZ2V0X2VxZShzdHJ1Y3QgbWx4NV9lcSAqZXEsIHUzMiBjYykg
IH0NCj4gPj4gPiA+ID4gPiA+IEVYUE9SVF9TWU1CT0wobWx4NV9lcV9nZXRfZXFlKTsNCj4gPj4g
PiA+ID4gPiA+DQo+ID4+ID4gPiA+ID4gPiAgdm9pZCBtbHg1X2VxX3VwZGF0ZV9jaShzdHJ1Y3Qg
bWx4NV9lcSAqZXEsIHUzMiBjYywgYm9vbCBhcm0pICB7DQo+ID4+ID4gPiA+ID4gPiAtICAgICBf
X2JlMzIgX19pb21lbSAqYWRkciA9IGVxLT5kb29yYmVsbCArIChhcm0gPyAwIDogMik7DQo+ID4+
ID4gPiA+ID4gPiAtICAgICB1MzIgdmFsOw0KPiA+PiA+ID4gPiA+ID4gLQ0KPiA+PiA+ID4gPiA+
ID4gICAgICAgZXEtPmNvbnNfaW5kZXggKz0gY2M7DQo+ID4+ID4gPiA+ID4gPiAtICAgICB2YWwg
PSAoZXEtPmNvbnNfaW5kZXggJiAweGZmZmZmZikgfCAoZXEtPmVxbiA8PCAyNCk7DQo+ID4+ID4g
PiA+ID4gPiAtDQo+ID4+ID4gPiA+ID4gPiAtICAgICBfX3Jhd193cml0ZWwoKF9fZm9yY2UgdTMy
KWNwdV90b19iZTMyKHZhbCksIGFkZHIpOw0KPiA+PiA+ID4gPiA+ID4gLSAgICAgLyogV2Ugc3Rp
bGwgd2FudCBvcmRlcmluZywganVzdCBub3Qgc3dhYmJpbmcsIHNvIGFkZCBhIGJhcnJpZXINCj4g
Ki8NCj4gPj4gPiA+ID4gPiA+IC0gICAgIHdtYigpOw0KPiA+PiA+ID4gPiA+ID4gKyAgICAgZXFf
dXBkYXRlX2NpKGVxLCBhcm0pOw0KPiA+PiA+ID4gPiA+IExvbmcgYWdvIEkgaGFkIHNpbWlsYXIg
cmV3b3JrIHBhdGNoZXMgdG8gZ2V0IHJpZCBvZg0KPiA+PiA+ID4gPiA+IF9fcmF3X3dyaXRlbCgp
LCB3aGljaCBJIG5ldmVyIGdvdCBjaGFuY2UgdG8gcHVzaCwNCj4gPj4gPiA+ID4gPg0KPiA+PiA+
ID4gPiA+IEVxX3VwZGF0ZV9jaSgpIGlzIHVzaW5nIGZ1bGwgbWVtb3J5IGJhcnJpZXIuDQo+ID4+
ID4gPiA+ID4gV2hpbGUgbWx4NV9lcV91cGRhdGVfY2koKSBpcyB1c2luZyBvbmx5IHdyaXRlIG1l
bW9yeSBiYXJyaWVyLg0KPiA+PiA+ID4gPiA+DQo+ID4+ID4gPiA+ID4gU28gaXQgaXMgbm90IDEw
MCUgZGVkdXBsaWNhdGlvbiBieSB0aGlzIHBhdGNoLg0KPiA+PiA+ID4gPiA+IFBsZWFzZSBoYXZl
IGEgcHJlLXBhdGNoIGltcHJvdmluZyBlcV91cGRhdGVfY2koKSB0byB1c2Ugd21iKCkuDQo+ID4+
ID4gPiA+ID4gRm9sbG93ZWQgYnkgdGhpcyBwYXRjaC4NCj4gPj4gPiA+ID4NCj4gPj4gPiA+ID4g
UmlnaHQsIHBhdGNoIDEvMiBpbiB0aGlzIHNlcmllcyBpcyBjaGFuZ2luZyBlcV91cGRhdGVfY2ko
KSB0bw0KPiA+PiA+ID4gPiB1c2UNCj4gPj4gPiA+ID4gd3JpdGVsKCkgaW5zdGVhZCBvZiBfX3Jh
d193cml0ZWwoKSBhbmQgYXZvaWQgdGhlIG1lbW9yeSBiYXJyaWVyOg0KPiA+PiA+ID4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQxMTAxMDM0NjQ3LjUxNTkwLTEtDQo+ID4+ID4g
PiA+IGNzYW5kZXJAcHVyZXN0b3JhZ2UuY29tLw0KPiA+PiA+ID4gVGhpcyBwYXRjaCBoYXMgdHdv
IGJ1Z3MuDQo+ID4+ID4gPiAxLiB3cml0ZWwoKSB3cml0ZXMgdGhlIE1NSU8gc3BhY2UgaW4gTEUg
b3JkZXIuIEVRIHVwZGF0ZXMgYXJlIGluIEJFDQo+IG9yZGVyLg0KPiA+PiA+ID4gU28gdGhpcyB3
aWxsIGJyZWFrIG9uIHBwYzY0IEJFLg0KPiA+PiA+DQo+ID4+ID4gT2theSwgc28gdGhpcyBzaG91
bGQgYmUgd3JpdGVsKGNwdV90b19sZTMyKHZhbCksIGFkZHIpPw0KPiA+PiA+DQo+ID4+IFRoYXQg
d291bGQgYnJlYWsgdGhlIHg4NiBzaWRlIGJlY2F1c2UgZGV2aWNlIHNob3VsZCByZWNlaXZlIGlu
IEJFIGZvcm1hdA0KPiByZWdhcmRsZXNzIG9mIGNwdSBlbmRpYW5uZXNzLg0KPiA+PiBBYm92ZSBj
b2RlIHdpbGwgd3JpdGUgaW4gdGhlIExFIGZvcm1hdC4NCj4gPj4NCj4gPj4gU28gYW4gQVBJIGZv
b193cml0ZWwoKSBuZWVkIHdoaWNoIGRvZXMgYS4gd3JpdGUgbWVtb3J5IGJhcnJpZXIgYi4NCj4g
Pj4gd3JpdGUgdG8gTU1JTyBzcGFjZSBidXQgd2l0aG91dCBlbmRpbmVuZXNzIGNvbnZlcnNpb24u
DQo+ID4NCj4gPkdvdCBpdCwgdGhhbmtzLiB3cml0ZWwoYnN3YXBfMzIodmFsLCBhZGRyKSkgc2hv
dWxkIHdvcmssIHRoZW4/IEkNCj4gPnN1cHBvc2UgaXQgbWF5IGludHJvZHVjZSBhIHNlY29uZCBi
c3dhcCBvbiBCRSBhcmNoaXRlY3R1cmVzLCBidXQgdGhhdCdzDQo+ID5wcm9iYWJseSB3b3J0aCBp
dCB0byBhdm9pZCB0aGUgbWVtb3J5IGJhcnJpZXIuDQo+ID4NCj4gDQo+IFRoZSBleGlzdGluZyBt
YigpIG5lZWRzIHRvIGJlIGNoYW5nZWQgdG8gd21iKCksIHRoaXMgd2lsbCBwcm92aWRlIGEgbW9y
ZQ0KPiBlZmZpY2llbnQgZmVuY2Ugb24gbW9zdCBhcmNoaXRlY3R1cmVzLg0KPiANCj4gSSBkb24n
dCB1bmRlcnN0YW5kIHdoeSB5b3UgYXJlIHN0aWxsIGRpc2N1c3NpbmcgdGhlIHVzZSBvZiB3cml0
ZWwoKSwgeWVzIGl0IHdpbGwNCj4gd29yayBidXQgeW91IGFyZSBpbnRyb2R1Y2luZyB0d28gdW5j
b25kaXRpb25hbCBzd2FwcyBwZXIgZG9vcmJlbGwgd3JpdGUuDQo+IA0KPiBKdXN0IHJlcGxhY2Ug
dGhlIGV4aXN0aW5nIG1iIHdpdGggd21iKCkgaW4gZXFfdXBkYXRlX2NpKCkNCj4gDQo+IEFuZCBp
ZiB5b3UgaGF2ZSB0aW1lIHRvIHdyaXRlIG9uZSBleHRyYSBwYXRjaCwgcGxlYXNlIHJldXNlIGVx
X3VwZGF0ZV9jaSgpDQo+IGluc2lkZSBtbHg1X2VxX3VwZGF0ZV9jaSgpLg0KPiANCj4gbWx4NV9l
cV91cGRhdGVfY2koZXEsIGNjLCBhcm0pIHsNCj4gICAgICAgICBlcS0+Y29uc19pbmRleCArPSBj
YzsNCj4gICAgICAgICBlcV91cGRhdGVfY2koZXEsIGFybSk7DQo+IH0NCj4gDQo+IFNvIHdlIHdv
bid0IGhhdmUgdHdvIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbnMgb2YgRVEgZG9vcmJlbGwgcmlu
Z2luZw0KPiBhbnltb3JlLg0KPiANClllcywgYW5kIGl0cyBlYXN5IHRvIHJlYWQgdG8gdW5kZXJz
dGFuZCB3aHkgY3B1X3RvX2JlMzIgaXMgZG9uZS4NCg==

