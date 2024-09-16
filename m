Return-Path: <linux-rdma+bounces-4958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA50979BE7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F31C228F5
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFF4F5FB;
	Mon, 16 Sep 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMWOJR8i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66A47781;
	Mon, 16 Sep 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471003; cv=fail; b=SjpfuO6emfVwLs50jxQ0qw8j+h4LGf2fhLFHrI1YfrsYh9KrBaQensnIDvOIOn//VP/rzekpOwYMgsABTUVE5iafzbAowUy7nx+XyZexaXEpSozK19+L6L+HvySkwx/W3MezFN6bUnt/cgPhyMkd8cxkGyvlq6YxsD2ig2s6XFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471003; c=relaxed/simple;
	bh=Fxn1bUBeEjMvIrdMrVTmTL4I7A9ZhLLA01sH/Yo2Gbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RIP4jEKaa+gdq5mcndbN6xmdLWUFPKijdi0+Hy607teeBpt2Ds0akfVgnqg7udvBnG4PLcUSMYh9spUZg+ENKRm1I+QfesIpIGrr4BUYq1NWZRzBzEgYzu0wTLUh7sEVAKTvK0GrzdHvcagJEeOwLomoyg9N4WPTGGbTMvjQ9Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMWOJR8i; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaWlIQY6RByD+3O/VFa6Wjtk9K0AYlvpmid8T7L1g8smajIYI1/IOXaQBd3xfm9yU3k6gP8sWqWe7bJQ3SYU2jut86VJFb5gWLyHcBUphPH9aCjuasmFUIPSfzVi9t4ooE5JZeaSdNlorawD+qN9xxk8wmiVG3tNOFFl7u9s3OIBRWJcPprHDttVRBnoD+dHB6l0hb1EepWkJ+DM+8O9DwrmX/XM4ys3tyY65AK5ZTNPT1SJpBcGSmmuxygxds+a8MSsCuByef+NUHmOYl8bwgIVvY+ZeQf9pvEcJHvDM6EKQt9hZ8ONBN/2SXyGFUoxivhF0Un3nLyGm4CCFEA+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy3RnI7yexZQmbc77FQ5SZ1ERCt3d1PXusmMYg8NN5c=;
 b=MbkTSlPvjoLMBLkj2Ss3/FzfD1b+qQk8c9Bys4XLd/iKY/LhDetVgOPFw4g22f02G2qC3IGZS4a4nWutxJX0epE3XEQ4IiSSp0YDCaiX4omy7dbi4YEpb/IeEwHbuCJRrUQ1pJiKYKgqG9jwb4YcGltIoIIQuWCkLfgZFuIRUJT+znjXjhuspBNGD2MZp/7UHXPhvifv1DcUnLVlvVsjU+UYagTNCykypVZCoIxYnZPrBFqoLeGp5DPTl3o96d4MKFcJfwWCTGozKH0AxVXeV7o1N8tJWcjXX3deIZ6JqJzJ4AAm94mJvUU6xgCdpaoWKO3kYyWXN5zXBbF/ZTQOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy3RnI7yexZQmbc77FQ5SZ1ERCt3d1PXusmMYg8NN5c=;
 b=AMWOJR8iQ/K3dfj53PdSLmP3gaYMQPp3XouBML/FfxgBpz7fsY1hnF/LX2+c/bxQhScZONQyoMYfrJFHGo0mUiJMM4j+vOZaBV6iysL4bnGpwhBiGqZOSuW/MVLQg4Cq9ouYPN5ji1epbKw3UuR0drTpyrG0t2k8hWEwI1D5Iydkrza1jI/hPB/B+a/CiVmeE9ycfUTuava6WAG/CB9Hhwo+eWiU/XvbMk8TCU/GSvq9NUuxClmfQwph9q0BUdbeaqZwVG8hIeIbx2mePFj4WxxM8sL8BpSO9XigY2M6G4sb1yGgCMhY2bdYdXtWNbDtmIv1FU5z1EfnTwBAv12RwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:16:38 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:16:37 +0000
Message-ID: <12092059-4212-44c5-9b13-dc7698933f76@nvidia.com>
Date: Mon, 16 Sep 2024 10:16:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
 Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::6) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1422b7-2478-48a4-ad3f-08dcd61f80d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z29vbm1rWWhSWm1NZDk3aitYQ0kvT3lwa3VDai8zU05yRWZvcWlOZEVIQUo2?=
 =?utf-8?B?VlRNSldVemdJVlcwSzFQenFLT01qOXg1RVlYOThDK3FSTVRhcmQyU2FmTUVR?=
 =?utf-8?B?b2craVVVNmZPOXNhcVlLZEtSYklLa1ByNVRkSWdPbFN0cVNrUGNFeHp5UzdT?=
 =?utf-8?B?aUc3OFdQZXZXSHBEQzNQcEkvYm1XK1RHZEE4L2kzVWVubkt4RDNhRVV4UE10?=
 =?utf-8?B?a3VsT3lYWm50a0wyNEZlMW5PK0o3Z3R4bVN5RHl3aVQ3QVFqRGVseDhFRVNp?=
 =?utf-8?B?ZjhoNll5VmFCU3lYQklObG9TUmx4cGViWGtmb3hSRGV2Zmgxamp2ODFyYVpF?=
 =?utf-8?B?V3VtcGd6TEdBbWtseXZwczZYWmZKVkk5YWNlbitWS2h2b0tkS2g2eU1mUXlx?=
 =?utf-8?B?QjMzeHpvanpDWGRhMXpSYVhlNUw3Y1I3dU9NZUVKQ290YUhJc0QwVkZPUHF0?=
 =?utf-8?B?Q0lyRVU1Mzd4YytRWFFrYzY4N0diSEpDNGh2ZFZIb2VhL1pSREdxcUltWlc3?=
 =?utf-8?B?ME1XdW5oTURxV1B4OFNndkh5bDdOa1FRWWgxejRXQzFLM01BQVpLVEI1WSty?=
 =?utf-8?B?NkRtU1Y4WTBjME56Q2tzNy96MTJYb1dFc1BhOG03cEV1N2pYTGtXdzBlUVdk?=
 =?utf-8?B?bUlmdjZLUDcrZ3pNL29uZVFMdUszbEhva2UrMVRTTk9iUFM4LzhweEo0MTdt?=
 =?utf-8?B?c3JJajdhRzJLbnFuTTFRYk9xK0Nad3NQb1FKK1pydXFMejBycjcvc3BtUVUw?=
 =?utf-8?B?cS8vSDRVaEx5dWhRQTB4QVc4SnBKVE5DeVh5ZCtaeWxFQXlPUWZSSjJUZnp5?=
 =?utf-8?B?SEZrR3g2OFAzSGIvUmZFT2djYmVQNkprdlBIVDdiN2hLVGYvK3dUL1hLUW5z?=
 =?utf-8?B?UVlqbS9NcWhaTjB6Y2JzWUJwRnBnbUxuelMxcDJKQ2g1NXBBUTlsc3JuM2NQ?=
 =?utf-8?B?VGluQW91Z0NPVDRKN3daMHlIanZFdGIwQ3YyZFNGeDRweGhOSE9vUnZ0NlAr?=
 =?utf-8?B?WnFFMkpSMFZKRFdQMFRKY28rL2I4dkp5clA3cU93MjRGS1pkdUFBamdQLzFy?=
 =?utf-8?B?VVRsbytUQUVVSUtzM3hoRHh5THZmSTFCTTFCRHpEOHQrWndxSk85RUdkSUk1?=
 =?utf-8?B?Rnp0TUllNzlhWkFJZG5tSW5DTW5TMkZ1T3MyOGhmT2Q4RmxlckU0Z3VVZXlo?=
 =?utf-8?B?ZWthNXpkWlhOZ0s2djFHVW9FTDJlSHNPc0JNV0tqamsyTHptaDlHTFkvVFps?=
 =?utf-8?B?MmpOOHZiMmRQamwwRzNLNlhNUkZBZERtQ3gzV0k5c05qV005VUY1d0hUaFUw?=
 =?utf-8?B?OTNVbFZybVFIYWZzQnI5d1N4WVdjNm5KckdiVkxyVjNlMjEzUHk1U2Nxbm1i?=
 =?utf-8?B?TElaRnY5bW1pd3c4OFFsZWI3d1Q1OVVLMkhreUl6R2xMK2thdm1vMVFuZDFp?=
 =?utf-8?B?Z3cyTTdJZ2xZc1ZOcU1TZEFJOFNhMVp4UGtMancvN29semxSWFR5NkVhdnBh?=
 =?utf-8?B?enA1Y1J1cXllMTN6aTJsTWE0UFJnVC85REVtK0YvTzhNTWN2M2dhRUJzejNs?=
 =?utf-8?B?ai9IbnMzWWhIdXZvRThZVi9hQzEwZXJWT0ZhVEVWZ0g3Nlprc01YQzhULzRw?=
 =?utf-8?B?amx5VVk4Z3ZhRlp4eGxEQyt0dVFSREFXWjVjbU1hZ1N2VWoyTWxOL2lRQVJh?=
 =?utf-8?B?eGJjNkJCdmpZMVhZWld6OWtZNUx3aDBzajJQM2wyK3BOaWVDZS90dWpjWHkz?=
 =?utf-8?B?Q2d0bmk5OGpZcTN4L1FVMWxHMEc0UVFYRjlseGtRZ2R3Mmd6SU9IVmJtZ3Jz?=
 =?utf-8?B?cDJaT1Rpc0hLcStiU3JER3VlTm9Yb21nVzk5WVdKankvV0srR3NnK2lyZG95?=
 =?utf-8?Q?pPBIIs5e1bnYx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHkwWCs4SnM5VlVRQUhNT2FuSGgwelFBNWdmSytaS0ZMdlZpY2duaWlTekRE?=
 =?utf-8?B?WDczT25ucDkvaU82NW5QOW1sV3hDRElLSmVLTForV3VrdEJGTVBxLzFkemRN?=
 =?utf-8?B?QU4ybytsMkduQXhFNVJ1YURnMFpuZG1ScUx0SXhlYld1ZWlCUnFMQVQ5Vlhp?=
 =?utf-8?B?Sis0UnZxRFd1RjN1WTVSaGVzQnpQSzhwdnVpbVlJY0wvMG12K1dQd0dhMWw0?=
 =?utf-8?B?V2ZNSnZxMTZrSHJoeTM1T05zZlprSFd6eGFCczY2Skw4QXF5T0xFZm9rREpJ?=
 =?utf-8?B?N3ZNekhDb1Nybk0zTXZCNVJtT3cwK0lpZ1hkNERiWU10WVF0M1JoeVhzV3N2?=
 =?utf-8?B?cE1zb2dmd2xKQkVRcVZCK1ZuaDVBaFpzQzYwcUNNVDVYTy8yTGpPVExRdCtQ?=
 =?utf-8?B?Y3J5UmFNQnduclpubFJ6MU1iUFNKTmRsU3hpZS95YnVnSVBhc2V6dGhnMiti?=
 =?utf-8?B?Zmd0L0VWNkEveVBvWS9LZHRtVkJMK21KQllqbzBTc3pZdGJpLzVIRzRTa3du?=
 =?utf-8?B?Zk5PajkrU3lGeXdNbDlSRy95V2ltQ01jMmU3Y0w0bUdYZlVqQTEyeWJxQjlo?=
 =?utf-8?B?UzRoK1A1QTJPRVRNQUJIdEdvT3N2RlYwVVZ5eCtpTm5nK2oxS2RjTWt3NlNX?=
 =?utf-8?B?blNIL0czWTZha0ViSVQxZVFHUDdyR2NyMmdpeFExTG9jVGt1MUhzUWFWZ0o5?=
 =?utf-8?B?SXpLMk5OeCtHb290V1hXam16MkpOSks1RTQzSmh0TTVSMVdqdEExSnpEVFNv?=
 =?utf-8?B?SGxyTUMzaENTekNzQ0xKdmVKQXQwcEFzYjlWendkVlR6LzlRRElMeUUrK2Rm?=
 =?utf-8?B?L2ZVTXZaVWtXOEpzTkcxd1dXUWdmbU1JeEtIVmlzSnZ3a3owSmVkQUNhRFQv?=
 =?utf-8?B?bkh5aTdyOW5UVm53eDMweWhCZmxXcU81c1FLdEVVMTd1VE9CWEtVZ0VPN21I?=
 =?utf-8?B?NEE3MFA1cWhZMWM0TWZIWWJ0aXFXTVR6SUF5Z2tZYnI3WXNEOFQ1TFc2Q25j?=
 =?utf-8?B?N3cycHRCQ2YzOXlIaVlkT3FnTVpIM0dHVlJTUXhGcDdlZnRyanE3Y3paWk0z?=
 =?utf-8?B?ekIzdW1JNGphb1BxUlZBUkpNb3czL0VwMWQzM0N4ZUdkRE1lMDgzNlVJTkVW?=
 =?utf-8?B?Tk9CdVdSVWpJeUljNytzSXVxTEZrQjg4MXJ0MCtBOVo4RG9iaWtPVXdHQmV0?=
 =?utf-8?B?WmFQem1WK3pEUjdOS1ZEMlZYR1RwNW5mWkZwYXdIdXlrelRmQVdqSldldzJT?=
 =?utf-8?B?SXEvYjhUQ1NYYUJnVDJBN2lpeVNyRFdWTHd3UUhpamxzbGg2djBSUFEzVXp0?=
 =?utf-8?B?QmtBeE16Mi9sdXFVV05Va0dQbytsU3VNUlcwRCtjblV0azlvMjc1TnhNV2Iv?=
 =?utf-8?B?Ymp6cSthRithZS9nNXNOVTlRY1A2dm40dnRQQ1paaC9HNC9ZS2x3cVVpUzBh?=
 =?utf-8?B?d3owTEhSR1BYVllGSEkvalFtanowMkJLbnJvWitIeUw5eGhPVDR6WnlCWEJC?=
 =?utf-8?B?K3NFeno1VHNjTnoxWDF1ZnRlaWV0VGdFNklYdXJBVDRYR2R3UEw2K05UcmNq?=
 =?utf-8?B?RUxSbXZITURBczRMLzhrYUU1YXZLTmlsc09RL1BFT2QxdEViVXN0MmtJTFBM?=
 =?utf-8?B?RUIyRXFZMlJzMkUwWmpmYzlqSVRnOEdHV08rKy9sMm5IZVkrVkM2cFZVUUdN?=
 =?utf-8?B?bHRWWjRXbkZYUGxsdWdIb2FXNXFocUlBaytFWlBrTjlwZ3hkL0huUnVwVXJD?=
 =?utf-8?B?ZjVEaVVLOXBXcXpsOFV5RmNvQ1U0WGxTbDFwK1pEZGl2ZWJDN1hsU0FTeTlk?=
 =?utf-8?B?TDBRUjR2ZDR5ODVxbmpUemdGNnhMNWs3S2QwemlQWlB1aEN6aWtUeU8rV3pw?=
 =?utf-8?B?Y1pDTGJ5aXN6K1EvN3k5eERpa1pCQnVSSzBJMC9UM243cU9ldHg1QTZvRnJk?=
 =?utf-8?B?NGdpZ0NJckRiZTd1UmRjendFK0VPSUp5WGV0MUIzUlNTYTJhb29ZV2VjNDlm?=
 =?utf-8?B?VnY2S3ZCMXpwNVY1Q0RDcUlSOUxZT04reWJlNDBXN3EvOU54MnZNWnpDK3NH?=
 =?utf-8?B?a1RGbnFScG9maC83TFQxdkMvNXhtRnBSR2dzQmVvNS9raFZmUFRVTzhQNEh5?=
 =?utf-8?Q?KFKQMR8yJ36H4fJBdNXwnecCZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1422b7-2478-48a4-ad3f-08dcd61f80d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 07:16:37.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHBbzaDTc2QcJWKBh5JTKZ4pUzrzOBGjA/XiCjGVZ/saQ+ag5R2lggVel0GwuACH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

Hi Krzysztof,

On 12/09/2024 9:38, Krzysztof Olędzki wrote:
> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
> 
> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
> as close as possible to each other.

Please split mlx4 and mlx5 changes to two patches.

> 
> Simplify the logic for selecting SFF_8436 vs SFF_8636.
> 
> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> ---
>  .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 33 ++++++++++---------
>  drivers/net/ethernet/mellanox/mlx4/port.c     |  9 ++---
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 28 +++++++++-------
>  .../net/ethernet/mellanox/mlx5/core/port.c    |  9 ++---
>  include/linux/mlx4/device.h                   |  7 ----
>  include/linux/mlx5/port.h                     |  8 -----
>  6 files changed, 44 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index cd17a3f4faf8..4c985d62af12 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -40,6 +40,7 @@
>  #include <net/ip.h>
>  #include <linux/bitmap.h>
>  #include <linux/mii.h>
> +#include <linux/sfp.h>
>  
>  #include "mlx4_en.h"
>  #include "en_port.h"
> @@ -2029,33 +2030,35 @@ static int mlx4_en_get_module_info(struct net_device *dev,
>  
>  	/* Read first 2 bytes to get Module & REV ID */
>  	ret = mlx4_get_module_info(mdev->dev, priv->port,
> -				   0/*offset*/, 2/*size*/, data);
> +				   0 /*offset*/, 2 /*size*/, data);

Why?

>  	if (ret < 2)
>  		return -EIO;
>  
> -	switch (data[0] /* identifier */) {
> -	case MLX4_MODULE_ID_QSFP:
> -		modinfo->type = ETH_MODULE_SFF_8436;
> +	/* data[0] = identifier byte */
> +	switch (data[0]) {
> +	case SFF8024_ID_QSFP_8438:
> +		modinfo->type       = ETH_MODULE_SFF_8436;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>  		break;
> -	case MLX4_MODULE_ID_QSFP_PLUS:
> -		if (data[1] >= 0x3) { /* revision id */
> -			modinfo->type = ETH_MODULE_SFF_8636;
> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
> -		} else {
> -			modinfo->type = ETH_MODULE_SFF_8436;
> +	case SFF8024_ID_QSFP_8436_8636:
> +		/* data[1] = revision id */
> +		if (data[1] < 0x3) {
> +			modinfo->type       = ETH_MODULE_SFF_8436;
>  			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
> +			break;
>  		}
> -		break;
> -	case MLX4_MODULE_ID_QSFP28:
> -		modinfo->type = ETH_MODULE_SFF_8636;
> +		fallthrough;
> +	case SFF8024_ID_QSFP28_8636:
> +		modinfo->type       = ETH_MODULE_SFF_8636;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>  		break;
> -	case MLX4_MODULE_ID_SFP:
> -		modinfo->type = ETH_MODULE_SFF_8472;
> +	case SFF8024_ID_SFP:
> +		modinfo->type       = ETH_MODULE_SFF_8472;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>  		break;
>  	default:
> +		netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
> +			   __func__, data[0]);

0x%x -> %#x.

>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index 4e43f4a7d246..6dbd505e7f30 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -34,6 +34,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
>  #include <linux/export.h>
> +#include <linux/sfp.h>
>  
>  #include <linux/mlx4/cmd.h>
>  
> @@ -2139,12 +2140,12 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
>  		return ret;
>  
>  	switch (module_id) {
> -	case MLX4_MODULE_ID_SFP:
> +	case SFF8024_ID_SFP:
>  		mlx4_sfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
>  		break;
> -	case MLX4_MODULE_ID_QSFP:
> -	case MLX4_MODULE_ID_QSFP_PLUS:
> -	case MLX4_MODULE_ID_QSFP28:
> +	case SFF8024_ID_QSFP_8438:
> +	case SFF8024_ID_QSFP_8436_8636:
> +	case SFF8024_ID_QSFP28_8636:
>  		mlx4_qsfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
>  		break;
>  	default:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 4d123dae912c..12a22e5c60ae 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -32,6 +32,7 @@
>  
>  #include <linux/dim.h>
>  #include <linux/ethtool_netlink.h>
> +#include <linux/sfp.h>
>  
>  #include "en.h"
>  #include "en/channels.h"
> @@ -1899,36 +1900,39 @@ static int mlx5e_get_module_info(struct net_device *netdev,
>  {
>  	struct mlx5e_priv *priv = netdev_priv(netdev);
>  	struct mlx5_core_dev *dev = priv->mdev;
> -	int size_read = 0;
> +	int ret;

Why did you rename this variable?

>  	u8 data[4] = {0};
>  
> -	size_read = mlx5_query_module_eeprom(dev, 0, 2, data);
> -	if (size_read < 2)
> +	/* Read first 2 bytes to get Module & REV ID */
> +	ret = mlx5_query_module_eeprom(dev,
> +				       0 /*offset*/, 2 /*size*/, data);
> +	if (ret < 2)

This whole hunk is not needed.

>  		return -EIO;
>  
>  	/* data[0] = identifier byte */
>  	switch (data[0]) {
> -	case MLX5_MODULE_ID_QSFP:
> +	case SFF8024_ID_QSFP_8438:
>  		modinfo->type       = ETH_MODULE_SFF_8436;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>  		break;
> -	case MLX5_MODULE_ID_QSFP_PLUS:
> -	case MLX5_MODULE_ID_QSFP28:
> +	case SFF8024_ID_QSFP_8436_8636:
>  		/* data[1] = revision id */
> -		if (data[0] == MLX5_MODULE_ID_QSFP28 || data[1] >= 0x3) {
> -			modinfo->type       = ETH_MODULE_SFF_8636;
> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
> -		} else {
> +		if (data[1] < 0x3) {
>  			modinfo->type       = ETH_MODULE_SFF_8436;
>  			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
> +			break;
>  		}
> +		fallthrough;
> +	case SFF8024_ID_QSFP28_8636:
> +		modinfo->type       = ETH_MODULE_SFF_8636;
> +		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>  		break;
> -	case MLX5_MODULE_ID_SFP:
> +	case SFF8024_ID_SFP:
>  		modinfo->type       = ETH_MODULE_SFF_8472;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>  		break;
>  	default:
> -		netdev_err(priv->netdev, "%s: cable type not recognized:0x%x\n",
> +		netdev_err(priv->netdev, "%s: cable type not recognized: 0x%x\n",

Unrelated to this patch, but OK.

