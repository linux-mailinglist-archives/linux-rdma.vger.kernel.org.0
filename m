Return-Path: <linux-rdma+bounces-5814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A29BF669
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 20:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B3828433E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC4C209694;
	Wed,  6 Nov 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgEW/le3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88320968E;
	Wed,  6 Nov 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921042; cv=fail; b=cIwjeseNp2LVkA8b0Q9oZc8GsrQfH3E+8TmQAHVwf0KFUWq+SC4caVciUf7SQ+edQsQI26YUmQCSnApMktQJJBINJkz8Walf675MufFU/qGeYzPhgt7UsX+MZXLsGOHbapTq+g8dWk6Nbdlv5yfsyjpxeV6mJjpq+WrJKYgH2hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921042; c=relaxed/simple;
	bh=n0Y+vMzqRAYXH+l6ZF6VjtozQAewR04L/V6Zp/Yc4NM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7KSCTsk6G/BbTgMj3sCiHAb5QPP251ut5bO8OGRP2twuD/srtyx3Q61VFWOZ1wW8kkyHL/cr1T0Fkk+pUtdWHptz2C/pCG1xM6oZ7UMaMy7ef4ThI8IlrjKgMY0lQgetDCkjYLxfUgn9OE3jvAZz5jSXQ1Dwr38pYvJVeeQn5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgEW/le3; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdkB1j+LPtQC+8H2a69skTCCXxwEkAcl9YxrqAIemtpph4sKJVDEQezCUR8AkIPxrzgYFlpyVemu74QJXuSz+6Ue2TfWVaAKYGaFhY+FwU4LJgj8INU6wW2yzRrY7tABvbRKcIkEVhnCbq9p5WOrRQ1lnjXSO9HdUVEa1poIiYOkT9+IMUZyFWk2KAwWmmV3zT+5ZsTOVJCte9F4hLMzzE9zYcgmNDcxXysn7dEqYWwVapBteCFNEfCGypq6AEsMk1gzW3BLgAYD6Rllm//a6teWS1L6gI1Hcl4JxuYU8Atn+vwu9Vh9YqGpgfTpXcX9DR/J24+n29DA3Dh12cyt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKgkpoGAnDR9lkJ6bY9fCVlNyUINBmsAhVhyEOTd81s=;
 b=t0gEbYvmJ8mfS8nXsDLjVHqLxRS2FSZA891yI1fY27DPaR2kBdtMekuO3DQwydD2BK6h2BYbmvRDwRzNZWZMExpjytaOBkHeSAuk33XS3sFOG35JmLPwrFd+coX6xOrHiqNlWVurEC+AKfkKoCDWo1HzdXw1Yd8eKSHZ6YaFUjFec1g8BDegmUNHS34HocWNbpZtBEpc8C1KW2BE+DhY9hDOX4mAIvhDxcsiNVkQer02tcLXBZ00AqA/VrCb88kviKGSsrviLBYPXwusRna218Y55CBv/NI0rhWFzE3jgI2+7/hesihrVm/kV5bhxZlyD3TcqRt4tUu2Mo1QgYHreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKgkpoGAnDR9lkJ6bY9fCVlNyUINBmsAhVhyEOTd81s=;
 b=PgEW/le3aQAIrw+x4leyTlM6ssC4S32ObniIb8EADF0Etk9tp7Djsb4lwzjfNdh4HgK8iQNJVrm3WECz3gEWRNQqoqskWz3IuCW9iVILig7fAZ7Ytf246I2h37A//G8zGO2tUDa+AthkZ/lkAhCv/dgDjBXUAkhAvmvrvvBnSevUBdfJKtq3rFcLmg6SL1Yny0l0pCxuLLXl1znsGXshbnmcoObyG/AFkKLB2/AfrHJM2DJpFkf/QJceuEwzIYmgxBPwslLJiSmHq303itfdrQFZJe6ijOBfcx06F17Fwboj/VvVmPmc8YPVOkFx3CT80o18sqFwxFbiAoBS/lVKnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:23:55 +0000
Received: from IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41]) by IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 19:23:55 +0000
Message-ID: <9b3af2dd-8b56-4817-b223-c6a85ba80562@nvidia.com>
Date: Wed, 6 Nov 2024 21:23:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
To: Yafang Shao <laoar.shao@gmail.com>, Tariq Toukan <ttoukan.linux@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241106064015.4118-1-laoar.shao@gmail.com>
 <b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
 <CALOAHbDPbwH7vqV2_NAm=_YnN2KnmVLOe7avWOYG+Rynd295Vg@mail.gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <CALOAHbDPbwH7vqV2_NAm=_YnN2KnmVLOe7avWOYG+Rynd295Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To IA1PR12MB7496.namprd12.prod.outlook.com
 (2603:10b6:208:418::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7496:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: b15f1cd0-5bb6-4c1e-5dcf-08dcfe988df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzVtWFhXUUxGMERYYzBhQVpQVllUL2tyWVA4YytrZzU2VW1kYWsxUm5RQ21I?=
 =?utf-8?B?cVM2L2VvQSs2TGVxZDU2RTNxUlk3YUszdWFIVlNLZ3U5RmlXbW0xQWluWC85?=
 =?utf-8?B?VEdzcWFvanJwcW5JQ3FyeXJ1b0ppdUsvK3RZOFAyWjlVSFk5REFFQkk0UTV4?=
 =?utf-8?B?N1JrTXB2ajMxRGZFQ2c0ZXQvWUFIVUdWRWVOM0FuQUxBc2ZOdHJQSlpSZGVu?=
 =?utf-8?B?NWcwc1pUK3MyOFJkMlZQbk55K0xsL2R5QUlkbGpWS1crT3k4UEkyU2RncHEy?=
 =?utf-8?B?dGxDM3psZkU5bm9aMmNyWXhmQzdNWUpySHcvWXB3aHpnZG12UUNjQXRLRkdy?=
 =?utf-8?B?azVNWWpDUkY1cm5HNFk1eHIxRmFrTTJKTkRsMnFNQzJ1a0wxRHJtMkMvY1dT?=
 =?utf-8?B?cDVGK1cwR2E0RlZhTFZvKzNLVkhRVHFNRnZ2eEhMdFVVTVJzUjZPMnBiZmlm?=
 =?utf-8?B?SHJRb0Z2VGhzWG5CYVlKd1JiZHhPRzcwSjFWSDFTai8vNU5iTnZ5RllITXYy?=
 =?utf-8?B?RE5qNURpUEc4Q3B3b1pUSU9PbE8zeU9vY2dhSlAvNjdyL1hBd0JOc2NmdHJD?=
 =?utf-8?B?M29EOXd2Mm9XZXZlUTNBam1nV1BiYU1CTy9kU2JjNktxYkhvcktqMENQSXRi?=
 =?utf-8?B?b2pkdGFZWE00MjlXT3F2dVo0UE1kZU5IaWVkSG91Q04vSW1zcGxWZHNaclQ2?=
 =?utf-8?B?bXNiVHNzYmZlTUxPd3RwNnUyS0pNbVQwK1ZLa24rTlRJVHdrYWpNSCt3SnMy?=
 =?utf-8?B?REJINWh4dDZiQXN5UVpXa1Q3eVdERWp6Zi9uU2ZOakx3WE9RMEp0bkUzbC9B?=
 =?utf-8?B?bzZIU3VucjJlbEk5VUhGOStSVmNpbWp5VCtBZE5WWWYxQW52ZGxhNUdrdGd3?=
 =?utf-8?B?VUNHWUhGS2RQNGpsanp3cFg0TjZ0L1FTdlc4OGRtdFZ4OTNiUnBkTEpKdHpO?=
 =?utf-8?B?N1J2UXR1UWVOSFhiWHNQd0tjNnl2YmpycnU0SWJ4czU1RVQ2NXZGampMa3Va?=
 =?utf-8?B?YlBISFJWdU9BTjhsZi9aYVRMcTZibnYyOXFLL1pqYTJ6emtpbU42TGFZSkQw?=
 =?utf-8?B?SWxTUjc5eUEwS2tEZ21wV2wzQ1BEdCtVc2c2WURUTnVJRmYrWFg4OEVHZ0Ni?=
 =?utf-8?B?NkJGVWdqVzBvUGFHamNqMVpic05oS3pxQmFyQ1lLSE1LYnV3QTlSdW1OUXZm?=
 =?utf-8?B?QkFyUmtWMFlVdEJjNWF2K01HMDM0R1VZNDQ1VzNTQUFBL25jcks0ek1TZzJP?=
 =?utf-8?B?VjNyN2Z1TC9qbjllZDNxVHJoYmFYOG1TV0ZJdFZIMmVQNDBVdWJjcnNOVDcr?=
 =?utf-8?B?c2xoQUt3MTR0MVNEdS9Idno0OFhhaGpwNzlTbnRZVWJ5ODhTMGQzdnFUb29y?=
 =?utf-8?B?amJscmdoS1puL055dmFYWmlPZTRTOG04Mlc5Tk4xRXFvRHNEc2RVTXhUMmlF?=
 =?utf-8?B?ckRNSXp4KzFwa1c5TS9Zc1dHWGdDeTBNdUdydjFXcTZxTHdxTUJLS3BkWklV?=
 =?utf-8?B?RFRSRmpid3lQR09Ra202RHF3aEQwUHhoalhQNnJkUkFGTDdtR2JmTHRpNlBp?=
 =?utf-8?B?cjl1UlE5a1ppZTAzUTArYkZWNUZuMy81b2xpY0lwUTFadFJqWjVQWEhCOWM4?=
 =?utf-8?B?Z0hNZmZsN0Nvd05qR1Z1YTNZWjJZVFNCTm1SK2YzUVYzaDFTTVR2TXVUWUsw?=
 =?utf-8?B?QmRseG5pa3VWOUlkaWNUdHNjNGNkc1JPRjFjS3E2WXNEZGFpbDFLcjZEUko3?=
 =?utf-8?Q?bkd/vSM7oKbgkbE2LLOkPHwFWBsLTQleA4s2kqr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3A0T2o1ZHl3QWEvc3BJQWVDSUgvL2JnNXN6TVBxNWllRCtBTDdxM1ZkR2Zs?=
 =?utf-8?B?aDN6U2Y5SDRyNXRyMFFYU1MycXc5TWY0WXFCTEhlWktqQ3BqcklvZGp1T2Vv?=
 =?utf-8?B?NWFKZkk1WEU4WXNIRjZxVHgyYzYzTUppZEF0VFVacFFKaFlNbnV1N3V1emxR?=
 =?utf-8?B?bDF2Snc0ZXhudVRXcGdzRDJYYXJTNmwrd0JRNktpbFMybGhzdkNMUWxLWm5Z?=
 =?utf-8?B?RlRTMkhwdnp6UE94T3VNNjh4WjM4b0c1QzBlWnA5UGl5RXl3V0dhQVJ5aTV1?=
 =?utf-8?B?cm95aXFCUEJsTFRMSGNoeVRFVDRBL1draEU0RmgvTjVMQzdCOTFCQXpJSlc1?=
 =?utf-8?B?YmZ2OWhhcmFoMHN4L0ZHUWVhSlFHbWREV3Y1djhuQkp5a1Q2M0JiVUxJbnBh?=
 =?utf-8?B?UHhJWER3WE1nbmk4Z0hjSlJMR2NFdG96RzhkaWpvdWZoZHJ3c3Z2L28xYm55?=
 =?utf-8?B?TVZZYVVzR2ZCVHJYdTBhbUVEeW5DK25TditncS9CTzhIK1hrSmx4a0tXajhE?=
 =?utf-8?B?NFhuMVh0d1pFN2Z6b2N1S2RjSnhkVlNYVklqTVpmeEZPalJEY3BRWHJkSk83?=
 =?utf-8?B?bXVxeDBuSFArQVR2bStpcFBnYzBvanM0dnFxcUE3MjdHejMrajZVeFVRcXJQ?=
 =?utf-8?B?OW54bEN5ZDhmckhRbzc1Rmg5Uit6OWdoZTlmVWY1N0lWU1R3NVVaMkxabytO?=
 =?utf-8?B?aUNiSU03SEw3NVZiVFhBWjRVOXJhOVpFbkpMYzc0bmZramNydThWcnNOU2tK?=
 =?utf-8?B?MzhsS0hZS2tXNWEyWXY5WVd4a1BTOFRjR0NydFhRR3lYZm5sc0dKQkVkOWVK?=
 =?utf-8?B?cy92RE5VZXFMZHVzb0R6UTdBbFhtVzlWT1dmTGMvUnVRajhSOHZCYWVxbm1s?=
 =?utf-8?B?VkpGeTc5Z2FmZjVLQUUyME5CaVBxMU1XaXhUYTZUZnZxU1pIbWlucDNwT1Nq?=
 =?utf-8?B?amR3R1lyQzZtOXZYMDRQS3g3Z3JjQjM0RG1waDhCdSthdVN6VlVPdmdNL0xY?=
 =?utf-8?B?Y1NLUW9qeWJ3RHdCajQwdEtBRHdEOG5CeEd5eFE1UVhRRFJwMHI0bWtVK2FJ?=
 =?utf-8?B?S0tKb0dkM3d2bWtwTElSWXhsRDBtTVhWdHRJV1BJRXJhQXZZam1rcW1VRTd3?=
 =?utf-8?B?TXNKSmQvSno0OXlkMTMzRXo4aXAxTTUvcGdsNVpUU3hFZitOVGcxVjAzTXQx?=
 =?utf-8?B?cVBhWWlselNaUklWdTFOVS8raVRwaTQ4dlVTdWZxZjNmd2h5RGFlcElkRDk5?=
 =?utf-8?B?eDlBTHArVWpkWnR0dERsQjBaUFJmWWxCT0crNUttVlVoRjFIODQ3NGcvN09q?=
 =?utf-8?B?T29PT0lRQTJpTGk2bnJSaUpMN1N5d0VVeUlvYXJYeDBFTkU4QTZYUmVsL21O?=
 =?utf-8?B?UmFadUhXUmdwc0tUSzE1bHFpcWg5Y0lMNjd1OEdmVUNmQVFzYm1GQTFiemtL?=
 =?utf-8?B?eWY1S1VKQjFXcUNKV3oyZ2d5WEtOa09ob2ljWmNJZDdlQ2VMOFAvV1QyTi9S?=
 =?utf-8?B?MWdmT1lxb2s2S3ZmV2VTdWd4MEx6QmlvN3pxTmtseGd1K2pkemZEOHRndHlG?=
 =?utf-8?B?dkJlOGZUVnZZcVo3SEttbjFKS292c1J5dmZ0NnUvd1FIZjY0eUFqQzlqZmt2?=
 =?utf-8?B?OE8rU0srVHM5TXRySHdqNUVpVkllZG95VmpLcEhQTC9YM3RuYzV0bFZsK0lp?=
 =?utf-8?B?YVJPRnQrU21PWENtaUhpOUMwL2xJcmh6UkJxTFI5NGcyOURUUHFOZzNlbWs1?=
 =?utf-8?B?cWVkVVNzZGdwNEtXS1pUREJiZlh4Q1RjWWgvRlJWMlhlYXdOTnNRbFhGMzV5?=
 =?utf-8?B?UmcxNWtnUHhFVXI2V0g1ODVJVkpiSHJMM2NYQ09PK1R3YzZ0MzhxdGR5M21Z?=
 =?utf-8?B?VmhhTEZpK1doQUkwdFZSRHUzdmdpTE4xRlp5eC9mRFlqcVJWUlhrS2htY0Z4?=
 =?utf-8?B?YnlTMGM1WjF6cFRWMGZpZkl5M2hqU0p4Q3FmRnoyU1ZodTZYaDdCU3VHaEdG?=
 =?utf-8?B?eEZRNUhLZEZENllxRzNWYjIrUVdIQllsSUlmdjNZOWRXaHo2T1lQZVpnZjV4?=
 =?utf-8?B?WjZqYWQ5a1lLblRnMHpiVThHNm02Rk9JZ3ZGRXAyRmJ3WVQyM3lkRGgvcVNS?=
 =?utf-8?Q?/gLCMpija27H1glzY+DFHIbOo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15f1cd0-5bb6-4c1e-5dcf-08dcfe988df4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:23:55.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2KjKJAFzNHOHLRl48tzULsLHRSwPPdkltcoMen71MVmvkt8mtx75z0H4BwVdoVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589

On 06/11/2024 13:49, Yafang Shao wrote:
> On Wed, Nov 6, 2024 at 5:56 PM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>>
>>
>>
>> On 06/11/2024 8:40, Yafang Shao wrote:
>>> We observed a high number of rx_discards_phy events on some servers when
>>> running `ethtool -S`. However, this important counter is not currently
>>> reflected in the /proc/net/dev statistics file, making it challenging to
>>> monitor effectively.
>>>
>>> Since rx_missed_errors represents packets dropped due to buffer exhaustion,
>>> it makes sense to include rx_discards_phy in this counter to enhance
>>> monitoring visibility. This change will help administrators track these
>>> events more effectively through standard interfaces.
>>>
>>
>> Hi,
>>
>> Thanks for your patch.
>>
>> It's a matter of interpretation...
>> The documentation in
>> Documentation/ABI/testing/sysfs-class-net-statistics refers to the
>> driver for the exact meaning.

I think this documentation is outdated, a more recent one is in if_link.h:

 * @rx_missed_errors: Count of packets missed by the host.
 *   Folded into the "drop" counter in `/proc/net/dev`.
 *
 *   Counts number of packets dropped by the device due to lack
 *   of buffer space. This usually indicates that the host interface
 *   is slower than the network interface, or host is not keeping up
 *   with the receive packet rate.
 *
 *   This statistic corresponds to hardware events and is not used
 *   on software devices.

>>
>> rx_discards_phy counts packet drops due to exhaustion of the physical
>> port memory (not in the host), this happen way before steering the
>> packet to any receive queue.
>> Today, rx_missed_errors counts SW/host memory buffer exhaustion of the
>> receive queues.
>> I don't think that rx_missed_errors should mix both.
> 
> Thanks for your detailed explanation.
> 
>>
>> Maybe some other counter can be used for rx_discards_phy, like
>> rx_fifo_errors?
> 
> It appears that rx_fifo_errors is a more appropriate counter for this purpose.
> I will submit a v2. Thanks for your suggestion.

Probably not a good idea:
 *   This statistics was used interchangeably with @rx_over_errors.
 *   Not recommended for use in drivers for high speed interfaces.

