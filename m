Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47AB483FFB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiADKiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 05:38:23 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:31189 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbiADKiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 05:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641292702; x=1672828702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1CtwKWnZIrn3adDdPMyPyhJUxW75RHjvuwOZ4lf5Adg=;
  b=fCGOk9OEB8qSpzxv/Iuhjgz2KL6psShPw3XxLIBhsPoOWtWa3vtpfC+t
   OOug24BnCkvJv29GszoCopxUJAEh1COLTgZ8h0oVIMeTyimVqHsxpfgND
   bX4afKZ0a/Q5qJWO8UcNaudgL+zEb8rX76B1U4Ldl1X5YZ36NX2z1tgs/
   gV4cXEps8PSt0y0sROBqZuX1kp7CuXUh6VP9ezUdrM50pGNuQL5wmU+QS
   oM1aDVwk7pMM3E2qQ8EiY+tGEHl0bhAm82fYCcHdH7jsZpNFqvZCSqbfg
   mzuchBZdq3UxzYA31590VHFWYCu9mnUbBZDFnFQBwdm8h5O1tGkCClSc/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="47076023"
X-IronPort-AV: E=Sophos;i="5.88,260,1635174000"; 
   d="scan'208";a="47076023"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 19:38:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD5cusRcgcNFxTwTLjtDakvK4Kqv4pLRcOCIyZJhaGWbNTsKCsF1f6GYexlI68wMmkMKBqtPVq3HGlxL5GoRXgSeVLI6eMShT5vkZC1ev7Li46ce40kYzsXpDTIy8oMmpmU0OA9QRyjkMIEHboALMpn2hEaWC1FzE6pBMuqi7wfM+SsPXkwdM50wFsLwXMHELCBBFanXhRZP6l606Dn8JDhZ8aNUqPOi0kEx7dcJ4hCEUr/NB9AqwW+8nbLhbvclHzlsSNdJUjgn3IsxrCGCB38K/cWWc3j0Huv0hh69vtdehn5/8qWYvcrPP7MFQbEBJwiXQR++yqEficbe4bcbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CtwKWnZIrn3adDdPMyPyhJUxW75RHjvuwOZ4lf5Adg=;
 b=SvXXUq/3hSqlhwn+AvNC30IRhevWV3MO3ZPdfI6YwLpBpjyCh5pbkSPmjwH0Ga34ucDnkW40lWBVSLX6kNjVt3uDR4bCKzmVay2TX7TQw8L1KUw9EuP//LklvN9ollHF5RZEubwiqxU3DSkeNEegDsmcBE6p3nfLkw0FFS0ixfSRljoIMpqRZ7U+mEQKS/BQTt5LfK4T5hHvuuijNObhqA+pF1xMMj34iKYvFswUNn1aW3au6puVmrZPNaHXnM9Myet6sMCXD4Btho7U6NeYI7c6HAw3WxBNrOEhO2tU+dpkSo/SkU7QvtOfv88bXHlishsimB4GDfDOiHzVAhV8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CtwKWnZIrn3adDdPMyPyhJUxW75RHjvuwOZ4lf5Adg=;
 b=Gk57iQtVP2NQbVeqxUSWogfTrvcxzdudByNzSDccs7AXbLI781gXZPOF0rXBehSV9tp7Dmau5BpiBxs8b+6q+JnA9/jX49edTCJkPVkjyQntUYWWgvoxcUFi7bY0RCM1oBvT6FXh06YBC3ByeinZ8mM041GeiE/9SAY9P+/WrsY=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB7506.jpnprd01.prod.outlook.com (2603:1096:400:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 10:38:16 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Tue, 4 Jan 2022
 10:38:16 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] RDMA/rxe: Get rid of redundant plus
Thread-Topic: [PATCH v2] RDMA/rxe: Get rid of redundant plus
Thread-Index: AQHYAQnJmOX9MHf9D066Gi6KfTaIkqxSfmgAgAAt64A=
Date:   Tue, 4 Jan 2022 10:38:16 +0000
Message-ID: <028697c5-5670-61dc-b3a3-6e7f7924780c@fujitsu.com>
References: <20220104012406.27580-1-lizhijian@fujitsu.com>
 <YdP9HHjeA8WPiBvf@infradead.org>
In-Reply-To: <YdP9HHjeA8WPiBvf@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d44cdf-70e7-4803-7d44-08d9cf6e5156
x-ms-traffictypediagnostic: TYCPR01MB7506:EE_
x-microsoft-antispam-prvs: <TYCPR01MB75068F40DBDDEAF0BDE4A202A54A9@TYCPR01MB7506.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2ktGy2FMXp7kedyvpF+McEX5PQ/V/K2X1HGMKeHAUNe67P1LnBN3nd5XPPlL27NJAsL4BtiX/dyP04z0idda4KnSvc2DfkkIk9/Lgiz9dHOxZRafuQXn5A0/GiUDKXzojZ5OoQU15/7ChqbrtLPpfbVZBZ+dYimDW7YB8nS9AUgkc8Ddvd/CLzy842+zGwNgyLkagvs9R8OdzkCB2SsboXnOi8kit7OxUYR+fBSGScpTVZaam65R4fj5ByEPJw2g8HxeKXdwnql342zIzIs0xoZTr0BsyYgBLRSHppWBEKXhHFID+BK2YNpts824glj2DzpqJu5vZ0OwVJ6Re1cS6m+QG3E19lJi4mA2xOWw4ALlMsq0HAZBF9KFUicq2DgBr/tNKOybT8zdGvbo1nvQiIqVxGFBF7k8rN8kh8y/7T6yDzZHPaTXJxd+slSqxXOn+J/e1TTVszlzxi2KZHGM+tYmY6Hsk0bTRUrBa7BfwxSkegkFRjT2jmCPQAwwFPb575t0Y8OUvrKVk72Ur84MQIyxyrZVlWgYB1m0XpopUAXhR6qegujQBQKg3nyPDmx7MOoQbMvOi9h3PDD6GM2R3q2sJXjkxF58BH0m1lz0BdKJ9O1OHXNj4/51lR80uqyHgjsdR2fs/chTRvlXQ+S7uS6KTEG8TTqBHQkvGz9udxU9u4SyckbfElNI2A97JoXDu1nzi68YwQqfxQKjZtzdUIHWkH1AmfjplwqIh8mNFKxdaejqbaffGdEvPqLO1G+V7vZuuS/eg5OJ+qIWNOWsVeu4n6TQKs7W+MIFK2y+i8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(316002)(83380400001)(66446008)(2906002)(66556008)(86362001)(82960400001)(8676002)(85182001)(38100700002)(64756008)(54906003)(66476007)(31696002)(186003)(122000001)(76116006)(53546011)(6512007)(31686004)(2616005)(6486002)(36756003)(107886003)(66946007)(38070700005)(5660300002)(6506007)(4326008)(71200400001)(6916009)(26005)(508600001)(8936002)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXFnbHljdFE5czZFN0JvSXp3YTJvREVPZ2w0cnN2RmpQVko2ZStXSW1VMUor?=
 =?utf-8?B?bXJ4aEhHQ1FDLy9RRjNEbFBKRnR5bWhXbDk5MXh1VS9SNGNFNklxaERVQ3Aw?=
 =?utf-8?B?SFVLcnhyb1RPeXlkZEtmQXRlV3JqaUtyWXlBZldTbCtCbTZyRDZNZVkrMytZ?=
 =?utf-8?B?YXJvZFJ6NjZwYmw2WjI5QU9DY1BVZUV1MVN1NlJocjhyRnFJMiszcDN6UEVt?=
 =?utf-8?B?cndpSTFRZHRUMzRneDJMSnNZSnVOYUd5ZVdRc1Y5UW9UbFBoS1RPdUt5aEdL?=
 =?utf-8?B?ZVlZbU5TTFAxVit1VXVJaERueDhueXNKYjYzNm1UTU9EMHRzUXZzUW5ZVUZa?=
 =?utf-8?B?RnRCTk93TTFuVXBWYmNuNkcyVFI0d0wwL1RRK1lreldqSXBhNmdXdXU2aDlQ?=
 =?utf-8?B?emQzclFOd0xweGYvT2Y5NkFLQmpSY3QvRHZrQi92K1k0c2VVVjJKR0NydlMv?=
 =?utf-8?B?Y0V6eGtkRHN1TVVzdStWbm4vb3I1WHlzdUpkakYzZ0ZDNElhMmcraVdVNWlG?=
 =?utf-8?B?RHJFQ2QwenJWbzZiUnI1a1Vac2JDUEozMUJ3cUJpVGFWayt0anhQQk9vVFR3?=
 =?utf-8?B?MEh6NmRiMndTNEN6cFNDT1p1RGdyUEEyQk9WeHhiZldubm9mOUVmUjJ3MkY3?=
 =?utf-8?B?c2pZU0FVY0dzRGNmRVJkYnIvRElFVExSYzR0ZzVuR1JMOGdJZng3RllnUExW?=
 =?utf-8?B?eHB1ejlHRnZLOFIrZkVoMFNZS3pIc01VSG8rckV2cldnaHRqT2VlSHVORUZu?=
 =?utf-8?B?UzlLRE42TENSQmx5S0RocVk0Nkl3SlZwVVpINjdzTXZFVWJsZ09IWERpVFNy?=
 =?utf-8?B?aGtUVWdDME5pNHhhUjdaWXBNQk9GeXBMQmREckptdXJwRmVIS0thTlp6UTJV?=
 =?utf-8?B?RnVLOW9ZVnlwT1U5TFJYQU5LREloSW9tTlh0amtPTmQxekRsQlIzSkpDbHIz?=
 =?utf-8?B?QVRUVU5IWXB2b3VKWVZ4L1JhQWpTRnNVNXB6akpoYWZhRXRnL0Fla3pBVlA2?=
 =?utf-8?B?enFmV3V6QXhlTlBrTmUzenVYdDVhTEdjQ1VLSzFUZlhDNVppVitXTExXSndn?=
 =?utf-8?B?WVl5aFVVa0k1dFVKK1BaRkcxS05GbGpuRlFTZ2ZLaVcrTGh2c09XTU1ZbWI5?=
 =?utf-8?B?KzVmQS95OElVbkRnOEpsK25oZ1hGcnBpNFJBUGxNbDdscWN3d2JSaUZJNVRC?=
 =?utf-8?B?SFBDZFRwZkYzcjUxd0xXU2Jxa3A2V0EwTUdvbGxNQkpHQURyUmtIcFZtckFz?=
 =?utf-8?B?NW9SZmRVL3ViL3V6VUp5cEpheGFMOERtaWxqcjJIVW5UTmZCZWd0ajZBcXc0?=
 =?utf-8?B?ZGhCTnRPbXVjenBHL3hoR0N4MTh0YzNQMmYvUmR2SmdiTlZlSWxNTWVLRWty?=
 =?utf-8?B?ZTZ4Y1lzUFhBYUlGOXZNRlJvZ1ZCdEhGTEY3UUxSSllKMEhIUzV5aTNFdnhD?=
 =?utf-8?B?NUllVnYzMWovdXIvYUd0SVJOckFFcUt6U0tNNHBRVXVHREZXRVZNNE0vNzJR?=
 =?utf-8?B?Y1BtWTBvNnh2V0pqQzl1bGlvRVlmQUhZVkcvczVkbzByeGhxWGh3aWNXS1M2?=
 =?utf-8?B?MlNub0dqTThNZDRWSjNabUsyRzlwa0F5VGhaZVhvY0x0VDJhUWJYbnE5ekdV?=
 =?utf-8?B?K3YyUXVVbHVuRzQ0aVlSd3dmb1JHWmVtSW41QmZtZUhJQ0N0WmdaSlY2eDlj?=
 =?utf-8?B?WkdmOWFZbkI4NFVyZ1dMMzhUcGhwL1FUV1RjVW00aWExeTU2L3UxOVREVEZH?=
 =?utf-8?B?aWhBTXplWnRJOC8vU3c4b0p5V3pJYmVPVzZPaWZGcEZIVm8wcm11MGNoQlQy?=
 =?utf-8?B?aEFQOENzMGZUWFUzOENUQXprY3UzWmNmdkloaE9sV3F1WGRPOWxIRERCZUNO?=
 =?utf-8?B?QkZJSUowMjNQMkQzd2svREdHVExTays5ZFNTUUlFbFN3MjFwRmV2Q0VEaFdV?=
 =?utf-8?B?d3ZVbk4rbnU3QVBUb3hhWmxhNGU1QStmalg0WHg2WXZmWUpwelBmSUw4RkdJ?=
 =?utf-8?B?QVdJNGx5VmhzY3FoSnd1dnJHYWxpOTFmTjNHeUM3Q1l6Q3EyRHRKNlc4OVcv?=
 =?utf-8?B?S1FnelRJSjRSNWlPM0hBTmpXdmJSdVVtU3hPR2FWSkJOQ2FvK1ZNaU1UL3Yx?=
 =?utf-8?B?bXpUVDYza0FydWRuQ3BzSERBTDBBaFFyZDJVcFprZlV6SGdNRzN0UGN4TEYv?=
 =?utf-8?Q?g3y1/JkOdihhJpLfRbh/njk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B4780DDE532A4D82FB22A694B81554@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d44cdf-70e7-4803-7d44-08d9cf6e5156
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 10:38:16.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwXhIgwb+etz8oVBJFfKCaYRUYvDf5Mfee8+muUXinEgSqUXnFmL91AaZoLaH2HautuLtxwSf0LgCkCfSYHYcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA0LzAxLzIwMjIgMTU6NTQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBU
dWUsIEphbiAwNCwgMjAyMiBhdCAwOToyNDowNkFNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0K
Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmMNCj4+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29wY29kZS5jDQo+PiBAQCAtODc5LDkgKzg3
OSw5IEBAIHN0cnVjdCByeGVfb3Bjb2RlX2luZm8gcnhlX29wY29kZVtSWEVfTlVNX09QQ09ERV0g
PSB7DQo+PiAgIAkJCVtSWEVfQVRNRVRIXQk9IFJYRV9CVEhfQllURVMNCj4+ICAgCQkJCQkJKyBS
WEVfUkRFVEhfQllURVMNCj4+ICAgCQkJCQkJKyBSWEVfREVUSF9CWVRFUywNCj4+IC0JCQlbUlhF
X1BBWUxPQURdCT0gUlhFX0JUSF9CWVRFUyArDQo+PiArCQkJW1JYRV9QQVlMT0FEXQk9IFJYRV9C
VEhfQllURVMNCj4+ICAgCQkJCQkJKyBSWEVfQVRNRVRIX0JZVEVTDQo+PiAtCQkJCQkJKyBSWEVf
REVUSF9CWVRFUyArDQo+PiArCQkJCQkJKyBSWEVfREVUSF9CWVRFUw0KPj4gICAJCQkJCQkrIFJY
RV9SREVUSF9CWVRFUywNCj4+ICAgCQl9DQo+PiAgIAl9LA0KPj4gQEAgLTkwMCw5ICs5MDAsOSBA
QCBzdHJ1Y3QgcnhlX29wY29kZV9pbmZvIHJ4ZV9vcGNvZGVbUlhFX05VTV9PUENPREVdID0gew0K
Pj4gICAJCQlbUlhFX0FUTUVUSF0JPSBSWEVfQlRIX0JZVEVTDQo+PiAgIAkJCQkJCSsgUlhFX1JE
RVRIX0JZVEVTDQo+PiAgIAkJCQkJCSsgUlhFX0RFVEhfQllURVMsDQo+PiAtCQkJW1JYRV9QQVlM
T0FEXQk9IFJYRV9CVEhfQllURVMgKw0KPj4gKwkJCVtSWEVfUEFZTE9BRF0JPSBSWEVfQlRIX0JZ
VEVTDQo+PiAgIAkJCQkJCSsgUlhFX0FUTUVUSF9CWVRFUw0KPj4gLQkJCQkJCSsgUlhFX0RFVEhf
QllURVMgKw0KPj4gKwkJCQkJCSsgUlhFX0RFVEhfQllURVMNCj4+ICAgCQkJCQkJKyBSWEVfUkRF
VEhfQllURVMsDQo+PiAgIAkJfQ0KPj4gICAJfSwNCj4gUGxlYXNlIGZpeCB0aGlzIHVwIHRvIGFs
d2F5cyBoYXZlIHRoZSArIG9uIHRoZSBjb250aW51aW5nIGxpbmUgd2hpY2gNCj4gaXMgdGhlIG5v
cm1hbCBrZXJuZWwgc3R5bGUuDQpJJ20gc28gZ2xhZCB0byBoZWFyIHRoYXQsIGkgd2lsbCBhbHNv
IHVwZGF0ZSB0aGUgZXhpc3RpbmcgdW5jb252ZW50aW9uYWwgc3R5bGUgaW4gdGhpcyBmaWxlLg0K
