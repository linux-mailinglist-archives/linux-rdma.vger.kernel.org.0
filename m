Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2430E1BD
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhBCSCV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 13:02:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:61809 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbhBCR77 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 12:59:59 -0500
IronPort-SDR: mp/JtfDnYTumOvI3BJA+PbQLArUn1YbIvp36eW6g0IUOVw5wqSYLkGOf7zCwBzCWtc6lo1zwDU
 5yd4IgN4PNog==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="200051047"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="200051047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:58:50 -0800
IronPort-SDR: YfuinT6kOdWDpeJMn6rriwCV7HTAUVOSbvdNqCkqKVmyX89rdkF/pgHwGT3NdFPGfU2v7x3YO1
 yj7c/mZsZJog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="392565376"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2021 09:58:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 09:58:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 09:58:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 09:58:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WauYF2zr7osr80+q/xzLzIP7ynSq3lFroNMxV9PMUldnYtzvq5fOLqdfkly87zI9EawLRjDKsqoZTisyGw8pV7KazYRwGU0sIANcjfCzS5umwNHVdKllzg/U8DBDXiPmhzJ99PoYWs3mNrSFqvDbjurecWWVoenc+1ipqs9we0M3dbQhcQ43OhFrRVaUS6St/RrHMIfaHEqIL9P32fRhPd0eomuf34TMR6zVVDuAZsFnbzEZgHsjCrBbA3zQrdXQaWJnTggFqy4l1r1Lvryqu0SADDZJ1mO9++WGM5eHY2xFQlnIJKyYZIlq/9CZd6CvIxiqPRVQNcznmhyURu4Klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaJ+QqxjRAjkpi1i1DMqSh06Ab+F/ItEw7c6jc18GbM=;
 b=Gkb21svMnj5UkQ1E8xikxEnlhSVBvzQZGc6RmbdCpT+8z+JDPvZe+3BYAWklasYYJogfyxMIvtf+J8QnXSfD/vzzbO1q5FlkbzbWhhJkYWKsaw1O4i2MylM8NgQmCDbkCnIDTKyUYVoVl1E/sloQNb8zVvIjJzjm0/0NmUg8kG+CTYnKsw4WHlExx3BxAUqpoIkmlhJ5lJAb8u1luAXtc0j7lfE+18szJGGUgw5E7ZvDTDPPn2cPhBF1cUSM7X/Zz9jEb8d1NGIaO5+IaBrxt/2+nbYRrqihRraUrm6x0Y8Eb3/MUWplz98prkX5ttnXDTG03cTi/wIXJBhuZkvsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaJ+QqxjRAjkpi1i1DMqSh06Ab+F/ItEw7c6jc18GbM=;
 b=TS/RyDO7XxRnrLUt2rrCBAXmQqz1H8BWhGbu7OMf3ZstX3fa81BhcK3Di42pMfmIJu+u62InTnOceH+3LAh+DdpJegFgjLKOpiH31KfMRlaKRCBydcopDr12HGXfEpyipMS7f/Atcquy7MpxYYlxW7rycaKwr3BP7/cup5RzUJA=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR11MB1535.namprd11.prod.outlook.com (2603:10b6:301:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 17:58:43 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28%6]) with mapi id 15.20.3805.026; Wed, 3 Feb 2021
 17:58:43 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Gal Pressman" <galpress@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
Thread-Topic: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
Thread-Index: AQHW81IsBXvBf9ch/Ui3XtDALqd1H6pB5ZYAgAD3NICAAIRsAIAAFi0AgAAZeICAAXeSgIAA9XkAgACyvICAABOigIAAAIWw
Date:   Wed, 3 Feb 2021 17:58:43 +0000
Message-ID: <MW3PR11MB455504E449DC36622361DD22E5B49@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com>
 <20210201061603.GC4593@unreal>
 <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
 <20210201152922.GC4718@ziepe.ca>
 <MW3PR11MB455569DF7B795272687669BFE5B69@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YBluvZn1orYl7L9/@phenom.ffwll.local> <20210203060320.GK3264866@unreal>
 <MW3PR11MB455563A3F337F789613A9940E5B49@MW3PR11MB4555.namprd11.prod.outlook.com>
 <CAKMK7uHAD5FbDPeT2cD03HjHhvmMMG__muXqo=rTjd=htSMhtg@mail.gmail.com>
In-Reply-To: <CAKMK7uHAD5FbDPeT2cD03HjHhvmMMG__muXqo=rTjd=htSMhtg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 488c9d5a-f5ab-4b94-9867-08d8c86d589f
x-ms-traffictypediagnostic: MWHPR11MB1535:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1535C4432A7B6D6CAE9E4B66E5B49@MWHPR11MB1535.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yart6WFz1fj5+phmHvwmTDuIBUCtUYJshRIj5D41PSxS91dfIEHb2TGCNleBz76+/RBV/HU/QONQTOXwqM+40VQejDC19PUU5oujQwOQuR4Z+X7rLq9luiF5/nyUV8Y9BKr2zJEZsLxt9eE3ng1kLlZPAIf/INc/8JomSP2XelgpPBEslt4ftyMLFNEjjHUldDf3iad42Pb/cEvGO5dQiUc2NaeUDhlHzhY4jL/vLQ8Lzvy1Iq0t2jlWNKe1QiM6fyaBgWuQS+5WhQPlBd2vP5/GeCyOgK5ufBrD+AtthOh5EC8tV3MCSMvyWsIFII8AgfZqZTkDfRWsqNDIG/xhhivUMNXoP8nDrxC0V6kLvGLsgm/udh1qdpa4ZxhLd26KtT0qUsiOoGuzgo4ObcPG38Ccu1dywtp4jcjVp9qR9UYq2ZD2HFoaCCROBlppoIIAthOY68LqORJH+x4EJBo+HJHxbTmqLYah6Kju3kDvZwAb07v56XzoeQEKGP4WZRGyQXqk+jBsyttlbLGM08enNjV+AqHPQJWdp/UUeaCs2eFPb5etWRe78DhAvkWpQIO7gOOBuXJ3sLFdtKjLaG7r0QHtoyKfqXZ1q2wAdlJ1Itx+rzKWC56RDz0wLWcWVCcH+pEvTsIDJGoTvQMv3d4/ai5CRWRK+uhp8uLu/LrkeFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(366004)(136003)(54906003)(316002)(33656002)(9686003)(6916009)(478600001)(76116006)(5660300002)(66446008)(66946007)(8676002)(53546011)(55016002)(7696005)(966005)(7416002)(2906002)(52536014)(26005)(186003)(107886003)(83380400001)(8936002)(4326008)(71200400001)(86362001)(83080400002)(64756008)(66556008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aTdBTC9BNzM5WWhrRi9obnJSRytNdkdlcUYvbnN6ZjlkKzVwWktybDRRN2Rt?=
 =?utf-8?B?eUE4enF5cUZVNkF6Um9pMFhLUUtSVjZXaU1IbWIycUkrWTFsa1dTRkpJNzEz?=
 =?utf-8?B?L2s2b3ErSlZ6RU8wbjNvSjRSMVlOU2NzSXRRcVVrZUExNHJsWUxUMFptQmli?=
 =?utf-8?B?R3VIN2FEWmhsWHR2NDJwNjVFd0laQ2RkMHRvdmU1U0FCbUQrVXczTEpWc3A1?=
 =?utf-8?B?VVgvVlFvOHJUSXMvN0JlVGFrZFNTbU1ocy9tOUFzYUZIb1IrMXVvdktIakJJ?=
 =?utf-8?B?aHYrUlc0WW9tK1JDWW9YU0RvRnpQeG1WK0xZL2VzQ1ZKcURBTyttd1UvVEgx?=
 =?utf-8?B?Z3BRYWRERmp6UkFRZFYzNGtkdnJzOW5kTnF0WmYrVENxbHpXNlRQcVFpUzBR?=
 =?utf-8?B?R2VzbG5rZW1JdS95bnU5TnZvMStrMkhsbjlKSS9GSEN3Wjk5SHJuenF2Unpx?=
 =?utf-8?B?TmtnNDZ1aXNMQnBLalRia05jZHFoUGhzaTdXcFl2WmhCUG5tdW5vNDNVT28v?=
 =?utf-8?B?U2l3M1YyelFEcnZiU2taazBETUZDbGQvRW0veS9CMWI5M1dLdTVVQVhBb2dM?=
 =?utf-8?B?UTErTFNENDBaaHAzUjZJMWtHclBKQ1dtNENzcDFPRXBhZXF5bnBzMlRmL0Za?=
 =?utf-8?B?Q3hwV1UrVGt3TThvWWdVMkUxcGp4cEM3UEp4aW10bSszZ0ZBTXB3TjNHSWtB?=
 =?utf-8?B?NjluSkI5Q09HQWdicHBoTGs1Rm9QcStnM2hwVXIzNFdJdE9yREh1Q1BvdDh4?=
 =?utf-8?B?U0dGMEJLTWY0NzVVWEtBTlV4U0d5MkhwbVBCNUdHT2kvcDlnbW9MQ1dhMEQr?=
 =?utf-8?B?b2FEWkd6Z2o2WEgvNU1CYm9iMXZJWG1UTmZnMXpRbFBJYVg4WU9IdUl0YTIr?=
 =?utf-8?B?WlpHMDlJcjAvNGFNTEowc2ZtWHI0cFB3cUl0YWxUUDhwNmNFeFdldEVpT3d3?=
 =?utf-8?B?bWRZOENkaU92bmczbWY4cDRKRU1Jait3WWpUQUIvQ2s2MC9HdTBla0V1Wno4?=
 =?utf-8?B?RVJSQXczd3o5dElwVzRqSzhXeTBTTjBrU2tESkVxMjFMQWNjWmhzNEFWbzZj?=
 =?utf-8?B?dDVWQmtpeEZ6UTlhR0YrTk1ZWnhRSWQ4TWl2YUtZS3FPc1RKVjl2OExlTk10?=
 =?utf-8?B?cUhtM1B2ZWJQMldMN2MvVEl2bmFGejM4M3lvbE9UT2h5WDBMVHZsT1AzcFI5?=
 =?utf-8?B?dWlwRDZvQ3VKT0tQRnpjNzhxa1FDaHhCejdwT0lyUHViY3A5d1NYL3ZqbTVR?=
 =?utf-8?B?QjhXTDdhU0k5RVF0RlZCZnRobzg2QnQ4cS84ZFBKS0ZGYkUvWXo3L2ZBU0R3?=
 =?utf-8?B?bytZK1hteDlwOVpZbzJnSDllb2xzYjhGR0xNckJzR1hzVWdqVkR5enBmSHQ3?=
 =?utf-8?B?NmkzRGxHZUxIc0JDRWxIclh1K1Z5R0hWRDJoNEFZTGI1OFNlb1E5V29CZzlo?=
 =?utf-8?B?ZEp6YlZFVUpqYXpkQ3djZGw0TldQZVVDQU5vT2g5RFJyd0dPN3E5cXArQmgz?=
 =?utf-8?B?cHpDNGRTSU1wWDdmZHBNRHpGVFliVnR3TUQ0N2JpaFdKZWgvR3FUeXczemRK?=
 =?utf-8?B?eHo0YW90akxaeVFRNVMyNW1ycUFzTUhnZnZOcnQvM1ZZUGEzV2R3U2ZQUVN2?=
 =?utf-8?B?ckZmRW1MclZQTHBqRDl1U2d3aHg2MGMxR0c3RCsvZUk0RmZocnVsbkpadEEv?=
 =?utf-8?B?ZjRQUnJLWDdZRk1KSUZ1cm9HeHdmSVdlZnBZeVVvOExIMThmYVZ5UUVxYWxu?=
 =?utf-8?Q?fxWSFc7FWJGR/Viyn0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488c9d5a-f5ab-4b94-9867-08d8c86d589f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 17:58:43.5535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KX4Go7Slox4+zerCMgv7z5PeKNON0VVDuELR3bF+4SCZjf79S5SXTfLkP/VTFTQTvjDwwsKmi5TFfYiR3S6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1535
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMDMsIDIwMjEgOTo1MyBB
TQ0KPiBUbzogWGlvbmcsIEppYW54aW4gPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPg0KPiBDYzog
TGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6
aWVwZS5jYT47IEdhbCBQcmVzc21hbiA8Z2FscHJlc3NAYW1hem9uLmNvbT47IFlpc2hhaSBIYWRh
cw0KPiA8eWlzaGFpaEBudmlkaWEuY29tPjsgbGludXgtcmRtYSA8bGludXgtcmRtYUB2Z2VyLmtl
cm5lbC5vcmc+OyBFZHdhcmQgU3JvdWppIDxlZHdhcmRzQG52aWRpYS5jb20+OyBkcmktZGV2ZWwg
PGRyaS0NCj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgQ2hyaXN0aWFuIEtvZW5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsgRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQu
Y29tPjsgVmV0dGVyLCBEYW5pZWwNCj4gPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHJkbWEtY29yZSB2NyA0LzZdIHB5dmVyYnM6IEFkZCBkbWEtYnVmIGJh
c2VkIE1SIHN1cHBvcnQNCj4gDQo+IE9uIFdlZCwgRmViIDMsIDIwMjEgYXQgNTo1NyBQTSBYaW9u
ZywgSmlhbnhpbiA8amlhbnhpbi54aW9uZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxs
ZW9uQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAwMiwgMjAyMSAx
MDowMyBQTQ0KPiA+ID4gVG86IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4NCj4gPiA+
IENjOiBYaW9uZywgSmlhbnhpbiA8amlhbnhpbi54aW9uZ0BpbnRlbC5jb20+OyBKYXNvbiBHdW50
aG9ycGUNCj4gPiA+IDxqZ2dAemllcGUuY2E+OyBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpv
bi5jb20+OyBZaXNoYWkgSGFkYXMNCj4gPiA+IDx5aXNoYWloQG52aWRpYS5jb20+OyBsaW51eC1y
ZG1hIDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz47DQo+ID4gPiBFZHdhcmQgU3JvdWppIDxl
ZHdhcmRzQG52aWRpYS5jb20+OyBkcmktZGV2ZWwgPGRyaS0NCj4gPiA+IGRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz47IENocmlzdGlhbiBLb2VuaWcNCj4gPiA+IDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+OyBEb3VnIExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+Ow0KPiA+ID4gVmV0
dGVyLCBEYW5pZWwgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCByZG1hLWNvcmUgdjcgNC82XSBweXZlcmJzOiBBZGQgZG1hLWJ1ZiBiYXNlZCBNUg0K
PiA+ID4gc3VwcG9ydA0KPiA+ID4NCj4gPg0KPiA+IDwuLi4+DQo+ID4NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gKyNpbmNsdWRlIDxkcm0vZHJtLmg+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsjaW5jbHVk
ZSA8ZHJtL2k5MTVfZHJtLmg+ICNpbmNsdWRlIDxkcm0vYW1kZ3B1X2RybS5oPg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiArI2luY2x1ZGUgPGRybS9yYWRlb25fZHJtLmg+DQo+ID4gPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiA+ID4gSSBhc3N1bWUgdGhlc2Ugc2hvdWxkIGNvbWUgZnJvbSB0aGUg
a2VybmVsIGhlYWRlcnMgcGFja2FnZSwgcmlnaHQ/DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gPiBUaGlzIGlzIGdyb3NzLCBhbGwga2VybmVsIGhlYWRlcnMgc2hvdWxkIGJlIHBsYWNl
ZCBpbg0KPiA+ID4gPiA+ID4gPiA+IGtlcm5lbC1oZWFkZXJzLyogYW5kICJ1cGRhdGUiIHNjcmlw
dCBuZWVkcyB0byBiZSBleHRlbmRlZCB0byB0YWtlIGRybS8qIGZpbGVzIHRvbyA6KC4NCj4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gZHJtIGtlcm5lbCBoZWFkZXJzIGFyZSBpbiB0aGUgbGli
ZHJtIHBhY2thZ2UuIFlvdSBuZWVkIHRoYXQNCj4gPiA+ID4gPiA+ID4gYW55d2F5IGZvciBkb2lu
ZyB0aGUgaW9jdGxzIChpZiB5b3UgZG9uJ3QgaGFuZC1yb2xsIHRoZSByZXN0YXJ0aW5nIHlvdXJz
ZWxmKS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gQWxzbyBvdXIgdXNlcnNwYWNlIGhh
cyBnb25lIG92ZXIgdG8ganVzdCBvdXRyaWdodCBjb3B5aW5nDQo+ID4gPiA+ID4gPiA+IHRoZSBk
cml2ZXIgaGVhZGVycy4gTm90IHRoZSBnZW5lcmljIGhlYWRlcnMsIGJ1dCBmb3IgdGhlDQo+ID4g
PiA+ID4gPiA+IHJlbmRlcmluZyBzaWRlIG9mIGdwdXMsIHdoaWNoIGlzIHRoZSB0b3BpYyBoZXJl
LCB0aGVyZSdzIHJlYWxseSBub3QgbXVjaCBnZW5lcmljIHN0dWZmLg0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+IEppYW54aW4sIGFyZSB5b3UgZml4aW5nIGl0Pw0KPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiBTbyBmaXggaXMgZWl0aGVyIHRvIGRlcGVuZCB1cG9uIGxpYmRybSBm
b3IgYnVpbGRpbmcsIG9yIGhhdmUNCj4gPiA+ID4gPiA+ID4gY29waWVzIG9mIHRoZSBoZWFkZXJz
IGluY2x1ZGVkIGluIHRoZSBwYWNrYWdlIGZvciB0aGUNCj4gPiA+ID4gPiA+ID4gaTkxNS9hbWRn
cHUvcmFkZW9uIGhlYWRlcnMgKGRybS9kcm0uaCBwcm9iYWJseSBub3Qgc28gZ29vZCBpZGVhKS4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXZSBzaG91bGQgaGF2ZSBhIGNtYWtlIHRlc3QgdG8g
bm90IGJ1aWxkIHRoZSBkcm0gcGFydHMgaWYgaXQgY2FuJ3QgYmUgYnVpbHQsIGFuZCBweXZlcmJz
IHNob3VsZCBza2lwIHRoZSB0ZXN0cy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBZZXMsIEkgd2lsbCBhZGQgYSB0ZXN0IGZvciB0aGF0LiBBbHNvLCBvbiBTTEVTLCB0aGUgaGVh
ZGVycw0KPiA+ID4gPiA+IGNvdWxkIGJlIHVuZGVyIC91c3IvaW5jbHVkZS9saWJkcm0gaW5zdGVh
ZCBvZiAvdXNyL2luY2x1ZGUvZHJtLg0KPiA+ID4gPiA+IFRoZSBtYWtlIHRlc3QNCj4gPiA+IHNo
b3VsZCBjaGVjayB0aGF0IGFuZCB1c2UgcHJvcGVyIHBhdGguDQo+ID4gPiA+DQo+ID4gPiA+IFBs
ZWFzZSB1c2UgcGtnY29uZmlnIGZvciB0aGlzLCBsaWJkcm0gaW5zdGFsbHMgYSAucGMgZmlsZSB0
byBtYWtlDQo+ID4gPiA+IHN1cmUgeW91IGNhbiBmaW5kIHRoZSByaWdodCBoZWFkZXJzLg0KPiA+
ID4NCj4gPiA+IHJkbWEtY29yZSB1c2VzIGNtYWtlIGJ1aWxkIHN5c3RlbSBhbmQgaW4gb3VyIGNh
c2UgY21ha2UgZmluZF9saWJyYXJ5KCkgaXMgcHJlZmVyYWJsZSBvdmVyIHBrZ2NvbmZpZy4NCj4g
Pg0KPiA+IE9ubHkgdGhlIGhlYWRlcnMgYXJlIG5lZWRlZCwgYW5kIHRoZXkgY291bGQgYmUgaW5z
dGFsbGVkIHZpYSBlaXRoZXIgdGhlIGxpYmRybS1kZXZlbCBwYWNrYWdlIG9yIHRoZSBrZXJuZWwt
aGVhZGVycyBwYWNrYWdlLiBUaGUgY21ha2UNCj4gZmluZF9wYXRoKCkgY29tbWFuZCBpcyBtb3Jl
IHN1aXRhYmxlIGhlcmUuDQo+IA0KPiBFeGNlcHQgaWYgeW91ciBkaXN0cm8gaXMgYnVnZ3kgKG9y
IGRvZXNuJ3Qgc3VwcG9ydCBhbnkgZ3B1IGRyaXZlcnMgYXQNCj4gYWxsKSB0aGV5IHdpbGwgbmV2
ZXIgYmUgaW5zdGFsbGVkIGFzIHBhcnQgb2Yga2VybmVsLWhlYWRlcnMuDQoNClJpZ2h0LCB0aGF0
J3Mgd2h5IHdlIHdhbnQgdG8gY2hlY2sgZm9yIHRoZSBleGlzdGVuY2Ugb2YgdGhlIGhlYWRlciBm
aWxlIChmaW5kX3BhdGgoKSBkb2VzIGp1c3QgdGhhdCkgaW5zdGVhZCBvZiB0aGUgZXhpc3RlbmNl
IG9mIHRoZSBwYWNrYWdlKHMpLg0KDQo+IC1EYW5pZWwNCj4gLS0NCj4gRGFuaWVsIFZldHRlcg0K
PiBTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24NCj4gaHR0cDovL2Jsb2cuZmZ3
bGwuY2gNCg==
