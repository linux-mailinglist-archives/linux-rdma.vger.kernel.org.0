Return-Path: <linux-rdma+bounces-13342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF3B56AB8
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D2A189CB8F
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB626A1AC;
	Sun, 14 Sep 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XgeRGA2W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3419C560
	for <linux-rdma@vger.kernel.org>; Sun, 14 Sep 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869450; cv=fail; b=fivtVgUkKxVoWfTkBvxkBbiBgv80xpJKNBiuiTVMyRamPOK7tPfpl/C8DeGkKEuwRAEzQeW9PdbwAptN2l88nDZZspk7XRWLSLtl/yecG1K/5psNo9ZZUbV5EnnErwHrvwYaJmtDKHJ5f4UrnbDwPkEh9w+rm7j6saJN6UZH2k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869450; c=relaxed/simple;
	bh=xCz1jv36118xrFnz/bs2Rxb47LLAfPFfZhsd3wEko7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KyERKpgSe3/glyUDuU3Msbni2VwK0aQPea+/HGnybgD0t9hBEwg3y4Ja2vp4gV7RXSO1uuqEUmOFwo71dwzaVAgUQ4Mv2G1nsL+e7+nHXKmWocdXfXCTsJHcnJ65iVwfjG8BRrSeEISILUJd8X5hPAbicps2d4s5n/UYlzCqLNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XgeRGA2W; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDIJYyu7qpETq18joGicwqnD+uhsyjBID8G0ZoIaLakY4xj/63Vs8AW/IFQ5ugVUJophptonPEwLoh5vqPK6N/O36JYtTKFlrDOGewxLcFCJsEe2SI0CxixxcWuMqj0ccHCXOG30W1trNA9Al+InhY7h6fBGhlYLUuczxlmP+/C1ozrSZCeVGvDxn0OTlKN/O9WgVNTgW6gXXsVtFYs1IBlCSsFwWUifEiX/ggGs5TOYyham1f29RtCN74Dclv+Kgai/V4taohkyynwOqCYPObn26kbMeLtJKBVpnEcS3U3ExtF81Gun1i8quwe10rJpdFRK7ylXgd6gxBvp0YLJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYEH5xIOjx/qTtFj/tdGhINdshrEEIQThv1qZkoa2Nw=;
 b=LL37vZVz6aaEGdYmFyasDjcq7L53wpJvXyZ3c8mPmy//bMMQWBORSv+80I9kvWMhkmeI3zH1JXWeF/WIJMI9j+7jq95Zri6SttDKrIfR2URujnEuqG3Nd296JLuc2/odj9iqQdWpW99nArSbVJbKmIrGxGjB5lTINjwJ+jY+8ZoUlaaU5O67Tra881e6vChefEjGhu6tiHdOFXHM20cosCm6zWorPVaWo68epdlQDWCOfrHl569RWw2ZRxthEDWmVp/3Wml6YRNyx3Znb04fc7m+8Ue8BDDE0l2WJauBp80zXIHOcbzMLAATG6I+KEsx87EPSNfGgm68jyRL083dZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYEH5xIOjx/qTtFj/tdGhINdshrEEIQThv1qZkoa2Nw=;
 b=XgeRGA2WfIx1RBLoqGLw2peozQ1n7OUPI1c4hs1cG4YsrJJANrDHZP1mlgyggKX4mYnRnO/TyT9TaJ5eXAd+gLFq1qCf/RDHZkG83HFBEAUz3Q7qNqsrhPikjFW98FLAnqfcg0cMMhrYwSKvdvjCIt2VcS4n3eO0VRGeL+dBezPf6RhkfW1eATcIxdKBJ1msReOq40zkN82yt0TAMzgugt3E/ivZl1Xr7VOcBcd4MyqWivEqWT3cePWH9vNrDHUeRNfdUqIY2qt5fV8gFTmVrE6/E2W0IH13DYBfI2D5OZRzvdwMIJIkqq9WPAQ1fMk76psySZejd0D5GvFzTIe1Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 17:04:06 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9115.020; Sun, 14 Sep 2025
 17:04:05 +0000
Message-ID: <4cc4cff3-d584-4d18-8e3e-b9d73d0837a0@nvidia.com>
Date: Sun, 14 Sep 2025 10:04:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net/mlx5: Implement devlink total_vfs parameter
To: Saeed Mahameed <saeed@kernel.org>
Cc: linux-rdma@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <aMQWenzpdjhAX4fm@stanley.mountain>
Content-Language: en-US
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
In-Reply-To: <aMQWenzpdjhAX4fm@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e13f86a-1c90-4f09-a455-08ddf3b0b67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RRcXhpbWFtbFNQTk5hcEs5VkcxVHZyNlBaL2hrbVdmSmQ5b3RsQ0VTQ3Fa?=
 =?utf-8?B?dG9ObU9qeCtsOFQzK2J5d0Z3cVQ0Z213VmNNb25KR3M1M2V5bk5rdk9ZRVpw?=
 =?utf-8?B?MHZsQ1NmNzhSUi84TkhkZmRpU2g4UjNMdytlVzZXUFVCNzRwQ1VZaDkzb0pG?=
 =?utf-8?B?dDhSaXVGSjNMR1JTQW1DbkUrKys1Ly9vMUpWaTNSSStOeTd6VzRxb1pJeVBR?=
 =?utf-8?B?S2xrOU5vNzlEWHA5NncxWDBMZE9TbVNDOHdrUnJBaC9vWjF6aWl1U1V6TzFp?=
 =?utf-8?B?U0ZrZmJYbHVBVEUvbVhmcjBpZHJJQjc2SGdVenYwM3l4MnA1ZlQ4OXd4ODlH?=
 =?utf-8?B?anJJNWtjdWRtd2dDc2tBazlKUThtdHVTdllDRG12V3lHUzFCYkE0aDNwK1Fh?=
 =?utf-8?B?cWxTUlB1QzFKdXY1c2ZQeE83bzVxV0lWZk1WRmhQKzg0eGE4akdsS2lOMHRJ?=
 =?utf-8?B?TzZHNGFkNXRKdTFyM0NQajR1bjZ4TndkVkRiT2dDS2tvUjhndWxmdXFkamhp?=
 =?utf-8?B?aHVNTk45bk5vVk43MW1UeTgrcGdqUWtkUHhQSk9LTDZUZ1pZcitvajZtL2dY?=
 =?utf-8?B?akRRdTl2a0cyM2lYWk94TVlUSml1cSs1YVVvZW04WkRvbmNvUklQa29HZ01n?=
 =?utf-8?B?RzNqOW15a0FYMjAvSWVCczJvK0dJYm9KT1YvWVhjdU1jc1hUaUlkYVExbHV5?=
 =?utf-8?B?VC9HV1dGSDZaWURVd3ZwVGx0RVU5VDNjTE1sR05EZnUzVG1uQnNFM1E0NkRy?=
 =?utf-8?B?dys3VkRxUlJRZzlYK2JNU2M4YkRRbVpzUE8wNjZDNjdEOUJYaS9jTVFxbjho?=
 =?utf-8?B?SUhUN1lpaEVFMkJaZ0V0eHY5VFJEbG14VktJUlNjakxwOFBKSHJLTHFPRHB3?=
 =?utf-8?B?UGlyY2sxU1JEMDlvREFUMzhEd2ZQNU42eGRoaUtIYnRDUTQ1OW9VTTFIK3pI?=
 =?utf-8?B?ZmQrc0tKK0RuTUNoMnVNcVFkSTVac3l3YmJhUVMyNXBxekxUOWZ6Z1NJU3Vx?=
 =?utf-8?B?NEMzQjNCWVJ0d1Bmam84cmdjcWNTZ0xEaUF3N0FSU0RIOWc1bVFCeGNDWXlW?=
 =?utf-8?B?S0l0WE1BejdWYThHVkhDTHFoK3liVWp4WDZNVTlLbFVmV253MjB4ekNYSVE1?=
 =?utf-8?B?K1RjRThPM0dvamhHOEpDa0dqWk5MVFlCZ21XSXZKd2c2L2sybFMwWGpkeGZW?=
 =?utf-8?B?aTdKeTl4dUpaNlN4TTV4STVNNjhtLy9oZExJU3hUbXhMNVQ3d1pGUWdCM1U4?=
 =?utf-8?B?emZSQjVDVmhNS0wyUjE3TnpCbll3eDdCbE44LzV3ZThHQVBMUjJVMEd4djJ1?=
 =?utf-8?B?MDR0NGRkNm5Ra25vVG9JdEI4S2J3L2lPQkR2VHdhN28rcnMyelpjUFJtOWNY?=
 =?utf-8?B?SFJEeW9MVndyWUlMUFNoRER5MFJJN3J1UXBsUkRhbHJnQVFTdmpML1NkcWpC?=
 =?utf-8?B?MnRIOWNBR1B4SWIydE42UFhOTzdFY1ZTK3c5dEJZRG1sTWJ2dDgwRm9PUjdN?=
 =?utf-8?B?V0VUTGZ6SW1DVTZoa3JwZFd5a0lnNjdiN1A4ZENUTWxQQW8ycStlVEhMdFF0?=
 =?utf-8?B?UThCVEhWaHUxd2dMOVVIRmhUMmFGcUI3UGZWY2ZCdmFaSG43RWt6dUdEaU1K?=
 =?utf-8?B?M0JGOEhzWEdteG1EY09CMzFCdk56cWY4VXVaaHU4OERPTktWUHFsZWtGRVpq?=
 =?utf-8?B?dWxxb3pZWEJRemhDRVlzK0pwOEhSOTZMOE55SGdlbTFEZkZUb29Fa25nUEtP?=
 =?utf-8?B?MmhzS0wvd3pSSXpKdkFYMlZsOHlYTFM5Vm9VY1VINzMySjFiWXAwUVd2dzhv?=
 =?utf-8?B?WTFoQVcrNUo1THBjSUM0VUhLUXJHVThZV2xLVENFTTZYR3FNeXRKVjBnMU9O?=
 =?utf-8?B?aURLSEt0dkZLK3I1Qy9wc1FDelo1RStFdXlGUS90bzd6Y2lRYVU1d1FVWTcx?=
 =?utf-8?Q?yTh4dIOmyyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rld1SHJvNUlMb0dVb25LajhRVGhWZ2N4Yi9xZkRVc25kL2wvWmhDM0N4cWZM?=
 =?utf-8?B?VndMN3duU3U2WWZJd3BQU0hSbCtZL3FHdmVLRStmdHhmU09UZHM1MXRVdlFG?=
 =?utf-8?B?SklLelpjaDE2K0NPNEVVZTluQjV1QUhjTkdLTEtmZzNjUVE1OU5OL0V0eTlF?=
 =?utf-8?B?SW5OWUFlMG5ISUdJOENNK3ArZW0yaXhneHhRNWM2WGExL2JzWXpsNEVTQzIz?=
 =?utf-8?B?K0R6T0ZZUEZrZmNyNmppY3oyMjRzdnU4SmViRHZmTWtJa2dDcW05RGFFWUNh?=
 =?utf-8?B?Q2VjZExpZkFyN0o5cGN2b0JEWHFTNCtka2x0cmJFUFpCYml1OG1IU01IMTZ6?=
 =?utf-8?B?bXhsRkt0SG1NRnhrZ2w4S0FYUDNmMjBjeHhVdW9KN001c2Z6Q0dYTlNrVGty?=
 =?utf-8?B?UDU3NDJLMytTRngrZ3dSWmp2VUUwSUY2US9Bd2p2aThzT0lkWTZQK0UrYTVB?=
 =?utf-8?B?V29rdnpiSEVORC9Wa3o3RTRldXpBZHFUekIrQWQ2cGJhVEtoTjhsdWg5ZWZQ?=
 =?utf-8?B?RTA1c2pNNE9mdVdkeU9FYkpJK1Q4Y0prbUI3UW55L0hrOVRiVnZWVlJOa1R4?=
 =?utf-8?B?Rng4S01taHZoaEF5N2pNajg2UGdaSTRITVA0c1NRZFYxUWZkQ0FhcStxK3d5?=
 =?utf-8?B?RmF6eW1NQTMwMFIrZ2tBQjN6a2ZQa1VjREFjK1N3WDFQYXZIa3JIcWpDeTRa?=
 =?utf-8?B?MVQ4bHJRTWJmbTNjSTJqc3RDMGdFaysrbEErU05BS1B0aWVwZlA3SDR0T0JZ?=
 =?utf-8?B?cnQzOXowOVkxSHMzcVVZSEVBc0pMRmgxQ0VoVEtqV3ROVUZDSlczbVF2RVhq?=
 =?utf-8?B?bXRlZXZtc3lqVSs0alQ4ZVN5Z0prN08rd09hMkd3VDlkYVBLSzJDQ0ozNTRP?=
 =?utf-8?B?WGsvRWdUR1E3cXU3Snd2RE5hNFc1QkM4dXcvTDZKOHZjMmtxaC9nR1c1ak9C?=
 =?utf-8?B?NnRrSXczZXhyODlmSDJGbEJKejI5STRUNmxLOWxEb2xlZkw4OXJ1eUdwOXpL?=
 =?utf-8?B?cVZ4cnRra09FOGFrRnNKbFYrbDJ6TzYzVXBTamlPZmRhRzUwTFByaEhoRGl3?=
 =?utf-8?B?OGlqN1hPYUJEdVB6OXJDTzltTzFIeUNJVkE1QmF3eklnUTV3dHluZ1FDZ0Nn?=
 =?utf-8?B?SnFSRkEyNGlQTW5FTDVJRTBoOVBweFF0cFlmVE1aMUxuMFBLV0VOR0pGL0Zh?=
 =?utf-8?B?ckJLb1NjSWVVZ3BSdTlNalphN0ZHb0lJNjRvbDlaaExVUytRRWJKcDFSV1Yr?=
 =?utf-8?B?QjJjbGp2Wml1d3d0RmhnSUhNNVRRL2N2YXJMTEhZYjRBSGFDa1pzMEh2Z3Z6?=
 =?utf-8?B?Q3FvUVlTdzNsNldOMFpsQVV6ZFRjNGVPa0RiRHlaZDR4TFJCRENFMzdWbnNV?=
 =?utf-8?B?V1hycEJIVk5oNmdaYWV1V2QvQ2NYbTM3ZkVBRDY1NlBkRzR6SDBBaWpDSTNY?=
 =?utf-8?B?NzlaZ0pRYW1JU0JmYlp0VjdHVE12emp3NzVsQ3ZKVDBjU0pwZ2d0V08rMXF1?=
 =?utf-8?B?aGczY3c2S2tYQmZyUHhUckF6eE8rVjJxdWVCaWM2SDQ1VWlCMHIvNGUwbGN3?=
 =?utf-8?B?VFJBQ2x0SVY0ZVFOWFEzRkJkRTZTT01jeU83aWhUSmVxb0Q5ZldBbGVSNlJD?=
 =?utf-8?B?RE1Dam1JNGVoUkpmMmFzY2tlc0Q3aTNxZkpGdUFDb2NiR1FXdWpTNDR6SDY5?=
 =?utf-8?B?U3ZLdTZlZHNFUlZKeWY4c0QreWl0bWpneEhDY0pXdGVHL1lMdDkrRklxTmpq?=
 =?utf-8?B?ZGx6UEUySlFaVFUzOCtzWHQ0Y2NSdjBmVEZrS0xOU1BiZmJ0Q2hPNHRpZDlS?=
 =?utf-8?B?NXFoR3FNc3hVWFhCTEU5UmtyeERLZ3ZmY2RHUytzOVAyR2VHWVFXSkdWaTg2?=
 =?utf-8?B?MHVWS1hiWWlPYXJXZWY1bGdWSHdDczlmN1JrK3JmYjBPNnNHQS8wc21Yd09X?=
 =?utf-8?B?U3FtZ1FIa2oxMCtIM0xlWnYwZ2JJc1R1WWpOZ1o0a0FmeE5EVnlGSUZKR2k3?=
 =?utf-8?B?Tm16TEQwakFraHBmNi9uWkhpZlRnU2R0OEFWVmRIbUh4THRFaUxXUVhUaEEy?=
 =?utf-8?B?RmcvSlNJSXJDVW5xWmpYbng5ZEJSaWVRcWZlQ3lLY0h4TlFYQ2drcCtuajFY?=
 =?utf-8?B?SzF6d0dqUzhWSzJJVHdhMktBMnR4MEUzMXlteGVCNFFBVWhFMGJnTWRRaTBC?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e13f86a-1c90-4f09-a455-08ddf3b0b67a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 17:04:05.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1sA39rjS779D+iyDBlXR3tHFFxD3V3IQ6yklSIDnNy7bOYajoEJqLQXHU8m57Rj3w77sewBQN96emd8s6u34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

On 9/12/25 05:47, Dan Carpenter wrote:
> Hello Vlad Dumitrescu,
> 
> Commit a4c49611cf4f ("net/mlx5: Implement devlink total_vfs
> parameter") from Sep 6, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c:494 mlx5_devlink_total_vfs_set()
> 	warn: duplicate check 'per_pf_support' (previous on line 479)
> 
> drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>     455 static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
>     456                                       struct devlink_param_gset_ctx *ctx,
>     457                                       struct netlink_ext_ack *extack)
>     458 {
>     459         struct mlx5_core_dev *dev = devlink_priv(devlink);
>     460         u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)];
>     461         bool per_pf_support;
>     462         void *data;
>     463         int err;
>     464 
>     465         err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>     466         if (err) {
>     467                 NL_SET_ERR_MSG_MOD(extack, "Failed to read global pci cap");
>     468                 return err;
>     469         }
>     470 
>     471         data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>     472         if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
>     473                 NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
>     474                 return -EOPNOTSUPP;
>     475         }
>     476 
>     477         per_pf_support = MLX5_GET(nv_global_pci_cap, data,
>     478                                   per_pf_total_vf_supported);
>     479         if (!per_pf_support) {
>     480                 /* We don't allow global SRIOV setting on per PF devlink */
>     481                 NL_SET_ERR_MSG_MOD(extack,
>     482                                    "SRIOV is not per PF on this device");
>     483                 return -EOPNOTSUPP;
> 
> !per_pf_support is not supported.
> 
>     484         }
>     485 
>     486         memset(mnvda, 0, sizeof(mnvda));
>     487         err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>     488         if (err)
>     489                 return err;
>     490 
>     491         MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
>     492         MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
>     493 
> --> 494         if (!per_pf_support) {
>     495                 MLX5_SET(nv_global_pci_conf, data, total_vfs, ctx->val.vu32);
>     496                 return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> 
> Dead code.
> 
>     497         }
>     498 
>     499         /* SRIOV is per PF */
>     500         err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>     501         if (err)
>     502                 return err;
>     503 
>     504         memset(mnvda, 0, sizeof(mnvda));
>     505         err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>     506         if (err)
>     507                 return err;
>     508 
>     509         data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>     510         MLX5_SET(nv_pf_pci_conf, data, total_vf, ctx->val.vu32);
>     511         return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>     512 }

Dan, thank you for the report!

Saeed, it seems like this was introduced all the way back in v2.

Vlad

