Return-Path: <linux-rdma+bounces-1374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935C7877A45
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 05:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB51C20D92
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B99A1878;
	Mon, 11 Mar 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MkBOXOy+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FVmIunWR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639B79CB;
	Mon, 11 Mar 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710130422; cv=fail; b=gXkKhJiXPmPdCljWEMtGggNEDO1q+mikLWTlFLpChijtj9JEhefrNFzQgaNMGGaIsMhwLYGBVXxiyo6lBOsOqFmjIgZjY+ZhOUAdvfWzAdnLcx8TAtCyYGqmZZi7gC2sMGv1wP5zZK96koehHSGF7D11UWayAbkzrEpoyyBpCn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710130422; c=relaxed/simple;
	bh=TsblDfNQKYoGTfiSA+/R/VeAeaM22kPoJhqyeXCJRC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJWPNcMpn3b7LJWOnGMJ6Tcnk+q3/CwUgiRT/EyCvL5qgpSouHPDVzsleRiKlfDF70UCOUVHkKOFhxsllqa2bjZdc24bIGN6EFoa2xrWgQpzrqM+0prNzaTgnPjQuPMlyyHB2VAlxMj0IS46EMnfyHFvtjHDqI46e9b/bpGfpAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MkBOXOy+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FVmIunWR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ANgce9024388;
	Mon, 11 Mar 2024 04:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q3IotM4HfSJ/bgMSQrgBelG/OyR6FMf3uvZ0UC8vIHo=;
 b=MkBOXOy+no9wHndXKYsTJGeQ5OJvbdMxeFoHuTrm4yDVyKdK1chs1bqmXrX0wo4Em0fq
 qsIjHF9ZO3vKo3GKy6vUtfoUg2Yra3bqnPl2iNwuIo3ICjM4S9Iq3+W+DaJQKVDMBnr1
 veemwm18t+x1/8dgePvK7VE8eqb8VDl51p9f8lSh1TpwI94VPGAUT3LhRLrJRYUAguS8
 qkJvbfHE/jfDb/gARqUhFmX2TQNoMNGFXr5F3N+gGT+vC8qwTvgt9WLTwRamwysKc8VY
 O8ZUUo0YPX9R0zHqXEbYRBky1IJRseNimagnjl1uKUVBQ8gHtkXpaqdjigVT5mFOf6bd 6Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauj87j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:13:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B27aDO038051;
	Mon, 11 Mar 2024 04:13:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7be5rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YajTQh/zda7Ee0tJ9ktRyx+7aXPZGHgfzgnvkAolyDd7jBjDmEwj8ZcmjIic6J7hs5RQGC2Y6iTdXLqKghcgSWEH2P2wwojGbRCyHKunaU/s4EWyLQWm9LBkt2QwnmSBkkO2YDgO5FAWQSS6OGbWDcrO4miYjx+M8lhUOyupKuOcBgO9XAYhE7dLeGx2MrDITzS4xCxwLCbsV6QO6DUmHt2ju6Y9WZVxozpqLt8AphslOC4W3daEHCn2Rhxth3ZirtU1air0iHFsvKs1KTXau76ATvvtZKujfqq6/uGoCyd/b3uP0YT0Ky35IlcQssRsZMsQxHx5TvVB969aY47Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3IotM4HfSJ/bgMSQrgBelG/OyR6FMf3uvZ0UC8vIHo=;
 b=oMQZ4J8+Mcfy5TbnLZCy3bPf3ande3cM53VJBDFc6CMVAEwAyYJkw+gU5Uz0rOsMUpEAyclrnepJcHkbqEuwKuH8o84gwZHVGRojsxUM+G2QW9VkMrXh6w6FLUBm9rfkybXJx3U/g3hxZ0X2Tc+Xl1DU6Z3y6C9NrJ6ZbTrFIlgd3/gkSFTKaKK1z5FCnYzE3lq+KP/ZMkmZ3dKdEPfrW95JcMuXZX/25u4UL7pWqNdLVeIqugDbouBJgkbZfTc3mpweXvRjAOiZY/Mjd9RmVNtHRaBfJaSVYELqiqoG2yOJMMgIlfYecGq12pHZelR54KOwa28rK1bcB2OMNWx6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3IotM4HfSJ/bgMSQrgBelG/OyR6FMf3uvZ0UC8vIHo=;
 b=FVmIunWRrbwVplh/kyGrlj85o50eXUNO/tSmCfxaoS+urBlnIGFH3GMCvTk/4D5aheCTBbG3u4chIN1JjSzB6cvPrhlk8xIQVdxB1FYsTqimloQGM4MCcbefa4mYeNp/BqiUX4gbg3+wEeN+dv1AX98C986cNJKIouibkViIvt8=
Received: from CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 04:13:20 +0000
Received: from CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75]) by CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75%6]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:13:20 +0000
Message-ID: <293eb402-73c9-441a-97ec-a5939ed44256@oracle.com>
Date: Sun, 10 Mar 2024 21:13:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] RDMA/cm: add timeout to cm_destroy_id wait
To: Leon Romanovsky <leon@kernel.org>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
References: <20240309063323.458102-1-manjunath.b.patil@oracle.com>
 <20240310111744.GE12921@unreal>
Content-Language: en-US
From: Manjunath Patil <manjunath.b.patil@oracle.com>
In-Reply-To: <20240310111744.GE12921@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To CY5PR10MB6216.namprd10.prod.outlook.com
 (2603:10b6:930:43::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6216:EE_|CH0PR10MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3881e8-483d-4170-0b66-08dc418195c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9DXPQ1iaaRQXjKc+PmTV28Vz3wE/qoejnZrAsSyRxw3IAgS9XCZAXm/UGELYpWtEIwuD7FY6aMQlibiPM4JMflSkxvc3/FOSohOaG8R533efy79befieYAaqW7Ne/f20H++bvN0XVKlcNMWapJA9guxInhDW0RHWiX6GU+lklu5mt8lFVpJT5wNG9mln4hcqOsU3izXdiwJocpo3cpYYMhLyBnbvLK6hR9cBaDO9IeWg8Abxn13EIKPl8EtB9PxHlz/pNtihepcwBpiMP+R7I0q6WEqVkJ5NQB6y3wPKsbTxuqQUA1jv/rOQDn0BfJSBPbmC99EGc0HI35F1V6WZgAp1FGbxEOraTyjqJjVGaCT/Laiba+28Sstd7vTfo+7nQW+OLbEw6InpPvAs6iSKGQqXREqNmi01LI9M6uDMyRXsXR+AMFo0Xlh99U3dogtzP5lBxlV6OagYsUlSQHUCKAFonEcVEaWKLXr0nEReUv/KXPTiGjUTVw8ZdfKtDLhNdG9JTcaUNLlUzbAeED5nWGQq4ImNmi8TVRaY8FWG+oBpvD4sTa5ZAUgEbp9OXmFlxEU6xQOfWMHVTzuRMPe89u95LgE/kVvdTOQSG+OaG7Qg0JKVLu/yhfJvOhodyePX+dMrnE6oZFnzKieLRDI5kZLBdLC6wvilzKo+hB2++0Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6216.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzRKbkdxU3hzeW9hdkVURVkzdmcyMEFLR0FSNUw5OUVPY0I5RVo2M0JHQ3FM?=
 =?utf-8?B?TWc3RXozaGhJRXpnT0RZM28vTTVzTWIwYWxiQ2VhK2xwN25kRGlsQ1Z3Z0Z5?=
 =?utf-8?B?eThRcVRmSngyREgzQ1lXdXBVQkY5WGVObzk5aElVRkNhTEU4WUlOcnVkc0xV?=
 =?utf-8?B?cGh1VzRYeHQvd2dNWUhNZTVNcG5DR1JDRnl3Q0xuUERqUjdRcTVtbEtFREEz?=
 =?utf-8?B?Rmc5MlI4a2ZETWFvMjNiZnA1UnBjK2w1MXl3c0lqRHVma2pXQUk2d2hWc291?=
 =?utf-8?B?UWtMWUhNWGFnMG9tMEE0bS8wdnpwWkM5dG4vMFpRb1grSGFTZlBaVzlkQ2Rp?=
 =?utf-8?B?RDFZWVc0R1VRNkZza1V4aGQvQUZVenBXQjltSkFLcFVzTCtrRCtyQ0J6OHBM?=
 =?utf-8?B?eUZIL2tZRjhsRnBMZEpibTBYZURZdUdjTnFLVGIvMzk5WGUxZWZ1U24raUgz?=
 =?utf-8?B?L1JhNDlxOUdSOEFRcDgxUEFhUnVzVTFYVmQyZkJMelhTbS8xbmxDNFEwWXFG?=
 =?utf-8?B?RjN5ZUl3US93c3BPejErZERrZWl6MHRUdHIvYXV6RnczcXJ0VmZDazV4NllD?=
 =?utf-8?B?RFZLbm5UR250YVNnWm5vWFE4TzVZUHFHQnhTNGtkdTEyeWN6ZVYzWFIwQTBN?=
 =?utf-8?B?WXBqcW1PdVNQcjZGNzdLZTJFRTRrcU1wRm12RzdzcFp3OVh2dXRhTDg2Vlhi?=
 =?utf-8?B?T0ZGdE55Z1hYazI2aDBzTkJ4b3d1Y1NRSVkyR2ZLaEhPaXVpS1lCUTdWbnhw?=
 =?utf-8?B?dzFlSnFJR0ZCL2tBb0ZsMk1Iblc1RStuUmZwL3ZZeGducUNVeExuTWpHeFZD?=
 =?utf-8?B?RUI5RlNJaWtxMmk2WDJqblNCbmpvZlpSVDkwditMay9xcUFzaEFJL3VPeGJ1?=
 =?utf-8?B?V2hkT3kxVVl5STVtWklodkRlMUxJQTBZZU9DaEE1NWNBVWg2cUgwTkU4ZzVw?=
 =?utf-8?B?YjdGQXJ3NUNLRkNRbkkxdFpHbk9zL25qVmRXK3lXSnNUc00rUmdOdzVBMDNs?=
 =?utf-8?B?VTRRWUhlL25kOWszaUp1ZHZQUDh6SFpzcjZYSm45Ni9DcUI5azFuU3hMMXBm?=
 =?utf-8?B?cllzVEE5MXVWTHlPTG5Fay9lVUVmSytVTFNKWWFtOWN2cDhLaGNnWU1SU0tv?=
 =?utf-8?B?ZnBtWFBkUWdpNzRWSCtwdEtsNGl6ZlgraXd4Q09mTGdYb04yYU96WW5CeFM5?=
 =?utf-8?B?eUErcWc0Mk5USmpXR1RTaCtLc3lrZGVPektBVGcyTFE2TmZrMTAzYjRrR2RP?=
 =?utf-8?B?RFBkOHRMZWNkdS8xdzhhdmNLTk1rSVpTL3RVZTVPZTdYOVU4bmFVZWczN2Zy?=
 =?utf-8?B?MUsxOEMyRGJFUER6ZHlsQlpSdUhQNHJyaFZVTnlJVWlEc05xSmNaR3NoQzU0?=
 =?utf-8?B?M3YzS2l1dDQ1WWpIM1EzUElzNVYvWmtaWFJod29LWlo1VThoa0hGOVF0L2Jn?=
 =?utf-8?B?d25ETGd4UU1BR0paTnZFZURxS1hMYmhnbmZKajZPcHRBb0tyTlRSaVhpcXJS?=
 =?utf-8?B?Tzk5bVVJNlRkUjJIYzduNVFIM3lueTB5cE9kN3BxbkVjVGo5L3N4Mm5zMkpv?=
 =?utf-8?B?YVhUMk1ZeitxRmdUU2VKY0VkaUpiZ2VHekZqWElrbGh0eVJsN2tyb0MyWHVU?=
 =?utf-8?B?TTBMRWV4R2s2aHkyTTY1a0RoZWt5b0FQMlBGZDlQdTBlL3h6VlZSdXhUS2dM?=
 =?utf-8?B?TkJRN2pVbkRKZkZIMTl5TGRHanlGNnhVOWgwTDhQUGNCNHJwY05QeFV2aGJH?=
 =?utf-8?B?a1BXeTE1QUVsV0lPRGYwNGM3a1M1ZG1XdTRPNEllUDNvQk5xaFhMZVBoNFhj?=
 =?utf-8?B?UXZ5aEJScW5sTVQrQktHc3lMeGw3WmVpc0hPQWdGQ2w2eGJabG1POGRXdzk2?=
 =?utf-8?B?NkNrbFozR3NYa1Z0azRsS3k5SWlZTEZZYU1YUVBXdTJZNUxnclRGalhET0Nq?=
 =?utf-8?B?L1ZZZ3JvMXp4bVhlTWdyVlJUekRLRWIrTE5pZ2luNEFLN1lDUG1JNVRzaW1J?=
 =?utf-8?B?d21SSHk2KzUyK3hhRW85LzQ2emczVGdHZmJoM0NnNnBEdVEvRHNrWVhyK3pw?=
 =?utf-8?B?Z0NPSGRocmcrVDlrRDRRZDB6a3NtWUZnOFNZTzVWSmRrc0V3Y2t0dC9ZTEFM?=
 =?utf-8?B?WjFDdkh5YnI5bGF4RkEzY3N4ODVOZHE5Z09ud09HNDZGbWVsNytvMUJ3dHZE?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DhUbexHr5Rn4goNg/tkiEFMJ2tqlbfObBP4Y4i7OtolltTyOrf3MePIG334orfgakmzC9U6Yg2lwqqb8pTgRFxKleGowIePJDT/g0nmvH46u83rngJ+Hj2RqtAPTMd/xxzn1jK+GYmj0refFAbcPSe3QPjtAyXMEBuecna9lHG2c5onhLY5eBMlrp15MHOaoGOW9/IT++l77FNgl8HE29syGxSGP7hoepTZP3ws0tAxMAbwfu0Vg53g1e3Svn33H5UXQT/rHWx8qdD6qxFHxUas3pgFVx1Yp82zA+gfy1CN/e3Z/m/3vWzyT5k/akvBE+a+A4IuDQtpIs3tyLMDegiGBYEAK29GRJuPx3uGe4n3oB2UnjYBYNHVtkDIoN5QkiYS5SMWboueUQh8gg1ZT0E9nQwABNDeO/b1eUo56rMPvzPh7QMix/RQMxYbJZfeNbEsfbdFnTJs/WWiE/dHVnySOzhnhJGNXqXLr9feOXmGFD+n/ywGaKasDecIZglRE2+IBHsQGdJlx0oEcbJEqEwDFK43pJ6NhzRyCTPsV1Nf7mfK9g1XwN88adzgwYuHQEcmigqFGVfvfEOV1QiHGO1KZY+KIL35FcKIlJ/21fic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3881e8-483d-4170-0b66-08dc418195c0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6216.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:13:20.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWuRCfIcIhspBtrDP8ziLBBBS/pHj2wPUucUwO1B4V2I0Cq3XlXDFAmGScVNOBMPpf77CmTvrqBmtGEzVtertxb7nqE9YPPVAzRer/2Qt+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110030
X-Proofpoint-GUID: XqCFzxaiiU7R95mo8NgVfFzaVhYs8bMM
X-Proofpoint-ORIG-GUID: XqCFzxaiiU7R95mo8NgVfFzaVhYs8bMM



On 3/10/24 4:17 AM, Leon Romanovsky wrote:
> On Fri, Mar 08, 2024 at 10:33:23PM -0800, Manjunath Patil wrote:
>> Add timeout to cm_destroy_id, so that userspace can trigger any data
>> collection that would help in analyzing the cause of delay in destroying
>> the cm_id.
>>
>> New noinline function helps dtrace/ebpf programs to hook on to it.
>> Existing functionality isn't changed except triggering a probe-able new
>> function at every timeout interval.
>>
>> We have seen cases where CM messages stuck with MAD layer (either due to
>> software bug or faulty HCA), leading to cm_id getting stuck in the
>> following call stack. This patch helps in resolving such issues faster.
>>
>> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
>> ...
>> 	Call Trace:
>> 	__schedule+0x2bc/0x895
>> 	schedule+0x36/0x7c
>> 	schedule_timeout+0x1f6/0x31f
>>   	? __slab_free+0x19c/0x2ba
>> 	wait_for_completion+0x12b/0x18a
>> 	? wake_up_q+0x80/0x73
>> 	cm_destroy_id+0x345/0x610 [ib_cm]
>> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
>> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
>> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
>> 	ucma_write+0xe0/0x160 [rdma_ucm]
>> 	__vfs_write+0x3a/0x16d
>> 	vfs_write+0xb2/0x1a1
>> 	? syscall_trace_enter+0x1ce/0x2b8
>> 	SyS_write+0x5c/0xd3
>> 	do_syscall_64+0x79/0x1b9
>> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
>>
>> Orabug: 36280065
> 
> Not related to the upstream.
> 
>>
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> ---
>> v3:
>>   - added #define
>>
>> v2:
>>   - removed sysctl related code
>>
>>   drivers/infiniband/core/cm.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>> index ff58058aeadc..793103cf8152 100644
>> --- a/drivers/infiniband/core/cm.c
>> +++ b/drivers/infiniband/core/cm.c
>> @@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
>>   MODULE_DESCRIPTION("InfiniBand CM");
>>   MODULE_LICENSE("Dual BSD/GPL");
>>   
>> +#define CM_DESTORY_ID_WAIT_TIMEOUT 10000 /* msecs */
> 
> CM_DESTORY_ID_WAIT_TIMEOUT -> CM_DESTROY_ID_WAIT_TIMEOUT
> 
> Fixed and applied.
Thank you fixing and applying. Sorry for Orabug and not being careful about the typo.

-Manjunath
> 
> Thanks

