Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0B322246
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBVWlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 17:41:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:59966 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhBVWlt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 17:41:49 -0500
IronPort-SDR: j8d6pqI2SgbPHN646VFydRDwl9wstqtQGA+nn4BWmKFF6A11aNn3pYlpZj43tdAtoXE2mncsm2
 DePtg7Fgy37Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="269564395"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="269564395"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 14:41:08 -0800
IronPort-SDR: 5NRVWKBb/0XFB4UixcQwRGMGJ6yFq/DIRr//EaYHYUpzlCM4X93uq6NAhEZPN/SJ6g2pBjCVhf
 eZdzr3bWrieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="514965774"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2021 14:41:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 14:41:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 14:41:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 22 Feb 2021 14:41:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 22 Feb 2021 14:41:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2HNaInf2KcdFjDG/efSrvmTNhJCHEmSNXkytYuJzIW7ZZFYDyATUJjGtiyNgabtmhZKgODKdfufzLp+IHsSbIScxMqSbttAkBRuSCsFqrbw8/4zHzeobBOKKDaJiYVO4OZaZHsCLEsk+sslaZ6Od7tXsQJ/yJBHopNAAhKP84IIWu7U/0yhFQZCnS09xY3mgVVwpuyoCt7RFdjkmTqGzDzQYRJbMX68MSY78RZoW/Px97mgHlMeVdew89Rs0hRYo0r37PlAWWsNCfp/4m6D9LlRfejJiJeY6jyjX7obG5bHfxCvjHWh0iLtiRnsHA+FQ6qPysTss1uAUW05vutOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QOJj9RZayLdrVthSSjtuDbtaxTMQjcsLd4cm3g/k7U=;
 b=jCvYz/PUFBguCThj8fJq+WeZJXVIeEaqv/fuRb4eCi2MpSTY4VW7K7WV0pVSUFwaM7aU3lVEEDBSDpA5uHD7wlun+v4XSxZ1VEibn6+OLM/rlJhi+1yMaePfexyflFaNqEVHfp31S/9mHvsmHrxmQkRIjm1YzOOOhOAn/6qQebVrIn6hpyEuY+dBWGJbt6ywp8HyDE9uZd+n0OpZYKxEz5KAvVtTuXrhKKDONwLsI8woItvfek2q+J4+dEysSS3AZQKFT2NGd1YqnVPz94U7rbrkHC8DAJBcoB3Bg/kILTEeyitp2mscOXzKzeHKBIv/JyFQIrPw2soFSj5C1joA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QOJj9RZayLdrVthSSjtuDbtaxTMQjcsLd4cm3g/k7U=;
 b=FiC2ZggzzQWKTktg0BOlDNxckhMs1IZuEQ1Cdv3ScXAjxeWSB/J3P8/0jL1wFC13FDuSgJMDIRwCtW0Z3EE7iE4IbDQ1tn6wr4bRPBP9rTNBLZ8UDeNdzcfMDOb2gYhdtLQFimuY3uCYQhXaKq5G0NiWoSaJE0oCF+UJXM6V4Sk=
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 22:41:06 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::435:317d:1c41:9755]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::435:317d:1c41:9755%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 22:41:06 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: ibv_req_notify_cq clarification
Thread-Topic: ibv_req_notify_cq clarification
Thread-Index: AQHXBeA7OnmuUcWYc0yznONdEF6dmapd3meAgAAx6ACAAAi4gIAEQhUAgAHbcQCAAB6egIAABYGAgAA6NACAAB8mUA==
Date:   Mon, 22 Feb 2021 22:41:06 +0000
Message-ID: <MW3PR11MB46519518F772EAFA758C45229E819@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
 <20210222155559.GH2643399@ziepe.ca>
 <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
In-Reply-To: <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
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
x-ms-office365-filtering-correlation-id: ce95e656-ce01-4a74-7c1b-08d8d782f10b
x-ms-traffictypediagnostic: CO1PR11MB5042:
x-microsoft-antispam-prvs: <CO1PR11MB5042F2DB9057700A2A5008879E819@CO1PR11MB5042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEdJycXcYgTppg9fQejDpvJzR0XG85b3aWQvku28pCZNXcbE+GcYQHGhPSlBsfwPQ4tfvwGJqyti+8R1YyhLLUhx0tEKQk3OXB+bnJt7KyNg5BBSY7u502AqGFVsjLOkiacZI4O3s7XKPsQWwbBFPEqRNvvzeGtNjW5Y6tdizUpWI5b4PBkufEzbTP+SH9RqYd+M5rtiqLZG8kWfhPjOasjAPyluqUKBc4kLWyc8C58bPDTXsZKEY2QwKegj/eVE6Cva6k9c673uijn+ARYm8FurKkiM7NP4W+CikiRAqR0a0Gd+JKhTGUlUkNmoyjibeyeQxw8v4VxMZCoYlo04VtZ8HqJV8lPO5lqMKGkhgQJ+aYaknJ3I64CI15vtnTX288OmLxgfRG0QUDfiqD01hkMjH8In0Cei0hKEct8C6EKZLzWL7SNojyohYLTRvPaSgslQlosk//LvGsE+aqEBb/2GUTpETrYdNdJ0ckpSvp8dtkmxf8AVcT6xdqYYNmQbPR9tVKpH0JpsLNtFAg9qJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(346002)(366004)(64756008)(66446008)(66946007)(76116006)(7696005)(478600001)(6506007)(186003)(110136005)(26005)(316002)(52536014)(4326008)(5660300002)(2906002)(7116003)(9686003)(55016002)(66556008)(66476007)(71200400001)(86362001)(8936002)(33656002)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SzVSUzRlQ1FlZE9NRlFPMEd1ZmozS09zZTVoTWY3Mm80dTVMdUlUTHV3NFZy?=
 =?utf-8?B?T2ZOUXI3OTFRdXBCU2sveXVmMUdVYUFwN01PYUl3UzlnbXNjSkQrSEpKenVn?=
 =?utf-8?B?bnAramFKNEtMZDNlRllLakJVZVE0Z1pCK3licFFiRFJDRkcwNC96RTMzUmJ0?=
 =?utf-8?B?ejdwTmtkVVF6Sk9tU3R3YzVoT3R5NFYyRTBxQ0cvOEFESFVJRDZockQzb0ZQ?=
 =?utf-8?B?dXg5VmcvS25mVUdmdW1PRkxSRnpYRzdwOVNPMlIwNVdLZWVjcmdvK3lhSGNT?=
 =?utf-8?B?VERYbEdiWk9xMkJrUjV2T250blMrc2pqK0hzb0hyN2JxdVFFVGVvUDFFeXor?=
 =?utf-8?B?NVdZbFduTHBYOUtzS2d6S2lxbzB4cm1LSlhGblZFSFZYSzZ1SGVaeWhNSDZm?=
 =?utf-8?B?TzcxbjluMTI2RlJ1TUFVdUtyOGMvclltcDNMRVFOejY4SmZLNC8wWjBDc2dX?=
 =?utf-8?B?UVVpcXVkNmtPL3R4emxjRnZKRllid2M4UVVSQ09FdFJoaXFKejB5MzU4R0dH?=
 =?utf-8?B?RWtnNjJLSDBqbENwQ0NTOHdoNUYvVTU2YWdWNnhPRGlzSnlqbGJzVUtmY1dn?=
 =?utf-8?B?Rll3L0psSXV1LzhXWmZGUHQ3dkxESkRoTDU4YjNMV1MrUHFpTHZSWHEyR3lU?=
 =?utf-8?B?dFJ5TmJsR05DNzdLdUZvK2JOTXNXZlBMWGtwc0JsY1dUZExDcFZ6bHpPS25F?=
 =?utf-8?B?UUJtSXhSV2ZqOUlsSFlSTzdhR0JneDdJYkhPL2NBellENXRWZmFiRDBJclE0?=
 =?utf-8?B?ZFpGTWhYZi84aFJiVGV1bWdBRTNBVm1iY2Q2bkpKcTQxRkdDazVFMGMzcDF2?=
 =?utf-8?B?QWtPSDlDUFVDeFYvMFJIWXpTZmQxWkI2R0FiY3I3ejZnMlVqUWdScVg0V1hi?=
 =?utf-8?B?NnQ4RXN1N29ZOGhHSDdzK2FnTEZLNnhCRDZ2VkNmMVE2Mnc4emt2M3dYQUt1?=
 =?utf-8?B?TXlOcTZFUERMMHBNakhFeEUwYlRMM2puc21vVVZSbHpmR0xobEt6T2FXZUlp?=
 =?utf-8?B?T043anB4OGl0Y2QvaXlROUVBNVdzdzlUQWJYcjdQcGIyYUFmd3ErNkY0NS9v?=
 =?utf-8?B?WVNmZDZPSVRhUFlnNFpBUGNNZG9SMVZob0VTUzVBaDJCZG9reXozNWFseUUx?=
 =?utf-8?B?QjU3RkdRRkVhdmZjeHQrTCtIeXZqcjVraFo2RjFyL1d6cTNGc3VkTTlmYjhh?=
 =?utf-8?B?bHBvd29ZY3RaVDZlSzFlUnpXY01idmFqMkNPbXZYM01LRmhVWmlMZ20rNUNm?=
 =?utf-8?B?TGlsdXNKUVVSeW12Q0E0N2w4Y2Jxa2R6ckZnRGJjQUdSSGZvcHZVU2NtaCs3?=
 =?utf-8?B?YW5VODVGejBmMmRJcDJONEJaN2c3UDV5YUtPWkM1NzNGVS96NHQ3U0lseC83?=
 =?utf-8?B?UGQ3S0E5bkhjWFM5S0VkcTUxdG5CNkg5Mnl6M1ZEcmtCZXJycTVtLzMvSXpy?=
 =?utf-8?B?K1lDaW1LeXJUZEFJNmMwazlnVzBvOUhYWUxncFFuVGhjc1N1VWZhUzFuNUVZ?=
 =?utf-8?B?bU80U0hUSkhpdERxQ2Q4L2xnRVgwRkJYRlZaa25xV0c2dHFDbTJuZWV3T1E3?=
 =?utf-8?B?QWhWdHpiUzlzNitCWFhKYUZnY3l0MlRieU51MTl5d3NQM0ZPT1BqM3V2WVNW?=
 =?utf-8?B?QndldmxUQ212YlZyNWNKazJQWmd5UXFYSFd3bmVrSHQwQUJIL0NxOFZPem1v?=
 =?utf-8?B?ZG1nWGY0VjJ4dWN0R29wY0pIMzR2V2hZOXpabEtIVlowd0hQZTFVMjZZUWg5?=
 =?utf-8?Q?2wEFRTKAizVUVQTSoYdM3GtZpPlXGO445PUFkSO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce95e656-ce01-4a74-7c1b-08d8d782f10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 22:41:06.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cf2pFTeQ3y5Iw7//uwv9teLzPtjjywHYy/XTHSMVIqNiAjQPxtmQdKa+cjZRVf0ZqCRuj36EHe3FNQuHM1dW9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+IEl0IGVsaW1pbmF0ZXMgcmFjZXMsIGlmIHRoZSBjb25zdW1lciBzYXlzICdJIHJlYWQgdXAg
dG8gWCBzZW5kIG1lIGFuDQo+ID4gaW50ZXJydXB0IGlmIFgrMSBleGlzdHMnIHdoZW4gWCsxIGFs
cmVhZHkgZXhpc3RzIGlmIHRoZXJlIGlzIGEgcmFjZQ0KPiA+IHByb2R1Y2VyIGhhcyBhbHJlYWR5
IHdyaXR0ZW4gaXQuIFNvIHNlbmQgYW4gaW50ZXJydXB0Lg0KPiANCj4gUmlnaHQsIHRoYXQncyB3
aGF0IEkgd2FzIGdldHRpbmcgYXQgaW4gbXkgZmlyc3QgcXVlc3Rpb24sIHRoaXMgaXNuJ3QgdGhl
IG5leHQNCj4gY29tcGxldGlvbiBmcm9tIHRoZSBkZXZpY2UncyBwZXJzcGVjdGl2ZS4NCg0KRnJv
bSB0aGUgc3BlYzoNCg0KUmVxdWVzdHMgdGhlIENRIGV2ZW50IGhhbmRsZXIgYmUgY2FsbGVkIHdo
ZW4gdGhlIG5leHQgY29tcGxldGlvbg0KZW50cnkgb2YgdGhlIHNwZWNpZmllZCB0eXBlIGlzIGFk
ZGVkIHRvIHRoZSBzcGVjaWZpZWQgQ1EuIFRoZSBoYW5kbGVyDQppcyBjYWxsZWQgYXQgbW9zdCBv
bmNlIHBlciBSZXF1ZXN0IENvbXBsZXRpb24gTm90aWZpY2F0aW9uIGNhbGwgZm9yIGENCnBhcnRp
Y3VsYXIgQ1EuIEFueSBDUSBlbnRyaWVzIHRoYXQgZXhpc3RlZCBiZWZvcmUgdGhlIG5vdGlmeSBp
cyBlbmFibGVkDQp3aWxsIG5vdCByZXN1bHQgaW4gYSBjYWxsIHRvIHRoZSBoYW5kbGVyLg0KDQpJ
dCBtYXkgaGVscCB0byB0aGluayBvZiBpdCBpbiB0ZXJtcyBvZiBlZGdlIHZlcnN1cyBsZXZlbCB0
cmlnZ2VyZWQuICBUaGUgSUIgc3BlYyBkZWZpbmVzIHRoZSBDUSBhcyBiZWhhdmluZyBzaW1pbGFy
IHRvIGFuIGVkZ2UgdHJpZ2dlcmVkIG9iamVjdC4gIEkgd291bGQgZ3Vlc3MgdGhhdCA5OSUgb2Yg
ZGV2ZWxvcGVycyB3b3VsZCBzdWNjZXNzZnVsbHkgd3JpdGUgYW4gZWRnZS10cmlnZ2VyZWQgYmFz
ZWQgYXBwbGljYXRpb24gdGhhdCBoYW5ncy4gIEEgbGV2ZWwgdHJpZ2dlcmVkIHdhaXQgaXMgbXVj
aCBlYXNpZXIgdG8gZ2V0IGNvcnJlY3QuDQoNCj4gU28gaW4gc3VjaCBjYXNlIHRoZSBjb25zdW1l
ciBpbmRleCBpbiB0aGUgYXJtIGRvb3JiZWxsIGlzIHVzZWQgdG8gaW5kaWNhdGUgd2hhdA0KPiBz
aG91bGQgYmUgY29uc2lkZXJlZCBhICJuZXciIGNvbXBsZXRpb24/IFRoaXMgaXMgbmV3IGZyb20g
dGhlIGFwcCBwZXJzcGVjdGl2ZS4NCg0KVGhlIHZlcmJzIEFQSSBvbmx5IGd1YXJhbnRlZXMgdGhh
dCB0aGUgQ1Egd2lsbCBiZSBzaWduYWxlZCB3aGVuIGEgbmV3IGNvbXBsZXRpb24gcmVsYXRpdmUg
dG8gdGhlIEhXIGhhcyBiZWVuIHdyaXR0ZW4uICBJZiB0aGVyZSdzIGEgZHJpdmVyIHRoYXQgY29u
dmVydHMgdGhlIGJlaGF2aW9yIGludG8gYSBsZXZlbCB0cmlnZ2VyZWQgb3BlcmF0aW9uLCBwcm9w
cyB0byB0aGVtISAgVGhhdCBpbXBsZW1lbnRhdGlvbiBpcyBmYXIgbW9yZSBsaWtlbHkgdG8gbWFr
ZSBpbmNvcnJlY3RseSB3cml0dGVuIGFwcGxpY2F0aW9ucyB3b3JrIHRoYW4gZXZlciBicmVhayBh
IGNvcnJlY3RseSB3cml0dGVuIG9uZS4NCg0KPiBCdXQgbG9va2luZyBhdCBpYnZfdWRfcGluZ3Bv
bmcgZm9yIGV4YW1wbGUsIEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgdGhhdCBjb3VsZA0KPiBldmVu
IHdvcmsuDQo+IFRoZSB0ZXN0IGFybXMgdGhlIENRIG9uIGNyZWF0aW9uIChjb25zdW1kZXIgaW5k
ZXggMCksIGNhbGxzIGlidl9nZXRfY3FfZXZlbnQoKSwNCj4gd2FrZXMgdXAgYW5kIGltbWVkaWF0
ZWx5IGFybXMgdGhlIENRIGFnYWluIChiZWZvcmUgcG9sbGluZywgY29uc3VtZXIgaW5kZXggaXMN
Cj4gc3RpbGwgMCkuDQoNCkluIHRoZSB3b3JzdCBjYXNlLCBhcm1pbmcgdGhlIENRIGp1c3QgcmVz
dWx0cyBpbiBzZWxlY3QvcG9sbC9lcG9sbCByZXR1cm5pbmcgaW1tZWRpYXRlbHkgdGhlIG5leHQg
dGltZSBpdCBpcyBjYWxsZWQuICBUaGUgdGhyZWFkIGZpbmRzIHRoZSBDUSBlbXB0eSwgcmVhcm1z
IHRoZSBDUSBhZ2FpbiwgYW5kIHNlbGVjdC9wb2xsL2Vwb2xsIGZpbmFsbHkgYmxvY2suDQoNCj4g
Pj4gUnVubmluZyB0aGlzIHdpdGggMzIgaXRlcmF0aW9ucywgdGhlIGNsaWVudCBkb2VzIHNvbWV0
aGluZyBsaWtlOg0KPiA+PiAtIGFybSBjcQ0KPiA+PiAtIHBvc3Qgc2VuZCB4IDMyDQo+ID4+IC0g
d2FpdCBmb3IgY3EgZXZlbnQNCj4gPj4gLSBhcm0gY3ENCj4gPj4gLSBwb2xsIGNxIChvbmNlLCB3
aXRoIGJhdGNoIHNpemUgb2YgMTYpDQo+ID4+IC0gbm8gbW9yZSBwb3N0IHNlbmQgKHJlYWNoZWQg
dG90X2l0ZXJzKQ0KPiA+PiAtIHdhaXQgZm9yIGNxIGV2ZW50IChidXQgYW4gZXZlbnQgaGFzIGFs
cmVhZHkgYmVlbiBnZW5lcmF0ZWQ/KQ0KPiA+DQo+ID4gSSBkb24ndCBrbm93IG11Y2ggYWJvdXQg
cGVyZi10ZXN0LCBidXQgaW4gdmVyYnMgYXJtaW5nIGEgbm9uLWVtcHR5IENRDQo+ID4gaXMgYXNr
aW5nIGZvciB0cm91YmxlDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIHdheSB0byB2ZXJpZnkgd2hldGhl
ciB0aGlzIHRlc3QgZ2V0cyBzdHVjaz8gTWF5YmUgSSBhbSBtaXNzaW5nDQo+IHNvbWV0aGluZz8N
Cg0KTG9va2luZyBhdCB0aGUgY29kZSwgSSBhZ3JlZSB0aGF0IGl0IGxvb2tzIHJhY3kgaW4gYSB3
YXkgdGhhdCBjb3VsZCBjYXVzZSBpdCB0byBoYW5nLiAgTXkgZ3Vlc3MgaXMgbW9zdCBwZW9wbGUg
cnVubmluZyBwZXJmdGVzdHMgYXJlIGxvb2tpbmcgZm9yIHRoZSBiZXN0IHBlcmZvcm1hbmNlIG51
bWJlcnMsIHNvIGJsb2NraW5nIGNvbXBsZXRpb25zIGFyZSByYXJlbHkgZW5hYmxlZC4gIEFuZCBl
dmVuIGlmIHRoZXkgd2VyZSwgaXQncyBzdGlsbCBhIHJhY2UgY29uZGl0aW9uIGFzIHRvIHdoZXRo
ZXIgdGhlIHRlc3Qgd291bGQgaGFuZy4NCg0KPiBXaGF0IGRvIHlvdSBtZWFuIGJ5IGFybWluZyBh
IG5vbi1lbXB0eSBDUT8NCj4gVGhlIG1hbiBwYWdlcyBzdWdnZXN0IGEgc2NoZW1lIHdoZXJlIHRo
ZSBhcHAgc2hvdWxkIGNhbGwgaWJ2X2dldF9jcV9ldmVudCgpDQo+IGZvbGxvd2VkIGJ5IGFuIGli
dl9yZXFfbm90aWZ5X2NxKCksIHRoZSBDUSBwb2xsaW5nL2VtcHR5aW5nIGNvbWVzIGFmdGVyIHRo
ZXNlLA0KPiBzbyBhdCB0aGUgdGltZSBvZiBhcm0gdGhlIENRIGlzbid0IGVtcHR5Lg0KDQpUaGUg
YXBwIGNhbiBkbzoNCg0KV2FrZXVwDQpXaGlsZSByZWFkIGNxZSBzdWNjZWVkcw0KCVByb2Nlc3Mg
Y3FlDQpSZWFkIGNxIGV2ZW50DQpBcm0gY3ENCi8qIGNxZSdzIG1heSBoYXZlIGJlZW4gd3JpdHRl
biBiZXR3ZWVuIHRoZSBsYXN0IHJlYWQgYW5kIGFybWluZyAqLw0KV2hpbGUgcmVhZCBjcWUgc3Vj
Y2VlZHMNCglQcm9jZXNzIGNxZQ0KU2xlZXANCg0KT3Igc2hvcnRlbiB0aGlzIHRvOg0KDQpXYWtl
dXANClJlYWQgY3EgZXZlbnQNCkFybSBjcQ0KV2hpbGUgcmVhZCBjcWUgc3VjY2VlZHMNCglQcm9j
ZXNzIGNxZQ0KU2xlZXANCg0KSW4gYm90aCBjYXNlcywgYWxsIGNxZSdzIG11c3QgYmUgcHJvY2Vz
c2VkIGFmdGVyIGNhbGxpbmcgYXJtLCBhbmQgaXQncyBwb3NzaWJsZSB0byByZWFkIGEgY3EgZXZl
bnQgb25seSB0byBmaW5kIHRoZSBjcSBlbXB0eS4gIE9uZSBjb3VsZCBhcmd1ZSB3aGljaCBpcyBt
b3JlIGVmZmljaWVudCwgYnV0IHdlJ3JlIHRhbGtpbmcgYWJvdXQgYSBzbGVlcGluZyB0aHJlYWQg
aW4gZWl0aGVyIGNhc2UuDQoNCi0gU2Vhbg0K
