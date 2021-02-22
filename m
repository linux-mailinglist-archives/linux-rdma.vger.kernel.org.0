Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEF321F3F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 19:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBVSkR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 13:40:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:35657 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhBVSji (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 13:39:38 -0500
IronPort-SDR: DGnsieTx6A/LHvueuUdZOuOm1ZewZLIuHwvx1aAN/nCXv6sdgwJ+HH0UeWCpl2t4UCSlb4i/Cg
 qpjYhPDrkySA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="164389258"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="164389258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 10:38:50 -0800
IronPort-SDR: 4288157xQIl2aGG1PGPIx9kDLnELTVjlDLkeMcMSkPo89qBl66XQZDR6O8zMp1L2QXx91INuX5
 UpzsToZrx7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="364111277"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2021 10:38:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 10:38:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 22 Feb 2021 10:38:49 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 22 Feb 2021 10:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJeQ2+RIHAVHxorp3DHEzjFe0L+85ZRInGX3z6A6cHhiOfd1cRcnt9kp2sYyHv4Z6pLYr5nrDR2pUrhLanBraSvQTAHyBSWr8rp8egkMqH5Kn93Go99L6jezQlTi5MB06ove/erfGuOJD6rhOPsGFbrOzpM1aUCdKzJcDmMExMQST58kTr8t4CWNKMhk7LtoZSEMEI8vlVjOaAoTiyrVYbEfBDBtdPe8dE2zfO3Nb4G3LM1PCh3V9XcLUlW3mzcKUerPDbojiu7wLECGEmivaMJRikgEhGAixFvm8+d3B+9WWpzjxxlVWOdzhkBJA+iZdhQsdapFHmJ5g1K6Go3zxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3mGIFh9uzcVjxAM5KAgGMU3b3huo5M8QQK7q7i/Eno=;
 b=Klx0u3TJOifI9NVerFwKzRs66pnEEU4BllsymFyND/iyaDjsS9bj6Yi9cg1IjWxCo18YkCniYLlzeoSrVebNngiywjiva6Ej9R4FDgTshYEIsQaPrHJYzljzs6hnUL0H6LnJHyfx5r/6ze0lCCUvMJOwvcdamuCj3EZ2pbwqAPW2Oi0cGBXP9J78Dey083hukzj8ayPQCM7HMEptbh5ooQUgs5gj880SizBMU1zoCaE6Rdh2Ry8ecp+AUHbg3qUvDjGvUdCaJM8EVfOnbfLMbDT8MmvON+DcrPKvMGZAU6f6Mq1mkp5ldN4pzT5vmCOxdG2hcJ12ZY2QjN1WhQB1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3mGIFh9uzcVjxAM5KAgGMU3b3huo5M8QQK7q7i/Eno=;
 b=zmfh/zj0gK0twurL8369be4wUCk8rDhDZugWbUaWYaDef/ZVKBorc/jx7otSu2E/nA4Kh4ekIXRhJ47HSkLzR0QSTyabS5eDdm7DWJ2st7+F2P9EiHHYMG0K7ULcLLC1Dwk/0JtGIVak05yxBYKqTkLMT9ORFsJ1nAashHDf2tU=
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by MWHPR1101MB2253.namprd11.prod.outlook.com (2603:10b6:301:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Mon, 22 Feb
 2021 18:38:48 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::435:317d:1c41:9755]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::435:317d:1c41:9755%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 18:38:48 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: ibv_req_notify_cq clarification
Thread-Topic: ibv_req_notify_cq clarification
Thread-Index: AQHXBeA7OnmuUcWYc0yznONdEF6dmapd3meAgAAx6ACAAAi4gIAEQhUAgAHbcQCAAB6egIAAMVBA
Date:   Mon, 22 Feb 2021 18:38:48 +0000
Message-ID: <MW3PR11MB46518F4C79C4114675F976F89E819@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
In-Reply-To: <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
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
x-ms-office365-filtering-correlation-id: c98fe018-ff3b-4836-1234-08d8d76117fa
x-ms-traffictypediagnostic: MWHPR1101MB2253:
x-microsoft-antispam-prvs: <MWHPR1101MB2253D87D09CE4134143763219E819@MWHPR1101MB2253.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwZidgNg/WIFhU/r9HUHLLIATGCYxJYzKdp395GTIU/BNdQajMJKcAxeeh4zQ5ySrzU6wfdPY0o7ykmMHhXfxMmPEaw18H5YgDCU1aKC+8JcfCy7ZJagMI6faJdbn5AM0f92DudwhfW+5C8hdgC+0Zgx2vxjvfe8Y2LXGXTtv9fFtDGHzaHTgi8nlKOX+OBHqARmO9Xf255B8Ds1/lXXIqbvZZDV/9Z4eUjuveEYVzZq82KsJHt0YkJkkDyQSvL+D6B4iMTEIetygsmUW163dvM10JQNQg4qgUF6GLiXTXfmkZAdkLw1RfoeIoCLdgL35b7wSSqzDP6BoU6EfQ2VTnI3/dcfLTKNwm4pqmW04Bu4ktrUyASgoW5KErOXijpME5y5Q8TZFhTTrjywCLa8B9CTDWOMvjOKQxMxV4Gav0mcojs+zDyUmdD34GuyiG7SlZWYDjrNHNZYk3vlbCSSr4C5sezV5bAykh6wMySrVGMX8E941/1WtEACjhoK1j/rG9uybGqh2GYB9DMkphgn6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(76116006)(66946007)(5660300002)(7696005)(478600001)(26005)(316002)(71200400001)(52536014)(4744005)(186003)(6506007)(7116003)(9686003)(86362001)(8676002)(66446008)(66476007)(4326008)(64756008)(110136005)(2906002)(33656002)(8936002)(55016002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZmhGSC81Um5uZ3YxMm1ZMHZ5aWFoa1Vyd2RTS3pFdlpjK1g4Y09PNm5RSFZC?=
 =?utf-8?B?c1BjOWgvMWZGWjVJQzlUUVAyaHcxZW4vT1Q2S0w4ZEkwUmRGTFNINFVHZDBu?=
 =?utf-8?B?Mmx2M0M3Q1BjWERva1kyTWtoVngzK0RwV2JCVjhYWEFadDdTZm5nR0xOY0Mx?=
 =?utf-8?B?RTdMdUU5ZXFKWGZySDVUcnpEdHVhdUV1YmE4UmFJM043RmJpTnNMSDFTNnRh?=
 =?utf-8?B?akY1WHBsOC91VWNLM3NXRnhCUWJXUkJYTzhkeldlZElkZHAwdWNyUkJ6N3FG?=
 =?utf-8?B?Mk5icXN2cjVmUVRxM1ZRNHNqS0JjR3hhQ243MjQzbktYNEdjNDFCVGV4eHpM?=
 =?utf-8?B?NjQ1d0RhbnNzWlRkditPdzhMRklrNEthZEdjU0Y0Q25LTTczaUc3QkhoenI2?=
 =?utf-8?B?M0dnL1JqYmpNMWdiVml2Um1NWjdvek82alVVUThZTENDY001S1FMZDcvR3o3?=
 =?utf-8?B?T2JtZllQcWQ0WG5rSG1vT0loTjI3K3h4MmJvU0FNR0J3bUJSV09nNnR4cVND?=
 =?utf-8?B?ZmR4ZDlHNkxpd2RpQmRxekFPdTV5TmRDUXZZdmpWem9EYzhtQ0lDNFVqWEx2?=
 =?utf-8?B?S1B5RGwwb3BGUFdZaEZXdVh2SktIVzJidTMvSGV1Mi9WVTNrRE1NT29CNTcv?=
 =?utf-8?B?eFRVWFZndTBBODdPakJHT1pJTEx4aElvWTdKbDdoQ052dkU5VkR0ck5jQXdJ?=
 =?utf-8?B?S2FKTURJNjl3NXNvbGJlb2U4U0hNOVhwR2lQN1c4OTVWaHBtc1Rzay9qYUY1?=
 =?utf-8?B?T21udGFZNk81ZVFkRGpBRDhCQ0ZqaVNSMGdkSkhkU2ZlNFYvcXlqRzFCSUNo?=
 =?utf-8?B?OHp3aDI3MHMwY2VOUm85WW9rUjZEaWE1RjVKa21DOUxvMHZtbmE1aG5nNGxZ?=
 =?utf-8?B?RTVSSS94cVJ4dmxseDFyMHpvVlJpLzlnRTcrTWtBUDlEMkdYWVZGUXZxRUpH?=
 =?utf-8?B?NXVvWlpEYmtzMkJrWkxPMktxTEhaK0pvZGJnaG9ycXd0NmliWnBZRHZHZEZ5?=
 =?utf-8?B?TGFad0Rnd0NaZ3FRMFE0S1hUZHhxelhFSk93TWtoYWhpM3p3VUpNNUo1UXJQ?=
 =?utf-8?B?VHpkVFZwTGhobFdSaytudmlXKzRaNkFkS3d4Qy9DT3ZjRXVjTVZxazQ4QUFu?=
 =?utf-8?B?OU52S2g2ekxxbkdsSWpWeFBnaERiMVl3d2YyUjk0RUVOMHdrVzRjN1VveGV2?=
 =?utf-8?B?dHZNRzA3SDBBOUVhakR2K25aazJENFI3aDdjelBGbHpDZGc4dUlKOU00cUs4?=
 =?utf-8?B?WnNpUkh1WWR6V3JUekZMMXBGRGllZ0o0ck1nNjVQM2pycnhnOTI4dXMyZ0J6?=
 =?utf-8?B?bmVtalpmYUFLcWxtR2czV2RvcjV3TVNUckpmd2tRVkozUW5LZmJrSi9hVWRG?=
 =?utf-8?B?UWIxOUV6b1BDdytpWE9lQXBoaDlxMU5od2ZjOHpBa3EvT3lhQTdHU3FWSWlL?=
 =?utf-8?B?Yy8yNFVVakM3dDJZcFgwaHY4SzFvZGd2S0RDMFp6ell0bTFkQkYrdHpacTB6?=
 =?utf-8?B?K3FlMHJ4U3ErdUdSQ0MxUGllQkNRRzY4TnliTW8ray83elhFeXZqUnMyZHJX?=
 =?utf-8?B?WlR6c3VUTmNqa1BPczRzSytsRE9wakFqSmhnNDlqN1B6dWN0bERsVWtuanZ5?=
 =?utf-8?B?VXJPK09zTnJoVXZlbDIwdW94Q3M5MVRRWFI2QVR5d3Ird0hSUG9sbVByNXZ4?=
 =?utf-8?B?Z0dyUWxkNUJybW5Sb3dIcWpiN1dZa09QZS9YOE1WWGJOS0x1bEpjTmZIaHoy?=
 =?utf-8?Q?JAgOhdFTrjlt+ij4Fl8h7iw7uD5LOqlL8l/r86v?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98fe018-ff3b-4836-1234-08d8d76117fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 18:38:48.6172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ey3fa83bXVyPlinzEXkqWFZkk9xVL23AAAb/6+4Ziiw6vMkO0RadlWny+5Is3aQ+tMi6LavvdS5RKo78Ys6wiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2253
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBSdW5uaW5nIHRoaXMgd2l0aCAzMiBpdGVyYXRpb25zLCB0aGUgY2xpZW50IGRvZXMgc29tZXRo
aW5nIGxpa2U6DQo+IC0gYXJtIGNxDQo+IC0gcG9zdCBzZW5kIHggMzINCj4gLSB3YWl0IGZvciBj
cSBldmVudA0KPiAtIGFybSBjcQ0KPiAtIHBvbGwgY3EgKG9uY2UsIHdpdGggYmF0Y2ggc2l6ZSBv
ZiAxNikNCg0KVGhpcyBpcyBhIHJhY2UuICBUaGUgY29kZSBzaG91bGQgY29udGludWUgdG8gcmVh
ZCBjb21wbGV0aW9ucyB1bnRpbCB0aGUgQ1EgaXMgZHJhaW5lZC4NCg0KQXQgdGhpcyBwb2ludCwg
YWxsIGNvbXBsZXRpb25zIG1heSBoYXZlIGJlZW4gd3JpdHRlbiB0byB0aGUgQ1EsIGFuZCBubyBu
ZXcgZXZlbnRzIHdpbGwgYmUgZ2VuZXJhdGVkLg0KDQo+IC0gbm8gbW9yZSBwb3N0IHNlbmQgKHJl
YWNoZWQgdG90X2l0ZXJzKQ0KPiAtIHdhaXQgZm9yIGNxIGV2ZW50IChidXQgYW4gZXZlbnQgaGFz
IGFscmVhZHkgYmVlbiBnZW5lcmF0ZWQ/KQ0KPiANCj4gQW5kIGdldHMgc3R1Y2s/DQoNCi0gU2Vh
bg0K
