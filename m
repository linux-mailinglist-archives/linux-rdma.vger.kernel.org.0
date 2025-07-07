Return-Path: <linux-rdma+bounces-11919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF5AFAE97
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 10:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C384A0776
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5E28A726;
	Mon,  7 Jul 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iy0d6Er0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D7220F2C;
	Mon,  7 Jul 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876876; cv=fail; b=gT1GShKtVY65xAes6ngDFM3h/VFS6zukpcHm23+QeUKKBCwTu/lTNxKgG0Ae7uI5X8J0F3LXM5iGnnv1/iZtiM/7GdbA6ZI/K8vA95ZNtGOfVRS5Hh0cP8UNkTpnG74osJlJWvWgmiAN3fiKn1BG01Ne9TDftwvoAtDrld8J0mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876876; c=relaxed/simple;
	bh=QA0uXe2hN8aGBSY9oOwD5hLxDEo+gz/ya3mA5TdPZ/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MFGu34ctAI49V0oBNjHl4Y248/3LcwUXP+qkhkWVZFQx0jV2TEzeOGDd/wmREGj9hcgbBcv/0k4K0WqxE+VM/RJ87h+RxeOb25Y57a1cdoN3+PFaBhh1GWILiOaPSO0D9Z7KMaWXjsZ8b9m+4V3UYsfoCxAdrn0ctbUd5Anlg1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iy0d6Er0; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMB4fcAwXF+UbVWu7IkRGOMC3iVXmqKEdhvwVlvony3GbMsSAqwtxyeU2xIYfaQrln3pRqdqTUl5rwRKL3z8AgsfXO7jEWYGiE4TdU3nV4LlwO8F8eKAP0FCDI9vL67fyN6lIlF+I3dJza+iJAGCVYtqfKPXuPH1ZMiULtsT1REFa1yEiYPN5os2khu4TBYNcOIfdC6PUdC473mxO+RjBT8NRfxWjUYqSWu0ZHJxzHpAU+cnWDlTU3Wb5L66o6UUSv1O7wqg7uo7cB0T6XwbmKgGnBHJoz2LX08Gklpr5Z2YTi+cSJA5cTPMIjpGY8Mq1dJXqRxaARXUTbgLzXOE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7xRy3UBMR+x2w/DRveIdEZMoNoHS552HU75IAkVITQ=;
 b=ER+uMrk8vzFo2irltqwblm+FofZXGJRBUfL+dDG7xREGX/ke3hLT2KGpO0avytDGEG8jEyJasvnmQgq2cDFxdbDyXGRMyak/v0t9w2HeKPs88BtlYSUG/WzRROhqJDMYmb4Z0NkKa4XGAhLiGoT9m3twtDQAGNWA2S4PsSZa0BqgmmxXTQVSBszISUdFtuO/WXL32LAWuxPC3TSaihcXoYk3RPVcWKvNeK8XmEo+HfzqLtS75cpliFSyPfjFmVoMg+9kS3x9uhk66DxWytww6ObQFR2v8HbYWt9MsTOTRfwjqyUakhv56m6UOTUQcY/bG1Jqm+Gh4/SFZH6HLtGtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7xRy3UBMR+x2w/DRveIdEZMoNoHS552HU75IAkVITQ=;
 b=Iy0d6Er0AB5jYWCzNFYuxEoSqbfGV4i+iMBgNU4vwA9+Xc4jQhwq3CrDrk6oSAFUHJTe24UfPc2OT4DRILHXaU1VONyE73AI7KaPe47yA6QN5PHSy9H7jCXUkI+4LxzeKdFaey+bZmRW0+4fBgMFpgywcc/uMvGIkCwAm0L4UHmcpXOiqv/qQhHFKfHONtlY/fXkSEhooTLc7ZyBRooZni/Kv1U1KVbBRoa3dIDl00P32ipqBS8YWhIyj/v4q9AEszWVzt5n+xWmsw885noJlISHGexSmnfSwHxpMdOkQKwD0IQ77/QGcO03MJI1/g30pNxKC9S2uMy8SDtHlOMggA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 08:27:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8857.026; Mon, 7 Jul 2025
 08:27:49 +0000
Message-ID: <f8ba8303-0ad8-4c93-b296-2bd96e1982fe@nvidia.com>
Date: Mon, 7 Jul 2025 11:27:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5: Fix spelling mistake "disabliing" ->
 "disabling"
To: Colin Ian King <colin.i.king@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703102219.1248399-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250703102219.1248399-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 743c6664-2e6c-442b-aa33-08ddbd3028af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clRZY2l2T0FKeGtBRFlBUlJJTTV6c3JDbEtUTm9QVmFzbXdJV1hmZGNycDhG?=
 =?utf-8?B?UWsybHpNZGk1K2M5ckloSzJEVFpYV2ZUOGlVMjZ3eENwazZnU1d3dUF4WVRo?=
 =?utf-8?B?TktWS0RVWjFyUEdNaFd3LzVha0N6VndvMDd6WVE4VVg0b3dYbDdnV2pONytj?=
 =?utf-8?B?ckVkdDF2eVlldGNMeFlTZXJnTlhRaXVPSXczdmVseUEvaThaRi9EM2t1RFVV?=
 =?utf-8?B?U1RieGJsME9ZWDlraTdxQnF5bEVTQ2FtWU9KNzR2L0ZGKy9YT3BhUStxWEM4?=
 =?utf-8?B?VzZXS0doNWRDSWt5MGh1YVBVTXBOUFF1RTBKc1M1eUdGRVFKYm9DblJtanBw?=
 =?utf-8?B?TWovN09jS01FdmFVQTNMaTRsMysvTDFGZzdodEFxQ1M2Z3RoZEdtQjBOM1RI?=
 =?utf-8?B?WmJhUVBQUHV4RnJLeldtWDVneU1tNjkxMTlxUVJLWm1pMlN0K3hSbllDb2xQ?=
 =?utf-8?B?eHhrZFIzTnVuRk0xLzFYd0VwMEYzc0grOEhSeXMxSms1ZER5S2VXbmtSMXNK?=
 =?utf-8?B?MjNpbm9PN0FUSUF6ZWMwWE0ybzBySzU2MkdLekYrNEpTSXZzQjcwQXBoMDRD?=
 =?utf-8?B?djlTajN2OE5lN3BreHlOR2RaSEdCV0Z4V0hyN2d5N0hxRFpTMU1vYklNbFE4?=
 =?utf-8?B?RE5yeHVYZmp3aG5rRWs5OGhydjhVS1k4MTZEMHUrRFRsb1dBcm1ydVlDR2dV?=
 =?utf-8?B?Mjgwc3hVM0hCc1ZoU01YK3dNbnpPS0ZucG9uTHN3dzFjNFhORFd5UG54QzVW?=
 =?utf-8?B?akpQSTlNdGgwUHFGUS9lbE9CRzdVeXhEVElabUZDdVRUYjhaVSt3YWVwVjlB?=
 =?utf-8?B?bmNxYmt5TFlpTC85Nmd1WVRkN0U4bmIzWDV1Yk82ZmJnd1h1dVFCazNGWHh6?=
 =?utf-8?B?MGo5clVTODM5NmpJbk5CN1Q5a3dZMjVTOTNtTEF1TkJjREVaYVRDNmliek53?=
 =?utf-8?B?UVdDN083SnZzTWpjcEZzVWdjKzdPVmRWL0Rkc0lGelRvTTRINm9jcGJPZ1ph?=
 =?utf-8?B?ejRzZHhYWEt2dW5sY2VZVTBid2xMWEhGMjFMUGY5K0N0ZHBJWGNWVW9wMFVt?=
 =?utf-8?B?VGx2WURpejdrUDhSRkdEMWhuYXBNeERHTzRLMzk5dmMvT0kwc09nREpKdFNH?=
 =?utf-8?B?Z25TVU9wdHdxUFVwemVMM0twdmxHTE4zNTljdGh3OGowTzYxelRPWlRzRU9t?=
 =?utf-8?B?dWkwaGxNOXN2UG80T3huTC9RSGI4RkplTjF2NTJvYWk5cFd3ZmJteXU5dm41?=
 =?utf-8?B?Y2QzK1AxcEVPUUg5NzhHT2NKbVVmU01jKy9zR05LdEZCdkhERjVUU2JIWTVP?=
 =?utf-8?B?SkozcVU2Z2JvOVl1TEhuRmwwVitoVzl0OXQ5dmVYVVhKOHNRRFlVc1dkcTRQ?=
 =?utf-8?B?OFozSXVtMzRLbzhSSFRka2ZWTDE4cGtFZDdkT3g1ajVnYUFnMUloTTlJRHNt?=
 =?utf-8?B?SytkZzlhRmY0Qi9WSlZtWUhBUWZjaEh4U1lkdFlNcy9CUnRHUk8xSjg5RGlP?=
 =?utf-8?B?eEt2anU5UFQyamhJSWZURDloZHZROERwSGc5YisvWXFYQ01GYTN1eUxnTnE3?=
 =?utf-8?B?alFubUs1aytDMTg5VDVJMGt4UmFLdEp1V2kyeWNMUlBuVzQ3LzczYVJsTWFR?=
 =?utf-8?B?dG9lVm1RQmEwbXZpMTdxMC9ZakErUHJaWFlyWmljTGtFWWVQVEJXRnVkRE9M?=
 =?utf-8?B?UFdLK0l1ZGlQVDAzNEJBY0poVGNUWXppcnRzT3oxVXpRLzE0MGExMzAzbE9Q?=
 =?utf-8?B?S1k0OWJ2QVBQUTdpaVdLYXF3K3didkhBWFBYcUxXYUpBK3ZzbS9Sa2l2cHNq?=
 =?utf-8?B?VzY4cHVpTXhIeEtuRDNRUnlrZkdmb0wvT0NrWHRWTlMvSk4rbk1wdVlRZllZ?=
 =?utf-8?B?aUp3SjREL2IxUnVEZVFsaWxST0hzbGJwUEVwT1ZvS2VPT3RjdElPdnM4WDRT?=
 =?utf-8?B?anFJaTI5azdrTy84WlZtNndkYnlQNHF0NThpbGFmR3k2VFJ4dU14WWpPMnlk?=
 =?utf-8?B?cnRXaWNzeUtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEhDdXU3K3hhOFZZVzJrbzRudkNuOE00b1BncGd2dE5vcGZOTW1rQXFmL01t?=
 =?utf-8?B?WTY3eXhjOWkwTVFCMmFzc0tYMEJuZ0VrTlhkUHYvUklJaXRrWXJOMTBMM2o1?=
 =?utf-8?B?d0tMS3J1a0hMT1JZckx4SENqSkxrbGsvUDRPZzFDZzlkSU5tWjhKQkxXWGJ5?=
 =?utf-8?B?a1NWVVZBQWd5MGZYLzB6MmFDNVh1YVdXemlPdXJLc2JlK3hLaGQwT2dzUlpi?=
 =?utf-8?B?eEFzYXJFVDUydGtnbFJTMUFWdm5kRFh6T01qNGJ5SEVoQ1NlTk9jVnNLQzQ5?=
 =?utf-8?B?MGdFYkJZS1dlSmlaZENwZkhXaWIySFRIcXFqRCt6VkU1NFAyWGxpaEozd2dk?=
 =?utf-8?B?Rng1eG96Y3NZNm5sMDRVTEFMM3kyektPWUtEaUlmYUZORXFKWHRweDl4NzdV?=
 =?utf-8?B?U1pMNUlpTjByRTVhNEZBRjExUmVHbzkvbDdCUkZqSTNUTE5jV3VLdWp0UW1T?=
 =?utf-8?B?SHE4cTUwR2h3Z2dISG8wcHFDaUFhRlpVRTZOOUxhVnBOTUFSZmErOHNFamtC?=
 =?utf-8?B?Y2dsOTFMOHM0a2JaZ0RCRHpwam5HazBTdnFJZW5UL3ZScjFCRE5wZFlQWjEw?=
 =?utf-8?B?c1FIMnJMQ2JWQ2pqK1BXVjVaT3BJT1BiOVN1YzZIYzU0Mk1iOElzQzY3QjhO?=
 =?utf-8?B?STVOSmRQZmMycnlGS0hFdSt6VWhmQklxMmFRZzZBdThSd29VbElUMXpKaHUz?=
 =?utf-8?B?UGFkTFo1cXNqbnhRQ3UxZzBxbDNRQ0IvODlTOWd0MURrSk9pMmdqcDk0djYr?=
 =?utf-8?B?OHMwSmVXRVJHOXRVSURNTGRTUERWNXJKRHBqU0FhNGRoQUYzQTBSUkVaOWRX?=
 =?utf-8?B?MUZKNkp2WTE0OVdJQ0xOMFQvUGdYdHNPUTFKMyt0YXpTeXpHT3dvbGwxZTVz?=
 =?utf-8?B?V3duQUtsM2RBWlhEcVJlWENrQXUxZi9yMTh4UytCTEZFREowdE9BRno1M3dS?=
 =?utf-8?B?bENMME12am8zSnhYWExlL1cwKzBGb0xnaVNqYm5Sbks1eWtOYkdKZ1pGVWpi?=
 =?utf-8?B?RjVLV2VuUEw4NVVhRXJyVDJDT1JCNzFkS0dVMkFQVzhLSjJTMG9MTWh3bzN0?=
 =?utf-8?B?UjUvWTlsVjZzeU5saE5hL0R3M1FmRHI5bDNvaXhkSktyZFRlQm5pVnpWdXJY?=
 =?utf-8?B?SHdCZ3Z2VzZNMnRKYUo5V1BwVzNyVGRXQ2xLVUJ6cncwVXk3aHpNLzV5b3k4?=
 =?utf-8?B?amw0MU5oL1hUQ1lDb1pmbFNoWU1iU2U0UTZwM1dFWlRFdEJCTnVBMExtR2Zy?=
 =?utf-8?B?RmlGOHZlM3kyUWxYNWJSTWxzajJmc2R1ZEVTc2h3NXZoa2krWmZlaWpaRmQw?=
 =?utf-8?B?amxYZkEybDdyangyWmZ0cU9lU1BDRUZ1WHU5UGs5M05BT1d5UlBGa0tWbDZC?=
 =?utf-8?B?Q3U1bE9VNTJOUW04bEphcFkxK01iVHlGbjg1YkdLK0Q4enNNdzAxaUpJTXc2?=
 =?utf-8?B?WkljRTFZUVN5M0lTVTNnNUltZmkwY1lKeVorRVRPZjZpOVlyQndrSkNmV0dW?=
 =?utf-8?B?MHhLRU9xTjBPVHBkUmI5Vk1qZ0NtS2FGM080bGhrYlg4UThLUXVJZU8yS09v?=
 =?utf-8?B?cHNzKy85ZWNBYW9EdzcvVmZxMnhKQ3VQS24rVlE2RWxwR1oxMklSRGJMWitl?=
 =?utf-8?B?ZTVsS0JoSmxlT0FlS2UzclFXNUZJdXVkczNoMW5aYVdaZjFMVWpZSWRnMXdp?=
 =?utf-8?B?TUJlaG9zV1g3UWZQOWNHNWRqVjBEa0U0T3Q3MUdVcEtPa0YreExhMVpPemZB?=
 =?utf-8?B?ZUlEbWJaR2RiTVY5ckUwcWF1SnkySitObkd5a21qNkxYRVRoZ2ZVVU1JaHJi?=
 =?utf-8?B?NWNVck5BTEJJK0JFZ0xuRzFHSUhMK0VYNC9ITlRUQ2xjbXY0NWJmdVRQaDBC?=
 =?utf-8?B?OWFtL1lVQnU3UXRXeVVpelhSL2dCVitidEFXdXNpdEJkZVNGV0UwU3plM3A3?=
 =?utf-8?B?L0ppNDljcTRua1NpbnhGYWVYOEN5QktqM3pmMWpKaGhCYlM4Qi9uQ2VSNVUy?=
 =?utf-8?B?RnQ5ZHJlaWVBcmpOUk9VTGlUNHVFV0ZKNDJlREdORm95M0FyV2ZRTXBZd0gw?=
 =?utf-8?B?MlJsaHRvUHRMenRqZDNVNG90WmozQk12eTlHWFQzaXp1ZEpIL0ZvS1JHWXZy?=
 =?utf-8?Q?aZXSqk63KHMI1PfWheZBV6gue?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743c6664-2e6c-442b-aa33-08ddbd3028af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:27:49.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+u50+zHXvnvZmpMGXjh0g/nxSCBQX1PwWr8KpDTOr+Eyd9J54FW1jItREGx7K1fMYjrbHt11OgzV1F+bSCbVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463



On 03/07/2025 13:22, Colin Ian King wrote:
> There is a spelling mistake in a NL_SET_ERR_MSG_MOD message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> index 154bbb17ec0e..7ca6bba24001 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -1353,7 +1353,7 @@ static int esw_qos_switch_tc_arbiter_node_to_vports(
>  					     &node->ix);
>  	if (err) {
>  		NL_SET_ERR_MSG_MOD(extack,
> -				   "Failed to create scheduling element for vports node when disabliing vports TC QoS");
> +				   "Failed to create scheduling element for vports node when disabling vports TC QoS");
>  		return err;
>  	}
>  

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Thanks for the fix.


