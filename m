Return-Path: <linux-rdma+bounces-12529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD525B14EFA
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A016E4AB
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4B191F89;
	Tue, 29 Jul 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZJzcywI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E971428E7;
	Tue, 29 Jul 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797793; cv=fail; b=bbdd6c56SD512x6tUHBNoQM8YXUF94JNVRPjZAyhSVn325bcCBb7ERp0t53oo7T70nsLn2xTS3Z5+YxzT9VNh4hcm+DfS6MwJ1e8GLxEkrnplr47bfY9NB56GVKhBQk8EnGnQkq4GdP4clsveigR71lBleKiE1yjLuVVa3z3X2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797793; c=relaxed/simple;
	bh=DRmHsdWyTTpx/+YPVM9asHFpE4lfFUsaOpt17gwP1xI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/K54dGWp7qTQS8h6VGl8YlXw9EO+dWJzpiMRTm5j58uxk0cAo2dqlo7JNKLecrrLKLxWwkWXCzPjDzvkpuvwJVrkZt3gV2KJuFgwPLWeAS1RqzehzxUHQ+w5pQFmo7L+2E7IXUHGvd/tvIk10FxVaSlcVztlOPZyrVqY/CjmP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZJzcywI; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgxmQFUY9e1BDcnachgPH/np/oVNfZEtUCE0YT5W85f01yUnbF77RLMzmxOmDGnYMyfyTAUxFeDfwFDk70KdINJoRZCLkeDneEFhEt0i75Pz13SWPxssr2PhEvxRApS3ErGph5feKf/3oXBtDam8YA5MECncyIQglPjgE1aw/UsZlx0qoY6ITd9TZ0ddDZ3t1bwBv8Y5JPlC5QLgg/3HwuhnHmx6xDEVhts5agmE6DJ3Z5HbCkF0RdiVV0coVBLp7C6E7acAF5ZH5mwwF6sPzx34j8GvQ5EaKpSCav20LDU14dQCm1ORqBn3evs3oDmiTRNX0OMlXr7CdQcFJANBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWtPhg1236m7nM+Mj/mPTdl1vqRYd6gf7ms1T7jXDcw=;
 b=oUi3swQUEn3GKKtLNpcVLkMd/zw90IVKLc7ur4DDWc9AB/pXmu+3lvoKDnC0q4GYY8Ia18PutPdUtJLlNLmiVqvKjcv7Jskt9Pe/dmp73r6ypMx80D6J+soSCIvNOuf8e2vkuz7uZgHzjzbh2FS+wLpQbtZRAI245VdLDgx27tc0gDBWFjo10Sd/I1I4LnwJyL1vOLfUuhvm0o+sRWIjPc4N8m4oNl2E0/NRcR/dQekbtqB/+0OGZrgTvQeZihZ7YlKjNxJo8sJOx08iVijQVi/dpwl00MnOr7S/NuBf8STzAdsMFsBMz/BgyU0KFPLw84367Of/v5zyRwgV5xM9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWtPhg1236m7nM+Mj/mPTdl1vqRYd6gf7ms1T7jXDcw=;
 b=nZJzcywIjqLsVUTPqFC7nWbdpR5f3bTkN8mT7rKJHUqUXuD5oIQWc4x3jYRELR9QWChZrN7/OhPFXtiI246iEqUDpLqn9zO2oZ7ADPQozIwvBk6IRz4eJYgCqKFi1XctZXgO+p0941Hde5OYI0vjx5YVY+XH8Jg23/3kZxiUyonq0Kr7mFkJO7OwZzlEcwxRvgGBMqRfvyGQhqBLaV8t9ja4TMMpH3FgVNIjm+9JWluF7Ha0j5EHvIA5luTtgyieAl6BNOSrP+lgPH+AHc9UafdVU2WXw90iHCaIIQCwePm0xJCe2pNPrPnIIqyKxigOz6+DAzSweVAYnaR22bFJWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::992) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 29 Jul
 2025 14:03:05 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 14:03:05 +0000
Message-ID: <6d3fdda2-e0dc-484e-8f29-3010b8b5da78@nvidia.com>
Date: Tue, 29 Jul 2025 17:02:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: Christoph Paasch <cpaasch@openai.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
 <6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com>
 <CADg4-L9osR02Aey319fMVAyAYXxOfaKqWcQ2AsfQCrdFKA5vsQ@mail.gmail.com>
 <CADg4-L_SNAKy3mBn7ssq7uw0_+wZ_=zyqrQ23yVTOo5J7z7Q=g@mail.gmail.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <CADg4-L_SNAKy3mBn7ssq7uw0_+wZ_=zyqrQ23yVTOo5J7z7Q=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 74496073-d0af-45f7-1826-08ddcea8a340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b05MQm15Y3dWeU5wZUp1S0NZQlRDZkVsbmhMMUd4cjE0eE1JTnczWjN6Snc4?=
 =?utf-8?B?ZWZYbEg1dUptNVlhUk9LL3hMM0FsOVRwaWQwNTZiNGpCYTJGMWl0dnNhNVBW?=
 =?utf-8?B?eHIrYnFSSEtONm1iR2VsUEZGR2RmVVdFRFd5TjFZc215bWNobnR2R2xwTGsy?=
 =?utf-8?B?a2JuSWF3T2FwTFJ4bnUvY25EcVdtUUx0MkxPYTVUSnluNkoycC9GZ1hRc1Jh?=
 =?utf-8?B?OUdBeGZWVytzUGdwOVhwV1ZFUEt3L1NoOVFKTGMwS3NzcjBFUDBGaUxHZnpF?=
 =?utf-8?B?T2k5NDdUMDZ5c3pXdEh2c3R1MGw3c1ltMFVzVlJLcXUvRVlrak5uQUxtSDFx?=
 =?utf-8?B?YVFweGF5dEszZU1sSzNvc3Y3a0xhdTYyQnJYQ0N1czJ5Wlg0ZkIxQXZQR0Ni?=
 =?utf-8?B?bUxBdG5SMDE0aXVTS3pJNTNGby8vUERZdnZ0bDA4bTBka3krdCswT05OSExY?=
 =?utf-8?B?cG5LSld1Y24yV0E0YTBYemJSbk9uTDgvWWRRckkvbnUxeCtodGp6aFhLU1F0?=
 =?utf-8?B?bTVleWlENEdZRHNuQ1FOYlF4djA2c2ZvWXpQWkdsN3dvR20xNzF5YTBlZktR?=
 =?utf-8?B?Z3U0cWFVZjYxdmk3MnJ0RGkybDQwa1ZkcGE0QUZQajdOZ09xM2JqbVNVRTQr?=
 =?utf-8?B?ZFlUMDEySWVOdE1KTGJTR29tSitHNmVMOVphVjRCS3hSNXZjbmhLWmFiOGRI?=
 =?utf-8?B?Wm45WHhGSmpENnVCZlVGR1J2dDRMYThUZmYzcUZqYWplWDRRd2kreUpmbVNo?=
 =?utf-8?B?MGdoSmFhYVBUVGxtTmNjajQ0MC9tUUQ5UEw4U2NIbDM2dGgveERGSWpJZ1Js?=
 =?utf-8?B?RmxvTjMreXZWQ0RPekUxRXdZbktuSUVhWWE3clAzQVZYSi9xcFgyRmJmZWYw?=
 =?utf-8?B?TitWOFV2R2wvenBFSE02UU8vbzRqalhQWmdBNXQ5cjgzdzIxM3Q4K0xDSTU4?=
 =?utf-8?B?LzhOWDRWbHk5am1HT3lFR084Y041NWtwWDBZMXRtNFhqa2R1OU8zVk9ndWRC?=
 =?utf-8?B?ZHZiUFZrdlFmNStIQmlWbWlvR0dZNEdtT3hTQ084TDB4OGN5ZVNld3NaRU1K?=
 =?utf-8?B?S3g0ZjhwamVzbEh3MUpDd09qT2RBVTdjSU51MlhYKzRwbS8yZlBFR1hYd3p5?=
 =?utf-8?B?YnBXS0g1Zk1PYUt1V052RVRxU3llV1FDd1JxeHFhNEpya000b1F4RjRxdWx2?=
 =?utf-8?B?V3JtYlRPMEExRnEwaGtuTkp2d1A5RnRoUFZrS095RDQ3eHhSM2dFKzZmOFFj?=
 =?utf-8?B?Tm0yZDVPVngvdUNZQzEveThvdnZkMStYZ3I3UHVlNndHV2g4b2M4cTRKcVBj?=
 =?utf-8?B?c1YwSllLMVhsZElVR05GT3BhMmdOWVAxMUtJOGZlZzdMdmtGcjNwbE9LaTFE?=
 =?utf-8?B?UHo3TG8waUJMLzR2c2t4dnQybEJNRGRGeG5tVVBVR3BvbzlGV3BReEJGZElS?=
 =?utf-8?B?cmxZZ0xsTWUrOVBCWlBweXhsWEQ1MXpTWEtUN2xmUmtrUVl4cDZsalVPOW8v?=
 =?utf-8?B?RHMrVDVsWkxPQzZNSmdDak5PTTlQVkQxYWtmeGt1bTFNT2h2YUFLQmtTaGpr?=
 =?utf-8?B?aGt6WGlaRm4rWjVtZnNnM3B3enJYVWZOWE8xWWVScjVrd2RDMmlpZXBWa1pO?=
 =?utf-8?B?OGVvdmFnN0FQbGVWc0k1VkZJZEdvVFJwSU9EVEF4bDAvWW9Fa1N0VVpsM1Bn?=
 =?utf-8?B?WmI5RkdzVTRQbnllSVdIWDA2dkpxM2tPY2RNZjdWekJwSXlmaENLV1RBdzBj?=
 =?utf-8?B?Rjl5SUVMdnhZMS9YRFBZMXdlNVlYRUlzK2F0czkyN2ppaUxla0dqV1FueTR4?=
 =?utf-8?B?Y04zcHQraXdMTWtwOVNNSVZuc3h0VWRtSklEZm0ybFlMVmJyd0FxV0cxbDJ1?=
 =?utf-8?B?cUpUMEpiQlgrNkpVaHExNnFwMVhRTXVqL0ZMNWxldGZDMmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ZxSlJKU09YWDNmMWQ4R3hQYy85cEgrcG1TT3NyWnlVcTVVSWloMnUvalBU?=
 =?utf-8?B?WndQWjQxRjNrM3AvczF6ZGpVZlRsVmh6TEFYYTF5RE5wOGlOTElnanR3cEtS?=
 =?utf-8?B?eVN6ZWFQSzJuU2JHTC9oaGN1NzVpK1d4ZC8rK01kbWM0RzhiZjByY2c4aEJo?=
 =?utf-8?B?Ulo0WFhERlkwWWRIS1FvMGFwNkpTbUh1U085Vk9XUWhwbzFuU2NDKzJDdGJG?=
 =?utf-8?B?cUFqdEVkblJLRCtIeXhnbU53WEVLQkpUNE9BOHUzR3I2bmsrbEx5NVdENE0w?=
 =?utf-8?B?dW1vYndScGdwZ1MxY1FVSVc3SitzRkRrYkFEeVlFTElESXJKTUFydEhRR1R3?=
 =?utf-8?B?TnR1aVJzQldnMWRBUUtLUVdmVEJ5VVlSdExwdWFqSGhYUUJyY2RJV3ZrbUZB?=
 =?utf-8?B?YVdNUjR1RXBOZmIxdEFYM0JkcHVuU1gwaUtZR2dHOTFuM1dObTdyR0E1U05m?=
 =?utf-8?B?elp6Sk5XZDZJUnRPejlucjROY0FPUmFGaDJreFhvNjEvcC9pejdzcFhBS1Jk?=
 =?utf-8?B?cGdlejU0N00vQWlOVjRPYmx0dDdoeGJnSlAyczVMSU9YbllRSjF3YzRwZm5h?=
 =?utf-8?B?VjNDZHR0OXFITyticjN0Tkhyb09ZYzB6MmFmMVg4UTZ4bnZSeUh5RTNiMTky?=
 =?utf-8?B?aWlNU0tTSjlra1JhRTVOOGpEdzVUeXovSmtIRmp5aHhZbk90Z0FrYkR4S1pP?=
 =?utf-8?B?V1ZpRG0yaEhGL1pISlNJc1J3NUgza21oZWNZblhQcjgzaWEzWGJTbStYOWQ5?=
 =?utf-8?B?U3p6Mkt1UUZMSElQSm44VUs5Z3Fid2hVTE1vR3pmM2NCWXh4ZUFJcXRsMkpN?=
 =?utf-8?B?MWZ1MWlSWnpoOE8vUEsrWE9sRFQ3bzVPUlcvZ0lBQmhvM2RQZXdXZ0dKOG1P?=
 =?utf-8?B?dHNLbTR2Nkpzem0xSU16K2V5dlR6QXVlVFYxc0V2Y1A5VDVIWUVIczB4TWZi?=
 =?utf-8?B?Y1M0MDU2Tk1GemxvUVZ1Z3kySjU1Ty91TVVjL29BOWxrZTduQnBLTFE0d2xk?=
 =?utf-8?B?SU1KTnZKa3BpdjYzdVhKS3ZrMWVPWTZCNnE3WXRjQ1FsalRNeWtmZDFFSFRx?=
 =?utf-8?B?bEFDYjlpZjF1aDM2YTN2cGtoVGJERUV4TTUvNk4ySWRsVVNLQVZYd1VEeVJC?=
 =?utf-8?B?d3BCM3BWQ3pJS21YNWgxUzdscmRyanBsQ3ZwNjYyTk5KQ2JZbjZ5eVBaeDR5?=
 =?utf-8?B?d3Axc1NERnBaWUJtWUl3MzJsYS8vdi9kOEVTckVUOXU5ZFNFZFlWZzA1aW9G?=
 =?utf-8?B?NlJrTFRzbHNYUDhBbTZ0ZDE3RXRyV2ZwUHcwOExNZTV6Y0ZmdzNuc1VaR1NR?=
 =?utf-8?B?VmRYdi9BeURYV2ZFc1l1T2xzMTdnS1lJcVFtQ3VtY3pDNXhMcXg3VmQvU0lK?=
 =?utf-8?B?b0NTRFlJWFB4cUxFV084WVF3amRYbTFzZHByLzRXZEkraE9sekNwbXRtQS9n?=
 =?utf-8?B?cktqZ1N5d0ZiNk9UMURzdkcwNEx4QjA0KzJGRjR5TGNNRDlYUWpMaXluNW45?=
 =?utf-8?B?SjJqYUljRlFLbkxhR3pKcjJETk45WHBzN3V5MTVzN2RhN3pqQkg1Z0VIUHVQ?=
 =?utf-8?B?WEF2MWpmc1VhemFsRWdQLy92Q1pjRTRzUGNUWmJIZGZ5ejRyR0FDU1RwVUtj?=
 =?utf-8?B?Wm1HMzM1azI0RGpmeFF3QWt4Nk9UWFNXVzI3dXdqV2RWbHVYSzZ0dmFUckR5?=
 =?utf-8?B?cndtaDRQVmxiZmUxbUhRWTU1a252SUNxUm5JOGV0RVlPWnpQdzdXR0Zycm93?=
 =?utf-8?B?L3FhWkpQbjhwaUJIVTNvRFBNVmlRcDE2cUIyZDMvRkh2K1doS0ZNN2YxckJn?=
 =?utf-8?B?UVlJRVZDR0RKTU5SU2JvR2pOTVlFd0dTRVNqa3E5UUlXSHlFcW05TGkwU3pw?=
 =?utf-8?B?dCttS3BCT2d3UXF4ZUNXZU92clo3Z1kxbWVGc096ekE4Vlk1dUI4MEdMK3Vs?=
 =?utf-8?B?Wk95K09Xa1N6dkdJZFdBb2NSM2NsMEV4WGpYajFFNnhuWTA5WHBtbkNvbXdM?=
 =?utf-8?B?T1FyZXRvdlk2eFJEOXBENUwzMXIwVytHd1lybGVnRm82Uit5eWw3MW5oZFFD?=
 =?utf-8?B?YUt1NzNBb0thbndjNlVobnYzUmxCRDhOVy9lVnkwbHVYb25XT3hrRkVJbElR?=
 =?utf-8?Q?JlIg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74496073-d0af-45f7-1826-08ddcea8a340
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:03:05.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXf1ocH7gHgys4bHGTVJuJxI2uMuBRb08RxMaLZONI3Ob6czIU6jsHYsq/FOzS/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9

On 29/07/2025 4:01, Christoph Paasch wrote:
> The below fixes it. The problem is that because gso_segs is not set,
> NAPI_GRO_CB()->count is 0 when processing the packets.
> So, if we have a non-LRO'ed packet followed by an LRO'ed packet being
> processed, the first one will have NAPI_GRO_CB()->count set to 1 the
> next one to 0 (in dev_gro_receive()).

I was also suspecting something in this area, but LRO packets shouldn't
really aggregate with other GRO skbs as they use different checksum
offloads (UNNECESSARY vs. COMPLETE), so tcp_gro_receive() should flush GRO.

> 
> This means we end up in gro_complete() with count == 1 and thus don't
> call inet_gro_complete().
> 
> I'm still unclear why this only fails much later then when checking
> the checksum, but I'm sure the below diff fixes it (and also gets rid
> of all packet-loss, so throughput goes up)
> 
> Will submit a proper patch tomorrow.

Thank you for the quick fix!

