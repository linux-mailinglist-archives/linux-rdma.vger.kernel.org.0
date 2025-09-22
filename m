Return-Path: <linux-rdma+bounces-13551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E15B8F414
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF513166805
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1E2F3612;
	Mon, 22 Sep 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLnZ20ky"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370819007D;
	Mon, 22 Sep 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525392; cv=fail; b=e/CGgkp9cejkaU0OBl/AZAdc/H0bBIdZzdL3KnoikFD1E5jRU7RsoySucjzZXiOtnGGSa2wVRkwUzc9l92J1wcMLXrt7K8SsrndzKyBa4YdPovv0enV3YCgOBqAMR867Wj4+fOgfbj5gs4Ud8PFVst46aGqZRTBy823zu/HhuFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525392; c=relaxed/simple;
	bh=ARYOSmTArM0Dq8+9vg8p2ql63D6gECMe9YRHKdupEYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZs0CB4xG57YgBjTdQENgVvgkU9n7yXSI9YYGfGeykn24MtI015Ua8sl0Aq8FThSH1tPs1g5UYy+clChU8fTd5RxCjsNItV8qUIzEAym6EGXw5P0zGZs/mphVK/JPbdOjEBuQYkOegagpDOCXCZehqbKesVp/R2h25l/3jV/Qoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLnZ20ky; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW1aQhwuqqlJdF5r7YyS5XPVOT6xlklT4t7bZbNaaWhnX3dpaN2qY+wF1c4ePcqkKcfaVsW4IVTpV4zGKoiWLnLS585wy0Gro9AcfzLANIagYt4y7iWpO8nQPJSCjAF9D1uGHPBQHEdOsMibEqqdkBef4TrXP6EQ+D6GH72rH5gaqbLz6tZYfrjdozPu8zg0XWq4V3xWF5Z+qGUMI0WK3fR/vv1zHAguZhQ38iXwA3529beCw4chxMGZ/VXCpxQfExnKp5EhH6J/7L5bA7s9YJJmsgHsFPQ4CyS+XEVs1kQeyaoGzCw9mxvINs1v2cw7TBLeH13EYBkbLPJUy/EfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pSqK/r48+eBhoJOBFfouh61y96nYrd37bejO/jaGmg=;
 b=kVOq1tsUkCmrNGASh/OZPI1QNejgLeec8mNnlFm8sM5CfV/ouinzMWQ04z56VBChwhsuekN1hTf78XIan/6cDan/c5j1N1sD6e/EyLTnSxSWBexHflCkkUqSfrTGNVf4WBOIOEyp02jodXfV0/JhpmGBsRu+4A2oJfMlzaefdpqjXOvIxcxmD0NglEaXRqYJCxsX01zactFR3KLdOHFPTruzOgs72Oe4f2iOGs8hGmRI3srbf8ThKJxmTIrjf7b+2Ssu5Ut/XOXlAgARtIOxOZe3AEHFF3a2MCRMaf/I4p6qOp2FTCZz/aK+hA6YJ5cw7wSckdkb/V74SY6R4uiTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pSqK/r48+eBhoJOBFfouh61y96nYrd37bejO/jaGmg=;
 b=qLnZ20ky56sMNOdQFOYCJMi3RMIAzjt7K/cj4I56rviOkEcIXtzdf8IuxwLo4WNRngQaVoInfu8KmdVTS8+QERI70fFM7B5Gb3shexlrF+k9iVTY0vxF26mSP0m78fs7hwPt2ezGBHJ+ifKOh8F/RdX7NO7lxZxeem83tc5Z5QLwEQEiicvrcXb9bDgbGEo24kZ86YLz0dVKmlbVLvnfk7I9YX+mRg+gb7jAJdIU18vuHuodpqp8296xcqVXywHyyxYgBsNzDxrC54Y7YHXyX9XglrDooZ/E+rtf1QUQgBfgMtPa2FM6LkyOJnrmXqY7bwwJdARzKYDQEknqMYylvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 07:16:27 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:16:27 +0000
Message-ID: <b5790517-a15e-43be-ba70-fbc9dbe2b6c9@nvidia.com>
Date: Mon, 22 Sep 2025 10:16:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
To: Sabrina Dubroca <sd@queasysnail.net>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <aMQ48Ba7BcHKjhP_@krikkit>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <aMQ48Ba7BcHKjhP_@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a07b1bd-5869-4791-3553-08ddf9a7f1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2FERjV3UmhUSm1wWW1tcC9wendLVWk4WldJZlhxclRXbjZiMHNFL2pjYU5E?=
 =?utf-8?B?b2lRRlpFMVFzTW5Ub0d1SmlFWXBMcHIzV1lETGw4U0puSFdYWVBra2cwaDB2?=
 =?utf-8?B?M1JJOE5yUTdFcWZvTVRNS1o3NjBVWWs1aXNGVDRnaFlYeVRWWWJaQ080dmRj?=
 =?utf-8?B?eGdWbUpNM3RGdVlIYU1VazRCemE5VGZKWDEyYmw5U0U2UGc4NktLWHdjMzJ1?=
 =?utf-8?B?SGdPNDMyZXgxYW1nU2pZU1J6b3JEK1UrNHl0NWpTalNIM3BrM1MyZjluVHlK?=
 =?utf-8?B?cU5kYyt6eEFKcVhzNXhBVW1YQUpJQWpVclEwUnNvcU5rQjZBRS9VKzFjM1lZ?=
 =?utf-8?B?NXJKVE9NK1lFWklFTjZmeGEzbFczSXliS1BraEZGeU9ta3d5YTREM1d2Y0Z1?=
 =?utf-8?B?akZ3OVlDc1l6M2dGQXRmbzEzMzV5dDNWMEl5YUsra3d3NElLQ0ZqTlR0WjZN?=
 =?utf-8?B?UHkxRVFwYjVDNWw2MFY2Nnc1MFlJa1U5bHVnaUswSGc1UUZXWmdoRkVFWUdy?=
 =?utf-8?B?YkYzT01KdzlBd2U1bzdUK2phLzB6K1FKRjdKUEc2V1l5dVZmald1L2t5blEv?=
 =?utf-8?B?T3NBRXIwY3AvbHRmK0thUW5MNHJIUXFUZEg5ME51K0xWblF6b0d2MzFBK1dG?=
 =?utf-8?B?aVl1b0c4cTBiNjNlQ3AyRDlmbmFnK2hWcWxQZ3hhMW4yT1g1RmQ0VXRvTHAr?=
 =?utf-8?B?bGVFVHZDcEdwbVhXNkVLQmN6UGZSZ3N5Tjk0emRPcGxsTEQrV0xFV05hK2Rp?=
 =?utf-8?B?SDFFdFhYSVp6OUpwQUUyRm5yOEpqNGxDb1NnRnBIU3JNM2ZLYUVPLzNMeWg4?=
 =?utf-8?B?MGdOYk56QWFkUy85SXF2MXVJem1Gcy9veU81NEFKb05zTmhQNG1sSlFMdk5n?=
 =?utf-8?B?ZjJSWFJNbFl1NDZScytubXJORk1zalZzY2x2b1I4R040a0VyblFNSmZlSENo?=
 =?utf-8?B?cmcwamNMVGVxWGFwQ3RaOXRpKzFkTW0rTVNpOStWTUppSit4UFpDVW1JZHVN?=
 =?utf-8?B?eE9SRUpzK0ZVY01lWnR6bVY5d1ltdndiVTE3NmhUcktSdUgrandjMldUcHlL?=
 =?utf-8?B?OTV6MU95b0dad3hmeDFJOUxMRVp4MkRueWJBdldsZFUzWjhEN0NPVGtWL3E3?=
 =?utf-8?B?Rm9nWmxBSGVnK2EyTnlWb3FpeXpQQ25rWG94amtjbUVGc0w5dVF2VXlmQzlU?=
 =?utf-8?B?TU1nUWpJbnhxeU9HMTJ0ak13Mmc3bUFTWUt6Z0lIU2dSdzJvWDIycGREN2Zp?=
 =?utf-8?B?T0VYc0NGZjEvWFV4YnBhK0dtdFRuUjFBeHBNSTd6VlNZOGJFNEs1clFxUndJ?=
 =?utf-8?B?TTVyZkFGdENUdVNVSXpsa3pudTMwb3JiQUNMQkdZY05ZQUd6OW5vTHVhd2dT?=
 =?utf-8?B?Q3U0cUdiZzJjMS9OcVpWVS9LR3lkcWVtOTNOSzBIRERNaWZrbW0vNTdoNnA3?=
 =?utf-8?B?aTJVcGx3UTlVQXNLelpmRDh6RTRZUGROWGtXNHMwdGZWY3hrYWhNbUs5ckNm?=
 =?utf-8?B?clpWVGxjeWdZazh6dnJsd1A0QlNnTCtJeHhPanAzNDJrOUxuU2Fyb1dZeFkw?=
 =?utf-8?B?RnBoMnZ5V1J6cWQ4elBHcjYxQjczamhKZENHc2ZucWxmUUxraGtXbkliclhl?=
 =?utf-8?B?NE51VGhFRTdLak5Vck1WKzUvd2tzYmJudTd0dTNFL2Uyd0ZiUkdEYlJlcXVP?=
 =?utf-8?B?dmVITWs0OEF4OWpVd0hRcHpCSUpPLzZwWUE3aVJVSTBMQURkT2NyWndyelhC?=
 =?utf-8?B?c2xjSS9Udmg0SzFYWmFhVCsxUkVCYjVmWEhRdkJTc0Fpa1pOdUpHc0NMdlRC?=
 =?utf-8?B?bXhiTng5Um9mYnZ5ZTRKSnBER1R6V1VaY29mZnk4a3dtNlZJOVZpZlpYd3ZD?=
 =?utf-8?B?YjRVYWcxbzIvOS9sc1daVWlOUHB4UlE4ZjM5RWlrQVc0SHlRZGJoOEp2eU9x?=
 =?utf-8?Q?Fkgi1hpGUl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXBhWEs5azBmakxwNVdPMzB3dkhNbnZSMkRQcVlwbXYyZ0NadW1JdUdsYjk5?=
 =?utf-8?B?M29KM3o0bXFYTXIrQ0ZKcjdrRlVXVWNuTUVhYXBxTFBvNFFPUGxYT1c5Qzdv?=
 =?utf-8?B?QUJ5THlwNGY4MHVtWmN6UDJpTlFDWDdtSFNYdlVCTjZtSU1seDc0aUtJTU5E?=
 =?utf-8?B?WmtDNEFIMFFKVzZ0L2VPY3poZnhVK2xEdFVidUV5WDlnZFF5Z0hsWjZyL0Vv?=
 =?utf-8?B?NWNXUXVRQlJwai9ZQmRHZTVCT1E2SDVYbFFlMDhpK2pKbFBEMmZhdXJVS3VO?=
 =?utf-8?B?WkVrb09hYmk5WEdoUDFzNmNNczJCQnFUVUx2NlNDSW1oVW9SbURidjN6WVhC?=
 =?utf-8?B?cHNMMUE0UkpYaFMyNnZkWFVuNmxoVGp4eVd3ZENqUFBhcWdnd09DQzNkV1JH?=
 =?utf-8?B?UEVVeU8yS3FiRG9BdDZieGFoSEFwK3NralRlVUhNYTcrM3JiaXF4NlkxQmt6?=
 =?utf-8?B?R1lpR0RvWlpFTFdIWVhjbUVpMHpjMlJzazNBR3N0eGQ2ZnAzcFdmbTNtVDgz?=
 =?utf-8?B?QWpHNTlPWlBtbFZ1a0Vickc0MzZVa3JaYmdGTzVwVTNOYkpyek5QVjZhRHl6?=
 =?utf-8?B?UlF0bCs3Tk9vZVlsbnJLcXhuSW9TbGVjTnF3aWdzTVdkWW9UZE1mbFlCbDlz?=
 =?utf-8?B?akREc0hkOERDNWlXR3p1RG80OVZObmdRZHhJYTc2czYxSE9mb0NTZk95NU44?=
 =?utf-8?B?SUdUZEFqOWwvSHFOOEZHV2RuOTdOcDljL1JKajhQUlRTZ1lQdnZ3RUIxOTJL?=
 =?utf-8?B?S0hkNVV3ZGhESlBUU1IvRzlyZE5BQU5wTkZqcktJQWk2b2lMS0RvaDQwcVpP?=
 =?utf-8?B?WUhjdUd6S3dMUW5paldTRzhyK1NaK3oyV0hqQ0g4ME9rRmkySXB2U1ZOVXky?=
 =?utf-8?B?eEVOaUI2dWVVQmk0SzZoMUdtSy95V25lMEthUHdHcEVrVi85aEYvNG1GcDVp?=
 =?utf-8?B?d3FySGZvTXJxUWRjTmZpL3BlRyt0SVEvUml5cU02NDlub3N6cXJ2aGpGYmh1?=
 =?utf-8?B?cGo0R1JvRzIzT3kxU3pIM1daUDlaanBiVmRsbWtGdVpXNE1PV0YzNW90eEhx?=
 =?utf-8?B?NHp0UGtuT3IvOW9IU2p6M2dsVXhXOGJVanNUSUZ3dkIzSVVuTkRDRUdtNDZr?=
 =?utf-8?B?QXNuMm5qWTQ0MEVNVWVpZXg5NkNQWithWDc5cVdwVDRLYm12aXhOc3ptQWln?=
 =?utf-8?B?ZjcrMVJneDlneGNYSTlHUGFydkZuVHF1MWRZeURBdlBWL2Z0aXZzOUZHZlRY?=
 =?utf-8?B?OTZ4dStzQy9jR0VtcnNyNERlSGI1YTMwVEdqbjZIaEZpOEJLSGxZcm43Q3N6?=
 =?utf-8?B?Rlo1bENHcjY1Sm9xeHpXUlI2Y1ByMENxcndUNW5aTlllV1V5aEg5TVp4NFFB?=
 =?utf-8?B?NWZad2FxRDZjT1p3dVVHZUJieGxtSnBod0F1MEFzQ2lqN2xzWkJZUlVNWUFO?=
 =?utf-8?B?bXd5RFNLbXlpd2JLK2JreThvajNiazVwZmhaZHVQR2FnUWVFVVlncklaSHk1?=
 =?utf-8?B?cnNBK1g5cFV0cUxoVlZSYy94Um9wWkdmOUJFNk5CbjgrdklJM2YvOFlqYUJp?=
 =?utf-8?B?eCtiM2IrYzNPK0xGQnh3YWxxYzh4amZQMUs5OXgzTHI1a2NrWFIxSjRYME5o?=
 =?utf-8?B?TU52U09wcUpaZDRNdVNrTjA4bmU0ZVF3Mzc1Nk5OMkhjTS84MndpQ08xUW95?=
 =?utf-8?B?c05mUDBKa2NhdzZjcElzNlREQy93bGtoVHlzYk5QeDR6dFJGOWdvUmZZQm1s?=
 =?utf-8?B?cUsvcXljSlhxMy9wdG9yN0I5MHQyWDVIWHRWR1U3U1ZWNnRnbWFyYlVheTdD?=
 =?utf-8?B?aFdQRHpHNDUzVWVDZ2ZDVlFOZFRHUDBndUVxZkc5c0dQamhTZEsrOVZIZFNY?=
 =?utf-8?B?a0hVTFdpc093cUVYVXdRVlBlS2RSa0l1TmJ0MWNSalBOeGpLRi9GM1lVdUxV?=
 =?utf-8?B?MWN2YldFRDZsamVJbkJZampwcnVGUmxUTzlBMzJzZGNJbWY1dkJ6K0lJendE?=
 =?utf-8?B?Ulh5YjlRci9JaDA0S1hSdjNGdmNNSWh4RXNTYzZtVjRHMFNsWWEvODgyZDRa?=
 =?utf-8?B?ejNRbnhWUEpzQnNyUWxJbVFacVViS0UxSUVwdVpUUWtIQkZid2Y1WTVDSUxl?=
 =?utf-8?Q?t93fD1wUTRtK1YvfAULO6+4y0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a07b1bd-5869-4791-3553-08ddf9a7f1e0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:16:27.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lSip/s1E6zd4FthvOeaKRRfVvkPREmwpI/opRxiHz4d0JqA92hVOwgCoKUE12CirufHA0z8bObc8AzUhRm9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39



On 12/09/2025 18:14, Sabrina Dubroca wrote:
> 2025-09-10, 09:47:40 +0300, Tariq Toukan wrote:
>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> When a netdev issues an RX async resync request, the TLS module
>> increments rcd_delta for each new record that arrives. This tracks
>> how far the current record is from the point where synchronization
>> was lost.
>>
>> When rcd_delta reaches its threshold, it indicates that the device
>> response is either excessively delayed or unlikely to arrive at all
>> (at that point, tcp_sn may have wrapped around, so a match would no
>> longer be valid anyway).
>>
>> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
>> to explicitly cancel resync requests when a device response failure
>> is detected.
>>
>> This patch adds a final safeguard: cancel the async resync request when
>> rcd_delta crosses its threshold, as reaching this point implies that
>> earlier cancellation did not occur.
>>
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  net/tls/tls_device.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>> index f672a62a9a52..56c14f1647a4 100644
>> --- a/net/tls/tls_device.c
>> +++ b/net/tls/tls_device.c
>> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
>>  		/* shouldn't get to wraparound:
>>  		 * too long in async stage, something bad happened
>>  		 */
>> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
>> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
> 
> Do we still need to WARN here? It's a condition that can actually
> happen (even if it's rare), and that the stack can handle, so maybe
> not?
> 
You are right that now the stack handles this, but removing the WARN
without any alternative, will remove any indication that something went
wrong and will prevent us from improving by searching the error flow
where we didn't cancel the request before reaching here. We can maybe
replace the WARN with a counter. what do you think?

>> +			/* cancel resync request */
>> +			atomic64_set(&resync_async->req, 0);
>>  			return false;
>> +		}
>>  
>>  		/* asynchronous stage: log all headers seq such that
>>  		 * req_seq <= seq <= end_seq, and wait for real resync request
>> -- 
>> 2.31.1
>>
> 


