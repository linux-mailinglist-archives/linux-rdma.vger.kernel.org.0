Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770E22A4D26
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 18:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCRgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 12:36:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:46144 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgKCRgm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 12:36:42 -0500
IronPort-SDR: wo+okU5dM+A24azEmK4LzlchUgQSHWjiXe0PoZCStRDWpIvz5fG1NP7L0PGFBUkMYrxnjmjcuK
 Yu/VkI6ZBqhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="253807428"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="253807428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 09:36:41 -0800
IronPort-SDR: EjuskdZZT0WTgW0y+4dJOijMxhtuIP7SR5/UPQH2/GRb/FksZMzQfReGgPdgcN6sSvq5uVB9Lv
 dV75Y1Vo/J3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="306114418"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2020 09:36:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 09:36:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Nov 2020 09:36:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 3 Nov 2020 09:36:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV6rSipNPtGIu2BY/UQsnpwzI9rXAFkvD9TA1WK5UPxLYLs5bgS9SXNuz5Z0WGOYkuWiBV5UBazJZ1YsyByrZYt+7SSKbe8Lj6lRNyf7cwS9bWnlyVuyHtLQZLrPSlTwDgLTvKHSeNt+5quSc73nkSFO6DiXzciwOo+LM3IKOFEF6JHEYHRA9KexLrsVMSl3kRruSp8QrUw2RvzkQeiPJE1mUvOvJp1XYqcxILIMdMBjsBP+1FX6EoI2q0DYkJVdqH91A0vU0V+V3Uq45kxiGjkvLsDrMj7KQi+x6AxEyPxhXDT2bWlhGWaDY3oWn7qVOzr2hlN+amB+riJOioDM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyKEzF+TDSQCQQkpNUY4uZWd6bCyNvDpTyFy8Q3WXvw=;
 b=gAgsTzWHo2rPVhW4PPe3p2M/1MbP3+d8Jwbt5l0XYHRKalGMIkNrKY++snOcizS34QnOWvS3gNaTtRUJyMlVpAf21K6mvEDJ0wc/DwSgfg33Fbkz+0zL4KK8vvBnrVOXU6PmWsKkqdDz2ibzKUdhkhhBGacK/7azjlhQBziFd1WWh24VJizpE/yNCpPwFvejFQrVYX0KPdpkR9/BIcSBPLTF2HPQ/B/jiP1Tsa9o8S/Bm1sdy4ffOkzfKgXsPmNVbe4MemxhO2j1RuzgroTry06gDGA91H3PpUH2wAoRyRLDxzrQkABtU5l37TPyBZ9KGA9cmapAxw+eTgleDzDvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyKEzF+TDSQCQQkpNUY4uZWd6bCyNvDpTyFy8Q3WXvw=;
 b=xC+Q6uZatAqyV783agHxqUJ4nW4V8JY0bR3suKLNad9jM7pOsVbiQVauaQzT8xFyrlh6D1Bux9saFP1674mGd22ulJOW7vhjL54RGK0jaQi9usiCgF53s289d4rhKTLK9tYayZzQFnRGgh0D4Dw4u0fY19QMBfGhNoHmecYeWLM=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR1101MB2192.namprd11.prod.outlook.com (2603:10b6:301:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 17:36:36 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9%8]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 17:36:36 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWqVlE332Lg1o1rU+Qqd8CQ3VTXKmlZiqAgAAZZoCAAHxZgIAQssdg
Date:   Tue, 3 Nov 2020 17:36:36 +0000
Message-ID: <MW3PR11MB45553600E8A141CCDE52FABDE5110@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local>
 <20201023182005.GP36674@ziepe.ca>
 <CAKMK7uEZYdtwHKchNwiFjuYJDjA+F+qDgw64TNkchjp4uYUr6g@mail.gmail.com>
In-Reply-To: <CAKMK7uEZYdtwHKchNwiFjuYJDjA+F+qDgw64TNkchjp4uYUr6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ef2661-b06e-428c-12ea-08d8801f03c1
x-ms-traffictypediagnostic: MWHPR1101MB2192:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21927F77C9550A02B1AC73BAE5110@MWHPR1101MB2192.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25FixGrDEcsRXEnHX/7z8cArZBTzAyFGsUotJ5rrBqRZfwLyeAVi66y+/nWK4vFiebd2xq3Or108YklSMOOQCSeWXbo0Pkw6KiqKcRJqj4fkWqCsIZBVZqAej7sNUezUdcK41/+D1saYJwIMW1/J7aJ2mBcywCIrx25/e1xpSq3BhyTotkIEyAhi7SLSVIrd7B7InonXgYSUsRG7RYENC8iOAW+7R96KgsPqCvjNjepgbCCqvNsUrVsDs3duV3VI+ZIB2WyzCAqz8DHka/dq1FKGkTK6GAI6ZyWvhI8oaQ7mjpShl/zndufBfSchp/j0M1TVSmMhSaS97Je13PcfiwHJXKVi1AjOtuZIMdwu3Yn58tIsxVrrWkVDULf+LvE8+MLl9i1J96XW/sDrhSC8SnFgnR6e5J8rgchy4t0xl8tQSRxMGWw5tFrIHcTFQHF4WfEX0/q6PugKJX14RRx3kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(54906003)(71200400001)(53546011)(4326008)(5660300002)(110136005)(966005)(7696005)(478600001)(76116006)(52536014)(66946007)(66446008)(64756008)(66556008)(66476007)(6506007)(316002)(26005)(186003)(55016002)(9686003)(86362001)(83080400002)(2906002)(8676002)(8936002)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dNQ+HMGaX0PGCEHlCSFlMGwdIjL6nBOipmVNsXFi1a9atKHsoyp9jSCM7Yt5lu1gfpLGz4/LYt0huzueWCB/IjD1MK1M/gJrS6/C4OzvvEm3gPBADqnrxqGewVCmq6DcQus9FKfnehJPvkMsVADnD1/lqu988j4MUgx+cI3/dhhuls8ZNp2UqZH9ePKMQM/Y/TNYB5SkcLZxdAH8Tgi2tF1jGqEShsN6AabrPDTjcR/yuU3dh3uJETV9gHYYDfbMILxErDv0VTDvRDgF1oK9dVvFZ1NpTPPCVnJYuWUtOGIlD/C3JqcsQiWYl8bBTZ05PVVBbXPUoy2mbgxfDyvGQ0aSQBJa9O0VK2+GwY14hgZxzAId4TUkfiQ8KY9i3mA8rGUwmooyK6JZmvgNYL3ZFvvEgJr7scPsu5sY4KXYMaAjD4neC1UCzov1mO3XM8cR/5SWxSEmj9SVpVYJnyPwUHmRucg7ZUlJ6jMJMICIdG4Qib25bf4Npx1ImXCON6fbz1vGhNvJ4EUzm6JY4ZMN4uyh2E5kYg30wh4O6vVTL8nLi9/YJOL3DcmHDlpSnAqevayk4fNJ18mXMeCh1GOCm6hSOewL1UEjJC7p5kk9XPNOj21Zkczc8sL+PnFU/wY0YZ9NYHJkrQWuvGtkbCP7GQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ef2661-b06e-428c-12ea-08d8801f03c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 17:36:36.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rc9nDCYVIlqoFUgSqe/whzvTG8Kh7cTdZ4ea/pz48pGMZoZXZvSyxKdoZsPwIgVnt5V1OGMpUNQR+MzYskGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDIzLCAyMDIwIDY6NDUgUE0N
Cj4gVG86IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPg0KPiBDYzogWGlvbmcsIEppYW54
aW4gPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPjsgbGludXgtcmRtYSA8bGludXgtcmRtYUB2Z2Vy
Lmtlcm5lbC5vcmc+OyBkcmktZGV2ZWwgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
OyBMZW9uDQo+IFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IERvdWcgTGVkZm9yZCA8ZGxl
ZGZvcmRAcmVkaGF0LmNvbT47IFZldHRlciwgRGFuaWVsIDxkYW5pZWwudmV0dGVyQGludGVsLmNv
bT47IENocmlzdGlhbiBLb2VuaWcNCj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NiAxLzRdIFJETUEvdW1lbTogU3VwcG9ydCBpbXBvcnRpbmcgZG1h
LWJ1ZiBhcyB1c2VyIG1lbW9yeSByZWdpb24NCj4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNpZmRl
ZiBDT05GSUdfRE1BX1ZJUlRfT1BTDQo+ID4gPiA+ICsgICBpZiAoZGV2aWNlLT5kbWFfZGV2aWNl
LT5kbWFfb3BzID09ICZkbWFfdmlydF9vcHMpDQo+ID4gPiA+ICsgICAgICAgICAgIHJldHVybiBF
UlJfUFRSKC1FSU5WQUwpOyAjZW5kaWYNCj4gPiA+DQo+ID4gPiBNYXliZSBJJ20gY29uZnVzZWQs
IGJ1dCBzaG91bGQgd2UgaGF2ZSB0aGlzIGNoZWNrIGluIGRtYV9idWZfYXR0YWNoLA0KPiA+ID4g
b3IgYXQgbGVhc3QgaW4gZG1hX2J1Zl9keW5hbWljX2F0dGFjaD8gVGhlIHAycGRtYSBmdW5jdGlv
bnMgdXNlIHRoYXQNCj4gPiA+IHRvbywgYW5kIEkgY2FuJ3QgaW1hZ2luZSBob3cgemVyb2NvcHkg
c2hvdWxkIHdvcmsgKHdoaWNoIGlzIGxpa2UgdGhlDQo+ID4gPiBlbnRpcmUgcG9pbnQgb2YNCj4g
PiA+IGRtYS1idWYpIHdoZW4gd2UgaGF2ZSBkbWFfdmlydF9vcHMuDQo+ID4NCj4gPiBUaGUgcHJv
YmxlbSBpcyB3ZSBoYXZlIFJETUEgZHJpdmVycyB0aGF0IGFzc3VtZSBTR0wncyBoYXZlIGEgdmFs
aWQNCj4gPiBzdHJ1Y3QgcGFnZSwgYW5kIHRoZXNlIGhhY2t5L3dyb25nIFAyUCBzZ2xzIHRoYXQg
RE1BQlVGIGNyZWF0ZXMgY2Fubm90DQo+ID4gYmUgcGFzc2VkIGludG8gdGhvc2UgZHJpdmVycy4N
Cj4gPg0KPiA+IEJ1dCBtYXliZSB0aGlzIGlzIGp1c3QgYSAnZHJpdmVycyBhcmUgdXNpbmcgaXQg
d3JvbmcnIGlmIHRoZXkgY2FsbA0KPiA+IHRoaXMgZnVuY3Rpb24gYW5kIGV4cGVjdCBzdHJ1Y3Qg
cGFnZXMuLg0KPiA+DQo+ID4gVGhlIGNoZWNrIGluIHRoZSBwMnAgc3R1ZmYgd2FzIGRvbmUgdG8g
YXZvaWQgdGhpcyB0b28sIGJ1dCBpdCB3YXMgb24gYQ0KPiA+IGRpZmZlcmVudCBmbG93Lg0KPiAN
Cj4gWWVhaCBkZWZpbml0ZWx5IGRvbid0IGNhbGwgZG1hX2J1Zl9tYXBfYXR0YWNobWVudCBhbmQg
ZXhwZWN0IGEgcGFnZSBiYWNrLiBJbiBwcmFjdGljZSB5b3UnbGwgZ2V0IGEgcGFnZSBiYWNrIGZh
aXJseSBvZnRlbiwgYnV0IEkgZG9uJ3QgdGhpbmsNCj4gd2Ugd2FudCB0byBiYWtlIHRoYXQgaW4s
IG1heWJlIHdlIGV2ZW50dWFsbHkgZ2V0IHRvIG5vbi1oYWNreSBkbWFfYWRkcl90IG9ubHkgc2ds
Lg0KPiANCj4gV2hhdCBJJ20gd29uZGVyaW5nIGlzIHdoZXRoZXIgZG1hX2J1Zl9hdHRhY2ggc2hv
dWxkbid0IHJlamVjdCBzdWNoIGRldmljZXMgZGlyZWN0bHksIGluc3RlYWQgb2YgZWFjaCBpbXBv
cnRlciBoYXZpbmcgdG8gZG8gdGhhdC4NCg0KQ29tZSBiYWNrIGhlcmUgdG8gc2VlIGlmIGNvbnNl
bnN1cyBjYW4gYmUgcmVhY2hlZCBvbiB3aG8gc2hvdWxkIGRvIHRoZSBjaGVjay4gTXkNCnRoaW5r
aW5nIGlzIHRoYXQgaXQgY291bGQgYmUgb3ZlciByZXN0cmljdGl2ZSBmb3IgZG1hX2J1Zl9hdHRh
Y2ggdG8gYWx3YXlzIHJlamVjdCANCmRtYV92aXJ0X29wcy4gQWNjb3JkaW5nIHRvIGRtYS1idWYg
ZG9jdW1lbnRhdGlvbiB0aGUgYmFjayBzdG9yYWdlIHdvdWxkIGJlDQptb3ZlZCB0byBzeXN0ZW0g
YXJlYSB1cG9uIG1hcHBpbmcgdW5sZXNzIHAycCBpcyByZXF1ZXN0ZWQgYW5kIGNhbiBiZSBzdXBw
b3J0ZWQNCmJ5IHRoZSBleHBvcnRlci4gVGhlIHNnX2xpc3QgZm9yIHN5c3RlbSBtZW1vcnkgd291
bGQgaGF2ZSBzdHJ1Y3QgcGFnZSBwcmVzZW50LiANCg0KLUppYW54aW4NCiAgDQo+IC1EYW5pZWwN
Cj4gLS0NCj4gRGFuaWVsIFZldHRlcg0KPiBTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9y
YXRpb24NCj4gaHR0cDovL2Jsb2cuZmZ3bGwuY2gNCg==
