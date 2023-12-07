Return-Path: <linux-rdma+bounces-296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03708080DC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 07:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12231C20929
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C7D51F;
	Thu,  7 Dec 2023 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pmmX0wTT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405ED59;
	Wed,  6 Dec 2023 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1701931041; x=1733467041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AJ/4Sh80yy1uV7zE7eghbGYWTA4nBmLKSuenGneOvig=;
  b=pmmX0wTTEp0oqVIlBrxXfb4TRcpOL1dPAljY0mSXSJd0VDWKEkRHqhDH
   DlRSV7gZQyWWrimyFoEi431qQ//i1mOVQzyCClKouxErMUheOQ298JVAv
   WZ8g2dt5nUzZrElBAUgkzsxd12h5VgsUmjnIqbKzjFbNPh5vGklC8hy8G
   4+bxYBsgqqS9pGOqqTUCYnBtW5EsWRte6a4iK7ItOy2oNYQnHiRl9tSZE
   rIc/qpl4Rn7vTJhJmxbH8ytcGAkEM6mUBeE5gQ0h5yNyfoSgVrcNXZA5N
   kHV7GEtCj+U2GT8GHc8/2iNWUAtbf9scjZP+Pco+KyDua2AMqqMFlZ2jF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="16035646"
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="16035646"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:37:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2VNa9pau9dihcVta1ZNVKVI8exQbfgoLocDD5ZlLTqEnXEFU8gdwtkuewQmyZqUZptUIXcD8F9YnXIcf1rVrKLtMJVyXUvUBymLt+nxVvs6KPhOJ4Vm00TridT0JeFZJmo+9U2K+DT0SLbWUjxDOT99O7+gRYzAJCeebM9UYAM+mybPUpwQhMXDJvwDouoIA4he9nMnXFU8eX1DjFp4Hkrm86XTbbSF+5NyQpIPxYIL2wR19juKrFgkP9/pFMP3po/rfZw+uQg8jAwfd/eOhn74nesaUFKfrHdbIkZ3ZMOQKa/rU1GHSleyLqO98t/oCWOGAD6tSrWghD4xx2cAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ/4Sh80yy1uV7zE7eghbGYWTA4nBmLKSuenGneOvig=;
 b=FeznmQZrXG/vVUpg1EaAtfu7vh6hNN/4gltPHPSP01Iib6+v4iMCrama34fOxIuNof+p3SDhcRR+VyovPYeW9ahK4EZ4XA8xEcDAuplrrwHOe9vyMZ79dc3HA6oKvGveulTfZP3BHVLewttogmp2nPJtmsclDmCzqpGSqfQ25hUQpYQvBYH/i3UO4ipeQdknC7GzevICBRZw4wdBNlpS/XfQSKT5kQH9eN2rDfQoNTJc9BuZEIkNN8Rv0y2j3lfRS9kUhGHHzG92fJJIErjsboPYYa3F2noQskrFEeloZ9nK3xg5lgEOdUBBD3O1tXD2+elI3vo3hdr/J4lxjPAOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYWPR01MB9510.jpnprd01.prod.outlook.com (2603:1096:400:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 06:37:13 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::67df:3a4a:c6e9:4a6e]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::67df:3a4a:c6e9:4a6e%2]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 06:37:13 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Subject: RE: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
Thread-Index: AQHaEs/s5mAmNLkVi0evL98pGBTDKLCZ+ZyAgAAbqYCAA24asA==
Date: Thu, 7 Dec 2023 06:37:13 +0000
Message-ID:
 <OS3PR01MB98659C7691D5DFB98D98D2BDE58BA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
 <20231205001139.GA2772824@nvidia.com>
 <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
In-Reply-To: <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YWIwZDJjMmQtYTUwYi00ZWE0LWEzOTEtM2JjYjU0ZmIw?=
 =?utf-8?B?NTYyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMi0wN1QwNjoxMzozMFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYWPR01MB9510:EE_
x-ms-office365-filtering-correlation-id: fe8d4e80-e55e-4384-f97f-08dbf6eef2bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jKq/BcSp1schnO74bM6MHzpCG97KZZePq4wzItV0btjgImk1UIjy1WRqNS3EuX6WUPjCJvgHAjxVZeHLFm+N7uOVWvx5CB4olfcKq3fBq1HCM72gVri399Q9rVJJDvX+hgmAxGpT6LOBKkJ6zme2jrWrVMVBfco6pejRh+ck9fvKaprOr+N2CS0Zd/Mm3b3OFd4Y+0gkxGfoeNByuZt+G75iQdPYmZKaX46dHnunScINAzM0SZfDLf307lMzufyEPiLhgfJEJZEW0gCubl6WXl9ZcvrHk143aElnDpi4gtYH+8i6DyQssYyRFjdyeM+r5LfTndHTikXfFzVvxS6YBc1JmsIyjSAWA8J3P/lbXqLI98dJfk7M1RONDp0/b+Hy8cu9dZpYkzz6xY7RPk42YsY99YKAMcOLQ2S5f/dvKYkwwra0NRmOoYEDqVxnzAoi0ndn+CkYx92dOeSsWX0YjDKui5TeEVW1K2rVD/GB526vB8pCytQlYpvm1iB+j2xrIj55QhbehTXpGm0afb+0tQ7Z8JA8NxbhD/RSdzL31hj+54qmC9NEDqgGVF1CMkFstuDJ3qLGQYsZ/JvzTr8dr4UpA1ti6h9mz6rwV5GAyM1XhxiFxvz2vDmOrLxHlxVulHQhNzhH2lI2mbiYJc4u/NYrbn5fExtkgocn7YkD1Ac=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1590799021)(1800799012)(107886003)(4326008)(86362001)(6506007)(122000001)(7696005)(38100700002)(55016003)(9686003)(53546011)(82960400001)(26005)(83380400001)(966005)(478600001)(71200400001)(76116006)(110136005)(66946007)(66476007)(316002)(66446008)(54906003)(66556008)(64756008)(1580799018)(33656002)(2906002)(85182001)(41300700001)(38070700009)(8676002)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTR3Wm9ZSXVOVk41U1hUV2htR0lpOWhtUEpIekNQWTczeW8rL2hWK3VkdlFV?=
 =?utf-8?B?RlVScTRzOFBmNHlzWE1uMG1ZVjZSY05hZUxmQVM3bk1LYlJUd21zN1VXNCt3?=
 =?utf-8?B?ZDB4emRzNEdJNUNlMmlLeUxmdGxDWFhrZ0JXQVRZSnNTUHlrQnBJZk9IVHJH?=
 =?utf-8?B?Y1YrQUZOWU1xVFp6akZTdW1EdlFCdmp2bVJOQXRhL0QxTHI2b3g3TjE5MFBS?=
 =?utf-8?B?OWpRby9icWY2ckdJaDRwQVBFN0tFVXpTOTZwNk5RZkt2ZnlMVVNjMHlnckNP?=
 =?utf-8?B?bUhkSmdGdmhQRzE5cjJwTUlPL1lKbk5CSDFjT2NiUDZ5MXRkUk9qRDNZL1hR?=
 =?utf-8?B?dkVXNUljdkJaZnAwUnQzbjlJcHZ5b3VmR2NsUkRsUzZUQXNzSy9zVnFIZVRX?=
 =?utf-8?B?eklPeFcvNWVodFNuVGJVSFkwRlhwZ3FwdERacjZiTnpiZXZwTm4xSFQ4NnJt?=
 =?utf-8?B?M0cxZXpwbWV2SU96S2o5Y09KWmJwUVpVdjNmV0kzYTB6bWpTeHBKeTMzalZj?=
 =?utf-8?B?Rk5yTURMenZRdmFINkt0dFV4NHBmTktZaFFFNzhJM2hhcWpVSEhXSzFIRHNl?=
 =?utf-8?B?UVJwZy9pYmVBM1JoUytMWmNyaDdYTk1haE11citYSGNmbzl6a3RTeXhpSVM1?=
 =?utf-8?B?K0VEVTNCNlNNRGNPYXVXMldTZUttUDF1aXFRZ3NPNVNEYUhRSnZNMjZCTnQ5?=
 =?utf-8?B?YnBQbnVkbytWZEdvMXpVaDdXNlBzT1grT2ptMkg1dEM5encxR2pDSkhWUlpR?=
 =?utf-8?B?N0ZyZ3JKZ1dzN3dhOVJzOU5rdzVvblpXRG52MUdua0lCNFNud29ZTHpFdVVQ?=
 =?utf-8?B?aWVrdFU1YTUvR0xwV3o5N1dFa3l0UGs2WUg4dU9vNDVLQ2Qya3A0a0dMZWxF?=
 =?utf-8?B?SEZpQzdNcFJTTDd0NzZNUnlLSWJpcElRTWpHZnZBTVZtWDBhOG41dXpWdnd1?=
 =?utf-8?B?bXUzK0pmc3hVdWQwNnNwU1Z1VmdlTk40eVQrR3dRaG9uMEpocjl6ak8veXlH?=
 =?utf-8?B?RlhENnFxcXZySkpGOU51UHNPU0dkVE1ObGpGQThrdDJqcVhRaS9jVnJTL09U?=
 =?utf-8?B?NERVK3RGV01COEJ5ekp0ZnZpbXVJWVVxTXFaTDZ2ei9JcWRPeitGREc4ajlw?=
 =?utf-8?B?WXVhNW5BakEvZEE5MkxmVTVwbEUyYmZwcHlkRkIzWDZtVWRJaFNMRXBUUk9P?=
 =?utf-8?B?M2JQaU1lOW5Ydml4N0hpdnhtQWh6Mk1PWHNidUFQZ3Y5eGpVN3Q2dmEyMXhj?=
 =?utf-8?B?VGJ3eHJPNFY1WWRpV1RNOTJyb0pXYm5sRHVab0NTdGZ0alZRa1VlWlRoQlVi?=
 =?utf-8?B?Si9PZXdEOXlQbVJuTzBmWlgvcnBheCt6VlRUM0xnZ3NEbGd1c0hJbTF4YjB3?=
 =?utf-8?B?SkpHK0FucllEbFZvT3hMQmNOYktCdkdROFprMGxYbjlNTkxsT3Z0VEsvcWRC?=
 =?utf-8?B?TUpQZ3dpTEl6bmVLVGFOQmRtOU96YkliU1VnQi9vRkhnYnpNVUc2R2hXNjdm?=
 =?utf-8?B?VUxOc1ZOcm96d0xCdGc5MkxGTHBBbnJVZDVHT1o2VXQrUzVFbEtCSFJmS3BX?=
 =?utf-8?B?S3JTZ25EVjArZ1lESXRsTzVGeVdVcnE4OThnU00wMi8wM01OUi9XSW1FTncz?=
 =?utf-8?B?YmdqWHpKa2tGajljckViN0k1S3JZcmR1Qkdvb0wzZUZIS1l3UmsrRmVrWDdB?=
 =?utf-8?B?bjZkQ3hyWW9oemFCeThnbFZ0MFcxcUw5dk54aVNtQzBaak5pYzNKV3pmenN4?=
 =?utf-8?B?QXc4TmgySjhRTjFjOXVGdVpGT0tHKzV0UkNRb25ucUpBK0JVMnp5cUZ2TU1J?=
 =?utf-8?B?YktuNkl6cnZJbG11Y045aUk0dWhKWlV5NVJZQ1ppd3ZpRXE2c2NlMG5jMG04?=
 =?utf-8?B?K0dZQ3A5T1Q0U3JWSis4bm1EcjlkVTJGc2xtTmpqRnl1WGp0UVQvMFc1WGtG?=
 =?utf-8?B?a3Zxb25CaWEwcGFiNm5yUm9pWjltMVpQOU9QU0EwTjgyMythaEoxaGFMdTdi?=
 =?utf-8?B?NWZyRG9WMnZpRWRBZFY3bzJQbStvb1ZKNUtPN2h2blg4T2xNNDF3K3ZTTXRl?=
 =?utf-8?B?U2hYcisvbnZ3djNseUtzYjBxbWdBQUVoUlB6R3NpajJjdDZPcmVxTXAxLy9O?=
 =?utf-8?B?S3VZOHBXM0VaYTAzOWszZzNzeVBPNVdFVlpmczlTME15RlZDU0d2NlEzSG9T?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qGsmQDrmQgcv35JrJDtUhGwtn8GaAqsA0Huy2VKwU4HBWx/SsiO0ENU0y3FYdjfze3OdK3aX2gUyq/ML4svm9k07G6SnXMgYJquIBo/ZHab1N/dq80GxMm97yBQ+F3s2lB6mcPZFRT6NA4OgkgAbxGvXl/fydKjMxnoZi9Tg6WVYMqAYhepUK3F2QoQvzjKaNwZAzcF/Z2UCwSTtZIZ/2bFGSuPoL2XFW2ltMN12zUmjc6WnMxNNkmNNFrJMultmz7cP88p7ddlp6ka3bg9aeuLqJ7TGkJpOJrQc34q2PrWqLlz+hX9qt67pnaYPnhrHaScr+JL89F3V2T5tU0mtSJqj263u4N8iCTeaD2Nxo7J0L2rE3MT4TAw853CLwJPGudJFoVSrJimsN/A9DIxrinTVN9wUn6VkyY7TRex+r6fUFCQFKBwagSGYR+ne2AxYGE1BwxagISgc0OmK4qwmW2XgFckUpCMk90Y+ZDHKejPJvggng7Nsl+CxFlApkHrPR4cr1buzwm2YgZg65Vk9Rq9hdvniaFYOF5qZBDn+xfgd0xBwquQ9ZduTd0w9+pKrDNgtcRFkaFg3t0+GGMky/l0p+zMbJh3gILzIxoOqmeIFTa+Mo112HssoCeqnhnefToA3GI+LmaaQ2kKtALT3gQ+lldYULUwmRgPc8vbcGIzeXmaSr+PfB7uOP8JlMgeXYNpe62ktQE/7CSEAg6wY8LPRq6ay7i1xBSui/ocvuOyBphQ9m8JIfzuKbDfO5pkoEbdu7i1i+jEYbKG+ICCgh8mcD/c2bZBpNDFQdjIklcbOIDV/7ESP4BV9HPd4q49Aekmhb7vY2OdnFzM799D7Ys6tp9h8ms0oZZ/1xT5LS3dL3nuG8y5IqaWBXJelBNLH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8d4e80-e55e-4384-f97f-08dbf6eef2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 06:37:13.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA+GIU2AVU0SmycSWR+tbADVJWYu0sNyhuRQ0g4D2vM6pAkx2bVj90xOQZUq+IyqghtccHOmUt0Hipe6shkMqxxwGx8mPEQT+YsEnYcHxSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9510

T24gVHVlLCBEZWMgNSwgMjAyMyAxMDo1MSBBTSBaaHUgWWFuanVuIHdyb3RlOg0KPiANCj4g5Zyo
IDIwMjMvMTIvNSA4OjExLCBKYXNvbiBHdW50aG9ycGUg5YaZ6YGTOg0KPiA+IE9uIFRodSwgTm92
IDA5LCAyMDIzIGF0IDAyOjQ0OjQ1UE0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToNCj4g
Pj4NCj4gPj4gRGFpc3VrZSBNYXRzdWRhICg3KToNCj4gPj4gICAgUkRNQS9yeGU6IEFsd2F5cyBk
ZWZlciB0YXNrcyBvbiByZXNwb25kZXIgYW5kIGNvbXBsZXRlciB0byB3b3JrcXVldWUNCj4gPj4g
ICAgUkRNQS9yeGU6IE1ha2UgTVIgZnVuY3Rpb25zIGFjY2Vzc2libGUgZnJvbSBvdGhlciByeGUg
c291cmNlIGNvZGUNCj4gPj4gICAgUkRNQS9yeGU6IE1vdmUgcmVzcF9zdGF0ZXMgZGVmaW5pdGlv
biB0byByeGVfdmVyYnMuaA0KPiA+PiAgICBSRE1BL3J4ZTogQWRkIHBhZ2UgaW52YWxpZGF0aW9u
IHN1cHBvcnQNCj4gPj4gICAgUkRNQS9yeGU6IEFsbG93IHJlZ2lzdGVyaW5nIE1ScyBmb3IgT24t
RGVtYW5kIFBhZ2luZw0KPiA+PiAgICBSRE1BL3J4ZTogQWRkIHN1cHBvcnQgZm9yIFNlbmQvUmVj
di9Xcml0ZS9SZWFkIHdpdGggT0RQDQo+ID4+ICAgIFJETUEvcnhlOiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIHRyYWRpdGlvbmFsIEF0b21pYyBvcGVyYXRpb25zIHdpdGggT0RQDQo+ID4NCj4gPiBXaGF0
IGlzIHRoZSBjdXJyZW50IHNpdHVhdGlvbiB3aXRoIHJ4ZT8gSSBkb24ndCByZWNhbGwgc2VlaW5n
IHRoZSBidWdzDQo+ID4gdGhhdCB3ZXJlIHJlcG9ydGVkIGdldCBmaXhlZD8NCg0KV2VsbCwgSSBz
dXBwb3NlIEphc29uIGlzIG1lbnRpb25pbmcgImJsa3Rlc3RzIHNycC8wMDIgaGFuZyIuDQpjZi4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRtYS9kc2c2cmQ2NnR5aWVpMzJ6YXhzNmRk
djVlYmVmcjV2dHhqd3o2ZDJld3FyY3dpc29nbEBnZTdqemFuN2RnNXUvVC8NCg0KSXQgaXMgbGlr
ZWx5IHRvIGJlIGEgdGltaW5nIGlzc3VlLiBCb2IgcmVwb3J0ZWQgdGhhdCAic2l3IGhhbmdzIHdp
dGggdGhlIGRlYnVnIGtlcm5lbCIsDQpzbyB0aGUgaGFuZyBsb29rcyBub3Qgc3BlY2lmaWMgdG8g
cnhlLg0KY2YuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC81M2VkZTc4YS1mNzNkLTQ0Y2Qt
YTU1NS1mOGZmMzZiZDljNTVAYWNtLm9yZy9ULw0KSSB0aGluayB3ZSBuZWVkIHRvIGRlY2lkZSB3
aGV0aGVyIHRvIGNvbnRpbnVlIHRvIGJsb2NrIHBhdGNoZXMgdG8gcnhlIHNpbmNlIG5vYm9keSBo
YXMgc3VjY2Vzc2Z1bGx5IGZpeGVkIHRoZSBpc3N1ZS4NCg0KDQpUaGVyZSBpcyBhbm90aGVyIGlz
c3VlIHRoYXQgY2F1c2VzIGtlcm5lbCBwYW5pYy4NCltidWcgcmVwb3J0XVtiaXNlY3RlZF0gcmRt
YV9yeGU6IGJsa3Rlc3RzIHNycCBsZWFkIGtlcm5lbCBwYW5pYyB3aXRoIDY0ayBwYWdlIHNpemUN
CmNmLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FIajRjczlYUnFFMjVqeVZ3OXJqOVl1
Z2ZmTG41K2Y9MXpuYUJFbnUxdXNMT2NpRCtnQG1haWwuZ21haWwuY29tL1QvDQoNCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yZG1hL2xpc3QvP3Nlcmllcz03OTg1
OTImc3RhdGU9Kg0KWmhpamlhbiBoYXMgc3VibWl0dGVkIHBhdGNoZXMgdG8gZml4IHRoaXMsIGFu
ZCBoZSBnb3Qgc29tZSBjb21tZW50cy4NCkl0IGxvb2tzIGhlIGlzIGludm9sdmVkIGluIENYTCBk
cml2ZXIgaW50ZW5zaXZlbHkgdGhlc2UgZGF5cy4NCkkgZ3Vlc3MgaGUgaXMgc3RpbGwgd29ya2lu
ZyBvbiBpdC4NCg0KPiANCj4gRXhhY3RseS4gQSBwcm9ibGVtIGlzIHJlcG9ydGVkIGluIHRoZSBs
aW5rDQo+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXJkbWEvbXNnMTIwOTQ3
Lmh0bWwNCj4gDQo+IEl0IHNlZW1zIHRoYXQgYSB2YXJpYWJsZSAnZW50cnknIHNldCBidXQgbm90
IHVzZWQNCj4gWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQoNClllYWgsIEkgY2FuIHJldmlz
ZSB0aGUgcGF0Y2ggYW55dGltZS4NCg0KPiANCj4gQW5kIE9EUCBpcyBhbiBpbXBvcnRhbnQgZmVh
dHVyZS4gU2hvdWxkIHdlIHN1Z2dlc3QgdG8gYWRkIGEgdGVzdCBjYXNlDQo+IGFib3V0IHRoaXMg
T0RQIGluIHJkbWEtY29yZSB0byB2ZXJpZnkgdGhpcyBPRFAgZmVhdHVyZT8NCg0KUnhlIGNhbiBz
aGFyZSB0aGUgc2FtZSB0ZXN0cyB3aXRoIG1seDUuDQpJIGFkZGVkIHRlc3QgY2FzZXMgZm9yIFdy
aXRlLCBSZWFkIGFuZCBBdG9taWMgb3BlcmF0aW9ucyB3aXRoIE9EUCwNCmFuZCB3ZSBjYW4gYWRk
IG1vcmUgdGVzdHMgaWYgdGhlcmUgYXJlIGFueSBzdWdnZXN0aW9ucy4NCkNmLiBodHRwczovL2dp
dGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvYmxvYi9tYXN0ZXIvdGVzdHMvdGVzdF9vZHAu
cHkNCg0KVGhhbmtzLA0KRGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+IFpodSBZYW5qdW4NCj4gDQo+
ID4NCj4gPiBJJ20gcmVsdWN0YW50IHRvIGRpZyBhIGRlZXBlciBob2xkIHVudGlsIGl0IGlzIGRv
bmU/DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gSmFzb24NCg0K

