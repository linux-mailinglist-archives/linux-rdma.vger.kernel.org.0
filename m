Return-Path: <linux-rdma+bounces-4802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B0096F41D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 14:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35F4282196
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01921CC163;
	Fri,  6 Sep 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iVBoqvu2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F352153598;
	Fri,  6 Sep 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625082; cv=fail; b=APQcetpVX5bBwMSYruTowfX0UKxccqb9p4VPk3WCm4Y9TR5TzsIDVlNemHzIFXZGMPpoyUOtSVlpTBpO+/Y1TxUZWVs4zR0qtx51Lh4JAs2nvERyJHp3qypr5HW0+txOeSUpz9nU/MyI2/2oGUndugtINtgfMq4A4nH2ipOYVK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625082; c=relaxed/simple;
	bh=nFJ0kV6GulRlmcEQvwPCrU7lBcLMiGIK9YUGC7SkeVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcCBi8RHoo470eNHXwJgMmoDbBFJ7r4OYwhrlU9KTqMY5jfPrbxTvuEoklsEL1UPMgpzkfon80H7bOT4MS4qhZPZECcXl2KJsRkjFsjqop794clnlizxPXBtuA/4OgR5gq+RIsY4xVGj29T6hjvI4hHncetTx1DleE0RyG6/p8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iVBoqvu2; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPtTNqskF+XJUYoYizMi3DHyzKoURMg4xex47mqsxP6B4w5FeXkstc8LQrWSNrH1F5Xp0vZ7aui+BAbvg+WsAp/bdB9u4ER5XSpP4Wpjv4JzE6K9fENkpeMfXSQSz9qVA5NXqcfEByGLcZzf6VgPtoeL8RT5P+0Bka7238WLWa0tijonYQroYBf3E/mBGpcMmzu5fZxT7MmoiVSmfgArhQTK1I+p+dHwOrIYFtSAvzsiln6lu+mKerd6y1XuFUFf9cCeU5PMLRt0TD6rzxT6tsaISJGSK/bE2hfQeLbAv2mpeeZ7rShtGzyIwKYotJ04f7+3WS1fSLINPBhW39kfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56W1FYCZzLhHBXiMPnmHUw9K/jGTZrBWbZsQyPYYBH4=;
 b=EnbB5Sex+QZ/qJ6OpC3nBTeMu0AWpsu42ZqApit2VONaWrpk8+CAV7sbBJzOg97ayqViUQq3W70MQKdfObjnByYNEicGvCwV68lMcUM6EthhqKk/OfKgVfh6YdKDR1zNvXDmtzVAEO8EWczid+AYIpdHNiSOH3SdexkW3DiXe9PAuyaN3fxXbaXrSZCbeR1JJ+DkNd77vjpYYrhpbXl73InsVyhYjxZEBlriFVCd7Xf+PVgV+KcYOpKRNyVKBq19tgmAHl2ehRJ1RFk4GgwhWhhaR6KOchaxS9IfXJEfE3gPw6pAqsH3/y+dXO+c2T58oktvgy+f5ibhwIpRK4+r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56W1FYCZzLhHBXiMPnmHUw9K/jGTZrBWbZsQyPYYBH4=;
 b=iVBoqvu22z59/YY+S8yE6AEMslXZIVa/zu9Zf5UjhX3T6SpNr5wVzf74ugEVTOxhHwJliB9AhXQKOYw/bqkRsO+BeFnMuMfSlSZ78JALEI7Y7OmOc2r3YVkZQQkokIV4FA4+W/jYn0o+7iN5fuHb8KQjkpiJYVrENf+9AaNgDwMXV0MzM/PIjKXS01U7XJCrYZuMkNrtUAfQKOkEiCFlg6ad1+J1jl12aBeh82J0a59sEygyu5HbrZFWuzM+XrLyvuIeeOoa8eC/M8bg4t0Z1DsF4FNHLnS2FlQxjj8h7wogri+QrhgmWDGHYC+fCdNIJVyF534WCBrb8p0LaBLCUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Fri, 6 Sep 2024 12:17:57 +0000
Received: from DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f]) by DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 12:17:57 +0000
Message-ID: <a50bd6bd-5cae-49d9-8bd8-172f88035d18@nvidia.com>
Date: Fri, 6 Sep 2024 15:17:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
 <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
 <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
 <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
 <09db1552-db97-4e82-9517-3b67c4b33feb@nvidia.com>
 <99b11f32-387c-4501-bd60-efa37618c53d@linux.dev>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <99b11f32-387c-4501-bd60-efa37618c53d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To DM4PR12MB6637.namprd12.prod.outlook.com
 (2603:10b6:8:bb::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6637:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 558480c4-0a70-4b94-b228-08dcce6df104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1GSWJIV1JDNnVVNG9jY0JNeWQwSzRlelFhZGhzVUYxN1dNYTlYRjlGQ2FS?=
 =?utf-8?B?Ry9yTFRoWk1FT2MwR1BONXY0cyswVkh1QVBSdFg3c0s1T3lrVCs0cDlVdnNx?=
 =?utf-8?B?VkhJQUdLTWpmVGlpSzYvcTBxYnZSYUhGcFgwaXFJZTg0TGZ5bVZMeW1LQ0JV?=
 =?utf-8?B?NW9Ja25CZG92MFUvTnpiaC9lT0JFbjk5VUlSbVpIcmRJVEJBc2hVY2lBbG9C?=
 =?utf-8?B?Q09IVnVSRXpGbTRONWYxb0t3SGU3ckFYWjVBZStUa2t0NDB4bU92MlllNURm?=
 =?utf-8?B?Q1FsOWxVMjVaL3VCUVV3citTaUFLZTd4RXlVb1lqNlVpYzBuK3J2Q0JRSGFW?=
 =?utf-8?B?WWEvcHJFVjM0bDUzbXN6WHltOU9BTlRMS1ZzQ2RtNHRHZmhpNnZjL0ZwalFE?=
 =?utf-8?B?VUhYeEdGVVZpdXR0cStOMDdFSXhxNlFPOW92TFB4b2pSdEN0SUhZaUkwTGZ3?=
 =?utf-8?B?RjFlZytJdTlLbzBZV1l5dzdCbTJhbm8xc0NNZHJ5MWQwYm9tL3NZdEpZaTd0?=
 =?utf-8?B?YUR1bU5nR3U4YVlZNzhQRjVyRVBFNHVBWXJ0VFZ4dkFZODJRWldUNXZoYkc1?=
 =?utf-8?B?dE9QUVdCQmJKZXZFazdIMnZXTm9LWTEvc2grZ0xXbEZ6S05xdERxUDVzKytj?=
 =?utf-8?B?MEtTTUM1NTlTK2FUUWhvQ3NuQlBuNzU4T3lXYmZ3Q2RVOWxnUUwxWlZZNVln?=
 =?utf-8?B?WS9MMWxjSVZvM1VDazVHZVNrbzNKa3dDV3dWWGVYTnh1SjdtNWE3Vm45VWRS?=
 =?utf-8?B?VHFLQnN5VWQ0WHE1QjY5UFZTTkpvMkh4UTRPUE9uVGY0a3Z5eGcybmlZM2xC?=
 =?utf-8?B?czZpSFZuZmhKTTVlcTFTamtScnd5dWh4U1hRN2Z3anZUcmFRQU1pb2lGQ0FJ?=
 =?utf-8?B?WWlsUldUZ280Q1dXRnkzb0xvQk5EeVMrUUtxbnZrRkVGc3ZnLzF0UmRGVktj?=
 =?utf-8?B?enBSNGJFenJWM0RkVEZxNmxKTHR3akg2SDlQOVRZeFJUcUdwRUk0ZUtPUzhF?=
 =?utf-8?B?VS9QM1FIUTd2b1Y4K3o4R2k4UEpFZG03ZE5YbzJiZWUrbU1JbGtSYmpyVEUx?=
 =?utf-8?B?UEJzRnA0c2g2YThBN3lETnZxdUFzVjI2NkgzWkRHTXhrdWZDVDlsc2VaUVVE?=
 =?utf-8?B?ZSs3aklVck9WOXN3dG1DdkVnbFhkOTFRVTMydEtVeldGVnFPTXRoSTNvVlpv?=
 =?utf-8?B?Yy9Bc1FjQVcxZkJ2akdxelVPYXl4Y0ZZSk5oQkZSdmxlVkRlajl6U0JkTVA1?=
 =?utf-8?B?NGRpTDgxam52S3VUeGVtWVY1dndjM3kzR3RsOHU4UTJ3d1hSakRUWGRNUWo1?=
 =?utf-8?B?Nzg2Z0psOVNaUGNkMCt5SFB6aWI3dFEvNXFZWW9KaVZCdTQxRWo1TkNVT0Rn?=
 =?utf-8?B?SkV1QnR1Zkt6RnZsbFl6Qms1U1FpT1dHZDVFY1hXQTM0Mi9lVERVZnBFQmJ3?=
 =?utf-8?B?Z2x3aWlXa09Bb3BHMUNzVWFwSG50UFlmWU5Tb1A4Qm5LT2JoQ0ppNDExVmZS?=
 =?utf-8?B?cTVUVC95U3RFR3hBdTNSWW5PTWxtOGdSTlZTWlpIN2JtQXF2L1NnUXNCNEZP?=
 =?utf-8?B?REE0Nm1taWY5cTZsbGJrS2FtT2tVUWFaeEFYQThacjlyRnFvV2lBTU1pRjJW?=
 =?utf-8?B?cklxaW1oT1JIWlBuUE5uWEphamhORzR2R0loaC9QYitWbC9Rb24wR3BveHdm?=
 =?utf-8?B?OGlxVWhyNzZxWEVyRjVrREMzK2FaUnlKMkhlYUhvQjZsZTVoU2UwMmdXbDRH?=
 =?utf-8?B?UE9RN1hGc0lTTlJqcXA5c052TWNvbm1ITVgvQ2RrMFk4RVp6ancwdXE1VnJn?=
 =?utf-8?B?YUJDT3BpUzZDcWc4ZTdNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVFJeEJmZyt0Tm1mcnBzL3hqQmxKZ09tZWkyb1NJbS9tYXgrRHJoeVk0Y3Ju?=
 =?utf-8?B?cmZERW5hYzJ3TnV5VUphWUNnQlE4WlBQY2JpTnVPZHIwdGdPTUdjcWljSUFZ?=
 =?utf-8?B?d2tYNXBybDZsVFdRTzZucFhKeG9CNWNab0xzcVV0VDNyQlpUbWYwTkVVY1lP?=
 =?utf-8?B?aDZISHoySGU2VTlVOEVYQTJCejBnaEl0emNEdjIyK2lhaGJ3SjFLdE5YUUU3?=
 =?utf-8?B?S25hVEdDY2xpb2xyaDkxaExIRzNaRXo2T3RhQnhxdUtDakVBZ2lzajk5TG52?=
 =?utf-8?B?dlFHaUpXWGxRb0FEU1JTWFdWZzB2bTQxYmJKSVU2TGszNG5SSkNMeS84cWFt?=
 =?utf-8?B?cE5EOUJJMDFVeXovRXhKdi9qYkdqeWZ2OGtDQUx1d0NvcTRad1IwSmRSNWFB?=
 =?utf-8?B?ZG93V2xpbTBCN3dZcGVERWRVYUxNdFg5Q2RuaXBCcnZ6cFE4aDQzdTUyUExN?=
 =?utf-8?B?NWxPMktrYzFlQU13NlVnSjVuR0ZjdlVqYUI0a2x2UFlydWwyK2laWHhtK0s5?=
 =?utf-8?B?TzduaXVzblExbXpVcXRXNzcya0hSRHRMODBtbkFWZmt0aTRTMjh3K0w3V3NR?=
 =?utf-8?B?Sm04emVBUFNvOGVjU3JaKzQ0Qk5UVXl6SG1iSG16V0lESXVWdkszamQyZW5y?=
 =?utf-8?B?T2dWb25BeGprb0hYR0xaOXRCR0tSRm1PQmxvYldmYVFoZWpLM05lMVZuMnpz?=
 =?utf-8?B?SXI3UmhVWEhReU9WeG1Idmp1d0FiM2VNZFRGdU9wTnFpbnZPdFZNRWc2dzJ4?=
 =?utf-8?B?Nk9OY0E4ZkdOTDliUW5IM2luQmZoODhEcDZ6NWVpK1FSc0dnWTFzNlVDdXFx?=
 =?utf-8?B?YXYrN0t6eFhyU0lGVldMZEgyQk9wSWVlTm5TRDc4ZU9waXBNRFdYcHNaSGNI?=
 =?utf-8?B?SFFydUNmY1hUbDBJZlRQaEZLOWhYZVRmakdTU2NKRm9uV1ljb1VZejl2MGJB?=
 =?utf-8?B?M0Y3NFdpQU9SRFM0dnlkUUZ0Um82WEJJU1FPbHc1aDhQZ2dlSGFwZWo3Ymlv?=
 =?utf-8?B?VGpVRll2eVhXNEVIMHZFUVIzOGlpaXJvL01nVStya3AwUEdEMVB2OEpCRHdj?=
 =?utf-8?B?VWRTZWltQVFqNWd4dzdDandNaE44eHdPemNXYTNLMjBhQVh3R240bEdTbVAz?=
 =?utf-8?B?R0RMR2FHL2E2KzZJczhjUWRjMlZ2alp3QmZObTNLOTFCZGRrT2NWNXJRN0ZU?=
 =?utf-8?B?R2c0YlFORUw2WVVPRWtLU2lEL3R4SFhDL2I1TklmWXoxK1I3YTc3YlEyVytp?=
 =?utf-8?B?NXppeDVuUDBOZXNraUVDYnF5TDVzTWg5M2hXNWhHQ0JWVGQ0RUVESzlIMUh1?=
 =?utf-8?B?elJCSXc3ZER2Y0RNZWF6ZW9Sa2k4TndLZWUxampEenZZOFRQS215T2RIY2dC?=
 =?utf-8?B?SjFDNGZLeWJpZld2WW5VMlpEbnNLRFhXQkZ4bC9HZUVRL09oa2dJZTZuYjNN?=
 =?utf-8?B?Wll0eHVlWHU2OEpMNFRQRTJXNnVSVGV3NWcxZEhoT2RLdHYzbEdmbjkrSk1P?=
 =?utf-8?B?VldyZE16VzlNNmJ2UGlsZGlzYzJmTDVNOU9kN3o1SmRSK2dpZjRLV1luYXUv?=
 =?utf-8?B?RXRHSVFlQVJNUUl3V0g0dnRPaFdML1UzaDdFZmVCMURYTFMvLzJVRXkxN1ZU?=
 =?utf-8?B?L3BLblJvcWFQSEx0aU5FZ3AxcFIveE9YOVptamM4dGE3cTZHQjFVZ1BmTmxr?=
 =?utf-8?B?b3ZYdVBzY1cvQnFJMGNkb2MrcmpUcWt1NDhLVEp3TVgyamJlcDIrLzBPa2or?=
 =?utf-8?B?d2ZDMWF4OUFSTVhlVVZ5TDdaSFlKS2NuMFZkZDl2N1lRZ2JXNEJJSGJQZS96?=
 =?utf-8?B?QXdVbDdNK0dESC9sZjNBc0J0STlrT0w4dDNzb1BnZFkwS2REVy9CSHlDcUd5?=
 =?utf-8?B?RHNGcWpKYWV2OElyM1R3ZXIrSklvSTROQVRRWlJqU2Y3RnhDSFB1cS80QlVq?=
 =?utf-8?B?aExTOXcrZFNLcU90YzllWFpBd0daM080S0xOdEpXWVhMald0YmNKUW52N2Qv?=
 =?utf-8?B?U1pwdlNzUnVVZ2dwbmpjQmVzUGNYWUdzSktmWkRoc0lTK2U3N3JnK0VCNUhC?=
 =?utf-8?B?RmdvazFkYlp0YkZMemREcnpDRFIyZ0xLRmxmd0dIUTAwWjRvSFgrVXczZlAw?=
 =?utf-8?Q?KP2o6vIYh4uSY+T/YPO9KD9/O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558480c4-0a70-4b94-b228-08dcce6df104
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:17:57.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss1+dlb4dukbzoa/QkBE9z2uj98NTSLccH1L8YqSsiSUp1tTb7Otpcpg7KVA8UoMP04sM0Iv+DTtIB1yrb6QGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228


On 9/6/2024 8:02 AM, Zhu Yanjun wrote:
> External email: Use caution opening links or attachments
>
>
> 在 2024/9/5 20:23, Edward Srouji 写道:
>>
>> On 9/4/2024 2:53 PM, Zhu Yanjun wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 在 2024/9/4 16:27, Edward Srouji 写道:
>>>>
>>>> On 9/4/2024 9:02 AM, Zhu Yanjun wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> 在 2024/9/3 19:37, Leon Romanovsky 写道:
>>>>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> This series from Edward introduces mlx5 data direct placement (DDP)
>>>>>> feature.
>>>>>>
>>>>>> This feature allows WRs on the receiver side of the QP to be 
>>>>>> consumed
>>>>>> out of order, permitting the sender side to transmit messages 
>>>>>> without
>>>>>> guaranteeing arrival order on the receiver side.
>>>>>>
>>>>>> When enabled, the completion ordering of WRs remains in-order,
>>>>>> regardless of the Receive WRs consumption order.
>>>>>>
>>>>>> RDMA Read and RDMA Atomic operations on the responder side 
>>>>>> continue to
>>>>>> be executed in-order, while the ordering of data placement for RDMA
>>>>>> Write and Send operations is not guaranteed.
>>>>>
>>>>> It is an interesting feature. If I got this feature correctly, this
>>>>> feature permits the user consumes the data out of order when RDMA 
>>>>> Write
>>>>> and Send operations. But its completiong ordering is still in order.
>>>>>
>>>> Correct.
>>>>> Any scenario that this feature can be applied and what benefits 
>>>>> will be
>>>>> got from this feature?
>>>>>
>>>>> I am just curious about this. Normally the users will consume the 
>>>>> data
>>>>> in order. In what scenario, the user will consume the data out of
>>>>> order?
>>>>>
>>>> One of the main benefits of this feature is achieving higher bandwidth
>>>> (BW) by allowing
>>>> responders to receive packets out of order (OOO).
>>>>
>>>> For example, this can be utilized in devices that support multi-plane
>>>> functionality,
>>>> as introduced in the "Multi-plane support for mlx5" series [1]. When
>>>> mlx5 multi-plane
>>>> is supported, a single logical mlx5 port aggregates multiple physical
>>>> plane ports.
>>>> In this scenario, the requester can "spray" packets across the
>>>> multiple physical
>>>> plane ports without guaranteeing packet order, either on the wire or
>>>> on the receiver
>>>> (responder) side.
>>>>
>>>> With this approach, no barriers or fences are required to ensure
>>>> in-order packet
>>>> reception, which optimizes the data path for performance. This can
>>>> result in better
>>>> BW, theoretically achieving line-rate performance equivalent to the
>>>> sum of
>>>> the maximum BW of all physical plane ports, with only one QP.
>>>
>>> Thanks a lot for your quick reply. Without ensuring in-order packet
>>> reception, this does optimize the data path for performance.
>>>
>>> I agree with you.
>>>
>>> But how does the receiver get the correct packets from the out-of-order
>>> packets efficiently?
>>>
>>> The method is implemented in Software or Hardware?
>>
>>
>> The packets have new field that is used by the HW to understand the
>> correct message order (similar to PSN).
>>
>> Once the packets arrive OOO to the receiver side, the data is scattered
>> directly (hence the DDP - "Direct Data Placement" name) by the HW.
>>
>> So the efficiency is achieved by the HW, as it also saves the required
>> context and metadata so it can deliver the correct completion to the
>> user (in-order) once we have some WQEs that can be considered an
>> "in-order window" and be delivered to the user.
>>
>> The SW/Applications may receive OOO WR_IDs though (because the first CQE
>> may have consumed Recv WQE of any index on the receiver side), and it's
>> their responsibility to handle it from this point, if it's required.
>
> Got it. It seems that all the functionalities are implemented in HW. The
> SW only receives OOO WR_IDs. Thanks a lot. Perhaps it is helpful to RDMA
> LAG devices. It should enhance the performance^_^
>
> BTW, do you have any performance data with this feature?

Not yet. We tested it functionality wise for now.

But we should be able to measure its performance soon :).


>
> Best Regards,
> Zhu Yanjun
>
>>
>>>
>>> I am just interested in this feature and want to know more about this.
>>>
>>> Thanks,
>>>
>>> Zhu Yanjun
>>>
>>>>
>>>> [1] https://lore.kernel.org/lkml/cover.1718553901.git.leon@kernel.org/
>>>>> Thanks,
>>>>> Zhu Yanjun
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Edward Srouji (2):
>>>>>>    net/mlx5: Introduce data placement ordering bits
>>>>>>    RDMA/mlx5: Support OOO RX WQE consumption
>>>>>>
>>>>>>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>>>>>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>>>>>   drivers/infiniband/hw/mlx5/qp.c      | 51
>>>>>> +++++++++++++++++++++++++---
>>>>>>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>>>>>>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>>>>>>   5 files changed, 78 insertions(+), 11 deletions(-)
>>>>>>
>>>>>
>>> -- 
>>> Best Regards,
>>> Yanjun.Zhu
>>>
>

