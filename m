Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967A3EB4A1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhHMLh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 07:37:59 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:9783 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238157AbhHMLh7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Aug 2021 07:37:59 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Aug 2021 07:37:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1628854653; x=1660390653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DybQj8zJ2WA1fUp06lsGwurX76f2pTbeHJRqI+bRHCE=;
  b=axhBK51LFBgbSO3BjErZxrMEYAtupvAYzo5A7YOqKjQ6ArPztD2VqQjO
   v2lkyM5KO9F44K0laHCGp4r+6dhJqMJD3Ytqn0YS3NO+BFz7fg54wYDGL
   HS6I5crWJ2fapr8wJurKcehbU2qteEuHz3RlQCEOhogcBrjndFaHexGck
   p7QJJKPYnDY7OmpKGd778aHsqEYfyFsTEeQc7nxoknwVf/Vbgr/6MHtrK
   E7Z0jha/Xv8EsK9X9mTD1FqQrGLlf+UilzvaLc7twNp+cM/hEKDvDqod9
   c7LFgp6Mi3PcN2O93CB0lL3y397VkG104U6qTi1QaUshOLrlMtiKmk5lb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="36739216"
X-IronPort-AV: E=Sophos;i="5.84,318,1620658800"; 
   d="scan'208";a="36739216"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 20:30:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf0cDm8tbb0HtCgtxrliOaKc16TIyxIlPca9bmwonHTozhhyR82VPT4CRJE70sHAfpi+iMav1dxXPOS23mQP7XBZwyAVJGz/ohbyCdZ3mMQp2e7EHNsgPDb84X5AexQbORJdA9f6xk6A18h+pSsiCKdzEA/VTGqLBF6ZRdGNim4s/549d08nMRT+69ijhpPEiWRsLHt8MqyXTT8KfD3gbLGkawse6Eic17H8UoX7R4JfELJBmPyUnf96tiAEU9k5Fd+SNW20WtXt9g5GcGS2gB5dF9F+YE8HDxThv7e4SXXVUEcTolDjdEQYFMx6V2z5vrsYiPhexEIFwAowsiu1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DybQj8zJ2WA1fUp06lsGwurX76f2pTbeHJRqI+bRHCE=;
 b=K0+W8zLwhyr90zkWk6jDuLQ37QCn3Bv2FeqiBK6NbhZhISXPGV24rhW1I3Wv4LeazdqNfYWU+8q/reFeKzYvIEjVVlD1HhAsh08PGoh8/j6ReCpDR3YpqNtw+xNOiGc2YuNwzgpXL/OdSuNVlvtrdKm4CP/WKv9E+6HWoq7A5UXeAPNyHY9u5VmjeZidSqqZ//pfRDPFrV4iVslRUZbjXrKJePU+SsVOiAMfutGtLdRCPfFG1wBjPPzITTzABA6sFfmwUX3jpyWp5lMXGdct66hxzScRLEs8hwLS1vE2OXXYIuVgkBEcCkVp0AOaND6CuptcVAG6NYrugU9tTZkMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DybQj8zJ2WA1fUp06lsGwurX76f2pTbeHJRqI+bRHCE=;
 b=ML72yMdo88OGxm9jZV0zUq6JUDMUhpFM7HvwHp3r3B+z4SaOeDhQmk85gbZ5YaQ8Rfdu/NRRlQUCR8Yayrr4BjQZyopzIBZtBnKxS1yQTJF/F/J9wea0wG/Wa9lXO2KRfqqSPws6L1/PfIX99262IVYLoC01UC9HmxFuQmxnHNw=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB2243.jpnprd01.prod.outlook.com (2603:1096:603:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 13 Aug
 2021 11:30:17 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 11:30:17 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Remove duplicate umem assignment
Thread-Topic: [PATCH] RDMA/rxe: Remove duplicate umem assignment
Thread-Index: AQHXkAgvwoorviCN5UWrf8pZpfszMKtxTRuA
Date:   Fri, 13 Aug 2021 11:30:17 +0000
Message-ID: <611657C7.1080100@fujitsu.com>
References: <20210813055729.19885-1-mie@igel.co.jp>
In-Reply-To: <20210813055729.19885-1-mie@igel.co.jp>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: igel.co.jp; dkim=none (message not signed)
 header.d=none;igel.co.jp; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8413ed34-a892-4d60-b8e8-08d95e4dba32
x-ms-traffictypediagnostic: OSAPR01MB2243:
x-microsoft-antispam-prvs: <OSAPR01MB2243AA8F4EBDFA7B22A8F8F083FA9@OSAPR01MB2243.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeQ2OkeC7gdtN+Hjji7RdVBwExnwR7PyRlO+k/v0k1OFH3RakLgMGNnvNeoJv7GeEAaqu9LgwUQjZ21v/C+PHsJ+CTZms34E5fk4XtU9KB/ANBgufBakv7g1/JPKvn0q3MW4fRnzPmZy3/1iWkYK5bs+SQOq6mYQDzpChTQ82WRv+0r0dSlMV9ckFNPq+q88O94TQ7y/lsBe/eP0PLYK4Bh4ICukRmUmWNHgHMQqVfmqna+ktMihGw5nWgkeYtwVZzTyOxFvyyuvlS6sR6GZk5nqGHkw8+lIfWDa9wKrT0PaJN1zp8DtLIxemBMTG3huWzBPCFppiTYVlsLC1q/UjO0JwW2x7G9uBe18meREt90uGwZicmDUmpR0ogM/u2ntpXbKGJ0Oa3izk3Rx2WDes5jg0HD8bZwJ1uQwi14MKfluwxMceeJytMB5Bn3DpJQY/RWZAutYSRljNtWr5svMLbhI1IwXkeYc2uFLKzPqKKEmA/044A3FKp+DFisb+1OtbUWgL1u6OECrBp3hVxrso1r16jrOX+UrENNGhMNW+D8WbZZJQEIcZB++YxTA4klNv7+ScGrFt+n4YZr0BZy11apvSP9HauTFwr9KH4wqeGWc68CT2Go6byK8QuryYcecyOhMUT9mhtWnrAh7YK5SQIe6ubaDQGkYxohqbF6Yz95Jo/uIMtagEdAnRbVVCvEUCypS58k8InUHJWOdcuM11eQnyCmiKtcJM0m/6rO9niDZAIQ+veSaeX6aC8EcRN9lqjSjoZYDWJRodZPVOk6cw8I3FK2trgqUZyLrTJRiXi8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(33656002)(5660300002)(6916009)(186003)(66556008)(66446008)(38100700002)(86362001)(54906003)(2616005)(38070700005)(26005)(85182001)(122000001)(966005)(53546011)(87266011)(6506007)(4744005)(6512007)(91956017)(71200400001)(76116006)(66946007)(6486002)(8936002)(36756003)(4326008)(66476007)(64756008)(478600001)(2906002)(316002)(83380400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L3ozdVlDRisxSDRaNDRjUEJtM2hQNDBSS1BJRXllTjFpcHZTdHB6aW5GeVZr?=
 =?gb2312?B?N1ptSHMzVjNzWjZLT2gyNFZFb0NrWGxWcFZJSjB1b2E4RXNKUU9NcHpWVW95?=
 =?gb2312?B?UVUvcWpRSWx6dm9MbFMxOXJHSk5qMVZBMmtHQUpROTc4L0NtdXBFQlNuMENm?=
 =?gb2312?B?OEFxalVRRVc3QVgwTVpTUitWVWwycXByN0ZaZEo3OVFVeUd2ZzJHRitmeXp6?=
 =?gb2312?B?N2s4UnkrYWJsRHVsckgvUFBYNWpoY2tQVVJ6d29jaFVDM004UFNNbGUrVW44?=
 =?gb2312?B?bzEyVUxDYVNFTU9rRjhBMkswNnFYb09BbGh5cG0vRWhlTk83bktuanl3K083?=
 =?gb2312?B?TFovMys2bnJJVXRsUnNLTmpnekhRQU4rSWhCaEQyKzV3OVhUemNTd3h1N2lM?=
 =?gb2312?B?Y3RzZ0QxK3NwbkdyM3Fwem9LTmV5QTd6RG9Fd3duWkFSV3dSNytvbFNUYmJR?=
 =?gb2312?B?MDdvRHZvL0NyNWphNUZHVnBDUTRGeXhUaTB6R2JJN2ZXWkh0MVQraTNKY1pv?=
 =?gb2312?B?RHNqMnhvKy9oTE9oUEpzd0dKYXZyUjlkc1pGUzJCUUhRYVkrUlpCRHNLSGFn?=
 =?gb2312?B?V2xqZTUrTTN2bElMNHUwMTdFMlc2SDk2UFFpbU9uSnVuanFIRUVOMXNZbFRN?=
 =?gb2312?B?d0FTZXNpWWo0ZHJseFhQNG5pbEhFYVFrbXhPclRMR0JyS3R4cUtMVlRTbHBo?=
 =?gb2312?B?cGRnV2N6dVVEOFlaWWJ2ZXpxQlpNWEo2a01FbktHdi90UjZCZFlGMDhmbEt5?=
 =?gb2312?B?ZFc4dDJ6N0dhM2NHZ3ZOZEhBTzZKclgzQ0JlK0JrSVAwdzdYdkhyRmcxekFv?=
 =?gb2312?B?dDRHNEtFVldQbGpzd1B0MTFGMFhiWXMraUtxcmlWVnY1MzVWWFNaR0pkd1pz?=
 =?gb2312?B?WVp1b3B3MS8yejh0aG1DampBcXVheXlyZzdrdk5FaVNxSk5GeEthZFA0UkNn?=
 =?gb2312?B?NkYxQXJxZ2RmaHlYT1NLTldWWTZEUm9vZUI1eHh6ZWFoVkV5cDhuVVhoR3FV?=
 =?gb2312?B?cnVaRFQ1NXFZMDNOcWFQbFVBQXA4cWF2aWR3WlRHZjRDbGZJWlpiQldZelMv?=
 =?gb2312?B?NS9YQUtvYnVOc3JXS3hvd1JHamxEOWloY0tUbXRld09mc3ZKSHJIeGhsQlVT?=
 =?gb2312?B?NkNkalB3TGpBZzRDV3NqNURTcFBlTmFBdDR5ZEsxcGh5bUoxaXhEd2U4MEs5?=
 =?gb2312?B?VTVzQTV2UVN3b0phamovNWZXZGp5RUd1ZWFOMmFQdkJQT0dKZUpjV2V4WlJQ?=
 =?gb2312?B?RHdoeHF2M2RZaEdOb2grdWNsa0ZBK3dIWSt1WE9tMlF1U0lzc1VTalJLOGxM?=
 =?gb2312?B?dkJlZ0lSMVBkZ1FFamhZSUgvSU9FRlhpakJZUDdlMXA0Q0NLNE56cDNSblkr?=
 =?gb2312?B?bWsweHNPSjNxOVNqVFVMY2lvSEY1bUU0Y1RHa3RKdncwRnd1aWtLY3hPVTYv?=
 =?gb2312?B?NTZTTU1tLzZENWF3ak42RitTbENVNkxpakdBS2VkK1dpYVFsZXdnWExBbU16?=
 =?gb2312?B?UjJVYUhXNllQa3g1TFhOUHlGQkF0bzNxYXluOGg0SitjZFRUUUJQL0VIRFBV?=
 =?gb2312?B?dGdZTXFMUGJqVklHVy8wRktveUpQcFBaREFsbFJyaTltN3p3Zjdvb1dLQ1Rx?=
 =?gb2312?B?ZSsxUktiaFVqS3FIVTAyUVBwYnJHczh6dlJBTXIzVW1OQ05VOExRbk5sVzR3?=
 =?gb2312?B?eDZGZmVZK1BHMGgyc2VqaTFkTXI4ajJzWEJkTU84cWRha2pnbk84aE51NHdm?=
 =?gb2312?Q?mp/sNOhgJA7YokS2vfoPgTBt0F1T+Z9wZd3F+uA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <F274D5CE895DC5448B593C6D309B0D0B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8413ed34-a892-4d60-b8e8-08d95e4dba32
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 11:30:17.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 373GpDZOwMy19Gbqvmb6rvHISL1NX3G5pkALd4iw7RYAx2gKZfYNN11C18I6OHAgTQjSdxO7HKhD27xUtP4MiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2243
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGksDQoNCk15IHNhbWUgZml4WzFdIGhhcyBiZWVuIG1lcmdlZCBpbnRvIGZvci1uZXh0IGJyYW5j
aCBvbiByZG1hIGJ1dCBpdCBpcw0Kbm90IG1lcmdlZCBpbnRvIG1haW5saW5lIGZvciBub3cuDQoN
ClsxXToNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Jk
bWEvcmRtYS5naXQvY29tbWl0Lz9pZD1jZGJkYjc3MjQ3NDBmNjJkMTE1MTk2NzllMTFjZjY3M2Nk
OWQ2YzhmDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KDQpPbiAyMDIxLzgvMTMgMTM6NTcs
IFNodW5zdWtlIE1pZSB3cm90ZToNCj4gV2hpbGUgaW5pdGlhbGl6YXRpb24gb2YgcnhlX21yLCBt
ci0+dW1lbSBpcyBhc3NpZ25lZCBkdXBsaWNhdGUuIFJlbW92ZQ0KPiB0aGUgcmVkdW5kYW50IGNv
ZGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+DQo+
IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyB8IDEgLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jDQo+IGluZGV4IDczYmJhZmQzMjU1NC4uNmUyZTBkYTJlNTBkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gQEAgLTEyMiw3ICsxMjIsNiBAQCBpbnQgcnhlX21yX2lu
aXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92
YSwNCj4gIAkJZ290byBlcnIxOw0KPiAgCX0NCj4gIA0KPiAtCW1yLT51bWVtID0gdW1lbTsNCj4g
IAludW1fYnVmID0gaWJfdW1lbV9udW1fcGFnZXModW1lbSk7DQo+ICANCj4gIAlyeGVfbXJfaW5p
dChhY2Nlc3MsIG1yKTsNCg==
