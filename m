Return-Path: <linux-rdma+bounces-18224-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMaBE5x2uGn5dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18224-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:31:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EAC2A0FD0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DCB3050EDD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F283644BD;
	Mon, 16 Mar 2026 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="GxmpVeTX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020095.outbound.protection.outlook.com [52.101.46.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A636492C
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696594; cv=fail; b=OX3G3+euJ4SgPkJF6AowEB1EiEyH4piw0uuups9hZcVCosusIhdWwmZ3r3M+ABu82M/wL0N6LK2P8mfSm10DJ01ZCQMD0BDQJ8c4QErqK7PnQTFnMW3peeqUbet12FUFnBJGoq+/DY7Te2GDOHfw+3EyPWExuG0v8LN2zpzu06Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696594; c=relaxed/simple;
	bh=03OkmvV2Od8EzynHqR5By9CuQ4X1SdgTbW4t6OPU5M0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bdh9jh/WLvFT1iPGak/GmjvksxmupiNhgYKrXpwKZFxtPQmDykkXnZZSVpl11USjtntvQi4RIpN/I/rjJPBoGLGavuUBhq+DiX8qX7RtMMcglwHu8c/APcI1YyfxrwA/afGzK/54lKHvDnAMzoJE/GI4SRwQtsWiYQqBDjywE9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=GxmpVeTX; arc=fail smtp.client-ip=52.101.46.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmbX/ZNzfiLwaxeF6ivZI2TsRK7XR0dvuoLOENUmO8YH+NnYRDx3KpOSsl1Z2LC2YAN+6AwvcrYypOHn4dq8dOudGdO/NO9OcuQtV3lllMgDl/gey8NDweVbeJanXehKIsAFmNOrXM3F533vfa9lALdccIeuxxB0jtxsMaC2tA+HjWeb7QhGmq+JV31FONDFZIM3M1ksMFwscz3Amhjz6Vqg1dJ7AT4YJMr4z98VKR8hzHE4yj2QnB4RfHFS3jeehpYxAZoTWx076rVAX+ZgPvC8LE+xhaCbQcnotE/ck92EuA3mAdjnYFa5EwCzMcPu1Gt20L6ZJW+vLZZe3/0Xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwzlhLf9bijG9I6Km1llw/cbI0HT2ql+j3Op0GLa6ZY=;
 b=BkmqtOUaRHQijlTVMxyBL6To5ndzaw2lGy60BObgy4C135qBj1F2uf7WgkefEcQTBTJlsgwJzNBvKVtLy8Rf5uPfwxP1HO6eGcR+bMR2C09PMwJGiHtw00egPIxK0BJFXGN9cBUlx49b4Rly5CFHjtIy3WrbXBZPqQn6+0Yz9KxPlRVdD19gPcaebLz+wexhtmykTycuLKEb5G6BlArdVwlVUeSLNOMAa1ZBxVXkUaIc3/0NnuJCySYulfCqxTwItJbARfGz+aSd5L26Dp9St2L5kUMIG3xQdQpUYTiYBDdTTwP9t+fxjpKiDM0RlqoN+6DUf+FnYu+84iXMTuNxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwzlhLf9bijG9I6Km1llw/cbI0HT2ql+j3Op0GLa6ZY=;
 b=GxmpVeTXiUMZeh70l8Z91hvKZmeL8dLoRBh1FIExoB3YJ2JQhkz2huqfTmotgsHQAA4TWOQoM9eLsbOtzp5LSo/Gx3vREHhuJ4tyed8f/EXGbQ+uZyTv9yyxCPNGT2yYeL41iyky+K2W2uBGNroQDcGIg0pyDJo3hO1Uw4itNz887CkzmhWS8n+PymFyetpvVyVkwOD8bkOe6NUU2ZUFWUyLzk4hr6olzb0AnlTsJpgzyFB3wwAKnsSZ0fuqUSwQeLeTElEoLrCjEQFCLpUMCQCdHBJVplEnbqvfs3c6I3eqDAswIzV59jXO/SHaSLnYyAcQdJkWdk8qZzL2nbTvzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 CH3PR01MB8629.prod.exchangelabs.com (2603:10b6:610:168::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Mon, 16 Mar 2026 21:29:25 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 21:29:47 +0000
Message-ID: <3ce89e19-f81c-4c04-9a45-2bdb72516b99@cornelisnetworks.com>
Date: Mon, 16 Mar 2026 17:29:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next resend 00/24] Migrate to hfi2 driver
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>,
 Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <20260316160203.GE61385@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260316160203.GE61385@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|CH3PR01MB8629:EE_
X-MS-Office365-Filtering-Correlation-Id: f190a48d-107c-4a8a-9886-08de83a325de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9tV1OOD/IqXd/I1w7wXlXkOhtSm03sDQ8tBZQpsjXLTnQco6sITQFU6MNnkalZaIc6XDgFzP7dXxUWa/Kvc+HA8OcRkm/jkmseHDva0Gmbt7JeTQaBETlXOJRu/GeC+H+eu8PG5RX1pL309cet+btSfD5OPK3f9rbJuutxCihRr1xH7jIkRgzLUrL7aEDr6BMPQ6lA83Hf/brUg3DZoWIQFnaW82Np/r6l9LSuztByyIBv1RhbnZtTlhoR6RlkNfUQCafEMiKc1X3aX4Gd7r6J6CLEpz3oFddBFq0FAUyuRRn7fYAfyOvhCK3j/ZmlGyj6+6vjAvmQljyktF4z5XZPH67f/0RaEZ5Jfkt8CaO1TufwI3K8KyqZaeVxFLcur95dGXtlxGrWDbLnuo8/c9BcnGpX94T1TBDz+SnGahAxaC+x/kFo+P0HlRzs9RKqZO1xBXs2NTxoc5kAMBxSoS9xSV8zdRoAnnI+4trT4t6wNzuOw340Wa1gEBakjBQ0B0ZKy+l0QYEP6FqwC6int4lMSkwgcr6ufzGl8a0Gyzb97u61wqHqyU26DqHg9P09czsyt18NKWZU1lnGTTXxJ0n6UOWmzwLAcrC6bWwkn1Xj30XFV9Qxw6hdWi7IYAxoZkLz9Tm2G/JmNmlaWCaw02hjQjHYv/bSCgVX3E2C4biF1iGLTLvrCrDQzxiQFq5rPHPp28wjnIPAeqGyICAvnHIQ0v5I9Hgcr0psJ2S2eXzvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eSthZnlvWVk1RzhuNnRNdU5DL3BlTFgvM29DWEo5eXE0TlJaZWRSSSt5VDc1?=
 =?utf-8?B?azZYL21nd3VpY3p6WDdaNENuTU8zc0hxRCs0OEYxQWxPY3ZhZ01FeWROTFRx?=
 =?utf-8?B?Zmt6bVUwLzY4S1JsVmZ0K0RpdUVIYjlLL3k1K0s2WGUrelNPYXFHcHM0alFY?=
 =?utf-8?B?SFhBcjkzdHZWRnBQbnNHUjRDSmRKMUpwRmN4UVVNdHhtMGFkUDNVaUpHd0hs?=
 =?utf-8?B?ME1BY2VkUzdWdmkxOFhPMHhmSTNCWEZuQnJCd215WjhLUDhvdmZaY1FBTDlX?=
 =?utf-8?B?WEpzSzFKSzZWSmU0Tk9mK3FwOXZwRVRvNU5Ha2tWQ1BhWm8vMUk0Z09PTUQ5?=
 =?utf-8?B?WVptNzdaNElhZG0wcGJFLzdrZ3I5eGVweXQ5VGo5UlpKVVFnaVdQZzRua0Rn?=
 =?utf-8?B?TUNhMG1OUVFUTjhGTmRTK0dPbmMvMU0yYXdoeWNLbXVlN0tJUkdUTDNWLzNF?=
 =?utf-8?B?YVl5M0pKeFUyLzJodk13RURPekNTcUhPZGZzN0NQbG44WjkranpWK3AyTmR4?=
 =?utf-8?B?TFpySDU0TXBkWi8yWUtMdGdSYlBlemlGYkhCdElGelFLYXVaOS9MazFldk1V?=
 =?utf-8?B?RUNaTmpxYjR5V2FHZFhBU0RsdmJvd016eHl2SVp4V2Z4M0M2WFNDcksxMUhI?=
 =?utf-8?B?MzJkc2NFYUQ1UnhWYzhCaktXQSswcEJmMTU2RHNIWWF5SWdJQTJKUmRpOTRo?=
 =?utf-8?B?NExpWXNYQTRqMDRPS2tQdE1mK3o3eGJZL1llSVpyZm9OWG94NFdlVFB6Y3Mx?=
 =?utf-8?B?QVVhQUtsMElRT0tUUlM2NlNxYnFHQmlFejRKMlJBVWdLTlFNU0dOZEtUcWNR?=
 =?utf-8?B?NGJZaUtldDZTWEd1bWwrT08zOWlsbVJLS3lJeEdWS0owQkQrcHhaR2lRS01Q?=
 =?utf-8?B?ZUVUK2tEcTdHbUIyWVFKOXdMblZHamZLYmtkRVMyUW1SL1dzWkppNDJIcnBn?=
 =?utf-8?B?aHE1d05mbkY3TkRMVFMybjVIbXNhaU9GS29tWGdrVHd1WEdYdXNOK1d1cVNm?=
 =?utf-8?B?MjdoYmdpVHZ4RzA2MnlQN2l4WktIcVQ2VFFsaWliMkg3M2JxeFU5blNLaDM4?=
 =?utf-8?B?a3BXTVdHMmhLOHZDWUlma0dPUmNZaFNMSGtQUmxxZDlLbmJLKzcydllXUTdi?=
 =?utf-8?B?T3F3Q2pMczdkbS95NnNiTjlZaGwvWTNuNkprQ08wMEhodXJ1RWZkeGNPb0lJ?=
 =?utf-8?B?ZVJDdWhqOEsyM1RBZ01qTUpZdWNwZ3R2VmQ0UWRKaGJXNVRMMDlQZ2ZZU05T?=
 =?utf-8?B?YURZVVU0WTFYb21meE9VRWtENGE0T2lSWlZqWlNYSWdzemhHbE1WZEV5MVpo?=
 =?utf-8?B?YTZwQW9tdUVlMHFvWW4ydFdQYk5OSWdmL3JjL3o5dkc1OW5MUE9pOGl2RDBr?=
 =?utf-8?B?ODRWWDZZbjFsMFFYWDB1eDFtbldRZXhiZ05JVWFvU1l4eDh6ajZFU0JMSDRC?=
 =?utf-8?B?UU9ROWRZVE9FU2dNZTd6cjZsQmNNOExRQUdMNFROSm9uLzkxSW9paFhJUzlO?=
 =?utf-8?B?VVRwcSsrU3B5d25SbEN1dGdQcGdYQWJRYjdzcGtGKzZVOVFHZEJ4amthelRK?=
 =?utf-8?B?b2tESVkwVDBjcVZGNGZsSGV3bkpmL0lKZFhtMzJnZVEvRDZOMFNZMmJqZC8v?=
 =?utf-8?B?TnBMbGFLei9jVlNtMGFUNXc3M0N3VHNGTlhxN1lhVVdTZUdORDA3cVdqNTZ4?=
 =?utf-8?B?S2xDemcvUzVCR0l0SEx5bXJ6a1JSb1ZTZUdLVFI5WGZsZjZ4ZSs1aTFIb2Zx?=
 =?utf-8?B?ZXJUVG9qTTY5d0lGQ3E0d3k3c1Q2eWpQZTljNms0cmdIR2RnMHE0aFg4N0Ri?=
 =?utf-8?B?NlBBc2RhRXh0V3FIeC9tamlIVEd3Qy9QT1NZSVdBK3VoTE9KY2VaenF2M1Er?=
 =?utf-8?B?VjZhb3NUTXJoSFlyUms3ZVJLUlVaKzc1SnQ3R3d3TDJ0d0VxeGpLdnhJTEtj?=
 =?utf-8?B?RjBzMnREQWpWNzM0ZExON0NpQkUrS2FyM0U4T1kwUjZEUEg2elVvMkQwMERC?=
 =?utf-8?B?bDN2V2J6UGxsWGJKRCtRdmFuZW1YOVNEMDFGZTlVSTNsN05uQ0VzWVpDZEYv?=
 =?utf-8?B?Zzd1dnZoampjU3pTNjJyVG9XNS9YeHYwdEpiOXhDUVQxN0hhWHJkSXJRMmFS?=
 =?utf-8?B?cysyZFVOTWk0VC82Z0xmT1p0SzlJdko5Ri92TlNhRlZoZ01nTXI5cHEvZDNk?=
 =?utf-8?B?bU9scU0vK2ZyY0NLRjMvOVkyRnZKRUhuM2o2a1NsR3BkbUg5bC92UW5SYjVK?=
 =?utf-8?B?MzR1OUVDUGNJWTFhaFEwaG1WQWllVjIyZTY4dFJxZlRkRko0TFIxS0I4My9T?=
 =?utf-8?B?aGIxemltVW5seVhUZDZ3L0RtK0ZwQVM0YTdkQXQydldBdWF2VjJWWm1ZMFZk?=
 =?utf-8?Q?2IwYirWPq9YMSDtuSAQcU5CMWRho5JZtEMhzi?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f190a48d-107c-4a8a-9886-08de83a325de
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 21:29:47.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1W1hDiFLG9wNZv10y2rHye4fpYgcATWQiEcX0AvstoIQU7BAu4Qh1Zdy5VBVzBegBXjCYZVz2bfOxfpxPVmNz7nRPxjD3WuYYYiUJ9V0l1np4Tfy83/5zZzvuDA11Bb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8629
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18224-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+]
X-Rspamd-Queue-Id: 15EAC2A0FD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 12:02 PM, Leon Romanovsky wrote:
> On Wed, Mar 11, 2026 at 01:53:45PM -0400, Dennis Dalessandro wrote:
>> Apologies for re-sending but even my cover letter bounced so no hope of
>> getting thigns to thread properly. Re-sending the whole series.
>>
>> While sharing similar bones, the chip for the Cornelis Networks next
>> generation fabric technology has some fundamental differences that
>> resulted in a near complete re-write of the driver. It also does not
>> use the private cdev interface that the hfi1 driver exposes. After
>> discussing this with the RDMA maintainers we have decided to go with
>> the approach of moving to a new driver and declaring hfi1 obsolete.
> 
> We didn't agree to take problematic parts of hfi1 and put them in hfi2.
Sure, so let's identify other problematic parts and we'll see what we 
can do to get rid of them.

-Denny

