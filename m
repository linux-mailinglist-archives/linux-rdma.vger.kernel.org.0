Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D103364188
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhDSMVK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 08:21:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:40365 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233627AbhDSMVJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 08:21:09 -0400
IronPort-SDR: eW5KJRdbSxJuib5sgk1ceNa+BdTehlf4e2gZycp9p8Wli0WAaDssSfrrJMdMeyJaZ8J1KJaG4k
 SfaVPHvKdrxw==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="182811617"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="182811617"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 05:20:38 -0700
IronPort-SDR: eSlnHTDHke4uGjIFSu8JKzc/Y3uIyGqsTsR1/9Qu0roUCNxQr9G4ztE3LfdLA2+yvs64hMhctK
 q6TFEgCKhgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="400614262"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2021 05:20:38 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 05:20:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 19 Apr 2021 05:20:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 19 Apr 2021 05:20:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrEkvEH+z0nQZzCJQRptrhkx7o/T3xS0g4A8JsitKg0x4SrUt5aK4409IqcRrLINQnUAJa749gLsTTjlKI4dhlJOqHhG8IO6DJzpF2P0A75EqC8ToeHoI0vXs41PlEz/Yi7d6PSdCe1rFm/ltEq+WsAA+qir9VKXc+w7cb82Owv/EZhwgSgyFivuFsqRm4VTuUq//+99DKJUYXXYB7oMX7XCqhp5RcW6dSxr2caQLudSfz4tm7XoHlRtFUaMH5ptESZc+ccPYyOtta8egdjBtcebAHF4QkU+s7ovBfeY2GMaXJ8pGUccc11wih+kVezXzDMH64yp4FMp38C3m3Luhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k8jqswz0FVU8gmqZheFHyxh7zjZGz3youwTfexnn1k=;
 b=Wa7b5WHXo/HY6vq1bqK2LfQU2rqPUTcOB/f/O+RQiauSDkYt4qXKsPdGasSSxvs6qleOlUJtxFd74HqrSeNIlDvwm+IP4O+bf1yu8z5+3RR3ipy+wxxXoVXtlBeqAR5sLvNC6BVZt2aj4CH0Ejvg5+dEa+AEsG1Y34NfMcGZT6bMF8SejDtnp8KE7OhRlH7RIO0xAIP7rVVQ+bZl3Z+sPFC0fywIcOsEj8JJd7ALdFTEWv7Y6cx9O0uBKuh4wA7apWTa0DljM9cetLo8vhK3f+XMOmrsqqmMlPDGv2KsHsJMXrcvAMfWPowJH9ut2GibTkAIcDZOclRLMM3C4+sfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k8jqswz0FVU8gmqZheFHyxh7zjZGz3youwTfexnn1k=;
 b=xXy7kSfAhbLcySFTi1hfohG5hMcGj3nbYAcXUXgSEfwCnohR532lPrxAz6tiEVFl1z/dEz0vhLZRgtgimRILxwNjUv//KNIZj1CIDFaAAbhAYMDJIXooaghZN8LbwMp1T2DW2kZ8tLWLG39RG1y/fJnQX/UR+hN6DM+ETaclQsM=
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 DM6PR11MB4026.namprd11.prod.outlook.com (2603:10b6:5:198::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 12:20:33 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::c126:daad:3751:d0]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::c126:daad:3751:d0%5]) with mapi id 15.20.4020.022; Mon, 19 Apr 2021
 12:20:33 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Thread-Topic: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Thread-Index: AQHXJKMqFhnjP44dM0GAMJcJIUmVl6qfXK2AgAs5VwCAAAI7gIAABJYAgBFDTaA=
Date:   Mon, 19 Apr 2021 12:20:33 +0000
Message-ID: <DM6PR11MB33061E82DC3C60F2779C87DFF4499@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
 <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
In-Reply-To: <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [96.227.240.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35c74086-8b4d-40c8-2ba8-08d9032d87d5
x-ms-traffictypediagnostic: DM6PR11MB4026:
x-microsoft-antispam-prvs: <DM6PR11MB4026B5BF44C677DB64C4BCC1F4499@DM6PR11MB4026.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MFpXUTyXBm8Gjn93ic0Ii/ZwpzqloKQ61ZiQA3dIbTP6B5NeV3D5+GnBAPLdAy/biXDyF7vGG6E9NSAx/rhqaUAWKaPS8ZW03T7rfUbGp7wglu2/HXLiyaMg9aLKAmsype6WOJti+RcBTKjQk7mdKmEXnIuekWDZqacmZzEsSeKvFNJo+WtG0dfVx63ewGQz4octwTi6vNyjjdtkx/Ue4zl+0l7xtrQg1SLBjQbC9wa34k1PA6YyrgFfLBLPt2o9qWL+XKs1b4oluUQb8g4TBDQf0PIMPeCiDJn7ITkjWq0mS70b9cdPn66tFqwUfydfbFj9QBVHk3+SAZ/sPXzVRBfo4xJvlw8BwId4SmUjhy3MCTj8cMxfxUtOEK390jjStX6bBTCG7ZgKn57Z3QO1fgCMUeS0gedNg4xPHUUL41zwGbOW9rcKUkG7pIZNxbNDFqjj+YCkpztsIGKDE8Hg3okPpTABDBjlx95THLAwpI7LHT9iJ6fN9Q/6TV0tmICZu2vpcLWYFVHPGNBHAdU7CuP03f2njKrQHvGlLSzpx/LPuOiHS2G6vW8qhyyoiFAP5nTfPpdOJLSXNCsKsKOXfEcSmLIeKQVx38Vl0svYcLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(122000001)(38100700002)(33656002)(2906002)(8936002)(52536014)(55016002)(83380400001)(8676002)(53546011)(86362001)(6506007)(9686003)(66476007)(71200400001)(110136005)(66446008)(54906003)(316002)(5660300002)(186003)(66946007)(4326008)(478600001)(7696005)(26005)(66556008)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUZ5Y1l1dndlRFBsVGJYK1lOak0zVlhJNWw5dVk0d1lLbE5hSUNjWm9pVXoy?=
 =?utf-8?B?WTJ0Um5IRENVbzJ3d09PYXpoK0t6MkRkK2JNV0hINVVZbmVBZVFiTVFhRXM2?=
 =?utf-8?B?dTA1SmdEV09IT3JhWDc3VWo2ek94RnhMTmlpeERvU05adkZSc2lvVGtRSUpX?=
 =?utf-8?B?aXBSRUNWUTdNMnJzTXplZWduOHpWN3hKeGhTellYb1JnMFkrQzVSem0xdHRY?=
 =?utf-8?B?VjZBS1JQdnU4QXk3dWNUdXo3bG1TWWJWejR4WVpPQkliKzFETjR4OXNJRHJ3?=
 =?utf-8?B?aGVlSmFJQjB1dEZsT200bnovcjRFakNqQ1cwTURZMmJsSVVXeHR2a3JXbnVJ?=
 =?utf-8?B?QnJNMG4wSkhiVEJ6b0sxUm1GQ0FyVjVLb2RkazlVa05nZVNLMzJjSUpyUHc2?=
 =?utf-8?B?Wm5mS0ZHSWhqK2hnVktQMDhqaTJ3QVFPTmRQNzVWN3hmaUxjQWU1MEw0b3BG?=
 =?utf-8?B?QU5oVWtVcjZDZzd3SnJUUWxuOE10Z3hpOVNWc1Z4ZGxMN1ZkbUZPNUVGWjZh?=
 =?utf-8?B?eDNiSHd5Z0VpVFFYTS9JNzVJSXFkVEhrZjJQZlhDVzMrc1V5bE92UEZhRDJ0?=
 =?utf-8?B?QysxemVPdEswdjEzRXAzRHBLV1dkSDhicG90eDFXaGszZWVvYzVUQTJJdjgz?=
 =?utf-8?B?WjV3bGRMUkxJZUFFOFV1RlVXaDhyT1FZbGQvL05neWg1T2hDczhaN3RheGNQ?=
 =?utf-8?B?SDRXYS9PQnQ5cmlnQnRMYmpLRStzOW40NCsvNW80Y29yQUMyWDV4MnA4aXRm?=
 =?utf-8?B?MnFNdUhQL290MS9aZlB5N2ZhWVc1TG1kTFJSWmoxN3FxZTRPVGRMZmZ1TTAz?=
 =?utf-8?B?NjBucUJJRUJOdGgwbGZjRkVxYTF1Ukx2REdUWTlxY1ZvS0xKcm10b3Q0ZHFj?=
 =?utf-8?B?NkZ0TkI3VmJ2Q0pJN0VneS9oenZNWU93MW1sekx2UjYxclRtcFBINW5lS1RO?=
 =?utf-8?B?ZjhqVzRsblRCU2ZlNXZoMGhwdG9TQU9jM3FOUmlXUks5bVgzSS9mUm4rd2xU?=
 =?utf-8?B?NE56ekZ1Q3hYZk01WTBmcXdVMU1LcHBFWkhOMU9aWjJaWkUrbFpFRnkvbmJz?=
 =?utf-8?B?MG5JOEpPcEl0Uk44U1dwU3lhK3Z1d01qbk9aZEs5WFJKZ3VuRVJhTlFFZU81?=
 =?utf-8?B?cE0zLzI1bkNUaDFlc2kyUnVTSTd0Q081ejcwM2cyR3RYUnkwNUc2VFVtcUdE?=
 =?utf-8?B?Y0NVenVxakRURXVCWWdycG41a0ptWG5Va1BWeTFlS1pLN28rL0NWWlFHdHls?=
 =?utf-8?B?ME8zdHNqMTA2STRDRUtGcFI3QXdiMkZ6ajFDNWZ2MW1LN3ZvakFuWElCVVRK?=
 =?utf-8?B?V1VNVUF1ZUtuYUFKZXZvYnkrcWNMVmVobWU1WHZIVWdGcUk4UERXWTVsc0RT?=
 =?utf-8?B?WXdDSnUyVmc2S3NtblVIN1dtdlRtRXpUbExKcVFRdTlKRVllMFE2MjUxL1Z5?=
 =?utf-8?B?cEZzRStyOGkzYlZqQzdMdHJHNEp0RG5DUFFNUGFNVUNBMTYwVTNCVGJjNURG?=
 =?utf-8?B?QUk5QW1nNWFRMC9jQ2tTeUZaQjdzS0EyMGpTRUJWQ1VWOTFZeFFVRGRNcThr?=
 =?utf-8?B?SnJZeEJGVFYzQXU5V0pSVHN5Y0UxN082cnJHVFd0NnArRStwVVQrNGZ4V1Jx?=
 =?utf-8?B?RWlqTGVuQ015d28rOU1XTnpxaC8vUjcrb2pHdSsxR1RBRWxia2xCTUI3SjNo?=
 =?utf-8?B?cUZOSnkwVU93TEpzMzkvekxwOERERmthYWM3RHJFcjBBOWdERUxhVWhKb0VF?=
 =?utf-8?Q?2xsHnTKCD67J8ll2fpknTSmT3lJ0R1Ghs8QtPv5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c74086-8b4d-40c8-2ba8-08d9032d87d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 12:20:33.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBmglXjJYGYOBolMn9EKTil+jj7AURWcejX2a85pqPG8LmaE3m+HJJoG6UIEp2qDXbyN/1JQvYCAZxBO4yh84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4026
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVubmlzIERhbGVzc2Fu
ZHJvIDxkZW5uaXMuZGFsZXNzYW5kcm9AY29ybmVsaXNuZXR3b3Jrcy5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBBcHJpbCAwOCwgMjAyMSA4OjMxIEFNDQo+IFRvOiBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz4NCj4gQ2M6IGRsZWRmb3JkQHJlZGhhdC5jb207IGpnZ0B6aWVwZS5jYTsg
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IFdhbiwNCj4gS2Fpa2UgPGthaWtlLndhbkBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggZm9yLW5leHQgMDYvMTBdIHJkbWE6IFNldCBw
aHlzaWNhbCBNVFUgZm9yIHF1ZXJ5X3BvcnQNCj4gZnVuY3Rpb24NCj4gDQo+IE9uIDQvOC8yMDIx
IDg6MTQgQU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPiBPbiBUaHUsIEFwciAwOCwgMjAy
MSBhdCAwODowNjo0NkFNIC0wNDAwLCBEZW5uaXMgRGFsZXNzYW5kcm8gd3JvdGU6DQo+ID4+IE9u
IDQvMS8yMDIxIDQ6NDIgQU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPj4+IE9uIE1vbiwg
TWFyIDI5LCAyMDIxIGF0IDA5OjU0OjEyQU0gLTA0MDAsDQo+IGRlbm5pcy5kYWxlc3NhbmRyb0Bj
b3JuZWxpc25ldHdvcmtzLmNvbSB3cm90ZToNCj4gPj4+PiBGcm9tOiBLYWlrZSBXYW4gPGthaWtl
LndhbkBpbnRlbC5jb20+DQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGlzIGEgZm9sbG93IG9uIHBhdGNo
IHRvIGFkZCBhIHBoeXNfbXR1IGZpZWxkIHRvIHRoZQ0KPiA+Pj4+IGliX3BvcnRfYXR0ciBzdHJ1
Y3R1cmUgdG8gaW5kaWNhdGUgdGhlIG1heGltdW0gcGh5c2ljYWwgTVRVIHRoZQ0KPiA+Pj4+IHVu
ZGVybHlpbmcgZGV2aWNlIHN1cHBvcnRzLg0KPiA+Pj4+DQo+ID4+Pj4gRXh0ZW5kcyB0aGUgZm9s
bG93aW5nOg0KPiA+Pj4+IGNvbW1pdCA2ZDcyMzQ0Y2Y2YzQgKCJJQi9pcG9pYjogSW5jcmVhc2Ug
aXBvaWIgRGF0YWdyYW0gbW9kZSBNVFUncw0KPiA+Pj4+IHVwcGVyIGxpbWl0IikNCj4gPj4+Pg0K
PiA+Pj4+IFJldmlld2VkLWJ5OiBNaWtlIE1hcmNpbmlzenluDQo+ID4+Pj4gPG1pa2UubWFyY2lu
aXN6eW5AY29ybmVsaXNuZXR3b3Jrcy5jb20+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogS2Fpa2Ug
V2FuIDxrYWlrZS53YW5AaW50ZWwuY29tPg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBE
YWxlc3NhbmRybw0KPiA+Pj4+IDxkZW5uaXMuZGFsZXNzYW5kcm9AY29ybmVsaXNuZXR3b3Jrcy5j
b20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUv
aWJfdmVyYnMuYyAgICAgICAgfCAgMSArDQo+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L2N4Z2I0L3Byb3ZpZGVyLmMgICAgICAgICAgfCAgMSArDQo+ID4+Pj4gICAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L2VmYS9lZmFfdmVyYnMuYyAgICAgICAgICAgfCAgMSArDQo+ID4+Pj4gICAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L2hucy9obnNfcm9jZV9tYWluLmMgICAgICAgfCAgMSArDQo+ID4+
Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2k0MGl3L2k0MGl3X3ZlcmJzLmMgICAgICAgfCAg
MSArDQo+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFpbi5jICAgICAgICAg
ICAgICAgfCAgMSArDQo+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFkLmMg
ICAgICAgICAgICAgICAgfCAgMSArDQo+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21s
eDUvbWFpbi5jICAgICAgICAgICAgICAgfCAgMiArKw0KPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9tdGhjYS9tdGhjYV9wcm92aWRlci5jICAgIHwgIDEgKw0KPiA+Pj4+ICAgIGRyaXZl
cnMvaW5maW5pYmFuZC9ody9vY3JkbWEvb2NyZG1hX3ZlcmJzLmMgICAgIHwgIDEgKw0KPiA+Pj4+
ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3ZlcmJzLmMgICAgICAgICAgIHwgIDEg
Kw0KPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY19pYl92ZXJicy5j
ICAgIHwgIDEgKw0KPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody92bXdfcHZyZG1hL3B2
cmRtYV92ZXJicy5jIHwgIDEgKw0KPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X3ZlcmJzLmMgICAgICAgICAgIHwgIDEgKw0KPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFu
ZC91bHAvaXBvaWIvaXBvaWJfbWFpbi5jICAgICAgIHwgIDIgKy0NCj4gPj4+PiAgICBpbmNsdWRl
L3JkbWEvaWJfdmVyYnMuaCAgICAgICAgICAgICAgICAgICAgICAgICB8IDE3IC0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4+Pj4gICAgMTYgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTgg
ZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gQnV0IHdoeT8gV2hhdCB3aWxsIGl0IGdpdmUgdXMg
dGhhdCBhbG1vc3QgYWxsIGRyaXZlcnMgaGF2ZSBzYW1lDQo+ID4+PiBwcm9wcy0+cGh5c19tdHUg
PSBpYl9tdHVfZW51bV90b19pbnQocHJvcHMtPm1heF9tdHUpOyBsaW5lPw0KPiA+Pj4NCj4gPj4N
Cj4gPj4gQWxtb3N0IGlzIG5vdCBhbGwuIEFsdGVybmF0aXZlIGlkZWEgdG8gY29udmV5IHRoaXM/
IFNlZW1lZCBsaWtlIGENCj4gPj4gc2Vuc2libGUgdGhpbmcgdG8gYXQgbGVhc3QgaGF2ZSBzdXBw
b3J0IGZvciBidXQgb3BlbiB0byBvdGhlciBhcHByb2FjaGVzLg0KPiA+DQo+ID4gV2hhdCBhYm91
dCBsZWF2ZSBpdCBhcyBpcz8NCj4gPg0KPiA+IEknbSBzdHJ1Z2dsaW5nIHRvIGdldCB0aGUgcmF0
aW9uYWxlIGJlaGluZCB0aGlzIHBhdGNoLiwgdGhlIGNvZGUNCj4gPiBhbHJlYWR5IHdvcmtzIGFu
ZCBzZXQgdGhlIHBoeXNfbXR1IGNvcnJlY3RseSwgaXNuJ3QgaXQ/DQo+IA0KPiBJIHNlZSB3aGF0
IHlvdSBhcmUgc2F5aW5nIG5vdy4gS2Fpa2UsIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLCBidXQg
dGhlIGludGVudA0KPiBvZiB0aGlzIHBhdGNoIGlzIGp1c3QgdG8gbWFrZSBldmVyeXRoaW5nIGJl
aGF2ZSB0aGUgc2FtZSBpbiB0aGUgc2Vuc2UgdGhhdCBhDQo+IGRldmljZSBjb3VsZCBoYXZlIGEg
ZGlmZmVyZW50IHBoeXNpY2FsIE1UVS4gVGhlIGZpZWxkIGdvdCBhZGRlZCB0byB0aGUNCj4gaWJf
cG9ydF9hdHRyIHByZXZpb3VzbHkgc28gdGhpcyBpcyBnaXZpbmcgaXQgYW4gaW5pdGlhbCB2YWx1
ZSB2cyBsZWF2aW5nIGl0IHVuc2V0Lg0KW1dhbiwgS2Fpa2VdICBDb3JyZWN0Lg0KICANCj4gDQo+
IC1EZW5ueQ0KDQo=
