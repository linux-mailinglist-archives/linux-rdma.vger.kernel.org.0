Return-Path: <linux-rdma+bounces-5361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8999838E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 12:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CCB1F2282D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197AC1BE251;
	Thu, 10 Oct 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TzPnA9AN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BD1B78E7;
	Thu, 10 Oct 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556182; cv=fail; b=tBrtwg89J4oDZSQKwbRboSkYJJSo0alvLMhgn3QLOrkKTGHtGxBoDiRPQ57dlRvDTbRJ5fwk0rk2atUEk32MYRrxITR5nSftWgKe6vn68LPUWoGTExBlg5ln2GDptI8h+acD+DPJ6rf8ua6si/fcJrn+vtZAxTgWApGsOHXu9Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556182; c=relaxed/simple;
	bh=idyMEr1QnaSqG2ccXFK8AlmG/jcbq4v5rpgljgkl2CY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fijIYV9gDhmfiX0EK/JM3co/1RF1vY8xPorOnxzYkWnFWxDZCcWLTC+BZ2Noeg8ZhxbQYvi9ElQ0GQvqlGdXNBdYAp+ocrvEVTKsDGdsdD6pnpvA0PWIgTKOIxw7JZ+iunu81nVQXeMkQiVOAtdSLAVRJmeyIY3eXwwSDLfUqEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TzPnA9AN; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1728556180; x=1760092180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=idyMEr1QnaSqG2ccXFK8AlmG/jcbq4v5rpgljgkl2CY=;
  b=TzPnA9ANl8zdPfIOR1qRzIoQw72i9dnmED8c6uPnY4JtzRvlBEiD1B6X
   aOhNNwVb/zhnMC1FY8DEqYEumoWdz1SGYM7/z2ehg+nTdrVB4mGBgAJfb
   uYPG/jxD2OnP42aceHb/O+kdBVd/bjqAXap7gmqsRfx/cSL3kGtcga6+r
   biHxeWivuys/1aiiL8bGNv3URRLwiGGfbCCETnQ+oomlPbLPsWPBqul/k
   yVs+He4cr6RtEvhrI8cWFylx/6UW57ypPQ41l1G5jV67iSuvoPhSa7IFR
   +6De4oougJlFZs5wmXYNB15WgD94f/43yvcoabWNpGveC9ugtyoZDyULk
   Q==;
X-CSE-ConnectionGUID: tlrFJng1TNSp996cAWcm0Q==
X-CSE-MsgGUID: vdatProKQnShjTl0Y8eCUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="133099341"
X-IronPort-AV: E=Sophos;i="6.11,192,1725289200"; 
   d="scan'208";a="133099341"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:29:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIaM0P4WTEVev4sTuvrbxGbCdZMPPbAZoQBgU+KkQs9CgC3NKjq7RP0VuNPrsfeD6nvxwhhe8++BE3k+8ViIH7pYTsbyQ3mlXH2wiPINLMfYCo/LSZD/BDUf5uthAtDYmxa9e9+nIHUYcucx2YLD/Prd+H/8j8RqHUv0mobdN0f5ZcGQvcX0oNo8biEMz7DWxzhRUe+ErQSYTUM8KRwXJzjTh+RCIDj/RiiSO8HkDg3wz8QoDVCo1n3HxT/pyWjEFHmv6sb7dMXNCQppJIEgx05EQKq5j13U4nHPGlUoRbDxoGjoJyi4kdB8XYPyCccChk6OhhoOUjrxia3OcIztpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idyMEr1QnaSqG2ccXFK8AlmG/jcbq4v5rpgljgkl2CY=;
 b=F3WmNuTeJADTw4TEt+53pn43atxLtD4wGPNSvaRAz1gGTO+Wzvyqxc35IwoAYd5wofiRmYSa44+h283SPg1yy4U4sEisOBm5xAsZ5kxNIyKB///yzHhAPswxoa1thUX8CVZI4L758edYy1FBTCFSSlxjeFvxXrw2aTyWbH7GYgG49U/BY2q3vt2LEZl8gAbP45d7ljSw4kSOnVT+GDWEPgsnOFxjVyiFW/Bb9AdMcF0UUoZe2jV4DdAwOFYrL7WclmTv25a05OIfA+ekxwUdnTHfLkR9vLaWPI5rzP6DZPReuhc1pm+88iMPmkRuQh5TLoungq3QBU1i5GY7Jzu4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS0PR01MB6180.jpnprd01.prod.outlook.com (2603:1096:604:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 10:29:20 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 10:29:20 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, 'Zhu Yanjun' <mounter625@163.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "leon@kernel.org"
	<leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "Daisuke Matsuda (Fujitsu)"
	<matsuda-daisuke@fujitsu.com>
Subject: RE: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
Thread-Topic: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
Thread-Index: AQHbGe7dxzAlCRK8qkOdYdUUXbPCsLJ+duEAgAEWJACAACnDAIAAC+RA
Date: Thu, 10 Oct 2024 10:29:20 +0000
Message-ID:
 <OS3PR01MB9865A2D1620C8F7D88802782E5782@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
 <67b556bc-2d48-4e7b-a00a-6b38512c8e8f@163.com>
 <OS3PR01MB986550BAFCFA30D409F5A089E5782@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <753c0fcb-0c6f-45a1-b132-4411c87374d3@linux.dev>
In-Reply-To: <753c0fcb-0c6f-45a1-b132-4411c87374d3@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YjA0NGVlM2ItZDgxOC00MzM2LTlkYzYtNTUxMjY1NTA5?=
 =?utf-8?B?M2ZiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTAtMTBUMTA6MDA6NDNaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS0PR01MB6180:EE_
x-ms-office365-filtering-correlation-id: cf3a1dd1-ebe6-4438-7293-08dce9166719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R09DV0dKaW1WN0VqWnF3c1RBWlNPaDEvaTRqaHRSY0hJSDcxR3l4eXVQUVo4?=
 =?utf-8?B?ZlI4WWtWdEZxMEtneTBOVW13VjVRSnVZZkNNaXJLK25MWDYvUlNvdFRLSEFT?=
 =?utf-8?B?emY5TDE5U1Z3NG1RVC9rU2xRT2RxWWhrdXhiNGdWR1l3cHVTK3YvV2R3TWEv?=
 =?utf-8?B?bjBRZHVVNHpzeDJSMGNKV1lzQkxpdWR3U1ppYk1sVXpUK3Ryb1hScEFUTzNj?=
 =?utf-8?B?aTVWdDMxbWNyb0ZCbmtJeUxBRkV0bFM2UGk4Kys3UlRiRjFJblkzaVpLWE9F?=
 =?utf-8?B?VXNXRzllTHZGZkFDTmJaU0t5b2ExSHhUcTI5N3Juc1BGZmxjeklKTllaL3VJ?=
 =?utf-8?B?ZjhFT3BON1hiVThCa1JyTzJ6b2U5UUFNZ3lMeWM4V0V1L2UrMThtSjU4bnMv?=
 =?utf-8?B?bDhqTjVxdVFkNEUvQjZwMXg2K2ZLNkxRWGJROUF2d3RIU2w2cjZ4bStqQTRi?=
 =?utf-8?B?aVdyVWZiVGtNMXd6Smp2RFJmOGdoQUk5U3JYT3Z0WkNDV3NCOW4zckd3NXl6?=
 =?utf-8?B?ZGZHNkdleFVBdGNVRERNSXkxZjVEdGFFcGZma2NGMkQwWGFpZ1BrTzhFL1BT?=
 =?utf-8?B?NWpPdWlLeVFveitWOCtBcFdHUFNDSnFQSVd0b2JaWUcrU3ZMdUJqZHJUZXAv?=
 =?utf-8?B?MkwzR3BoVW92OG9DRU81Z2xCNmNOeE1LaThDT3FpQmhGNVFCRkpSNmhjRTRH?=
 =?utf-8?B?Z1llQkdCUWJBcDJwQ2VvQ0swV1M5VkJmbi8xS3ZIUTZ2MVNDc2pLNnQxWThx?=
 =?utf-8?B?aVNidE14bEhKRktZRFlGdUdtUjUwbE40WDR2cEhJS3dEUVVWckhnQTk2Ni9j?=
 =?utf-8?B?WDliZzlhV0kxWFJyQVd5Mkl3VURrbGJZdll6R3V5SHY5U3BjTndycHFoU0Nm?=
 =?utf-8?B?dUhaTkx4ZUNSYk9qVG0yMXhrbTRtRmE0U0hPYVIvMG0rOURSaDlQd0VCbWgw?=
 =?utf-8?B?aDBTNFpGVkxCbm9FNVBYYXFxa000elBYYnFTRk8rSjRyOWpiakc3THdRaEYy?=
 =?utf-8?B?T1YydCtzUi96Q0RnMjVuVGNxZmNFcE8yOGJjSHljYnNaRkIwSjlBNFRJc2xr?=
 =?utf-8?B?V1JGZ3YzU0NjR3VZYndXcTZIZ01CVExiZ2hCd2IyQ1VGUmdUZ1o5VDI0MjZC?=
 =?utf-8?B?RXpabUp2R09RRUNSWXU4RS9zL2h5ZFEvS2VxMi9ydlQvc1JuQUhxTjcrVkNr?=
 =?utf-8?B?ZVVsWVpDR0dUOGdEYzNzYnJRb0RGeTBocWF0MC9nNzB2ZlgvbGsyNm9scU1V?=
 =?utf-8?B?QkhsY05EbkluWHZvbk02NXhpYmZWek5OSWE2dkp6ZDh4RHp3WUg2Vm11NkJ3?=
 =?utf-8?B?QzdvWHZJQTFkczlwaTdNMGVPWFE0cDEzZzVxQzBKeW15Z29zSlJwdFY5WTRT?=
 =?utf-8?B?M0NPMFFWeFVSZDBiS0pCR0F5UXcrRXl6UXZvSXpNSTVVNGI5Mnl4SGl0S1RF?=
 =?utf-8?B?cDZ4R0R0TTl6SXZpTHAzcjBjVmZTb0lZU3Q3MDFNamZ1MjJVWXFQWUFMQnpL?=
 =?utf-8?B?SENJSnA5aENRWHl4VjRKeDIrN1NYdzBBRE9Teis4REFIU2hRaVlOK2lYVC9V?=
 =?utf-8?B?bjhXaHVWVkRPTlFES1RBQlN1Z1psNnhrM1RkbWwwVHpmT1FTcDlhdzVvWUZi?=
 =?utf-8?B?UVJhbUh0NFBLWS9LQ1o1Ymh3d05zQkdJV2tvYjQ2MEIydjlsUTVkM1FqR2lU?=
 =?utf-8?B?aUhuYnJxM3pOSFB2OUFoSHNqWDhkZ1VSTld1aWtYVk5CWUtZbVQvaE5seEhC?=
 =?utf-8?Q?AL8oz/iYVGz2yYqauSDR9lA0avNiH29udDjplZy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eitGdDJaUE1acXM0T3djckFNQjZLdGdHTkNzb1JWR1ZVUGhQM2I2YUkzZzkv?=
 =?utf-8?B?QnFubDNZcWhhVXJlcXptbG12SGlyOURWNDNtc21rcFJiejc0SVVCMmRUUS9V?=
 =?utf-8?B?elV4SzJMb1NTdzNGcUlUZDNkYmt0TkQrYzZzekxtQWlKZ2svTlJ6S3hWRGZk?=
 =?utf-8?B?K3kzSHhTYlJ4eTdXM0JSb1ZMZHhvWHphQzJYZkJqUUhYSHdaVEdhVGFYV3Fs?=
 =?utf-8?B?ZVRSZm9uYXJUVlhaUDNqcjBFcnVMNDVYOXZwYS9KTXMvSGdzcXJCSG16RXB6?=
 =?utf-8?B?bU42eEJvOVl3Z216aE84VnI0L0JxQ0RMSEFlRk90eUFQdEhhQVptSUZjVEph?=
 =?utf-8?B?bjQ3UHIzU0ZadVN2RzdyTGk5a2FwTXdEY1JibnpON2FDY1VpYityZnZCV1Z6?=
 =?utf-8?B?MEFhM0FEZVJLb213UXJMWnIrS3UvWFY2M1VyMXBQdklKQ2k2SVZvQU5rSnp0?=
 =?utf-8?B?a1dIMm9wSUFtL0lVT3lGcUtOanJPTTM3ZXJYMW80aFV4TGQwQVllRkFNdHox?=
 =?utf-8?B?WnZOSjlyTWIrNUVDTzNNQWNkWTZWMzhuZGwxMllMaXZtOVNvVllaSFo5eWh3?=
 =?utf-8?B?REVOR1BkcnJSNGFKWkJYL011eUk1TUJYMCtWdmVRRUZ4RUU3TFlRQ1pJOEZn?=
 =?utf-8?B?bU9ydWtmaTlLZnNvWG5UVFBLR2dyK3poQ2dVUTlKMFQ0bThlTTRSUG9vTjkr?=
 =?utf-8?B?WktHQSsxb3hkSjI3eHpqZnRHWml6eGFoZWh0LzZzR0tTNnlicVowcXNFcjIy?=
 =?utf-8?B?Z1VqY05yRlk0Sk83eUNYaWJ2YmJEcEd5MFFRaXJJRzYxUEZVOE9mQjFpOUpm?=
 =?utf-8?B?MXgweS8rbzBUUE5OVFZzYy9NVjdFTWZ2NlgxZ1lvdlZjTCtCQ2xPMWV1ZnM2?=
 =?utf-8?B?bzFSend5YWlOeTkxT0NRbk1yTGZrb2dNcGVXVWlZWEJ4U2lHL0RUbDM1bmR0?=
 =?utf-8?B?dGxHa2dWQVBSMG5YU3c4aC9aekZXZXNvZTRJajhCVzE4eWUxTlp3bmVQOUI5?=
 =?utf-8?B?WCt5RTZhNlpMdk1VWmNWaWJoNXBleXhPVWdpTzlHUXBrM1VrRTJvMnBwSzI3?=
 =?utf-8?B?ZmJDZEtsUnNkQklVM3BMR1JvVGVVWEEweWQ4NlpBM3hOM1NBY1d2bENWYndI?=
 =?utf-8?B?RmJaVW9SeDNkZk9qT2lRTjJ1NjJFajhBSDVSSkFtbTgya1dlai9IMDQyb09s?=
 =?utf-8?B?eStrSTlNMHhHeUpncitTcThFa0RFL1p6ZFpOUzhGV3NiWmlGbDJabFRTMGto?=
 =?utf-8?B?TEwwUDEwZER3eW1yK0kvUDNVNGhRc1pzamtJWWNuMktqZFhrTWtPc3JOc3dN?=
 =?utf-8?B?S2lSYUJsa0NkWmhodDB4RFIxMEZ1MkJSNHVkK2g3N1RiOFV2K2hsT1FxcjFT?=
 =?utf-8?B?Zm4wdjEvaDFvNmwwUndKM2h4Y0N2ckxuVng1V1FFSGRValQzV0RjQWJzV1U0?=
 =?utf-8?B?V3VGVG05NzNTeHAwdWhXV1RnZVlzeGRsN3FKZ3hpTkJsMmFQbCt4VGxySnVj?=
 =?utf-8?B?TERybW0wMG9xUkVpTmQzdlJ3RjJBaU5OVDl1NGlkSHJDOU1tNHRhckppYVJX?=
 =?utf-8?B?ZzVxUnFIMS9YL3l3cTEwVmV6OTB3dG82a3MwbVJVN3U3RGxFN05zc0xTaWhX?=
 =?utf-8?B?SlVIUDBzcDA2WTJKYkpQZGlpK1hwR21KVmJyRG5nOFF6aU1LQnJFSHJMRWll?=
 =?utf-8?B?MkRjT2ZOM2RJcGZSRk53UFdVSDRWS25xR1E5Y2p5N0Zibnp1WTllMS9Ic01O?=
 =?utf-8?B?bEFwdUJYZFR2YUl4YTZoN1RhWmpjTGFOaXRnRkJrSDdtSnhJc2F4cUc1enI4?=
 =?utf-8?B?Sy9mSjJWUHJvcE5FZzRGL1g1V0dQYjVlWEN5Nm9TQUZnSE4wVW0vSDNob2x5?=
 =?utf-8?B?YXd4NlNJZHZyK2hmT2g2WDZxaGg4aDBaMTAxTHBoTmkvU3JySGI5MTlmK0lL?=
 =?utf-8?B?Y2tBelFFNmVnQk5mNHFITjU3Vkd6UkFqM2FuRHN2QXZVK0x2V3JvNkZFaTRJ?=
 =?utf-8?B?NzBXQ2JwUVRkcHhDaUZyK3B4Z2lXU3k3Tko0dFBTUGxld1R3bU9MejhLWXBK?=
 =?utf-8?B?Szd0cEpjUVFrZStTNkhEdDlpSnA5U0h4QktIUXdhSmNhOW8vaVlyMk5zSmJ6?=
 =?utf-8?B?a25scWtmY0JSS09JNmY5OG12czVqT0RHcTVFNFo0R1NSRytZT3FMb1QxVFRz?=
 =?utf-8?B?bnc9PQ==?=
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
	5zKyq0402i2iEwceGWmaYM23XHCg7e1sktCWBSfEhP7JAdakSy6dozChO2SE6hPuHBbchGThSzgBvGbJy8pMEutFF6frTuwUPDmJTGuI+F9l8BJEE6Ogjxe0e1j2iiTYZmen2lB8iC+jH1/E/6EWIJqdj03lnmH9ueIvqubaHsNf7IP3y2VKdPcNVIRe6exbvmBiizuTsZhBWgzhQTc3gBsQ8DXB33vYe/ls8GKyzAm9K18MvCxgkba+fe2/uAgpXCd/7fe8llxswELkOwstJXn9To7pxQxa1ruulQlUzsIv2Spck1ybCR4ccnOWCm1nRs0E7/1E5r29+BtaJbXRYdpVoyqYSeKpLOp9I8zd8w9riZ4OWCchpA4CgoT1kz78T7iYjVQ78GOdvEGYSWJwkU6k0LJkpDg1HEXWOgIoQ7k2/cyBvFQCPmjKvjUM70siiBCP8R83MiiIZT7P+yT91aCx3bplgqw6A04h9gQ6eoMcAubIuxzhYkDz2JnSEn3ElyqKT7+KZxKbOhD/bYMCvDUIb44/pjVnOfELrbFgkQxKenxAWbLUlCmF0FzFAUgMlrqlZ+6t++E2Go1HJz7usse0432cIdNSA7is9s4u9N2AAgeKb7KtTOjAKjL1UwIS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3a1dd1-ebe6-4438-7293-08dce9166719
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 10:29:20.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExdZQ4WdHuRQpCfKs+N0MArmlnI5Zpo4FoDBMfscUKVcJ6S7R65n3fB3wGzJ81JclYP2yRwWKBtmaH/7J7y8/fVYY29vQqSPtYxdO+zwWd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6180

T24gVGh1LCBPY3RvYmVyIDEwLCAyMDI0IDY6MTggUE0gWmh1IFlhbmp1biB3cm90ZToNCj4g5Zyo
IDIwMjQvMTAvMTAgMTU6MjQsIERhaXN1a2UgTWF0c3VkYSAoRnVqaXRzdSkg5YaZ6YGTOg0KPiA+
IE9uIFdlZCwgT2N0IDksIDIwMjQgMTE6MTMgUE0gWmh1IFlhbmp1biB3cm90ZToNCj4gPj4NCj4g
Pj4NCj4gPj4g5ZyoIDIwMjQvMTAvOSA5OjU4LCBEYWlzdWtlIE1hdHN1ZGEg5YaZ6YGTOg0KPiA+
Pj4gU29tZSBmdW5jdGlvbnMgaW4gcnhlX21yLmMgYXJlIGdvaW5nIHRvIGJlIHVzZWQgaW4gcnhl
X29kcC5jLCB3aGljaCBpcyB0bw0KPiA+Pj4gYmUgY3JlYXRlZCBpbiB0aGUgc3Vic2VxdWVudCBw
YXRjaC4gTGlzdCB0aGUgZGVjbGFyYXRpb25zIG9mIHRoZSBmdW5jdGlvbnMNCj4gPj4+IGluIHJ4
ZV9sb2MuaC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1h
dHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmggfCAgOCArKysrKysrKw0KPiA+Pj4gICAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyAgfCAxMSArKystLS0tLS0tLQ0KPiA+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaCBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oDQo+ID4+PiBpbmRleCBkZWQ0NjEx
OTE1MWIuLjg2NmMzNjUzM2I1MyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX2xvYy5oDQo+ID4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9sb2MuaA0KPiA+Pj4gQEAgLTU4LDYgKzU4LDcgQEAgaW50IHJ4ZV9tbWFwKHN0cnVjdCBp
Yl91Y29udGV4dCAqY29udGV4dCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpOw0KPiA+Pj4N
Cj4gPj4+ICAgIC8qIHJ4ZV9tci5jICovDQo+ID4+PiAgICB1OCByeGVfZ2V0X25leHRfa2V5KHUz
MiBsYXN0X2tleSk7DQo+ID4+PiArdm9pZCByeGVfbXJfaW5pdChpbnQgYWNjZXNzLCBzdHJ1Y3Qg
cnhlX21yICptcik7DQo+ID4+PiAgICB2b2lkIHJ4ZV9tcl9pbml0X2RtYShpbnQgYWNjZXNzLCBz
dHJ1Y3QgcnhlX21yICptcik7DQo+ID4+PiAgICBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3Qg
cnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsDQo+ID4+PiAgICAJCSAgICAgaW50
IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciAqbXIpOw0KPiA+Pj4gQEAgLTY5LDYgKzcwLDggQEAgaW50
IGNvcHlfZGF0YShzdHJ1Y3QgcnhlX3BkICpwZCwgaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9kbWFf
aW5mbyAqZG1hLA0KPiA+Pj4gICAgCSAgICAgIHZvaWQgKmFkZHIsIGludCBsZW5ndGgsIGVudW0g
cnhlX21yX2NvcHlfZGlyIGRpcik7DQo+ID4+PiAgICBpbnQgcnhlX21hcF9tcl9zZyhzdHJ1Y3Qg
aWJfbXIgKmlibXIsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2csDQo+ID4+PiAgICAJCSAgaW50IHNn
X25lbnRzLCB1bnNpZ25lZCBpbnQgKnNnX29mZnNldCk7DQo+ID4+PiAraW50IHJ4ZV9tcl9jb3B5
X3hhcnJheShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHZvaWQgKmFkZHIsDQo+ID4+PiAr
CQkgICAgICAgdW5zaWduZWQgaW50IGxlbmd0aCwgZW51bSByeGVfbXJfY29weV9kaXIgZGlyKTsN
Cj4gPj4+ICAgIGludCByeGVfbXJfZG9fYXRvbWljX29wKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQg
aW92YSwgaW50IG9wY29kZSwNCj4gPj4+ICAgIAkJCXU2NCBjb21wYXJlLCB1NjQgc3dhcF9hZGQs
IHU2NCAqb3JpZ192YWwpOw0KPiA+Pj4gICAgaW50IHJ4ZV9tcl9kb19hdG9taWNfd3JpdGUoc3Ry
dWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCB1NjQgdmFsdWUpOw0KPiA+Pj4gQEAgLTgwLDYgKzgz
LDExIEBAIGludCByeGVfaW52YWxpZGF0ZV9tcihzdHJ1Y3QgcnhlX3FwICpxcCwgdTMyIGtleSk7
DQo+ID4+PiAgICBpbnQgcnhlX3JlZ19mYXN0X21yKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3Qg
cnhlX3NlbmRfd3FlICp3cWUpOw0KPiA+Pj4gICAgdm9pZCByeGVfbXJfY2xlYW51cChzdHJ1Y3Qg
cnhlX3Bvb2xfZWxlbSAqZWxlbSk7DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyBpbmxpbmUgdW5zaWdu
ZWQgbG9uZyByeGVfbXJfaW92YV90b19pbmRleChzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEp
DQo+ID4+PiArew0KPiA+Pj4gKwlyZXR1cm4gKGlvdmEgPj4gbXItPnBhZ2Vfc2hpZnQpIC0gKG1y
LT5pYm1yLmlvdmEgPj4gbXItPnBhZ2Vfc2hpZnQpOw0KPiA+Pj4gK30NCj4gPj4NCj4gPj4gVGhl
IHR5cGUgb2YgdGhlIGZ1bmN0aW9uIHJ4ZV9tcl9pb3ZhX3RvX2luZGV4IGlzICJ1bnNpZ25lZCBs
b25nIi4gSW4NCj4gPj4gc29tZSAzMiBhcmNoaXRlY3R1cmUsIHVuc2lnbmVkIGxvbmcgaXMgMzIg
Yml0Lg0KPiA+Pg0KPiA+PiBUaGUgdHlwZSBvZiBpb3ZhIGlzIHU2NC4gU28gaXQgaGFkIGJldHRl
ciB1c2UgdTY0IGluc3RlYWQgb2YgInVuc2lnbmVkDQo+ID4+IGxvbmciLg0KPiA+Pg0KPiA+PiBa
aHUgWWFuanVuDQo+ID4NCj4gPiBIaSwNCj4gPiB0aGFua3MgZm9yIHRoZSBjb21tZW50Lg0KPiA+
DQo+ID4gSSB0aGluayB0aGUgY3VycmVudCB0eXBlIGRlY2xhcmF0aW9uIGRvZXNuJ3QgbWF0dGVy
IGluIDMyLWJpdCBPUy4NCj4gPiBUaGUgZnVuY3Rpb24gcmV0dXJucyBhbiBpbmRleCBvZiB0aGUg
cGFnZSBzcGVjaWZpZWQgd2l0aCAnaW92YScuDQo+ID4gQXNzdW1pbmcgdGhlIHBhZ2Ugc2l6ZSBp
cyB0eXBpY2FsIDRLaUIsIHUzMiBpbmRleCBjYW4gYWNjb21tb2RhdGUNCj4gPiAxNiBUaUIgaW4g
dG90YWwsIHdoaWNoIGlzIGxhcmdlciB0aGFuIHRoZSB0aGVvcmV0aWNhbCBsaW1pdCBpbXBvc2Vk
DQo+ID4gb24gMzItYml0IHN5c3RlbXMgKGkuZS4gNEdpQiBvciAyXjMyIEJ5dGVzKS4NCj4gDQo+
IEJ1dCBpbiAzMiBiaXQgT1MsIHRoaXMgd2lsbCBsaWtlbHkgcG9wIG91dCAidHlwZSBkb2VzIG5v
dCBtYXRjaCIgd2FybmluZw0KPiBiZWNhdXNlICJ1bnNpZ25lZCBsb25nIiBpcyAzMiBiaXQgaW4g
MzItYml0IE9TIHdoaWxlIHU2NCBpcyBhbHdheXMgNjQNCj4gYml0LiBTbyBpdCBpcyBiZXR0ZXIg
dG8gdXNlIHU2NCB0eXBlLiBUaGlzIHdpbGwgbm90IHBvcCBvdXQgYW55IHdhcm5pbmdzDQo+IHdo
ZXRoZXIgaW4gMzJiaXQgT1Mgb3IgaW4gNjRiaXQgT1MuDQoNClRoYXQgbWFrZXMgc2Vuc2UuIFRo
ZSBmdW5jdGlvbiB3YXMgY3JlYXRlZCBpbiB0aGUgY29tbWl0IDU5MjYyN2NjYmRmZi4NCkNmLiBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzU5MjYyN2NjYmRmZjBlYzZm
ZmYwMGZjNzYxMTQyYTc2ZGI3NTBkZDQNCg0KSXQgc2VlbXMgdG8gbWUgdGhhdCByeGVfbXJfaW92
YV90b19wYWdlX29mZnNldCgpIGFsc28gaGFzIHRoZSBzYW1lIHByb2JsZW0uDQo9PT0gcnhlX21y
LmMgPT09DQpzdGF0aWMgdW5zaWduZWQgbG9uZyByeGVfbXJfaW92YV90b19pbmRleChzdHJ1Y3Qg
cnhlX21yICptciwgdTY0IGlvdmEpDQp7DQoJcmV0dXJuIChpb3ZhID4+IG1yLT5wYWdlX3NoaWZ0
KSAtIChtci0+aWJtci5pb3ZhID4+IG1yLT5wYWdlX3NoaWZ0KTsNCn0NCnN0YXRpYyB1bnNpZ25l
ZCBsb25nIHJ4ZV9tcl9pb3ZhX3RvX3BhZ2Vfb2Zmc2V0KHN0cnVjdCByeGVfbXIgKm1yLCB1NjQg
aW92YSkNCnsNCglyZXR1cm4gaW92YSAmIChtcl9wYWdlX3NpemUobXIpIC0gMSk7DQp9DQo9PT09
PT09PT09PT09DQoNClRoaXMgcGF0Y2ggaW4gT0RQIHNlcmllcyBqdXN0IG1vdmVzIHRoZSBmdW5j
dGlvbiBkZWZpbml0aW9uLCBhbmQgaXQgaXMgaW50cmluc2ljYWxseQ0Kbm90IHRoZSBjYXVzZSBv
ZiB0aGUgcHJvYmxlbS4gSWYgbXkgT0RQIHY4IHBhdGNoZXMgY291bGQgZ28gaW50byB0aGUgZm9y
LW5leHQNCnRyZWUgd2l0aG91dCBvYmplY3Rpb24sIHRoZW4gSSBjYW4gc2VuZCBhIG5ldyBwYXRj
aCB0byBmaXggdGhlbS4gT3RoZXJ3aXNlLA0Kd2UgY2FuIGZpeCB0aGVtIGJlZm9yZSBteSBzdWJt
aXR0aW5nIE9EUCB2OSBwYXRjaGVzLg0KDQpUaGFua3MsDQpEYWlzdWtlIE1hdHN1ZGENCg0KPiAN
Cj4gWmh1IFlhbmp1bg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBEYWlzdWtlIE1hdHN1ZGENCj4g
Pg0KPiA+Pg0KPiA+Pj4gKw0KPiA+Pj4gICAgLyogcnhlX213LmMgKi8NCj4gPj4+ICAgIGludCBy
eGVfYWxsb2NfbXcoc3RydWN0IGliX213ICppYm13LCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRhKTsN
Cj4gPj4+ICAgIGludCByeGVfZGVhbGxvY19tdyhzdHJ1Y3QgaWJfbXcgKmlibXcpOw0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+ID4+PiBpbmRleCBkYTNkZWU1MjA4NzYuLjFm
N2I4Y2Y5M2FkYyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX21yLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMN
Cj4gPj4+IEBAIC00NSw3ICs0NSw3IEBAIGludCBtcl9jaGVja19yYW5nZShzdHJ1Y3QgcnhlX21y
ICptciwgdTY0IGlvdmEsIHNpemVfdCBsZW5ndGgpDQo+ID4+PiAgICAJfQ0KPiA+Pj4gICAgfQ0K
PiA+Pj4NCj4gPj4+IC1zdGF0aWMgdm9pZCByeGVfbXJfaW5pdChpbnQgYWNjZXNzLCBzdHJ1Y3Qg
cnhlX21yICptcikNCj4gPj4+ICt2b2lkIHJ4ZV9tcl9pbml0KGludCBhY2Nlc3MsIHN0cnVjdCBy
eGVfbXIgKm1yKQ0KPiA+Pj4gICAgew0KPiA+Pj4gICAgCXUzMiBrZXkgPSBtci0+ZWxlbS5pbmRl
eCA8PCA4IHwgcnhlX2dldF9uZXh0X2tleSgtMSk7DQo+ID4+Pg0KPiA+Pj4gQEAgLTcyLDExICs3
Miw2IEBAIHZvaWQgcnhlX21yX2luaXRfZG1hKGludCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgKm1y
KQ0KPiA+Pj4gICAgCW1yLT5pYm1yLnR5cGUgPSBJQl9NUl9UWVBFX0RNQTsNCj4gPj4+ICAgIH0N
Cj4gPj4+DQo+ID4+PiAtc3RhdGljIHVuc2lnbmVkIGxvbmcgcnhlX21yX2lvdmFfdG9faW5kZXgo
c3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhKQ0KPiA+Pj4gLXsNCj4gPj4+IC0JcmV0dXJuIChp
b3ZhID4+IG1yLT5wYWdlX3NoaWZ0KSAtIChtci0+aWJtci5pb3ZhID4+IG1yLT5wYWdlX3NoaWZ0
KTsNCj4gPj4+IC19DQo+ID4+PiAtDQo+ID4+PiAgICBzdGF0aWMgdW5zaWduZWQgbG9uZyByeGVf
bXJfaW92YV90b19wYWdlX29mZnNldChzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEpDQo+ID4+
PiAgICB7DQo+ID4+PiAgICAJcmV0dXJuIGlvdmEgJiAobXJfcGFnZV9zaXplKG1yKSAtIDEpOw0K
PiA+Pj4gQEAgLTI0Miw4ICsyMzcsOCBAQCBpbnQgcnhlX21hcF9tcl9zZyhzdHJ1Y3QgaWJfbXIg
KmlibXIsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dsLA0KPiA+Pj4gICAgCXJldHVybiBpYl9zZ190
b19wYWdlcyhpYm1yLCBzImdsLCBzZ19uZW50cywgc2dfb2Zmc2V0LCByeGVfc2V0X3BhZ2UpOw0K
PiA+Pj4gICAgfQ0KPiA+Pj4NCj4gPj4+IC1zdGF0aWMgaW50IHJ4ZV9tcl9jb3B5X3hhcnJheShz
dHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHZvaWQgKmFkZHIsDQo+ID4+PiAtCQkJICAgICAg
dW5zaWduZWQgaW50IGxlbmd0aCwgZW51bSByeGVfbXJfY29weV9kaXIgZGlyKQ0KPiA+Pj4gK2lu
dCByeGVfbXJfY29weV94YXJyYXkoc3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCB2b2lkICph
ZGRyLA0KPiA+Pj4gKwkJICAgICAgIHVuc2lnbmVkIGludCBsZW5ndGgsIGVudW0gcnhlX21yX2Nv
cHlfZGlyIGRpcikNCj4gPj4+ICAgIHsNCj4gPj4+ICAgIAl1bnNpZ25lZCBpbnQgcGFnZV9vZmZz
ZXQgPSByeGVfbXJfaW92YV90b19wYWdlX29mZnNldChtciwgaW92YSk7DQo+ID4+PiAgICAJdW5z
aWduZWQgbG9uZyBpbmRleCA9IHJ4ZV9tcl9pb3ZhX3RvX2luZGV4KG1yLCBpb3ZhKTsNCj4gPg0K
DQo=

