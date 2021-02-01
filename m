Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED130AD85
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhBARN1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 12:13:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:23522 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhBARNW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Feb 2021 12:13:22 -0500
IronPort-SDR: Bo3sEwYlV+rPR8Nv9Ku7zqF/ZZlh2OEUZApMOfrVw4PTReMgYEl4M/AnHnOx2ESeuF481SwJUK
 WQ3DxmVYJoUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="159887043"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="159887043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:12:42 -0800
IronPort-SDR: gjDdF4FPbz1CO7YtkpSSMgKNCx4M+PoJgKz6xWic+JuMRmSghW63wwKrVpeoAFyLiu8rpm2MU0
 FKh2mIXkwtZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="405834162"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2021 09:12:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 09:12:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 09:12:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 1 Feb 2021 09:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiwiuX3tCP3WrYhryJ4Mg7ZfGtfzrDfFNEDUXKIElvV+OgzGBOqd4+S5q30n1RLrHwvD+ONaqjD49dyoK5+HSAqOK9Az6HbEfmMx9FarWImYmsx6XVKDTkRJcGK/3WKpQs2T83QKFvyhL7VOYNJ77X7G3Ur4vp+6A4FInSihTFXnTx6NI8OJJ/EUJTIBCC7mL9yn79OpaUYwQZO+JLpx15yO8MHfNnRyz9LgpoT2DCn39BfwjJNCYwxI5GJbFhwwD/h2bd2yoxtVvff2oTE4/8yD72twRzibZkNoSF7Sw+NAGD8TzzwESWwGJyOb8/nffN0w50abgVymi1paPLZQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNM2oWq9Htt9eVPSGtPFZGmV5WidufMM8Ylxvftvx5s=;
 b=iQ3FSOiHxG4kxjvCccYlbPQNxungJk+RgqAI44Wp3Rqqu3e+zCDHb5x/R05YlQ0mMOM9hOSrbzmyHa87DpO8vGSsx270E/srMtCyYk1KhefJ8NfUfR4ioLXcYFmItAamyJiMYMaEku7h+PmWOo1bxxZBrdESTFD4t4SY0p18/XS4nlQFg2Dr2HVDm1VdVMvZT29uQBJFXAefjzxt4VRrLsCDLSXDgcMHs1g76MgUGR8TsFJF0tH6N1xBXpc+gWUNtIbUorDkC9sXfMXwIlG6ZcbCY2u8RtrhVX1iR9fOWuwgs6jlep6LwVrgs67OB67AuyjJ+iwbSVi0HB7yka3ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNM2oWq9Htt9eVPSGtPFZGmV5WidufMM8Ylxvftvx5s=;
 b=dtrRht6HbeGZ5FsOFmRRNlaFzRe1GRaHp8AfEbokr7UiaE2wR5iBlPFdBorzk2CY1LmgMvhLtFheoViSf2P1Ke/2eyqwnK/h/sTNtKA9+x9dfFC2e+4tZOWH5Rx7zliDEaDcpe2QI6YxQ1d5PZ6iZpZlwGp4f3yRA6hzhmG7b/4=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR1101MB2112.namprd11.prod.outlook.com (2603:10b6:301:50::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 17:12:37 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28%6]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 17:12:37 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH rdma-core v7 5/6] tests: Add tests for dma-buf based
 memory regions
Thread-Topic: [PATCH rdma-core v7 5/6] tests: Add tests for dma-buf based
 memory regions
Thread-Index: AQHW81IuKgbK67xKWkWTrvoviqU6oKpBc/sAgAIfJVA=
Date:   Mon, 1 Feb 2021 17:12:36 +0000
Message-ID: <MW3PR11MB4555F45D21C7375CED57E0B5E5B69@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-6-git-send-email-jianxin.xiong@intel.com>
 <b147c3ca-5754-f317-9f3b-5fbd42eaf4c0@nvidia.com>
In-Reply-To: <b147c3ca-5754-f317-9f3b-5fbd42eaf4c0@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 139e1c58-97b6-4e54-67f1-08d8c6d492c2
x-ms-traffictypediagnostic: MWHPR1101MB2112:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21124E164BA1AF5523051C38E5B69@MWHPR1101MB2112.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUxxWGYCDt6voReumf/6A5Q1k3sKknWEnjA80UcPVombf/cX9JpJ47e9FiABpfseGQf7KznystmpM8VNUukqVSAvfS2rWwcdr4FJr7CVom+ov8i6gizz5oWgR40bufea5bFMUMLAcDQvHODHv85zMEZ9BixL6yz38pVcLSMFWbTGMnIDnKXHCdNaH1V/dBIsCgS0/oie1Fg4jKIdIvnMC+smDtea70yrNWg10GEfbafi0o08tt6gF0EP9+DvRb50aIFbG66+YuSafyzJLNzHhpXU5+8Lsokt0LUoKbsMsC7dr2QbrcAPgCxjFAQYzQlnAxqfEYEeEhsHGzJSHlovs8LSL2J9mGsZNFs/AbO3n8DyykTI32B/czIVgHTwIfIoZ1UnjS2ZsJdozI8ZtkLmlVCV4ATZKgDUkZo8BWoCQxkjnTXZCeDQSFmr92Ge7qEkIRZ+QFfXz39FyJldJ8F0kvtz0gTulPQLBM+QHCtcxB4yhAStC0glCtaHOCocFv2T/snGCWXaSbDDSHu9XM885g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(110136005)(53546011)(6506007)(54906003)(9686003)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(186003)(4326008)(55016002)(8676002)(52536014)(7416002)(7696005)(83380400001)(8936002)(33656002)(316002)(71200400001)(5660300002)(26005)(86362001)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?akJ3T01vdmVRUXEyeUE3eE05NWREYXcrejhIQjREMmdkRnNJV3hoSFFjRjFK?=
 =?utf-8?B?bUo4NGRNSWk1RGYvdkFhLzd0d054MW1qSVZTdFVvbExkNXFHWW9semZTYTV3?=
 =?utf-8?B?UEtRZFZxYmVZY1hybHA0TER0QXAyaC9pSzQxTTduQ3NiSlV5ckd0UFU5M1FY?=
 =?utf-8?B?Vlk0UVhHaHBWc3BtcGRua2U1UWgvRmZKVHoybDhRK3gvZXRjZ2MwTWM0bllV?=
 =?utf-8?B?aUZNMnF4WW16UVRjdXpTZXExSlcyS3Fzd0J4ZGpyVjRsenRNNzBNTVIzQXh0?=
 =?utf-8?B?VC9ueUlDTFRQNVNvSEN2Q1NLYjB4RXEyYW0xcXhTVGIvLzJpQ3BTU1RVNnBi?=
 =?utf-8?B?YlF6WHhVejlST09BMk14MFBHMnUveXBiQlpNb0lHc3E4ejF6Zjd1Yy9FN0or?=
 =?utf-8?B?TG9vaUlXUUhmL2pzbTNubjhWY2NyR1pVWjBwSG5zSzdCckFNRFZBcnBReFFI?=
 =?utf-8?B?M0sydlN5ZTVSN0RyMU84M1hMSW9BT3lNV0N4WUlnRE9LYjBKOTBCWkxMYTFi?=
 =?utf-8?B?aTJBZXlLbGFnMUhNY1ExVVBMUUlSS2RCVG1aYy9DV0ZtN1JJNUNtN3VwSndu?=
 =?utf-8?B?WEp3cGo4ZFRSUDF5TDg5N2hVVDVRSkRqNXZjWHdTOEZ0czBVTjl3dkd6NzVP?=
 =?utf-8?B?d1RIQ1RCWlFWSzlRaitVb2pFQ0tjNm40YXZzOC95SG1ZRnY0UG0rbHBKR2RQ?=
 =?utf-8?B?Ly81OElkUTQxeXVTR21UcklHNmtSd011ZDFhZGh3ajZ4OGpsV3RWYmVPMzQ4?=
 =?utf-8?B?UGI4Yk1nQW5mM3JWM1ZneHhuUnZPdG9kbmovYWJNaWlqdjNmSE1zSDFGOTMv?=
 =?utf-8?B?MlZWYzZheWJLV09EZU8yY0RwYm02c0hheHYrc1lnSFE0bE85QUJHMXk4bzc3?=
 =?utf-8?B?NzNrVzIzbjJrbkpHRW1MZi9UaVVlZ1pGNVBoekYzbUFFNElJTE5JY0VJOTUr?=
 =?utf-8?B?cjN4TEhuY3dsejkxQytabkFaYU5iQnM0SUtXTlNaWTBkUytIVkF5T1ZPUTAy?=
 =?utf-8?B?Z1dkUEdTb1Q4cFBuZ0crdi9ZRVFJQmxCR21mZzBNWFZOQ09LTm5qcTMvQXdl?=
 =?utf-8?B?T1JtU29MUHRGRVdMVXJXSElMRVRNQk1qVVRZcDlHQkIzS2tjcXpmQ3h5ZG8x?=
 =?utf-8?B?d1lRbGU5dmtFdnpkdUo1U0lCaUlXZFMrcVlkaDhTWTc3YUsydTRTbzJUNTJi?=
 =?utf-8?B?Tm5ReUFWTW5jRjNKajJxa0grWTc4SkhlVHB6T0hlOHlBUHo4MWJOY0NYa243?=
 =?utf-8?B?MHlrUVVUY1MyYjBna1c0TUJZdURkMTZoVlIxcnVCc2NydjZ0ckI3U0FId2pX?=
 =?utf-8?B?VjZnU2ZCZnV1NXpEUlUwNGg3N1p6aDlDUEVGc0ZYbUltREc3SFR4T0FDbnp5?=
 =?utf-8?Q?Y+ZNa2RjuYsHWtxK8cZzVLVKlKvfuDiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139e1c58-97b6-4e54-67f1-08d8c6d492c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 17:12:36.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgAujVEe5ndfdkAkPoz2m/eNEtCOy2/4YvxcP2FjiVOlk8Icig2emRq++c69o2fnXoBw1jmARzq+jQiTuwVS1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2112
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEh1YmJhcmQgPGpodWJi
YXJkQG52aWRpYS5jb20+DQo+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSAzMSwgMjAyMSAxMjo0NSBB
TQ0KPiBUbzogWGlvbmcsIEppYW54aW4gPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPjsgbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IERvdWcgTGVkZm9yZCA8ZGxlZGZvcmRAcmVkaGF0LmNvbT47IEphc29uIEd1bnRob3JwZSA8
amdnQHppZXBlLmNhPjsgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBTdW1pdCBT
ZW13YWwNCj4gPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPjsgQ2hyaXN0aWFuIEtvZW5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsgVmV0dGVyLCBEYW5pZWwgPGRhbmllbC52ZXR0ZXJAaW50
ZWwuY29tPjsgRWR3YXJkIFNyb3VqaQ0KPiA8ZWR3YXJkc0BudmlkaWEuY29tPjsgWWlzaGFpIEhh
ZGFzIDx5aXNoYWloQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggcmRtYS1jb3Jl
IHY3IDUvNl0gdGVzdHM6IEFkZCB0ZXN0cyBmb3IgZG1hLWJ1ZiBiYXNlZCBtZW1vcnkgcmVnaW9u
cw0KPiANCj4gT24gMS8yNS8yMSAxMTo1NyBBTSwgSmlhbnhpbiBYaW9uZyB3cm90ZToNCj4gPiBE
ZWZpbmUgYSBzZXQgb2YgdW5pdCB0ZXN0cyBzaW1pbGFyIHRvIHJlZ3VsYXIgTVIgdGVzdHMgYW5k
IGEgc2V0IG9mDQo+ID4gdGVzdHMgZm9yIHNlbmQvcmVjdiBhbmQgcmRtYSB0cmFmZmljIHVzaW5n
IGRtYS1idWYgTVJzLiBBZGQgYSB1dGlsaXR5DQo+ID4gZnVuY3Rpb24gdG8gZ2VuZXJhdGUgYWNj
ZXNzIGZsYWdzIGZvciBkbWEtYnVmIGJhc2VkIE1ScyBiZWNhdXNlIHRoZQ0KPiA+IHNldCBvZiBz
dXBwb3J0ZWQgZmxhZ3MgaXMgc21hbGxlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW54
aW4gWGlvbmcgPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPg0KPiANCj4gSGkgSmlhbnhpbiwNCj4g
DQo+IEl0J3MgYXdlc29tZSB0byBzZWUgYSBHUFUgdG8gSUIgdGVzdCBzdWl0ZSBoZXJlIQ0KPiAN
Cj4gPiAtLS0NCj4gPiAgIHRlc3RzL2FyZ3NfcGFyc2VyLnB5IHwgICA0ICsNCj4gPiAgIHRlc3Rz
L3Rlc3RfbXIucHkgICAgIHwgMjY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPiA+ICAgdGVzdHMvdXRpbHMucHkgICAgICAgfCAgMjYgKysrKysN
Cj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjk1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9hcmdzX3BhcnNlci5weSBiL3Rlc3RzL2FyZ3Nf
cGFyc2VyLnB5IGluZGV4DQo+ID4gNDQ2NTM1YS4uNWJjNTNiMCAxMDA2NDQNCj4gPiAtLS0gYS90
ZXN0cy9hcmdzX3BhcnNlci5weQ0KPiA+ICsrKyBiL3Rlc3RzL2FyZ3NfcGFyc2VyLnB5DQo+ID4g
QEAgLTE5LDYgKzE5LDEwIEBAIGNsYXNzIEFyZ3NQYXJzZXIob2JqZWN0KToNCj4gPiAgICAgICAg
ICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLS1wb3J0JywNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBoZWxwPSdVc2UgcG9ydCA8cG9ydD4gb2YgUkRNQSBkZXZpY2UnLCB0eXBlPWlu
dCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWZhdWx0PTEpDQo+ID4gKyAg
ICAgICAgcGFyc2VyLmFkZF9hcmd1bWVudCgnLS1ncHUnLCBuYXJncz0nPycsIHR5cGU9aW50LCBj
b25zdD0wLCBkZWZhdWx0PTAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZWxw
PSdHUFUgdW5pdCB0byBhbGxvY2F0ZSBkbWFidWYgZnJvbScpDQo+ID4gKyAgICAgICAgcGFyc2Vy
LmFkZF9hcmd1bWVudCgnLS1ndHQnLCBhY3Rpb249J3N0b3JlX3RydWUnLCBkZWZhdWx0PUZhbHNl
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGVscD0nQWxsb2NhdGUgZG1hYnVm
IGZyb20gR1RUIGluc3RlYWQgb2YNCj4gPiArIFZSQU0nKQ0KPiANCj4gSnVzdCB0byBiZSBraW5k
IHRvIG5vbi1HUFUgcGVvcGxlLCBob3cgYWJvdXQ6DQo+IA0KPiAJcy9HVFQvR1RUIChHcmFwaGlj
cyBUcmFuc2xhdGlvbiBUYWJsZSkvDQo+IA0KPiANCg0KPC4uLj4NCg0KPiA+ICtkZWYgY2hlY2tf
ZG1hYnVmX3N1cHBvcnQodW5pdD0wKToNCj4gPiArICAgICIiIg0KPiA+ICsgICAgQ2hlY2sgaWYg
ZG1hLWJ1ZiBhbGxvY2F0aW9uIGlzIHN1cHBvcnRlZCBieSB0aGUgc3lzdGVtLg0KPiA+ICsgICAg
U2tpcCB0aGUgdGVzdCBvbiBmYWlsdXJlLg0KPiA+ICsgICAgIiIiDQo+ID4gKyAgICBkZXZpY2Vf
bnVtID0gMTI4ICsgdW5pdA0KPiA+ICsgICAgdHJ5Og0KPiA+ICsgICAgICAgIERtYUJ1ZigxLCB1
bml0PXVuaXQpDQo+IA0KPiB1bml0Pz8gVGhpcyBpcyBhIEdQVSwgbmV2ZXIgYW55dGhpbmcgZWxz
ZSEgTGV0J3Mgcy91bml0L2dwdS8gdGhyb3VnaG91dCwgeWVzPw0KPiANCg0KVGhhbmtzIGZvciB0
aGUgZmVlZGJhY2suIFdpbGwgaW50ZWdyYXRlIHRoZSBzdWdnZXN0aW9ucyBpbiB1cGNvbWluZyBw
YXRjaC4NCg0KSmlhbnhpbg0K
