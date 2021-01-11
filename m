Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685AE2F1D32
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbhAKR4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 12:56:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:21973 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732509AbhAKR4g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Jan 2021 12:56:36 -0500
IronPort-SDR: /X1RrcUx5qIHoEs4g3/ST8Q84ac1dFVpVuKlJWDtEwlwRsPATOfonxFpKv/3KeCcB1zU+W9Wq5
 as9+HOYsgmxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177130216"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="177130216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 09:55:55 -0800
IronPort-SDR: 55xgk8e2G4vF5DbflHnNQIarQpM9zwI/0ZVaOWi4fsIrY6rNlt244Pa+NidjAFJFLifXyd5Gvq
 q7k87S/Y34qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="464236107"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 09:55:55 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 09:55:55 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 09:55:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 09:55:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 11 Jan 2021 09:55:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCXutMx8pJu3m39wrpAfsi13Y5NW3F33MNXKQllQeMcv8naR2YzqLSuoxTHKQ497tlamiiIJ8hqF98mxtA+7ltvN5SUT00KfWda8jmpoinK4HXrjvGhB95ShqQa/nNpQZN/03RaREc9oTp2eBbzraLwB1C1RLUKT3upvZuRvLwO42/cgiI+FEIIfriOh1OM8KW2t+ngthyTPQW7bIAQ+rl56XHpm2vyZUe4Zlk5GE8FVXtVQewZokGVJRMQPaeR9AB8pVeCpr1IRN6gLl9P7lcd4GTBqwfT0i/CQyK9PEAtc/MjOINLCCY+b69lGRAiYfwRq/caN3hpkR2r/EQKsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2B+nUPi6WjkbL7fPl2MD2PzQ1RCBfUIq73L4eXZKMg=;
 b=SCdsKS4UehL9eTjfO4Atn5YDLhoUKXfUUP7Cf+qujHhP8Ay1Tb19xtnPqSWJsFQ2cYzbc4A6gf7kApJ5XmA7y3bm7d2h4QoaYAqCwWfmCXE5zsX+lIyKCDLSIQHMkHWzebAxRdCQ9EFS99NdYw2k5cdldpYnFQXAQ7zgE2jL9RkEsnbzhcpBo9Zaj89z0ZMUZb/icYLsZEO9ByQaKJCDn+dnEog+kXRealMC2E/Gv1OJH8M5TsF5gxXloXDPSF/GICz8KQ4v1usOrSGmbwD4xsWJasq+mNc//ZVE5o9zqidww0EW5tZlXXbHQXtSRoKUpjXpLGG34jdMbYCt0yLunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2B+nUPi6WjkbL7fPl2MD2PzQ1RCBfUIq73L4eXZKMg=;
 b=IriKCvHr3ahT3ydnXM5zSQhY2jwCu4JPrXtfmd/xQcwDCQyiVI7IHTckh7Q1m+voUJs/RAVZDqjPjKGKuO41nLMFCbjOiE4BnvWDfXZNDx5QQp2Cp3woaGkL5UFeaiXamZ+z8bLP7eL6FBpOByR2lChtGLbo+8CUtrvqC4i82rU=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 17:55:51 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 17:55:51 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Alex Deucher <alexdeucher@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [PATCH v16 0/4] RDMA: Add dma-buf support
Thread-Topic: [PATCH v16 0/4] RDMA: Add dma-buf support
Thread-Index: AQHW0ybv5Bnk7Ef2+EKwhnBRO9bgTqoitKeQgAAF2oCAACAzkIAAApoAgAABi2A=
Date:   Mon, 11 Jan 2021 17:55:51 +0000
Message-ID: <MW3PR11MB455518915ED5AE1F2FF0CAB1E5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <MW3PR11MB4555CCCDD42F1ADEC61F7ACAE5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20210111154245.GL504133@ziepe.ca>
 <MW3PR11MB4555953F638E8EDCD9F2CA90E5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <CADnq5_NTwynVt=ZPF-hiNFaWfEWiDnoTQCS0k1zx421=UAFSNA@mail.gmail.com>
In-Reply-To: <CADnq5_NTwynVt=ZPF-hiNFaWfEWiDnoTQCS0k1zx421=UAFSNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f9a98d3-5b49-48f1-ae47-08d8b65a2265
x-ms-traffictypediagnostic: CO1PR11MB4785:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB47851350BE682B51BE37DE8CE5AB0@CO1PR11MB4785.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TK7UXkX/RFeWBDuG+APhu0k2uvExZbQGsouLJ2cwZ6VSi0dadlMzu/jU0UhuMJ5aaFatFGy1ROM6v62Tf2NzDUom8sISyrAj0oeIVFFxCrURzb6GrFISdFqEVba6hxLFNPs6Zo3oaWEuOMzX75QSlACf1t47IGG95LYojnpUbljfW5m1pkohGYa3H/k5/f/Dsa8MxFLksQymoOOre9HedQ0HYkL3GVwUT+2h5il6Q8ByZWVD3HDNl481OYBGmXgmVyYuDgSK+y6/TVp8WE3YCWz/T6EYwZFVIJVaKTC/JqIUSsjNjQpbJHQ4LuBsv7fJUijelhK/30w6wx70IbLLy2rW7HYBdHCCyW6rWkJwryW54uryDm4Uzx8iFjOSvhH+e2CiVuCRYrs/YznYH+weq0nvk2XHnQJYfwZGcaOoZTpwy58R/qdwcvX5rSgQ6+jWT+wNCGqBUClHRplYcMpbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(2906002)(478600001)(71200400001)(5660300002)(4326008)(6506007)(86362001)(966005)(26005)(6916009)(52536014)(7696005)(8676002)(54906003)(316002)(53546011)(66556008)(66946007)(55016002)(76116006)(33656002)(64756008)(66446008)(66476007)(8936002)(83380400001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d0pTT3MyWVlmUkdnaVZ2YnNvMkUxb1ZyeFdUYjVhRS9YRHBSd2lVdkJoVmtT?=
 =?utf-8?B?RVdCNkIyaHBvSTFRT292eWNxNGNBZ3N5RUJ2TGNNTW1rNFJiR2oxaWxZYloz?=
 =?utf-8?B?QlFqcndPcHM1UlBiRFBIUjN1VXZZLzZ2Ui9FSFkzZDVWaS9hZ1hwTWdiMUJW?=
 =?utf-8?B?TUlpNC9jRUdvOG9vdkhDdVdoTVhzd3R2Q0RPNmErdXk4SDI5emgwNElsQTNR?=
 =?utf-8?B?QVFLblpLM01sdEROZ1pucjV1RjRITnVrT1IwbjNIMm5jMk43S0NEMFg2S3Vk?=
 =?utf-8?B?MlBHQXZPTW9YOXo1anl5SklxVFpFVjlGZGVualZKN0hTMlFKMDNFakllZTdG?=
 =?utf-8?B?UkxlRytQWCt3NmtubzU4ajJXYkE0czNrT3VpMTVYdUNMRlZucWhKVk9KdkdY?=
 =?utf-8?B?S0lEbzg0aHpFSmgzWlBGMXJNSDRUSzFUcTJSbHU4N1c1YitNVzV6YTdES09m?=
 =?utf-8?B?Skh1elNvQ0wyRk92amlmUkF2RDUxYkRWbmRFMGZnSWVORU1RTUUwdG1nakNQ?=
 =?utf-8?B?UXhKU2N5MkJXbFNYeXhqRjFyLzBheFZmOVZyQWZRbDAzTkxiOW9wK1JSSmt4?=
 =?utf-8?B?cm1jaWFGZUdnKzdQYUpoalluMW5DUjhtTGZVQmd0UGJnTjRySnFUQ01aV2xu?=
 =?utf-8?B?OGxjOVFVbTI4M1Zka0RjV0lPQ0FDODdTYVBGVkwrWk5YT1VITUNsRmliUnFX?=
 =?utf-8?B?Q1c1YUYzZGtzUCs0ZXRYV0RheXp2SzR6cWg1WGtCQ09QMjFZYkNVRkpEcUZI?=
 =?utf-8?B?QlRmSG0wZ3NuaWJSMnFnbWQ4L2NMQWt5dytxaWtGN1ovWEJtVXFzTkRJZUV0?=
 =?utf-8?B?Z0NyL0wyUnJJUHpwUnl1NW0xdU1STG1wMnV4TkEyS2puWFRhV1VGbzN1ZVMx?=
 =?utf-8?B?RTBFTllRejNkTlAzZDlORnZoZUZSaGZ2M1VDSEQ1RlVZWFBMd3VIUmNlS3dh?=
 =?utf-8?B?ajhFdytPNDdhM05aRHIzaDdjcGNoeEVGZ1RvZlRCVnRocHg1VlZsbjQzRnZQ?=
 =?utf-8?B?L05aRVZTVFlVOWE3ZW1zUTl1M3hzOVI3eGJoZmc5Q2dtT2kva3ZHZWNaRzRo?=
 =?utf-8?B?MEtxTVRUK1NuYkR5VE9IODVIdytrOGU0cHhhc0kveElUSkNDMVIraTgzUWtC?=
 =?utf-8?B?TDRHNitUa3RXQXRQWWtKTzBPeTgxeWtkMUpUV1JXdDRFVGZsdmg2SEJtbFQ3?=
 =?utf-8?B?d0lnYkUzNFp5NWhPbW1WbGlWcU5LTTRKQ0x1L0I3b09Fckd2Tk9zQk41OUEx?=
 =?utf-8?B?WlRhSk0vUHdHNW8yV1lRQjU2Wm1LNmpBSEdJRUZyNVVlbGFqbHo2Tk14ZWpJ?=
 =?utf-8?Q?/xjPxW7mK82nE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a98d3-5b49-48f1-ae47-08d8b65a2265
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 17:55:51.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61UH9TZxk5TUbo6ThfzGLNhmii+ZcLDx7eeSolMROgDiBfbk0qFyd3nnAFjqiu0TS+6E22AiqgcmUfrG0S46GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDExLCAyMDIxIDk6NDcg
QU0NCj4gVG86IFhpb25nLCBKaWFueGluIDxqaWFueGluLnhpb25nQGludGVsLmNvbT4NCj4gQ2M6
IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtl
cm5lbC5vcmc+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsNCj4gRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPjsgVmV0
dGVyLCBEYW5pZWwgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPjsgQ2hyaXN0aWFuIEtvZW5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxNiAwLzRd
IFJETUE6IEFkZCBkbWEtYnVmIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgSmFuIDExLCAyMDIxIGF0
IDEyOjQ0IFBNIFhpb25nLCBKaWFueGluIDxqaWFueGluLnhpb25nQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKYXNv
biBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAx
MSwgMjAyMSA3OjQzIEFNDQo+ID4gPiBUbzogWGlvbmcsIEppYW54aW4gPGppYW54aW4ueGlvbmdA
aW50ZWwuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiA+ID4gRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEBy
ZWRoYXQuY29tPjsgTGVvbiBSb21hbm92c2t5DQo+ID4gPiA8bGVvbkBrZXJuZWwub3JnPjsgU3Vt
aXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz47IENocmlzdGlhbg0KPiA+ID4gS29l
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+OyBWZXR0ZXIsIERhbmllbA0KPiA+ID4gPGRh
bmllbC52ZXR0ZXJAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTYgMC80
XSBSRE1BOiBBZGQgZG1hLWJ1ZiBzdXBwb3J0DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBKYW4gMTEs
IDIwMjEgYXQgMDM6MjQ6MThQTSArMDAwMCwgWGlvbmcsIEppYW54aW4gd3JvdGU6DQo+ID4gPiA+
IEphc29uLCB3aWxsIHRoaXMgc2VyaWVzIGJlIGFibGUgdG8gZ2V0IGludG8gNS4xMj8NCj4gPiA+
DQo+ID4gPiBJIHdhcyBnb2luZyB0byBhc2sgeW91IHdoZXJlIHRoaW5ncyBhcmUgYWZ0ZXIgdGhl
IGJyZWFrPw0KPiA+ID4NCj4gPiA+IERpZCBldmVyeW9uZSBhZ3JlZSB0aGUgdXNlcnNwYWNlIHN0
dWZmIGlzIE9LIG5vdz8gSXMgRWR3YXJkIE9LIHdpdGgNCj4gPiA+IHRoZSBweXZlcmJzIGNoYW5n
ZXMsIGV0Yw0KPiA+ID4NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIG5ldyBjb21tZW50IG9uIHRoZSBi
b3RoIHRoZSBrZXJuZWwgYW5kIHVzZXJzcGFjZSBzZXJpZXMuIEkNCj4gPiBhc3N1bWUgc2lsZW5j
ZSBtZWFucyBubyBvYmplY3Rpb24uIEkgd2lsbCBhc2sgZm9yIG9waW5pb25zIG9uIHRoZSB1c2Vy
c3BhY2UgdGhyZWFkLg0KPiANCj4gRG8geW91IGhhdmUgYSBsaW5rIHRvIHRoZSB1c2Vyc3BhY2Ug
dGhyZWFkPw0KPiANCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXJkbWEvbXNn
OTgxMzUuaHRtbA0KDQo=
