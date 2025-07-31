Return-Path: <linux-rdma+bounces-12559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10744B1765F
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6409D1C20FDC
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB823ABB1;
	Thu, 31 Jul 2025 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHzeKkkh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A178A29;
	Thu, 31 Jul 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988598; cv=fail; b=e1TYEHf+jU53YS2uhUE8JDwld0FqIlEKXYPPT9OlT453GEHy+sTiMBHXFIZPL5/jI+cfAVoFVbPZuNstMMb7DMzNoKglJHQrSw5YYdoEfB43Wcay6Teqx67WyuzbsXcbQE1s2fyRvUAy/Rj0f5mySKJ9De8XJvAeLEeykJaCPWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988598; c=relaxed/simple;
	bh=IsAmynk3EN97XfbJsgLkT09M5RIxH6AyM3iNwrdCXiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0+TWTye9FlgfUBF1HiDcZh26gPayfKQBQ109bQzpyLZBzDzIrLVDRXIg44oiyQ6ZLPfsm4k6U656K790DFdPP6ZGbCF0q2Ce/ifFpuRUW6D2pNrEeUEZOuC846fxubdSBpr6a2L7CeYwkT/QWlOSqRQu1lnvOtW7eZxrOGnXII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHzeKkkh; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPHGEAQY37RZEwpQhfoSxYU83XFeEVu12rHIiU0eUPumagSl1FFSzOP85SUpGkbcGi5iAIZXKUJkFbfYS2M2L123vhMnYs+8m7EoMPFm19TZhykSJQdF8svMjKFqSt0EsS1HIefPsmzOPjaKi5gXgPL8HGn/8LQboImJUOIJNtb6aKGACOOu0AJne/Pvkn72qygpwCZQI7AX8tL/rxKwKLxd2Ve66RpGK9ZfIYGdh4nWDWsCGmD4kgIP6kTR6WkMBTt//T0UfyjjjCx+Sa5kPgS7xsDmJWj6HL7uacvbSnzsrphls38VBAqscWQvNLIiu/goLeAlwCx4Kwn2SGFalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdG54YsxnXbPUwOc7YdNiFJeFn35aUeSl0eTXWfg14s=;
 b=OZSK754GgKwTHPeNHZF1OLuyUN7RsYo4CUiNOz5I3IzufwSlitvDwyz2icnsreB7TXAt9yKZYQfUgDyIIFHllhn4ZIVhwpm/KmxiYkl/H6P5p7wSznfUf/K1XyzG0DiucBr77Xuq+SKSRyuKBVcf5ozE3LhQQ3t5IeZ+f9xG+5h+yQxKfJBtUmAR6ZbcpGSkdl6OxgxcrG5s4PXaJ0t/l7SOhQD5oVw5si09ZTgJIQrJcdGygHhK71A83Rnt2w6VBqKiQOe80XrJzy83sxJzFXNIlgz73ocwEz1eNxwAjoX4X4qwe69Dp9jLxxvDzeKePcmp4MKsv8vES0drMu5E9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdG54YsxnXbPUwOc7YdNiFJeFn35aUeSl0eTXWfg14s=;
 b=qHzeKkkh6W9s/Jq2cBRNrLjbSApfcOL6+VxHsUKQ6cnsm7w5VO1zCs23f7o29DoMsiQ0e7SBXVykmAEWsRq5YpyHSM/tGasG3NelMs2V8vTxYI11HglB4ZjuydiGdRxY7qRlKjzly7PPA6Y9RHOoLkBjjwWU984eEILIcW99I7PTA57oqKtm93GUIqRZJ1a2+CWDNjr4o8EDesO9ccjsW1roQPKK9R7muLO0TUz0xHq95SjgjGhNxEB06sR+O+F5QpWuLz0fwb+bTCwGBjM43o9YhbGlrDSp6rG0h4l9OrEgX8O2XhKcUfJav74WXHZkzHCjM9c0iC/xhso1ljFoKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 19:03:13 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 19:03:13 +0000
Message-ID: <c52004ea-16dd-4131-b58a-4a7f7c6be758@nvidia.com>
Date: Thu, 31 Jul 2025 22:03:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <20250721170916.490ce57e@kernel.org>
 <0c1cea33-6676-4590-8c7c-9fe1a3d88f0b@nvidia.com>
 <20250729154012.5d540144@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250729154012.5d540144@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3206fb6b-7e10-4444-be15-08ddd064e611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmIwQzcwNXh1Y1c1eDZlQUpIWGhZYXNjWkRTa0FBY25kd2c5SEptalZDd2dK?=
 =?utf-8?B?OVVwVTQ5WG8zbmgycm96dGZVL1p3clRYbTNCZENzUGJScjN6R2VnSGtZRCt6?=
 =?utf-8?B?TEp5Qk5LL042S0hKNGZvbjA4SGJqK09wakFGOHd6Y1JjMkEvbzhPbFJ0R281?=
 =?utf-8?B?WFhGMzN5NFRaV2FaUVdZVGtnOW1EelVKbGt5VXRvR0V2MVhhQWowQ1pMSGl4?=
 =?utf-8?B?UDhkc2VzaG9weE1lNS93QnY5U1VjYkpMM0lQRG95cUJmYlZXdGlmeVg2bE43?=
 =?utf-8?B?R2lqRkJOMVJmSUhKWFpsOUxoa2c0N3dSZHgydWlMWnFwZHprK0Y4azQva1FD?=
 =?utf-8?B?bG5QN3hQT0dLRXVwcTNhY2dVdkRVN3lIcUZTb1NqSlFPY2ZyV3J4dFBvMjlX?=
 =?utf-8?B?cS9QTDZWanAwNmNaMC9FTFRlQXM0KzlwSitKTEtXaURYenRZUGRLQkY3emNp?=
 =?utf-8?B?WmNxZU0vSUcyaFd3QU1XSGlubzRna3BVVDJFa3A4THZPMFB6d3dmTkRLYnpZ?=
 =?utf-8?B?L1YrTGZFVDBtNi9pNXFzRjJUNmsrSERJbUhkQUkxamJwUGJuSUhxa1BmTjJM?=
 =?utf-8?B?bFo2S082dVZGMlMyZVNoSGFpdDhqUkp6bjdRUkt4ZlJVQVE4SVV1Z2sxRzJF?=
 =?utf-8?B?Ukk2SklyMktCL0FpTGJCMmovMUd0U3hwMGV1YmNrNW5sWEh2U1oyQmJXQzRC?=
 =?utf-8?B?ckE1TUZZUGZKRUpHQzNEQlRmV0JkNHBVTUgwNndWMlJ5SEpKYzhmNFBGbklI?=
 =?utf-8?B?NEhzdjZEaGs5cTFiRmZKNzR3dEE0Qm5CbGFHZTl3WG9ZN1BUUjZzM0ZFdVE4?=
 =?utf-8?B?N1pqcTFKWHlYK1MxdlNkYms0cG83Ly94cy9mTTlvNzVMZDJOYmhYcWxVQ2tZ?=
 =?utf-8?B?SVdlK0ZWYUIxWFBtYjBpUGc4WnAwcVVjYTZudCs3clBlWHVUNitNQ3ZNcXNa?=
 =?utf-8?B?RTlCdU9kS0cwQnNrVHh0WU1hdzhQSVE5cndUNWRLZFBOWWZFbEFGbVdlUVVF?=
 =?utf-8?B?VjRueUxoVXBNdzE4N3hUcXBSNTQrV1UrcGxZSjhYbVNpZkpPK1dCZHhFNkpu?=
 =?utf-8?B?YVNEdTlWVWIwVnh4WkxkYnVYTXBuamFib0V4Y21RWjEzelo5MWlUUnZmbDZN?=
 =?utf-8?B?VlFySVNNYlBjbzIzVnE5clRPU085UjI3Y0lXTEFMK2t4UDhNcUZVZU5Kaldn?=
 =?utf-8?B?Z3g2YlJBRGhhbnY1Ylp0Q3l1bEwyeTFCTk55d29mcytzRmpzam1GUWl4a3Iw?=
 =?utf-8?B?aGRkajM5ek5pRHUvZk0vbm9DSWpQejBpVlBIeTdOa1JRNHJpY3ZuSFZKR3hz?=
 =?utf-8?B?TnF1RUV3NGk5eFdEWGE5TWt5YjRyNCt3cWxzdE41U0I1bTRRN0I0VmUwR3F6?=
 =?utf-8?B?MDJldFB3emo4bUU2Y0R0RHJqOXNmWFVHM3dtTnlxbWVDbks5MVM1NDZCdVdC?=
 =?utf-8?B?bHAyNFBub0JrZE03UVJRY0hBSnI0N3hqaGsreVpmUzQ0ZjBIYmxPUHhKWFV4?=
 =?utf-8?B?OERzWm9WZHBueC9CYktDNDg4L3FMWGtlVFJERVNEWVU0WTExMS9FYjZvODRH?=
 =?utf-8?B?eGhPTFREekFZYU5LbU92RGJ3emJBRWNDOUJ1T1V3QkE5NGNuV2xIaEJoS1dz?=
 =?utf-8?B?dzlHK2VEZ09haDVGVXFncHZzTHJhQjEvanc3TE5nVEswSnY5MnFMalRlWE5y?=
 =?utf-8?B?TDR5dXR2ZVVlUmdMN2Z0bzlvMnRnVWFIcHJaSVdxaXJsR2wzMk1ud0p3eGxP?=
 =?utf-8?B?WTVESjF1SWFmWkN2RVpIMHNKNW52OUlVeCtBNStjd3FGUzhqZEcxTTJ5a2c3?=
 =?utf-8?B?K01uSDNxelNUczhzZFhnVG1GRHJoSUNvUExLbjFKa3VoQWJFaGZOMENyOERT?=
 =?utf-8?B?bXhGanVYRlJlSU9uZTZSaTYvSHpRRDA4N0QrZklEUTR3OUxqMnd2bEJYTnVn?=
 =?utf-8?Q?MhXg/chXNbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdaR2xkQkJwYURycVpoWFFYSXVWcXVyd0c5QWJtR3FGWXFpTWMxQ1l6ait6?=
 =?utf-8?B?WW5OV1k2bDlvYmNQdEZJbkFnejhQRXFVSGFNUVZIRWZ6d2VUdjNyTG1ZRkly?=
 =?utf-8?B?Zm9la2M3REloejhuSWpYOEZWdi9lL0thZm11NG44aHFjQld0OWw4QThzTHJQ?=
 =?utf-8?B?K3M4MmVHU1B3MjJFNW5Qc0hDZmg3VU1YYnpDVDhVWmZRVkpodVRydnJlQXpR?=
 =?utf-8?B?WURnV0lJNy9kcjhFWjkzREZqNTNaa3prTG9KblZlcVZnYUVRREdKSmYrMzdB?=
 =?utf-8?B?Vlg3dmNteC90cElCVTJUMDY5K0J6Z3pSaklhNmZZTHhsQVQvV1IyYXpZQWFO?=
 =?utf-8?B?eHRwZExyK1pGUWo0b0RuSjVMcFQ1TDUwUW94MzFwS1VOUE9kTURmOVlkRUdO?=
 =?utf-8?B?cHhmdGg4cHU3RWFtREI2U1RNcWxRM0dkUE02T1ZrdUxvc3NxTkpNRTFrdUwv?=
 =?utf-8?B?ZTJIS0JzMW9CcU5ZVnZqNzRVeU5uV1o5ditjOGEwaHVSSFQvcXNZQUhPV1dB?=
 =?utf-8?B?eXZBK01tZGE1TWNzWjlaU2xDUStJMS9BOEJLT0Y2bUJNVWlaWm1tbjYyWklJ?=
 =?utf-8?B?RTRkbUVabmExTm1GU2RHYmNHRVlOL0Z4VU1qWXpuN3ozNHc4MGFmSjhzL0dM?=
 =?utf-8?B?dzh6WlEwQi9HaUg1c0RHNTZYeVJibHZYZ1pFbjJhS0lhYUE2azVyNXN2a1J6?=
 =?utf-8?B?NDVoMkFESU5RbndIUG5tU2JNOXQ5M1ZYQkw0clp3Z21RNEcweFRHRHZyeEJp?=
 =?utf-8?B?U3VlM0htZEEwdW94UjNsRW5GdU9GMVI4MkZWc0NnQ3ppbWowUFkwdkduU3RC?=
 =?utf-8?B?ZEZNSXJrby9mTENYam9ERTM3bGxGUTdXbEdtMlVNL3dleUY0YnNKQUZXT1pH?=
 =?utf-8?B?SGtNYWVRR2h1anZ3UFpScFNjWC9WY2lNaFRQcUxEQjBMdFJsU2RBMnhscDhx?=
 =?utf-8?B?NnVURWFHMGtveDhmY2FMM1ZKS0YyRHpxZUtzL095ZlVrdHdXSlVncXk0aHho?=
 =?utf-8?B?WHNnZjhCbE5WMlZEVkM5enYvR0VqR0JVd0RLQWtxVWRZMjhlYis0dFBCZTYy?=
 =?utf-8?B?T0hsK2JSdkRuWWRJbVY1Zys1aEdpNm5yT0NwQkhDVFJEdzFHcFpVZ2xSZ1cr?=
 =?utf-8?B?UVo2aUhmdzBTWnM0UVJDZWZJak1PNWxSL3RUZVk3WjJTK3B1MUhRWEFGdEc2?=
 =?utf-8?B?NmcrdUNWczdPRVZXZDd2S1hVcXI0UWJjV0VsMXF5bUI1VWx0RUMxcnNTUUdt?=
 =?utf-8?B?dGZWS0tCVjRDVk1aL2VhNytKYzNpK0d4eHA5WVQvZnFMUkV6YjkzZWF4NVRS?=
 =?utf-8?B?QWdzaVlvaWJLamhtcm85ME03YmpPWU5iNnlrRy9pZytxTkZ5SG96eTBsczYv?=
 =?utf-8?B?c0U2SGsraW1YL0dXS0xrd2ViVmVvdDdhdXpRR0JwWWNGVy9Rb1dGN3ExZkJz?=
 =?utf-8?B?cTdVb1oxc1V1bmpYemZXYzRYWWRrWmw5VHljUjVnVC9JM2pMR0lLUk4yQ3Vj?=
 =?utf-8?B?bHRHQ0J5R08wWGk5Zk96TVZPMHVjSEQ5UUlLZzhHTHlHdFRVWk5xUGpqS2VS?=
 =?utf-8?B?UUJkb2V3aHorTEZMR3l3d1RLamdzZEwyYVVHSjZDbW5aUVRMYXI4RlpURXN1?=
 =?utf-8?B?WUR2R0Rxc0RkV1FKcjExckdWSmkyRUtETm8wNWlsV0dXY01KbEl5c0JRRURi?=
 =?utf-8?B?d25zK3ZnSW9oc21sUzBuSDRCenh0Mkx6eFBrR0haL2dHbGJuTGxjNUpibHJB?=
 =?utf-8?B?UHhoTVM3dlVYVjlzVGxKNVo3dmdKNFNkelZ0V3prY0JQb2NyK1o2QUtIOFpR?=
 =?utf-8?B?R2NBL05OYnNRZXRkTXN2NHpNTzJERHNPN1FpSmtVTThPYTZVMjFHam1rNGhY?=
 =?utf-8?B?SG1CU3czb0h6WklQWWYwWjY3QTFrelpWMktScktybllQRGpiMVdrTGdmMTdZ?=
 =?utf-8?B?S0JMdDBzQU02WW9HeVhlbzRNY1F4dG5ycDZSVDNjY2FnUVFxTGwzVHVVckFT?=
 =?utf-8?B?MWpPYU4zMGU4ZXcyT1ZUc2Q4OG9nRFZhVWVJYkdtZUJHS0pUU05hVWx1UVFJ?=
 =?utf-8?B?SWV3SVJCbXU2d1A2K2VrVE9sQnIyMkhibm5kN2lsL3B3MmNoVnpWTXhRa0wv?=
 =?utf-8?Q?eTnu1l6oyZoLrSt9tM7rotmPg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3206fb6b-7e10-4444-be15-08ddd064e611
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 19:03:13.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz9c6VUTCjZPS9pxw71lQEPExaETYodTAQMZ4feflSrQkRpBOr6o6lMcJRkqQnTnNMqtLm6uo7CdGqL1FDlz2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357



On 30/07/2025 1:40, Jakub Kicinski wrote:
> On Tue, 29 Jul 2025 09:57:13 +0300 Carolina Jubran wrote:
>> One concrete use case is monitoring the frequency stability of the
>> device clock in FreeRunning mode. User space can periodically sample the
>> (cycle, time) pairs returned by the new ioctl to estimate the clock’s
>> frequency and detect anomalies, for example, drift caused by temperature
>> changes. This is especially useful in holdover scenarios.
> 
> Because the servo running on the host doesn't know the stability?
> Seems like your real use case is the one below.
> 
>> Another practical case is with DPDK. When the hardware is in FreeRunning
>> mode, the CQE contains raw cycle counter values. DPDK returns these
>> values directly to user space without converting them. The new ioctl
>> provides a generic and consistent way to translate those raw values to
>> host time.
>>
>> As for XDP, you’re right that it doesn’t expose raw cycles today. The
>> point here is more future-looking: if drivers ever choose to emit raw
>> cycles into metadata for performance, this API gives user space a clean
>> way to interpret those timestamps.
> 
> Got it, I can see how DPDK / kernel bypass may need this.
> 
> Please include this justification in the commit message for v2
> and let's see if anyone merges it.

Thanks, I’ll include the DPDK/kernel bypass justification clearly in the 
v2 commit message and cover letter.

Additionally, I wanted to mention another relevant use case that wasn’t 
brought up earlier: fwctl can expose event records tagged with raw cycle 
counter timestamps. When the device is in free-running mode, correlating 
those with host time becomes difficult unless user space has access to 
both cycle and system time snapshots.

