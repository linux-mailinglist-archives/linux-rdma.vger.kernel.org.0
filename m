Return-Path: <linux-rdma+bounces-12502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE6B138EB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27C417355C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE65253F1B;
	Mon, 28 Jul 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xHsFWgia"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147B221FD8;
	Mon, 28 Jul 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698346; cv=fail; b=rciFtJtaoTddusMyRij2jfVh3vg6WrSOY+XM51X2LJLDZ3osO9YniRYmqQ2HVVTrMgHWifWz6WcSUVxFmNQCdX63IrtZeLXM46yTAomvGqOqYII9W5UX2DCslnQQp/bo4rsyB/8bDi82fYMiE1yMY5c7GLqumSqZVNpshcvZHbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698346; c=relaxed/simple;
	bh=psL+C4+tGutF2pEq4d4zVILqP+p6GmgfAq5ihXnK6/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JpvngOoQvQKbEwSH0OU7lxVEoZ7CpskVykw82HdCP7XS1P8kIvyt/iP+KUxrM+6Q7vgmaDoYztoWERU+YfeguvuHj28olk+pD7gS/awBoHJEaNc2wNnm7u1+OizMywafrK6wLjp5KpImZTAHpUsEamAyCoHf3K4h8qG37EdNrjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xHsFWgia; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKlXandfDCsWH8/9RfNV1pHmQjAosvTy754JfxHVddytRMAjz/LkCucQ/WwOxB38wwzAxFk+6/J5kIUTZx9mq0Jn1pgz+kftTBGfEMjVJpomqW3m5Rq+QLay8+b3uRVIL+k7eZmkkGoEJObJBRbEf9oH71Z8bKNvyrSLW4e4hm708QG890gTrgej1vnEow8Ocf+U8G1brV8dubXRBxYYmgqwDjIa//ZVdDhmqK6pzk8nO4St6L4n4fHZbSkazrv6RAK0TFIF440QjiTNCqrfzSoejAchm3htvu5PsnJSCYJC0rtKnDN8T4tR/NphdI3eSaevy/qcTDnxLU+T1WMcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdRL5VS/PXSZCa+ZX9K3M4/t7Y+lv+pSVT5ngJluxfQ=;
 b=FlSu6iO6Bn7iZ6tZJ52UprwcswhmjLnupM5BzzfhXqYD+/8CSJnFekrVFyYucYpEFgT4JObrIxgy2awC/AZVBMu3VomQxJMub18RVyTlwQXuSwpGDylIQ/LgzgB/daaI3PClLT0tEqG54HLituHflUrjzolqULa9XYJ7pSv7mR1+dwi5auik37Qz4tXIjiGSPvBkWXhlLWShzmTVt8o411cWNTnk9WKS9thTzo7mDr7d+3bTLtQrkzGUN6CBb56g/hFfJznndgJYr2ekXKA080Y41eIXbNCwhnIMrVEj7KIENT6ZPhsP8RiatsJsApBzStAftIY5WluB1DRSmxs/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdRL5VS/PXSZCa+ZX9K3M4/t7Y+lv+pSVT5ngJluxfQ=;
 b=xHsFWgiaoKhoWD4spfXrZUWeYlFpqv8ZI4X51tZzhZXq67Y6BMLx9TeH1C/6qmyQNdUFmuNX27fOEzeMezi/0MRkWEnnkM15WdkW4QX/ucqNk+SEKXT15gkwpHCL+ODtUq5AAmibMXcgRZHLRc05XQL8oDs2fVd3CcVNRDtJoOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 10:25:41 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%5]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 10:25:40 +0000
Message-ID: <cdbe26be-1132-332e-86c8-642b76097caf@amd.com>
Date: Mon, 28 Jul 2025 15:55:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
Content-Language: en-US
To: Shannon Nelson <sln@onemain.com>, shannon.nelson@amd.com
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, leon@kernel.org, andrew+netdev@lunn.ch
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-15-abhijit.gangurde@amd.com>
 <086f34bd-12d9-40a4-919d-9c36a4089e8b@onemain.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <086f34bd-12d9-40a4-919d-9c36a4089e8b@onemain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8dfa07-75c1-4821-21d6-08ddcdc11a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am00bjlmTytaanpwdXVtbFhacjhPNU5PQWYzdWc2a3pIRStyWFpZcEpUcmM2?=
 =?utf-8?B?K084eW9oL05qdWZOZmIyS0lIdGozNGZ0TVRzNExpK1lpMHpaZEFJZW9TbG5Z?=
 =?utf-8?B?YmVuNUw5NzE4SG1wcUJqWFNzb1ZKRkJKY2ZVQ0FibzVHQnBLeGJXK0UyaW9Z?=
 =?utf-8?B?QncvbWZUNnhoQjNDN2Z4QUFlOHJqYjk4Mk51bDhmRHkvM1FqQU1UV09WMWRE?=
 =?utf-8?B?SzRoTzZOTHZmSUlyaDlFUFBUUjl5aklFSHdYbE5iRFdzQnkrK3lLalFoYklS?=
 =?utf-8?B?SGpIbXBwQXhvd2h4c0xJSjBCZmFyWDhyalFBanJjY2MzVW5hME5KYmNOdmJG?=
 =?utf-8?B?bTVaalJIbXFMckVxWDhVai9RRVN5ZWdGSWl5T29uSWVSajVrRE1PcEY5QitY?=
 =?utf-8?B?YXFWVjY3cDJqN1h5RUxTUllDMnh1eGF1WXdHQ2VkSW4zVkd6UU8wUU12TFJZ?=
 =?utf-8?B?SmV4NkFldW1DVGJWQUxzOWR4dHhwYnNKZzYxYkIxem4xM255elBUdjRMVzMr?=
 =?utf-8?B?WVphcTlIQnR1aFVqc2h0SFNaaXRZUXljQXQwL1IwanZMR05yR3RXR1Vxb1hQ?=
 =?utf-8?B?cEg2cmF0VUxBL1BZNkJRY0VIUzJqSnZncFVONGdGU3dLRW1PeWJxcTVNUSt1?=
 =?utf-8?B?RzdWN1hNUmt1NTgzL1lwN0lQeWFnTjdQd2NZLzQwam5uMm1OVndYUXl4azl0?=
 =?utf-8?B?RXhNcExZWFJPUHVZdmV2Y2orRUZkbEI1SGhJVHhMRklsUlYyRUdOcXBDc1Fm?=
 =?utf-8?B?OWx3N2JjT0dHbi8vdG4yczI3MlVIZTl2emNEQkQ0ZVRYbWhwdTdGbUwvVEN3?=
 =?utf-8?B?enZCRzlrbFRMMFFiSTZWb25kc1hNQldXK044Nk04RFVoQW8zRnFmRHRNUE1Z?=
 =?utf-8?B?OUtWRmEyRW42Rm1DZTZxOGVQTzM2eFNMdEJuaEFhYmIySXFSd0FSbVhJMWtq?=
 =?utf-8?B?VTVJd0ZaTHJkWWtmeFZpUWVpVTVqQ3cxTW8vNUxVeVQwWW9sY1FRQ0twWndU?=
 =?utf-8?B?Si9pcnBuZE9vcmozUnMxYU1wVTVveUFwNWFEbysyaHRsQjJYSHppcEJGRWJY?=
 =?utf-8?B?QXhyTEpJL0lWd05ab0V5V29HeGZsQkpKNVZ4bWw1cTRKOHBOdHYwOE44N0pT?=
 =?utf-8?B?QTVteERHakI4a3pmSlR4NW1NMTlocFFnNnVsVlh2SzV0Q0EwU2ZKOUpMdEI5?=
 =?utf-8?B?dGYxejR1Ly92Mmc4TWt5VzkybU9NcldBRDdHdXZLV0wrRzlrMVBzTG5NOUhj?=
 =?utf-8?B?c2lhenhjTVFmZHVxR05KY2h3NUhJZHNNQVVnM29sQkkwM1FJWlU5U3NJQ2wy?=
 =?utf-8?B?aTN6Q0dWdWxyMEQreWFVb2NjS21zeGxDcGplMkN1U2FvYU9GcXJLelJ1RmZv?=
 =?utf-8?B?Sm1uMkN5N2Irb1BBRXNsWUtEWDBxaTRnd1kwa0xkZEU3emJpZnJrVXl6WnZG?=
 =?utf-8?B?dDhFZnVxbk5xNEVXbHk3U1VKdUJLckMzUE9NTnlRZW9pcWdENHFSRzB0dGZ6?=
 =?utf-8?B?cWs0S1pBNEl1T0kwZW85Z2NwbnJHdXhYc243cnpxMkhDWVFEaHRXTndRL0NR?=
 =?utf-8?B?M2JuMTBtSWVER2QxTW9QOWZURnJDU1pSSS9QWVlDeVJwM29qRGYxWGJBNk1N?=
 =?utf-8?B?Z2NXSTZuV2hxY2FVZTZ5RkFaaVhlMm5LL3puOWFMbTZQbU9FRmlZd0JNVlNu?=
 =?utf-8?B?aHhBYmNSSHhtRmcyY3VabmRlN29SMW85MUNmUENRNE9KVFgxSlNzK2dqOWRm?=
 =?utf-8?B?MlhpVmFVc3hMditUYTBweGpBRmY1UFoyeWVTRWtnZlZxd1k0WXRzMkZzZHFH?=
 =?utf-8?B?RmdiaXdjK205VW80OWNuR2t1a2U4aHpSVmRrSFhUUVZObkp6WW9wRG1SZUpT?=
 =?utf-8?B?TDl4a1R2clB2WmFzRGwrQUlyL0hEbWtMeGY4YlNObjJybmdoRkdvWElBa0Z6?=
 =?utf-8?Q?gKg575ZYn/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmN6TzN2dnBkSEpER1ZyWmpIY0wvRGxxdkFXOU9JdEY0Zk9iYkhVbmZKeC9X?=
 =?utf-8?B?LytObDhBVVRjU3F5Q2VidGhnVnJOT1duZkdndW1kaDJvRWJuMEdjSHNsZHha?=
 =?utf-8?B?aXNPazQrZFBmZHNtcTRiL0ZmM2Z3Vk5SblJOdkFpTDNCYy84TVc0akFSejhI?=
 =?utf-8?B?elRjQU5ZTzRVaVY2S1ZTK0puTUdsbDA2K0d4cEQ4VFF4RERCc05aWlN1Y2hm?=
 =?utf-8?B?MXNJWnVadVNIYi9VL09uSzVPdTBvR1hKTnpoVGN5TEJCL2MrNXMxeXVrQ2hp?=
 =?utf-8?B?ZmUrbjRvQlFhZDBHc1N1QmFnRUQwcXNLYVRuSkhWUGJnTjBrbEc3MUFpeHgv?=
 =?utf-8?B?aWpUSWlBN1RjYmdTVlVSTzVWL3JWNzEvcjJ4TloxTm5YdUNGa3VmeWNNNC9v?=
 =?utf-8?B?K2lsV2tZWlNqUnhSR0pQcmlXbzFTS1pOenUvWFA5TjJoc1RKTU91R09XYWU3?=
 =?utf-8?B?bW1kcXBmTFJydS9UTlRIMThFMVFzcGUzRWdFOVU4RlFia2lISnZFWkpzVlBJ?=
 =?utf-8?B?R3FRZk1ydTRCSG9WVklPT04vVHNsalZlNGUyQ1FWMjVWUGgrNTFZdUh2L0FL?=
 =?utf-8?B?eDdva1NHTUw0SXB0UEVDaWRnWEZXZHZlTEFTUDU1N1FXaFNRTXphM251Rnlo?=
 =?utf-8?B?dmJ2Z0hncHBiNkpwaUcwU3BLN2JqR01qT3dCbE5nbmFFWDIvdVBva25MbmJI?=
 =?utf-8?B?bXJaY3FFVE1KK2trdzNlWEFSZDI0WW9EbnhqYW55aE1JSlZqZ09FbU1XVU9E?=
 =?utf-8?B?UmpZN21OczNKMklVM2FjY2JVZEFzUks5bnVPK3ZjZFhrOTJFZkZOa0w4Q25J?=
 =?utf-8?B?aUg0bVhHOTRMVU5vTUd3Zy85K0hQK3pLR2p6ZDNqT3B2TWc3Zjg3YUdWZ3lQ?=
 =?utf-8?B?Q3EzWVRmODl0eVJKc0JzMHE3V0ttdFJPa0xaSzN3R3FyL05KOE9kckhjVzI3?=
 =?utf-8?B?RHRybkI1V0ViV0RqcGJSTU8wU1dkMFVMM1FuQVM1elN3THI3akxKcThzcVp0?=
 =?utf-8?B?Y3dMMUhhVDRBdEhrSFlod3MzRWJFNDZOUGFzeXU0KzQwQU03andlM1NGUm9z?=
 =?utf-8?B?NlhNUmh1ajVocW5weGZKdkZpS3pkaDRpTkJCRlFRQWZZYm5qcXN0TU52Qm5n?=
 =?utf-8?B?TG80YkZTQStaZmZpZ0VsWEEvSWtpaFJYNG4rNmVnaG5uSU9CQUQrZEJIb2hK?=
 =?utf-8?B?ait3THhya1I1cDFDL3d5S1pVMHBIc1NydjFnbERMeVhlSEhPVCtFSjZxYmU2?=
 =?utf-8?B?b1RtT2FYN0QyM0NWc0JxOW12RWV2NjdRN3E2K04wMm0zRjdRM2lrZTN5bE5E?=
 =?utf-8?B?dHhZZDRvSXA1dlF1djhZVjlnMDZUV1dwNVBuMVJuSnQxR1QrREdSQm5FRExz?=
 =?utf-8?B?bmVoOTNQTncraFFsem1MaFd2MG5CQldCV2hqc3ozNk53UVRsUkk0RHFVYmFB?=
 =?utf-8?B?clJ0UEZJN2NMVm5TY054Vzd3NWZpYXFhTDhEZURQVzVEK3NUVi9HNWNPWmhY?=
 =?utf-8?B?U2V3d3lzaWtKWEJya0x5aE5kdGJXSVB1LzZJWkZSaUR6MDJFT3BKN2JBazlU?=
 =?utf-8?B?L0Z4TXVsY3dyQ0JveFBNZ3VEYmYxb3FhU2NJajRLRzFNbUxyWlVwbkF2TWlx?=
 =?utf-8?B?b2R0ZkkvT1h5MTJNNXo3TjQrWUQ5RkwvWGpERm02cmx0U3ZGTG1sZGxVOTBa?=
 =?utf-8?B?NC9RWld3VGRPZ2J2K01XaUtQRXhPb2o0Ylg4RlR2dkswZW5KaXl5c3VBZ1Ix?=
 =?utf-8?B?dDVDU2dDamtHdkVkcE1PMGtpV0tMYTJIa3JjZmRRa2U1cDZuZXAzQW1FeWxO?=
 =?utf-8?B?NnNTM1Frc094WUtVSFlDeWV1Ri9QN1B6QkIzWDBuRVF6NTJlV3VkZDlVa29z?=
 =?utf-8?B?RWxxTnVRNTB4ZllhV2RoTVEvYXVFditwL0RQbE9ITytwekJXUTJ0b1ZjNEhr?=
 =?utf-8?B?N2g2dWdEM0V5eGkxREg2dE8rUlM5VkJkZGsxa3phaW9TcDlqb2tPMVdoOTM5?=
 =?utf-8?B?ZDgwNGlXb1l2UUw4b1ZjTjVCZVJkY0J5WGVHZ1RJWDBZVTNuYWh5eUgzZ3ds?=
 =?utf-8?B?WE4xWGEvY1Z3S3pOY0UzUzU4cldLUTNJZmJ6QXpGa3FwUCtBUVFZZTBGbG9R?=
 =?utf-8?Q?uNAwxgtTO4qutMS0chDQpT37l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8dfa07-75c1-4821-21d6-08ddcdc11a0a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 10:25:40.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7VtIqGfLmt1z8WRunwFl9emTq+35doMIvld20rtIu2EMP5lkhF955LGsBvMLuSNALInojckVENxp/uw5kp+IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290


On 7/23/25 23:43, Shannon Nelson wrote:
> On 7/23/25 10:31 AM, Abhijit Gangurde wrote:
>> Add ionic to the kernel build environment.
>>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>> v2->v3
>>    - Removed select of ethernet driver
>>    - Fixed make htmldocs error
>>
>>   .../device_drivers/ethernet/index.rst         |  1 +
>>   .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
>>   MAINTAINERS                                   |  9 ++++
>>   drivers/infiniband/Kconfig                    |  1 +
>>   drivers/infiniband/hw/Makefile                |  1 +
>>   drivers/infiniband/hw/ionic/Kconfig           | 15 +++++++
>>   drivers/infiniband/hw/ionic/Makefile          |  9 ++++
>>   7 files changed, 79 insertions(+)
>>   create mode 100644 
>> Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>>   create mode 100644 drivers/infiniband/hw/ionic/Kconfig
>>   create mode 100644 drivers/infiniband/hw/ionic/Makefile
>>
>> diff --git 
>> a/Documentation/networking/device_drivers/ethernet/index.rst 
>> b/Documentation/networking/device_drivers/ethernet/index.rst
>> index 139b4c75a191..4b16ecd289da 100644
>> --- a/Documentation/networking/device_drivers/ethernet/index.rst
>> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
>> @@ -50,6 +50,7 @@ Contents:
>>      neterion/s2io
>>      netronome/nfp
>>      pensando/ionic
>> +   pensando/ionic_rdma
>>      smsc/smc9
>>      stmicro/stmmac
>>      ti/cpsw
>> diff --git 
>> a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst 
>> b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst 
>>
>> new file mode 100644
>> index 000000000000..80c4d9876d3e
>> --- /dev/null
>> +++ 
>> b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>> @@ -0,0 +1,43 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +============================================================
>> +Linux Driver for the AMD Pensando(R) Ethernet adapter family
>> +============================================================
>> +
>> +AMD Pensando RDMA driver.
>> +Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
>> +
>> +Contents
>> +========
>> +
>> +- Identifying the Adapter
>> +- Enabling the driver
>> +- Support
>> +
>> +Identifying the Adapter
>> +=======================
>> +
>> +See Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
>> +for more information on identifying the adapter.
>> +
>> +Enabling the driver
>> +===================
>> +
>> +The driver is enabled via the standard kernel configuration system,
>> +using the make command::
>> +
>> +  make oldconfig/menuconfig/etc.
>> +
>> +The driver is located in the menu structure at:
>> +
>> +  -> Device Drivers
>> +    -> InfiniBand support
>> +      -> AMD Pensando DSC RDMA/RoCE Support
>
> Please add some verbage about this being an auxiliary_device dependent 
> on the ionic driver, and that it can be disabled/enab led with a 
> devlink command.
>
> sln
>
Sure. I'll add verbiage explaining that this is an auxiliary device 
dependent on the ionic driver. Although this series doesn't include the 
devlink changes for enabling/disabling functionality, I'll make sure to 
mention this aspect when the devlink changes are submitted.

Thanks,
Abhijit





