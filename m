Return-Path: <linux-rdma+bounces-10153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F450AAF6AC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 11:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA5A3A4CA9
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0381623D284;
	Thu,  8 May 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mLTwzSF6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3F4A33;
	Thu,  8 May 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696203; cv=fail; b=HWRHhO5Crme75NRWDMq/r53QS57gnm3lbkxKyXSkpYeclIKgyonjHaCY/02b16xg/wkTetnQiglGsB0TYZFbvVAfmz9XegsjeKAP0Jn8tGhGMSkoYU2bUie9+IE9jl6UX5o+YeAvtkJdORcpflnViKh70j1DvA3mk7Php6A9fiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696203; c=relaxed/simple;
	bh=bSxguap6kq35hwlbqijyZlbqYEOpODvU1oVYh7SQLAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rrs2w5GazZ5Y15x0g5idyilaEl9KcFF8SmA6D+wXlwTHi0pgPWbgLfNtFsEZoKDefx+o3heVmG8F7HxTRWXLL55T7apAMYM48Xky7FeM+cmTZvyB4pDg83qxUcNHqOOTy3EdzmYLYGYQTWtq4+6XnrkDRm/gdxjW/95thJ/0pnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mLTwzSF6; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o56rHbGPpfQRmE7PkKcXYI4KFRJHe2tSRs45X6RalPeqayIkC/LPqBhYN5B7nihxid4s/F4B8WiwUzqN5ROfTEWfQZlHJZy/oFnQsDk/l1Zp7AgVT7LVpQEvZAKK/Qhl9Uo60BHk8Acy3BqthQUsBjGp8p8H3sIyqGa1NwdiMzT0krXKqQ6U96z+tNuKz/vNBNU2KvPYBBcraQOqMhD9ZhC9+4VphraGzVlSxA8DGJXHxQEGvulio7G3EaXMnYMdQlxZySoWfXJi2CWFvMj2ZReZzdvwB5DvivihgsJ9k4m3feoEPjvNhpg6cmz42rrXuS5O4NzmJaR7brkUlZy93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcSoSFIBUgfK3Sw4wAmYg9hFIwZ+R4WDsu1/PiItPqY=;
 b=tfBMQQnxPVOTi8XsoJRG7+f/xUbkchpjtURZTD3isRMj+hUzvu4PUMB6i/dYGV05CzkcQSKzyQnJcbwG4nxcDzkzfpDL3sxPd2rCZV32Et5JNtXCgBvw2MxphfZ6dC4FGpk8xC98fb23qVFtyzt9pCV5BOf2/d8wC8jZtLCmk9nN1U/rQYQgUnrhCtwSDao5yK6XLkU4ThPlksDGaZ6JqqrB58lSzPEaJcheBMt2PXQo3vlX05tJyKTZ7OJWME69B2mOc6a9L6OTCPVtYyexUJOFewSjZ+hhA+8+9QDl8Gfj0S10o1I4cwAig8/NhV0WSMHh3hBVi2ffBB3R4pNRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcSoSFIBUgfK3Sw4wAmYg9hFIwZ+R4WDsu1/PiItPqY=;
 b=mLTwzSF62iattczEiYr78lsmb5UV/crDcJpUdEiRXGU8jMvXwz8eLuDaAPZ1nUMFZceuMU4vG3+eBao53Po+5RM65+zEF9CgX+HxqWS5Fy5m2SvW2K8pQiRmI2FryUj7e1pbYoRwcieR77uhMFscKbajXMr5mAp+dtkLMSx6PE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 8 May
 2025 09:23:15 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 09:23:15 +0000
Message-ID: <86be353f-4255-ca71-82db-4aa77331dcfb@amd.com>
Date: Thu, 8 May 2025 14:53:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Content-Language: en-US
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <20250508045957.2823318-9-abhijit.gangurde@amd.com>
 <CAH-L+nM86KduwFfEUDdGOSx865Dq=YHaVfUZU8GRqb2C3tq7dQ@mail.gmail.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <CAH-L+nM86KduwFfEUDdGOSx865Dq=YHaVfUZU8GRqb2C3tq7dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::11) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f16fd3-cfd4-45ef-b65a-08dd8e11f606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDkzSGZtamQ3TGlZbEpmSU9mU1NyZFdxWk9QMm0yUEdSaXlQaE0vaHk4S2h5?=
 =?utf-8?B?ejlpN3Z4NVFFZ2k3N05UVnI3QzI4aFA3WlFsK0FhMmhKeGd1VE9OYUNBRlpp?=
 =?utf-8?B?bTgzdzIvTk9Rb1h5dTlpQTB6MlpvMVFjOEljaEpyVTE3WERCeGlaZ2hrSUph?=
 =?utf-8?B?S1pRdGRwQmJYQlpiUVEwZ0tXRHg2SEloeWh4VUJqM3ZJRmpaRU9WYnRrT2dO?=
 =?utf-8?B?eWorcFgzalBwbEdzK3VNWU52SHNlc05Id0NtTlBOVlVzYUN5M2lzZHM0dDNk?=
 =?utf-8?B?ZDNqMXFHNld5dGY4Ujk0R29pL1J2cEVsN3VFOUt3Vm8zYS9ZYWVBK3BpczVr?=
 =?utf-8?B?Q2Jid1p6K3RtOTNvcjhJdDFCVENJN1BsWHlTSjZEc2o4eCs5NkdBczY0Ym1R?=
 =?utf-8?B?dzArNCtSYWU4QXdFSHFYeEhPWTErckVJVFN5YWp5dVR5SkhXdEZlZkFXT1Er?=
 =?utf-8?B?cElIeTJsQlRURytIUFprQ1VWL3FERWRVc3pUWnBCOW8vNi9QV09sUHZEWERL?=
 =?utf-8?B?N2ZEUVdzcFVmSGtDekJWckczbFJNYlNNNlRBLzVCLy9jMXZsS3JVZk5SdkFG?=
 =?utf-8?B?alE5T29ISTFBa3g2ZVdHdXVZeURJeHZGcTlER0ZIb1dTVklTb2l5MTlDUCtR?=
 =?utf-8?B?WlZQNTlBNFVYYVdhZkpJdmJlZWp6K1YyOUhDbWhXMUJ4c1daZE5VU0tmNml0?=
 =?utf-8?B?dHJzNXpEMStVcU9rbVJ1V1hYRTBCRk1TM1E4bVVYVVh0dnd5LzM5OWdNOXpH?=
 =?utf-8?B?N1FNREJhNExFSDBXWGxwbmdQckJGUWl0TGNBOFJwY2thc1BYSXQwUmZBQUtw?=
 =?utf-8?B?NU1DcDlwb1FHU29DTG1kTytkUTliSUUyVXJYN2xuSXJlZnVGWVF1M1RZcmdm?=
 =?utf-8?B?ZE1YbHI2V1B6WkxEVlYzZFE1YWJuOHZVQ0hSSnFVcEFqeVJoT2NHNUp4ejcr?=
 =?utf-8?B?SGkyUGlmZ2lrbndOOGZtUWIvWUhlZVpwWjZHZnBjVW5hUVF0VlRJSWFNV09T?=
 =?utf-8?B?Z2dvWDJ4VWkvUFFmWFd4NXFDSXEzSkFmUG9Xd3BueHJlQVo2dFAyY050cUVp?=
 =?utf-8?B?NU1LS3BHR00rd05lcDkwMmczZkFDaU90czAxWW1wSWVFWWlDbGErbVR4STJQ?=
 =?utf-8?B?bWhmOHBLYXZzdGpscWw2Uk1jeUV2NFc2R3NGWXBlbTF5M1pWaXN2eUpWK25n?=
 =?utf-8?B?VUkyRVFjTG1YL2ZzSjlyekZhWTdaNzBMbmliV1U3NCtLMERSYThkd1hiRnEr?=
 =?utf-8?B?WkxVUm5teTNEcDdBMHQ5b3ZCRTgvRXZYaGJrUFVrOFlyKzlxTndsODhaWXhr?=
 =?utf-8?B?ZHM2Y1hJa2xLemQ5emh0ZTFuVTZTQUdJZ2xWSksycVhmdUhVLytkN0hpSUQ4?=
 =?utf-8?B?Z3Brc0h6UlhVcEZRZER2ZGRRWDlvbEd2WTMxemo5MVE4V0NSaTk2aGNyTllz?=
 =?utf-8?B?aEYrbVp4ZW5xV2dDcXdwSHJwUitzOHNrOGQvb3BZanppZW9adjliWis1UGhQ?=
 =?utf-8?B?TFZQQVE0ZHZWV3FxekVaN09ldmFlTVhXUzR6OVEzTHRnL0t4SjBVcjk4bjNz?=
 =?utf-8?B?QnFHVEdHd0NhaDY0V3J3NnJKc0ZNbGZhcGxoMXQwbUNTZXU2eUc3Tm1sekpm?=
 =?utf-8?B?Mmh2Wk1kWFVvWU5HQnNxZWR4NHhNYXR2T2ZOQlFaUUVrRFlodGhEdUhNK01n?=
 =?utf-8?B?Z1JsWXprQkVHR05za3hFRE9WM1RaSEVBd084NmlQbTFGWVhZdDh5OXlyWWMv?=
 =?utf-8?B?V2VuTFZ6UU5NRUlWWjZWdXVoWm45NE0rM09YYWt3bmhTMXlySE5ZVG5RSUEy?=
 =?utf-8?B?WVBWbE55QmJFRlRaOXZ6UVNrbnV1TDJrNXMyUkxtTktiQUh5bFU0SHdwZTFI?=
 =?utf-8?B?dWc0L0VvRUJuRlByUExxYTZHQm1QQ1h0cVRJdExaYmlKS2kwaEFLdGNrSEdN?=
 =?utf-8?Q?WkkO14ojSb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmQ2UjREYm93ZWZPd3FQZWllMkdtUDE0ZG5vcWZCMFNhcjE5SkxJY1R2SUo1?=
 =?utf-8?B?aG5WV1NVMzNTYWlwMXprV2ZVU2ZOT3JFUTdHcHFNTW90RUs1bCsxL3pBbzFD?=
 =?utf-8?B?UVdtT3V3UDNYQXJ1QjBtLzF2cjNCVjNzcW5xcXpvQVlKVUQyVHB1L0xOU2Uw?=
 =?utf-8?B?SzBlaU5sbmRJbU5pcUMrWTIwbDUxbkplR3hLSG8xVzZCTXZkYWZGNG05ZTA3?=
 =?utf-8?B?QXVXUkp3WlZ4WnEyLzZZYTFUcUlZaG1EaHQ0ckpQalJvcTdVRjNUWG8yVzhs?=
 =?utf-8?B?dVY5VHEzVGN5RnFMMW9aeThnVUhYZ0hWLzZwakJMQ2R3dDgrMm0rUzRVS0py?=
 =?utf-8?B?T2pnV0VUbmpSMmtBemp0dWZ3K3cvZWVtaEpleFZ6TDhvNmV0dmdNN3lFMDJF?=
 =?utf-8?B?UHpUbSszUUVYY3VCd2FoQjNza0FXRW5VdlhadURRZkV1Q3ZDY1BRa2dldkNK?=
 =?utf-8?B?d2ltem5ZcWhaVTVZM1UreHkydXBlLzF6SVZSN2pFZDEwTnFuM3o3cmplSmxq?=
 =?utf-8?B?T1JveUxnWC9XZ1o2eW1sQnVNREUvSmF0YldYSzBZd3lHZ3RwWHJ4TGxheXJz?=
 =?utf-8?B?YUtaaUxPQ1d0ZStORGJJRjJ4MjdFZks0dUxtUXVOeTh4Wk9yd3NkRngwS0JS?=
 =?utf-8?B?ejRsK3hubkgyQ2pXWjJLVmszVFJ4TDZJVDV0UW1BdjBwT0JjN3hYODJwSnNO?=
 =?utf-8?B?ZEwzeS9FNCthdE9JZ3NBeEsrWGtqVlBJemV6L09rU3I2ci9Gajd0alIvdDMz?=
 =?utf-8?B?VmlVOWVsR1RLWGRwaVNyZU54U3BZTEtvaWRnYy9SS2k3aXgyMVVNUWF3Qnkw?=
 =?utf-8?B?YnQ2UFhDQkdDWENNT2ZHS3lqZTFsM2Jyc3dNYktmRzVkeUZEU0NqV0VZaWc4?=
 =?utf-8?B?TTRxOCtwYWNoeW80Z1N3cDFNV3hPS1ZyeVlnNkVGYi8razZ4ZzlpQk52U3g0?=
 =?utf-8?B?YnFIQWhDT3cyOE13T1BHVml5eUJVcGVjQXlsbi9OeTJSMm5WT0xGWkUrQzdD?=
 =?utf-8?B?dURTSEVPMloxbmpvRjdjbGtVY2hLNTBEV1VieTZBUVFZbzdONGhweHhoa210?=
 =?utf-8?B?MjFUak53eENENHBSakJTWXRDS0crUGxLRkl5T2h2NzRjUHpCeThWejluRzV0?=
 =?utf-8?B?bHk5ZEl1SDBlRUFLVnZxd1pFRnpwYnZYd01kNUZvRVhidEdtcitrUFJXZVE3?=
 =?utf-8?B?THYxcS9nM2VvUmdJTzJ3UkVOZXJTYUl0dVgwemFNajRScmxGelFielMxbndU?=
 =?utf-8?B?Uzlybms0aHlqTm80ODlyTnV1b0dSM2ZCQk8ra1VKZHlGeCtXNXJsRWlCQWxE?=
 =?utf-8?B?SG94RmlGUzdwUU9uZHdicTEzOWdGenBUNStzcUkwRkFVdElrRlhaczRNcHZU?=
 =?utf-8?B?Nzc1aE5ERkNPbkwyYXZ4UEhoTnRVU3E0V1pJUTdMajVKRFU3Q0FDUlNiS3RN?=
 =?utf-8?B?NlVITUh4M3BqRmhDNVJWQWRKWlFVblhTNEl6YUFsYm01WUdKQS9yYnhSbCs4?=
 =?utf-8?B?TVY2dXRuNjIzTHZQck5lTWorMERQb2RPQ3paaXVVeSsxMnF1TFVxdjhETFBv?=
 =?utf-8?B?QzEvR3pkNHIrdjZzVzlOMHBiczFIRmpFeHpieFQxRkxuZFFmNHo2NE5PYktk?=
 =?utf-8?B?N3VnK05EenQwVGFFQ2dOK1NSYmt6azR4QVNVRm9BU2U2RVNqWnVSNFJSRHRV?=
 =?utf-8?B?K0hPS2I4dUIzMEVBK0pSZklMbEs5Q2xDWk5tR1gyWStpWGZoeGFHUDhlaG1R?=
 =?utf-8?B?bEszUWRxcWd1eGk0WWxGSmptaUd4VzV1a1M2VXJQTUl3elkzS2trNmtzYm9L?=
 =?utf-8?B?eHJpUkQ4TDkvNFNjOG1Vd2E4LzZja1NIRFNxRXhPaVJnYk1Ja2w0SUVtT3Vl?=
 =?utf-8?B?Q2lXcjgwREo1eDZrdEhRRjRvLytXRGRpK2JlcWIraFVkYlZCTUthem9KbXdr?=
 =?utf-8?B?cGJleHNoK3ViM0kweXhFQWlSUjFkbXpZVEhnTVJxYUNHN0dLYlBrOThCRjJT?=
 =?utf-8?B?c2t3YnFwSExYM0FCNUxYdmQ4Vldoc2Z6cEZJUmVMNmdTbXhHQ3BXSXZIalVa?=
 =?utf-8?B?M0I4TkFTK3dVM1o3WHFNbjJTR0lQWkorVlM4UUhUazJab003Z0lHQ0tSYVl3?=
 =?utf-8?Q?QkE9rTlRrHD1ZOOaIko6RB60Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f16fd3-cfd4-45ef-b65a-08dd8e11f606
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:23:15.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qDCCdjwQnD0mdS4ta99ASu92BDxIxUURHa5AfiBOXpyn9t2ytj9FkmE2+vWHYiP38Ha8DqGJgNNY91aWy5FGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887


On 5/8/25 13:06, Kalesh Anakkur Purayil wrote:
> On Thu, May 8, 2025 at 10:33 AM Abhijit Gangurde
> <abhijit.gangurde@amd.com> wrote:
>> Register auxiliary module to create ibdevice for ionic
>> ethernet adapter.
>>
>> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
>> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>> v1->v2
>>    - Removed netdev references from ionic RDMA driver
>>    - Moved to ionic_lif* instead of void* to convey information between
>>      aux devices and drivers.
>>
>>   drivers/infiniband/hw/ionic/ionic_ibdev.c   | 135 ++++++++++++++++++++
>>   drivers/infiniband/hw/ionic/ionic_ibdev.h   |  21 +++
>>   drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 121 ++++++++++++++++++
>>   drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  65 ++++++++++
>>   4 files changed, 342 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h
>>
>> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
>> new file mode 100644
>> index 000000000000..ca047a789378
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
>> @@ -0,0 +1,135 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
>> +
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <net/addrconf.h>
>> +
>> +#include "ionic_ibdev.h"
>> +
>> +#define DRIVER_DESCRIPTION "AMD Pensando RoCE HCA driver"
>> +#define DEVICE_DESCRIPTION "AMD Pensando RoCE HCA"
>> +
>> +MODULE_AUTHOR("Allen Hubbe <allen.hubbe@amd.com>");
>> +MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS("NET_IONIC");
>> +
>> +static const struct auxiliary_device_id ionic_aux_id_table[] = {
>> +       { .name = "ionic.rdma", },
>> +       {},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
>> +
>> +static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
>> +{
>> +       ib_unregister_device(&dev->ibdev);
>> +       ib_dealloc_device(&dev->ibdev);
>> +}
>> +
>> +static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
>> +{
>> +       struct ib_device *ibdev;
>> +       struct ionic_ibdev *dev;
>> +       int rc;
>> +
>> +       rc = ionic_version_check(&ionic_adev->adev.dev, ionic_adev->lif);
>> +       if (rc)
>> +               goto err_dev;
> You can return directly from here
Sure. Will correct this.
>> +
>> +       dev = ib_alloc_device(ionic_ibdev, ibdev);
>> +       if (!dev) {
>> +               rc = -ENOMEM;
>> +               goto err_dev;
> You can return directly from here
Sure. Will correct this.
>> +       }
>> +
>> +       ionic_fill_lif_cfg(ionic_adev->lif, &dev->lif_cfg);
>> +
>> +       ibdev = &dev->ibdev;
>> +       ibdev->dev.parent = dev->lif_cfg.hwdev;
>> +
>> +       strscpy(ibdev->name, "ionic_%d", IB_DEVICE_NAME_MAX);
>> +       strscpy(ibdev->node_desc, DEVICE_DESCRIPTION, IB_DEVICE_NODE_DESC_MAX);
>> +
>> +       ibdev->node_type = RDMA_NODE_IB_CA;
>> +       ibdev->phys_port_cnt = 1;
>> +
>> +       /* the first two eq are reserved for async events */
>> +       ibdev->num_comp_vectors = dev->lif_cfg.eq_count - 2;
>> +
>> +       addrconf_ifid_eui48((u8 *)&ibdev->node_guid,
>> +                           ionic_lif_netdev(ionic_adev->lif));
>> +
>> +       rc = ib_device_set_netdev(ibdev, ionic_lif_netdev(ionic_adev->lif), 1);
>> +       if (rc)
>> +               goto err_admin;
>> +
>> +       rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
>> +       if (rc)
>> +               goto err_register;
>> +
>> +       return dev;
>> +
>> +err_register:
> Unnecessary label
Because of logical split , this used in patch #13.
>> +err_admin:
>> +       ib_dealloc_device(&dev->ibdev);
>> +err_dev:
>> +       return ERR_PTR(rc);
>> +}
>> +
>> +static int ionic_aux_probe(struct auxiliary_device *adev,
>> +                          const struct auxiliary_device_id *id)
>> +{
>> +       struct ionic_aux_dev *ionic_adev;
>> +       struct ionic_ibdev *dev;
>> +
>> +       ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
>> +       dev = ionic_create_ibdev(ionic_adev);
>> +       if (IS_ERR(dev))
>> +               return dev_err_probe(&adev->dev, PTR_ERR(dev),
>> +                                    "Failed to register ibdev\n");
>> +
>> +       auxiliary_set_drvdata(adev, dev);
>> +       ibdev_dbg(&dev->ibdev, "registered\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static void ionic_aux_remove(struct auxiliary_device *adev)
>> +{
>> +       struct ionic_ibdev *dev = auxiliary_get_drvdata(adev);
>> +
>> +       dev_dbg(&adev->dev, "unregister ibdev\n");
>> +       ionic_destroy_ibdev(dev);
>> +       dev_dbg(&adev->dev, "unregistered\n");
>> +}
>> +
>> +static struct auxiliary_driver ionic_aux_r_driver = {
>> +       .name = "rdma",
>> +       .probe = ionic_aux_probe,
>> +       .remove = ionic_aux_remove,
>> +       .id_table = ionic_aux_id_table,
>> +};
>> +
>> +static int __init ionic_mod_init(void)
>> +{
>> +       int rc;
>> +
>> +       rc = auxiliary_driver_register(&ionic_aux_r_driver);
>> +       if (rc)
>> +               goto err_aux;
>> +
>> +       return 0;
>> +
>> +err_aux:
>> +       return rc;
> You can simplify this function as "return
> auxiliary_driver_register(&ionic_aux_r_driver);"
Because of logical split, err_aux this used in patch #9.
>> +}
>> +
>> +static void __exit ionic_mod_exit(void)
>> +{
>> +       auxiliary_driver_unregister(&ionic_aux_r_driver);
>> +}
>> +
>> +module_init(ionic_mod_init);
>> +module_exit(ionic_mod_exit);
>> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
>> new file mode 100644
>> index 000000000000..e13adff390d7
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
>> +
>> +#ifndef _IONIC_IBDEV_H_
>> +#define _IONIC_IBDEV_H_
>> +
>> +#include <rdma/ib_verbs.h>
>> +#include <ionic_api.h>
>> +
>> +#include "ionic_lif_cfg.h"
>> +
>> +#define IONIC_MIN_RDMA_VERSION 0
>> +#define IONIC_MAX_RDMA_VERSION 2
>> +
>> +struct ionic_ibdev {
>> +       struct ib_device        ibdev;
>> +
>> +       struct ionic_lif_cfg    lif_cfg;
>> +};
>> +
>> +#endif /* _IONIC_IBDEV_H_ */
>> diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
>> new file mode 100644
>> index 000000000000..a02eb2f5bd45
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
>> +
>> +#include <linux/kernel.h>
>> +
>> +#include <ionic.h>
>> +#include <ionic_lif.h>
>> +
>> +#include "ionic_lif_cfg.h"
>> +
>> +#define IONIC_MIN_RDMA_VERSION 0
>> +#define IONIC_MAX_RDMA_VERSION 2
>> +
>> +static u8 ionic_get_expdb(struct ionic_lif *lif)
>> +{
>> +       u8 expdb_support = 0;
>> +
>> +       if (lif->ionic->idev.phy_cmb_expdb64_pages)
>> +               expdb_support |= IONIC_EXPDB_64B_WQE;
>> +       if (lif->ionic->idev.phy_cmb_expdb128_pages)
>> +               expdb_support |= IONIC_EXPDB_128B_WQE;
>> +       if (lif->ionic->idev.phy_cmb_expdb256_pages)
>> +               expdb_support |= IONIC_EXPDB_256B_WQE;
>> +       if (lif->ionic->idev.phy_cmb_expdb512_pages)
>> +               expdb_support |= IONIC_EXPDB_512B_WQE;
>> +
>> +       return expdb_support;
>> +}
>> +
>> +void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
>> +{
>> +       union ionic_lif_identity *ident = &lif->ionic->ident.lif;
>> +
>> +       cfg->lif = lif;
>> +       cfg->hwdev = &lif->ionic->pdev->dev;
>> +       cfg->lif_index = lif->index;
>> +       cfg->lif_hw_index = lif->hw_index;
>> +
>> +       cfg->dbid = lif->kern_pid;
>> +       cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
>> +       cfg->dbpage = lif->kern_dbpage;
>> +       cfg->intr_ctrl = lif->ionic->idev.intr_ctrl;
>> +
>> +       cfg->db_phys = lif->ionic->bars[IONIC_PCI_BAR_DBELL].bus_addr;
>> +
>> +       if (IONIC_VERSION(ident->rdma.version, ident->rdma.minor_version) >=
>> +           IONIC_VERSION(2, 1))
>> +               cfg->page_size_supported =
>> +                   cpu_to_le64(ident->rdma.page_size_cap);
>> +       else
>> +               cfg->page_size_supported = IONIC_PAGE_SIZE_SUPPORTED;
>> +
>> +       cfg->rdma_version = ident->rdma.version;
>> +       cfg->qp_opcodes = ident->rdma.qp_opcodes;
>> +       cfg->admin_opcodes = ident->rdma.admin_opcodes;
>> +
>> +       cfg->stats_type = cpu_to_le16(ident->rdma.stats_type);
>> +       cfg->npts_per_lif = le32_to_cpu(ident->rdma.npts_per_lif);
>> +       cfg->nmrs_per_lif = le32_to_cpu(ident->rdma.nmrs_per_lif);
>> +       cfg->nahs_per_lif = le32_to_cpu(ident->rdma.nahs_per_lif);
>> +
>> +       cfg->aq_base = le32_to_cpu(ident->rdma.aq_qtype.qid_base);
>> +       cfg->cq_base = le32_to_cpu(ident->rdma.cq_qtype.qid_base);
>> +       cfg->eq_base = le32_to_cpu(ident->rdma.eq_qtype.qid_base);
>> +
>> +       /*
>> +        * ionic_create_rdma_admin() may reduce aq_count or eq_count if
>> +        * it is unable to allocate all that were requested.
>> +        * aq_count is tunable; see ionic_aq_count
>> +        * eq_count is tunable; see ionic_eq_count
>> +        */
>> +       cfg->aq_count = le32_to_cpu(ident->rdma.aq_qtype.qid_count);
>> +       cfg->eq_count = le32_to_cpu(ident->rdma.eq_qtype.qid_count);
>> +       cfg->cq_count = le32_to_cpu(ident->rdma.cq_qtype.qid_count);
>> +       cfg->qp_count = le32_to_cpu(ident->rdma.sq_qtype.qid_count);
>> +       cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
>> +
>> +       cfg->aq_qtype = ident->rdma.aq_qtype.qtype;
>> +       cfg->sq_qtype = ident->rdma.sq_qtype.qtype;
>> +       cfg->rq_qtype = ident->rdma.rq_qtype.qtype;
>> +       cfg->cq_qtype = ident->rdma.cq_qtype.qtype;
>> +       cfg->eq_qtype = ident->rdma.eq_qtype.qtype;
>> +       cfg->udma_qgrp_shift = ident->rdma.udma_shift;
>> +       cfg->udma_count = 2;
>> +
>> +       cfg->max_stride = ident->rdma.max_stride;
>> +       cfg->expdb_mask = ionic_get_expdb(lif);
>> +
>> +       cfg->sq_expdb =
>> +           !!(lif->qtype_info[IONIC_QTYPE_TXQ].features & IONIC_QIDENT_F_EXPDB);
>> +       cfg->rq_expdb =
>> +           !!(lif->qtype_info[IONIC_QTYPE_RXQ].features & IONIC_QIDENT_F_EXPDB);
>> +}
>> +
>> +struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
>> +{
>> +       return lif->netdev;
>> +}
>> +
>> +int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
>> +{
>> +       union ionic_lif_identity *ident = &lif->ionic->ident.lif;
>> +       int rc;
> local variable "rc" is not needed here, you can return directly.

sure. Will remove it.

Thanks,
Abhijit

>> +
>> +       if (ident->rdma.version < IONIC_MIN_RDMA_VERSION ||
>> +           ident->rdma.version > IONIC_MAX_RDMA_VERSION) {
>> +               rc = -EINVAL;
>> +               dev_err_probe(dev, rc,
>> +                             "ionic_rdma: incompatible version, fw ver %u\n",
>> +                             ident->rdma.version);
>> +               dev_err_probe(dev, rc,
>> +                             "ionic_rdma: Driver Min Version %u\n",
>> +                             IONIC_MIN_RDMA_VERSION);
>> +               dev_err_probe(dev, rc,
>> +                             "ionic_rdma: Driver Max Version %u\n",
>> +                             IONIC_MAX_RDMA_VERSION);
>> +               return rc;
>> +       }
>> +
>> +       return 0;
>> +}
>> diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
>> new file mode 100644
>> index 000000000000..b095637c54cf
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
>> +
>> +#ifndef _IONIC_LIF_CFG_H_
>> +
>> +#define IONIC_VERSION(a, b) (((a) << 16) + ((b) << 8))
>> +#define IONIC_PAGE_SIZE_SUPPORTED      0x40201000 /* 4kb, 2Mb, 1Gb */
>> +
>> +#define IONIC_EXPDB_64B_WQE    BIT(0)
>> +#define IONIC_EXPDB_128B_WQE   BIT(1)
>> +#define IONIC_EXPDB_256B_WQE   BIT(2)
>> +#define IONIC_EXPDB_512B_WQE   BIT(3)
>> +
>> +struct ionic_lif_cfg {
>> +       struct device *hwdev;
>> +       struct ionic_lif *lif;
>> +
>> +       int lif_index;
>> +       int lif_hw_index;
>> +
>> +       u32 dbid;
>> +       int dbid_count;
>> +       u64 __iomem *dbpage;
>> +       struct ionic_intr __iomem *intr_ctrl;
>> +       phys_addr_t db_phys;
>> +
>> +       u64 page_size_supported;
>> +       u32 npts_per_lif;
>> +       u32 nmrs_per_lif;
>> +       u32 nahs_per_lif;
>> +
>> +       u32 aq_base;
>> +       u32 cq_base;
>> +       u32 eq_base;
>> +
>> +       int aq_count;
>> +       int eq_count;
>> +       int cq_count;
>> +       int qp_count;
>> +
>> +       u16 stats_type;
>> +       u8 aq_qtype;
>> +       u8 sq_qtype;
>> +       u8 rq_qtype;
>> +       u8 cq_qtype;
>> +       u8 eq_qtype;
>> +
>> +       u8 udma_count;
>> +       u8 udma_qgrp_shift;
>> +
>> +       u8 rdma_version;
>> +       u8 qp_opcodes;
>> +       u8 admin_opcodes;
>> +
>> +       u8 max_stride;
>> +       bool sq_expdb;
>> +       bool rq_expdb;
>> +       u8 expdb_mask;
>> +};
>> +
>> +int ionic_version_check(const struct device *dev, struct ionic_lif *lif);
>> +void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
>> +struct net_device *ionic_lif_netdev(struct ionic_lif *lif);
>> +
>> +#endif /* _IONIC_LIF_CFG_H_ */
>> --
>> 2.34.1
>>
>>
>

