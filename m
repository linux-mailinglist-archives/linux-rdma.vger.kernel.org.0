Return-Path: <linux-rdma+bounces-11552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68DAE4AE3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDCD3AA8AF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A729CB2D;
	Mon, 23 Jun 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="lDsNFsGt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965F27A10F;
	Mon, 23 Jun 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695826; cv=fail; b=X5IlJ2ILgmFZt0vneZmmO2o8kDm/Fm0bWlH45ZKMmQEDAvvemctgJuqNWpiXyA75cTEADu57Y26Yk/BeVbNNPuXJPltCykaaSo/q1lxLhuqb32KjxgGPG1/hRPb0cyksvSe4GPmKKixq/XFTdMoAFriI99+oHhtssHMquGhs9Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695826; c=relaxed/simple;
	bh=socxSifk0Egz6dljCQBM+1Z0tcd+mvJLRQ2Ut8Vt5FA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9L04pj6C7XzUVCvItEu8Nj5hovc4X9uzp6wz4xKDNOjSyG9WPXl8KrWsXjfCfXlWRQ+XpzykrE01F7lKtcVj1h3r5vqfDdVtNUGtKgT6yWa46w6/6NoAucrmS+254NvmIgn9Z/yBVZ7A6S3eKYkldPR+P7hOPNxsSx+CaoXNiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=lDsNFsGt; arc=fail smtp.client-ip=40.107.94.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUcLF5ljM/g1jbZtwF6ZfmsZo67DUhzsgSsw0LGRC98IU67Dg7Ro/9qurpoLilrZeB2N3vz235bsy2mUVQ26mELsfvixF7/Lyu2IvzBXfAlw0KaRkdNPqILLa9a4Dk03w84Mr3DqUO/VKsYCYyqAX1tIXTnIlzqnux+VZi5Se7uHuoHXMiLCa5146KD/tsiTr3rYsXhU1e4FQ9oyQfTaIJWuUuJKw2G53eU7PL/gZVp/EsJX9cdAXF0b7Ma9FRAq0XT5B4kYZaJ6ANRkcSU+CIKIBQdyY3KcHZm/nLfvV9cBZSVVXcOZS9EyeVggCjlYhNiHUmZaYX+lQ7kOMcaIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfirnNl1/XNe6MSlNBlJ/L81vPYxLHN/EB3yKj5Vr/k=;
 b=Ag5VIx5MwkMNdFlfS42W3UijhSZC5fGkSU2PULBWIUiVFiWYBu2TpyMHMJG4DB3OYAWE6loRJ8dzl2KLJCz4UtBGTwb1LzwLzggnDav+dHguNO3OoS27FxdFHxJUMUPbZxUy6iUcpKeDVUD8wrqtbLtCCiDIpYGFKt7SKGymwkgJSngkqmqN4jsecIwNvqx4aLnnnXMk8uvePXHyKOnEdamh/t8ha/bIGYI5lfUDiACFzSHy7rfhgO8JDtDRyXac1WKUpG5QJOBP5z18VENVK1bNced+bWwPkxWQTpunmpnCZYrYHsSkx22bzD28gNQpjt3lEfBH/bnqqFMKI3WdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfirnNl1/XNe6MSlNBlJ/L81vPYxLHN/EB3yKj5Vr/k=;
 b=lDsNFsGtEJwEUWfKGoLcWNdWOZAW/88jQpFgkDGgEixyAHPILnkD1Ulpd/7MmLGPdhgPxtHY5o7sujHpCp8maJJLTFX4HOEXPIlmfSiBzCzG/UhEDHuXh0MjtYE0kIGuyN72HzHd22lJR84WvrFEQmu9FvtRoDkcAO6CkxBWsMNuondJCbUxl84ThxCy8Isrzev/RUCsBggRVxyiXylgW0oc6sdWbN1xj41+xwyk55yabZHlp8EYQNwYG4AzHe7ZSFcIaZxf6D5lSfkv4djO4N6v1cyaLQ7ERTU85yC6NSgfqh44BRQuvV96p8SzJovKsDoR2LMGR2uL5jTL+QOgWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 PH0PR01MB6422.prod.exchangelabs.com (2603:10b6:510:1c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Mon, 23 Jun 2025 16:23:39 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 16:23:39 +0000
Message-ID: <ed72aae3-e9c2-4768-a400-cb99cb2a0f24@cornelisnetworks.com>
Date: Mon, 23 Jun 2025 12:23:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] RDMA: hfi1: cpumasks usage fixes
To: Yury Norov <yury.norov@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250604193947.11834-1-yury.norov@gmail.com>
 <20250612081229.GQ10669@unreal> <aFbJpqbP-tU4q84P@yury>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <aFbJpqbP-tU4q84P@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:208:160::45) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|PH0PR01MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: bed3701b-dca2-451e-7f45-08ddb2724ff3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3h1c2Nob2s4bm9PZWwza0h4VCsxT25JZGhYQ3lrY1phK2d6eTMzaVhFQW9S?=
 =?utf-8?B?ekxCM0NHc1VmbHBIVk5GWi9WQWJ3Y3ZkOWthWmR1RWJuTlZGM0I3REZMb01n?=
 =?utf-8?B?WkpyNnVoOTErQjVlMWw4Vk5mRVp1YmFXQ0ZRL21qV1FSR1NBSndhbVFtUzIz?=
 =?utf-8?B?RS9qc04wZHNsdHhEZGRDMEM5eWR6RVRVZVZqL3l1M05OSzhLK29FczZmamJD?=
 =?utf-8?B?ajhwNEFuWGV0RnRvYkZIME1ZcmMzcGJyYXpFc0M4bVBGaTRrSVZiMnl2aGYz?=
 =?utf-8?B?M1ZnZGt1NzlRZlpDQ0tRai9NcGthdkxyWVVmUnQxdkcwTDJrZ2p3VVRqS0cw?=
 =?utf-8?B?enlQSGw1RkE0Ujhld1pHK3Awa1J0b3RVSGtqN3dGU0JYbzh3NXFBTy9MMkVl?=
 =?utf-8?B?SEVzeG9MT2dCeXI5UysxOHpub3BtNWtwT1RQRDVJR1RjVE81MGFacUg1RFY2?=
 =?utf-8?B?dzhFRDlzQS9LajI0K3VRZjZ1ZGlacWhXR2J6aUE4OWMzb1NSdTZRVU1kU2J3?=
 =?utf-8?B?V1dvSjdoa0krRUJTUFhPOTFMTVJFMFRMOC85UHhyYXV3RW9DQ3owbWRzcnJN?=
 =?utf-8?B?K3VYZjdUK0ZMcHZUNlNFMmRyWkpRQTJKdGM4RGU2RkZTR2loMUF4Y24rZWZj?=
 =?utf-8?B?M29DT0s5ZUpqRTY3SnhYQVE2a0xMVCtDVzVwQm1PWnpNTmVqTFpKbGlnOTFR?=
 =?utf-8?B?S2R1VEtveFR2R0lnYnZGeG5COTRpeWNOQTlOYWoyelFxUktJVVFIZlFQNWtX?=
 =?utf-8?B?Y2pBeEZEanhsL3VWRTh6ak5mK3BIcy9Ca3ZGQjJPeWphTzJsejIyTktOaCtQ?=
 =?utf-8?B?TUVPWFJ1SisyZmc2U1dXYXB1UXVoNlpEZEd3L0F4aEhMNCs1TUdLRGpuVzRS?=
 =?utf-8?B?L0ZPUkJKRzVpU3lUOHg1WFBnNEtSMVZ2WTVBbUl6OXlZWFNwdDd1TElQYjdT?=
 =?utf-8?B?MVkyN1RKSEh3dUtld0hSazlwSlpPTWt1TzBPL0lhaGRLMVpQbFpBS2p4T21O?=
 =?utf-8?B?SFhESVgvN2lTN202cG40RDh5WGpFeHp5QnFUZzF1cS84YlN0a01ERHYrd2Qv?=
 =?utf-8?B?eG0rOUVhTDFjamdYVHViNmxRUFd6SGsrUW56MHZPZzQybDBMOXY0UnJnUlFx?=
 =?utf-8?B?K1hRN1hoVnhJMzhSL0xzZE1iWTFhZ0oxYWt0ZVRWQ2xwTW5Od0pqY2FtSUZp?=
 =?utf-8?B?U21iODlnK3NHWGcxQ05UMnVUcEg4dUt4WkpveTZZUVdhQ3lBUzMzL2R4b0Ux?=
 =?utf-8?B?TitTZDg2a29GS2V3dnNOVmJuMTlFajVuNCtlSGVaNzJzdmw3L2ZtTFFKQVNl?=
 =?utf-8?B?MTN5QzRLc254c1pHdzYyWjdwOU5LdHo3aWxYZlg1T2RFaEkxSTFBaWZsTnNr?=
 =?utf-8?B?UVVtQTZUWGhXWVFpNDJHM2hwQXJPbG9KeE9nWkVna005VFIrYVVNNVVuMzJX?=
 =?utf-8?B?NndEN0JXMlEzR0FLSTZKTEpYVU45WTVJSVBXY1FpZzZETlMzaGlTQ2hsUHh3?=
 =?utf-8?B?Um9kQlpRSFl3b095WGgvaWIvUkJscVVJZVJkSW51MXdDNEdaZkxKM2EvNGFV?=
 =?utf-8?B?UnNEeVZ3QzZBeWVVTjNzQWFyMndQaHRsUmM5blgzMlF6QjVQZGhTUHdYbEhM?=
 =?utf-8?B?K3VKS1ZaaVp2RGZ1eEtHQXEyTmFXYzBMdEFyc0tBRmVINU10STFIR3NRVS9U?=
 =?utf-8?B?MzR3SzlVUXZPTnJxNkFJOTJ2TzFVbGEzQmpSRGdmVEdrbmlUY0pUZ0YyRmE0?=
 =?utf-8?B?VTJuMkRrRW82Tkk0NlI5Uy9uOHFJb1RHOFF1WVJpVjBIb0dIeDNKSmt3eUZG?=
 =?utf-8?B?MEhVY2U5L3dpdjJGTGh1UzUvY2lyQkkvUm9DQVdLbUlWRFpHUmpoWDBKNjIx?=
 =?utf-8?B?ZmRxTysxWlAzaG9Ncmd6OW9qdUdURWlhRWNCSXBCYjVrK1c4VlFJTU9TK0Rz?=
 =?utf-8?Q?pza8eDtoCuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE05Y0RhYXMwaTAxMWFEWFBaaVFESWJWQXJGVDhnMEY5b25qSERCN2pYQWRm?=
 =?utf-8?B?cTdiZDRHTVZqQ3p5dmp3QURieWgrWFc0Q2FidERqYkI2VXU5c1ZoR3RlcEpD?=
 =?utf-8?B?elBKc1VUMU9BYk5yQytadkpiMW5JZnVJc3NuOXhIM3dNZ3FFSnU4S1ExZW5o?=
 =?utf-8?B?UDk1MkQvODlsNmNRQ1lkUGNBeDVHaldhejVadGE0N3BJTmRtUmVDVXN1MEhY?=
 =?utf-8?B?RVhmNVYzZExWeE9oWE9QTkhEVzZXenU3a010dUpkazhFcGlJeDhKdUE0T3dt?=
 =?utf-8?B?VytwWTZ3Z1lrb1FNYzl6NDEvVkxxOGZ0d2RVOGkydW82T2lBMGhRaWtTanVr?=
 =?utf-8?B?ZjhhQW5RbDZNVmVLaUt1RXRUa1RzZUFVZGRCZW1WcnVqQm9PMlJKd1hZTmU3?=
 =?utf-8?B?MGMvalcydjdxeFZTdWNrYmQ5VDZkWGxycUdqcmZKWXJ4RVlsV3dqUlBmUk11?=
 =?utf-8?B?ZTA2eE0ya0QrQ0pRcFNpZVJMcUdLZ3BJOEptTHo3Q21HUG8zc1Y1WXNlVGdt?=
 =?utf-8?B?bUxMcUxGZXBLNGNwYUNVaHZickYxeldkOHl6bXlmUnFGVzQ1YmJHOVJMMStH?=
 =?utf-8?B?UmxWR0xZbFVlYTE2NE1QVVc4TWFKZmNoc1g5cXhNdWZLb2FVcW1VS3pLc2k5?=
 =?utf-8?B?RnFWYjhrd1pQWWNlVGxwcXNPZ1NVZkVqR2pHRThjQk1RelM0dGw5cG1hN1p6?=
 =?utf-8?B?aXFFMUtTUnZxYjFyKzNDRE52V3JjOW56ZFBIRzYxcmpzKzJEYWN2Qm96emxh?=
 =?utf-8?B?bFk2OEx5aUQ1NDhZREdmallOcno0ZGNqSmVadllwWkZwWnNlaUg3Zjh2Wi9r?=
 =?utf-8?B?OVB5QWRMSHIzcklTanZleEJHRVk3R3owZG9HcVV3OUpqbytveEdaMENxa0Zy?=
 =?utf-8?B?citXbUJKOFFCbVBMOS9PUFJSRVQ5WkZRakovUFRLanM3TkpyMmRYTG4zclFh?=
 =?utf-8?B?NkJIUjlDSG1adHNTL2x2TDAyZ21WcWJhVkpFSE5ic3BMZFE5cnNRalVSL2ly?=
 =?utf-8?B?bitzdkd4VmdBMDE2KzVqNy9Xdjg4Z3lESitydkJoalZ2eTNkUmpLT3dRUUlB?=
 =?utf-8?B?L3N1cm9sU2FSbEJBUm1ScUQvVEU1TVE0eldkMzBnVVRjTnJyaUticE9LMGVB?=
 =?utf-8?B?ZlkrK3RxS3lKQ2NLVXVZRXNZNUVHTmNSZklrWmpsbmZjRndRdE5qOFJ4eis4?=
 =?utf-8?B?ZC9qYzdZcnJGUnVPekxDeHYrOXY0bGV4c3lFRS9KdGNoTHcvaDBUM1M2SWpG?=
 =?utf-8?B?MXVwcmtFT0htWnFMWVBnVGpZNG5zTWdiRXhWY2FiNEFLTG9lNU1VTjVxamRW?=
 =?utf-8?B?aHFvbE5jUS96VmNsaVdQd09YSWdpeFZyMXNhOTNIQWQ3VG8rZFRQRWVzNVlq?=
 =?utf-8?B?TkRlY2tWODFQN3pGczhmM3dJNHZuMHBkaUtjeUVIZlFDSFVKb2ptdnhXR3Jw?=
 =?utf-8?B?VHVKbS85dWcyUytydGxkYXMvMk1mTFBxTlpyb016QjRSdFVTZTVMajkvdzV1?=
 =?utf-8?B?dFFobVBLY25UWDVpY0FyS1R5VlZ3eWpZT09ETlR6R0NmaVZlOGZWRHB0SWg2?=
 =?utf-8?B?YVY4NlhSajBzU3E2WmozcjdtejNqdjk3dkdSUzY3STVCRlNQYzhMYXpKY010?=
 =?utf-8?B?d2g5dlZRNDM4Y2h5cXJVZEhQTng1NXpWSWFzSEFmb25uUENMbGFES1V0STV0?=
 =?utf-8?B?VXNvQ3RHTGNyWkNoa1RzV3ZLbG5nWWoyb1Y4N2dvNVJWMTBsRUQ0d3BEcGE2?=
 =?utf-8?B?NU1Gd3NoODhvRTAyMTZndm4xbVR0a2dQNm5RcitIQzBXMzFyWEhWNk8wU0Mr?=
 =?utf-8?B?YnZxVDBOVk5Uam9SSjY1amZmUTFqQU5Dc0c2dFg3a1FtYVN4OC9xYkxnbi9y?=
 =?utf-8?B?WEVxYVBucklPRVZkUnlpYnMyVTZnSlo3eHhqT3MyR01XeDZPVlhDMCtxbzFk?=
 =?utf-8?B?VVRuYm9ySDU4N2hCZlBRck0vUTBWYmloYXQxYzFSTmdrSldRWHlmMzZja2R6?=
 =?utf-8?B?TCt2dlV4eURCRE1tZVVlMWZhaGNBcTZkbGRDUlZGd2lvSk9PTE1KdUtqdlVW?=
 =?utf-8?B?TjhpWkZLeFFiOWRBS2JFaEdkalI4Mk93MFFTNXJqRTBMY0Y2ckk4b2JZTkNn?=
 =?utf-8?B?cUU5K1phWnpkeE40bkdsb25QTkI3SVNqdWVQVGlJQUJuUkg5VHBKTm15dE16?=
 =?utf-8?Q?rfNVnzDTkJGYbreBOB7wJeo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed3701b-dca2-451e-7f45-08ddb2724ff3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:23:39.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6mnvweHq/owy2TA1etxwnHbnsZsg56eCKEWwWMlAvGiLqD+7zRiALxuHL1xT74DFLIYqvBH9iLRU2I8ceQc7RrgaxO4GhOPs/6vZHAsmZf5IFMvKwDWubSPxDB9/RAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6422

On 6/21/25 11:03 AM, Yury Norov wrote:
> On Thu, Jun 12, 2025 at 11:12:29AM +0300, Leon Romanovsky wrote:
>> On Wed, Jun 04, 2025 at 03:39:36PM -0400, Yury Norov wrote:
>>> The driver uses cpumasks API in a non-optimal way; partially because of
>>> absence of proper functions. Fix this and nearby logic.
>>>
>>> Yury Norov [NVIDIA] (7):
>>>   cpumask: add cpumask_clear_cpus()
>>>   RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
>>>   RDMA: hfi1: simplify find_hw_thread_mask()
>>>   RDMA: hfi1: simplify init_real_cpu_mask()
>>>   RDMA: hfi1: use rounddown in find_hw_thread_mask()
>>>   RDMA: hfi1: simplify hfi1_get_proc_affinity()
>>>   RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
>>>
>>>  drivers/infiniband/hw/hfi1/affinity.c | 96 +++++++++++----------------
>>>  include/linux/cpumask.h               | 12 ++++
>>>  2 files changed, 49 insertions(+), 59 deletions(-)
>>
>> Dennis?
> 
> So?.. Any feedback?

I'm ambivalent about this patch series. It looks OK but I don't think it's
really fixing anything.

