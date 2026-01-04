Return-Path: <linux-rdma+bounces-15283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37360CF0C36
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 825593014A2A
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337E26F29B;
	Sun,  4 Jan 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqJBUiY3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF7254B18;
	Sun,  4 Jan 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767515949; cv=fail; b=fWY/H6r6yr3qJVZ4AqzHUD/wqQLDxHatdEMtrTXslfKj/CxdCZ1Vv1pBBs6l6WXwlms3aDRwaW7Ia96pjSsUKsEl62+JLa9uD5HHU7IMQymi18MD9bPkr9bkU/vHbxDUniVI8PcCp8KH+XBCQrp5SNtAWzESva3pVyC8c42KqnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767515949; c=relaxed/simple;
	bh=GTNfRlEVDNuU+BCoJB1Ig2t51SQHghtA9hJkE5WjzuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYP1AWPSnzp4wVYMwyYej2SEGiSPMZtsImvv4VQkMkHc1NFc7/erZ8bc55D0fPRlyoKQz64lkUuckAj2TgDsRV+BcZWl9m/DJYU2zmis115Oc1CrUCPQ1Nq+TfWtw8DwGfdPQMirpyCbDs2lgIOUShK1myuCDKQgxgu8AZL5p8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqJBUiY3; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bms0lpkt7dJKGG9P/5SobNlwVEI+Xs9GuL7JED8YvrGpAkSMEJ/djxOdYrLClWwfI68Ro5pK6vymN217FXW5NonZKsq2+Fslua7fkUtRoT4t/ZPIsLXpJvv1v713xlR26MnPE0GxQA/Om50xSRYhzgxO6ejwO4/POImDGoQrWsIT0H8yGBbjNVd7pYTpATR841yeJ2Vn/1rJ9BY7N4p33w6OD+rUONMpJcXMgZi6HgvhiAlVzHU/lCLwzfsn0mayLkjgWmIZCiKMcbyAFKVSNx0kPOiFwyIcZjFw7qp/XD745qdn5iiCJzLXJv/hoR7qgrAyOYmrKbGyvust4WnAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1AqaI7BNQiON5jMUWeSvruWo36MWHuF7QbFDSJVUWg=;
 b=DTTcRQR8ney71/U2v0yXeiE84noDCZQz8V3pLaVdyPHqj5+cqQf+12TAfdMbeCS410kE84bCFcXe2mAFap6LNlc6UvUU3ImkAsfO5JVHS/Ww6T/uwLbCoWYSPl0ItoCnpFIuOxnkmnqCMO4YxKfYi3/Bh887UkKHdAU63WGWGLNgK7/F+qQGlKfg+4Xbx8T12QUZbtsLBFuM8joQouk7ozxXXoL6ius8lkhVRF7ltDoPiQFDmZL1zEjp6+2YjbE6ilfDnEHyFleJ4a+nWmZzthPOg59RqitXUeHYN+GQiFkkIU2U/KhUKqaKkOphCdrev22ilcaZw+RFDz/epdxemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1AqaI7BNQiON5jMUWeSvruWo36MWHuF7QbFDSJVUWg=;
 b=UqJBUiY3nvx/1WhTtxfefHcPJyLLEabtwWUbh99/Rvyjg1wkPwo0g05C2tm09jnXpmcKLq/G+kgGjBptROiQuUmIEw6KCGIgsEjk4MCIi8pUD9vR7LlDF/xZdw3cYAmuNeU4xqUcQoLheCwS/sVk4sfBLYJvspVwHXinUNEwRcK6tSF7nQU21uh2wAbT3Lo4VHLbvfeFv7nndvRBAi6o1AJYtbOiwq26bZr1Ji8YJlUmVzJbSMJ5fCjHZut3NHEEOkU/01GvnRtICaOPuZHleo9ORewj05g+HeHd6KT5GtTKGkfbBg829PL5SgfOzCXGzVV6JXhH/Ue1FxyWYm5uXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 08:39:05 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 08:39:04 +0000
Message-ID: <834c29e3-d2c4-48bc-a2e7-4f80209a3328@nvidia.com>
Date: Sun, 4 Jan 2026 10:39:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: Introduce
 netif_xmit_time_out_duration() helper
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jian Shen <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
 <1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
 <20251127173437.479d27fa@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20251127173437.479d27fa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7f08ef-4ee2-4769-4302-08de4b6cb7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW5HbnZxWW0raVRpV3N3NFdJSm9qTGNLZUt1MEkzQXhadGpFT2hLdlFSUWtn?=
 =?utf-8?B?Y2o4aGQyV2FZamNSeU1OdXJwWnc0cEFzYzB4MENPbDVCaUNTNnlWV3h3LzVH?=
 =?utf-8?B?VzdRQkdSb1pkaDlQeFh5TE8vOWRjVzdDRTlGVDNVR01GdHVJR2NHUmVoTFFL?=
 =?utf-8?B?VSsyalhqRDRYZ1VnTlU0WlUvRXU3U2d4VFUwSEpoN3NqdkYxdXFpU1JVL1JX?=
 =?utf-8?B?Y2FhN3AyTjI5ZU9KdjhqS3FyR2lUM29EZkZRKzlZVVBHY0s5YjljV1ViV3Rw?=
 =?utf-8?B?NjV2NnJNeStTckJYTUV4cGs2aHRyZnU2ckh6aXVrbjEzYk9nNjJyZ0cwUkJW?=
 =?utf-8?B?c0JaYnMyNmNZTTM0ZXpETWU5Z1dhR0VnbDNtZmcydzNrMjdCV1JpUTEyUUNm?=
 =?utf-8?B?Y1V3clRxWUl3NExXY3Y4eHBGVE5BTW1RR1pPY0hINHl0VnRrdnJvYVhpaFUr?=
 =?utf-8?B?Nkw3VXRqL0hRdk5sLzRmU0x6MUVOaDNIY2tOYW9zaTdnQ1lPa3B1bmQvaWs4?=
 =?utf-8?B?WUxmKytFREhpcHhBU1VjcytNTWtDU1JlVW9RSS8wMHY2MnpFT1FBY2htOGQr?=
 =?utf-8?B?WU9oYlcwaVAxOTZDb2FUTzhLMjByT3pua0h2Ymk2MmtFZ2NmdVZBbW9iRTJC?=
 =?utf-8?B?VktrQURZSVpQZ2x1ZjFLbjlvYnIwY29sRS95ekdiMDEvR0JvQVFZY0JDY01y?=
 =?utf-8?B?aThGa3NKMS9ZTVVPTE5QNGNwdnNnUmxYTk0wd2JmUit4THM4QXlRT0xoZWRa?=
 =?utf-8?B?SEswcUVUSVRiWUttbDlWL0lzY1dGb1JFcTlpczg1UmtkS1pjZ0NRd3EzVmxZ?=
 =?utf-8?B?cE5EenQ3SGNkRDZGQjVnWHNJbHZVcWhoSy9RdDVSNVFqL0FvM1haR0N2TnRT?=
 =?utf-8?B?b0ErTXJWaWxMaUttczhDUmlENXZ5K3N1eGMveXRrTGtNZm5iVUI3cUExZ3gz?=
 =?utf-8?B?WmxwSjJpMlZ1ZkN0ZDFvSnVNWFR4Ulc3VDc2TmxaQ1VrU0p1Q1pid004ejdp?=
 =?utf-8?B?dk1id3drYnhEUFRJNFc0QlZ3cnFpUWpyYnloYi96QnJuSTBGaC9lb3RXaVRV?=
 =?utf-8?B?SWpWK1M0eEo0ckMwNG5URGFqWnBJcmFEa1EyZUx2eGFNTUV3TEZ1c3o4Qm5a?=
 =?utf-8?B?RThEOUo4dWMvbG12a3ZpdkpTNm5rZWhBWXFJdjRlQWJUdEVsMTZTQ1Y3S0xM?=
 =?utf-8?B?UjJoQzI3L3hPTjZIcFFOQm1Na0c5dW5BYzFrc1R0R1JZUFc1QzEwTUVPa3Fl?=
 =?utf-8?B?U3pRcnZUbUtZcjVCS1h3Wk5BR1NMblMwNElSVy8zTUs1Z1JkdElkWjlzcnVk?=
 =?utf-8?B?TmF3SVBYVUlXdVdZTkRpMEl2RGdveWdCejdnanp3enJpYlNTbzQwcTRGdnpB?=
 =?utf-8?B?UHNuMGt4SDlXUXprOWNWOUw0RE5WeXlZa2ZKenRaS3YxTVVjelY2SUdYRTVK?=
 =?utf-8?B?bkdPZUNlemp0Wm5EeUppakpFaTdOdXRFcS9XS2lPYy85YWdIZHp2UlZQeXd6?=
 =?utf-8?B?MTZFQThhbE82OFZUTUVldFIwL0lHd0ZzdUJ0K0NSY1RLSjAwZ3diYXpFN0FC?=
 =?utf-8?B?N0M0bUQwdDZlaDRIZVlMeVFnSUxmTzNoS1E5dnBzZzFTV1Jjbk5yNVhXTFNM?=
 =?utf-8?B?VnNvQ2l2YVROWXZJUmo3TTFjVkxaSkovZnAyQzdybllGZFNveUtFbU9URkF1?=
 =?utf-8?B?RnF2ZVh1SXZEaXhlQ0lCbDlXQnA3bm9ZaW9XRHljb25MaVpmZE1hZzkwYUJI?=
 =?utf-8?B?MlJzNzIyeFhXUm9zWDd5UmlvRWQ4eEhVdWZkM3Y4aEtFTHZlWms2OVNDWGFV?=
 =?utf-8?B?SEk0SW4vNGFVSzlFRjc5SGRsM25OOGl6alU4RVpBR285aytWRXYwa0ZQVFVS?=
 =?utf-8?B?NVlqdFJxNTNjNTZteHowTGtZTHQ5Z1hjQ0FJdVoxWFJKUEFWWXM1ckJGUmE1?=
 =?utf-8?Q?QdVvTNLgXJo50h6xn/qT5HlH6P3VUUTX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODRyYWRpMDJiKzFscnd0R1FTdGhFWkc3UDlCT0VZb1hubituODdsT3dENW0w?=
 =?utf-8?B?ckZWRmRHa3cwWWZWUlovRHcvOGozSzZ2QXRlQ1pLMGFPSkMveHdIREx6QW93?=
 =?utf-8?B?SytRb2RtM1RlUjJVSnZIUDhQMHFNUXhWL2t5YW8vdjFiQTZkbVVmTVFWenVW?=
 =?utf-8?B?VTZtZFVVQjBTaHlsajdVNE4rTS92b1FRam5uZjJaaVFHV3o4SXhxSXk5ekdl?=
 =?utf-8?B?SmNRaEhnTkZ1UE5uSzl3K2lvaUN4cDRiUkhZSlRuYTdqVXEyL0pHVkJxRE5N?=
 =?utf-8?B?Y3M2eWw2Mld1cm5Cb2Znai9iaWFWVW5laVkzWG1zM3QwTDd4SXd6dlEzWjdo?=
 =?utf-8?B?cHBiZmJlU3JWTzNYcVkrY1lxT2wvb1JKbkpRb1lOWlV3SzlwelFNRk5KMFBq?=
 =?utf-8?B?MXFLZ0poNXFvN09DVnBkRVNCbGtuQnEyeE5rZ3doUXoyVjUvaE5vRVlkMGRP?=
 =?utf-8?B?aEVIQTdsdEtkNFhiWjJESFY1eHVKVlBwNUZsZlJyYk1qVVdyaTF0M1VUT2dD?=
 =?utf-8?B?bG5GbXBMZSs3OEx3TWhPaFNPc0lGVzVMd0E2N0kvOGw1S3kzeUs1Slg1QUll?=
 =?utf-8?B?bG9BYjVtMFA4VGZVWDJXSDJYbmxHdlcrWGp6T2V5S0tvNFJhODFaOWxzV002?=
 =?utf-8?B?cFE4Rk15RVRrWktaNStkSEN0NVU4VjBWellySmorUlpIc1FyQmZSL1ZEcHJ1?=
 =?utf-8?B?bDduQjk1Z3hXTkI3SGE5OUJlRWZ5Q1daTmJZVEZ1Rlp4OGtvc1JRWUczL1F4?=
 =?utf-8?B?djB2VEptM3BKUGVmaitESzc5OWlyUElpUTlxeGFEUGNRcjBISXRCc2QvVVdX?=
 =?utf-8?B?ODNEM2s1VTEzMnJZMysvYmRrbjkydVhLbGJTMjlnZTNHZ1hrOXNESnhpL3dj?=
 =?utf-8?B?TUlxejFOTzBHQ050NWZ3Ry81WlcvblV1aWkxMk5jb3k2bXJRbWVGcFVnQ2Iv?=
 =?utf-8?B?b2pRZkFncElVNlZJSCtrT1ptc0krSStiWmFXZWRNMVp5YzVQU2lZZkFLMWNE?=
 =?utf-8?B?ZzhOZGt2aHRYVHJnNnltZEFuZGVJZXZMOHdQVVRFNHJPS1BKdGlwS2wweEIr?=
 =?utf-8?B?NmhpT250QmVVMSswNXhPZHlBQlFSb3dkTVh2RURlWkJaczlTQm9pRnlYNTVy?=
 =?utf-8?B?RVQ4ZytVelN0T09EMFZWRW1IWWs1dWRpazRHdkNJN1B2SUpwZ21DSVBXYXZ2?=
 =?utf-8?B?SGU2K0Y3QVlRUGwvZVI1c2x3UGd3enNqaFd6ZHZ2cE54Uk95eUkrelltQ1pn?=
 =?utf-8?B?SVJTMkp6dHFIWGs4MU8wYlE5dkxrTTN5cExWSnFGR2ZUeXUzR29STloyVk9Y?=
 =?utf-8?B?bnpwVXNPZ2docU1HUkJock9oVTg3Y2FTNHF1b3YzRzNqa2w0UVVtL2VTVE56?=
 =?utf-8?B?T2lTUU5POGJUbWRhN2FHcGltM3dSTjB0L1B6ZU5sL29WWnJWMmZuK0h2M2Ru?=
 =?utf-8?B?SzF2QjJ6WU9ubmlYdVFLR21rZFdjQjVXN3JQcEdkdWxpTElmY3BYOWZUT3Nt?=
 =?utf-8?B?SjA3bUdaS1VaYTd6R2c4VjZXOVZnV1d5dG04UExiaE5QdEFIM1B4OCs3Z214?=
 =?utf-8?B?enE0cGFpVHBWV3FWOEMyRVpXbmR1eURWbDE4dUpKYnBqc1dIUGRkdEJZbCtv?=
 =?utf-8?B?bnZaTjlxaEJHUURwYWgxM3pDeGpBYUliN2xKcXFhOFdzdWV0SWN1VVpCb2tn?=
 =?utf-8?B?elVlYmpxV0VwNWNrdmV1WE91NTFPNklaMXFsbWxNcVdYeCtJT05Dbm0wMDRS?=
 =?utf-8?B?a2dSMzNLbi9peW1FSkZlWjlYVnpXS1VtRGFKRFY5cVF0ZWc3ZkhRV1ZkbDI3?=
 =?utf-8?B?VnNKMnEvTnhKQlN4V0toUnN1Q3pTaEwyMk14RkdvY1NGR1JzVnNzSlZkeGg5?=
 =?utf-8?B?dGdnRnp3Wk40cVliSGdZVUM4Yno5cWtHWVhMRVJmOXord1EwQ3JmbjdNdEw0?=
 =?utf-8?B?L0Z4OFg3ZU10UmN5dG5OVTlsYnZuQW9kYkx1WHZKamRjZEh6TGIweEFhdlFt?=
 =?utf-8?B?WHVIVSt2VDJ1dFFLRWhjMXNla3hneWxMTVlBMDdCZjdONEI4R0R0aEZlNm1D?=
 =?utf-8?B?eVh1Ry9yTk8yd1FjNVA1VXI0Ny8rSGFvOCt5Q1oyMUQ3UFdrTFhqcWY4MWN6?=
 =?utf-8?B?b1dDQ0xvSFJPMDltbmN4UGlmMm5rWlIzaWVBZ1cvc01nM244Q1Qzck1jeU5Q?=
 =?utf-8?B?MG5NRFhQbUZTVmdnTWp6TnlkRG01ellIM3ZKTEEwdE13Y2hpYU1aUVVCVmUw?=
 =?utf-8?B?bVJhUWU5N1RvK3FZSWdwSVE1YVE3OGo5TG9HbmV6WTNuRVhFTDFEemhaYXBn?=
 =?utf-8?B?VkpkRGsyK0pzSWllOHFZQWMrUFAwOXY0Qjgwa0ZVejE3MWg1TlB0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7f08ef-4ee2-4769-4302-08de4b6cb7da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 08:39:04.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LojHKfDqVK/RHX6oH9OY6qkGV1xbfdk5letTtgLIR/gOjMUuMBY0LTT/YdBfIG5bIN3og6fBJ2XaFZsgFk68zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533



On 28/11/2025 3:34, Jakub Kicinski wrote:
> On Tue, 25 Nov 2025 09:12:54 +0200 Tariq Toukan wrote:
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index e808071dbb7d..3cd73769fcfa 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
> 
> include/net/net_queue.h seems like a better place for new code
I don't see this header, even in older kernels.
> 
>> @@ -3680,6 +3680,21 @@ static inline bool netif_xmit_stopped(const struct netdev_queue *dev_queue)
>>  	return dev_queue->state & QUEUE_STATE_ANY_XOFF;
>>  }
>>  
>> +static inline unsigned int
>> +netif_xmit_timeout_ms(struct netdev_queue *txq, unsigned long *trans_start)
>> +{
>> +	unsigned long txq_trans_start = READ_ONCE(txq->trans_start);
>> +
>> +	if (trans_start)
>> +		*trans_start = txq_trans_start;
> 
> The drivers don't really care about this, AFAICT hns3 uses this
> to calculate the stall length (return value of this func.
ok
> 
>> +	if (netif_xmit_stopped(txq) &&
>> +	    time_after(jiffies, txq_trans_start + txq->dev->watchdog_timeo))
>> +		return jiffies_to_msecs(jiffies - txq_trans_start);
>> +
>> +	return 0;
>> +}
>> +
>>  static inline bool
>>  netif_xmit_frozen_or_stopped(const struct netdev_queue *dev_queue)
>>  {
>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> index 852e603c1755..aa6192781a24 100644
>> --- a/net/sched/sch_generic.c
>> +++ b/net/sched/sch_generic.c
>> @@ -523,10 +523,9 @@ static void dev_watchdog(struct timer_list *t)
>>  				 * netdev_tx_sent_queue() and netif_tx_stop_queue().
>>  				 */
>>  				smp_mb();
>> -				trans_start = READ_ONCE(txq->trans_start);
>> -
>> -				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
>> -					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
>> +				timedout_ms = netif_xmit_timeout_ms(txq,
>> +								    &trans_start);
>> +				if (timedout_ms) {
> 
> The use of the new helper in the core feels a bit forced, I'd leave 
> the core as is. Otherwise you need the awkward output param, and
> core now duplicates the netif_xmit_stopped(txq) check
ok
> 
>>  					atomic_long_inc(&txq->trans_timeout);
>>  					break;
>>  				}


