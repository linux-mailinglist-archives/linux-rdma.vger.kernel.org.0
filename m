Return-Path: <linux-rdma+bounces-6043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78069D3368
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 07:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401FCB2381E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2024 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853AA15746E;
	Wed, 20 Nov 2024 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRCImuab"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57227447;
	Wed, 20 Nov 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082685; cv=fail; b=CVmEzwA5Ye1ZvNZ3joL8C6u7Zqu4yACow1Y0HIkiTWy2SuSX5Nos1sAgyP9IVnfVl0zHeKHy3vYGuR2kWQhTINY0fJzcU4nBXxfOqrXqd5qqeD4w6qP43pYWt7r/F4NCQewP0ZTz5Zq9x6YIKQKqsLXFzUUk7kTP3wdy2gOvBoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082685; c=relaxed/simple;
	bh=ZHo1Zzne7KftmLlQuTUij8VuuqecpYppLij+tj8t+DM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCGqcxlPps63sLes8Yp4hS747Px3ICWe8mRHh0rAmmCAglvo+ZzsJ7+cIzmLUx5ZqVD2EprX/dRmlSZlN5o4umald93y+VUh21AVnE7YyMNtPCyklTnOBryy0q+vmxIhM0U6+o8DpjznjnZz7UNwSj/6Es4d3rkNIuO0+cIZuoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRCImuab; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG6q94iw30ZOwQMFqN/zEHDPynwGm+pR5BhSjUANcMEe/UDluUYaZGI9q7trqAFrDsBfNgEtLYYk9CsJTQVQityG5cjq7vjTfUWCcbOlSzs8/0/W3FjwAV9JoXEZpxiqYENs0DNzMkK4jbX2F7xFmREEmqm4BV5lO7sSb9oPG+nM8Cgl3xma0UW+Y1o7OMSwXIVv+/mI/14gHTwW2yiMWL3cbdffTxKiGcmEQLfMTiBgXkyt2uUBtUCFO4KxmOsmtiz7WXTONkiZENtt3giaQgqn4uCOGdX+vIPGLyhNXQ2V7IpAmFu+3JDTKh4RYuPhonTYF9o7OaXMiaLSB5C4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unTFMK///gYhCKszOpx63oTxDxCfXEuBCYC4qYfYPHQ=;
 b=SO8uukNWglugTKkw8E1EXRgDgrU9ZS2geBeDfoYUAX90CyWrv3ZXYWOsF+e7JM2s9sGN35qOeOXl04xRCc5uBlEMIlc6w5EbtLHd/MbyYdoryLkeG0FtRsGjXKvTAGHVLPpe//CpZCovRnUlvxmpbQ1ufRyT6rfWlAFKUFciBDcrrB2ZvAf5KSapcEe/AmOpurDe/np06dqPF3HJF6Os8ZqCsRQRpds9hat3VNFKfCbT/zbuiX087ZRY+EHjzPsDZBxU9z42dNhniGmZIqKuDtv5steQ/+GH3BV6cifyhuw5oaYFqlANDewP6UMTFi70SUsJKMmYW78rm1XKxixdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unTFMK///gYhCKszOpx63oTxDxCfXEuBCYC4qYfYPHQ=;
 b=qRCImuabWyGZ7hxkvtlFy8AbBB93p1ew2W1qDnxWwW9V2kI2qEynVV2i7YX9qK08y5a3HET5X4XVRkrkTqKZbHe7TEL8c1qK5sMKN42E3YNcWgdkjHkuNtkp4TOfhA5jdSXTjZEJogyWIxeSf1yp916PDYdKzY76CZc4bTjbRoMsonZ1Oj7QTeYtwzWlPQwikdgor0tdF6wDSHTVahTxH3X+Hgd5edd0kT+nyHJI2uGg4ypgsl9vZVPyjoxR0z/n5YG+gEDGbKgVRZsojXnnLKBdp5vxuNJWcKBd/UOteVNcwqewuN4fFxXLCT43gP5bIUrUrOblSlz73jXOYwbn5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 06:04:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 06:04:39 +0000
Message-ID: <1060ac7d-ad76-4383-906f-9f20a7b8174a@nvidia.com>
Date: Wed, 20 Nov 2024 08:04:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Yafang Shao <laoar.shao@gmail.com>,
 ttoukan.linux@gmail.com, tariqt@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241114021711.5691-1-laoar.shao@gmail.com>
 <20241114182750.0678f9ed@kernel.org>
 <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
 <20241114203256.3f0f2de2@kernel.org>
 <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
 <Zzb_7hXRPgYMACb9@x130> <20241115112443.197c6c4e@kernel.org>
 <Zzem_raXbyAuSyZO@x130> <20241115132519.03f7396c@kernel.org>
 <ZzfGfji0V2Xy4LAQ@x130> <20241115144214.03f17c16@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241115144214.03f17c16@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: d167535f-c8cf-4213-5528-08dd0929379c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJGakovOXVsbyswbjBGNDZiZGU0ZGNuYmJYRnhFNGVKL3o4WEVSNkh1OW1S?=
 =?utf-8?B?WUxZekFnUWtyd0hoeDdKWXZCcnBrU0FXSTRwNkJLVTVoLzlvaGhQUVRKNisz?=
 =?utf-8?B?UGhjNUJJR0VSRXRXRGU3TmcxY2dVckNobStFbG54cWw0TmlRWEhoaDJERFQv?=
 =?utf-8?B?ZUljK0M4dldJcHMxZTA1ZFNSbTRNRnNRVjBKMllxMDB0VmwwSFJMVEIvc1JG?=
 =?utf-8?B?VGpBZ1JQRnVFZ1hFeEcyWmNpVXd6eUtSVXoyMXUreW1uM3BmVXE5alNObjJK?=
 =?utf-8?B?eGJ3eDlEcG1JMTNQKzdEL2NrTXRaeWVZWC9Da3k0TmJRd2xHazVLYWFtZmVY?=
 =?utf-8?B?bVJoMU0xVjVQODdxSUhFN1Z5RzJPMjFtN2VubU5PNVJHWWxjb3ZkM3Q3NFhz?=
 =?utf-8?B?TStXV2lBWjVsUE5NdFlna2xXNURIWnJmcEFvWTlualNrbnB0YUhIOU5XbFVJ?=
 =?utf-8?B?ZXJYY0J5TGhCaUNvWEVCdzFsMUFObnQvdmZXbURZVmp5SVdqd0xVZkhzUGJW?=
 =?utf-8?B?SnY4TXRKTVh0dE96WW1pNVhmMTQvMnpZMnVlSkZHMlZXbHI4eDJkKzgydXVQ?=
 =?utf-8?B?NWsyUVREek41VXRlVlEvaWlWMm5MODZDU2FJZHdFeTZtbnNJK3ZQdWZ3bE5K?=
 =?utf-8?B?bGtzZmYwS1Q2SFl4Tm42cEN6NWxocjNScXBENUpnSFNZamZhQ2Q1eUhLTm5h?=
 =?utf-8?B?b09ndW9XZHVWVm1pZWtvZlV0THc3eHpRYTF0TWNsZzRZWGhTcGErNUJRanoy?=
 =?utf-8?B?WXRxVmE4V1M3bzlxcnBrTVJhaWhVdjhTdkVZV2dyM2YyVWNZSXVNcGpKK1BU?=
 =?utf-8?B?dXRaeEs2MG9wazViclJGQ3R4VmxWNUNDeXNpaklFZlp2M25wU290ekU4eHZ5?=
 =?utf-8?B?ZzYwb0ZHMUxHSW9YNXFvTHBCZHdScVk4Qnp4ejZ5bGxkMHovQjFtcDhxVEpQ?=
 =?utf-8?B?aGg4WG9MeEtUMlVKMGRFODM3K0RQbGwrYTR2M0g1M1JoT2d0TDEyYlBJOXIr?=
 =?utf-8?B?a0h0Z1VpQVJGb1Y0OVJNL29MR1FKaUthOUJQb3lDRVk4SUcvV1V5RGZtbFpB?=
 =?utf-8?B?ZHZFeUQ4N0JUVy9TUnFicThodzBXaTVLMUxvd05LWEp0c0l5ZGRJblhKR3d6?=
 =?utf-8?B?SENqcHB6aldGR1BpeWl3aFNUOTdWYXU2VWVNZys1Rmx4T0NiVnZmWXR5K3c3?=
 =?utf-8?B?TWltN2RMTjZWWHpiZFBXYW5YZzhQcnZtb1VrZnVOODdSWXY3Y1dObFpZVnFz?=
 =?utf-8?B?Ri9ycE9vVkFFWW41NG1xclhTMmVWMlUyNWJhZmRsa003OXJ4ZGlmaDVXUXJ1?=
 =?utf-8?B?cDZ2QmcyOXZXM1puT09OV2F3eUt3cEJsWDlVZU5ISEorSEJyWldRdFIxNy9X?=
 =?utf-8?B?RXZOWUIxN0RiM1J1OXN2MWR1TXlhcitKL3U2N0ZFYzYyMDZkbmRQUXhPMkdQ?=
 =?utf-8?B?VmIxeWE5NnhTRnhQY0FnZUEwNTMxWUZ6WFllekJUeDU4aGJEM1FBRmNubGYv?=
 =?utf-8?B?Z1lvZ041M3pZRXE0QmRjV2podHF0QXlIdFVyK0F0TnVDaWxrTnpsRk5TMTNz?=
 =?utf-8?B?NmJldVVJTEJwWHNwTk5YSVNjRW5HVEd3aUp3L3p0WWpubzVheHNpZmx3d1U0?=
 =?utf-8?B?cSs4TW1FekVQanRNMVlpSzhlZzQzZncvQlord1FpVXNYc05HVW16bTdYOWlU?=
 =?utf-8?B?aUlUVnIrZnFWQmJVQW8wRHlNWkNhbjd0Y1VSZ1NhdW9PODgrZFRDMTRkckFp?=
 =?utf-8?Q?EpOYm3bPLTzJD33EQECkJWh1qCbAMr6k44rb6ED?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRtcDh1WHQ5aStYWGpSVGVUT3djR0Z5dGVFcHJsNUd2QzUxeEIwdFoyalFM?=
 =?utf-8?B?VzFHZDJVRTlQenJQTlpWYXRuajE2RHJvajdVY2x1aHRTcWs2YXA4Sng1NGkv?=
 =?utf-8?B?YlZ2N3VXd0JnWWl3b080Y1ZwMWRDVnd3cHE4VjVoRmo0RzR2U013TmhlSGhZ?=
 =?utf-8?B?WVpKSnY1Zkk1aDVPYzdvbU9IZkFRTzMrS3V6YStCTzNXb1dIN3VUeWg5Snph?=
 =?utf-8?B?bWdraWQ4SEhSejRoMHE4SExjaDhUTWovTXNPa24zZGZBQmtrdkNyN2hvS01v?=
 =?utf-8?B?WUNBN3psdWMzWFRMTzI4b2pndXBsZEdsMnhUUGFQbzBVVTlaR0pGVkFreUdU?=
 =?utf-8?B?T1RweWtaUnRTcUYzYk9rZWlLQjBPZjRQUWxHd1k0Kzk4MGtJVWViMkFnNFUr?=
 =?utf-8?B?Ry9nbzdOK0NCSCtGdFdwUjdCS3JodlVReU9vYzlaRGkyYjFtQU41NHJrZDVX?=
 =?utf-8?B?eEkwZnZKOTZGTHNoUHlaVXF2OW5taFNKZzY1UHhZUFhvWmdUcTNnaE0rVTM3?=
 =?utf-8?B?dUhhWVkyVjFCei95ZGlOcXdCMTJsNVFBZHBWZ0d2Z1JNR3lxTHJqdWR2cndu?=
 =?utf-8?B?ZlZHOENXNldTekRIbnF3d0Qwc0ZqZlZNN1V3d3VmdlVtQnRwVDliSVN2a29X?=
 =?utf-8?B?Umw5YVkzdHg2U0hjeDJBNmxmZ3F3bHpzNHNuQVVyZzNoejFHZ003ZlVBRTR0?=
 =?utf-8?B?SEVCTUVORExQTTZ0WUhSRVhhbm1EQmRHekVBd3RZUHlrczIrN2ZLamw2M29h?=
 =?utf-8?B?NVV0b25MV2djV0c2dE9ORFU2UXg1alVncDUzTkJZRnVKTXJXWkk3MGFWUW9q?=
 =?utf-8?B?YUEwcWVhTy9FMFQ5TXI1b3AzbENNUUZRNG9TNmpmeGxRWWFKMVdFd3lvMVBk?=
 =?utf-8?B?L2lNRXZJZ0N6cHlJbkwwaERrQ21oTStIMnNOQnNaZS9GV1pqeW9SbzFFT1RY?=
 =?utf-8?B?NmJYNFlTSWo1dzkvSDJiZy9TQVNvbUZ2TXFUMGRJa0EzMGh2M0w2TUxFeFVm?=
 =?utf-8?B?QjBKTDJoaTZVQVpmQ1dKZG9nUXV6cmtJbU0yZTVxRXZRb0Y3R09ieXJZSlh3?=
 =?utf-8?B?TDUzeTNNeXhJMWM0Q29VcWFuMEg4T016T0pua0ZWWEhMd0pIcUVqUHhtRzYy?=
 =?utf-8?B?UnFOaTBIbWtSNWRWM0lFMlBDUDNZd2svVHhNTnBQVTJ3ZWdZd3h2L0RoRzFN?=
 =?utf-8?B?S01FN1NqbUNLL09xS0FDUUpHQWRwczdBL0dXSGd2K1ZTeGxNWUh0TTMyRXE4?=
 =?utf-8?B?cjZFRUZmSHczOXhHT0xieFBFMkFibVJyT0tLL21QNU0rU05ZU2NLLzBvWjVI?=
 =?utf-8?B?U1FKOWRYMUtJWVpDTUFmVHJ6T3RValBHK1A3eEhad1dFeHpkRzdJYU1Xb2Iy?=
 =?utf-8?B?WWhZNm1hT2NIVzdocktCVlpPVVlxNkE1bHduZC9Fcm5hbHc2NmcyL0NxMk1G?=
 =?utf-8?B?dHo4VHJ4UzRPTkdzRTlDZmVqVkdzZG1Wdy95VzBEU1hFajJ4WkNlVUFPNXBl?=
 =?utf-8?B?Rm0wSGR0MG1lMUtWcnN6Tll0VVorZ3Z6L3lld3lOZTd5aVRYTjJLY0dMdnB4?=
 =?utf-8?B?YzRVbU1wSHZGZWpyTGl5VmlkSHR6cGRpSTNzV1djaGcrZk5iTnpYeEhZYmVq?=
 =?utf-8?B?UHpPam8xQXZxVklsaDdBL3QwV2dDaTVwcFI2WE1jK1BvZ3Ryd1NDZzljQzJj?=
 =?utf-8?B?UEJXd0tPVTAxOEh1eFJQUEI5ZG1tUDBSeVY2SEdTeEhlUmoyWFE3dkIvQ2JJ?=
 =?utf-8?B?MFBWemQ1Y2pSanZlVGZiSkhRendKZ3E0cnJxbVNyeDBESDVjRzg2eHVpRHI3?=
 =?utf-8?B?aDlEM3RHdDFEcDFtR3VmWlJDT0Q3RXdzeXROdW5WQnZkZXhiWHY4U3lrZm4y?=
 =?utf-8?B?R3N5UXh1cGVqT0laZGliQ1RyRnBpWEdPR3YvbW5lelNWMTQ1WW5rOEIxYXJM?=
 =?utf-8?B?SjIvRXRBdDFQWDVBbXFhMGR5QXNnNDZCUkpSVDBxVzE3UE13eEh6MEVMTzFR?=
 =?utf-8?B?S0UvWDFVSzA4c3RyK1NXc2dLTk5DOVp5VjRXV3dpNjRSdEZpVXRWQTVGL3VD?=
 =?utf-8?B?VHRyWnl6S0FnY0dEd0l3OURpbklPdXg0cFZVMlBaWG9ZV2dzY3Rrd1F3SXlp?=
 =?utf-8?Q?qffAhHV+7a1WW8/dbkYlR1ezc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d167535f-c8cf-4213-5528-08dd0929379c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 06:04:39.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYPU1Sj/gWrGJlGvIJC2av1q7KMrhmx6JMh/iJiSPXTn/MD+2TRvJJXwUaR4JKVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

On 16/11/2024 0:42, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 14:09:02 -0800 Saeed Mahameed wrote:
>>>> rx_dropped: Number of packets received but not processed,
>>>>   *   e.g. due to lack of resources or unsupported protocol.
>>>>   *   For hardware interfaces this counter may include packets discarded
>>>>   *   due to L2 address filtering but should not include packets dropped
>>>>                                   ^^^^^^^^^^^^^^
>>>>   *   by the device due to buffer exhaustion which are counted separately in
>>>>                            ^^^^^^^^^^^^^^^^^
>>>>   *   @rx_missed_errors (since procfs folds those two counters together).
>>>>       ^^^^^^^^^^^^^^^^^  
>>>
>>> I presume you quote this comment to indicate the rx_dropped should
>>> count packets dropped due to buffer exhaustion? If yes then you don't
>>> understand the comment. If no then I don't understand why you're
>>> quoting it.
>>
>> I quoted this because you suggested to use rx_dropped. It's not a good fit.
>> In your previous reply you said: 
>> "but honestly I'd just make sure they are counted in rx_dropped"
> 
> The comment just says not to add what's already counted in missed,
> because profcs adds the two and we'd end up double counting.

So this is a procfs thing only?
Does that mean that netlink's rx_dropped might be different than procfs'
rx_dropped?

