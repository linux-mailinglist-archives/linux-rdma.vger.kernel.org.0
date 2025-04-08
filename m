Return-Path: <linux-rdma+bounces-9222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B208A7F3C2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 06:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59411898968
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 04:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF5020E706;
	Tue,  8 Apr 2025 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6vDclLA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FA206F31;
	Tue,  8 Apr 2025 04:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087220; cv=fail; b=tLY5SU03ZjAffISCRc/X0x7d2zFQxhSJF53aI0Q0Clvyj62Ie9oO8QaG9B8JjaScXeSARN0EHFXzlUMTW+0csmy8OJ52QK59NI7Gxv3zxNzwjP4LiqDGTgLcpcb0OP/QBvKyb72Mn+Yb67i93s2Z03Pr+U0mpAlA7C6WEHP5rwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087220; c=relaxed/simple;
	bh=TgyBOWkeSRmvnCZlKeCTEqHbZFsd9tCpjm1NlcpmX0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VwyqtwJHcDGqv6ZmSD6IYK5tENNgSBRaJMxQSsPNt+VOCrHZjuuO+BlGJ58Rmim6beH7cw+80uG5ZK/MoNp/DDxdukrPHsp6Vq0SAE6Lh15KlPqRc+jbLw5gstHCb/Lxpj1Al8CHmSuKxhqkKSdDAP5kMTJ/qQ5e4/WUNa7So+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6vDclLA; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxOsK4OMdK29mKC5CndtplakYV5eBHUxV7wYcLF7rtNqd3/bQtcy6NR777EpLdgWE/xvoAsmab6z7U/VoyYxQLYIf0RAjgllkb2Z4qLG2NQx98mP0H8qTqntmBnihnEGnVE0YR96kImpSY8v5gijq4d202MT++qENkG7NefJDRqlhdDAzneiaPJ4jmtIuPnVnE/4a/iTPqUhVMihpSPBeYmk7cjnmZC9mD3BISVQaFjqohfLVzhuEUYnMOkzgUnTzd3sEEyzEWfD5UomXFR9w45LFcHbegiekwdPgTReAVGY8jUmooHAHV9CcWsj/4PT1T37z00IJ8rAW8gyFdM1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgyBOWkeSRmvnCZlKeCTEqHbZFsd9tCpjm1NlcpmX0Y=;
 b=TSwOPYkp2BpRAV5OHrZA269DyHlBvhJdwVxvD6LvTzfLFdwi6hdQoqcORGLxhhai/gsFu3w8Hp7Mlwzb4s5cVmRVyLiJZaK95IqpefaCmIa0SB0M3hU+GRK57ac6KZ46HjvOiW37Ot3Ep7TA6Ht66vpCR6sivOni1ET939IpN0vYitEexH2/MoaTNcT+s0OJcda7B3C+zpzBas7qEga3rDa0VBKfgzkEnKjwkUKgu8qPY7jOl8kvL7/Gshz7pdhezN5E0hxc3U/7mSBGdtjLTQZk2WmnAW21nEsiX9881if87QGsGWtdss/YiVcmpvjPssG9watViSoTdV3TEGIZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgyBOWkeSRmvnCZlKeCTEqHbZFsd9tCpjm1NlcpmX0Y=;
 b=Q6vDclLAe4TZ1Xez8li46HqnNZ7ADKv6eiMthSk/Ta8m+F2+0Ju5klMMI+3BjT3OE8yZzEtJrhrDg/PDU4r0UpAdGSlN/Ju/eL9zXq1c9T1l9cymadwWgToZOZO+rHPqWF403KMVwfvJrVfVYxDKK/tvZulDBezpHq/uY+0duF9K94a1qqau7REixO/wYFIOf3kwMbf0aIOW5p9wZ2JyAHlyL2WhpYgyfufefo3mfuUx3Wp9Rm33LksSmDugluPJONFkafKuvbILiPIxPGlvpokQxG557EVPNxYvP7nYG1wRad8erOrc0AVsyR61snfm3bC4fjmF1emEiUjKPgXlgw==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Tue, 8 Apr 2025 04:40:16 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 04:40:14 +0000
From: Sean Hefty <shefty@nvidia.com>
To: "Ziemba, Ian" <ian.ziemba@hpe.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6TwgABCwQCABHrAgIAAgVrAgARv/wCAAGo9AA==
Date: Tue, 8 Apr 2025 04:40:11 +0000
Message-ID:
 <DM6PR12MB4313C577073C5ABE1507401BBDB52@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
In-Reply-To: <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|DM4PR12MB6304:EE_
x-ms-office365-filtering-correlation-id: beff2d3c-d445-48c1-1f73-08dd765772c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2hMZG10OUE1bGNuZmlxM0pMdjBCeGY4SmhGVW5lL1NtQ2x1UC9oeUtORmdQ?=
 =?utf-8?B?Mi9uRGhmd2l3cDVCMnBDNjdDWWZxbW5yZkxrSGJWdHNPaEJSbkVUWkxwTjV0?=
 =?utf-8?B?cktaMGhMbXFFcGEwNjZQeVRXWnFBaDNiRHBOS3pwMFplMExjSy9RUFMyQ0o0?=
 =?utf-8?B?WSs1TEZBMGlNWGZhVzlWR1U0eURDSndXNWdlY0hQY1RCaGVtbTBzekJTN2p3?=
 =?utf-8?B?UGxQRnRFM1NjeFZ3YWdEMmI2WDEraUg4VkszUm9jdmpzMEFQYWdtVkdGYzFv?=
 =?utf-8?B?dkRlNG03TkRxQjNHU3ltTUcvQ0k1N1ZMV01NaWMzNzUyNk92QmRORTZ5bE9v?=
 =?utf-8?B?YTdsb3JrVWJzQ1dRUUh3YjIwc1FDbThzVkNZQldSelJBSTNaMExpcjc5a2xm?=
 =?utf-8?B?N3JEMWF1S1BNeGljakxLN0RHNEVXVXFjSHdOb29HQUV1QWF4YWpOeUp5Ujhr?=
 =?utf-8?B?djNva3NabG44d2ozVkI0amNTUlNhT2Z0T2g2Y291T1dWTEhlemdMUUozVFJm?=
 =?utf-8?B?QklpQW5ZU1FGVDBnMWRWa0JidjMwNXBaTDlzSnVoRTUyOTBSUExzYnVkS0hm?=
 =?utf-8?B?d2JPMFNMQk9rRENORzdNR1hCelZwNmtRaUxUMXh2WWkrbFlQU0JQTWc0bmho?=
 =?utf-8?B?TGI0cEtiNHd6THBxMlRjZy8rdWRGUWRkZE9zY0dXOE1IeGZYS0daeGNpbEJh?=
 =?utf-8?B?dCt3dWlzTW9pL2JjY1BvT01xMk82bUxoWXQ1QzlENktCdUVjd3daUGJtdEdo?=
 =?utf-8?B?QlZUamw2aDNRTG8yZjhyZDF2ZzRrRzMzN09oUXFzZFpVNmxzaEI0WFljeVc3?=
 =?utf-8?B?Q3JvbjNDdDNiZHA0cHg1d3FxOTVVZDR6UE9VYjhXVTJNVVhuZTFNd0FNRTNs?=
 =?utf-8?B?VW1PREpsRTVqU25aaHB3VGJSaWRtVUR4eTVvNTdOVlZyMmFLQTRDcERKZEd4?=
 =?utf-8?B?aUpDb1ovRWxJOHY1aFd5ZG84dEpjTW1BTDlnSDlFaWlBdXppamZBNHM0d3U3?=
 =?utf-8?B?ZzlLRHdVUzF2MzBNNFo4OGJVNCtvRW8wNWdIWGVHUlQ3bGUwK01PZm5ZSGNZ?=
 =?utf-8?B?Yyt4YTFRMmtqUlN4blFqK2gxbjhacUd3Sm53SkVGWUU4TWlCRGhXY3orcENS?=
 =?utf-8?B?NlNVWnpWT0xPenNaK25aUkJVcUZvOXJUcjg0dTNMaFdCcXhNK3d0TndQRjYw?=
 =?utf-8?B?cDQzVUkveC9xYkR0cEJMalpUNVlZaTgra0tjTG9EenBBVnJIblB3SjdpOEVu?=
 =?utf-8?B?NVNqSUdXMlpncyticnJMMmEvMCtzU0pHMmpGQ2JrQjRWd2JVZ00xV3dqMW8r?=
 =?utf-8?B?K0hiU0JFUDh2d3RFVXFYRVRqSERHU2VoQ3ZVcVRHOUVzTWVKUCt2eHlWbGta?=
 =?utf-8?B?Z2FTdjhkamdKTC9sNjh6L3NGSUtEdkhqcFJJVHlZbFVHMi9CNFA1VFNSdm5w?=
 =?utf-8?B?cWVsbTREbkZTekRGQjBmOVVmbnVha3hibXQrZHdNOVFSaUdTOW5TUU1PNDE3?=
 =?utf-8?B?dUdRV2MrT2h2Y2RMVG5aS05KUVg0S1Z1QUloOVo1NDA3SXFVODF5bVNCZDZh?=
 =?utf-8?B?QkNPYnpSc0RGUWJ2YzRMU2RkZ002Q0lWanZyLzFrTUZlWFJERVYrZkt6R3Fz?=
 =?utf-8?B?ZFVtNTVLeU5RQ3BsNnRrSHR1aForWEhKMUxCRFM2aDdUWk4ydlZPcHZDSzBu?=
 =?utf-8?B?aTdyR0UyY3RuN3FTNWhwVnJnSjUrWlFRV3I1SnpxcVEzY3laOVR5MmZuWjVR?=
 =?utf-8?B?anVqbTQ1YUJHdTJWSGlkYWd1ZWRrZzZYc255ai9lb3hBcS9qVnZOMWRjN0t0?=
 =?utf-8?B?SVNnM0lwRkNqSU05VkFlYUVXWmJCaDM5NFlWNmhmWG5aK2gxSDZMbE5QdEhM?=
 =?utf-8?B?dk1iREdwNWpNWVlkMmh5bDBobzJHU3BxRDJLN3BxVUxJTVZWQzZDSnlPanBl?=
 =?utf-8?Q?LA5GtZgr8WrQj8i+EMBmljdlHNa08xRq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2Z3alpkalYvd3FNZWRRVjlUM2I5dFlFVFR6STdsbFhKYmlva09MbVJ5Qnpx?=
 =?utf-8?B?QmRyZkYxbDdFb25JbXh3dGFlV2FvbmMxaG9qMEJYUU9WejJESXVxU0xQdmR2?=
 =?utf-8?B?dTFvd0RUUHhzT3gzbzJKS3lHVytWTFN6dWdVS0hwa0x5N2JVYmRsMXc2NENQ?=
 =?utf-8?B?Q2RMNWJaZUpyQUozUTBmcThLSTA4UHZSZlBwQ20xem8vZDRMaWZwV1ZGYUZP?=
 =?utf-8?B?THhqNWpYQU1jRC9PTHZFT2JnR1RHWm5JN3BNQzlxcDdIV0ZZdG52eWxONGNk?=
 =?utf-8?B?OGlYUGlwWjZrRTdMSE1LUGhGc2ozTFpaRHc4OUoybjA1Qm5CMUcvenpUazdU?=
 =?utf-8?B?TnNUU3F6NWsramw4QTVyT1IyckNyYXdhUks3QWJkN0hyUnR5VDlEVG41cnhl?=
 =?utf-8?B?YkF0MTg0MEJKa084aHJJUi9vaUl5VnZ0c3J6anhOWDJkcGFCVlZiV1BReXg2?=
 =?utf-8?B?Umx3T0YvY0dIZTFmZ3ZLYWpwTHJRV0x2ek9yL2xick5Xb1ZiUmFnVWlvNFR5?=
 =?utf-8?B?L1gxakx1ZG92eExaZDgxY3dzV0ZveGIxZnhTRGtnQUlTejJ3VkZGSGhSUy9Q?=
 =?utf-8?B?WUo0VlJ3emZLVWxldzQzZFpKRVBaV09neXlYMlhkN1VOUE1SVE5zWG1zZDFL?=
 =?utf-8?B?dUhva1dqTHl5TFM5OGtiOG1IZUdaMHFtdUZqWXpDdzlhQlNkVHc4YjV6QkJk?=
 =?utf-8?B?M0loVlVPQ3ZSNFB4MW5VV3N4cFZpMTk5WTJCUzcrZW42dDhIMFJuTlVVNkNR?=
 =?utf-8?B?eXRHTkcxZUliVEFjUE5hTGFpcWxwaTQyeG1RY0dLWm5zUGozNnQ2T1dQVk45?=
 =?utf-8?B?bHN1dHRzcWZhREJoQk9HbkFqRmNaWkUwUXQ5d2tsSXNrQWtNSmE4eHJHeXNY?=
 =?utf-8?B?WDR1M1dtcVphRUZ5SlN4WVBCMDB1am9vdjBqZjZVcXNHRzRBa2V6QjFUa1Jt?=
 =?utf-8?B?ekhCc2E1NmpxMTNtNSs5bTd1VnhLdE82aFA1RVJkbjNHRkpod3NWM1J0RlE1?=
 =?utf-8?B?d2hTemxjakhjRWdxU1BEQmlxcDZaRklKU3dWMEUvRWpHVzRFK2xiZ0dwUDlQ?=
 =?utf-8?B?L1pFZzZiT1MyOXFPdFhnSGxyWDhsTUlKcGNFWGtUUUtHVEdLM1p0WGdHZExE?=
 =?utf-8?B?cXBMWmROZld5N2JjQWxnWHJVdWx3dmVOTzd2R0xkb08rWTdxUXhxOERiU3RE?=
 =?utf-8?B?dlEwRXhSL3orU0dBSlR4VHBVVlJRb01zcE1jSkhvN0pra2xLYmRWNHNBRGR5?=
 =?utf-8?B?NU8zc01yaC9KcjVGNTIyQ250Sk1jRXVIeDlBMHRlTUo3dUc2aG9GUmc2YzM1?=
 =?utf-8?B?MFRGKzU1b0FJckhGTUQ3ZWxiMDBJQmkrSlRpVUhHRmxtR2F2YWFiVXUwZlpX?=
 =?utf-8?B?andzanlSbGZGTEY4aStHbW9zY0tjcmRDRXBGNlJaZ2ZraTZaU2xTRnZsOEhY?=
 =?utf-8?B?ek10NGVVd09yckZRdDF5WVhadGdXVHhRWldJVDN6WE9aUGtHSVNXWkFJTXd6?=
 =?utf-8?B?alhrYS91bEJENWd5RGViZ2ZQNlVURkMyV2R1alRTc2x1ajlHOThwcnBCN2JQ?=
 =?utf-8?B?enR1ZnlHTDY5NHBmRHlkMkc3ZjZtMi9GQmR5OXZaK3l6N2o1ZWhVWm9kbGlw?=
 =?utf-8?B?bzFLdTZiZ0ZKUkNRQm9jMVVBS1ZpQldXSTVNYlcyU2VQS3VFR21sMTlNQWt1?=
 =?utf-8?B?NHhMcmVHUmh5UGhvRE15cDVEZ0RYM0MwYUpLRFF0MjlXdjJMNndPUjIxQ29B?=
 =?utf-8?B?TTRoQmRyemtHOUVMZ1k1c2x5aGM1N1ZyQ0w0VUVkWGh2MFF2LzNKM29aQWtD?=
 =?utf-8?B?ZE1QT1hxOUkvODVPV2laMmpWTk5MUnFkWkpSVXVDbmtQMjRSSStmSmx6RUE1?=
 =?utf-8?B?N243VjF4Z3h0ekZwZytGVzBPMnQxYWhZVVhRK0RnM0J5bEFtNy8rN3U0aTBi?=
 =?utf-8?B?N3h5dCtxQzRoT3BzZEZ3bDNad1JJWlVEVDFKNWs1SXZlY3hRL0N1c3EyNVpx?=
 =?utf-8?B?dEtCc3FyT2d4dVBFZDJUSkd6THJNZU83WEhEdkN0ZURVZWFqQWpsTHlSZ25S?=
 =?utf-8?B?VjNoZjRTY1BEdm1PaU1udk9hWXhQU20wRjNtd0RMN1FCMlpNamRqcFVpWXRY?=
 =?utf-8?B?VEhzcjBVcTJueEt0WVR0VzU1SlVKQ0JlL0JFVnpVWGcrQ1dpWEpJMHd1ZmpT?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beff2d3c-d445-48c1-1f73-08dd765772c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 04:40:11.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCuMyQq79h5FE31r8ASQdrfUKgzMOxUQIuJMtKMurQXoI45uHKOtB6C3+UtuPdealNhM63Su1lQRjOSeAzb4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304

PiA+IFRoZXJlJ3MgYWxzbyB0aGUgTVIgcmVsYXRpb25zaGlwOg0KPiA+DQo+ID4gSm9iIDwtIDEg
LS0tIDAuLm4gLT4gTVIgPC0gMC4ubiAtLS0gMSAtPiBQRA0KPiANCj4gQ3VycmVudCBVRSBtZW1v
cnkgcmVnaXN0cmF0aW9uIGlzIGNlbnRlcmVkIGFyb3VuZCB0aGUgbGliZmFicmljDQo+IEZJX01S
X0VORFBPSU5UIG1vZGUgd2hpY2ggc3RhdGVzIG1lbW9yeSByZWdpb25zIGFyZSBhc3NvY2lhdGVk
IHdpdGggYW4NCj4gZW5kcG9pbnQgaW5zdGVhZCBvZiBsaWJmYWJyaWMgZG9tYWluLiBGb3IgcmVt
b3RlbHkgYWNjZXNzaWJsZSBVRSBNUnMsIHRoaXMNCj4gdHJhbnNsYXRlcyB0byB0aGUgZm9sbG93
aW5nLg0KPg0KPiAtIFJlbGF0aXZlIEFkZHJlc3Npbmc6IHtqb2IgSUQsIGVuZHBvaW50LCBSS0VZ
fSBpZGVudGlmaWVzIHRoZSBNUi4NCj4gDQo+IC0gQWJzb2x1dGUgQWRkcmVzc2luZzoge2VuZHBv
aW50LCBSS0VZfSBpZGVudGlmaWVzIHRoZSBNUiB3aXRoIG9wdGlvbmFsDQo+ICAgTVIgam9iLUlE
IGFjY2VzcyBjb250cm9sIGNoZWNrLg0KPg0KPiBJbiBhZGRpdGlvbiwgVUUgbWVtb3J5IHJlZ2lz
dHJhdGlvbiBzdXBwb3J0cyB1c2VyLWRlZmluZWQgUktFWXMuIFRoaXMgZW5hYmxlcw0KPiBwcm9n
cmFtbWluZyBtb2RlbCBpbXBsZW1lbnRhdGlvbnMgdGhlIG9wdGltaXphdGlvbiB0byB1c2Ugd2Vs
bC1rbm93biBwZXINCj4gcHJvY2VzcyBlbmRwb2ludCBSS0VZcy4gRm9yIHJlbGF0aXZlIGFkZHJl
c3NpbmcsIHRoaXMgY291bGQgcmVzdWx0IGluIHRoZSBzYW1lDQo+IFJLRVkgdmFsdWUgZXhpc3Rp
bmcgbXVsdGlwbGUgdGltZXMgYXQgdGhlIHtqb2IgSUR9IGxldmVsLCBidXQgb25seSBvbmNlIGF0
IHRoZQ0KPiB7am9iIElELCBlbmRwb2ludH0gbGV2ZWwuDQo+IA0KPiBUaGUgVUUgcmVtb3RlIE1S
IHJlbGF0aW9uc2hpcCB3b3VsZCBsb29rIGxpa2U6DQo+IA0KPiBKb2IgPC0gMSAtLS0gMC4ubiAt
PiBFUCA8LSAwLi5uIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gMSAtPiBQRA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgfC0tLSAxIC0tLSAwLi5uIC0+IE1SIDwtIDAuLm4gLS0tIDEg
LS0tfA0KDQpJTU8sIGpvYiBzdXBwb3J0IHNob3VsZCBiZSB0cmFuc3BvcnQgYWdub3N0aWMgYW5k
IGluY2x1ZGUgY29ubmVjdGlvbi1vcmllbnRlZCBSRE1BIHRyYW5zcG9ydHMuDQoNCkkgbWlnaHQg
aGF2ZSBlbmRlZCB1cCB0b28gY29uY2lzZS4gIFRyYW5zcG9ydCBoZWFkZXIgZmllbGRzIGlkZW50
aWZ5IFFQLCBNUiwgYW5kIGpvYiBvYmplY3RzLiAgSSB0aGluayBpbiB0ZXJtcyBvZiB0aGVzZSBt
aW5pbWFsIG1hcHBpbmdzOg0KDQpRUE4gLT4gUVANCnJrZXkgLT4gTVINCihhbHNvIGxrZXkgLT4g
TVIpDQpKb2IgSUQgLT4gam9iDQoNCkl0J3MgYW4gb3ZlcnNpbXBsaWZpY2F0aW9uLiAgT2J2aW91
c2x5LCBRUE49MSB1c2VzIG90aGVyIGZpZWxkcy4gIE1heWJlIEpvYiBJRCBpcyBhY3R1YWxseSAn
cGtleScuICBFYWNoIHZlbmRvciBvd25zIG1hcHBpbmcgdHJhbnNwb3J0IGZpZWxkcyB0byBTVyB2
aXNpYmxlIG9iamVjdHMuDQoNCkxpYmZhYnJpYyBzdXBwb3J0cyBib3RoIHZlbmRvciBhbmQgdXNl
ciBzZWxlY3RlZCBya2V5cy4gIEkgZG9uJ3QgdGhpbmsgdGhpcyBtYXR0ZXJzIHRvIHRoZSBtb2Rl
bC4gIElmIHJrZXlzIGFyZSBkZXZpY2UgdW5pcXVlLCBya2V5IC0+IE1SIGlzIHRyaXZpYWwuICBJ
ZiBya2V5cyBhcmUgbm90LCB0aGF0J3MgYSBmZWF0dXJlLWNvbXBsZXhpdHkgdHJhZGUtb2ZmLiAg
U2ltaWxhcmx5LCBhIHZlbmRvciBtYXkgc3VwcG9ydCAxIGpvYiBwZXIgUVAgb3IgbWFueS4gIFJl
Z2FyZGxlc3MsIEkgc3RpbGwgdmlldyB0aGUgc2VjdXJpdHkgbW9kZWwgYXMgZmluZGluZyBhIHZh
bGlkIHR1cGxlOg0KDQp7UEQsIFFQLCBNUiwgSm9ifQ0KDQpUaGUgTVIgYW5kL29yIEpvYiBtYXkg
YmUgTi9BIGZvciBhbnkgZ2l2ZW4gdHJhbnNmZXIgb3IgY29uZmlndXJhdGlvbi4NCg0KPiA+IFRo
ZXJlJ3MgZGlzY3Vzc2lvbiBvbiBkZWZpbmluZyB0aGlzIHJlbGF0aW9uc2hpcDoNCj4gPg0KPiA+
IEpvYiA8LSAwLi5uIC0tLSAxIC0+IFBEDQo+ID4NCj4gPiBJIGNhbid0IHRoaW5rIG9mIGEgdGVj
aG5pY2FsIHJlYXNvbiB3aHkgdGhhdCdzIG5lZWRlZC4NCj4gDQo+IEZyb20gbXkgVUUgcGVyc3Bl
Y3RpdmUsIEkgYWdyZWUuIFVFIG5lZWRzIHRvIHNoYXJlIGpvYiBJRHMgYWNyb3NzIHByb2Nlc3Nl
cw0KPiB3aGlsZSBzdGlsbCBoYXZpbmcgaW50ZXItcHJvY2VzcyBpc29sYXRpb24gZm9yIHRoaW5n
cyBsaWtlIGxvY2FsIG1lbW9yeQ0KPiByZWdpc3RyYXRpb25zLg0KDQpJIGRpc3Rpbmd1aXNoIGpv
YiBpbnN0YW5jZSBydW5uaW5nIG9uIHRoZSBjbHVzdGVyIGZyb20gYW4gaW5zdGFuY2Ugb2Ygc29t
ZSBqb2Igb2JqZWN0LiAgVHdvIG9iamVjdCBpbnN0YW5jZXMsIGlkZW50aWZpZWQgYnkgc29tZSBv
dGhlciBzY29wZSwgY291bGQgcmVzdWx0IGluIHRoZSBzYW1lIGpvYiBJRC4gIChFLmcuIGVhY2gg
cHJvY2VzcyBoYXMgaXRzIG93biBvYmplY3QuKSANCg0KSSBsZWFuIHRvd2FyZHMgZGVmaW5pbmcg
YSBkZXZpY2Ugc3BlY2lmaWMgam9iIG9iamVjdCwgYXNzdW1pbmcgSFcgcmVzb3VyY2VzIG1heSBi
ZSByZXF1aXJlZC4gIEpvYiBhdHRyaWJ1dGVzIGluY2x1ZGUgc2VsZWN0ZWQgdHJhbnNwb3J0IGFu
ZCBhZGRyZXNzL0lELg0KDQpJcyB0aGlzIHN1ZmZpY2llbnQgc2NvcGU/ICBJZiBhIGpvYiBtYXBz
IHRvIEhXIHJlc291cmNlcyBhbmQgaXMgdXNlZCB3aXRoIHRyYW5zcG9ydCBwcm9jZXNzaW5nLCBk
b2VzIGl0IG5lZWQgcHJvY2VzcyBpc29sYXRpb24gdGhhdCBjb21lcyB3aXRoIHBhaXJpbmcgaXQg
dG8gYSBQRD8gIE9yIGlzIGl0IGVub3VnaCB0aGF0IHRoZSBqb2IgaXMgcGFpcmVkIHdpdGggdGhl
IFFQIGFuZCwgb3B0aW9uYWxseSwgTVI/ICBJcyB0aGUgY3JlYXRpb24gb2YgYSBqb2Igb2JqZWN0
IGFsd2F5cyBhIHByaXZpbGVnZWQgb3BlcmF0aW9uLCBvciBpcyBvbmx5IHRoZSBhY3Qgb2YgYXNz
aWduaW5nIHRoZSBqb2IgSUQgcHJpdmlsZWdlZD8NCg0KVGhpbmtpbmcgdGhyb3VnaCBpbXBsZW1l
bnRhdGlvbiBvcHRpb25zLCBzaW5jZSBqb2IgaXMgc3BlY2lmaWVkIHBlciB0cmFuc2ZlciwgaXQg
c2VlbXMgZWFzaWVyIHRvIHZhbGlkYXRlIHRoZSAnamtleScgd3JpdHRlbiB3aXRoIGEgV1Igc2hh
cmVzIHRoZSBzYW1lIFBEIG9mIHRoZSBRUCwgc2ltaWxhciB0byBob3cgYW4gbGtleSBjaGVjayBt
aWdodCB3b3JrLiAgT25lIGFsdGVybmF0aXZlIGlzIGEgamtleSBsaXN0IG9mZiB0aGUgUVAuICBP
dGhlciBvcHRpb25zIGNvdWxkIG9mZmxvYWQgbGliZmFicmljIGFkZHJlc3MgdmVjdG9ycy4gIEl0
J3MgcG9zc2libGUgdmVuZG9ycyBtYXkgaW1wbGVtZW50IHRoaXMgZGlmZmVyZW50bHksIHdpdGgg
ZGlmZmVyZW5jZXMgc2hvd2luZyB1cCBpbiB3aGljaCBNUnMgYXJlIHJlYWNoYWJsZS4NCg0KLSBT
ZWFuDQoNCg==

