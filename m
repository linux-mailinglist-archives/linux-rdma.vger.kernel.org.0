Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F573AE431
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFUHaU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 03:30:20 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:17976 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUHaT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 03:30:19 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 03:30:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624260487; x=1655796487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YOUy97Jlpfy9Tb3ascT1ajcr1Eqo95Uc5Wc6cCftshE=;
  b=FmDMUzgUVHTteFT7xTwEIowm1c2/G3bRKBZJvmmjKHoD9A/WQUbJQSFj
   94DcMN2/D/qxrtIWjtKboHjBUy4v7pg3g6E4FyW7tAJR5tdIBH0AZC3+8
   hiofnFTHE0YICnnqwEoa8DxMg03/efa6A5wZlAMxoUF3GZLgDMBXvXBHY
   WJiqe79fbySeaquoYzq3jmjSYklfOrfYtK2rJK2eNrI6vE1MwHiKXuESn
   8IE4HpuTMIQTtoxFcVDS+gzrcI8r7gbhxqJOdvTy8w91sJSy4h3l+n4EM
   BWr9cPhmeZBsv6PsjzVkemZ6N+EU0dGfzlZf3GjcZiNQ6Lnm6VTIpMLda
   w==;
IronPort-SDR: CNNR2w3bkbQPSdB86u9VoAx+TD/zEzIH/SHM3iRWcFy2yRW4wLJCcP1g31QP8T5RkgjpuVoUYS
 8oTLFl6s4kfTVqaX5VqbqiSiAwrIOGrVqlUhi8IQLnBRwt0XqNtYsQRNlYLWJwKs52BKGl8Ngk
 ADzBxN+khnBR9rzrW1J1jmZ4DnHQ9nYcJv2LJKFhmM4ec5xuPWMpf9IqYMWTESJsl8ZCoUdEHi
 x2POwg0d8fkpuPZDFWkcwDqSAS08J7Wdg52SPsdCVWutgVmMIDiYv0c7KinjCuGwEnxrmesWRQ
 br0=
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="33252186"
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="33252186"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 16:20:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUJsVL0AyQpMrH4YU5NNwl8pwQtf9SZV29bv5AhBefLIgR0pO6znbhQe97FjD+Mw7T1XuBtEaTA+yL4XPTmKxGz1byCdXAFRdfB7+PxhLKrc47jMBGONt7RkrfS17lh8Qw2U0Itfe+/giFh6Klh9f+cXgW+LS3CdYVuuadPCsGvpkLG9x5l6Jri56D15TM7WwuaHmlA+b9own6ykxj9QooqhKz7RSZHS3Afz7SSKwKHUaQJkWmrq39YAqj8HQQtZxWVwYfLFJB2SDovGkFt/kllk47yG5Mymy3RksNl0iSaQgdwWeS9mK+p29/ORZK4TVm2SaJsEOleESpQzfNXWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOUy97Jlpfy9Tb3ascT1ajcr1Eqo95Uc5Wc6cCftshE=;
 b=OxPcDQTdcMYalZmzh2K4QyevJLzKwHdxol1/ZptuxYIijIXMQJ8r0wNH8yWdiDNaPQAAuHmJliT/vDcpw3rzu37aml96CD53T1sU7I3C0KuS1M7lEUY/XKGjNvKeM8EG7cHTpXbdr4Y2kXTzrdATBIeqwwY95TmO6f5Yl824g8zPgXh+ePwRcjiZr9/QNF+6i1kXdvrObIUmZicB/u7Ia5n0NbqqlmJQjzxMnZdsyx8Z8FCijbm+uVdkuIiyGHfOUUby0coRzA8RmjukpOcCrXMa3LUA8wyyC/+5smAqx/hjCEqdfLZHKHYiH6nbu0sqHDEjUqdxtNNfL84BVQfudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOUy97Jlpfy9Tb3ascT1ajcr1Eqo95Uc5Wc6cCftshE=;
 b=O7jXaZypfSBHJP4CSIV84+kYIKdmEWYX1m27kHs5hueFLxhAnycVf4pkf/jLzneMpS5U2udALxVwhZ4fGfHvSkeYRsIqZ0f2KtmUX4OVJhEO88CZrijyhFodWL9+5KNong2JIcryyJB9FbIkBXc83LSdV2PnVHmHKJ1MUA2brXI=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB3461.jpnprd01.prod.outlook.com (2603:1096:604:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 07:20:51 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8563:fad6:ddc7:fa72]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8563:fad6:ddc7:fa72%9]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 07:20:51 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "ice_yangxiao@163.com" <ice_yangxiao@163.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: Re: [PATCH] RDMA/rxe: Don't overwrite errno from ib_umem_get()
Thread-Topic: [PATCH] RDMA/rxe: Don't overwrite errno from ib_umem_get()
Thread-Index: AQHXZmrLa290Kfn07EulYtWgpiP08KseDtsA
Date:   Mon, 21 Jun 2021 07:20:51 +0000
Message-ID: <60D03DA0.6060007@fujitsu.com>
References: <20210621065749.6596-1-ice_yangxiao@163.com>
In-Reply-To: <20210621065749.6596-1-ice_yangxiao@163.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a76d21-a9a6-4d75-7419-08d9348519e6
x-ms-traffictypediagnostic: OSBPR01MB3461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB34610C9CF1B777AECBE444AE830A9@OSBPR01MB3461.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYmc7zV9h2KTbrs2lsI9RSTHep8zcWGXBuri5RAI2k9Y1Qlpr4a8RM8iaHana7A2SGA/89wJ+ss3vTdGH/lbPklUKELSEnMphnB2rovBMUUb0oWNbNop8b+tOpezGDgcEooY4siFtBLbEWwlq47LlvgH2cc6qydaiKA9GdKFUYE0WkHKuYoRUArnHuUzWGbp/hHOUOt9TfDKtSA/owVFgw6yfYsyoRDJMuTFJuTIcL/cpAuQkZr6Mft8+dAac/7uRiYnT5WzvZ3sa9N3v4g97nklLEKjiDbau9PZ3qMeYz1du7qIGdr3CuQtAffa2JXm3SY3ihRVcX6T3okCj1CEKH56GYMa2Om/xGUnIPLXhgUrIiiJ+QNFWaB5AyKbaR05jkoGPu9+bLcL3oMD18O/xZeDSzD0SMsaGR2fJ5h6Ldz7HIaZQEvozW39ufaE/Dq6NidtDndzmXPYSTbPh1NQl3RJpeThoeANSawxdFH7+F+IcCkeBwON2j10zS+dZAetyeOCShq/BL4Gtg2v08DUsyNxb3uto8uz6VubvFR8xZGcpIa8yCmDzWqEkHe29kg9rGlJdkCWGl06tq3/Aigg34T2EcXDJJlv4M/Hh/lLYq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(316002)(107886003)(87266011)(6512007)(2906002)(86362001)(71200400001)(478600001)(38100700002)(122000001)(33656002)(2616005)(5660300002)(8676002)(91956017)(66476007)(8936002)(76116006)(53546011)(26005)(6916009)(6486002)(66556008)(85182001)(66446008)(64756008)(4326008)(186003)(83380400001)(6506007)(54906003)(66946007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZUlHQ2YrVU52Smd1Mkl6OXlhMGN5OXpOUENxVFBTYnBkVDU2cGlmSkFkUGV1?=
 =?gb2312?B?N3hERzhNSlEvWWhzZDJPbmpFS3FEQWVaajF1dWNETWNmMDhOUEhSa25lKytD?=
 =?gb2312?B?Y2ZpUXc0MTduRnBzZTk4UEFMSjFuN3NWS1QxWURXd1dvcFd6Rm5wUllTQXM0?=
 =?gb2312?B?UDZMaFZ0NXBvTFJFRzFobXlOWjh4WGFRcXJDbk9nM2F0bEhJUkVSUjlraCtt?=
 =?gb2312?B?eS85UENjbVFpWm1Xc0RpYVd2UWtCZTJNckhVNGhqOGV4RlNwaXZVclhBRzIw?=
 =?gb2312?B?bVpYMlNjRUhEZHlKWXkzbUFwemlJem9HbFNqT2RTKy83SmJMTVRrdVBPVGNx?=
 =?gb2312?B?b3l2a3EyWncvQ1pxTWN5d3dYdzVYZ01rZ0VoaG1YK2Q1WENPNWNabmNVUm1F?=
 =?gb2312?B?Q1pkNHhwM0J2cnpwT21hQklvZGZLU3BSUjMyOTlYeWg3REpRazFtYmFGZ2RR?=
 =?gb2312?B?OVRGS1NRMW9nQnVrYTdnTm0xa29DemFRU2VFdFRqOThVeXhWNXNUelRRaFJU?=
 =?gb2312?B?d2JNUkhPL1lFZ1ZXYTFLZUc0WnUwNXBicUxjUnlEbHVOT0lESzhzRGtRR25R?=
 =?gb2312?B?WDQ0ZHVBYmZLN0RONVd1LzB2R1RyZE1PSHNlMU90RW5tNUpGUVJmK0JlM2g1?=
 =?gb2312?B?SlBZZWRqcThNWWJwQncwaU9nTUFJRCtKdVBIQWF3aXFOMzJhZzZqdGZ4cjJL?=
 =?gb2312?B?K3N6TTJvQXREWEErd2JqS2taR3dIb3lSZUNaMndQaGZtME5YUlRRZktjT1hw?=
 =?gb2312?B?VzVSSks1RDRFZlZvd3ZQSWp0NnJvWHZmWWp3VytGMEx3elBXeXIzL0Q3RFVC?=
 =?gb2312?B?UWdocFgvSVRDbzhBc0RDYlF4aWNQV3BpNTZhVmUvaTVuRUVUNmEzMWhoeEgx?=
 =?gb2312?B?M2c4Z1FpUXZYU3BGWHVjeWtXd1hmNTZ0NVNHdEQwZ1Y4V2tzNjZ1cldtTlZE?=
 =?gb2312?B?bW9MWUJlYU8yalgvbFVETTYvOTBmN1psVi9kYkYyY3F5Yzc1SXJ4ZUtuSVZQ?=
 =?gb2312?B?Nlhaa1hRTlBGb3FudS9zN3UzNVhQRjZEUkR4Vi8yVWxxSDhwR3Nma1ZSK0RX?=
 =?gb2312?B?dEVrekplK0pOY3JWMmR1RVlLaU5yL1VzWlVBa3RQYUxXQUlmdGJURzdPeDd1?=
 =?gb2312?B?bEpOTStJMVFjempCMWVzUE9XRmI2eVhabHl6Zmk4d2N4L3RtRTl4SEhkc1Jx?=
 =?gb2312?B?RkgrcU41TUV4VUlHdXlHRVBjY1VRRUthSzFSMkZGUENoUm9qRnNrV2xFajVm?=
 =?gb2312?B?cVcxZE9RNDNvRUdLWFI2a3YvWWRmUUcydDlJNjl5MW5HbER2VVNsSVRCL2tK?=
 =?gb2312?B?WGkweS9MdXFnRGtlSFdVR3ZicFowRlBhTDhFRkwxTWZzM0FHeUVVN0YwaFg2?=
 =?gb2312?B?WHIzVzc0L0pBM0xJMTQ4eHFtNzVFQlIvNWNJZnJtSTZ5cXhTTnFPM3lLMk1V?=
 =?gb2312?B?bWtIcmg2MzRXLytnY2c3aDdMOWZuRmJrUE1QbDlIcDhmZ24vWUxyVUNNU01H?=
 =?gb2312?B?QmVMczBUeWVtMjFjZWdhei82V3lVQzR6TjNQakhBZUxJRSthRGhTWStpM21Z?=
 =?gb2312?B?SjkzUlZTVlZzcTVuZTZkeWNTSWtMTzZRWVFXajF0YTJmU1gvaVJScWpNWWhS?=
 =?gb2312?B?N3ZvMnVkek1SczRqSEpranBsLzQ2bW80S0VESi92Y2lVZ01pUEdWeFhzekIz?=
 =?gb2312?B?SVJlWkpQZzZERHlqRGVtTzRPMDc3Mk5Cd0xCd2I0KzhueUV1OUQ2L2ZjWVpk?=
 =?gb2312?Q?fdRvQUqV6I8Mv62km80AuwtwuEtGngZxWaYK+oO?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <AD80B67A540D374D839BE6E24E4460D8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a76d21-a9a6-4d75-7419-08d9348519e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 07:20:51.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYcuVDbeX2r00LQwW6MRXuzieCrMG0zk5JdG719jHkbKqa94ZaxhP+tNQ8HoOap4c3c+YK3fTMpfBFjBCfixbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3461
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS82LzIxIDE0OjU3LCBpY2VfeWFuZ3hpYW9AMTYzLmNvbSB3cm90ZToNCj4gRnJvbTog
WGlhbyBZYW5nIDx5YW5neC5qeUBjbi5mdWppdHN1LmNvbT4NCg0KSGksDQoNClNvcnJ5IGZvciB0
aGUgd3JvbmcgbWFpbCBhZGRyZXNzIGFuZCBJIGhhdmUgcmVzZW50IHRoZSBwYXRjaC4NCg0KPiBy
eGVfbXJfaW5pdF91c2VyKCkgYWx3YXlzIHJldHVybnMgdGhlIGZpeGVkIC1FSU5WQUwgd2hlbiBp
Yl91bWVtX2dldCgpDQo+IGZhaWxzIHNvIGl0J3MgaGFyZCBmb3IgdXNlciB0byBrbm93IHdoaWNo
IGFjdHVhbCBlcnJvciBoYXBwZW5zIGluDQo+IGliX3VtZW1fZ2V0KCkuICBGb3IgZXhhbXBsZSwg
aWJfdW1lbV9nZXQoKSB3aWxsIHJldHVybiAtRU9QTk9UU1VQUA0KPiB3aGVuIHRyeWluZyB0byBw
aW4gcGFnZXMgb24gYSBEQVggZmlsZS4NCj4NCj4gUmV0dXJuIGFjdHVhbCBlcnJvciBhcyBtbHg0
L21seDUgZG9lcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBjbi5m
dWppdHN1LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5j
IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiBpbmRleCA5ZjYzOTQ3YmFiMTIu
LmZlMmI3ZDIyMzE4MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IEBA
IC0xMzUsNyArMTM1LDcgQEAgaW50IHJ4ZV9tcl9pbml0X3VzZXIoc3RydWN0IHJ4ZV9wZCAqcGQs
IHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQo+ICAJaWYgKElTX0VSUih1bWVtKSkg
ew0KPiAgCQlwcl93YXJuKCJlcnIgJWQgZnJvbSByeGVfdW1lbV9nZXRcbiIsDQo+ICAJCQkoaW50
KVBUUl9FUlIodW1lbSkpOw0KPiAtCQllcnIgPSAtRUlOVkFMOw0KPiArCQllcnIgPSBQVFJfRVJS
KHVtZW0pOw0KPiAgCQlnb3RvIGVycjE7DQo+ICAJfQ0KPiAgDQo=
