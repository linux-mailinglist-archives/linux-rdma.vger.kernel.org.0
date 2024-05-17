Return-Path: <linux-rdma+bounces-2521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FAF8C7FA4
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A26C1F235CC
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6910F9;
	Fri, 17 May 2024 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MIH/1U7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC838BE2
	for <linux-rdma@vger.kernel.org>; Fri, 17 May 2024 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715910318; cv=fail; b=mRdsJeg/IEVqxlkYVn3IIpE1kRaL6hdH/74iaWRSCkPtHqFT+rJKOstdMm88U408fot7UICfxZIiF9H0DFILt/TVtswYkVDL/B9qhXXj4fLZasgg2l9/Y65SIDdu4mLwSxTlJ4gO7wj7pdh+U1CHdcvtsEVkeJga59o52Kv8Cdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715910318; c=relaxed/simple;
	bh=MrCSuJpy8dNcK7OlD4fBIkS4p8BhvzJw+UejN6S1yws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhAhB9j3HdZsuLBI2LUisvpc1v5L5AkE0FaYqY+5Y6iqWObS9C5B1UzlVLnVrNp3J22HpTWQ8L/Baglx+MpmSBN5vAP9jFRvgtwTzs3WjzP7ubMtnmin0SKpc51QEPlprvv6VM0DJpMbBs29SRCmDKuspj4tEudKsR49jjzDITI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MIH/1U7a; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715910315; x=1747446315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MrCSuJpy8dNcK7OlD4fBIkS4p8BhvzJw+UejN6S1yws=;
  b=MIH/1U7a9/h88fT3Dm+IkDCmJBbsvaDGj8tWB1bcFfK4j/fWT67Gb6zJ
   Z7ny2Hn8Tl7nRzeMyC5/Kskc3bIE+4aTfuD0hgGkI0PWxQAzkUoisQdgA
   BkUpFqZWBgR0zjnl1s695tLEs4ZJLAzdgGxMDgEiMAPlkwpiYhT3VrXab
   ilBcwjq1skeBtvgvvhLlQr7Ng3nSLj8e0zWr/sK5vj4ViQY8hKCjDkiop
   DZDjKOaLp+FqjxTj1f321MBzFJ+hi0hkzVRvorRFMINilK3p7DfCNcptV
   t7Jr4tzyB6UiI1+1bkbU5UMijt96ohtOqJwnpZxkWimpcS6Lqw5SnF0nv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="119659993"
X-IronPort-AV: E=Sophos;i="6.08,166,1712588400"; 
   d="scan'208";a="119659993"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 10:44:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glb5emVeDZypRSYKWHwIv/aHZ6lIJxGxaSVfSVCcjC6Q+loI7OTSg/bDEm+CFaqrCtrO4bYRNBXvs/cmuuQSNz0bFlgFHvQt9oGl+gSuB4wR7AUNWmw6jzk6gv0XXClxFlYSvb3LSV3ZjLUnJIMN4eINasp9SI5IjeMJY5A9OkFAvB95/BujJVsfaowYlPQgnMZvvIIwiwIEu/yAy8bDeaVDag4bQ9ZWuhnbs3AkAWZXpC+04t6ngAhm6UCJmB+SfjoOVg7LlsL/4mgFCIDyKVZtGWn00NwcyJ7DH3BrGjY4cY/A19YTRl+gKQfDNaF2UAsuzEWwG5qKUB7YFaTu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrCSuJpy8dNcK7OlD4fBIkS4p8BhvzJw+UejN6S1yws=;
 b=BX82Z84cnUKFUjt2TjGp5LUzmCN0vU73vIB0LChqoVLWWcDJCtu1Auu4N3X+ykH5/TYcKSN8W9se9W5v8B1S3qeM7w3nYLe9KB0qNQ11u2O0W3UJNAOAQYZaTYVvevnCd1Dx/KaVSFzKI6j2UCloxSIBtp9FOcKVYsk6hhkDJ2lgXjrtKRNmtIY2QKF0b4bG1UGLeIwIYe2u9gaWXbx+HNqkzPoyKUjVD8KH0YEZ7+26QHqvKp8zIPaI2MMMtDYNOZXVVoQzhvhGqqtu6CRU4stoQzZyi2778odIqx6sC7mi3OuJxi22FJQQ8bdQKJWhHLOvTO3VYCFzIxS/c6UYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB11038.jpnprd01.prod.outlook.com (2603:1096:400:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 01:43:59 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 01:43:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Honggang LI <honggangli@163.com>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Thread-Topic: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Thread-Index: AQHap3alkfyJZNtp8km6yMUvtyqJS7GaqHCA
Date: Fri, 17 May 2024 01:43:59 +0000
Message-ID: <ef948dee-a65e-4c8c-a8ab-12cc06634b17@fujitsu.com>
References: <20240516095052.542767-1-honggangli@163.com>
In-Reply-To: <20240516095052.542767-1-honggangli@163.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB11038:EE_
x-ms-office365-filtering-correlation-id: 4654b24e-9cff-47df-f237-08dc7612d2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0pFaU9oSDBJa0lWbmJ5eUh1Y3BwTHk5Ym83bUdjcWNzdGxQYjFxVEh5dlh6?=
 =?utf-8?B?M040R0RMRmFZUjdlU1dOSU1OM21uN210ZkhnMURXeU5oNmhJS252dlJXM2hl?=
 =?utf-8?B?TjRQS0NXalFVSUJ3R3UvMlNVM2FWL3J3VFZUaEVDNUZZMnVyQmprSU0xdXNw?=
 =?utf-8?B?dTRkaDkxbkgyeU12N3liV3NQK2NYSU1zYlg2V1ZXMGVzUllNMEFDcXNOL0pM?=
 =?utf-8?B?UDNSZlM4YzlPRzg2SDhzZU1GZXZpWHdORUhEWGNqaDkrTUlPWm5UREQreHZO?=
 =?utf-8?B?MGNLZVpxNzFtZVVjQUxOa2k1Qm0wZkxBbXMwSzN5czcrWWRYdEZmY1NrU0ND?=
 =?utf-8?B?OUhHemxjZDIvRTd5ZFBURDMvSHQvN21Rakh0aEE2SFFqSHdvU2JnYTFNaVZj?=
 =?utf-8?B?SGtOZDlZOTNLVk1NenJHUUI3eWNBMnFWdTJLMDdXakJlY0YxNDY3dGZYUmpT?=
 =?utf-8?B?bUdvRGg2OFZPSm84OXNiK3FnZVB2RWxRYTNiUDgrZldkL0FpbkpyZnlZNUpy?=
 =?utf-8?B?MzBqR0ZSQWx1WUtxbzg2YkVkOWxaYVAwNVNrYVlPM210VnQ0aS9Cdm04TTBU?=
 =?utf-8?B?WUYwRTdLRFFqSGdlRlAydjE1OEhYTGdJMVREZFVhRXRxcllyMWRQeDVCUXRq?=
 =?utf-8?B?QkhaT3BLTEtVc0FnYUo4QkdUZXNuR0hPc2M1eFdtSDV6VHNrUzJhbnNGd3ZH?=
 =?utf-8?B?c3RGZEEvM1BXMXZGZndkajladGd0Rk45QkNEbVFpZGg3a3FldTFrMjdpTGhP?=
 =?utf-8?B?NTJqdEsxU2VHYW92eWxsM3BZaTRUTkswWXh5QitFVTVlM0FJd25RSlYrNnJW?=
 =?utf-8?B?VmF0eisyNHNSZXdDSi9XWFloYktTdmZCcnpiWU5FSVJKRlRwRjJNenBiY2t2?=
 =?utf-8?B?R3JTZG9RbTNZS0NVa3QyTUhYVHF0NHM0K0tFN2VEdHlpbUt4YzlTTlZRUWtC?=
 =?utf-8?B?QktNNmZVSDd0YUxkQ2NPR29DeXJDRE9kaW9IcVlHSFlHK2VCZnJ1aC90TnJN?=
 =?utf-8?B?OE1McDg4TVVyaUZlcDBUNGlQalZHb3k5eWJ3STlYNHJLcWEzWFZjaEJzZUQy?=
 =?utf-8?B?VFdBcmR6Rm5vRzFjL0FoblBTSW1HOXVCNEYwVk53TlNmSW1yV0M4c2pQcXB5?=
 =?utf-8?B?ZmUrSUFBQjlTdnUyV3pocVYzYmdoSitJenRSU3hQZEZLaE1sNUluS3Vvb05w?=
 =?utf-8?B?b0tIZ0t5MytrMStwNytkSjdYWHFnZmViTnJTdmU2dFYvdzc0Z3hRUUVnR05q?=
 =?utf-8?B?azd1c01aN1FjQnNuSE0zeklvSVVDdmVCeTZtb0t4eVFUdU92eUxtaDVJeURF?=
 =?utf-8?B?T00yM3hNemNOUTRmZEZjdmtLTVAxNDNCcEVZZis3VkVBekhiZFVTTWNXTStV?=
 =?utf-8?B?SUlxclV0bFdmQzlBcUVielhISzdNRUxYUERQbUFENEQwekJqeWZEeXBtMWpq?=
 =?utf-8?B?WGsvSVZVcDlHOHNhTlJhUk1VRWZSaFJ6aEJiNzJLT010ZHpkckxvMGFOSzNh?=
 =?utf-8?B?bThSK1gxRUg5ZmhhSnpnWUIyR2VwODNROUk0Y1dNU2lSU2lFWGNsWnpYU3Ro?=
 =?utf-8?B?d01Fam8zSzZNc0lZVDJsRTBvWGt3OFdLMWc4WStCYUxWaFBkN1F3RnRJQlhF?=
 =?utf-8?B?QVNmeUREQzQ3TmNIS1dHeDkyNVJhTitSZllldHBXZ3ZkcVE4czVRNUhRQm8z?=
 =?utf-8?B?OHVHaUMrV2ZpZ2d5OWVVaStCTDE0cmRoUXBvWUVNZEdzbnJtQ1JicHlNWGls?=
 =?utf-8?B?cHd1VXgrTHpyVlI4UjVpMXRlZUJoRVhwbExaYUtNWUZ1RmpPUVlMekRuK0dZ?=
 =?utf-8?Q?Y2/KJpMmr2C+J8cZJjezezh634yMy15PI/qEE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWh0T3VocUtTUGZMWDZ1c1Zvbmd3dWNIamhnZlRqTS81RUx3WXQrMStEQjhP?=
 =?utf-8?B?cjA3RGJzeHVUMHRyc1hKTGwxdWxTdkZHdnRvSE9UNEphZEVLT0VWNHVPTlRv?=
 =?utf-8?B?d2cxaDlNQ0ZjVHdKQTZzWVVMVk9oY21za25xZUVpREhnaWNkdmNmeEVjQ1VN?=
 =?utf-8?B?dEI2WE9mTEx3VVcrejU0RGhsaVBjQ1FOYVNXWGliM2Y3WXAyWXB0dHJ6bkpX?=
 =?utf-8?B?WUVmZmNMZ3ZuRlp5SE5IaVJ3bFl3VVBmTmt0TnAxdHdIKzhlY2tpMS9QS1dq?=
 =?utf-8?B?ckdWb2ZVRU1kUkl4RFcrZFVPc1R6QTdwV2tlWERmV1hEa1ZjcWRSTXVRTUY2?=
 =?utf-8?B?b1dTM1ZraUF3TkJUV3N3Q3BaMDA1VW5vVHFNSUtxZ3NPT3lyNW5VQllFVkFB?=
 =?utf-8?B?Y1AzVHNTTE14ZnQwRWtFR3J5ZmZDY1NYZDROY3NqU1NkSlNlKzAwd3BtcWxF?=
 =?utf-8?B?Y1huQ2dvcjJ4TU1KVWxKc013MmxnSm5mRCtqdmFUdVZTbzdWdGNaZk9VZnJ2?=
 =?utf-8?B?SGpWVktZMEJKNFY1TVhhVmRkS0RZMS9ReDVaWlRKaFpvUk1QU25NNENRdzBQ?=
 =?utf-8?B?Qk85eUhJeURoUTFCM1JnMWFXUzloczFGaTFsYWxoVTg3akJlSmNkNmZ0ZnJo?=
 =?utf-8?B?d1RFbVd3SWJZZlNNa25ndEtFSmsvTU9IcUszNVRlRkhEcm5UMGp2ZkdYNmV5?=
 =?utf-8?B?b2cwOWxFMkNpbVcveE9nQUkzd1lQekpreUg5dENSV29lOWtsd2tCMmRReDVW?=
 =?utf-8?B?ZC9NenZLcDZGdWZRM0pCNDUwK1RDaHpBUjdUZmxwd3ZObnBwQzdkK3FkNVM1?=
 =?utf-8?B?WlZXTXFxN01wa3I5UGJHL0lndSt0aFZ2RHBpZWJsRHoxaCs1SzBaZXlKdE1R?=
 =?utf-8?B?S3dmRGVEVFFGS3dkc0pKaFN1L0xTWmE3RkhyeXF5TWJQUndlYndHMFdPY1R2?=
 =?utf-8?B?OWFOcHVqVnFqT0dwVE45MzlzZW15VldGZXAxUklQUnNCMHMyVHU1OTl5UnVj?=
 =?utf-8?B?NldQdWs1MFdpN0Nwa0c0b2RNUUlLc3oyemh4c0N0VldTYnk4bjBmaWsrMGpQ?=
 =?utf-8?B?b2pKdGt1L2NEaFpBbUZ2VEtqTVhDdzZ6clBJaGxzS1RSTkdzajZyRi9IemZr?=
 =?utf-8?B?Qi93b2RkTWZmVEh1c2NCWkRZYThwdkZUNjU3QnQyanRCVURHaGhGNGlMWFFC?=
 =?utf-8?B?WDFyYk0zdzBLa1VRbWtqWEJtZDV0bDRNYm9pbEQ2bkpRak5rNFBWV3loTU5X?=
 =?utf-8?B?SHBHUVdBems0bFFIckNrTGlBbFAvYXV4Q3VjY3VFZVNYTi9CMjNQNGVQd293?=
 =?utf-8?B?amxxWTZyUHBpNzRQYW4rM3NiV2E4U0s4Nko4eWFNWFp0RDJpckM3U1crVFRv?=
 =?utf-8?B?eU9XYkNSaC9hNkxQRmlGbTlMblRJRFg3NU94K3FCaFNpYnJCS2gzQVpONHpL?=
 =?utf-8?B?ZlVvK0lGMUdtUy9VdDZaV0loZ3VhMU5MMUdwelhwTlhsQmFFTVo3WDVhR1lX?=
 =?utf-8?B?UkVBYmpuUVBsTzJUTkFnWDM0ZlRFNGtWS0FUVnl3b3FPeWF2T2txYWw1Q0xp?=
 =?utf-8?B?RUV2T1RKNE8wVjJLY040b2xzWExYZkZCRkhzREJDSDZZOEEzZ1NTUnlZaExI?=
 =?utf-8?B?bzZwRVFJVHplby9laEordE4zdlRuR0c4OE5rUkN2bFFrS3NtUURIM2JCRVB2?=
 =?utf-8?B?c2ZLdkJYd3lsVVhrWG9RTUR5a3Z5RXNLWGJ4bm5xMUJXOGNHd0FFcmdQditC?=
 =?utf-8?B?Q1dvNFhRUi9LbDlOVk14cndpWEplTDAyUng5TEdUblhrc0ozVGNBUkwrNmEw?=
 =?utf-8?B?aStuVnNyZW9US080SWFwaDEyNW44QU1wQ3QyUFFaZnVuYnEvSU5rTzRXeHNM?=
 =?utf-8?B?aitWSlU0ZEZFMkd0MEtCVlJlOU5SZGtZdjhBNmF2bUV6UnlQNVRkL2kvcG9H?=
 =?utf-8?B?ZmNIWGxTdzBmTXhYWGlUWG1mdkNjY0JPeDdjb3NDYXJGSzQzeXBOWFEvbi9U?=
 =?utf-8?B?T2RzN3hPTXQyL2hHakpIZWk1UisyckF3VlRyMlA0QVI0UVZPSkRLT1Bpb1hv?=
 =?utf-8?B?ZlR3MnFDMjFOTkZXZ2RJWGlabkJpZVQyNDMxTnh2RGtwMDBhNHVMdElDN3Jt?=
 =?utf-8?B?b3JOcDRHNlNQZ2hSK1VvdFM0MUpXRTIrSFpucmExeG5GZjFwcEdWYStBUlRQ?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DFAE43A7DFEC24197E2866D800BF96B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EAqxSqlOVJ3U/YIvCt3bAS/++Xft7X+vBro9tULDPvhUT5A6e3pNYCW3nO0sdmwIo2gcJHx4lasS1Kb2KAVp9c7CA9oZ3n7y8gvZP+YHi9eYMl9CiisvNo0dVV6wfYlsZOjpPt3fu4Ep/F2+EU/YWSXjTQjzIFmcT1J/9pu8Dk0roUZHWd0FlJgGKJ3K7cZlFpTvemN16Odzj3jnbrQi/GK5OJrTrqFVyHd/ffRlQxcGpi5ZaM3kbja4VxuBmUdmQrx+Fpkj3GdMlyKRvc9ziESV+s/K/Qy/3S6MKzbUchLIoGfMF8BCfLD7Y4P97+YG8iYAKpp6S1HR68Fo25A4BgSzoG/+YohvkaA6FN0TRAHzjTuq18APvnbSTyOC3HqLGXvIbTTPCd78B6uWwlqwvA6ENRro41TTxuA9G+3NhZVH0npe9WMQMDGh6mSPGtmORPou2X4NJD2+BdHj7nnXo3nmKmnZBc7sT8pE3MN6mZyc3NWTrsk0raU0jEHXDMw7B+CVjKwSwaJ66K8u57bAeRlG7HZY+bICOYJg2d4B9vOVfJg9IQhmYwfVnVRbJVWKKV9Nl4sjMpq7O/5CzJHM2sYk428iLn5UFs7vBihkJsHLwQKq8WZS1vpfW69+CxRM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4654b24e-9cff-47df-f237-08dc7612d2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 01:43:59.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNptfMBTupt1gyawOj4T54GC/zVAa3bpgHaIaR2XEXphXkdCvbeB+/YZUN5LRlWM7lc/8eVSzQLhpQwtgoKUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11038

DQoNCk9uIDE2LzA1LzIwMjQgMTc6NTAsIEhvbmdnYW5nIExJIHdyb3RlOg0KPiBGb3IgUkRNQSBT
ZW5kIGFuZCBXcml0ZSB3aXRoIElCX1NFTkRfSU5MSU5FLCB0aGUgbWVtb3J5IGJ1ZmZlcnMNCj4g
c3BlY2lmaWVkIGluIHNnZSBsaXN0IHdpbGwgYmUgcGxhY2VkIGlubGluZSBpbiB0aGUgU2VuZCBS
ZXF1ZXN0Lg0KPiANCj4gVGhlIGRhdGEgc2hvdWxkIGJlIGNvcGllZCBieSBDUFUgZnJvbSB0aGUg
dmlydHVhbCBhZGRyZXNzZXMgb2YNCj4gY29ycmVzcG9uZGluZyBzZ2UgbGlzdCBETUEgYWRkcmVz
c2VzLg0KPiANCj4gRml4ZXM6IDhkN2M3YzBlZWI3NCAoIlJETUE6IEFkZCBpYl92aXJ0X2RtYV90
b19wYWdlKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIb25nZ2FuZyBMSSA8aG9uZ2dhbmdsaUAxNjMu
Y29tPg0KDQpHb29kIGNhdGNoLg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPg0KDQooQlRXLCBEb2VzIGl0IG1lYW4gY3VycmVudCBweXZlcmIgdGVzdHMg
aW4gcmRtYS1jb3JlIGhhdmUgbm90IGNvdmVyZWQgSUJfU0VORF9JTkxJTkUpDQoNCg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jIHwgMiArLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmMgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jDQo+IGluZGV4IDYxNDU4MTk4OWIzOC4uYjk0ZDA1
ZTkxNjdhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJi
cy5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmMNCj4gQEAg
LTgxMiw3ICs4MTIsNyBAQCBzdGF0aWMgdm9pZCBjb3B5X2lubGluZV9kYXRhX3RvX3dxZShzdHJ1
Y3QgcnhlX3NlbmRfd3FlICp3cWUsDQo+ICAgCWludCBpOw0KPiAgIA0KPiAgIAlmb3IgKGkgPSAw
OyBpIDwgaWJ3ci0+bnVtX3NnZTsgaSsrLCBzZ2UrKykgew0KPiAtCQltZW1jcHkocCwgaWJfdmly
dF9kbWFfdG9fcGFnZShzZ2UtPmFkZHIpLCBzZ2UtPmxlbmd0aCk7DQo+ICsJCW1lbWNweShwLCBp
Yl92aXJ0X2RtYV90b19wdHIoc2dlLT5hZGRyKSwgc2dlLT5sZW5ndGgpOw0KPiAgIAkJcCArPSBz
Z2UtPmxlbmd0aDsNCj4gICAJfQ0KPiAgIH0=

