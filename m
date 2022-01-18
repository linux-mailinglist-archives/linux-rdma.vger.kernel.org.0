Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE03492154
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 09:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbiARIhZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 03:37:25 -0500
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:53046 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344560AbiARIhU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 03:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642495040; x=1674031040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3CKgrDzcNkxM3ZLjrWs9HYjozbqOKA1SAgI8+KF2rc4=;
  b=OtqDF9PETi5PqaZS+qarGzm8q4hBhOPqrY4wh8lobjbN24fgreQ7R1RI
   /la9yhVof8NHxAz+a6pwwtld2HFnUr0b+y8Ft/2tKJ2XjIYlvrjY5ZNLg
   RLUWL3cSiv6OnVikM/WVFIeW4Zh9UwxGh39jKPIkBbeQsIIzVVCVDg70V
   MI6WBqqzeaQMSZ0dPAqwgVDdfCpvyK89XYRbZBjFys9QX6GqhHsG9hKdA
   D2omgAUGQD+0Iwq9NJ2QZJ6Ps0okCJf7EgnT0GiU9lnNp1NJ4zbNljYXO
   HG/1NaB6w/N5wmn4La2+b/E8D4t3KQMnAy0QVxZXCEsdWvcQWaBz3mY7D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="47535129"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="47535129"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:37:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLw+i5V3h2I6X4IqWsansZ3LKQf5pb+COpAgv0npuVOCAuzMVxIEBcnJ58kaVgmSX37Lz1nu68t7E4bY5IDiS0kBp5tVG0rJdz9wljEBSfiL2yGehltecSfCJ72EC0uFqDu4LAJlVNAJVY2fcAk9DSVxHCrLec2tQpTq/oQZEYbB0J4ZFuilB+rYORyoD0VVqG6H4s+MfjC0SK2tO7MJDMzkQp9fDhP3RJeVrrujX0s1lHi0J7wjsgkXUG4Ro/TRJv/OQrFjoCAVPFvVZgQICuHdrWlwEdu6BV2VFCq0CmwmJeV6gUEeZoe9FieZNgl2NKo7ntDIrf8yToEEh6geHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CKgrDzcNkxM3ZLjrWs9HYjozbqOKA1SAgI8+KF2rc4=;
 b=B+gL7nv+fVZZcjrR2JWM2izzB6lrj8aSoE2E3ilXGqcgYSlHdRBwqi5i3w3kcZogmgF4LoKpHvSABicoyEPHj/oPxjOXomNNQkg5bQsjY4hkt0+gP1pqm3BYS4Y7J1QfR7S/BL2Nei9eenJyExGo/qdmDMy1xUac/7W6B698MhYqLaksaJTzBS/Mpk/6Oau+tbxBMpy1RqaYnXCnRqOYtGgIetwX8pZND/Zgjn4m9EqG6/OvIl+v0NATVJlgOqRgQkcbgPLLTOj89/DPSslJQ/KruaPQtJ9g178xspg8iEw31DPU6tyxJz5I/ChvBCLdZHLutX10ET14dU0Oi7bKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CKgrDzcNkxM3ZLjrWs9HYjozbqOKA1SAgI8+KF2rc4=;
 b=ZXSiAzhW+C8gTLko0SUZhmxHwwsl2SoxyoPBiZrjmEbJelomEis+tRLWuQjdZ/gCCBclxcEqw9RceleDe/kus9LM2wJgEaZ1Asj8qyN3gRbEIDZHZ5S+TX4Jqwn948BtDR5PZ7i3J2EwCivHOAgwIpsh/tSbcgjBUN4u73k0uPs=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TY2PR01MB4937.jpnprd01.prod.outlook.com (2603:1096:404:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 08:37:10 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:37:10 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBpJuJ6RKP3ud9UOOlkH1pyHpjqxogAMA
Date:   Tue, 18 Jan 2022 08:37:10 +0000
Message-ID: <61E67C34.5070009@fujitsu.com>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5863ef0b-70b9-44c7-75f4-08d9da5db7d8
x-ms-traffictypediagnostic: TY2PR01MB4937:EE_
x-microsoft-antispam-prvs: <TY2PR01MB493761239D794973E9EB8A3883589@TY2PR01MB4937.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pHRnBXMgXE+7CKn03UlD5thV4wS/qkPOMjkWob1n1YqcGOklJiT3lcTsK5OjodpP36ugpge4EmIRm8glgIaCk0BErhmXWp//hiko2CA+n/t/wD4CmnV+HpT/QDNinfMb56KhFrj+OyozNl2n8HwEYTGHcFxiqYrBksPzbt9WbVX+/d6/3yAPqFvt+dL6swACDMj8bmAWpEdSlGjpzPrqpd3Ctot2JYGoAWBlkDCE4og4wAZbZR7qzMx+D1rX6iP7Wtgan48IIO5gyZGa1Z/pqzHf1b65FBn6oIEq/4o7VZdBEr8uAULgprGCScL94KvyStg8VhqjGi6K+0oXCHiVGT1xkt6pDJ4ZIA93fbF9I4jekUhqcAlTTqjhSTtyxoIuUIdQkZBvvLDU062645KCMoWWwy05KO0qh6GETvsVro3ZJwU8pMQlldGL0ywtliJOyBN+k2FWgBroJKdtFf4JWTu4d4EDMoq7RiRBOfVcw7GCbGMTzqpCgwCp/b2+4YCGjRIMH93HwIyvvu6TDnce+juOivP6pcm1dQg2CHjsjs176pQHozaV7gZjxTNIu6+OAcSgk+CAHoRzuzbLSSeJmkuIz8QozVXbuXWWibsSWUcRBpMCgfYoaf+LDLuw5Iy18NY2uuGrDWGpaxlL2KkkDiiTOAhkLCycqt+XuKLX4p3MAmObQvd/DM8kSYk1LlqN8sW277CRWZfLRTElX0HNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(6486002)(33656002)(64756008)(66946007)(91956017)(54906003)(2616005)(2906002)(66476007)(76116006)(122000001)(71200400001)(66556008)(66446008)(38100700002)(186003)(53546011)(8676002)(6506007)(5660300002)(4326008)(85182001)(6512007)(36756003)(26005)(4744005)(83380400001)(6916009)(316002)(87266011)(82960400001)(8936002)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?T1VXRVhLelFvUjBSbE1oN1orNWNSM0o2ckdQM1RhenplMGVZbjNoQ0F2M05I?=
 =?gb2312?B?NlFKb2h4a2E5UkFUZXBpMXNUaWsxOE9nRXZYbmxpTXB0ZWhhZk1oQW9PTWY2?=
 =?gb2312?B?T3g3QThYMEV1UWZMMzZkWWZpWEdCOFZWbVExQlBSQXZBNFJtVmFzTm5MRDFH?=
 =?gb2312?B?TkNXZTBRaDBxZ0pEQzFJdndRdzBmbHUrdzNGbmRQR2p0TVZHeTZ0dmNqeWkv?=
 =?gb2312?B?bWUyc1JRMVFySmVqUnF2QWZzTGZDOFBiNDR0S21tZGZwWEF4Tk5YWm54eG13?=
 =?gb2312?B?bzE1R0JkcGc1K2t1SlVZMFlEblVoeG1kNDlTbS9QdVV2ck5mSTdvMm9RcGk5?=
 =?gb2312?B?VnU0NkluczY2eWFIUHhaZi9lU2ZKTlU3YUNLNDJVRVdzZFlPdkYrYXU0QmNQ?=
 =?gb2312?B?bkhKVGdqeTA3VUVnQlkxT3NvWXRZN3ArWWZLY1pXN2duZk5RRzZTa0luVzlR?=
 =?gb2312?B?U1gxZGY4MmhUUGJScEpreUF6MVNYK0hiU2NSZXh0WkJBZ01ndVhIQVZ0K3Q3?=
 =?gb2312?B?YjF2RzFNOEtsdjBaQ0tvT0dBQUhOUFRTaEFkR3ZtNkdlMEhrbS9Idy95ejRy?=
 =?gb2312?B?NXhjam9Lcy9vN1RnVjhNR0taamI5Y1RaWjBGYm1uWkVVLysvTG14c2Mvb3c1?=
 =?gb2312?B?ejNKblBTeVZ3d214OThNM1VGa2hYT3I2Unk1QjdtQ3c3d0RmcnVrdWp3a2NP?=
 =?gb2312?B?eWlFQ2RmeXUxZnlTbXFLK3hDb2w0MzNJK1h1NFVJZ1ZndHVha1hZdjgzRWM0?=
 =?gb2312?B?dW9VVjZ4YmRDM2pSSlhQeXFDUVhnVFBEL2tKazk3T2pxWks4VE1FVXJpRVdm?=
 =?gb2312?B?QklyY3RyNlkyOGNWckhhczhPR25MbUtGVGFKYlJBQks5MXBUaVlLWFAzbjVr?=
 =?gb2312?B?RFN5bWIxMml3TTR6ZkpNOTN0NjR5MTZlOTltUFduRU0wWFhLVGJPMWQyK2ZP?=
 =?gb2312?B?NkcxMFBQenNRZElTL0JKZkp6eEdVT1lFekxXTDBUM2psSWxNV28wR1hFdFBa?=
 =?gb2312?B?UzhNVlhKOGxtN3FqSlc1cXI2S3RmVkpWWnBqRE12L0gyOTlqK1NZb0MwMnZr?=
 =?gb2312?B?YW00c3V1YlNDWGFCbFR6WDI1b01SMHRVODl1aGxSOVRoMldSR1FMcXd2VEZu?=
 =?gb2312?B?SU9EUysyUHM1ZHRhREN5WVpHajFmTS9HazJxNzNLejFFcXRTZnVQaUNaemlv?=
 =?gb2312?B?WHgzTDNJN25BNHZsTWxUUlBYc1psTHBnQURnZ2JySHBrWWlTQkptYTRuZFgy?=
 =?gb2312?B?WlVlVWNkcjR0MTZmUk5JMUFOY2pKdW5neUZ1dWV4aHRXNlZqZnA5VW14aGZX?=
 =?gb2312?B?YmU3ZjlRaEcyODByQ2FHNmxRTHV6enB1VUs2blRmK0lIdDZqdnY3MElXekJZ?=
 =?gb2312?B?TUdURUxmSGdGYklnblBHSUF3dkFmaXY4bGlsT3M4SW5vQlk1amlGaGl5N1dN?=
 =?gb2312?B?MkxKcVhYalBMUjJZZm5ZbjMwR2IrckFkcTQrSWsyQ2tUWmpDUGpzV1NZTnBO?=
 =?gb2312?B?ZklDcTYxQUZVd1V6YW5qWG1nSzIzOXhrZjNnVWtPS0V2eWdJRkNKeWNncXFo?=
 =?gb2312?B?bGdpdGRIRmRWMkhjUFFMQUw5Y0hnQ1ZsNG9vS3JNL1l6WjA3QUxncThCbW16?=
 =?gb2312?B?d0tDYUhLeFM3dmp5OHhwQzhnRkRSWVcvOFVqalFwbTcxOTlraUkvR2YvMGp3?=
 =?gb2312?B?bDZUWU5YNDR6OEVGLzB1aS91M3ZPdktYUmpqSFFwVVdhUC9Mand4dnFoSEtT?=
 =?gb2312?B?Ty96c2tBeHp6UGszMWJGMDZYTGV3NEQ3ODk0RnhJcVdJNG52M3ZzQTV1QmNy?=
 =?gb2312?B?dysxTXNYZk9IeVFQcUxGdnc2NGt3Nmh5WENpR0FuUmxoTVlrRWlxTk5hb3lv?=
 =?gb2312?B?ZW0yNis5Tlh1cGlCMUpGZ2pjYTRsRWhpd0p4WlpVQTc1Mlc3aUlqcEVka1Fm?=
 =?gb2312?B?aFpOcnFyL296SnQvdUdpbGFuMHpzMWY5U0ZNaitQSXhnV1gwaDdOSkoyRnox?=
 =?gb2312?B?aURybTFxMnMvRTU1dU5QV2R6SFY3ZmE2V2lySjVDQSsxaFlEVlhramxBQUgx?=
 =?gb2312?B?bFJiemIvS2w4TXlka2tOSVhDazg5eWplMDc4eGxhRkk0cm91cGtNRzRGVVZp?=
 =?gb2312?B?M1RNamRKSFJLT0pmSlFoSTFlR2JydFNzdEh2c0RQWnVsN0NwZjhMNU1jT0FM?=
 =?gb2312?Q?Ilwlwz67msaZY6koK3GY8X4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <D3D1971E3E14084EB9B799FEA597FE7E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5863ef0b-70b9-44c7-75f4-08d9da5db7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:37:10.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObE+OmB8Jjx7dX1Td9H+flYJCHzpOygN5n44l5Q1GQpDJlZFsbOUZL3yChCNejFfvXfLfW8e4iDO1IDwgNlc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4937
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzExIDEwOjI0LCBYaWFvIFlhbmcgd3JvdGU6DQo+IFRoZSBleHByZXNzaW9uICJj
b25zID09ICgocXAtPmN1cl9pbmRleCArIDEpICUgcS0+aW5kZXhfbWFzaykiIG1pc3Rha2VubHkN
Cj4gYXNzdW1lcyB0aGUgcXVldWUgaXMgZnVsbCB3aGVuIHRoZSBudW1iZXIgb2YgZW50aXJlcyBp
cyBlcXVhbCB0byAibWF4aW11bSAtIDEiDQo+IChtYXhpbXVtIGlzIGNvcnJlY3QpLg0KPg0KPiBG
b3IgZXhhbXBsZToNCj4gSWYgY29ucyBhbmQgcXAtPmN1cl9pbmRleCBhcmUgMCBhbmQgcS0+aW5k
ZXhfbWFzayBpcyAxLCBjaGVja19xcF9xdWV1ZV9mdWxsKCkNCj4gcmVwb3J0cyBFTk9TUEMud3Jv
dGUNCkhpIEJvYiwNCg0KSSB0aGluayB0aGUgY29tbWl0IG1lc3NhZ2UgYWxzbyBtaXNsZWQgeW91
Lg0KDQpUaGUgZXhwcmVzc2lvbiAiY29ucyA9PSAoKHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmlu
ZGV4X21hc2spIiBtaXN0YWtlbmx5DQphc3N1bWVzIHRoZSBxdWV1ZSBpcyBmdWxsIHdoZW4gd2Ug
Y3JlYXRlIGFuIGVtcHR5IHR3by1zbG90cyBxdWV1ZSAoaS5lLiBjdXJfaW5kZXggPSAwIGFuZCBj
b25zID0gMCkNCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5n
