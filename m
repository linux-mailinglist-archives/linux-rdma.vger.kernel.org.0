Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07282AABA1
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Nov 2020 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgKHOgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Nov 2020 09:36:24 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:53222 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHOgY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Nov 2020 09:36:24 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa802670000>; Sun, 08 Nov 2020 22:36:23 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 14:36:22 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 8 Nov 2020 14:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW/CWthEy0Ms3ZsW+TvMfOpqd4MYe1EYkJSeyqay7zZ9MKxYUWBwgo5qK6nxYFvnuRdMRsgzVbBXotM6xqJvBjnlTOtycQAlk8uZAy2Q+JM+pI0H+qIPBTTkL2EWRmfiAtnHfj/MGAB326fpw4eDB35d57d7WTIhJU1UxqKzRJ1dIQ/aMQyUcGaCfpndogSOH7hxp/+YGtQxRcPOjaSRTDhcFb5MuMoQ0m0RzlKx+5eEOW3Pa70x8wyyXifPzvNBXHVFFJDXpM35cOWcBtEnVJfW+qQZdUnpL1yPvA575GqGBXJ2/H/y3MLpTHr+Dw7b9C+hEaCSuFoZyaEJsWdxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaOuVY5JQS9cQ9EmJi5mKMD3He0C7+i+pcm7d7+ua6g=;
 b=crVoaSrD69c7YJVPHCGg5RBof0COgyyY3qSJDMmpwdDkuihCn9vyqR0Co6tJCOFHGZhocrDvqX2e3yREbT6Rro0Pw7LsD0ZwUFATndVkMyjTR/24lZKUlBet4MWMljwXWswwXmVv5+WWHh7ThOzApPmBB/5x1YA5A62E7hNDRdS8yTLvXca0g0g729T3o61j3ewYe1aVllmWIrMpQsgqsZgbha1NGckKw1v9o5U045UZFz6hIYMKdZY3ToqTK6HViIKOuj6YkhKH/oMGPOElsMl3+tdQQP5Nh6O5zD8dYd5gf3OLfbXwoSgegem5NZlMYRrijIH7mX84HGHlucdIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3032.namprd12.prod.outlook.com (2603:10b6:a03:dd::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Sun, 8 Nov
 2020 14:36:20 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 14:36:20 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/nldev: Add parent bdf to device information
 dump
Thread-Topic: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Thread-Index: AQHWseUFa8s51ZXrO02crXmgHvhE86m2a1wAgAADV4CAAAPpgIAAAy+AgAAXHQCAA2vPgIAEQqyAgAAYf/A=
Date:   Sun, 8 Nov 2020 14:36:20 +0000
Message-ID: <BY5PR12MB432246F3155BC1D440857629DCEB0@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca> <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
In-Reply-To: <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [171.61.125.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9a615ae-ca6f-428c-1c30-08d883f3a8db
x-ms-traffictypediagnostic: BYAPR12MB3032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30329E8D64B40C9059F2B12EDCEB0@BYAPR12MB3032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/iN/YSwoev5eQZg3+MK07wUsVyMrcP3si4fESFfqjeNwfdQDVGzqnHbKoMYIMnKoVrl9dQDTCz89CWHbpAkac5hDiJAJiQ+YjitFuJf5fK34q0dIQ6wUijZ0Q4+8oZ9xWWHIInxeU+P7JNZZssBkY6dzl1XxDtwaeq0e043Dz2nOuaXwB9qdnT4aN08K+NEYoylQND4AIjkLZK/Fu5wR95mWmyu3b/BF7Y9VZJkcJE+2GWI6b3bRHu2X6TV2K7P7xZ0sSfxz3GWiUJh4ysK6qAjCG4Vb7Jas9OnX3zH2ATTdvzzy31wO3kj/BKbCp9wtibH57+xu4YbGETw2UGuaj4nllWP5UDdeSWoZT9SlDdDFhk6aDsNC2bTpkucFFHXToaOvUy9bFzq5zIPpgN+tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(45080400002)(6506007)(54906003)(76116006)(66946007)(110136005)(8936002)(53546011)(66446008)(66556008)(66476007)(7696005)(64756008)(86362001)(316002)(83380400001)(478600001)(966005)(9686003)(5660300002)(8676002)(26005)(55016002)(4326008)(52536014)(186003)(33656002)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1FW07Ve2SJ3xjgOIAWKTvoE6XAGGZ1IG8+3RaWdEjWPQntBLVZnVXe8PLkDkdU5iNj0tpN1fQvbYh6M/SiSB4dnF6toq4y9FrMzgANUqAvmZP4A7BfhyRqdm0yuir7qTichbDvwhuWO+9NHbRk7Jou32c7YD48ABcLiskKtM0CEP66gTJ5TEilIZkkQFw9QwZSdzLWP0yewZf2dTB6VkUq6zfHumbzsjEdfLfnc746I9hyjr5JY0AEj28xBsi6sh8D8RXqWfi7ziz2idUCk1ZARgpM4J5H9Z0CBObXCzzv+bMQcfyDsuvHcrK/qzuNKqsUxOpFxTq1WJWFHcVWKkfa6PikX2o9zSEayrOIp4eIrgDqE6YBdBprDyGS5bSeseM0g2pWF8lyRp2teD0LCNV11lhy/Aj+WDnhYHLL0TC4UYhuYGip/N49/3W+WAXTY+RdtR8kwhqg8shjzmj3lhx0AhkquBUp8NBJMRIxjUiOLOy9NGqtkFHbicoGLd/G7ZcEh/ac7pva1HQFCsH8wz43f7Xa/G9XW7Qc2k/dBLCXU9epeKQXahqh7+QfJJblEz1f0LNEisCxjoaJekOGDK7cZO3/V1qPYzG+gORTkqT5Uz6EMfxMkhiBsJqFOg8YwXCeGRrUT/2tzEDFP2GBP0Lw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a615ae-ca6f-428c-1c30-08d883f3a8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 14:36:20.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Xz/OjLhK3kqMs9EWv7nBJhG3nNAeH/wMbBSmzYYBYc3YwxnOcLU+zXSXO04Ezba/Ups1lVWtSJ1WsC6xkYkYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3032
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604846183; bh=GaOuVY5JQS9cQ9EmJi5mKMD3He0C7+i+pcm7d7+ua6g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
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
        b=cpXCmEPAboJzAbGRRjhs+HwOeqDpYbkLzLPBQLMdAGZIUgpuaIWD671tbhn5i6mU8
         uR/mbKR1jrYCRnGDj7PodCBIRvEPiOM4/8fmhVU/YIeZo/wm+ShSk+qchgEizXPstk
         HX3fmqw0NLEIJ5YzWCZUFBNo2F964EZGeyVeAGFggZRwUB+QexZEkGD8fAhdzOKGD1
         zLkhNz8Kn3HIgHETwFzuXgwmoV9J5ZBp0SMBmkWTt8RUkhk1Hbo5wBo4z6WR3IvTuC
         QL3jg0XPwGKrnG9qvke1Ar7mieeVNZyTcycNuafEqZhyeAw7mDDHn3dT1blCUqYaKj
         Wk+ggvGIGk2ng==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogR2FsIFByZXNzbWFuIDxnYWxwcmVzc0BhbWF6b24uY29tPg0KPiBTZW50OiBT
dW5kYXksIE5vdmVtYmVyIDgsIDIwMjAgNjozNCBQTQ0KPiANCj4gT24gMDUvMTEvMjAyMCAyMjow
MCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTm92IDAzLCAyMDIwIGF0IDA1
OjQ1OjI2UE0gKzAyMDAsIEdhbCBQcmVzc21hbiB3cm90ZToNCj4gPj4gT24gMDMvMTEvMjAyMCAx
NjoyMiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+Pj4gT24gVHVlLCBOb3YgMDMsIDIwMjAg
YXQgMDQ6MTE6MTlQTSArMDIwMCwgR2FsIFByZXNzbWFuIHdyb3RlOg0KPiA+Pj4+IE9uIDAzLzEx
LzIwMjAgMTU6NTcsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPj4+Pj4gT24gVHVlLCBOb3Yg
MDMsIDIwMjAgYXQgMDk6NDU6MjJBTSAtMDQwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+
Pj4+Pj4gT24gVHVlLCBOb3YgMDMsIDIwMjAgYXQgMDM6MjY6MjdQTSArMDIwMCwgR2FsIFByZXNz
bWFuIHdyb3RlOg0KPiA+Pj4+Pj4+IEFkZCB0aGUgYWJpbGl0eSB0byBxdWVyeSB0aGUgZGV2aWNl
J3MgYmRmIHRocm91Z2ggcmRtYSB0b29sDQo+ID4+Pj4+Pj4gbmV0bGluayBjb21tYW5kIChpbiBh
ZGRpdGlvbiB0byB0aGUgc3lzZnMgaW5mcmEpLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSW4gY2Fz
ZSBvZiB2aXJ0dWFsIGRldmljZXMgKHJ4ZS9zaXcpLCB0aGUgbmV0ZGV2IGJkZiB3aWxsIGJlIHNo
b3duLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFdoeT8gV2hhdCBpcyB0aGUgdXNlIGNhc2U/DQo+ID4+
Pj4+DQo+ID4+Pj4+IFJpZ2h0LCBhbmQgd2h5IGlzbid0IG5ldGRldiAoUkRNQV9OTERFVl9BVFRS
X05ERVZfTkFNRSkgZW5vdWdoPw0KPiA+Pj4+DQo+ID4+Pj4gV2hlbiB0YWtpbmcgc3lzdGVtIHRv
cG9sb2d5IGludG8gY29uc2lkZXJhdGlvbiB5b3UgbmVlZCBzb21lIHdheSB0bw0KPiA+Pj4+IHBh
aXIgdGhlIGliZGV2IGFuZCBiZGYsIGVzcGVjaWFsbHkgd2hlbiB3b3JraW5nIHdpdGggbXVsdGlw
bGUgZGV2aWNlcy4NCj4gPj4+PiBUaGUgbmV0ZGV2IG5hbWUgZG9lc24ndCBleGlzdCBvbiBkZXZp
Y2VzIHdpdGggbm8gbmV0ZGV2cyAoSUIsIEVGQSkuDQo+ID4+Pg0KPiA+Pj4gWW91IGFyZSBzdXBw
b3NlZCB0byB1c2Ugc3lzZnMNCj4gPj4+DQo+ID4+PiAvc3lzL2NsYXNzL2luZmluaWJhbmQvaWJw
MHM5L2RldmljZQ0KPiA+Pj4NCj4gPj4+IFNob3VsZCBhbHdheXMgYmUgdGhlIHBoeXNpY2FsIGRl
dmljZQ0KPiA+Pj4NCj4gPj4+PiBXaHkgcmRtYSB0b29sPyBCZWNhdXNlIGl0J3MgbW9yZSBpbnR1
aXRpdmUgdGhhbiBzeXNmcy4NCj4gPj4+DQo+ID4+PiBCdXQgd2UgZ2VuZXJhbGx5IGRvbid0IHB1
dCB0aGlzIGluZm9ybWF0aW9uIGludG8gbmV0bGluayBCREYgaXMganVzdA0KPiA+Pj4gdGhlIHN0
YXJ0LCB5b3UgbmVlZCBhbGwgdGhlIG90aGVyIHRvcG9sb2d5IGluZm9ybWF0aW9uIHRvIG1ha2Ug
c2Vuc2UNCj4gPj4+IG9mIGl0LCBhbmQgYWxsIHRoYXQgaXMgaW4gc3lzZnMgb25seSBhbHJlYWR5
DQo+ID4+DQo+ID4+IEFzIHRoZSBjb21taXQgbWVzc2FnZSBzYXlzLCBpdCdzIGluIGFkZGl0aW9u
IHRvIHRoZSBkZXZpY2Ugc3lzZnMuDQo+ID4+DQo+ID4+IE1hbnkgKGlmIG5vdCBtb3N0KSBvZiB0
aGUgZXhpc3RpbmcgcmRtYSBuZXRsaW5rIGNvbW1hbmRzIGFyZQ0KPiA+PiBkdXBsaWNhdGVzIG9m
IHNvbWUgc3lzZnMgZW50cmllcywgYnV0IHNob3cgaXQgaW4gYSBtb3JlICJtb2Rlcm4iIHdheS4N
Cj4gPj4gSSdtIG5vdCBjb252aW5jZWQgdGhhdCBiZGYgc2hvdWxkIGJlIHRyZWF0ZWQgZGlmZmVy
ZW50bHkuDQo+ID4NCj4gPiBXaHkgZGlkIHlvdSBjYWxsIGl0IEJERiBhbnlob3c/IGl0IGhhcyBu
b3RoaW5nIHRvIGRvIHdpdGggUENJIEJERg0KPiA+IG90aGVyIHRoYW4gaXQgaGFwcGVucyB0byBi
ZSB0aGUgUERGIGZvciBQQ0kgZGV2aWNlcy4gTmV0ZGV2IGNhbGxlZA0KPiA+IHRoaXMgYnVzX2lu
Zm8NCj4gDQo+IEFyZSB0aGVyZSBub24gcGNpIGRldmljZXMgaW4gdGhlIHN1YnN5c3RlbT8NClll
cy4gVGhleSBhcmUgY29taW5nIG92ZXIgYXV4aWxpYXJ5IGJ1cywgd2FpdGluZyBmb3IgdGhlIGJ1
cyBhbmQgTGVvbidzIHBhdGNoc2V0IFsyXSB0byBiZSBtZXJnZWQuDQoNCj4gSSBjYW4gcmVuYW1l
IHRvIGEgbW9yZSBmaXR0aW5nIG5hbWUsIHdpbGwgY2hhbmdlIHRvIGJ1c19pbmZvIHVubGVzcyBz
b21lb25lDQo+IGhhcyBhIGJldHRlciBpZGVhLg0KWWVzLiBJIGd1ZXNzIHlvdSBtaXNzZWQgdGhl
IHN1Z2dlc3Rpb24gZ2l2ZW4gaW4gWzFdLg0KQmFzaWNhbGx5IGFkZGluZyBidXMgbmFtZSBhbmQg
ZGV2aWNlIG5hbWUgd2lsbCBnZW5lcmF0ZSB1bmlxdWUgYnVzK2RldmljZSBpbmZvcm1hdGlvbi4N
ClRoaXMgaXMgZ2VuZXJpYywgbm90IHNwZWNpZmljIHRvIFBDSS4NClJETUFfTkxERVZfQVRUUl9Q
QVJFTlRfREVWX05BTUUsIFJETUFfTkxERVZfQVRUUl9QQVJFTlRfREVWX0JVU19OQU1FLg0KDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRtYS9jZDNmMjkyNi0wNDkxLTg1NDAt
ZDZiMS01MzQwMTQxOTBiYWVAYW1hem9uLmNvbS9ULyNtYTVmNzFlMTRhYmFlMjNmYjY3YTUyZmYw
NmU3NDYwMGNlMTQ4OWU3OQ0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJkbWEv
RE02UFIxMU1CMjg0MTc5MDIyNTM0NjlGQzlBQkI3MkYwRERFRTBARE02UFIxMU1CMjg0MS5uYW1w
cmQxMS5wcm9kLm91dGxvb2suY29tL1QvI20zN2Q5ZDI0OTAzZmZmMGU5OWU3ZmVjNTk5MzNkNGZl
NmU2YTUxNjJiDQoNCg==
