Return-Path: <linux-rdma+bounces-19448-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFzJDEhu52ke8AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19448-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:32:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0943AA3B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FC33304D64E
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D93B8D48;
	Tue, 21 Apr 2026 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/sIi1OJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8893C140D;
	Tue, 21 Apr 2026 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774576; cv=fail; b=PPWu17hhysixu8zIHmE4Nu9zFdq4ATo07yubW4nb3sk/3eE3L/j4k4tqb1b1558LkmPJ4oCu1M38iNgtRzBw/CAsgnI9mnlFnhwuW/54Z095psriZb9DrxRI5q4vGoo5EN8lOJFvMBkmAV/3t9rGkxx+s5bTIf8Z1+cm/5t1Lhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774576; c=relaxed/simple;
	bh=3zIw328zqRDRr46v8YupU9Y/j7XsGoz6Nb7LZKaFRQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SK+b4FRc/BFzOeBUw5bwcEPTbMt2ssDc2qIXiHAgKa+mPwoV6hapapsVPRivsOzfrTkXwPJ9JW0ZwHOqO/fV2oTIOfeBPzpE7Jh4rtEODSK9dRLE6Va7pU+BIN/xjMsfofkYlZwnfXsrAtMAMJkD72y08jNJdPUbuOfIWTJ0NAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/sIi1OJ; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mskCbZpY6UsEOeWwqKgef49O8mP0Z1ylnjRQipjiFZ3/x8kQj8cFZsckFXMcBeuTFqMgsR/vLZD9z+5G4mkR9aSjBLaktndmJX9Fs4LzhSe0Umi0nvqq8t1TdFRSf3scJzHQ+U+b2A3WMct7SbyQX/WrK9tHkVeQOHsLXbGjon3wHGtu8aiKFHKUWrChcFFaSBvb36FX7ycWqzO7TMOtIRkB2XpWNVcJ7b1pqHB1iXvAwU2HWvuP2p/h0mZyirTr9PW61loFiCeqIlahoA/r0xDji+paLkuP9yxTTC1FrkyhRD2fSh7K3QqNzLGtvd0t6ezwci8bUyF84Vexo+LYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zIw328zqRDRr46v8YupU9Y/j7XsGoz6Nb7LZKaFRQI=;
 b=y46GTrkagpjAKrFQhhzdsNiZlp/6VoM579/pwmd38QAT30AsNmAKJs5AKwnJqC4PuscWK3if4IapwURGihgmNqw/D6N0V2F3ShMPCqLNCmELl45rkJgS7BgyQenPk9dvbNyDCsaEf2mEZQ5KUAz3nZM+lSTx1ukMBYqX6ovTn1zEwhTTwmel2hmKtYK6N3q3a91jxDb85Be8TSNjuG4l1HIzhV8t358TZD4mZKlAIp+11NFHY3UrGaa8z2wx4ZPr+nOBCSMMu/SKgNQ0otw/LFQYv5V4yrSfTr3Agk9OXy90gKgS+5uB/jqhigtUyNoW+9mUnVWkX7EZDCpEp+/Z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zIw328zqRDRr46v8YupU9Y/j7XsGoz6Nb7LZKaFRQI=;
 b=B/sIi1OJJ1DKJssfqgWHvPZjV5rTYf3g9dkc3GFZpUnO+qXSQb00zewIu4ZqR4CFxliVHDN6tJEJiB8bqLmQe9yPqI5JtB1ZYweOItGnZ1rw8ORvncA7frlHEfZgg9TIF341eq7hSEpedTNBb2jY/2bVARocM9IZqER1pWjzfQabDINCpY1wuZHgpMFFkejsMe9W1z+0dGIeBHYEgHwCd6c0UUiiAyjnvd/G+MNgII75aqnY9sx/UMhKl5RUn0ZF98jYIJiIOg8AHyyJfu9Rt+1tHVmY/3Dr9/TIjhU8NzCvOOVaMb8L8XbaiL3IVh/SM1/tcFxE9rbshFpiBphXeQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 12:29:13 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%6]) with mapi id 15.20.9818.017; Tue, 21 Apr 2026
 12:29:13 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Topic: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Index: AQHczieNmLFIHpbrDUuqFWyBz+NLKrXlMUIAgAKT6wCAAG9bgIABRBKA
Date: Tue, 21 Apr 2026 12:29:13 +0000
Message-ID: <f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	 <20260418190848.204170-1-kuba@kernel.org>
	 <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	 <20260420100917.1e4be22a@kernel.org>
In-Reply-To: <20260420100917.1e4be22a@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS7PR12MB8202:EE_
x-ms-office365-filtering-correlation-id: 394f7cab-d62b-4932-4f02-08de9fa198bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 ERRKZ8wQwbFC9zDfXrpqbSlSwYpzTPnpY35A9fQYDUQJpV53jOGCipTkdHhNl4PekVAaI9Kl/lcezFtFYIbSZ3CL6HJ+vVhqqPiCaqK4cEf6PmJjPGxZdlLkZygzkwl0TJEu4PEg+lqci6uB42B7EujaXYCO2Hb22XsIo/vwv3LjUZk/fAIkJtp2xly3bIPeAo9oeXE5bFQ43nCNxH9Ohu000g6it6Ltxo95mOR0z+cNXPeVFdFr+JJXqJP7W9+Pq0kLMd1mK+n5En2AH9QaIFQEQ6/SqazwRBAXvhuNJl/tOOlnSeh9tsu41UACcfhDIsh6nwJmAaQJDV9YsPFBNSCBfqye5T/1nRdAWjvejY1J77iw2DwB6k76jMY3qX1sd4ZCsVwxBwLEje8qWkQO/Pj+jSL8M0Z5gj14cLzkUvQ1Wrf1r1+MulRYN4xebdL+HcDRuj3gtkv/nYKEQjak4SyCz738zVLDXKuHtHcDw59gMjxI2awSl2n5HQQ6X4xg74DxDUVXZHfiikBK97+wCIiLbh03hKgdeuvM0XgtPFRRH02hMZyY2XXRNuMC5IjTmb2NoUgsxaCXwldE4Y5idI1OMr58cmV8RmQBx3nUbKsUS59K31BPFmKLkbd3slAYCwNS61XygKYIoIEwTLS0nN+OKBAXIZ0ZX4Mr0f3W0kcd1z8Tshrksz9QvRvu0APT3eR5gjhjnAH9BPnq9RPW/T8m0RHIusuyaSdseCu3WXiouNVg5r+7Ij7v7uyWypGgysoSUOc0e+f2pO6kIP+iaGsG+SFy0KWvSGSiDZvykUI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0UxK0wwbFZ0ZE5jd3FZaGh2ampwTVkwVk1FZ25lR09wNUI3MTQrY281bzNh?=
 =?utf-8?B?NHJyS2ZsNy8rbk45MmdBcy9NVlc0Sjl1c2hzYUErM0plUzNPcFh0T2paVThj?=
 =?utf-8?B?T1drbkZKaXVuRXpzYkRwYnE2eXk1QTZkL1FPRzNIdzhXa1RWVm5sbEFUbEti?=
 =?utf-8?B?VDR5WFJFK3NRTFNrTzM5b2RmTU5tT1JnbDBuWWc4Z1pmaGZXckxwaEpRa3Iy?=
 =?utf-8?B?cExwUTJDNTBaa1pzeEluZXk3ZitkMU5CbDJsMFg4YTJFVmVGQzF0MzRlMnho?=
 =?utf-8?B?WVVTRmJPVUdyMjc2NFd1UndaVWphSnlLY292em5jZjBsSElmNnhkWEtzZlkz?=
 =?utf-8?B?U0pJa3pBblNlME9UNk5YUWpFQ0tybXhsYWJYdkQxbDY1RHhJRWlBVlVKWndP?=
 =?utf-8?B?NzZ4RmpQUXpBQ3VKZ2d2eDY5WDg2SHJpMURkcCsydWxRV2dKMXc5RjROUjc5?=
 =?utf-8?B?bGJnZTRJSk50c2VKZWpJTDlNaVZoczI5WGcwS2tqU3NmSi8xdml3Q1VnSW1C?=
 =?utf-8?B?UGZTWEZLa3JoZVVndFBwb25PNjVaRHJuREVRR0dqSXNZQUdCdWUzRHdZWDJY?=
 =?utf-8?B?OERHMEdxaEVia2E0N2tudFMvaEVLaC9RcWlhR1hueXFudmpzWG5mZktYdFdy?=
 =?utf-8?B?b3RkNk1LRXpEeFB2RjRrcnFZdGIrTnA5M3pWRlRjRGp4MTQxWlpFcFprK214?=
 =?utf-8?B?MUdrdWxCQ1UwcmtRY2F1UXIwejlub0RrUWhJcWc3ejFBWjZmclFPNzYrTVI1?=
 =?utf-8?B?RnZjTUVRTkpPOUJVbStoM2E5V3dPZzBYS2F0Sk9vVmNqUWc1TzBPU0JYVGZS?=
 =?utf-8?B?cnZIRFY0SkxjNGNMRlkrNktkWEZ2TmNpRmtYSHZqeFpmNGJPdG0zeFplekQz?=
 =?utf-8?B?bW54L2I0aWxYOENlaVFhMkhSb2tQWHJFQm1iemUwOFhBRlZmNmZ0TDAxK2NQ?=
 =?utf-8?B?bGl1Q1VUd1RrWE5DZXUzUHAxVVBmZnk4cUtNKzRrQ1Awb3dlYlNleEJWQmgz?=
 =?utf-8?B?c1VRK2xGbzIvd1JIY3dHd2lqVW1QZi8wTlZ5Z3NvbTFMYXQ2emk3K0UxU0gr?=
 =?utf-8?B?QVZ1Y2hIbktKUkFKSTVDZXZQZHZNSHMrNVFxdTk3UEhTdXhQdjNFdGowM3BD?=
 =?utf-8?B?RmcvOXhiWS9zRVNmaEFWUTM2K0JWb05FL0tUNXNJQUY1RzlrdXJKZ2xjTmFh?=
 =?utf-8?B?bjNMN3RXZWd0cmljbVkyaFl4NURkMHZNUFJma1E5YlUxQ0tzRHFETmZhYW9Y?=
 =?utf-8?B?ZWVWc0dTcDN2cjdNbW1ZZFNER2VHMDA5Q3Zqek1tWFI5MDgvMTBZQ0JWL3BB?=
 =?utf-8?B?RTdzcHB1N3Rma2pYQktpUkd1YjBMSTBoWEV6RUNJZXVqWmlJblBKSEhzK3VJ?=
 =?utf-8?B?T1VvVDhhOFJXQnhDamRNNk1oREs3c2w4b0NoVUZsSThXeXhmU1NiNTBIbFBq?=
 =?utf-8?B?TU43TWpGZFllTnROdzBXR00xdlVYampIbU5LR2FCeENyWjRlMkpoZEVxT2pj?=
 =?utf-8?B?WUI5a2xWTW5HOEVXQmVSRlJKQ200amk1RHROdHEyYzNFZHh6YUFJRnJORlAw?=
 =?utf-8?B?MTlCYzFkd000ejViUDZqM2xiYkpJSlQrMllBaG9sUzRrM0NzMjM0aFhmdHRa?=
 =?utf-8?B?V201aG5nd3h3UStVWU11OU92UlVnckRIQmdGdTdQOTlnM2dML3NvN1JjZUdP?=
 =?utf-8?B?T2dIY2svWmROSzRFa0tRUnVFNTJNQVBRdTBQaGVTS2l2OEFnNjNZYTJpQmlK?=
 =?utf-8?B?cFA1bVM0akNDQlVGNlp1QUdSTzlPYlBoTjdXdnRSZkFxS1ZmK3RhbUVMbE5z?=
 =?utf-8?B?Y2Fyd05qL3psSzFoR1M3anZhSm82Vk0xWGF3Yk9jU0VQSHN1VFRQRVVOSUdS?=
 =?utf-8?B?WTk0a3REc3liV05lTFJrZ3JYU3l1c09JWEpnV2ExUE45a3U4aHViRzNZdmVH?=
 =?utf-8?B?TklXWTJwWHdoUWV1b2FZdUdpOXIwMUJXeWlMSklOc04vSTlyd1UvNE9xdEtX?=
 =?utf-8?B?d2ZDc2EyU2Zxd0psRkExQm8xSnNhVGw2ZDdnSkVQR0VJOEpjbjBxbEdxS0Rr?=
 =?utf-8?B?bnp1aFVKUEM2d2FyMDlLUnVUdXFiOXpHY1BZdE1WNmFhWnpyRys1aTR6OE1n?=
 =?utf-8?B?dUxSUnlFQi8vUUs5WDJYM3lmVnZ4ZkR3V0lwVUEvNXZqOGdwRmRKUUNXeFFM?=
 =?utf-8?B?ekEraWV6UCtKN1lRYS9hS292K1VLMCtjQjVtMTVNWVh0LzlPby9vZG5ZWVkr?=
 =?utf-8?B?aUQ1NkJ1eWVhcUZJYkVBbFY1RDlRL3ArOHdBYWMvc3VZQ3hObHVqNG12MVV5?=
 =?utf-8?B?R2p1S0hQVG94WWlhQWw1dERBa0xjbnBFVW9vZHdUWXBNMnFkRDVZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAB89EA549AC8440B9DAE4D1681E0E67@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394f7cab-d62b-4932-4f02-08de9fa198bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 12:29:13.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYYMaGKVMxJ4NPWImoBPfCWoVAHzHKS7A27Jece3FFht3OFpmI+b/rrMOziaz2iPax6hFoTzRuEGCb9UANCg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19448-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 89B0943AA3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTA0LTIwIGF0IDEwOjA5IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gTW9uLCAyMCBBcHIgMjAyNiAxMDozMDo0NiArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gPiBXaGVuIHBzcF9kZXZfY3JlYXRlKCkgZmFpbHMsIHRoaXMgZnVuY3Rpb24gbm93IHJl
dHVybnMgd2l0aG91dA0KPiA+ID4gc2V0dGluZw0KPiA+ID4gcHNwLT5wc3AsIGxlYXZpbmcgaXQg
YXMgTlVMTC4gSG93ZXZlciwgcHJpdi0+cHNwIHJlbWFpbnMNCj4gPiA+IGFsbG9jYXRlZA0KPiA+
ID4gYW5kDQo+ID4gPiBub24tTlVMTC4NCj4gPiA+IA0KPiA+ID4gRG9lcyB0aGlzIGxlYXZlIHRo
ZSBSWCBkYXRhcGF0aCB2dWxuZXJhYmxlIHRvIGEgTlVMTCBwb2ludGVyDQo+ID4gPiBkZXJlZmVy
ZW5jZT8NCj4gPiA+IA0KPiA+ID4gSWYgcHJpdi0+cHNwIGlzIG5vbi1OVUxMLCB0aGUgTklDIFJY
IGluaXRpYWxpemF0aW9uIHBhdGggY2FuDQo+ID4gPiBzdGlsbA0KPiA+ID4gY2FsbA0KPiA+ID4g
bWx4NV9hY2NlbF9wc3BfZnNfaW5pdF9yeF90YWJsZXMoKSwgd2hpY2ggY3JlYXRlcyBoYXJkd2Fy
ZSBmbG93DQo+ID4gPiBzdGVlcmluZw0KPiA+ID4gcnVsZXMgdG8gaW50ZXJjZXB0IFVEUCB0cmFm
ZmljLg0KPiA+ID4gDQo+ID4gPiBJZiBhIFVEUCBwYWNrZXQgdHJpZ2dlcnMgdGhlc2UgcnVsZXMs
IHRoZSBoYXJkd2FyZSBmbGFncyB0aGUgQ1FFDQo+ID4gPiB3aXRoDQo+ID4gPiBNTFg1RV9QU1Bf
TUFSS0VSX0JJVC4gVGhlIFJYIGZhc3QtcGF0aCBzZWVzIHRoZSBtYXJrZXIgYW5kDQo+ID4gPiBp
bnZva2VzDQo+ID4gPiBtbHg1ZV9wc3Bfb2ZmbG9hZF9oYW5kbGVfcnhfc2tiKCksIHdoaWNoIGRl
cmVmZXJlbmNlcyB0aGUgcG9pbnRlcg0KPiA+ID4gdW5jb25kaXRpb25hbGx5Og0KPiA+ID4gDQo+
ID4gPiB1MTYgZGV2X2lkID0gcHJpdi0+cHNwLT5wc3AtPmlkOw0KPiA+ID4gDQo+ID4gPiBTaW5j
ZSBwcml2LT5wc3AtPnBzcCBpcyBOVUxMLCB0aGlzIHdpbGwgY2F1c2UgYSBrZXJuZWwgcGFuaWMu
DQo+ID4gPiBTaG91bGQNCj4gPiA+IHByaXYtPnBzcCBiZSBjbGVhbmVkIHVwLCBvciB0aGUgZXJy
b3IgcHJvcGFnYXRlZCwgdG8gcHJldmVudCBmbG93DQo+ID4gPiBydWxlcw0KPiA+ID4gZnJvbSBi
ZWluZyBpbnN0YWxsZWQgd2hlbiByZWdpc3RyYXRpb24gZmFpbHM/wqAgDQo+ID4gDQo+ID4gRmly
c3QsIHRoaXMgaXMgcHJlZXhpc3RpbmcuIEJ1dCBtb3JlIGltcG9ydGFudGx5LCBpdCdzIGltcG9z
c2libGUNCj4gPiB0bw0KPiA+IHRyaWdnZXI6DQo+ID4gLSB3aXRoIG5vIFBTUCBkZXZzLCB0aGVy
ZSBjYW4gYmUgbm8gUFNQIFNBcyBpbnN0YWxsZWQuDQo+ID4gLSB3aXRoIG5vIFNBcywgUFNQIGRl
Y3J5cHRpb24gY2Fubm90IHN1Y2NlZWQuDQo+ID4gLSBhbGwgdW5zdWNjZXNzZnVsbHkgZGVjcnlw
dGVkIFBTUCBwYWNrZXRzIGFyZSBkcm9wcGVkIGJ5IHN0ZWVyaW5nLg0KPiA+IC0gdGhlIFJYIGhh
bmRsZXIgd2lsbCBub3Qgc2VlIGFueSBQU1AgcGFja2V0cyB3aXRoIHRoZSBtYXJrZXIgc2V0Lg0K
PiA+IA0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGNvbXBhcmF0aXZlbHkgd2F5IG1vcmUgbGlr
ZWx5IHNjZW5hcmlvIG9mDQo+ID4gcHNwX2Rldl9yZWdpc3RlciBmYWlsaW5nIGFuZCB0aGVuIG1s
eDVlX3BzcF91bnJlZ2lzdGVyIHBhc3NpbmcgdGhlDQo+ID4gZXJyb3IgcG9pbnRlciB0byBwc3Bf
ZGV2X3VucmVnaXN0ZXIsIHdoaWNoIHdpbGwgZG8gdW5wbGVhc2FudA0KPiA+IHRoaW5ncw0KPiA+
IHdpdGggaXQuDQo+IA0KPiBTdXJlIGJ1dCB3aHkgYXJlIHlvdSBsZWF2aW5nIHRoZSBwcml2LT5w
c3Agc3RydWN0IGluIHBsYWNlIGFuZA0KPiB3aGF0ZXZlcg0KPiBGUyBpbml0IGhhcyBiZWVuIGRv
bmU/IElPVyBpZiB5b3UgcmVhbGx5IHdhbnQgUFNQIGluaXQgdG8gbm90IGJsb2NrDQo+IHByb2Jl
IHdoeSBpcyBtbHg1ZV9wc3BfcmVnaXN0ZXIoKSBhIHZvaWQgZnVuY3Rpb24gcmF0aGVyIHRoYW4N
Cj4gbWx4NWVfcHNwX2luaXQoKSA/IElnbm9yaW5nIGVycm9ycyBmcm9tIHBzcF9kZXZfY3JlYXRl
KCkNCj4gbWFrZXMgbm8gc2Vuc2UgdG8gbWUgLSB3aGF0IGFyZSB5b3UgcHJvdGVjdGluZyBmcm9t
Pw0KPiBrbWFsbG9jKEdGUF9LRVJORUwpDQo+IGZhaWxpbmc/DQoNCnByaXYtPnBzcCBhbmQgc3Rl
ZXJpbmcgYXQgdGhlIHRpbWUgb2YgbWx4NWVfcHNwX3JlZ2lzdGVyKCkgaXMgaW5lcnQNCndpdGhv
dXQgdGhlIFBTUCBkZXZpY2UuIENsZWFuaW5nIGl0IG9uIHBzcF9kZXZfY3JlYXRlKCkgZmFpbHVy
ZSB3b3VsZA0KYmUgd2VpcmQsIGl0J3MgY2xlYW5lZCB1cCBhbnl3YXkgb24gbmV0ZGV2IHRlYXJk
b3duLiBUaGUgZmFjdCB0aGF0IG9ubHkNCm1lbW9yeSBhbGxvY2F0aW9ucyBjYW4gZmFpbCBpbnNp
ZGUgcHNwX2Rldl9jcmVhdGUoKSBpcyBpcnJlbGV2YW50IGhlcmUuDQpwc3BfZGV2X2NyZWF0ZSgp
IGZhaWxpbmcgc2hvdWxkbid0IGJyaW5nIGRvd24gdGhlIHdob2xlIG5ldGRldmljZSwgc28NCmxv
Z2dpbmcgYSBtZXNzYWdlIGFuZCBjb250aW51aW5nIGlzIG9rICh3aGljaCBpcyB3aGF0IGlzIGFs
c28gZG9uZSBmb3INCm1hY3NlYyBhbmQga3RscykuDQoNCm1seDVlX3BzcF9yZWdpc3RlcigpIGlz
IHZvaWQgYmVjYXVzZSBpdCdzIGNhbGxlZCBmcm9tDQptbHg1ZV9uaWNfZW5hYmxlKCkgd2hpY2gg
Y2FuJ3QgZmFpbCwgc28gaXQgcmVhbGx5IGNhbid0IGRvIG11Y2ggb3RoZXINCnRoYW4gY29tcGxh
aW4gdG8gZG1lc2cuDQoNCkJ1dCB3aGlsZSB0aGlua2luZyBhYm91dCB0aGlzLCBJIHN1cHBvc2Ug
d2UgY291bGQgY2hhbmdlIHRoZSBlbnRpcmUgUFNQDQppbml0aWFsaXphdGlvbiB0byBoYXBwZW4g
YXQgdGhlIHRpbWUgb2YgdGhlIGN1cnJlbnQNCm1seDVlX3BzcF9yZWdpc3RlcigpLCBhbmQgdGhh
dCB3b3VsZCBzaW1wbGlmeSB0aGUgbnVtYmVyIG9mIHN0YXRlcy4NCkkgd2lsbCBkbyB0aGF0IGlu
IHRoZSBuZXh0IHBsYW5uZWQgUFNQIHNlcmllcyBmb3IgbmV0LW5leHQuDQoNCk1lYW53aGlsZSwg
Y291bGQgeW91IHBsZWFzZSB0YWtlIHRoZSAybmQgcGF0Y2ggYW5kIGxlYXZlIHRoaXMgb25lIG91
dD8NCkl0IHNob3VsZCBhcHBseSB3aXRoIG5vIGNvbmZsaWN0cyBieSBpdHNlbGYuDQoNCk9yIHlv
dSB3b3VsZCBsaWtlIHRvIHNlZSBhIHNlcGFyYXRlIHN1Ym1pc3Npb24gd2l0aCB0aGUgMm5kIHBh
dGNoDQphbG9uZT8NCg0KQ29zbWluLg0K

