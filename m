Return-Path: <linux-rdma+bounces-10681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84976AC3372
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0518964D6
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B701EB5E5;
	Sun, 25 May 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GVl8gUPb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B431E834B;
	Sun, 25 May 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165707; cv=fail; b=I/HBxuw9/MnTXsPVqYCCTIjb9Z3DAjQDMalL7s15QSMgOJxqxKO4OUYkxLXY4KSBptY3Mg+BD603eK0tz5Wml6l9r5KMjGfdt7FqzhUsTFY9io9FvCma9VJTnWcYDq4Eq2Et3791erd9p4jPzP9Wf+UCkbBsks0qpCyiOwDP4ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165707; c=relaxed/simple;
	bh=/Vz4R/sLw5jiVBCxVbTh4xvS8EKs+t291xLuwo8AF8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htSKd8Qg+MrdJ9qujEgKVipM9Fy4p332t5aCqtxKhgBD9pYpMG9We9vFnfnoDqp433atL0bsa0CgJZAvmP/928VUQzPPI8iU4S4grdQO94KGEMKKzUQzFqewHxTmmubi1qojoY6yg3dXFNU1x1YEa1kU1+wwbaOSbPkSx9J6prk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GVl8gUPb; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX/f3pLrks/B7Jc/ER3z0zuMbg9yCjmcyLfy99jkWPIJDtMlSCMFPmLEZKDpJGog0JxY+4hTL6MwgTlkNiZjahjvyR1djSvxv2G9AMxYKYUdoCmAKRSTEFayfx8BRB/MQUSHNC55e2o15z7P2bfB0Q7BqzSHu06kdcx/VQ5SzFvwku5P3U3+gWyzblpjQCSA0/krAivH53F0C75FNbiRqDrjLWBotyKu3E3/++eHBapa9OjuScq5ULm0IbpLb0pRxRXNZA3uosR0rxB+Yev1b7aQmI5ipH4Gpo80fr/K9O1QTB7pdujh9MAgPed4Udssb0STeBHc6Lbr/ThaQGhTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLh1zS++Ru+7Z0opMYolxnUdlv2tObbu1N472PY5byE=;
 b=Gfkn2JcKaVNPzy58np49tLB4Gp3JCMraMA0o3ReoycR1JCx8pFsx0kDJysUE3R7CyzRAdAzs6XKKMKsVyhgstEaWlK0LZI32sWy8Jq3jYdysx80C2TmSJBuQ5b6vf1ApORrPAO0v080nPJnneW8R2Ph5uxvOYmPnG4OptXYgJRXuhmKehWIVPSCjc6ptnmDNSfIjumcVMmxNTzxLynCGlPTO4fHML6mVgCWK8aLZWlrUKd4R+Ev/dc/nhs2brU9kD1MTzL6XqMQC4RU4KXOoukdy1t0nE8ENDMN8MqUA8JAqdQeXJ21G3wvE9/wA3iAEa06RNpHkc5MqcmVw1YnCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLh1zS++Ru+7Z0opMYolxnUdlv2tObbu1N472PY5byE=;
 b=GVl8gUPbKz3jhuulOt4V8w8nxTpHDO1K08NsysgK1ufMmHymXvZ312obI53CUg/1pn8bu5N6kz8p5KTimAviViZ9xMIRcnqgNNeec6Ove98QpI5LWIXVL9k0NVbzV1QCkiZpoSZMVSvSZBTEs3zQMIn9yCPvI96sYLd5NxALSnvxQAYBxKlYNtMh2Ua28IU/ESESC5k4u/jPPm9jujRHOf9Kv71Xg2EWf6qXr9eUu4Zg3aEv7YV8IsFbD3lfAiCSL0gXr3grZ6zbGzfvRfJ14Qt2vB2yblkQAS12/JsImcK9iLV1JNzhJ5v4d5fO7f+UQ7AUBL3e6WxGG9DN6v994w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 09:35:00 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8769.021; Sun, 25 May 2025
 09:34:59 +0000
Message-ID: <a8c2fdae-1de6-4b1a-8da5-23f4a653b074@nvidia.com>
Date: Sun, 25 May 2025 12:34:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: HWS, Fix an error code in
 mlx5hws_bwc_rule_create_complex()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aDCbjNcquNC68Hyj@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <aDCbjNcquNC68Hyj@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0032.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::6)
 To IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: daba21c9-1994-4951-485a-08dd9b6f6adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlA2VDVsOFpqWkdDY1BOMUc2VlBFbkp3cHdMRU9yRHdESzN5WjlDRUZFdmlr?=
 =?utf-8?B?V0ZtUGVKM1VHeWpjRlZKZy92NGVIcXBxS0pHa0grUTRZWXVGNllpVE9FMnZr?=
 =?utf-8?B?ZlFONHFUMzIvODkyRkdZT3dpK1JLYU52T0VxRWtzZFBXK3ZrMlg5eWhTYWtN?=
 =?utf-8?B?NVZIYzJBTlhWMHBaVHNQWklZT3hPT3RhWlZ3by9aSmR1M056c3dJSDljT2Ja?=
 =?utf-8?B?YkhDcGZwTXZtVzhkQmlOQUcvcjlhODJmQ0dtVnRldGc0K0IxZmhyNTdmT3FK?=
 =?utf-8?B?RHlnZjk2MUtlOEVSZDBQTnluUHlUdUVvUEI3bXVPTmg1R3lUbWNTQUZITHpr?=
 =?utf-8?B?Si9sZFEwRVpwVWNEQ0RnUFdKYVdVaDNWcmZvR0xHMk1jUXYzUTdTSnR1Tm1U?=
 =?utf-8?B?UzN3aWthbXdHTUkxWjlyRS9waVp6bjROaFAzenhNbXMwS1d4OTd4U0RIdzJQ?=
 =?utf-8?B?MkExejVBVStpS3BqSWh2YzJFbkZzdkJaU2cvZmhJems0eEZiTHRLSWtMQjBY?=
 =?utf-8?B?VkpEVHd4SFZDU2gzcTdRRCtMN0NJWlVOby95ejZNNndJR003dC9MLzdWdDJh?=
 =?utf-8?B?dVdySVBqZlcrT1hIUVdVUU1LY29HZUE0bURnYVZpWnZaTzN6SXcyTkdqdkVO?=
 =?utf-8?B?ajZ1OHNiaVJOUGhhRkpkNmdrYUh4TE9NcG96L3FickJERDQ1RmkvRDJWa01v?=
 =?utf-8?B?ZlZ4VW9YbjJJRW5KUXUrSmh4RlREcmdHajdCL0xZMFU5Qkg3c3BLSGp4ZXI1?=
 =?utf-8?B?bEFWTm9TU1Q0WTBMWHFCUHZyQVlNUHNNT3BBWDk4aWlzUHZnRXhyNWNOZzd0?=
 =?utf-8?B?cHlHdmZiNnRMNm5aRHBHK2dvb3dqSnRJTW9Hb0Z4STBUc3ZrVU1tcy9MOHN3?=
 =?utf-8?B?aWRzUVF6b1ZZWDlxMWFYNFFwaEhxYzdTTVkyWWk3OUQzUXBtcUtZdXNWcjJr?=
 =?utf-8?B?RFJHRXFHOFdJUXUvOEJEdE4zU011M09DVUVqWG4vNUF5Y1BFZnlYMXRmNkJh?=
 =?utf-8?B?eWFkcDBpczR1Y1ZmMEF6YkJkbW1YSUE3dkhkNy9JL3FLVmJLYk85V1JJMCtJ?=
 =?utf-8?B?RjFmUmVFQkd5ZDZ4Q0tCeXhkVEJ0UldFRkQrUjZqc3hEUEY4RENudVJNczhP?=
 =?utf-8?B?aDNxSWJaQkRCdkRkZGl3M3ZPdCtHdm1NaFV1QXgxaExLSkdGdWRzZWN6Y1A4?=
 =?utf-8?B?VDNBcnNBRThuUWNRelBkRkVicS9mYVlmS09wczcyL0VGSjBGRGpwN3lMcTJx?=
 =?utf-8?B?MmgrTXhYZHBBWlUwOXlSbmp1UjVPZ0t2RjA3elErY1VTNDJMMkZNZDdRYWhP?=
 =?utf-8?B?ZXQvZDkzZFlBcmNrdmQvampyNjdrTkROTUVKNVhMWktOWVoxR3FXcGxvTFdt?=
 =?utf-8?B?ZHZYV1Rlc2lQd3d2VnJqanJ5QmR3TmRScDNsR1lsR0w0cG1veFBERFdVeDQv?=
 =?utf-8?B?QldwSlJWV21mS3huTFZUb29BalFQVnhqWldhems5Ti9vMnlwaHYzZlFGeWlv?=
 =?utf-8?B?QVV2QlM0V1N2eUlDdmtGVm1TVmRTNWM5Nk5aZGUvMmhCY3praFNVcHVjNkZG?=
 =?utf-8?B?WHVDdUFwNHIwcUFMdk56bzRxeXk5c1JwR0d3cGRzWEpVc25CcDBRbG9KNWs3?=
 =?utf-8?B?MVdTTUlkSUk2NGc1NHVKd1RnRmlNVDk3SVhWZTBqeGdpbXJSTXZNUkZyL2Q3?=
 =?utf-8?B?SWtGcCt6SHloVEFPcVNRYVFlL0J5TEhVNmJ4aUV1OTVOZ0p3RW51b3dLQysr?=
 =?utf-8?B?WmpkQ2czQUZUWkpaeDVRTjBmdVFSeXR2ZlZPWjFqTjZEelQ2aVRjaDFISW4x?=
 =?utf-8?B?K0QybGtwUk93c1c4Q1NJYmYrRFJxZU9YYXFHVnJyL1BGSDZJMzhQbUp0VVM4?=
 =?utf-8?B?azVIMjd1c3dSSWRUVGhvdzJJQUxOTklhQ0FnZTVORWMxOWhNMWZSU2tWZk1C?=
 =?utf-8?Q?B8ML9FckXLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmFvSnk3cHZ4RUxPekcxeDg5aUthZmY2VTMzTjdJcjloKzhqazBFb1Z4TXFM?=
 =?utf-8?B?SFR1RjRHN3l6NkdSNWJSamtnWVJBZ2Y1bG9vSkk0NlYvQXJrM2JLd3ZDQzlP?=
 =?utf-8?B?NFlRanNMSk42SDBQZmp0Mkc4QUFWRS82Q2Mvbkl3WjE5aWdxZ3RvcVh2VzZ6?=
 =?utf-8?B?ekZmYnk0dE5NU3BRQ1ZzdU9hWDBNS1lRUkUxQjBYL0pUNlZqRGUrelk0d21D?=
 =?utf-8?B?RmNySFJPeGJHcklrdmdUVmNkaks1L1p2V0ExZUVIeVh5TE4rN1RMcjF0TjQy?=
 =?utf-8?B?VTF2Z2FLSGJOS29UYnpzdHloSGJBY3llSGs3bW4vdTVWMTh2SExzRDlmbGlP?=
 =?utf-8?B?d1NkNXJXZCtpUmRjZ3RIZHl0VnByUXBXck44WGljYXR6T0N1RUJIZ2FVd25x?=
 =?utf-8?B?RWRwRkR5S0E1djF2RUsvTlduODdHazJoamNIb0FOR2tVbUNTZXI0RzhJV2px?=
 =?utf-8?B?c1lYTUdNREhMUEMzRFBBQ2RsN2VVTzlqemVtR2pnK0xQNHc0c3ZlUjRSazBE?=
 =?utf-8?B?NDhBR0RIbFpTZW9KOW9XNi9HcDluSjZLL3hGQjIxRG1QQi9idFZ6Ykt5RzJz?=
 =?utf-8?B?d1VvMDBqcXNlbjdSUk9rLzZwaGczMWhhTmpobWMwdWVkYVNxT3ZjaEw4NWM5?=
 =?utf-8?B?bU0ybS9oL24rS1puYmNzN25ZNjlsSnRSMWR6c0c4WWhYTWkvdjBncC9Xb0lP?=
 =?utf-8?B?UldnUVRSaEFDMDJ6aS9qWWR5ZnozOHVGY1BzZThpK2dPcnZNWW44aUtTTHJM?=
 =?utf-8?B?eXdOYVRLWkNMYVJyVWw4Q2FaNE5WaWVEcTVRaWkxSllzL0RWMlpEV0hHdlZ3?=
 =?utf-8?B?eGhxaW9rbDZaeU5sOXJDdkh6a2pQcjZ0b1RXN0R0OEhWcithb2V1bWhyRzNz?=
 =?utf-8?B?a1Q2cW5UQnl0SnEvTDZkMjlCc2RlZHZwL2hBVVFDaU05S1VZQ0VCWUdWNUtz?=
 =?utf-8?B?VnIwK2RNTjVUVU9YcUo2aEMwNzZJQ3ZKVzRnVEdnRlRlcWtZdGo5TVJZRUFw?=
 =?utf-8?B?VzlzQlMxUXhncng1OFB4VXJJZTkrWkRJOE8rd1FvVkJzeEkzWTE4YTE2MTF0?=
 =?utf-8?B?SzNlREJQNzU1QUhhOUtndjBydC8zV3ZrTm5WWXEzYUNPN2xqb1ByUlp1U0h0?=
 =?utf-8?B?cTl1QzQrZzc0QmhrVUZMS1RrTVJpYUo1c2tqREpNUHJ5S2xVMHpObGhhaXFq?=
 =?utf-8?B?aGUzL0owZjYrbSt2RlhCM3daWUk1Tm9KTjlsTk55NEpTN0swMGZWK2xTeEhx?=
 =?utf-8?B?QW95U3Ryb0N2SHdzUTFrcXVnOTZkTGtWOXRQeWt3WnFjemMwSENHTXAzeUlh?=
 =?utf-8?B?dTQ2alk1bTBUQmI1VkVtbGF2cTNPQys1WkVDTUdBYjBFMVlwMWdxdVYwQjlP?=
 =?utf-8?B?ajVQakIxTHQ2eXJhMUd1TjdrNUx5UFlaYXlFdjRyS1JERnpZcks2K3BsYkVF?=
 =?utf-8?B?ZDgxYTl5aktVeGtuTlJaVTNTSitJSnlOazFiRHlQWndJRUMyeTB5ZysydHYz?=
 =?utf-8?B?aGRjRlZQS0JTc1JXb3E2VmNoZnltdGhvSjZ5R29JK29wc0p3ZmVLbDdRcGxi?=
 =?utf-8?B?THVwZVFKZW1PU2ZBeDJxRGZBREtxVHBTY0NtZldhNit3amNLd0krWXlUdk42?=
 =?utf-8?B?RUpjYXBOWDZ3M1BuNEFMVGtZbFBQYWVwbTdrRFl1Z0FNQU01cFdsV3RTUjJa?=
 =?utf-8?B?SXJNWEtBeUl5NkNEa2Fnd1BqVU1CREdqdkFLQ3V5Q2VRWE9IdlB0blcwbDFM?=
 =?utf-8?B?WVZ5cUhNdjloSWlpWVRxU293dzVuT0IxYnhxRzJhbTdia3FVZXoxL2hjVGZ1?=
 =?utf-8?B?YVpJN01BTlZuSHJ1Mmt1Q3pxUHdLTzVHbXFCNkI3WmpMYVlaeWtJb0VOWnBZ?=
 =?utf-8?B?Qi9QR0VRUGtLVUdRUVhLWkZ4Umd2L1RuU0g3RThuKzBUeWVpdVBTWVQyQTha?=
 =?utf-8?B?VkRLMk1nS2xGU0czNnQzeE9aejNFN0pteEJraGZnNk5ZcS84V2dYUGVVWUZ2?=
 =?utf-8?B?V2F0ZmE0NlZYU29lQVFUYjl4WjlxYWhCT3pCVWRwYUVmQ0REbE1sZ2hlTmc5?=
 =?utf-8?B?NEtmT2lUT0JvOS9JeGNTUE4vVm9RNmhLV0xPaGM5ZUxNTmVaT1QwZXpLMVBT?=
 =?utf-8?Q?VxM7opfoe6krY9FrOdiQ2KX8X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daba21c9-1994-4951-485a-08dd9b6f6adf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 09:34:59.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fml/zzeUDXrSZpFu3CezJfTbgVKooULgE81kNIeWurvPbWIgPz9iOLvvKSyi5/K91RSpRx/NpJm9EXf2Mim8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207

On 23-May-25 19:00, Dan Carpenter wrote:
> This was intended to be negative -ENOMEM but the '-' character was left
> off accidentally.  This typo doesn't affect runtime because the caller
> treats all non-zero returns the same.
> 
> Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c  | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> index 5d30c5b094fc..70768953a4f6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> @@ -1188,7 +1188,7 @@ int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
>   			      GFP_KERNEL);
>   	if (unlikely(!match_buf_2)) {
>   		mlx5hws_err(ctx, "Complex rule: failed allocating match_buf\n");
> -		ret = ENOMEM;
> +		ret = -ENOMEM;
>   		goto hash_node_put;
>   	}
>   

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>

Thanks Dan.


