Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9572326A0D0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 10:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIOI0D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 04:26:03 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11412 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIOIKV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 04:10:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6076550005>; Tue, 15 Sep 2020 01:07:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 01:10:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Sep 2020 01:10:10 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 08:10:10 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 08:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYIa+UeQQmM9PjwSmSmsVJ+PxLj8mEykgt0QADxrtIiF88NAjEfWsD91+Y+Z6CnlqT+2rzo5CdV06gTIHqQW5C7fF7BPcYwtFro0dIyNEl2fcFAh1iePQAMgCSn5hfap0/ryUDMoSGqkbZzKrFf6Vo9l1KsEb4IEeGeoIRVT4YsHdHuYNnuAjVsL5N1EVgU5GrcEKk8hQyIeLDcIRt6oVs4D9WJpdZHa3FBaU2ZzLaY3XKLPhkGXXUWyhHntOSiktouO9DTM04LqBKMz9BDlFn/orQuMpZbTRKHBwA+s7SUYsL3F1roMCed0C5mB/MIqcCoYnmSx+m3Gm3zLg/Sa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4499LQUr1dmIIMmakEy0Q7hayDx34AQH7NJsn95u0Rc=;
 b=Hbi/qIo4WdX8SyEYjjpUxg6L7fELLvWMm9uTzlJpU+g2dnBLzQrleQQ/OXFUSkAix8Thmncx9jzEKYRUsOhSnMSH/hJZt6BMsIy+xSxHJsGkGmUK2iw7A1uY8GWhqB1WjvHUcZOsbCTZqn2mGnoWtXxvlYQM9nYkupB7HNE2ORqiXu2SOIKaVTIFM/t6amaBxZSSVGxC9eUTARGx/LDUDN6v/VuSm/CzgRKJWYASq2BeFMmpYkn9ZRWwqqRWN4cs0QUx4q6uxi/NubzH8KeGUONg/Vu4xosFXl9Jo2BojD3emA8cmL1w2mbxkuW3JCF0nGVxbLWMNdrufZ+16PZhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24)
 by BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 08:10:09 +0000
Received: from BN8PR12MB3220.namprd12.prod.outlook.com
 ([fe80::9d11:73e6:5f3e:e8e3]) by BN8PR12MB3220.namprd12.prod.outlook.com
 ([fe80::9d11:73e6:5f3e:e8e3%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:10:09 +0000
From:   Sergey Gorenko <sergeygo@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH] srp_daemon: Avoid extra permissions for the lock file
Thread-Topic: [PATCH] srp_daemon: Avoid extra permissions for the lock file
Thread-Index: AQHWdjOe+wgn5hPzo0iAnP+klkdJtalog4eAgADn4vA=
Date:   Tue, 15 Sep 2020 08:10:08 +0000
Message-ID: <BN8PR12MB32208D60B5E5E1AFBDBAF0CCBF200@BN8PR12MB3220.namprd12.prod.outlook.com>
References: <20200819141745.11005-1-sergeygo@nvidia.com>
 <7027c39a-1435-c4eb-d42f-c7fe272456a8@acm.org>
In-Reply-To: <7027c39a-1435-c4eb-d42f-c7fe272456a8@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [46.219.210.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930e0224-d4da-40b6-6449-08d8594ec335
x-ms-traffictypediagnostic: BN8PR12MB2947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB29472AB07D324F347AA1AB8EBF200@BN8PR12MB2947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxSLRPiE+AhW2CnD1ujHNgef2Tv8WXr4ay6GOpDL/BW12MhkG+d5IBD0/qgoJFWP4YgXhcsZbTAz6MfWK9FX2UeLscMm3omQPWN0iuHuD4MpvlvR9HJRTSKnEHjSrtFokhNzVwgrZPYst+Yku+owAG1aoYb3sFoVc1hLqyhsrj8hmiV0MYZfvHLS8Q9btbkXP+iiDxJXDsRjr5GaPPN9Lk3c/1Ed9WYHPjzmbuRFVtBvK3AmHqv9l4Gko6kY4AeszyzrwZi6U5e/PLpyufgW4omEategLZ99j+AR4C0Z2OwHejMN1ASn4CuYZouQF7Gs/XONNzCFh4YLjtgo0jO6ibri+3cH63pCbZLgE1Rapr0c6zZyB0Y81aFJE6Wxnf5W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3220.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(64756008)(66446008)(86362001)(55236004)(6506007)(53546011)(2906002)(54906003)(5660300002)(55016002)(6916009)(9686003)(478600001)(76116006)(8936002)(66556008)(66476007)(7696005)(33656002)(71200400001)(66946007)(52536014)(8676002)(186003)(26005)(4326008)(107886003)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DQplv7z9KPFGb8aPoh/qd9L817WqsQziZ6NOn8NrH/MTWkNeHIzwqLks6kZ7byNrvvha5vnnHsztvPE5yTKhwb0VDe8z6L6BiF9/GzFw7hnf5x4CRl21F6k7dAI18wDoOk8KmMudwrKBPyua60ylvrj1d2z9zoVjhdQdPHkVbsf6K55zDfm1Ge56aTSmwD9/4wg6qetgoHjCFTgDs/pQxvn3e6LeMWwjwl/r2NU9dy0zUVUmPiAsSEmOyvedvJMHxU9sqDV/lBA3sg6IYp54vk4xFQ2gmMbOKD7L6oEYgy0MhWDQULtlLN/nWdYYfcZ0rRFvH2Tt45y5bByIqyIZqTCH0Ta69oNaprBrniLRLiqF8Ro4px2BMXLpt3jSfnc7d9ied+O73+Mc0iGz7v9jMCUIG/IlY5HR9XHJjRCemkrdJNJwX55rv1n71DyMFWid7gwRzjBaUdQ6wXQxjlvxdIpV4Yct9Lba9qbWVyIQBx2KckhSvEvCP6bf58BK7KEJ73vAyQV9zRs2w+BwY9Y2NqYNEXKY5KKgMkdFQMn0b7mrSfzt7xpbC4AvT1U2qnkerAoW+vF1Dh1Vc3W80m9PPQEdkeH58u0vqYBM0L7x5BSRypPPFN9I6PBwzotl+J+GaQMtQZ6oQGX7BwP0kdz9JQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930e0224-d4da-40b6-6449-08d8594ec335
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:10:08.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWEuABRCIVsW/uosUQOK3XKNeddD6+0rm0AdIk80kY2mWh8oQTuiIAuSvFHgnt8mp6vqJZbuhuNcr7LgyNSkJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600157269; bh=4499LQUr1dmIIMmakEy0Q7hayDx34AQH7NJsn95u0Rc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=e3hj5pDPfXz0KzHOw8tkHWU7/SXHetOE3Dd4m1w4EJ3HIybZS+xnY5fRddg4180oz
         sxuLeDx9bI4LmbT2KFjWM3b4J5ihBzp82iaAtggZsVCI2xgz0IohOpF6zTh9kv2Xp2
         nmD0MCRkIQA+ExLl7G8GVRSVKC5Iyiyyiu7LTwhG2FCZsKhmX1I0nuBhDtLmv57kAT
         aJx8UkcN7vj07OJRYhmrPGXgXE5t8Zz59er6PDsshKT2PULCAvi9+lhXHFTV8v/jht
         A/uktc7PH+aRe6JlJIjAe712inyxGwJt8q9zRt/FDcoKbCi4OGBIOwngqxS9pDmi92
         5ad8uLizBmzoA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhcnQgVmFuIEFzc2NoZSA8
YnZhbmFzc2NoZUBhY20ub3JnPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxNCwgMjAyMCA3
OjU2IFBNDQo+IFRvOiBTZXJnZXkgR29yZW5rbyA8c2VyZ2V5Z29AbnZpZGlhLmNvbT4NCj4gQ2M6
IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlk
aWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzcnBfZGFlbW9uOiBBdm9pZCBleHRyYSBw
ZXJtaXNzaW9ucyBmb3IgdGhlIGxvY2sgZmlsZQ0KPiANCj4gT24gMjAyMC0wOC0xOSAwNzoxNywg
U2VyZ2V5IEdvcmVua28gd3JvdGU6DQo+ID4gVGhlcmUgaXMgbm8gbmVlZCB0byBjcmVhdGUgYSB3
b3JsZC13cml0YWJsZSBsb2NrIGZpbGUuDQo+ID4gSXQncyBlbm91Z2ggdG8gaGF2ZSBhbiBSVyBw
ZXJtaXNzaW9uIGZvciB0aGUgZmlsZSBvd25lciBvbmx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2VyZ2V5IEdvcmVua28gPHNlcmdleWdvQG52aWRpYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIHNycF9k
YWVtb24vc3JwX2RhZW1vbi5jIHwgMSAtDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc3JwX2RhZW1vbi9zcnBfZGFlbW9uLmMgYi9zcnBf
ZGFlbW9uL3NycF9kYWVtb24uYyBpbmRleA0KPiA+IGYxNGQ5ZjU2YzlmMi4uZmNmOTQ1MzdjZWJi
IDEwMDY0NA0KPiA+IC0tLSBhL3NycF9kYWVtb24vc3JwX2RhZW1vbi5jDQo+ID4gKysrIGIvc3Jw
X2RhZW1vbi9zcnBfZGFlbW9uLmMNCj4gPiBAQCAtMTQyLDcgKzE0Miw2IEBAIHN0YXRpYyBpbnQg
Y2hlY2tfcHJvY2Vzc191bmlxdWVuZXNzKHN0cnVjdA0KPiBjb25maWdfdCAqY29uZikNCj4gPiAg
CQlyZXR1cm4gLTE7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWZjaG1vZChmZCwNCj4gU19JUlVTUnxT
X0lSR1JQfFNfSVJPVEh8U19JV1VTUnxTX0lXR1JQfFNfSVdPVEgpOw0KPiA+ICAJaWYgKDAgIT0g
bG9ja2YoZmQsIEZfVExPQ0ssIDApKSB7DQo+ID4gIAkJcHJfZXJyKCJmYWlsZWQgdG8gbG9jayAl
cyAoZXJybm86ICVkKS4gcG9zc2libHkgYW5vdGhlciAiDQo+ID4gIAkJICAgICAgICJzcnBfZGFl
bW9uIGlzIGxvY2tpbmcgaXRcbiIsIHBhdGgsIGVycm5vKTsNCj4gDQo+IEkgdGhpbmsgdGhlIGZj
aG1vZCgpIGNhbGwgd2FzIGludHJvZHVjZWQgYnkgY29tbWl0IGVlMTM4Y2UxZTQwZCAoIkNhdXNl
DQo+IHNycF9kYWVtb24gbGF1bmNoIHRvIGZhaWwgaWYgYW5vdGhlciBzcnBfZGFlbW9uIGlzIGFs
cmVhZHkgd29ya2luZyBvbiB0aGUNCj4gc2FtZSBIQ0EgcG9ydC4iKS4gSGFzIGl0IGJlZW4gdmVy
aWZpZWQgdGhhdCB3aXRoIHRoaXMgY2hhbmdlIGFwcGxpZWQgdGhhdA0KPiBtZWNoYW5pc20gc3Rp
bGwgd29ya3M/DQo+IA0KPiBBbnl3YXksIHBsZWFzZSBhZGQgYSByZWZlcmVuY2UgdG8gdGhhdCBj
b21taXQgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFy
dC4NCj4gDQoNCkJhcnQsDQoNCkkgdGVzdGVkIHRoZSBwYXRjaCBmb3IgdGhlIGZvbGxvd2luZyBz
Y2VuYXJpb3M6DQoqIFN0YXJ0IHRoZSBzcnBfZGFlbW9uIHNlcnZpY2Ugd2hlbiBzcnBfZGFlbW9u
IGlzIG5vdCBydW5uaW5nIGFuZCB0aGUgbG9jayBmaWxlIGRvZXMgbm90IGV4aXN0Lg0KKiBTdGFy
dCB0aGUgc3JwX2RhZW1vbiBzZXJ2aWNlIHdoZW4gc3JwX2RhZW1vbiBpcyBub3QgcnVubmluZyBh
bmQgdGhlIGxvY2sgZmlsZSBleGlzdHMuDQoqIFN0YXJ0IHRoZSBzcnBfZGFlbW9uIHNlcnZpY2Ug
d2hlbiBzcnBfZGFlbW9uIGlzIHJ1bm5pbmcgYW5kIHRoZSBsb2NrIGZpbGUgZXhpc3RzLg0KKiBT
dGFydCB0aGUgc3JwX2RhZW1vbiBzZXJ2aWNlIHdoZW4gc3JwX2RhZW1vbiBpcyBydW5uaW5nIGFu
ZCB0aGUgbG9jayBmaWxlIGV4aXN0cyBhbmQgdGhlIGZpbGUgb3duZXIgaXMgbm90IHJvb3QuIChT
dWNoIHNjZW5hcmlvIGNhbiBoYXBwZW4gaWYgc29tZW9uZSB0cmllcyB0byBydW4gc3JwX2RhZW1v
biBtYW51YWxseSBhcyBub3Qgcm9vdC4gVGhlIHNycF9kYWVtb24gZmFpbHMgaW4gdGhpcyBjYXNl
LCBidXQgdGhlIGxvY2sgZmlsZSBpcyBjcmVhdGVkKS4gVGhpcyBjYXNlIGlzIGhhbmRsZWQgc3Vj
Y2Vzc2Z1bGx5IGV2ZW4gd2l0aG91dCB0aGUgZmNobW9kKCkgY2FsbCBiZWNhdXNlIHRoZSBzcnBf
ZGFlbW9uIHNlcnZpY2Ugc3RhcnRzIHNycF9kYWVtb24gYXMgcm9vdC4NCiANCkkgZG8gbm90IGtu
b3cgYW55IGNhc2Ugd2hlbiBmY2htb2QoKSBpcyBuZWVkZWQuIEFuZCBpdCBkb2VzIG5vdCBsb29r
IGxpa2UgYSBnb29kIGlkZWEgdG8gY3JlYXRlIGEgd29yZC13cml0YWJsZSBmaWxlIG93bmVkIGJ5
IHJvb3QuIFRoYXQncyB3aHkgSSB3YW50IHRvIHJlbW92ZSB0aGUgZmNobW9kKCkgY2FsbC4NCiAN
CkRvIHlvdSBoYXZlIGFuIGlkZWEgd2hlbiB0aGUgZmNobW9kKCkgY2FsbCBjYW4gYmUgbmVlZGVk
Pw0KIA0KSWYgeW91IGhhdmUgbm8gb3RoZXIgb2JqZWN0aW9ucywgSSB3aWxsIGFkZCB0aGUgZml4
ZXMgbGluZSBhbmQgc2VuZCBWMS4NCg0KVGhhbmtzLA0KU2VyZ2V5DQo=
