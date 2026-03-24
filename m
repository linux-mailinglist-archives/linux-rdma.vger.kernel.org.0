Return-Path: <linux-rdma+bounces-18580-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPzjGiyWwmkbfQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18580-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:48:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A802309B20
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F03330A0C77
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC23FCB30;
	Tue, 24 Mar 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/SmLADi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DB3FBEC9;
	Tue, 24 Mar 2026 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359815; cv=fail; b=adec/f3IOcqilfne2atDyKyZKDGtm2cDwUcWT85A+kEZ9hnh31bVWrbYqEU1RAfgEIZYUmKL/z0xWism7pz1CN1UneTJrYhZ0BfE8G2E5fD4N1R73lzkASLjz88w7aXDFyWB6T/uJM3q6DWzbgOBPMGOFXlYEUCbqzNLeZKOGOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359815; c=relaxed/simple;
	bh=3O5uBk3KqQsmIXM2KVXZFAn+2lV7ibdQN/Lm/5VWF5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WFzZegb4gjHLoxuIEbmJSJyZzFDdMkDtnO8+7DYwZb1rYAblxfJy+gCQvfVPabVRwI/s0nXKngzo/vJ3HUVV6PgsmbF1LNF5riFpoR9NU718EEC9LKmyVpWUmgcjsDdeB0V2YPtk/PySAxcLlbT4+cuWUTWYmT3AXW8lWYn04QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/SmLADi; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1dWf68y7uKQdgbj9i8A7PfobO3Mp/9d0Oopn1qeROiCd2Jg3uCnG0hA2RNAeXqUHVlijKm+WxnDMjDFXbAUcPFNJqkwO+S/ryWUrIdITBRunCbImXXXuABVLWJVPKTtYcSf3bwRvM+kw2NleetNkin/OwAzTrGTqo2F/ETEaytIMcyF29ucjfRobNmZ7dSygqKS7KcB0UQHci7F/1rD7SifcRJ5CweG+UDW6yjGw2idVxyj48bjmZQojn/GFgWwrzPPsJbw0KzrmZ0F4LAhZk7aYdQpJstA3Uo/PI1rlBpUkjWQ5WpMLZUtui2TZxd6qLRJ3W5P3LTisY7maQpkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX53zD7sFEvJPedEnfqd0I8OaTK1Lw18E9grhrcB/S0=;
 b=CPCdLE1zBnkAvnuQFF69MYGdPXJl6NvZVnmfi6mlww4lFH4np0CXy4OKdC0fUtVWuid6Arnx08meLjXeDk1SKKeZ6740YwVBokxkuhyqLDHweWOrVTydnA+aPApnvGgx1y+8Vvik+rbaqYOmK52mX0nxwHQ1dYFA3UrCGAOxpOiFkz2mkzo6eq6Va8p11rznPjhmqe0mvjnLTiKoPZw4z6L3Y74V7iG2D3k4TKfbySxqFvX1ODqf5/8ypSC1o71MikhW56XCpVThBrCxwS0TxzKL/ZMvyOd5Sjim992beM1FGzkdMnrQDMRU9yr/GbQtLOliSFTpYPrcjoJrENRiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX53zD7sFEvJPedEnfqd0I8OaTK1Lw18E9grhrcB/S0=;
 b=Q/SmLADi6ZuVN5vRZU5zDsKemt+x5F6QDEHn0Fy+VBSipFU7YLRMYZKUsa6/5acnr1JEQlqt/ZGMU3MhnzJLz5l+Tt0r3ry7zej3wKmW5gZgEFX45rq0x32znz1JBSMNo34SkbozU9DXl6htcC1BAizRC4rVH2rnh7cgDxLot9YPVDvZ3pVbt/hkB6ns1cPoUYQsYVH1O1QobPpgSmpZndvVibkdidW7eMBV8gxz1tqKJ68acvdHznUso1p1zdpcdvrvk5mpJ8l6tMvKQZKboKdc6oiDVxZjnWpQxW5KfLj+kSPIssMQdJKY7l8ALIG+cUX4PseIR5u6ddytwb+ycw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:43:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 13:43:28 +0000
Message-ID: <538059c1-edfe-4261-9ecc-056a5ce68bc7@nvidia.com>
Date: Tue, 24 Mar 2026 15:43:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] docs/mlx5: Fix typo subfuction
To: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>, rrameshbabu@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, joe@dama.to
References: <20260324053416.70166-1-ryohei.kinugawa@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260324053416.70166-1-ryohei.kinugawa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 992a375d-04dc-48ae-4bfa-08de89ab5465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NmLrvjsuvRIEWuvqCgQ8QYQzrhg6jGEowUtBOAovhQZv0D34Y1GT8sTxr1npLL6tkZC6FMcq8sO8MKa7M4Kuzv4WcFp1pi6vTVyx5sxZ6oK+vlwAK5PJdCxZgvWF41FUhcSmSzWJXQb/T3EejU22aqDUXTZ2B4wmn0bchWACYs/q/UE1mnpzSgiF7NlYH9LcBCUeuhF5Kvcw8mNSosErkh7LgwYYmYBVH2u6UiXqosZOT31pSMPJuAvLshRPeCZdZhZDVOPj9wLczGdK9GAECKmkC5xB1/GIe7nEL2xlHbjwtcISltMxg/6bagn6t4OFLpocdwpz4RsLD7SmQV8ro5AoR548vB8VWJrilq/hy9FwZ+3Uqkc6baUDOokb1U1q/HXLN7b5etxIJ8b9E9fUTtUuZ8vCrZ1fKt10jMld84Vje/55a69lGVoBSWZs2aBQdegIgUdvESqKdDiRUi/BMaQKOHIe8mNGP3O0RfhNENORFNuOuBW0UjR7pnKuM/pmJWOdSpt4M+As90hwjzKbyLwYR4eIvBSB3I40Hb7Z73DIcFWpJWhRP/jBy79RdkHOAP03ZStQCMVpw/fLWMAYwEma/MYt4/jrGN5gC4FdYYkLBXJFROJdDbu7ptCkmqf98rl9uTfblsGcktF/VhA/KVU2J2yXil5x7TYHG6KHHFuSJtNFsDCVtmAj6QytB+vM6ctf1YINv3/RqbGfv3CGoA5DdRHcnUbEmsSE7SF2cwVnBVR4VVpKzv/JtNbb4A1mSU0UwRFOr3S4W5hsRyrK8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGo4T2VocmEyOU12eDRnMkwwOE0yclFzRWFIdDNWdHBITjNyMUlCTjRIcG9w?=
 =?utf-8?B?Tm5ZRDZmeGtEZFhvVXNHR01Fa0FXem5YNGZZNW9XNDl2TTF3TmpzV3Ria2do?=
 =?utf-8?B?cEVSVGs4Zm5jbTNmM2RJRnZSNXRVRjhjZmpZV0o4L2l1eVI0anYrT0xZTGUx?=
 =?utf-8?B?WVlVclF4NVNKbDk1c3pMWVBZNG5lSkdDdGlGTUcxdGgwL1Z1OTFlQ0Zla0Qv?=
 =?utf-8?B?Nm1KM1pQYlRrWm80NUVTNGZ6M2N6dE4zT3dPOXRYcmVDNThnRVpweHhOZXdl?=
 =?utf-8?B?bmthVkV6RU82VGdMdGtna1ZldGRKZ2dYaWdwVVdscHlsd0pwNEI3S1VJeUoy?=
 =?utf-8?B?TllzNk4yamhzdXIyMUdpYkFkM0U1dDhIdzltU1l3Vy9yZnNzL1lFSlFFR04r?=
 =?utf-8?B?UTE3Q2tMOVJHUDRiRWpXaTBuSGdScHhSL1JOekZUeTE3SXA3dTh2MFBaYjRQ?=
 =?utf-8?B?RXl3YUJ6UUxMR0xSN2l0eCtSdUlxTXNON3huNThxSEpjMkk3SHNRbzNmNkNG?=
 =?utf-8?B?dVdrNmU0WXFQaVY3emdFSHR2djNlRTk0WHFpbnR4WjhZZG4xdDdVMXBUVUt4?=
 =?utf-8?B?SnJTYW1ZaklaeU40T05oNEhMei92WjZnRnpuSUdiYllLL2t2d3FmOVRYVXRY?=
 =?utf-8?B?Y3EwWnNTa3Bub2t4b2NGb29DelJJblpDbm1iNWZxZitDRjRsUkx1STBSQ2xt?=
 =?utf-8?B?dFhvOXZUK0dBYWxiU1NQM0xBbXR0M2Zaeng1ZWt3RG5aVjRGcmJ3TzdHcVhD?=
 =?utf-8?B?OHNFT2VuNnp5NG55M0FmZDhoK2haUHdNaHEzVGFQYlFXMG42dXNPTUZwUHI4?=
 =?utf-8?B?emFWSkovSkNuMjNXenRDMkl6cmppeUNnazB3RStZbDFkcWZKNXM3RGVaY2lM?=
 =?utf-8?B?TU91eGxxTGFIL29oUEpRaGd0OHVTM1NlRTlPeFlUUldmSGRtcVV1QVpSTUtE?=
 =?utf-8?B?MTdZRWQ2bTVMdlducnBDaDlaOHVrM05OMStBSFNad0JQL0xPZnVDOTlXRHZS?=
 =?utf-8?B?OEYxYS8zakJMLzFXTk5KazJXaWdXT0NzWVRWSDFJdis1Mlk0bTBlRjBqcFJG?=
 =?utf-8?B?SUpiN1JnalpGeWZoWTNGcUMza21yRWhiSm5qVWZvR2loQkNFa1ByTUNsNTZB?=
 =?utf-8?B?K1g4cTBkVTBrdlRDNTh3dlRHSTRpSWhWakFwNWdtMFdOZVZNQmo0eE9qVjJU?=
 =?utf-8?B?Zzc4TWk1amNNQU5oNlJuWGlDNmEwRzFyeXovVzhUOWkzVm1QV3ZaRmFJZjZ1?=
 =?utf-8?B?VTJmMGtXeGpGeElMMVBUOWJ3a0dkdlpTdldXb2tPN3BhNzZZVnpWKzdRYllv?=
 =?utf-8?B?YzJKSVMyM3VFMkFsazc2bUxxcFRWVmt5TkVNbVRlcG1BTHl4QW5MMUdSTVh1?=
 =?utf-8?B?OFduUHA1MFlIbWk4VWhuNE5LU3Uxd09SemJYU0JZN3E2Qk8wemVHcitRU3o2?=
 =?utf-8?B?NzNvKzN5R2RyWGJ2QlIvN05CcEVsRmVCSERmcEtYMHJxYWJiczNXcit4ektC?=
 =?utf-8?B?OVE5S2g2QVFxY1Zmcm43YUdKNTBpR1dtMmVpNWhsMXRxUUJ2VVdOWSsvdWVl?=
 =?utf-8?B?M2RjVEtHYisyY2pUemc3NWJIRzhLSDJxWVhhbDVob1gxZ3V4RWhsYmNJKzZN?=
 =?utf-8?B?am1uQVJ5aDJXWER2RGZ5V1VETTZ0Q1FzcVlsMDh3eGFZbkxNdHNJT1lLTUhy?=
 =?utf-8?B?a05XK0JQU2tjZTQraFF5QmY3M3lZVTdOb3UycW5ZdU5CYWo0cGE5dXd2UUo1?=
 =?utf-8?B?K1Fwdk51MWxENWljMS9JTytjSkVkcnVJL0JDR0QzeWJyQzdpWTBjekJtRnlm?=
 =?utf-8?B?cGVDSzh2em9YTllvQjlyNncvN0ZGV2o4Q0RldXVQVTRUcTF0V014RGcvYTlQ?=
 =?utf-8?B?WU5ZbkUvV3ZRUTFPN2dNeUVtOGlyQnR3MlBzOTNRQngyN01qRjFOcUJsSk44?=
 =?utf-8?B?MlJBcU5zT1paVGl6bS9TQ29uUTAzZ2oyLzFHbkk2VnNxa0I4cElSa3M3Ukwr?=
 =?utf-8?B?V3dYK2NDcURRRks3S1BFNmJCeFRIb3E4MS9DQlByT0tuTGdENkwzRkNubTV5?=
 =?utf-8?B?Wi8vc3F3aWhTUWxDUnJ4L1g5ZVRZSHNaOS83MkxzMlVQVU9PR25yeW53Skw2?=
 =?utf-8?B?eUdaNGNQSzV0OElSYVI0cDU3U2Rockp2VzhFL0NLb1dzQnNJL0xwM1pFWG11?=
 =?utf-8?B?UmNtc21EdDRSbW1oRXJ1ZVQyWTNPU1piK29sTHpxZUV4TmNKK3l6b0laZVhU?=
 =?utf-8?B?VGZWTmNzWXNqeEJrcTVyZzVaL3JYOHBISHFVNGhrVk5pV2kvWU04MGl4aDhW?=
 =?utf-8?B?UVJ3UFduVlE5RytWOTZwaU1UeUJmTDdFeVlHamp2NWVqaU5SZ0ZrQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992a375d-04dc-48ae-4bfa-08de89ab5465
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:43:28.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZhTFyA3ebNNjTwk8b9EBsqCAjtFmKwhn8/xdzcOmmYqAFEUNEEx327UfBiFWlC3+X63uM4gBmyIy66vOxDvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18580-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 2A802309B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 24/03/2026 7:34, Ryohei Kinugawa wrote:
> Fix two typos:
>   - 'Subfunctons' -> 'Subfunctions'
>   - 'subfuction' -> 'subfunction'
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
> ---
>   .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst         | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> index 34e911480108..b45d6871492c 100644
> --- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> +++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> @@ -114,13 +114,13 @@ Enabling the driver and kconfig options
>   **CONFIG_MLX5_SF=(y/n)**
>   
>   |    Build support for subfunction.
> -|    Subfunctons are more light weight than PCI SRIOV VFs. Choosing this option
> +|    Subfunctions are more light weight than PCI SRIOV VFs. Choosing this option
>   |    will enable support for creating subfunction devices.
>   
>   
>   **CONFIG_MLX5_SF_MANAGER=(y/n)**
>   
> -|    Build support for subfuction port in the NIC. A Mellanox subfunction
> +|    Build support for subfunction port in the NIC. A Mellanox subfunction
>   |    port is managed through devlink.  A subfunction supports RDMA, netdevice
>   |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
>   |    SRIOV support.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

