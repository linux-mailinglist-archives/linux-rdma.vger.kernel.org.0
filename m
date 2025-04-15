Return-Path: <linux-rdma+bounces-9448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C5A89FD8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF93BFDBF
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64AD195808;
	Tue, 15 Apr 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/ocm5kY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089C167DB7;
	Tue, 15 Apr 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724740; cv=fail; b=qoIXGaFhqYp1IZSIe1TFpc+kBOSQcNnDgU9czEp6ORUQqAdC3jxyB77K7PJUoQWcwC+L/HeWs3grxoLStftz2j154vCKDiSnPUxZqZgSjqJRPfUdGazVY04J1/XaeaJ8XIHjswuardqz13cdNjik4vStUtK1gAOjBryicEYlVtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724740; c=relaxed/simple;
	bh=4XbSEXtKD2Gs+YhEQHcRSO7bXaYOXQcX5os+tj89N8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLF2yn3Pkw+O8/nGTFyqr7c0E8+KhEK5YkpqRUoBcdiQTZuWJEMLoD8/Pv3K8fUkKKTwUh+pSNUdx8cNU2yxrfd0vC5p9ZLiG0ck3T5m/sp0xVxkvfbXtgceSpZ7rlejQ2pkjg2HaDRPfIwl5TJsjizvBxFDSCmOY9BTfsyVLyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/ocm5kY; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4ZIYclZFqaj4jD/FR7R3NvEIQzV14/vujsiv/OTi2ZbGDBj3e9UOOZs3dwlrTz+PAEi2h/G7szMT0ed6TNb0R+P/UbZp2SDTKrrsBneWC0oKxXC1Zx6EXdRKwxS0cKdSj2ocEByPvFHEDloInhF0Lv8PLq6X+jNIazluxDZye8w+iTRzHtvF9vpDF0nYYk7GgSnWch1eNeQXWNiHCKhskt3WPJmGj11JOigapIV+dAZoXdhUz6GttJN6MXSb3Fzkxe1EOGXeTr+AJt0VWZgCslJXZboWi9P+wlV6ZEjmmsqXpICGTww8aSUzSgWyJcZKHIW7Hgus55YP190lZgv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv7dNGViEAk7ROhcNbKLbdft4kU41pNW54CtuLHmCcM=;
 b=QudfvG2TwvyPOcowzkw1pSrc+/L8e19qVRkWIi+ZmD7x0lFA0uBP7LaZGQ2NWCrk96nudFg09o1tY5j1L/cU+J0fCkLtpVA2jFowUTdsZEdWMizDabEG+hUYtj5z7RifcMzJhm+JQ/5aZmlfWeGhYRZHtrd8DV2zAZAy7AYaunhu/apqtsXTjOxdKzRDxUY8vmTsDS2HiVT4ZzeP4BrLXGWiIO/iHNGlOTpZdGQJRXiT1Q3n0ltFj0anlz6M2lJKmETw1CtlGMRZEMfXvr9UnLMAMILqpOIKLWpyYfW7Q01igAaiYvcry6sAwsrMvUa2+hycMDuHD5rf4jo3p4du8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv7dNGViEAk7ROhcNbKLbdft4kU41pNW54CtuLHmCcM=;
 b=C/ocm5kYgUW8pT10xoUV+u8YOaYeABoOWf5pQnuIoeS4h1vIvComR0nXUbCY3t9CJ1n/Yrjby0wKSz+v8cwkAuBlFZKMK8QbBDH+gaahZhZXrTprWlgpo5XVeSkg5dg68VZdvNj7hxKdtnqR17DTviOgj2atUSdE4B2guyGWnGS/adwWAjB7erJvOquRr4AUCqZiWuriFPCDaANPhE34r6p7osqitcRp62UAOrE+MnX/5MFHQYzJO84BH+Od5w1dT1cJxUjoglLd2+JCQbcJv3U2aT0sH64aJzfBduDJeqUCCqWmap490Re99s7Hv599remLzV28r43KFDIuGtpb1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.38; Tue, 15 Apr
 2025 13:45:34 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 13:45:33 +0000
Message-ID: <e0db67c9-8e38-490a-98a2-13c61ef11aa5@nvidia.com>
Date: Tue, 15 Apr 2025 16:45:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
To: Henry Martin <bsdhenrymartin@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, amirtz@nvidia.com, ayal@nvidia.com
References: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
 <20250415124128.59198-2-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250415124128.59198-2-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b62696-89e3-484c-1cb5-08dd7c23cb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDgvbWlFREtUNlpxR1U1N2VLeGc2OExNUGJsUU8yV2lrYnY0TWswNlJ6L0FF?=
 =?utf-8?B?alVQcE9uMHZWdWZ5OUg0R1dsSU9ueUFsSVFXWlhLVWtudUJOYjk3aWppSzlh?=
 =?utf-8?B?OGNGZ29TNTZSaTBQdCtYS2x1dEFoTm9oaWNXYlA2b3UrZElIcFlZbWNrUk1Y?=
 =?utf-8?B?WWIrZTJubENLYWtqR0ZNcGtwYkZkTi9zY2NybFQyR2c2M24wbzJBNHlyQ3N6?=
 =?utf-8?B?ZGgvRDJuQ0RqTXJPSFE5b056OTFkNE8xeXkyMEFBZmczdDVKSG1hWGJWU2dj?=
 =?utf-8?B?TWpWb01pVmZ5MTRZM3lXYzE2QmwvdDlFeElxRjgxUjZKU2t0ZS9NaWF0Yy8z?=
 =?utf-8?B?cFNnV00rTmxEY3EwdEhvU29STEdPblVXUFMzZHRXYjRlM3BKRTd5UkNKZE1I?=
 =?utf-8?B?L2lPanJUM014ajZkY0xSRnhOUG4ya0dNbkJwS2Z4cVFrdWtQK1AzamhOV3BO?=
 =?utf-8?B?ekxIRmZqWWFlc3FMTzlzNFhBSDZ3RWlFcDhPZzdqWGdIMmFGcDFiN1FWU3hw?=
 =?utf-8?B?SktQUzhubS85Uk85SkdNamtORWdHYmkyWTl0djhtVzZyKzBlNSszWU4vYjhL?=
 =?utf-8?B?bzM1QmZieE52YmNSVHNTbDl4amtzUnRUZWs3ZjgydTA3N2lxck83MmFZQUlR?=
 =?utf-8?B?ZmNWbjljTnJOLy9qRHdqUlBNUUJqdFJlTTFrNGxybU1raHROTmlYVTVqOWph?=
 =?utf-8?B?K01lbkEzRHRZSVVkamFkR1p4ZGpwNmJyY1VENDVKTE9OL1RZUitiY0hGNVht?=
 =?utf-8?B?SXVZZzNHaXoyOEhkV0JLWmpUUnZ5TklyRElHaExZVW1idERIY0lGMUZrZWs3?=
 =?utf-8?B?Mnc4a3BJQzF4SjNIU1p0RzhQWFlHQ1JKSlNRMS9NS1ZrQ3pkZWVwc2ZXZmJG?=
 =?utf-8?B?NGlOcGJmZnNhZ25CNkVyaFVycWM1QzdmTUVDSXJ4MDZSM1U3czRTVXJ4dG1H?=
 =?utf-8?B?dGNrSHNxY0ZBc0JVTUxQYzZhNDJXakNNemxPMkxNdnlBNUtpTUNBTytnaVZ3?=
 =?utf-8?B?U3gybXBLRDJaMUM0NXo5alFnUDN4LzVqZmlmWHU2UHl1MzlJNTNSUlNyaWl3?=
 =?utf-8?B?Z0wySnBDL09CVHlsOVc4c0pWTnVzbFNzclMvNjVwT0VEZ1BGMHp0a3BwOXUw?=
 =?utf-8?B?YWQxZjdkNTNTV2NjR0NObTBvNUlnN0lycEhmVDFUc1B2ZVN6TEVXTEhmZlM5?=
 =?utf-8?B?L3ppK09qbGVwYmlhekJXNjM5d0diS1dPNVEwVmdNRlNSY0xFQUI3MXM3NW81?=
 =?utf-8?B?ZTd1NlZPSVRxUk83NUY0WC9HNVFjeUMvUVNHVDYreThWam1SZXlVVGxMK2k0?=
 =?utf-8?B?VkRIL1FnZWpsSCt0ZndXR2kxa1FqNjZxWDBsdWJnTytrQVNrbmR0ZmVuWUE5?=
 =?utf-8?B?dEc5UFViVUYxWUt6aWtZRFc4RUJGd2llOU5LM1ExTmVHSmJ1UC81cGxQZ1RJ?=
 =?utf-8?B?WXc4cW1XZGNaNzBRM1VVWnp6cHNhMjdSRTkwK05ZdmNDRHR4NEMvQ0xHUThK?=
 =?utf-8?B?YmpQSnNJQWxqNHRRK1pIOVAvNERXVWtxZGpsNGJRU1JHSVQ0RFQ0TEFpK0Q2?=
 =?utf-8?B?NVdFdjdzR2s2U1h6Vk9ySGpWTWJBRXo2Nis1RDB5TXlaNGtnUURScVJMNHBT?=
 =?utf-8?B?QUpBdUpXMXc2bVpCeGFuSWhsZEptY3QzTE8xU2NyY0FXQnJnRTVoT0hyc1dL?=
 =?utf-8?B?U1kyc0FYOUd3VU05amdMbUd6RVN6L0V1Y3dRbDJTS1VLNTExNnlWUi83c1JJ?=
 =?utf-8?B?T2E0bFdacUV3MHFSYTBDbnE4THZxTHYydjRYUVlGSmQ3aEtlQmN3cVJlR3ND?=
 =?utf-8?B?cTNVTDVOWHg0aFVNSVczK2doeVQrcDQ3TS9FWTlMSlE0L3JteFZpc3gvR3ZK?=
 =?utf-8?B?UFNVMzc2Q1VvREcvVDRSVVJ3M1dYNjVIeVhzaUlPUTdmZkszWEhUZkJLREF2?=
 =?utf-8?Q?9DIKC1ryWQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJBaFhVSHhUWmlhNXR2ZFpHaUUzL2RRajR5VGp5dTBiUVFDNjlpaFVpeWUv?=
 =?utf-8?B?OWxWRFVjMm9JamMrZ0srL0NFTTR4bnVrNHRLZHgyQUZzY2tsaFRYQU1MTnpq?=
 =?utf-8?B?OVN5N3VLMVZWUlM5OHlmSEZQYXloVmxwbzZrL2tWOU9Xb2pSeVU2VUdYdjRS?=
 =?utf-8?B?Q2RYNGVkT0l3QzVhL1VXQTdFV0xlakEvMGt3dGZnZzNyaWJEd005bVFMRTVX?=
 =?utf-8?B?MDh1Ui8wWGdhYVhsQ3hCNmFTYm9CcVZPalZLT2VhZStJUU5IVnI1UVR5MnlK?=
 =?utf-8?B?RVI1TTcrNS9kVkl2dVFmdlM3QkVHTzZRZU1EZitUdFdReWR0WFlYZk1HR21q?=
 =?utf-8?B?NUpxL3g2c0RiMU4zN3JuSlBCVXRISjF1MTNaTWhuSDJqdzZPSVVKYmVvWnJ3?=
 =?utf-8?B?cWlONGk4N1ZQOXh3L0lqMmtrSUtiRGFOZW5Md283OE9nb2hmaHRnVjdVZUR0?=
 =?utf-8?B?b0xVT2ZKVnl2UWJLMXcvQ29TaW1nRVo4b0FKTFhVUFNrMGxxK3U5eElQLy9V?=
 =?utf-8?B?OEZQNTJ1VmNFNlQ0bHNzdWU4bDZsS0xRTVkzLzNNU3lmckFZSWlJQlBiOVI5?=
 =?utf-8?B?Uk5oZUc0RlEwNGlTL1JEcW16blZhSGtmcUtLamdwOE1vdXVFRzh1aTBUREdj?=
 =?utf-8?B?MEkxSnlaUmVpYVVETEZaWnc1V3lOMzZWMmI5TmJFd3BySytXUEsvUW9kN2tt?=
 =?utf-8?B?Sm5zc1BNRXREZ2lzRi81TG4wTzhmSnQ1Z1BhN3ppQ1ZDdXRkclh1NUlIMi9U?=
 =?utf-8?B?WkJSbndMMit1TjlKcnQ2STZHQXIzZS9JODkydTlxSmFtek5wZW1NbkV5ZGx3?=
 =?utf-8?B?aVNZcHVNRENwbDZkMG9uclhBck9zeVVsck9TZ3laVGE5S0FnMVJsSXc2WXBm?=
 =?utf-8?B?a1dHME1ScWJ2QjJieFczdThIOTNySDlkUzNKVjArV2VlRlFoaEhheTBidlNW?=
 =?utf-8?B?bzdNZmlOZW91SThUb3p4MlZzazVFSWlIbEpaRzVnSXIxZmNmQjk5NURCK3hJ?=
 =?utf-8?B?Z0dPT3MrOHpiSUt4T0wyWWxQR2pqQ2VQMXNNMFQyVHRBNlJzV1g3eVpUbGpi?=
 =?utf-8?B?WDh1Sm96ZEdlRjNPSTM2WU9RbEhTTW1hNHJQUWxwZGVvRmV1SE4yYUVNdi9i?=
 =?utf-8?B?SmxMam5GRzFiQmpPbWF5NWZ5M1VsSXkrTmxhbkVpaUd0UkZjMjBDcFVjSktC?=
 =?utf-8?B?MlhzOFA4RjNsZmRndis4M0w2b0RKL1BhWGY3ZVNLTW5NVTczUWZCYUlFalAr?=
 =?utf-8?B?K3JuYVZWTkFVcmRnM2JXb0JUTnBvYmF0eDFZQ2xWeE5HallHVktPaDdzdDB2?=
 =?utf-8?B?VTBWb0F6enlYbi9ZUjAvTHh2N003WmV0TjFHcDNsT1BTMEZRNGtGSFYvU0xy?=
 =?utf-8?B?ektyZ1FNODVaYmZENVNmeityWHVVdTk2aXY2cUtTR0V4SHN6TzZJZ3hWeEFl?=
 =?utf-8?B?YnJkeGJlemFHMm9QT2RyZXVmSG5lOWpwVkNwT0RHVmJsRjdFckg2UXIrZVZD?=
 =?utf-8?B?aUxKblh1VHJZeTZ1K09FdjQzNkhEWUpjV0hQUTFPNmFQKzUvaDJ4bUFpa0E2?=
 =?utf-8?B?ZkdiZVhNeTh1YXRaUnYremdrRnUvRDY0SjQzd0x3NXZsK1A2ZzdKVFRRZzVr?=
 =?utf-8?B?K1pzZG45aTZyMzFORUtZM2JwL2FqTlpoellOTW5EYTJUWTU2Ti9wdFlJNnMy?=
 =?utf-8?B?M24vaDFpd1hrNTFIbUJXbVc1ZS9BbDhMYnhFMnBjZEh5VlZiSmFtcnUyTUVI?=
 =?utf-8?B?ZG5JYnhqbFFkczJqU2ZUR2k0VyszSjdieEFiVUJnb3YrdDFwNTlzZFFlZFgz?=
 =?utf-8?B?ekVMUVprRFZBNzlTWEdNWHdsSm9iaElXblFaOHBXancraHJEMysycUNONGNF?=
 =?utf-8?B?bTFhaXh5eDA0VUk2Q0t6SDkxcjlUM1h3dFBtNXFSZ050U3MwektpdzgzOXNo?=
 =?utf-8?B?U0JjWll1R0xNUXlMcUh6eVcrcTErWWN4MGs5bENjYkxwcDkyTVVvQlZ0ZUpt?=
 =?utf-8?B?RnI4eDVOdWhNcDBVTllxQ2l1Q1ZNQnZSWWpJQWNPRURYZ1JtaEpha1BPVzcw?=
 =?utf-8?B?TExqdTJGcVRWakJRM05ubXJjT1hsU0hXQ2pMZm9vYXlRUVhXRWc2VjREd1ZB?=
 =?utf-8?Q?1FSAY2fs6wJOApPb8W5umnRCV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b62696-89e3-484c-1cb5-08dd7c23cb77
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:45:33.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+ZFJ3neKzuPLGZhAviS6CV/RdiS+HhALjSCKdXv2GAIPm6lrCVHRnmgDDLv51weFxgZIZ8DPNKf/yplXmGPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596



On 15/04/2025 15:41, Henry Martin wrote:
> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.
> 
> Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index eb3bd9c7f66e..e48afd620d7e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -655,6 +655,11 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  	}
>  
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns) {
> +		kvfree(ttc);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>  			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
>  
> @@ -728,6 +733,11 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  	}
>  
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns) {
> +		kvfree(ttc);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>  			       &ttc_groups[TTC_GROUPS_DEFAULT];
>  

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Mark

