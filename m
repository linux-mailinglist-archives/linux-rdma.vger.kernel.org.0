Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A507A27B16C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Sep 2020 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1QIt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Sep 2020 12:08:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10222 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgI1QIt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Sep 2020 12:08:49 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f720a8d0000>; Tue, 29 Sep 2020 00:08:45 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 16:08:45 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 28 Sep 2020 16:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPDxsflG0DG5Rv+JsjgCacEbSsy9U5n9cBteYdWikv6yD6bqPvVziPvu8tJggjvigGhRrg4z/T/YX6PwriCJ16dTgfYSV1ZQXzNvl2SUZm9PdjpKrVtJpV27nLtICT9GVEj0UmSLQFo2UkUsvUNCgy4f7egnb72KsKZv0lCiCnq3uiojBWyStI3ouYwocrSsVGOL5T4bwrtMKMv1uAdd3dWMlJ2wccJDs8/NBZrxiJZZtWdAHmeoBshKbUU3Ouwwk+uZPai94R03cyNkRfrmMkbOAuN6jvi35sYLvrX/b78i9SRykP/eahrDHCV7yNjy6wHwgJUd1i9b66SuoZOWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rHSwkYvuYtML2liH3DmnR+7NeGkUUgB/mH2ixaLy4Q=;
 b=SUnP6q5vftbUJDWU+ZxAnlLlSBJ1vzgW0tgpmd7RiQrwL6OuwRlOfFqWjqTf+GSdI04ah5sY3plugg5bskfB0iRsbSQ7Ek11MDyZmlP3WNeV3IhQFZYjj4RKj6Uz4iMsxnNeHwKvybP8OMRpwRDve7RvV77FR/e/drxA9fFWL72TBBsgRSruvgDN2wZvNiL4h7tuzOXAbGbe8G9Rg1XCEEWHazig4Fg9abUx/N77vdIZ3XNCYcNFPTpuAxlbbqCrZzZP8k2uwVwlII2fjVbZAbw+Yeya/nq5A0yB7XThqHDvakiNQe1npq9HYLBrFl3amwfFjIp5sXPJGBurfCcNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB2942.namprd12.prod.outlook.com (2603:10b6:208:108::27)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 16:08:42 +0000
Received: from MN2PR12MB2942.namprd12.prod.outlook.com
 ([fe80::e089:b3a7:ae3f:2436]) by MN2PR12MB2942.namprd12.prod.outlook.com
 ([fe80::e089:b3a7:ae3f:2436%5]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 16:08:42 +0000
From:   Ariel Levkovich <lariel@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "lariel@mellanox.com" <lariel@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [bug report] net/mlx5e: Support CT offload for tc nic flows
Thread-Topic: [bug report] net/mlx5e: Support CT offload for tc nic flows
Thread-Index: AQHWlYBOpHhHERdquEedm+A31naWc6l+OESc
Date:   Mon, 28 Sep 2020 16:08:42 +0000
Message-ID: <9B692B14-F4D2-40EA-B9BD-939471DE910E@nvidia.com>
References: <20200928101505.GA382341@mwanda>
In-Reply-To: <20200928101505.GA382341@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2604:2000:1342:c20:1dfe:d10b:526:54a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ce6ff0-3991-4de0-8c12-08d863c8c542
x-ms-traffictypediagnostic: MN2PR12MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2928F4FC042168312194E029B7350@MN2PR12MB2928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9M6Ytz+Q5jXdb/qv7htF7zePB9bQnVx2uxSHPGFRlwMbni3OIGb/XpkiLslQTV9r42Hfi9mViEWFvQ8vhdPuPAu7uwBFc+0QW6Fif3tuAyTI1hi2RGoVU41ZyUQMlB5j5uM39Au9VkvaYYSIbcdCUzwcp+7n5hsGCm5SaNYZVI1xW9lymLdM07eqg4EUCL87pZ64B3tVp7xxQ8sTecIrtZ55gRxE1mzr60WbI6IBguK3zzw6ciysImAPv+A8Tjg3BjLEQANMicnE6wuIvDnNsBs7ndUMpjc6DexyBGwLpmaO4h/Gvu+Gp1DyWvqr9zkJUKXtgfldazcKsew9WjXRarvjG2QSEdhmJ2CYRKzq68prPAdMsFYonm3ScKycF9s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2942.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(64756008)(5660300002)(54906003)(316002)(66476007)(66556008)(8936002)(6506007)(66446008)(2906002)(186003)(53546011)(86362001)(478600001)(33656002)(36756003)(107886003)(6512007)(6486002)(6916009)(2616005)(71200400001)(8676002)(66946007)(76116006)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +Z6N5ubstjex0tdwSv3+rU6AmOjrW3dz21h03VptKBEzh6cZsmbeKlorSM7CRP54h4BcQrRsAZ7GwyhOWTU30mKqpqQGJD0aPR5fT/XMV1+rF+UnkSlL/VQg2m9WTzYLNnvZa0Pc+gkgfzSWT2pfUA2qLHQqCJeelF2YUGowinB6cjock9/l9EA6wSBPORJtOrmPH+HcA12A6veKtlRc1osO0lmRHS84luZkACssxm394LBW7jLv0BwXSYQms6gFLt1ViJ4eSRzSUyh+F4tHh1KNlFJkdYu5ywlQgUSMeW1IoV+XEEqeouG4Olh03T1d1YDhcyWcgP3Iw583Yslo0ZdN6UZAb5Nq2Lo9aTecA2fUFahs0rD/BrmcW6vp11jxSGfaP1ez/GLuIf6BLELeqU0KeyctL+pOquUkgQbHBHh49lQB3LREu50uepfk8zneyTpUK838wYOb7p18B2yOyj4iV4Pz45LI1T7c6xOHeNw/MT8Gx8nfya87f98rxItREeWrk0H9jX7IqursDAXsjYES00bWTfId8uTjflHJum4efC40ZSscOFpGuaigH8EurQvT+kaki05P19+5X5JHWdj7wNuX2Vhc9EiudtCMRQM6qE2dJeGi0jm0rmJ9H88I7C5/gD5VtdYxuCzbLOVT27cFkTlSBCWcyQncQ82+yaBiB40CxQ1rsL5ko8kRhTnnigSzygJg9MRKoUGvdQ5giQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2942.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ce6ff0-3991-4de0-8c12-08d863c8c542
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 16:08:42.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3d0KJje2t8c5Q66N/DRiI57eKKxlX/zNINgyLJ54OchVJF8jqbgnTpEV4qEI35p73OaH/Pe896/8SCRu+joWVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601309325; bh=7rHSwkYvuYtML2liH3DmnR+7NeGkUUgB/mH2ixaLy4Q=;
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
        b=AVGzLiivVO8sz2TbkLhINNFlGWWcDrnYb9pGbtvM0iWlLfaTMvEbO8QbF6QA1vQ0x
         WIM4Pt//l7sQkide8ZpT2vki2aqB2kvuuAhQIhFLn+TO7kFX6W8re67qIZJTpJIYep
         1QktUiTASSTC5jOW6YcuYIJzfCiBZ75x5MOc5iaqi3IPYn2LnZTe19sT0bfq3oxkUV
         JbX3o2AeAWbXARZ9Z9mK7lOcBl/CWHC6xYg6x2gEdTamgzOk3riGPpKwwYsSEGUVQp
         z0m2R8R/dSVr4C2Rj1QVqckvxEej9+AE4HW5TMRtpDSEMmqGFkyqaGbrMF8cel4S0p
         Ts5aGGu7YuBKw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2VwIDI4LCAyMDIwLCBhdCAwNjoxNSwgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBv
cmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IO+7v0hlbGxvIEFyaWVsIExldmtvdmljaCwNCj4gDQo+
IFRoZSBwYXRjaCBhZWRkMTMzZDE3YmM6ICJuZXQvbWx4NWU6IFN1cHBvcnQgQ1Qgb2ZmbG9hZCBm
b3IgdGMgbmljDQo+IGZsb3dzIiBmcm9tIEp1bCAyMSwgMjAyMCwgbGVhZHMgdG8gdGhlIGZvbGxv
d2luZyBzdGF0aWMgY2hlY2tlcg0KPiB3YXJuaW5nOg0KPiANCj4gICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3RjLmM6MTEzMiBtbHg1ZV90Y19kZWxfbmljX2Zs
b3coKQ0KPiAgICB3YXJuOiBwYXNzaW5nIGZyZWVkIG1lbW9yeSAnZmxvdycNCj4gDQo+IGRyaXZl
cnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl90Yy5jDQo+ICAxMTA1ICBzdGF0
aWMgdm9pZCBtbHg1ZV90Y19kZWxfbmljX2Zsb3coc3RydWN0IG1seDVlX3ByaXYgKnByaXYsDQo+
ICAxMTA2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1seDVlX3Rj
X2Zsb3cgKmZsb3cpDQo+ICAxMTA3ICB7DQo+ICAxMTA4ICAgICAgICAgIHN0cnVjdCBtbHg1X2Zs
b3dfYXR0ciAqYXR0ciA9IGZsb3ctPmF0dHI7DQo+ICAxMTA5ICAgICAgICAgIHN0cnVjdCBtbHg1
ZV90Y190YWJsZSAqdGMgPSAmcHJpdi0+ZnMudGM7DQo+ICAxMTEwICANCj4gIDExMTEgICAgICAg
ICAgZmxvd19mbGFnX2NsZWFyKGZsb3csIE9GRkxPQURFRCk7DQo+ICAxMTEyICANCj4gIDExMTMg
ICAgICAgICAgaWYgKGZsb3dfZmxhZ190ZXN0KGZsb3csIENUKSkNCj4gIDExMTQgICAgICAgICAg
ICAgICAgICBtbHg1X3RjX2N0X2RlbGV0ZV9mbG93KGdldF9jdF9wcml2KGZsb3ctPnByaXYpLCBm
bG93LCBhdHRyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eDQo+IEkgZ3Vlc3MgdGhpcyB1c2VkIHRv
IGZyZWUgImZsb3ciIGFuZCBTbWF0Y2gncyBkYiBoYXNuJ3QgdG90YWxseSBjYXVnaHQNCj4gdXAg
eWV0LiAgTm93IGl0IGRvZXNuJ3QgdXNlICJmbG93IiBhdCBhbGwuICBNYXliZSB3ZSBjb3VsZCBq
dXN0IHJlbW92ZQ0KPiB0aGF0IHBhcmFtZXRlcj8NCg0KSGkgRGFuLCB0aGFua3MgZm9yIHBvaW50
aW5nIHRoaXMgb3V0Lg0KWWVzLCB3ZSBjYW4gc2ltcGx5IGRyb3AgdGhlIGZsb3cgYW5kIHVzZSBw
cml2IGRpcmVjdGx5IGFzIGl0IGlzIHBhc3NlZCB0byB0aGUgZnVuY3Rpb24gYXMgYSBzZXBhcmF0
ZSB2YXJpYWJsZS4NCg0KQXJpZWwNCg0KPiANCj4gIDExMTUgICAgICAgICAgZWxzZSBpZiAoIUlT
X0VSUl9PUl9OVUxMKGZsb3ctPnJ1bGVbMF0pKQ0KPiAgMTExNiAgICAgICAgICAgICAgICAgIG1s
eDVlX2RlbF9vZmZsb2FkZWRfbmljX3J1bGUocHJpdiwgZmxvdy0+cnVsZVswXSwgYXR0cik7DQo+
ICAxMTE3ICANCj4gIDExMTggICAgICAgICAgLyogUmVtb3ZlIHJvb3QgdGFibGUgaWYgbm8gcnVs
ZXMgYXJlIGxlZnQgdG8gYXZvaWQNCj4gIDExMTkgICAgICAgICAgICogZXh0cmEgc3RlZXJpbmcg
aG9wcy4NCj4gIDExMjAgICAgICAgICAgICovDQo+ICAxMTIxICAgICAgICAgIG11dGV4X2xvY2so
JnByaXYtPmZzLnRjLnRfbG9jayk7DQo+ICAxMTIyICAgICAgICAgIGlmICghbWx4NWVfdGNfbnVt
X2ZpbHRlcnMocHJpdiwgTUxYNV9UQ19GTEFHKE5JQ19PRkZMT0FEKSkgJiYNCj4gIDExMjMgICAg
ICAgICAgICAgICFJU19FUlJfT1JfTlVMTCh0Yy0+dCkpIHsNCj4gIDExMjQgICAgICAgICAgICAg
ICAgICBtbHg1X2NoYWluc19wdXRfdGFibGUobmljX2NoYWlucyhwcml2KSwgMCwgMSwgTUxYNUVf
VENfRlRfTEVWRUwpOw0KPiAgMTEyNSAgICAgICAgICAgICAgICAgIHByaXYtPmZzLnRjLnQgPSBO
VUxMOw0KPiAgMTEyNiAgICAgICAgICB9DQo+ICAxMTI3ICAgICAgICAgIG11dGV4X3VubG9jaygm
cHJpdi0+ZnMudGMudF9sb2NrKTsNCj4gIDExMjggIA0KPiAgMTEyOSAgICAgICAgICBrdmZyZWUo
YXR0ci0+cGFyc2VfYXR0cik7DQo+ICAxMTMwICANCj4gIDExMzEgICAgICAgICAgaWYgKGF0dHIt
PmFjdGlvbiAmIE1MWDVfRkxPV19DT05URVhUX0FDVElPTl9NT0RfSERSKQ0KPiAgMTEzMiAgICAg
ICAgICAgICAgICAgIG1seDVlX2RldGFjaF9tb2RfaGRyKHByaXYsIGZsb3cpOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl4NCj4gIDExMzMg
IA0KPiAgMTEzNCAgICAgICAgICBtbHg1X2ZjX2Rlc3Ryb3kocHJpdi0+bWRldiwgYXR0ci0+Y291
bnRlcik7DQo+ICAxMTM1ICANCj4gIDExMzYgICAgICAgICAgaWYgKGZsb3dfZmxhZ190ZXN0KGZs
b3csIEhBSVJQSU4pKQ0KPiAgMTEzNyAgICAgICAgICAgICAgICAgIG1seDVlX2hhaXJwaW5fZmxv
d19kZWwocHJpdiwgZmxvdyk7DQo+ICAxMTM4ICANCj4gIDExMzkgICAgICAgICAga2ZyZWUoZmxv
dy0+YXR0cik7DQo+ICAxMTQwICB9DQo+IA0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQo=
