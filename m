Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6C2A5ADA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 01:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgKDABw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 19:01:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:20903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgKDABw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 19:01:52 -0500
IronPort-SDR: KJS/gjGzzhQAqxLCCc0lsVGGDPsmK8Wj2w7uOLIWAcJbIyJo1io+Dss7ijPqpS4wiYsOCXXbi2
 gUKdSt3N1e5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="169279903"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="169279903"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 16:01:51 -0800
IronPort-SDR: rVZVPYMFsqG7iyFlqP3YmCd4hx7ianssPm5lxfnjsIBCDMrQtQoq17Ll/xVv4QVKDZUtzWYmln
 5YboF6dbQQgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="470996944"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2020 16:01:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 16:01:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 16:01:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Nov 2020 16:01:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 3 Nov 2020 16:01:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEwy55TlFPyIKwA/D9p3m5yU6ndKUrJ1OaC5wLfyeAkGRx0wSs31JjD8tKhYHjliavsnGsUXrMPl1ITW2dfNQBhvK4/6PcgNKF8j+YO8rZtAGemV0eJ5T7gouQelJmefvdJu55fKlaUvvmXtCaKhTn3twWscE51RSMuK/pdoNmeqLPIzQLk3Lw2OlQpSVgf83WVB+525aEFYJ+b/bfnhicdMmXJxNdgYOi0NH+VNG42x0zRPovZt9t7JwWluYrEkMe0cbUOZQWBsnrVIN+35Z2UncvEtcoxGOFDqJ+w9oSMWEnEg6yzIhnDiXA71m+g/7SI52sTX+27YnY0gDsweoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ1/yX3VXEIolS5SOqz0PlS9PcWRqU5IkPYYsAMbP9Q=;
 b=SrnmaRS3ds22orUUrNdm8yvcOKCCkOKMBr/i79OUJVEsM9pW2dXW0bxbi0sEQzsBsFk8xWOy5J81TFWed/VBSlJFobcgitIDcOK4hul99qcpiZ6ni3Yheg//m8LFxULswIaGn/BYFEuE/quXbEff4rnn7LtbVgHHHLl+M29dwea3+Ke+yjScUMBgBk5pMTmiqFTgZKGN13Zw33Uq7NEvisKdEqYdsliay+kqpe1h1AZBz9/9XuYaCt6kBpOczV941elwnB1uWWTHXTt+Amwrb6O4EEMkTMbaeUPXIKT6TKkJQLIwKKXXM4uSXMy0Qjxxb/pYkyt5/LH20qm6bWmPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ1/yX3VXEIolS5SOqz0PlS9PcWRqU5IkPYYsAMbP9Q=;
 b=VcB60U6T+CExuYnLGnoj5GxUJu+rRr5DiX2lMPShj2J25WlrlBs8b4HmYjH95fspSvTj1dy28pPbyVoGOTTyzrfjpjxOHiqQibx+qrusnTfyTo1XDt3DF9i+HgSNNv8Ae3IhuCPv5CVt13t0GHjd8qIS0Fioojg8V4WhG0emteg=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by CO1PR11MB4899.namprd11.prod.outlook.com (2603:10b6:303:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 00:01:45 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 00:01:45 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWqVlE332Lg1o1rU+Qqd8CQ3VTXKmlZiqAgAAZZoCAAHxZgIAQssdggABCh4CAACvkMA==
Date:   Wed, 4 Nov 2020 00:01:44 +0000
Message-ID: <MW3PR11MB4555E00C171FF550020ED890E5EF0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local>
 <20201023182005.GP36674@ziepe.ca>
 <CAKMK7uEZYdtwHKchNwiFjuYJDjA+F+qDgw64TNkchjp4uYUr6g@mail.gmail.com>
 <MW3PR11MB45553600E8A141CCDE52FABDE5110@MW3PR11MB4555.namprd11.prod.outlook.com>
 <CAKMK7uFMAiv27oRi98nAvx15M6jniUEb+hhe3mrY3mdYtzsmLg@mail.gmail.com>
In-Reply-To: <CAKMK7uFMAiv27oRi98nAvx15M6jniUEb+hhe3mrY3mdYtzsmLg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 226f7a20-f3c6-465a-9d70-08d88054d158
x-ms-traffictypediagnostic: CO1PR11MB4899:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4899E71422C7BEF81B2562C1E5EF0@CO1PR11MB4899.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFLyj6SkBFaGBALvuQYrjqeCgSiT2FlHc1KAPcslmoItdmgrSGMYHOP8/wtJ2zbJGOQYCRNKAQRN7kjJ1+Snvx5Z4vjiZYbSLuqRQzphWo48H2OB8ODoms6QV09g8ZcaVHRvmBASSiLYSd7ozeVIpip/fXE9CCNlTDPH7bicUaTr2UYVdgysR/cHesfEM4M5yD0Gld7NyJ7xyyRKoL876OIaehRRMQ8kI8WELC4VYEkR9of+WpI/1I/LCIELMoxwk0q5icPYWAewshPbIXT19v/wzIJEYcMqdVKyjWcrKtzPMvYDMQux8lbfAXT5kKrckNQFD8K2o5sFuo/Uh00DNzcG2Gpm+wkebPeUNrb2oDBZSudsnegOGhVz4vQC0XLmoNPeiBlIEaoPUq/T9xvsMuZBbPJZI04CUVp3kHfSxgzSzh7qDGh7vpZPzo2BQviHTnGL3iZicmsWcTQsotlnLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(71200400001)(54906003)(26005)(6506007)(186003)(478600001)(6916009)(53546011)(4326008)(316002)(966005)(7696005)(83080400002)(55016002)(52536014)(66556008)(83380400001)(5660300002)(8676002)(33656002)(66476007)(64756008)(9686003)(66446008)(76116006)(66946007)(2906002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Avg7SBGPRWjgkHsJDbLpageEh/cyNBO4yyuft1pzFPRI/pS/aWt2ghFXjM4fSKU8P18L6yt0M8FEepqVVco1poyu54Qlohqvb9JwVsi05/wz/4JQnIApVjh+vMyX5+97RupxYiwybATkLCbBg9g0YHEqgUk+s3W/2PZT9Wn3YQmnRBlVSfzN+0c8YFtffEmEYvjB3QcXBxOpHSzCb0fO3NtuNsdq1WMnRnjPXKyp9xyQfWsEhCsNxRUArMp/YP4ORIxdcnxPvIjuKsDR+iGXHoodOuPA4VlXdWrtMMe4tGF5QNHUOo2QuKhYtUJnLaHu7aNq2oUVStnDqUK2AByhsbO9oiqnNZuD1d20wMtdyRHfu6fRmPOboAQOyK6NawDNCMFnvW3wF3iE391N0dqifOz0/yIIM/wd9HzGBie5R2JZKc3/Z/1Nm/+cGvNMVUIi67wVuBpPVFurChcF70Yv5Acj9moOdDIHtQ3+4yfhGtEN/G7Pewr3Pe+XglCidkLDD24PPt4OM1jgjpiOaB1DfeqDQw9aXrnWNOdt5ZsWuiNJx+1Lqb7B7q+wRgR7fQ1Wb6ekYIISzHwADcDoSN95/GhhOUZdPVLZrEO+0a2zu+kvlgVxDPQf+Tycs0lyJzoKlpEmo4/BRLvtGmZCJVFj3w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226f7a20-f3c6-465a-9d70-08d88054d158
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 00:01:44.9275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+LfKBtW1ZkBBOaqYh9nTGUcQkdMhbe4JHcdIDpijFgmPvwGx2MNj+YpPjCr5q1/bGAzeJdvvVVblF9AZiTiAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4899
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDAzLCAyMDIwIDEyOjQzIFBN
DQo+IFRvOiBYaW9uZywgSmlhbnhpbiA8amlhbnhpbi54aW9uZ0BpbnRlbC5jb20+DQo+IENjOiBK
YXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IGxpbnV4LXJkbWEgPGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnPjsgZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PjsgTGVvbg0KPiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBEb3VnIExlZGZvcmQgPGRs
ZWRmb3JkQHJlZGhhdC5jb20+OyBWZXR0ZXIsIERhbmllbCA8ZGFuaWVsLnZldHRlckBpbnRlbC5j
b20+OyBDaHJpc3RpYW4gS29lbmlnDQo+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMS80XSBSRE1BL3VtZW06IFN1cHBvcnQgaW1wb3J0aW5nIGRt
YS1idWYgYXMgdXNlciBtZW1vcnkgcmVnaW9uDQo+IA0KPiBPbiBUdWUsIE5vdiAzLCAyMDIwIGF0
IDY6MzYgUE0gWGlvbmcsIEppYW54aW4gPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
RGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KPiA+ID4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDIzLCAyMDIwIDY6NDUgUE0NCj4gPiA+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4NCj4gPiA+IENjOiBYaW9uZywgSmlhbnhpbiA8amlhbnhpbi54aW9uZ0BpbnRlbC5jb20+
OyBsaW51eC1yZG1hDQo+ID4gPiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+OyBkcmktZGV2
ZWwNCj4gPiA+IDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgTGVvbiBSb21hbm92
c2t5DQo+ID4gPiA8bGVvbkBrZXJuZWwub3JnPjsgRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRo
YXQuY29tPjsgVmV0dGVyLA0KPiA+ID4gRGFuaWVsIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT47
IENocmlzdGlhbiBLb2VuaWcNCj4gPiA+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEvNF0gUkRNQS91bWVtOiBTdXBwb3J0IGltcG9ydGlu
ZyBkbWEtYnVmIGFzDQo+ID4gPiB1c2VyIG1lbW9yeSByZWdpb24NCj4gPiA+DQo+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiArI2lmZGVmIENPTkZJR19ETUFfVklSVF9PUFMNCj4gPiA+ID4gPiA+
ICsgICBpZiAoZGV2aWNlLT5kbWFfZGV2aWNlLT5kbWFfb3BzID09ICZkbWFfdmlydF9vcHMpDQo+
ID4gPiA+ID4gPiArICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsgI2VuZGlmDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBNYXliZSBJJ20gY29uZnVzZWQsIGJ1dCBzaG91bGQgd2UgaGF2
ZSB0aGlzIGNoZWNrIGluDQo+ID4gPiA+ID4gZG1hX2J1Zl9hdHRhY2gsIG9yIGF0IGxlYXN0IGlu
IGRtYV9idWZfZHluYW1pY19hdHRhY2g/IFRoZQ0KPiA+ID4gPiA+IHAycGRtYSBmdW5jdGlvbnMg
dXNlIHRoYXQgdG9vLCBhbmQgSSBjYW4ndCBpbWFnaW5lIGhvdyB6ZXJvY29weQ0KPiA+ID4gPiA+
IHNob3VsZCB3b3JrICh3aGljaCBpcyBsaWtlIHRoZSBlbnRpcmUgcG9pbnQgb2YNCj4gPiA+ID4g
PiBkbWEtYnVmKSB3aGVuIHdlIGhhdmUgZG1hX3ZpcnRfb3BzLg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGUgcHJvYmxlbSBpcyB3ZSBoYXZlIFJETUEgZHJpdmVycyB0aGF0IGFzc3VtZSBTR0wncyBoYXZl
IGEgdmFsaWQNCj4gPiA+ID4gc3RydWN0IHBhZ2UsIGFuZCB0aGVzZSBoYWNreS93cm9uZyBQMlAg
c2dscyB0aGF0IERNQUJVRiBjcmVhdGVzDQo+ID4gPiA+IGNhbm5vdCBiZSBwYXNzZWQgaW50byB0
aG9zZSBkcml2ZXJzLg0KPiA+ID4gPg0KPiA+ID4gPiBCdXQgbWF5YmUgdGhpcyBpcyBqdXN0IGEg
J2RyaXZlcnMgYXJlIHVzaW5nIGl0IHdyb25nJyBpZiB0aGV5IGNhbGwNCj4gPiA+ID4gdGhpcyBm
dW5jdGlvbiBhbmQgZXhwZWN0IHN0cnVjdCBwYWdlcy4uDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBj
aGVjayBpbiB0aGUgcDJwIHN0dWZmIHdhcyBkb25lIHRvIGF2b2lkIHRoaXMgdG9vLCBidXQgaXQg
d2FzDQo+ID4gPiA+IG9uIGEgZGlmZmVyZW50IGZsb3cuDQo+ID4gPg0KPiA+ID4gWWVhaCBkZWZp
bml0ZWx5IGRvbid0IGNhbGwgZG1hX2J1Zl9tYXBfYXR0YWNobWVudCBhbmQgZXhwZWN0IGEgcGFn
ZQ0KPiA+ID4gYmFjay4gSW4gcHJhY3RpY2UgeW91J2xsIGdldCBhIHBhZ2UgYmFjayBmYWlybHkg
b2Z0ZW4sIGJ1dCBJIGRvbid0IHRoaW5rIHdlIHdhbnQgdG8gYmFrZSB0aGF0IGluLCBtYXliZSB3
ZSBldmVudHVhbGx5IGdldCB0byBub24taGFja3kNCj4gZG1hX2FkZHJfdCBvbmx5IHNnbC4NCj4g
PiA+DQo+ID4gPiBXaGF0IEknbSB3b25kZXJpbmcgaXMgd2hldGhlciBkbWFfYnVmX2F0dGFjaCBz
aG91bGRuJ3QgcmVqZWN0IHN1Y2ggZGV2aWNlcyBkaXJlY3RseSwgaW5zdGVhZCBvZiBlYWNoIGlt
cG9ydGVyIGhhdmluZyB0byBkbyB0aGF0Lg0KPiA+DQo+ID4gQ29tZSBiYWNrIGhlcmUgdG8gc2Vl
IGlmIGNvbnNlbnN1cyBjYW4gYmUgcmVhY2hlZCBvbiB3aG8gc2hvdWxkIGRvIHRoZQ0KPiA+IGNo
ZWNrLiBNeSB0aGlua2luZyBpcyB0aGF0IGl0IGNvdWxkIGJlIG92ZXIgcmVzdHJpY3RpdmUgZm9y
DQo+ID4gZG1hX2J1Zl9hdHRhY2ggdG8gYWx3YXlzIHJlamVjdCBkbWFfdmlydF9vcHMuIEFjY29y
ZGluZyB0byBkbWEtYnVmDQo+ID4gZG9jdW1lbnRhdGlvbiB0aGUgYmFjayBzdG9yYWdlIHdvdWxk
IGJlIG1vdmVkIHRvIHN5c3RlbSBhcmVhIHVwb24NCj4gPiBtYXBwaW5nIHVubGVzcyBwMnAgaXMg
cmVxdWVzdGVkIGFuZCBjYW4gYmUgc3VwcG9ydGVkIGJ5IHRoZSBleHBvcnRlci4gVGhlIHNnX2xp
c3QgZm9yIHN5c3RlbSBtZW1vcnkgd291bGQgaGF2ZSBzdHJ1Y3QgcGFnZSBwcmVzZW50Lg0KPiAN
Cj4gU28gSSdtIG5vdCBjbGVhciBvbiB3aGF0IHRoaXMgZG1hX3ZpcnRfb3BzIHN0dWZmIGlzIGZv
ciwgYnV0IGlmIGl0J3MgYW4gZW50aXJlbHkgdmlydHVhbCBkZXZpY2Ugd2l0aCBjcHUgYWNjZXNz
LCB0aGVuIHlvdSBzaG91bGRuJ3QgZG8NCj4gZG1hX2J1Zl9tYXBfYXR0YWNobWVudCwgYW5kIHRo
ZW4gcGVlayBhdCB0aGUgc3RydWN0IHBhZ2UgaW4gdGhlIHNnbC4NCg0KVGhpcyBpcyB0aGUga2V5
LCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0LiBJIHdhcyBhc3N1bWluZyB0aGUgaW1wb3J0
ZXIgY291bGQNCnVzZSB0aGUgc3RydWN0IHBhZ2UgaWYgaXQgZXhpc3RzLiANCg0KPiBJbnN0ZWFk
IHlvdSBuZWVkIHRvIHVzZSBkbWFfYnVmX3ZtYXAvdnVubWFwIGFuZCBkbWFfYnVmX2JlZ2luL2Vu
ZF9jcHVfYWNjZXNzLiBPdGhlcndpc2UgdGhlIGNvaGVyZW5jeSBtYW5hZ2VkIGlzIGFsbCBwb3Rl
bnRpYWxseQ0KPiBidXN0ZWQuIEFsc28gbm90ZSB0aGF0IGNwdSBhY2Nlc3MgZnJvbSB0aGUga2Vy
bmVsIHRvIGRtYS1idWYgaXMgYSByYXRoZXIgbmljaGUgZmVhdHVyZSAob25seSBzb21lIHVzYiBk
ZXZpY2UgZHJpdmVycyB1c2UgaXQpLCBzbyBleHBlY3Qgd2FydHMuDQo+IA0KDQpkbWFfdmlydF9v
cHMgaXMgYSBzZXQgb2YgZG1hIG1hcHBpbmcgb3BlcmF0aW9ucyB0aGF0IG1hcCBwYWdlL3NnbCB0
byB2aXJ0dWFsIGFkZHJlc3Nlcw0KaW5zdGVhZCBvZiBkbWEgYWRkcmVzc2VzLiBEcml2ZXJzIHRo
YXQgdXNlIGRtYV92aXJ0X29wcyB3b3VsZCB1c2UgdGhlIG1hcHBpbmcNCnJlc3VsdCBmb3IgY3B1
IGFjY2VzcyAodG8gZW11bGF0ZSBETUEpIGluc3RlYWQgb2YgcmVhbCBETUEsIGFuZCB0aHVzIHRo
ZSBkbWEgbWFwcGluZw0KcmV0dXJuZWQgZnJvbSBkbWEtYnVmIGlzIG5vdCBjb21wYXRpYmxlIHdp
dGggdGhlIGV4cGVjdGF0aW9uIG9mIHN1Y2ggZHJpdmVycy4gSWYgdGhlc2UNCmRyaXZlcnMgYXJl
IG5vdCBhbGxvd2VkIHRvIHBlZWsgaW50byB0aGUgc3RydWN0IHBhZ2Ugb2YgdGhlIHNnbCwgdGhl
eSBoYXZlIG5vIHdheSB0bw0KY29ycmVjdGx5IHVzZSB0aGUgc2dsLiBJbiB0aGlzIHNlbnNlIEkg
YWdyZWUgdGhhdCBkcml2ZXJzIHRoYXQgdXNlIGRtYV92aXJ0X29wcyBzaG91bGQgbm90DQpjYWxs
IGRtYV9idWZfYXR0YWNoKCkuIFRoZXkgc2hvdWxkIHVzZSBkbWFfYnVmX3ZtYXAoKSBldCBhbCB0
byBnZXQgY3B1IGFjY2Vzcy4gDQoNCj4gSWYgdGhpcyBpcyB0aGUgY2FzZSwgdGhlbiBJIHRoaW5r
IGRtYV9idWZfYXR0YWNoIHNob3VsZCBjaGVjayBmb3IgdGhpcyBhbmQgcmVqZWN0IHN1Y2ggaW1w
b3J0cywgc2luY2UgdGhhdCdzIGFuIGltcG9ydGVyIGJ1Zy4NCg0KU28gaGVyZSB3ZSBnby4gSSB3
aWxsIG1vdmUgdGhlIGNoZWNrIHRvIGRtYV9idWZfZHluYW1pY19hdHRhY2ggKGFuZCBkbWFfYnVm
X2F0dGFjaA0KaXMgYSB3cmFwcGVyIG92ZXIgdGhhdCkuDQoNCj4gDQo+IElmIGl0J3Mgb3RvaCBz
b21ldGhpbmcgcmRtYSBzcGVjaWZpYywgdGhlbiBJIGd1ZXNzIHJkbWEgY2hlY2tpbmcgZm9yIHRo
aXMgaXMgb2suDQo+IA0KPiBBcyBhIHRoaXJkIG9wdGlvbiwgaWYgaXQncyBzb21ldGhpbmcgYWJv
dXQgdGhlIGNvbm5lY3Rpdml0eSBiZXR3ZWVuIHRoZSBpbXBvcnRpbmcgYW5kIGV4cG9ydGluZyBk
ZXZpY2UsIHRoZW4gdGhpcyBzaG91bGQgYmUgY2hlY2tlZCBpbiB0aGUNCj4gLT5hdHRhY2ggY2Fs
bGJhY2sgdGhlIGV4cG9ydGVyIGNhbiBwcm92aWRlLCBsaWtlIHRoZSBwMnAgY2hlY2suIFRoZQ0K
PiBpZGVhIGhlcmUgaXMgdGhhdCBmb3IgZGV2aWNlIHNwZWNpZmljIHJlbWFwcGluZyB1bml0cyAo
bW9zdGx5IGZvdW5kIG9uZCBTb0MsIGFuZCBub3Qgc29tZXRoaW5nIGxpa2UgYSBzdGFuZGFyZCBp
b21tdSBtYW5hZ2VkIGJ5IHRoZSBkbWEtDQo+IGFwaSksIHNvbWUgb2Ygd2hpY2ggY2FuIGV2ZW4g
ZG8gZnVubnkgc3R1ZmYgbGlrZSByb3RhdGlvbiBvZiAyZCBpbWFnZXMsIGNhbiBiZSBhY2Nlc3Mg
Ynkgc29tZSwgYnV0IG5vdCBvdGhlci4gQW5kIG9ubHkgdGhlIGV4cG9ydGVyIGlzDQo+IGF3YXJl
IG9mIHRoZXNlIHJlc3RyaWN0aW9ucy4NCj4gDQo+IE5vdyBJIGR1bm5vIHdoaWNoIGNhc2UgdGhp
cyBvbmUgaGVyZSBpcy4NCj4gLURhbmllbA0KPiAtLQ0KPiBEYW5pZWwgVmV0dGVyDQo+IFNvZnR3
YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbg0KPiBodHRwOi8vYmxvZy5mZndsbC5jaA0K
