Return-Path: <linux-rdma+bounces-6964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F062A09B7F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 20:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EFE18854F4
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC4215047;
	Fri, 10 Jan 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="c5SWQkej"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAE2144AE;
	Fri, 10 Jan 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535542; cv=fail; b=dgHCOD2Siei5d1u3ZFyZdtgYiS0xBRmoX6tk6Xc+f675UYmtHMURAVOqZRsod/totRo2dlXgabYXDSTmf3BxHiifVMxCshAyusPYHy1nZFuHDtpM7pEyfxY1IDU8vmMkWkJ6ZxySkewOgS2V4orOeQYmIpNG05szi39yVhnSIN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535542; c=relaxed/simple;
	bh=6AO6gJ8F3WTW/tNr8yM3dAzyLzfwtCXBGngwcCXFeHo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NyLegiNbO8MW4Sw22+UzFCOS/R0twNpbnXzw66H8B8XoOYNAGR7Omb/eumRmSwrh+m1qPsvLBzKcmJc3+MNvcf6BX7WZjCq2AEXpWrB2pymtRgkqjUHpxYm8HparmYkb+A7C0dAiJ3As/rJA5R4+EW5Sof5vKy0fCk5fvgv/LJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=c5SWQkej; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1736535540; x=1768071540;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6AO6gJ8F3WTW/tNr8yM3dAzyLzfwtCXBGngwcCXFeHo=;
  b=c5SWQkej73v4dJn3SKgql7ZKsr6CD8rHbxsrvG05+JP7FYi6QhbyOUQU
   jWjGrr0P9rHM8BMMc2RG379g/gy/gFDjox2YDh2LoIAEZV8zhUtjEHQCB
   x3Z8s43UL3nKq07e7yXAyeO5PqSlqxhGbByHTfhe+S2ORWt/09P6g3rFS
   0=;
X-CSE-ConnectionGUID: Dao4rmTlR2GJqXSxWD7B3A==
X-CSE-MsgGUID: rLnzyypESGe2gVOxmCdxiw==
X-Talos-CUID: =?us-ascii?q?9a23=3A/C6mTmnw0z3rsJOugXuHnTVuskLXOVHUyyvKJnO?=
 =?us-ascii?q?8MzxGaqSlck+v1PxOyOM7zg=3D=3D?=
X-Talos-MUID: 9a23:qE/zlgXQTQ2ixBTq/CXIgiNzJd9F2IujUk8ztoUDkMWUNDMlbg==
Received: from mail-canadacentralazlp17011054.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.54])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 13:58:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrQ+9vEXJ+tSDRAi45zZvV++M+LdKgcDVYxf0cT2BDW4DPeQkY8ZK0Wl7SbMvJz8hl7GvBYOYlHGKnaobEyNBbgix/LDqK5FIsulm0HmQSwoSJ5/we7saSNJshD9aM1F53md8H9tDQvhLHP57cIzBVKJ63hIjSBO2Myp/Y6/jMnJUzmVgtIWvi+j8gfr3Wf2KXk9NdfDnTGPkFD1vd6FkFEi/dXCfrGHTX9VEhCpMET5Op+GriOeTADjBTTgOSBPPiZcJ98+OiFYPElWgGWUu7sLTuMvtbqEcWTBUNEShY8AInQJd1c+RnttKRRLxR9B7rP87u4a3UwrcybRcQoCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddWAJ8IkFEc7tDWsVaDFnVmccl/5r21uEaMyzOhS9ok=;
 b=xY4/mKCvHvL+sjWVfRwZFW35LnZwGgM2IH9dbmI5Glq0TtfFGn2DxkgJumMxPFMPgYDwMWYn0dW0CZTjKDj7PCLKBzAr+2etOcMoZMh7nNz8vJBmhQjFt9dE+zelm7N2u0NxZ9wb6lsTpdkVvFgxl/OVaDC5vKbjwMvcQ29T8i0tBZ4zjjbmggaPM89RMXsasIFUExrt3Uw3dRR1CTzGVq7MsKNrkjqmec5P8SQ86pwAkyzGJsXWptzddlFCbUITHuTSiM3zl46Tv6983fnPFOuQccLty5ayH06aPtmHGNFnMUqYql6F3WjYvWTNqoT3fvgok5iSOj7Ldk8Erg6i2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB6551.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:72::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.14; Fri, 10 Jan
 2025 18:58:16 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 18:58:16 +0000
Message-ID: <58173312-64f0-4208-9469-7113d2f81119@uwaterloo.ca>
Date: Fri, 10 Jan 2025 13:58:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
To: Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato
 <jdamato@fastly.com>, Alex Lazar <alazar@nvidia.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 "almasrymina@google.com" <almasrymina@google.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "bjorn@rivosinc.com" <bjorn@rivosinc.com>, Dan Jurgens <danielj@nvidia.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "hawk@kernel.org" <hawk@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "johannes.berg@intel.com" <johannes.berg@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "leitao@debian.org"
 <leitao@debian.org>, "leon@kernel.org" <leon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "sdf@fomichev.me" <sdf@fomichev.me>,
 "skhawaja@google.com" <skhawaja@google.com>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 Gal Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
 Dror Tennenbaum <drort@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
 <Z2MBqrc2FM2rizqP@LQ3V64L9R2> <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
 <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>
 <Z3Kuu44L0ZcnavQF@LQ3V64L9R2> <Z4FkAZkNnySdjdRb@LQ3V64L9R2>
 <Z4FmbseFBQT_g1R9@mini-arch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <Z4FmbseFBQT_g1R9@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0019.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2208a5-4bad-42cc-8332-08dd31a8bd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHlZRmREdythV1V2K0VoSFh0ZlJUdW1hL1NOcUZkQmVaam55RGJtblV3NFI1?=
 =?utf-8?B?bktzcm9rT2ZTZ2syTGNLSFp5bUZvWG9iZTEwRHh3QzY0TFpEM21vMzlYcEpO?=
 =?utf-8?B?TW5JVDlPYmhBdjMwQ3YzYmxwekEydlhWZEVFSU1aSnhRSDJpUE0yYU1CWFpB?=
 =?utf-8?B?MFFaeWhZTnVnemYxVUswRGpoeTlMYVVKWDh1amJ5aXlabm1mV0IrOXp3S0cw?=
 =?utf-8?B?cEYyaHVSSENIK2NIU1VJcnZtMGpCbTEyYkZKLzdTNHZkb0JrMVFDdkNPQVp0?=
 =?utf-8?B?ZUo5MXdkWWhaYlJRaW5KUzNUWkZDQzF5bVo1dTgvc1VaYjJDYmtVQTNxNGV1?=
 =?utf-8?B?T0VqWjQxbmwvVVYvMmk2VHdFV2tadzRGczVMZUQrczQ2M1pRc3VMc0xXbVFz?=
 =?utf-8?B?WnZVd1VZTGl3OXp1QzRPOTI5V1M4cDd5RHJvRGhuWk1IMlpJQzF3c1RjbFBL?=
 =?utf-8?B?aitBSUd1RVY5eHJiS1JPOFhRUzkydHV2bmhyZk4rWHRhTGsrZk5SazZsTEtF?=
 =?utf-8?B?cVhWTVhIYS95ZjlBMlJFR3dCUjZjYkFGMTN0SXpMVisrZW5uMzc1bndyNUh4?=
 =?utf-8?B?YnB4UFVhbDBmWFEzQ1lmdGJadENEOFBGaDk5WkdmVFhEb005L2dIVGZ6Zmd0?=
 =?utf-8?B?Vlg1TkhjeHZRRWlEeUltbWhnQ21YVVI5QldRYk5YVTBBQXhKQS80Uy9ncXEx?=
 =?utf-8?B?ZXRYY0dISFBDekVHb3JFaWRLWFdUMXlkQzMxN3VOV0pxWVBYRDNPYi9ldHRi?=
 =?utf-8?B?K0FoRDBlSk5uTXZjK3daMXdTZkdBQ2EwOW1LZ21PSlpWaCtRcE9PQ1ZmemQw?=
 =?utf-8?B?bVdhY29MbGlKY1BsaVlkWHdEZzZaRUs1Tkw2U25mUlNPM1FiV3B5elJrY1dr?=
 =?utf-8?B?cG01UDBDMjBZTUsrZDNuQURhU2w2MDdrb3c0OW9JZkJnTmpGbFpDUnpCNm5z?=
 =?utf-8?B?Mm9TUi90K0JUbTM4RWoraDFRUmc4dmNrakdnVjdjM0JEVlNKaXpPUERqb21w?=
 =?utf-8?B?eC8zT2FBL1I1MWs1NklNd1ZpTG8wNkFXZWFRazI4MUNxT2VXSHZlN3UyMGxE?=
 =?utf-8?B?cks5R1lNRkM4UFBFS3l4WG1Rdy9tTHlmd09PUkdINVAzYkIwSUE5Yy8wZGtl?=
 =?utf-8?B?Rld1eG1Tb25xd1lWaDR2Slc0ZUVCcnVrWlh0VkpsWjJydERyRVBScTZjaU1V?=
 =?utf-8?B?RE1XTmxJMFdyek43RXN5SzlQK0lINXBINW1QVkYvUS8wWDhpazFvVUVzUFE3?=
 =?utf-8?B?OWFGbFptd2hsVzRneG9tdEhrbURUMnAxZEFYeEVGT0d4bFpaQXdXa0hMbWNY?=
 =?utf-8?B?azNRRk82TEFSbDJzUlozaWd0L1ArajJzY1Q4aHYrcWI1MzBsU2xzcnNEamlO?=
 =?utf-8?B?VnVidnhkdU4yeUlDOGxyWjNHU1VraHRGREd3dlo0amtqOUNMTkg1VjRGZGxr?=
 =?utf-8?B?bGNmQ3ZXa1p6d3JiVXFlRkIrZytiM1MxRGZHa0thd1UwMUpaRzQ2Ym1aZzNh?=
 =?utf-8?B?NTlNV1F3OGh0cXUvWEVCWVBNb3ZYNERyQjVqL2t3VlIwTUJyazJYNXNSWVJr?=
 =?utf-8?B?TU1ZMi9mSWxsRzY4cTREd2FlUlQ4WU1BOE04aXBFVzVmYk41UVpxc1hhdmlq?=
 =?utf-8?B?ZldXT3FMOXhuQ1RUbTA0aDdsS1Rtd3VKWG5VSjhMVjJjQ1RUaHNtNDd4YU90?=
 =?utf-8?B?aFNOQURINGxxbzJHcHg1OFdhd3NGbkdyb01rdEJjM1NUSi8zSU9jVHpwTXhm?=
 =?utf-8?B?K3BJOUcyMUk2M3pCdUZSRTE4RUhPdHhza2dscDBPR2VMWUVacFRhVzZDaU5x?=
 =?utf-8?B?Yk82TytaMHhaQWhoTkI1N1I2Y3ZOcU1sVVBvTlAwS1BWL2I3a2tHNjNxTzBn?=
 =?utf-8?B?MzFWZ01lU2hUZlRUUGsxZXh1N1M2N1dZMTBLV1FDZVhWcFdWM20xb09sNEZY?=
 =?utf-8?Q?EHPy8VSWTVE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWNtK2NTblZjUlROOEtBRnRvbHRFNnM0S1UzL0xoYStEUlo1cGt0YVA3OTh0?=
 =?utf-8?B?LzZrYUpuSi9NNGlUMFE3VjdnRzBOZ1hiWGlUcjNrRkVZR2dtdmZiOXRkWTVx?=
 =?utf-8?B?em83NFBYMU9Xek4wbDRBUUR3T1dsYXBPdnBRQnpOckdLbzVpc09iWnhzNGpy?=
 =?utf-8?B?SCtKemU2WHE5c1NoRzJjVlN3TWtKS1hrTklzUTY3dzZnMnhUYjU3NDJucnpT?=
 =?utf-8?B?RVJYQ2g1R2hiRTJFSHBNR00vWXdiQ1Q5MytBcDJ5cUc5emNEcXQ2Wm05aldr?=
 =?utf-8?B?OGgwekF3SGoxR0UwMWtaWnhONFN1VnRmTXZGb3VDNHhWckxZRXVIclJ5YzZI?=
 =?utf-8?B?eW1kVGxTNjFiSHA4S2hQeTJ3ajBVbExQOXJyMW1vUHNUU09iTHN6V1lSY0kz?=
 =?utf-8?B?eFAzbTBQR01BN2ZNQjlKbkdESTk4eVNEQjU2R1ZhSkxlRHVNMkdaQ3BUdmV0?=
 =?utf-8?B?bEZKMkY5OWJSS1pXSDNoWFhXL0F3THVrMHhLR1k4Q3J2cnNJVjl6R1hoVmtS?=
 =?utf-8?B?UEE3dHRqRDRpTktuVUpOKzFjUGIwaDIxdHdhdkllTSsza2ZJNmpKVUx2TTk2?=
 =?utf-8?B?VjQxTE5MQlY2SkR6dG5DeGdERWFEVDRlc2h1WHRnd0k4Z2YxUVJVR2s4NGNC?=
 =?utf-8?B?dGsrRmpBNS9vZGpHclhkK3kxa29sdjB6MWs4azVtc2MzRFZRcG5yZGc2S1lv?=
 =?utf-8?B?TFUxdnh0R2FidnIwZHJCRk54bkY5cXVtdDhRRXZGR0RtUEFUQ0dGRFZZbE55?=
 =?utf-8?B?aGZaN0dLS1Vvb0x0SkNSMTA3c0NRUHZDSHAyaVJoRjlWMGNxWWtYUXNQMFJ1?=
 =?utf-8?B?dHl0TTdNNUxxMzhpNmFuTkZwbWs1ZkRwMndOd0E1TlJYTmlMZTF4cjI4bmVR?=
 =?utf-8?B?azQ1VENuUFhCU2R5b3NIcXhKWUVHbkpsdmI3emx5SVNPM1UyVGlWMVpzQXhT?=
 =?utf-8?B?cmtYaGpmWWFuMTM1cE8yUUQrWkxWaHZpL1hxMTN5OUFVcC9qUTN0ZEdYVFF0?=
 =?utf-8?B?Vzk1eU5KZEVaWlVtbVdZdmNybGxVYURSVFRxZjJQZ2V0QmhNT3BxZlVlTEUy?=
 =?utf-8?B?VVBhR3IyL2VWZGFnZkpiL1Q1L3BTUVpZVG01cnNXVVFLTDZ3VUNlVGliS2hq?=
 =?utf-8?B?R1puS2NrbVhYR1p1WmdLVTZ2RlFYNnNBYXZiNEt5OTM2UDNycHBHS3hRMnV4?=
 =?utf-8?B?Wll6aUxZaDdvaWsydEpOTjhOU2hxa2o3RmlMOSs5Wi9JSVdnL2p6NmROZ21J?=
 =?utf-8?B?ekFMSkg2K1lnd3gzanpJL000L2JvUWMwTi80OWVPTmptbWlUdHU2TVJEVlIy?=
 =?utf-8?B?YU54cWdHS3dMRlp2c2M5ZmFBaE5TbVRKODluS2c4aTBwbHhBRGRrS2tabERU?=
 =?utf-8?B?R3FHVmdyQnFKQmVhbUZteDJ4Ynp6c1BUU0hIdDRXTzRlTSsxd2VGck9KRXFG?=
 =?utf-8?B?YTQvVHdXT2VRMTRpTmZVR2ZUN1dXaTBJMDhxeFV5VndnaURiRVdPUk11aG1W?=
 =?utf-8?B?MWlKUkE0M2RWTk1NUU5mY2ord2o4ZFRiVGtJVk5MdHJrM2VXcmRsckFqaU1w?=
 =?utf-8?B?cW9zd01JYlVRd3lISjJDcFNxVWhVNnM4dk5kMFM0SXArSmlUUGhMbzNtWHgw?=
 =?utf-8?B?NHNqNnZ2Z2dTbUZHMTFmNUdhNURZbGlmbi9yeGZrUTFmZ3BOcEZoZlhIZjZt?=
 =?utf-8?B?MllXeXZRMjg2L3dSOHEwbXRQOTFHd3lTZjl4cGMrc2ZHb29RYkxRWitjVEFR?=
 =?utf-8?B?cVBaRzlGTEZLYUxGUlJid3djaDVaN3hiSkh6MXh2T05jTjB5eFNWTlBpWFVk?=
 =?utf-8?B?eFkrWlVpQWZYVlZRcnp2ZXpRaWQreFR5b0pMaitjQU5GSXNKZjVJTmJDaGd6?=
 =?utf-8?B?QnJDbHRZcWF1TkxnWks5Tloxa2dzUURsSkNNQTAyQjF0a01HSXg0aVpYMTF3?=
 =?utf-8?B?ejJRRDBZeFlaTHAvc0JPRkI4Szdhb0pDQTJ4MTNMZmo0WmttUXFVdXlRMFRD?=
 =?utf-8?B?M0RSd0tKR0RVbXhiaUxFNkE4OVhEOHR2bDFRYjlDSU9DUitITGVQbTBoYk45?=
 =?utf-8?B?ODk5ejNYYytSSVdkakFKN2xvdUpSRmtUSVM2M2NCdDVjUWdsZDY3VDZXV01S?=
 =?utf-8?Q?YER8uxVr9kqXw4CL9UNTYB0mq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ra5Zz+iHJ5UDMRbZQy3EHAOBc9Pun4NBeGHJW4S77T+x3B9vhWx4kA8R4ThavUdCTPhZnBhdW5WiUuMujYZIJI2uS0lFSVJYecSmhi9vOuzJPfwVbokvQ7Cqo+LFrnuZRsFLRuv2mDztxiDrVaJ3uHoq4sVmaDQ7e88mcGEnIw2bTz2htWI5Qp4ETUPxd/yCmW2nd8eL2Zku7shfELk+DXMEsTrDGfK5HCUOQLWaZaS2vhLQL+IPgoBOVoxqVWJa95HBV8gUcNe/2bzGMSll4+QbZFVNAkns4brNf7WLW+Ev6gcJmwypE+6g/4ylX4yNMnjj6vkqJGb4rsxCcC8KWF23NmZSrlY7MXkty4uDnx+O5cFxMF09NkY8+/Aybpiekfv3mUhl3R1cMsUZfsVUns85V5kywfK8mbWM7RqJQEspLfpRU0qnsqFuxWuv1ZjGRnQxDRx9vwaw9REhzbcOm/xKYAddqtiVdvdhLJg6ai6c2NGZpe1YmcvtJdJSn6e8p7D5AWcmKaFt3Z/eqreI7TIHjQYL7S8CzCuC05mw/AqA6R6dXj6va7sYXe4f9oTbkR7EOWZKMKxZf9k9kG97OrxKWvZMlQeMCGCaOCTwkshSzwEmCIz2uPIWPv1y/9KS
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2208a5-4bad-42cc-8332-08dd31a8bd93
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:58:16.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rggPR6Q6W57K/vYzhB95ldfwtaM5z9S1wSB9NUqqi/KI9OZEpfi7eAQh0x+cw7+TYM0YdsiIeNowGCEKzH//pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6551

On 2025-01-10 13:26, Stanislav Fomichev wrote:
> On 01/10, Joe Damato wrote:
>> On Mon, Dec 30, 2024 at 09:31:23AM -0500, Joe Damato wrote:
>>> On Mon, Dec 23, 2024 at 08:17:08AM +0000, Alex Lazar wrote:
>>>>
>>
>> [...]
>>
>>>>
>>>> Hi Joe,
>>>>
>>>> Thanks for the quick response.
>>>> Comments inline, If you need more details or further clarification,
>>>> please let me know.
>>>
>>> As mentioned above and in my previous emails: please provide lot
>>> more detail and make it as easy as possible for me to reproduce this
>>> issue with the simplest reproducer possible and a much more detailed
>>> explanation.
>>>
>>> Please note: I will be out of the office until Jan 9 so my responses
>>> will be limited until then.
>>
>> Just to follow up on this for anyone who missed the other thread,
>> Stanislav proposed a patch which _might_ fix the issue being hit
>> here.
>>
>> Please see [1], try that patch, and report back if that patch fixes
>> the issue.
>>
>> Thanks.
>>
>> [1]: https://lore.kernel.org/netdev/20250109003436.2829560-1-sdf@fomichev.me/
> 
> Note that it might help only if xsk is using busy-polling. Not sure
> that's the case, it's relatively obscure feature :-)

I believe I have reproduced Alex' issue using the methodology below and 
your patch fixes it for me.

The experiment uses a server (tilly01) with mlx5 and a client (tilly02). 
In the problem case, the 'response' packet gets stuck, but the next 
'request' packets triggers both the stuck and the regular responses. The 
pattern can also be seen in the tcpdump output at the client. Note that 
the response packet is not a valid packet (only MAC addresses swapped, 
not IP addresses), but tcpdump shows it regardless.

Thanks,
Martin

# on server tilly01
watch -n 0.5 "sudo ethtool -S ens2f1np1 | fgrep tx_xsk_xmit"

# on client tilly02
sudo tcpdump -qbi eno3d1 udp

# on client tilly02
while true; do
   ssh tilly01 "sudo ifconfig ens2f1np1 down; sudo modprobe -r mlx5_ib;
     sleep 1; sudo modprobe mlx5_ib; sudo ifconfig ens2f1np1 up"
   ssh -f tilly01 "sudo ./bpf-examples/AF_XDP-example/xdpsock \
     -i ens2f1np1 -N -q 4 --l2fwd -z -B >/dev/null 2>&1"
   exp=1
   for ((i=0;i<5;i++)); do
     ssh tilly01 "sudo ethtool --config-ntuple ens2f1np1 flow-type udp4\
       dst-port 19017 action 4 >/dev/null 2>&1"
     for ((j=0;j<10;j++)); do
       echo -n "$exp "
       echo 'send(IP(dst="192.168.199.1",src="192.168.199.2")\
         /UDP(dport=19017))' | sudo ./scapy/run_scapy >/dev/null 2>&1
       cnt=$(ssh tilly01 ethtool -S ens2f1np1|grep -F tx_xsk_xmit\
         |cut -f2 -d:)
       [ $cnt -eq $exp ] || {
         echo COUNTER WRONG
         read x
       }
       ((exp+=1))
     done
     ssh tilly01 sudo ethtool --config-ntuple ens2f1np1 delete 1023
   done
   echo reset
   ssh tilly01 sudo killall xdpsock
done


