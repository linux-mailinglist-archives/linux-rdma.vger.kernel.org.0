Return-Path: <linux-rdma+bounces-11260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18D2AD7470
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589773B21C9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAEB1CAA96;
	Thu, 12 Jun 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mxjS19Fj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EEADF49;
	Thu, 12 Jun 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739653; cv=fail; b=DA9G1SotUrE6kfJjtCGE/QAv5wrk5kwneh52TYFThCVDyCGKC1kIPkPS++wZDwbNmoMEIe38MgsWD9nCKrqPcHGwrGTceuLMn8YS2MYgGo8DRN2msHehaEhBEJuxY1DTd/WaRCnfy3545//KfxSt4lYFGdmHol8K3akb4XDFmsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739653; c=relaxed/simple;
	bh=XQEEWnqNp5FqwRM3LIcSMTO+96AhJu+L9EAxWqS2iZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUkuFxTkZPaLfkxCzei7d97ZYAhE71t6J9eztfH38WM0tT8+thR0kyk5Hi0vJ/Z+8ilYQttI6RiSDyrEyjvU2f4xPLnSUdOqdMRQExnJ+Ai6RpFLFdNZUry1zQuXDgew6kcrDGRtorIIZFBTxSGffmsa2xQIQBYGSBn9AfwK4QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mxjS19Fj; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqqAFKaEubOnsRTa1ez21n2BxchOzJ1lnEEUy6lWdTlewWAlqbNVJT1R4BU2stHbwfp/ivbl4xWrDqABgD8wV+0TtKsPCc1/xpeU86idQI0Mm1wutzmlLgzd0UQ7/a07dGmBKIEiadxBbCfuLxBgC07zDUOrwXXzZFwgQPoDS3o9nrujHvTnshr6rlZmtocfmDgwgO6tPnYyvbkvH3+HlWXeFMAjv+q/QzSoSSCzZDz6R7CPr31x1ZLOo2AkiJLcFRWeoQ0oKWYW0L/u18vM3QPR2c1JohQV8Pwkc1rakZCSI5x72/ZDanIvbQZ6jS0fHwA7pxeD1Pr3Y/FFs7DVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+rCZkh9ApSUFsYCTSlRsP27skOesxNRgNHdVbuNhhM=;
 b=QWWqyiC1CBf+cruoS7CzGCAlHy6uiCCdN9cln47dfL9AbXZ97AEV5IMYlrSpFaj3c6PdHOSJW0paNubDnF9rltlIGdtu0iI/WchgpNllpxkjfolcs94PvpWqJPPvIq0ijnGO/zqn8937NS7u0vy6V/cePDr0awVLY2VDPo61qFcp+m3QQ8rdV5xhziqn1VeAtcVqDkIfHBP3oKzOV4AHWelCMPMsbOEBGyTLBeqnsSrhr4uB4WwuVM7Cf8F2ad2kn/HvvY1XE6jV7e/a1INC7Sf+FJJhzQrV1rauUQZW22W9JMYldDYq7+UgKN8yFYXkkg99nJs9I+qAC+D9414rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+rCZkh9ApSUFsYCTSlRsP27skOesxNRgNHdVbuNhhM=;
 b=mxjS19FjbEv9/vYwrhYSxV8KTANyz/F1HE4R9MVZ2uLAlFrGdPIX/kAwayn9g2exo7H7+DiZJ8f+8O02pxT9qA4zs0yHa0mrYmrCU4m9HAix/MjxdegqxEf1LjZK37q9LmGAlwShcLUrsOLgMWy9tlbY8SxBSN5SGqspLHZI4z3QQCK2hDIXiztbybOLUb1qX7Go3nqXBaGIwMxVf7S1n68ggP0iNLzFw31zQeH1wq2iQmGK4j8eS9DM8ceK0rkH7BgTGu6NxPhH1C3L4Y7GDmvL2j2sELMsVgDwNdysiU5NegwdPgW+DCphQJ0OoPId/lYl15JffnYBJARQo1iWXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 14:47:28 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:47:28 +0000
Message-ID: <badcacf1-c42e-4cd4-8d3a-a9a5b3407439@nvidia.com>
Date: Thu, 12 Jun 2025 17:47:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/9] net/mlx5e: Properly access RCU protected
 qdisc_sleeping variable
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com,
 leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610151514.1094735-1-mbloch@nvidia.com>
 <20250610151514.1094735-8-mbloch@nvidia.com>
 <20250611144013.300c79ea@kernel.org>
 <bdfe62f4-8b70-4284-b06d-e50ea6ae2d88@nvidia.com>
 <20250612072218.6be4547f@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250612072218.6be4547f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdb39a5-800b-440a-2033-08dda9c00d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVFySkVuaWlRZllGb0QrUVVudG1KeUxIaTNCbUxwMy9YWlBJaWREdkx2VE1o?=
 =?utf-8?B?RDZhMk45VHBTZ054Vk1mWmp1SzUvaWxvTENUWXJ4RzI1WjVVcXBQS2ZhZFcv?=
 =?utf-8?B?a0ZveTVTT01iSkFvbVRlNzlRdGRuSW55c0FkazY3K0ZzOWNFWGNhSVg3UkxO?=
 =?utf-8?B?cTNSU1ZvZHpNY1NaT3pGS1h5N01ib2F0SFlueFc3VUJYa0E2a1Y4N1hwdWhG?=
 =?utf-8?B?TVJZVC83bmtaKzFFbnFsdURRUEhjV3RDZ3BpK0RUSXlNM1dnRVRISi9Xc1cz?=
 =?utf-8?B?MzlqM0ZCb0NXUjFQUkhLczJxT2UrOVRkSzhaeVNTTVl2bHdPYzNQTW80K0c5?=
 =?utf-8?B?Rml2aU9qWkRwUFdIajhCcDN6M3IrTkk3UG9GcjQ2di9VWE95YSt0aUhRMXJE?=
 =?utf-8?B?bjh4R0hDa2xOWkMyeG9VVG1GbVNmZGJaREpRQ0RBVWNlZHVRSm45QnJlSkds?=
 =?utf-8?B?eXlCN1ZZUUVPMEZaZ3pnUUtWV1o2OGlzSHI3QUxBNkpFQTVBbm5mUUJ3WnZD?=
 =?utf-8?B?aEo5aUlQQ3gzbUlrdUNOWXVBRVgxMld2Ymt4OHJQK1locmliamRMb2VnazBJ?=
 =?utf-8?B?YUROU3VOT2ZnV2RpSHZtcVVjd2ZUWEwxR2x6Y240SE8xWG1neXh0U3FPVCtW?=
 =?utf-8?B?dzlDSHFqMFZoa2htRER1VkUzUzNtY2JJeGlvcjhUUEY5Q295eU9WbVIzYzc4?=
 =?utf-8?B?b3JtcFVWL3U4bE9xdWdjUnBuTUU2USszbDVKRFpBVk9hNTFYU1U1akdndFp6?=
 =?utf-8?B?bmtZT3BxVDlEaEIyVEZLdnI4UUE1NGhhVGJEMG04d1AvQXRpcVFLdVVXRUhH?=
 =?utf-8?B?N2Iyb3RRMW9uY0VLc0VoQ2gwc01jUXNnUk9GZ2pxNFJVUzZUczhEN2tCVVAr?=
 =?utf-8?B?eUNNSFdPUVJsZ1d0dHd5bkZVUGRPUDRDRVU2dVpuUFZPUk1YLzhrUmM3V2Rk?=
 =?utf-8?B?WDE4eVFRcFB2ZG1waDBWTHI0eVVQeVJqREtDV2tRa2xveDRkYlNlSkF6UUF4?=
 =?utf-8?B?SUlMQnJBbWRJaWE4ZjdFZmFwMlRCSGZiVlcrODVGbjRUM0Y5eElRcDNuUHRE?=
 =?utf-8?B?L0hialh0WWFnb0RBdGZhYmgxbERqbURtdm9CZ0JLR1RSbGJ2WXJjT1poTHJy?=
 =?utf-8?B?WmE1ZGIyek5uWGtrS3c0RXBvTG9TajNoZGhzRTdMMmhDMlBBTVV5bnV2d3JO?=
 =?utf-8?B?QTkzZEszQ2dlSW8zN3hDcU9JNndlRDFWV1pYcU1HSGQ0ZmJBamtYek9pZ2wv?=
 =?utf-8?B?K1hYM0dWOXl1SWplQk5UME13K050TlhVN00zVGxVdXRTSEwxOFJ4MlIxdk1z?=
 =?utf-8?B?NG02WjhFTHNWOE51L0RLMjE4ZHJJRDFEZ3VvazhaYkRvSkNqV0ttMWhPSWV6?=
 =?utf-8?B?T3FlZlZMTXVuTmF0QnYzUGhWUU1UVVFjM3dvZm43Mmpxb2tJREJVS08wM1lZ?=
 =?utf-8?B?VlI4djJwZ2xZMkg0NVJtOVp2L29mcVpOdktPNkVValBpSGdsRTFxNDNQUnJ5?=
 =?utf-8?B?emJPZkpPTHlPazQ4d2hPZkI0a0FkcEFZRnJpMiswVFBla2QvaUFJbHVCZTBt?=
 =?utf-8?B?WHJmWDN2K28yTFJUOW1na3AvT092aFo5aFRQYlBTcXZGMUgxQkliOG5ZRU5B?=
 =?utf-8?B?Q2tMNWtDdElmcmtld0tzRHNFYjJWeHB6L00rYUtITDdXeFJLRmRlUVFYVG9y?=
 =?utf-8?B?ME5mWEorRjdmSHVTY1MwSEwvOC9BTm1lWGpndGNDd1dQbkF5ejFZaWs4UklE?=
 =?utf-8?B?TEp0aFlGV2FyejZQR1FUeHRBQzZ6UllRTFhWZ0pmSXI2cm1aK0lOQzBnWlIr?=
 =?utf-8?B?QmlERjJiamFtZ2N5QUZKZGVlcG1uUkxzRmp3a0xDZmE2YWRoY29kSkhBaU5x?=
 =?utf-8?B?dHhpa0N2M0lnZ2tlSVoydUlkMlZ5VGJYOWNkNUpnU2VvY2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTN4QWRsaGU4OE1TTlZmRFppUHRVL3ZUS2xXaGZacXRWeis1eldGRmoya0Zv?=
 =?utf-8?B?RXVFY0EwUElOd1Mvb205aVdBYlNVTVFRMkg5Wm5FZzArdlBEMlRSSzJ2azFt?=
 =?utf-8?B?UkFUamZwYmFNcVRyK2xvV2lWeWRNbHhtd0lkSFpNM2U2aUN3Zi9RNkFJOEl6?=
 =?utf-8?B?U2FYVDFDODlFcWpOK3BvbW5aQjJCSEYyQkFHUzNtb0ZRUnRiUmNVYVJSZVlY?=
 =?utf-8?B?MEEySEpiNU9PNG1qOTlJdFRxL1Q2MW8wQmNCSE9LejVTN3ROcWhTQ01uRk90?=
 =?utf-8?B?N1dQMFR2Z2Z1ejZXazNRQjdlSTdxWXZIRGhFNkFWVUtlVitnN1VVQnFXdUZ6?=
 =?utf-8?B?ZlRNZUdWYkduTjFwamRuaFF1aVJkbGNseUw0cjFlTm9oRTJmeTlvRVlWZ0Jn?=
 =?utf-8?B?OVZVTURZdzRuR3pxcDVrYTlQSEFlYks0UTE2KytwS0o0RjN4Mm5kSmFtSC8r?=
 =?utf-8?B?N3hTekZsRFNuWm1jYmlJM1hNVzY4dDJVb1hPMXVRd0tvbzFtNGhyL2FFQTdq?=
 =?utf-8?B?aktocHdQUlc5OHJuWXRQWWZuTU1vdkRZZ0lLRmJ5THlnck94Mko0VWI3NDZp?=
 =?utf-8?B?L3ljY2R4YzZzcTNrMkppSnBhK01sMlNYeEJkc2VrQXJvbDRuMWt2cm1GRm1G?=
 =?utf-8?B?VUd0SzlBaU5qN2VmMlFMRkdnVzVKRTIxTGhmdjNaWTlWQVBIYXdnVWRVbHJ0?=
 =?utf-8?B?VUF6cUFkQnNVK3RsNlRvbmV4SHRHbkxBR0VMakJ1c0x2clo2VWVTaTlRNWhQ?=
 =?utf-8?B?Qm1ROWZ3N0FhUjZKd1RuWkVMNkkzQ0J1OGxjeHV3T09NZ292amo5WjMrNXpY?=
 =?utf-8?B?ZUJDYlEwWTh6aG9yY0MrTndmaDlLa2dWSTRuS0E4cGJDaitIbkVyaDNReDY5?=
 =?utf-8?B?b0VCWGg2d2ZlQU1JRUZFT0FyWGUvcXJNbTVTaXFxSXhBOVhZUEs2MnYwbHJ2?=
 =?utf-8?B?WVJwSktYbm9hMUxRRmdDajh6OUh1MmpZUjZhQjVDNmpVckFySytOVnlCRnA1?=
 =?utf-8?B?UFh6Zlh6RVBlN0R4L2EvRWdlcThCQlkreENNVjdjZVQ1c3d4OXUrclBwZllM?=
 =?utf-8?B?L0ltMk1GcGFmbzZ5RHpBaG1Gd0prdVZleENIQTduZ3ZxSk9ocHU3YVp3cm1D?=
 =?utf-8?B?U0RyQnJmczdQNTN3YVMzK1FaVmxpMktrZXdUTFQ0S2p0ZWVYWUxGTk00VkFa?=
 =?utf-8?B?R1dHMXBSWHdSWENTM2dlZkkzdS9QSVdVZm41Z2JqcEVJeHRrdTdOOTNSQmVi?=
 =?utf-8?B?bWNYWXBjbW1VSkxQS01MelBINFNhRm82WVpJNlpUQjRDeE82cnRGSHNUTGJW?=
 =?utf-8?B?TlhoRHYrUG1kMFh6RnI3dS9IemJtT084K25KQ0kvdXFqUU0zNjRoL1F4ZVEx?=
 =?utf-8?B?QXo4QVNsbUtIclFWY3JIcmFlYWZndnlCVlpVeGRHc3FHVmpnOGFZUUJCQkN1?=
 =?utf-8?B?bDZ4SmFwUWY5K09KVnliNm9qV2FnVzJWdHRRZVpuMHZqa3dxTGpRaXVJMzFs?=
 =?utf-8?B?RkhRUUx2bnplbU9vYjN6bFhPVFhnYWVNRDNBWm45OVFuRFFENmNnVDFKVU5j?=
 =?utf-8?B?eGpOTElnbSt2a3RMci80eW5YU3NBa3FpZ29HNzNRMWdBTFFyY0VGMU9YcXlV?=
 =?utf-8?B?NUkya1NsQ0xVNjZweVQzSDIrM1ZoK29GU2E5SzY0clcrMW8rQVpZRk9OMWpS?=
 =?utf-8?B?ZStjTEFxWmxUMEhKcm1xQTc3U2NNZEt1T2lIVGZ4RWlqbzcxMFNaQS9CdWRa?=
 =?utf-8?B?MzcyU3ErWTFpY0xLWG11K0RtN1NEQUh0Q3FsMkRRRmFMOHZZZW5DWTZWend0?=
 =?utf-8?B?SlJ5bjF5dGpETng5VGJ2WTlqUEdFQmxUOVVMRWZMRnBZSEdsbkxrNGNPcWJO?=
 =?utf-8?B?Unowc1NidTZVakdEaFc2cThjZnBJOXM3V09HZ3YxYlB4YXlTZjhaR1E1Qy9a?=
 =?utf-8?B?azlsM1Z3Ky9XNGtycFZhaG1aRWx2SXV2QVg0MFEzMXU4SkgzV0h1OU5MNkRN?=
 =?utf-8?B?cWlUb3hkZEFqdE1tb3ljbjFRa2FWeGJhMkFmbHNoU0tGTlZkNDZDM2tUQlNH?=
 =?utf-8?B?dFlDdmYvM241bTdCK2F1cDQwNGVRZVp1dGxlWVBUV00rQXFsS3Y0RHZzcW0r?=
 =?utf-8?Q?j34PMzEabFCuxsh0pdeDoV+UX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdb39a5-800b-440a-2033-08dda9c00d9c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:47:28.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqwcnX5+5AlS0n/w0qfd/sTSQ3cdEJSzwgsf3Srjg1duwjv+BQrP4I1H7HgMMylcx7v8o+JNfx2WTPMToiwTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964



On 12/06/2025 17:22, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 10:31:45 +0300 Mark Bloch wrote:
>>> I don't think this is a functional change? We don't treat silencing
>>> compiler warnings as fixes, not for sparse or W=1 warnings.  
>>
>> Well Eric's commit: d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb
>> that added this annotation was because of a syzbot report.
> 
> And your point is?

I just mean there's a reason for using annotations, and being
the odd one out feels off. I also wouldn't want anyone to
accidentally reference that logic (if they add HTB offloads support).

Will push via net-next.

Mark

