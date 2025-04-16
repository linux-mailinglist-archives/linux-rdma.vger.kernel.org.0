Return-Path: <linux-rdma+bounces-9480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1041A8B819
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92C1444BBA
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E923D2AD;
	Wed, 16 Apr 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yu40u7As"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474332327A1;
	Wed, 16 Apr 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804943; cv=fail; b=jy6lC+/TSATUOBJLuJ2CgfauY0R8toBwsi+LUkVfol+9z/pIqjvoMZLxhyU9eloJ3fIryQlyEBzTiPDzny5ILIZXg7S8pRcqE3DacDKKXtRd8GI8oPAkzkhF1jgFj8/smbUKbSAiaIgYzSqMbkurDXIvEuZOo0Vyv0NWc1P7vq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804943; c=relaxed/simple;
	bh=jYSSLjsnzQnoYPNtRz6GWl/u1bGiBQS2CZpoXpJ7SMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBubJdobf9kQE452yhNa9nj5RFN+hcYPaGrmRj8IQtz+UZ4+sV49LNElZGgelWSm4JhTayiNOdUbp4F1pEhLQP6Km8IYTfd6w/+kQkJkk6hOx64Xwp3K2O8cQ7IlZjdxcySoAWYTmDosbz/sIUyJxGi9BIfT5pFGK7zIBFoAtMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yu40u7As; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtR0iwcQuVqljLOQTaBO+tFGSYMm6v20qhBVQ/newRZzupVuNlEE2StEniL50EYb8QzR+ASajs1X78x6l53Hr+PCq3d269z+tzy8bUjnugN3KOr4cJ7LBaicrXzsBFQEwBzFkR7v0QVmf8Sd/QwRaiYzPL8p09927RpQvrWyrlyv23vsWHe3nS394Ncpqzjsgo/Hqu+aZUru7HcDcSPzaikDOFfMFwJcDX5Dq8f1FCqKFxjM16c2nKZAGr8/sQDImEatjktcdYMaCgtqLlfV/T3hhOjHWDXaroGXuapB6ls9mFazYmVX8fgHv29iQ6SB09qGdUGW3cu0o7fnXOCsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVZjJ+syV6a/tEQjdxtSZyR4V5oljUtmSGQ1bMLXToc=;
 b=g45FwNoiKVYRw9behL0pCW4M9UPz/N/qar5njXqAgMe85VgAK+3VkeWL33dqXZ7Z+LyaHb1V9RV8suZPGpRrFXYHRQAkhXqGHmcTSUIhy9n4fHNd9SXPlTWqYp83ww25mUEV886P7klTT+AUX9B1hjyl6CkgaEzMKB0hdRLMuIOmS+sVSoSp6AM0wz+HcgWQ7CSwdQKhsHiLyI1hyyKvwRvzvPddG8LrPQwist0ck3UCKw52a59ocha88NQru7sBoBjfFG/b5roWc5B2FrhH2vz/faqNYWyKr4VqeQQEyyWjNOcNfcf/iPO+MWGhOioQX4G46UqMtUGnWWdwiKcY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVZjJ+syV6a/tEQjdxtSZyR4V5oljUtmSGQ1bMLXToc=;
 b=Yu40u7AsB3y0seeWv8sjEkxOcJHhq8pqWl5XmY6CPm/4CoB1WvcwzObChpNcAbxEqoNLA4EueMYYEfafT68MNAVCLVLjXhlJ/W/RLfH+Av8NmzM89pVCMi1KCwhgHT00BKwD8deomAvXvQr+dGrk9i8bwr36HiyjxajMoZlrgh+/n8OmY3dLjU6W91nbPuKsiJIlwW3KBT59t7lrbOeUVjAXvKboVamw/3QA042Ph1luh5hrbvCZcqfj3FPO9XtfEwb5fWlg1fvRsyZBYbDfxuxQP8GYHBKfzsMfX4cwvGPUVc82tHYSzTt8NSNptahcTXxowIEep4du5ah5bcRCEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 12:02:16 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 12:02:16 +0000
Message-ID: <817d5a9f-63c0-40b2-8e97-4a29185c0455@nvidia.com>
Date: Wed, 16 Apr 2025 15:02:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] net/mlx5: Move ttc allocation after switch case to
 prevent leaks
To: Henry Martin <bsdhenrymartin@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.swiatkowski@linux.intel.com, amirtz@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
 <20250416092243.65573-3-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250416092243.65573-3-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a88b8b1-46c7-484b-bbdd-08dd7cde880c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXFlMnZvanJOdlpqOGE2Sk5oeFB0c0NpM2FHZ0xYZjZwaDdqYzNoODdwT21z?=
 =?utf-8?B?cHl6dWkvZ0w2MXNFVS94cTdwMm5VLzM5eGc4YmNlYzZmSGloa3pTWFBYZ1p5?=
 =?utf-8?B?eHBHd1ZueTltbHlLVWVXZ1pBUXd5cU04VExkYkliS0hDdkhXbXNYWFhVMVd1?=
 =?utf-8?B?ckt2clpZUTJhV2dwMEtCbjN1dTZUK0JEUkZTU0thSDBsclI5MGtPZlc5akJC?=
 =?utf-8?B?czVxcUZkQjA4TTFZU1VRaTE0NCsyRFVPWWxJaEptaDNVeXVzMzdLK1Irb3RB?=
 =?utf-8?B?ZkNvWEo2SWliOW9USDQwclBkUTVWSkxVZEhxbnY3bUY4VDFvVlowSk1ON1ZC?=
 =?utf-8?B?UjhaNmF0YXBVYzhVekN1TElKc2x6dVZOTE5OOWFEeXd5dnBOOHlMOThQazVB?=
 =?utf-8?B?RkhsSzZQeVRpNlpWV1ZpK0dVM0pQY3RoY1RkV1ZaU2lNWFpYV0FmOGVXTXVL?=
 =?utf-8?B?TDNKQ1R3Z0pmbG5EWDRzUE80VnNDeC9nR24zbzFhOTNjY1RoWmtORG1vQ3dh?=
 =?utf-8?B?WnRrSFJtRVZBWU5MbVI1Ky8xNWRVVEVnclNXUWthcEFVazlJTDhaZ1hTYnpl?=
 =?utf-8?B?WlYxOTMrTGFrNTNJNG9TVGI0eGZWd2hOYlJrREtqV0RlK2x6R0FYZGJidG4r?=
 =?utf-8?B?dUxlMlBXWW9oZU8vdit4SmhyRFNBSkFBRjF2eVFXakpzcG5PSkJLMHhWTHBP?=
 =?utf-8?B?eGtQUWY2UlRNVEszQkN4bWszY1hvSzlld0t2RFg0Z3VXUldWUzIyMVFpWm1R?=
 =?utf-8?B?K1dscmNKUTRabUs0NlB0dFhjcVRmL2tOZVhZMGdMQmtYeEFXdWY2NFhmeUIr?=
 =?utf-8?B?cTRtWW9Qai9NcE1tRWhzS1dJalhVT0NtenJZcmdzQWE3QkcyT0M5bUREUnZS?=
 =?utf-8?B?aVZRVVVQcGxSZ29TR1VZaEcxeUU3S0ZTa0pMM3JibngvTytqbS8vSVBpYWhv?=
 =?utf-8?B?cHdtQXFwMzVGWExaSE9KNURVa0UxQURlNHlXMVVBSjBHZ1VHM2Q5bzZZNnVR?=
 =?utf-8?B?VVd6cjR2dFZKTUErWkRvY0NoMUZaczViVW5rYlBvdFJsSTNqd2g0QytZQjJ2?=
 =?utf-8?B?cWNSTlBlUGtCQjZoeDZlUHMrSk9VU280M1pQQzVGMWZyV0dHV3paNWt2ZGhJ?=
 =?utf-8?B?dlZ6akNRK25PV2pVa1B6WEZyaWtoZ01ZcFE1VHhsRFV6N2tQRWpJV1VJNU1R?=
 =?utf-8?B?Q0JiNHZiMUIrOTB2L3NaTDZ3MEZEZlJaQW5XaG43M0NxUFZlTkFJOTYrOG80?=
 =?utf-8?B?Z1V3MHRFcnl5QTlWeXdncUFJelZjc2luQTh1YTFmZ24vUmppaS9ReEQ2T21M?=
 =?utf-8?B?MlQ2dUVnSXJZWnpXYmI4UUppOVpRQnNYcXVqd044THluZVpwMEZ6VVp0WlhZ?=
 =?utf-8?B?MmpJakk1L3hkeXZBTUxndVFKd3F5S0xRWi9GM1JNQVdTRHdFZUtnaXlRaFoz?=
 =?utf-8?B?YlMweHVkcG9kTzlaamRaK3dsNWNaT3kzclRlT2tQSzkxZTVNc3RtUmpiUEh2?=
 =?utf-8?B?dldPVWJVblpJQkpZY1FmNWl0RGM2WkhBT1EzSVJ1REZWOGJCSkZ4akJ5L2w4?=
 =?utf-8?B?Rm95cUp6eExFMVNTTWtXS0JEQ0Nkd2lsYUo5R0hFTk5md3lQSzViRkdvRzgw?=
 =?utf-8?B?T2djMEpSTkZxWVZJVng2TE43bVJMTFVhd0kxdVFPOWllQmRkUE9HcU5rRGFU?=
 =?utf-8?B?OWRReG1wTVhUS0hWeHZSWEQvcGNPY0VEM0dqcWN4LytGd1FPbXEwdEdmS05V?=
 =?utf-8?B?ejZWWVVXWVRtS0QxUU1XZThwNUV2b1BCTGtiV1R1WUFIaW9jNlJSREJMK3pl?=
 =?utf-8?B?RlVBekFJVHQxemp3dXBuU09uYmFsdkxUSDY2YXNycU9CczhrbG9ISGE3cDVZ?=
 =?utf-8?B?bUtQTnQ5WDltTGFoZkZCVUZweVlMQTdiZHR6VjFXYkR2RGsreWNLUXBhSGxv?=
 =?utf-8?B?QVQrdFFsbmJsbDc4QUdqRjB0SmZUS09lQlJYYUNkZHV0WnpVelp2YWwrMndj?=
 =?utf-8?B?RXcvMGhjVThnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNwL1h2eGYyczU5ZU1NRFVHSHlNdldSSU81d3FDM2UzK09HNkpyQjFrNXIx?=
 =?utf-8?B?VE42NGROUnp4SG85YU8zWWFTdG51Q0ZSa3NqUEZtYk9RYmZxSENwWXdZWWZ5?=
 =?utf-8?B?cklmRG9yZ0pMZmloenZjZlU3WjRKN1pSTDZ6Y0tKREp3VWUyc0dSalVCSGh3?=
 =?utf-8?B?MDJucnN4U2VueG1FOUJ2T1p4bmo4eG1aNTh6TEg3Y01FRXJhRmwybGlJT1FC?=
 =?utf-8?B?emRaeXJLNW5VRXFzaEVPQnR0bk5seTR1VEJsNERTbmI1a0JrSkdsdXkrVUFS?=
 =?utf-8?B?MHEzdWlkRzlxWEQ0aFJtVXJvU3NaTDdtRUwwOERYZnE5Q1pZaHQxUFBlRkZt?=
 =?utf-8?B?UXJUTkxVMUlyTTVlR0x4UWZJZ0tzWDEwZnVCQVprUlJ2cm5GU3l2eFJkS1FR?=
 =?utf-8?B?RlhsaVpacUpDZE1tMVRrYy8wOE5rUUU0a1p1cGF5MlJ1aVMxcEJYTEhGdE8z?=
 =?utf-8?B?K0xIUG5ZWGExUkxjeEJwc3U2Q05uejdyWmFtSHFIRFN1eVpRWVRCSW9BcURr?=
 =?utf-8?B?Smc5cDZzTmVhU1gySmxvR0lnREdqUHJnYUJmVXVKS25WcWxTeTVBRXdtdDRJ?=
 =?utf-8?B?cjNDakt1bFFGc0VtOWFNU0FQQWlWYVhtbW9UOHBYZk91OCs2KzVERHd2WldM?=
 =?utf-8?B?ZU9EL21IYXVnTUxMejBEbFdJZHRsWW5FaUdBWEhlLzBaajR2UGl1U2VmYWZt?=
 =?utf-8?B?MndGaitXMDl2YTdqN3AvWXZaKzlNa1I1aHBHNUYyd3h5RER2Q0FnRHJmdVlO?=
 =?utf-8?B?U0J6OCtYZlVjOGFBeHczdXh4d2M1OFFrQUgyRzJMSWRMQWxTVVlUbTBXZjhM?=
 =?utf-8?B?RVJUc3NWY0lrSkpsVmFjaUYrVmdpUHI2TTIvd2k1S0laKzRJK2pFRjhOSjRW?=
 =?utf-8?B?eUl6NlBQcjJNU04rVWsweTRvUy9mQVZXOHhEc29Ra3Noa2NScXlpM2VnT2Y3?=
 =?utf-8?B?SFFRSHc5TXdzeTZCOHozK3ZNMXQ1b25LclY4T0RqUWErcUpmUHJ2WThsSWZK?=
 =?utf-8?B?d3NhQlpzQmMvMkV1NUtsN3dWRk94M0FYTVJ4NW1Kdm5hamhnQXlQNEJhUWdV?=
 =?utf-8?B?Y0NwUkdBSnN2SEVoMGtkYm9xaGUrS3RxUUZ1aEc4MjVQL0p2OCs1RFlSL1hk?=
 =?utf-8?B?dTlMVC9xODRtdnJENTUveGw1ZDAvWFRrQm5ZdS9BMndHam9scGRreXNoL0NU?=
 =?utf-8?B?VWNKamx3S3JmSXYwMTFhT292eHNWSnNvNXhuejd4WG5Tb3hOcVhzRkdBT1NH?=
 =?utf-8?B?Q2xOMzE3UXZ0cHlyV05TNUdrNXprZFJFV3krL3hzS3FKa0V1N2Mwa041amgx?=
 =?utf-8?B?ZlBpWXFGaXV5SjlBMDlqenZyQXliZ2RaZTgxK0VBb1pDRktPQkF2UmFsVkU4?=
 =?utf-8?B?cW9OODI1ZTlSank2V3pPKzI5bmVFYk5lRlFFYkptdnRJSUJQQlYrNHIvRWti?=
 =?utf-8?B?VnZCbXc3eWNva2dDRlRibk5YS1NuVUJtV1JuNjA3NTRjTnFra1p4Sll6SHpr?=
 =?utf-8?B?d3dZWHozYmoyUDUyYjcxYkJiMVgyMFRyeURCVTZYaGJTaWZncVdqWkROdm1w?=
 =?utf-8?B?Vi83bkVicjY4dmt5TGVISTZSMzh6WTg1ZVNpZ1dkVkpTRE9Dc2dhRWNtczNE?=
 =?utf-8?B?R1NxUEJnUjU3Z0hNK2tMUU4xWU9NL1dFSlJzNmJzZFJjSVlKVmx2WVRhR053?=
 =?utf-8?B?cldvaFVPNjAwZUY3a1N3dzU2cjN5eUJWYmx3T0VWREhRYlhpZ3JJYUU3UGsw?=
 =?utf-8?B?WjlHeWwxRk9DOVBrODFtNXFRVVdVOUkreDNnZFd0bHNiMHBGaS9FWG90QnQ1?=
 =?utf-8?B?VnNHaWJFcUZDaU82cGlsTm5ReC9NTmZYbEpkQmNGNDUrb1hKUmhFSXN1eGNB?=
 =?utf-8?B?U2lHUTRvMnpXM3kzaGtoNUIvYkprUUVVT1ZWcVFZa0JzaGFDR20ra2FVVTF6?=
 =?utf-8?B?Q2kxMC9BTHlFdmZ0SllkNHpUWEV6cE83aFpBM2FzcEN1RFdNNzVzY2U0MEtn?=
 =?utf-8?B?TGxkY2FJenQ2QVRvUHZUNXdSOUFVOWdEU1FMdXFDb2c4Q0FaeUY4N2Z1U09T?=
 =?utf-8?B?d3ZrVzFmaC9RQytIbE13N1MybkgxaXU5cGF0MXU0bGNhUFFwUGVMUHJSVGlY?=
 =?utf-8?Q?MfeT+QBz6PS+JEe1IXRsetKrN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a88b8b1-46c7-484b-bbdd-08dd7cde880c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:02:16.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s7je+PEZgtWpJBSPuFMis1A5gy1eJRtAQvqCqAMwxaqWrk7Sn2OL0nuxXddupK3YxMlBhhCKLb+lrplqfbbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794



On 16/04/2025 12:22, Henry Martin wrote:
> Relocate the memory allocation for ttc table after the switch statement
> that validates params->ns_type in both mlx5_create_inner_ttc_table() and
> mlx5_create_ttc_table(). This ensures memory is only allocated after
> confirming valid input, eliminating potential memory leaks when invalid
> ns_type cases occur.
> 
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index 066121fed718..513dafd5ebf2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -637,10 +637,6 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  	bool use_l4_type;
>  	int err;
>  
> -	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> -	if (!ttc)
> -		return ERR_PTR(-ENOMEM);
> -
>  	switch (params->ns_type) {
>  	case MLX5_FLOW_NAMESPACE_PORT_SEL:
>  		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
> @@ -654,6 +650,10 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> +	if (!ttc)
> +		return ERR_PTR(-ENOMEM);
> +
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>  	if (!ns) {
>  		kvfree(ttc);
> @@ -715,10 +715,6 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  	bool use_l4_type;
>  	int err;
>  
> -	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> -	if (!ttc)
> -		return ERR_PTR(-ENOMEM);
> -
>  	switch (params->ns_type) {
>  	case MLX5_FLOW_NAMESPACE_PORT_SEL:
>  		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
> @@ -732,6 +728,10 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> +	if (!ttc)
> +		return ERR_PTR(-ENOMEM);
> +
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>  	if (!ns) {
>  		kvfree(ttc);

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Mark

