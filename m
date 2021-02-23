Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72957323270
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 21:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhBWUty (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 15:49:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:32482 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhBWUt2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Feb 2021 15:49:28 -0500
IronPort-SDR: F+jKyJ0mEWjXjFbYjwEB9wdPmY4Y5z/NlJTs1O6MDh2muZ6vOmJqMc2ZDJDQDBPajUn8pSorAF
 wxNgLTi5Gd5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="184238433"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="184238433"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 12:48:45 -0800
IronPort-SDR: YyJ3aWDuBqY5bsZn5Yu1TdS4ma1LW8et0JQu3AEcPjXmHevUCArMT/SiM+KSRYJG9NfRSolit/
 YAcIG39Rr/hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="593377032"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2021 12:48:44 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 12:48:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Feb 2021 12:48:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Feb 2021 12:48:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK7neLoeqDZEEO5u+go0xQsdyk1j61BqPIyQQIJvNFU+kS29uIkyqmef5lAduIv+2jmibOgPizw0LW4LgMhPuNxkiSMRmcXUY7YTSx6z+fxrKBk0vPnnZRdylbs/fWVLBohZuMaULnD7dE2DUGaoltWoDRuAtSxLIR90fR2mgOMx6PvXityBVMSPdgTQkNhYFttaeCzR7MmmK5/Lu02GRM1g/U+kz8ltZFIBSTJXmfS9StXI5SL9RaABMXlobuCoQ6nwpr8xxPAccst6kCwEh0NsOiNW1XhNWbgNNLhzzhzatNQFtuVXcjls0pFHXKpCyQq08NMFcnNwEQxdMCw+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9hiFS9FotoJiLFV5RQwUxtOSfYK93KXLcyis1oRB+w=;
 b=e7jHghsQ13NVw0jaXxfN7Sue1USw30btmWkEU9NViFt95j8jkTLcl5vRIpumrz8NEHwp0leGuE3UjsdYtTCBoUQGRofQ2McaigRkjpPD2Jrtgkl1XzCZtkPnvuG4oll/fUOcWEravEXRN3SP42iQW8gGs2zHlPhKYqd+FwSE6pZcUuPqiR5MwSQ2vfNXIM+VLb8sphZOJABVcEtTZplsXMLARZ6D75UuaBlrnt5VIdYxmwcqKLoZasCJOQJxTAdt/NGQCYPH7M8nBQ0nSsElcgptDjVqgAq25W69h2YF3sTmmgTYUavXbut1ilM2Y/5D5MXwhDTROJSkkuom9VEMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9hiFS9FotoJiLFV5RQwUxtOSfYK93KXLcyis1oRB+w=;
 b=x5qFbmqxlZSfZ8JHovYAKv+QOATKzwUWz3DJL7QTVeBAxiDlkzhl3IKNohdNVJ7WAp5YI7SeZOtKH6BcGyiVLeZG8A3V7PAg9Rp35IJnszRjbEzp9Tm/hBRrQ8eE/j+dltkW9WQeDDtPSyS00XDr+TI/7mtOaIevWIKWha+YkCM=
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by MWHPR11MB1389.namprd11.prod.outlook.com (2603:10b6:300:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 20:48:42 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::435:317d:1c41:9755]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::435:317d:1c41:9755%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 20:48:42 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: ibv_req_notify_cq clarification
Thread-Topic: ibv_req_notify_cq clarification
Thread-Index: AQHXBeA7OnmuUcWYc0yznONdEF6dmapd3meAgAAx6ACAAAi4gIAEQhUAgAHbcQCAAB6egIAABYGAgAA6NACAAB8mUIAA/YiAgABMUOA=
Date:   Tue, 23 Feb 2021 20:48:42 +0000
Message-ID: <MW3PR11MB4651E18E0D74699538E37E6F9E809@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
 <20210222155559.GH2643399@ziepe.ca>
 <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
 <MW3PR11MB46519518F772EAFA758C45229E819@MW3PR11MB4651.namprd11.prod.outlook.com>
 <47a7c3a3-ebe1-7fa1-b47e-650ad4d6e736@amazon.com>
In-Reply-To: <47a7c3a3-ebe1-7fa1-b47e-650ad4d6e736@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.67.182.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826927b0-de90-4a6f-b8bf-08d8d83c6800
x-ms-traffictypediagnostic: MWHPR11MB1389:
x-microsoft-antispam-prvs: <MWHPR11MB13892CDE05E110CB0DA51FD59E809@MWHPR11MB1389.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKlvrFdA6fLr8NTkdJaUSV98RogKbxAYso5mr7VBChtSDLXkdePb5RJS0L7afwp2iwfso4xkwNKL4/FMg6pmTIPBO88JVgO+UaXOiggVEIMbivgmsvj+NgTAFOSya1tnpP1y2nStr9Bv9jwXXluzNEeu/Eica6pGZUTu9ErsDGAKnU2KiO322jF2DFcnqHugdYRBy9qUuhQ3n2LWnm8cxzITr9BGG6SoD0KAQebtLTYtQoff8QcmXWmJYRC+Fo5pU7ayp7k2cyGh/cPsNtB6zS+EAe7yJ74gHXPt2gE/BaToJt51L32/ix2gCF74h2G1n0NEkV5cDe3a1EahF+98EEVNE5VmBXbisE++LBkT01j3g7LnFxCyp1aQuDE6hTH0V4kt5atoYssm5FFGQQFHm24B1oGA9qpx/aTl/x9KAOaAKm69ygTQTSjb9lmUjlu5FzGbHzw+LgOxOBrre+wusKAZVmlehGhNprIvzzuo+IrI/OOkxuviKXA1igdZT7PYhOXo0PnMt7Mvh49pMbRoPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(396003)(136003)(76116006)(110136005)(7696005)(55016002)(66946007)(71200400001)(33656002)(66476007)(83380400001)(52536014)(66446008)(6506007)(64756008)(4326008)(66556008)(86362001)(26005)(5660300002)(316002)(8936002)(7116003)(186003)(2906002)(478600001)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eXRTR2lBQncvUmJiWWNjcm8zQjJUTnVYcm9CMzN5ZGV0MWxmaDVYblBBZ3lQ?=
 =?utf-8?B?clZESkMxSTZPc2pCUExOaG5hM0Jna2xaTThxUGtndVBUTXd4UnpJeGRmenZR?=
 =?utf-8?B?dFdjeWVPTzJNMS9RcHBsTmEyKzZrRGpobUZpOTVDSERudnZiUUU4Wmk0Yy9U?=
 =?utf-8?B?YkxLK0JXalA4WElPdHFLTWlRMTB5RXMrUW1xL2Z1QTVodnJudEpDd3dTbFRV?=
 =?utf-8?B?S3BXNE1wWkx3SlRrYzRmckFqbUkrWjF3eGRiSGRWSDdhNjFIUG9OL1Fmci9R?=
 =?utf-8?B?QUsrRGhaRmh4TXVtalZPYU1hbkJSWjk4LzRZZUZpM0p4cExSM0w4UTNpakpk?=
 =?utf-8?B?bGhmOUZzT0xNbmZZcWVXTmh1RjZTVHoxdmVoOFpNMXNGZXVQTGI4THdCek93?=
 =?utf-8?B?UEdLQUpWR2YwRmxvcXlVWW9ESHFCL29POG5CRGl2N1cvVlJsMGFtdTJlWFIv?=
 =?utf-8?B?RWd0YU9lZ1ROdjdOdVdGYWNMaWRMWll6WHp5L0s0ektIZVJxYzh3aUJoTVU2?=
 =?utf-8?B?bm1tODRyL2MvWVVZeGRISGF4ODFIZEw4a0phL0NIUThsbXJXSlZuOU5OTVA3?=
 =?utf-8?B?RkhDYlBCRUZISjhPdmd2ZEhmc0NJOUJmMDE5QWRIMGhvc0hzQS9IVitmUTJj?=
 =?utf-8?B?VndCWExUb3oyWDVseVpDam1yMll0dnBUQS9TdTFqVzBudDAxTXlEcWhWOTJo?=
 =?utf-8?B?SUhabGhNOVZQODY1ZU54eTl5R2pKQ2J2M2liUEYxWWVzV2Y4b1F6QlBRbVRY?=
 =?utf-8?B?RTgxeG9LRnhZNXdiM2YxeFhTNkkvLzhITUptMXlmakVUSkZkWk1LSXNsWnRy?=
 =?utf-8?B?dEdKWS8wb3hYWE5JMEhtNUhEbE85cEx4bFIrNm5PTFNjUnN0bkd3c2gvYWRT?=
 =?utf-8?B?UFRQN3BmV2JiV3FDaE8veERjdTU1MkFtSTFpSjVLUzRsTlZYcmxsOEl0SEhn?=
 =?utf-8?B?RXkwY1BZa1J4N1hXS1B1TUEyL3R5bmJVU2hJaFlhMHM1RSs2RmNHK3V0bEtI?=
 =?utf-8?B?QlpvVEJabVlRTDBNTGl5ZjBpWXYxY2hhYWlHNWhMVFBWOS9na2RZOFRtL2da?=
 =?utf-8?B?Z081aTM5YU95OTZrK1lacjFZWW1pRm5CQmJxUk5CVUVMWStpR0tOOGFlajQr?=
 =?utf-8?B?RGQ3bWloK09hOTBma0dvYmJuTFY5NHdRc0wrK3llNUJqWHdhUjlrMzc5SVA0?=
 =?utf-8?B?L3JpcDgvSnhzNHRic08rSzhaUlc5Q25vOXZFcDVDNGVhald1VkZkMkRvYkRj?=
 =?utf-8?B?TGFlSFpkU28rbDhUSlNXQjVxK0hkTnZUS0xpZGZXTzdZdU9HRDloUnZ3K2Vi?=
 =?utf-8?B?aG91ajVhUU04cHMxYmZBSzNNMDhIbHI5aXhIT1kxQkpiK2J4Nk13VHhBUkNn?=
 =?utf-8?B?RGpJNFlxV1VHalk5aHE0Nkw0dTN5N3RMUE13MUdWbjhHNGdzY3RReW5BZUhO?=
 =?utf-8?B?WStIM1daTmEvYjYxL08wK2lxakMxZ1ovKzlaVDdWOTN2VGRFV0tiRDI4aG03?=
 =?utf-8?B?QUlpK0p3SUQwS2FreHB1bzFOVFg5WDRoNEVrbllLRFhWMzZkQi8zUWRlTGxq?=
 =?utf-8?B?aE1BSi9YRitlNzBQZ1M1eGZkY2RqVDZ1elRFcTc5cGVLWXRVWW82RS9CRDlo?=
 =?utf-8?B?cXlOdXFLT29oc0ZtUTJML2s2SXFId3VDN3U5VDBxRTZyZEYyc1JTRTVzNU5k?=
 =?utf-8?B?ODROSEZuT2NQZHg0aDZ2SnQ3SjJpMGRlR0NDUGpnTTBGZW9RUXZUWW54NTlD?=
 =?utf-8?Q?UowTt3hT0xEDeTlwlbJFRc1cTlq0VMrEVBCCXlG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826927b0-de90-4a6f-b8bf-08d8d83c6800
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 20:48:42.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw7JW/I1+gfRd7sDAWxXMrleyhXXMEjkdw63otdHSlb9GFSIyhAV57xmIQtksULHDb22TVls2eD6Gvkr0pP4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1389
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBJIGFncmVlIHRoYXQgdGhpcyBiZWhhdmlvciBpcyBtb3N0IGxpa2VseSBiZXR0ZXIsIGJ1dCBp
dCBjb250cmFkaWN0cyB0aGUgYXBpDQo+IGFncmVlbWVudC4NCj4gSXQgc2VlbXMgbGlrZSB5b3Ug
c2hvdWxkIHdyaXRlIHlvdXIgYXBwIGFjY29yZGluZyB0byB0aGUgcHJvdmlkZXIgeW91J3JlIHVz
aW5nDQo+IGluIG9yZGVyIHRvIGdldCBpdCByaWdodC4NCg0KVGhlIGFwcCBzaG91bGQgY29kZSBm
b3IgZWRnZSB0cmlnZ2VyZWQgYmVoYXZpb3IgZm9yIGNvcnJlY3RuZXNzLiAgSSdtIHNheWluZyBp
ZiB0aGUgTklDIGFjdHVhbGx5IHVzZXMgbGV2ZWwgdHJpZ2dlcmluZyAoSSBkb24ndCBrbm93IGlm
IHRoZXkgZG8gb3Igbm90KSwgdGhlIGFwcCBjYW4ndCB0ZWxsIGFuZCB3aWxsIGp1c3Qgd29yay4N
Cg0KPiA+IFRoZSBhcHAgY2FuIGRvOg0KPiA+DQo+ID4gV2FrZXVwDQo+ID4gV2hpbGUgcmVhZCBj
cWUgc3VjY2VlZHMNCj4gPiAJUHJvY2VzcyBjcWUNCj4gPiBSZWFkIGNxIGV2ZW50DQo+ID4gQXJt
IGNxDQo+ID4gLyogY3FlJ3MgbWF5IGhhdmUgYmVlbiB3cml0dGVuIGJldHdlZW4gdGhlIGxhc3Qg
cmVhZCBhbmQgYXJtaW5nICovDQo+ID4gV2hpbGUgcmVhZCBjcWUgc3VjY2VlZHMNCj4gPiAJUHJv
Y2VzcyBjcWUNCj4gPiBTbGVlcA0KPiA+DQo+ID4gT3Igc2hvcnRlbiB0aGlzIHRvOg0KPiA+DQo+
ID4gV2FrZXVwDQo+ID4gUmVhZCBjcSBldmVudA0KPiA+IEFybSBjcQ0KPiA+IFdoaWxlIHJlYWQg
Y3FlIHN1Y2NlZWRzDQo+ID4gCVByb2Nlc3MgY3FlDQo+ID4gU2xlZXANCj4gPg0KPiA+IEluIGJv
dGggY2FzZXMsIGFsbCBjcWUncyBtdXN0IGJlIHByb2Nlc3NlZCBhZnRlciBjYWxsaW5nIGFybSwg
YW5kIGl0J3MgcG9zc2libGUgdG8NCj4gcmVhZCBhIGNxIGV2ZW50IG9ubHkgdG8gZmluZCB0aGUg
Y3EgZW1wdHkuICBPbmUgY291bGQgYXJndWUgd2hpY2ggaXMgbW9yZSBlZmZpY2llbnQsDQo+IGJ1
dCB3ZSdyZSB0YWxraW5nIGFib3V0IGEgc2xlZXBpbmcgdGhyZWFkIGluIGVpdGhlciBjYXNlLg0K
PiANCj4gWWVhLCB0aGlzIHNlZW1zIGNvcnJlY3QuDQo+IEJ1dCBhcyBJIHNhaWQgaW4gbXkgcmVw
bHkgdG8gSmFzb24sIGxpYmlidmVyYnMgZXhhbXBsZXMsIHB5dmVyYnMgdGVzdHMgYW5kDQo+IHBl
cmZ0ZXN0IGFsbCBnbyBmcm9tICJSZWFkIGNxIGV2ZW50IiB0byAiQXJtIGNxIiBpbW1lZGlhdGVs
eS4NCg0KQm90aCBvcHRpb25zIHByb3ZpZGUgY29ycmVjdCBiZWhhdmlvciwgcmVnYXJkbGVzcyBv
ZiBob3cgc2lnbmFsaW5nIHdvcmtzLiAgVGhlIGlzc3VlIGlzIHRoYXQgcGVyZnRlc3QgZG9lczoN
Cg0KRm9yIEkgPSAxIHRvIDE2DQoJSWYgcmVhZCBjcWUgc3VjY2VlZHMNCgkJUHJvY2VzcyBjcWUN
Cg0KSW5zdGVhZCBvZg0KDQpXaGlsZSByZWFkIGNxZSBzdWNjZWVkcw0KCVByb2Nlc3MgY3FlDQoN
ClBlcmZ0ZXN0IHdpbGwgb25seSB3b3JrIGlmIGl0J3MgbHVja3kgb3Igd2l0aCBsZXZlbCBzaWdu
YWxpbmcuICBJIHdvdWxkIG5vdCBhc3N1bWUgcGVyZnRlc3QgaXMgY29ycmVjdCBqdXN0IGJlY2F1
c2Ugbm8gb25lIGhhcyByZXBvcnRlZCB0aGUgcHJvYmxlbSBiZWZvcmUuICA6KQ0KDQotIFNlYW4N
Cg==
