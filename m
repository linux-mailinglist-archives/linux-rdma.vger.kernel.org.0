Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908797F0034
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Nov 2023 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjKROye (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Nov 2023 09:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjKROyd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Nov 2023 09:54:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D7194
        for <linux-rdma@vger.kernel.org>; Sat, 18 Nov 2023 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700319269; x=1731855269;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Yli/KrGRhBmGVkYecUMYB2LJoTwvo+e1/Pg9wDik8z8=;
  b=Ylof4bHWNWf6+Xrv13n9VUJjGFeDe4Vp6ro5VJFQv/TeesIUmF+l8Rh+
   Ctpq+9Cpng9oFYItRlvMvNMBwe967CFli5UH8NxDSmtm2isteF+6W7JJ0
   //vxsEKxMaLp2+P0Uopzg/Ey9P/oXMlKKUK7Mjdam8Kzt6ZYjp4uqiMVO
   uPX7k0PqWgOcazv7kZD5BBgegszghStoFqQhHWTAfJ3xtgE5rMw73HrZY
   32ad85IRqzIu0EmH31TU31ZN5rXkHyGa2qbuDJ9p28+E0a9r3ThPAkOym
   bON49pCqxq96QN6FHyXBzey5v/l7dNMc2eiSZQJqziSdjjNnqais59uQi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="390294305"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="390294305"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 06:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="909681651"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="909681651"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2023 06:54:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 18 Nov 2023 06:54:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 18 Nov 2023 06:54:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 18 Nov 2023 06:54:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 18 Nov 2023 06:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+u4yD9/M9GxbIFHGm68b1TufdjsTT2nU36/ZHxGkPMHAUvejFLcN/G812cDyquzAqnlS7qdQQ28livsh4pVaA7uj2DD6uv7Gfi6BMyZVDbm0gCh1mmpYZBKYgt2aTOHY5aA97kEuzW97FeZqzboavbV27zhNMMmWghFv2xrvZZOaaGCoR1qlE48MA8JO+sDT2WVUvxads4mUio7KTRnytRSIzToAc3hE8MoHjJEdwNSbJM+jCe6vt2WWiF0bnJ2nHYw/nbtc5OhhRV1vnDIwSuZ3RAQN2TwVLj3nIAljTVao0W7korJf/hXArAMldM0Uikm5Z65InTPO8gRXZnpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yli/KrGRhBmGVkYecUMYB2LJoTwvo+e1/Pg9wDik8z8=;
 b=fEGJ/Wgahkuz0b16b6c658FRlrmF84xUcudPBDeWs+BuS6DqJVl5luAnu9n5x0pHB8Cvx+Sxm/+QC7pR5sR39y5EzGYEY+qAj7ZvENPRhGFvtKWUrUZVG1roySeo6/2YDzQAD6CNb4dKrzOFohwjULsJjyZr+HYaCwgNtNkZ4vuLN71VkJW2BCSripE5H3Pi5d4bhYJ37HWHy+dryUhvBKSXaeOIGvU0LdV3VzHPu1aywPoztbLKmKOtr/oy9E9+p5l4/kgG2e9+OZEBsinqkfUeEN8liMyBuCX2Q4RyS0nKVq5wF3KKy1QgRoIGKxd5JBisa/JRoHlaMCglz9u7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 14:54:26 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::8a71:5126:4858:e1cb]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::8a71:5126:4858:e1cb%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 14:54:25 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE is
 greater then HCA pgsz
Thread-Topic: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE
 is greater then HCA pgsz
Thread-Index: AQHaF/h9mIGliMQYi0WcvhC4HtkgjLB+bxYAgAG4MxA=
Date:   Sat, 18 Nov 2023 14:54:25 +0000
Message-ID: <SA1PR11MB6895E230B7CFE2D293DAFAA886B6A@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
 <20231115191752.266-2-shiraz.saleem@intel.com>
 <093f16a6-2948-4103-8d27-ea349aa6909c@linux.dev>
In-Reply-To: <093f16a6-2948-4103-8d27-ea349aa6909c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|CY5PR11MB6391:EE_
x-ms-office365-filtering-correlation-id: 6b4d6d1f-4d4c-4e90-9bdf-08dbe84641cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqld3OGlb8kGS40fl+ArEzCnmLHASExHULzyZHoEB+2iTDhm99/kWW3k98bxM+0vyTTrZ66SZm7HVPdz81orCb/vjICHwDUiezvOOdhi6kBAp2D95F+yQzCnTKwttVdmGoZteTz3ymtSrrrMpS1efE6VS5DE1i40yLVQzcKHQNYVt4UuK9EugyiBtgeMr/5bjxwfYmc59PLiLr78DGn5TFi3A2J5y0KqyZBp7ARe4T89GqyKLHL/ldDGG1WONagyyhXhwh5jtYJLM9U8OCE3nTVMBExyEGE4+fe6hhHOdam/FtVisnTHskG4MiEwJIHYuCvEPKf1cdGKQNiS7BQdUAnV4z73wLfrPPyLGrsT51+SGNO5eje2eFKFok6p9o2DHJvNypW5mhEC/U9gsNY9VkwJCgfITofk7+aMmRsnkg0fj0YEhhNSshqVNtM37dpjatpBDogZj8bPUgRyDrvw89Y4gUReYeK5dyLis0EyVQ5Fm9eUZDoPLZoSJGgGDrZtkAsSwxTYgthK8W/sLa7c/AOxGpN36gF+2Vya6rUPMQ1T2w8FRQiy3pDfnjs3RCwxAijNRZkeOjpEsus1CXrvxQFvKDfS1CFKWp+zZLytNsYOyLSNLrYdJzV22imMDu7J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39850400004)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(110136005)(76116006)(122000001)(64756008)(316002)(66446008)(66556008)(66476007)(66946007)(82960400001)(478600001)(38070700009)(26005)(33656002)(9686003)(71200400001)(7696005)(6506007)(38100700002)(86362001)(55016003)(2906002)(4744005)(5660300002)(8936002)(41300700001)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFFFZ0NNQzJ1TmQ4ZWsvc1ZQUG5OUnluUVVVZ3BjMjdWNGNJSWQ2SFdYbXc0?=
 =?utf-8?B?em5VemU4Mm9JMEJ4M3VwY3dkYXNRTTZiS1BmUE9FcUJxd0JINjBEV0c4OUVC?=
 =?utf-8?B?T2hwcHRYeXhzczhrRmhSbTA5bkdiMkIrdjcxYXJIdWhjdmhSeEdYUGdHMzNx?=
 =?utf-8?B?dytmRkZReFQ3czlCeTNUZUczM24zSDBQMmxFZXorNVJrMnJEQ1Rldm1Edk1w?=
 =?utf-8?B?emNuVjBjYlZSeU84d2ttWkgwQ3BLZWIrTC9yZW9WaGNKOGNYZFBjcWY5UTRw?=
 =?utf-8?B?VW45MlpreFpieGRGZmJOQ2RSVUdvVEg5bzE0LzhQWklDVWQxRWx5dFZxcXda?=
 =?utf-8?B?RFIzcCtOM1BndDFLMjdXNU9JNU5BZkVMaTBCZVI2bXN2c1lKOUJZN2NlcTJB?=
 =?utf-8?B?ZnhnK3cxOUYyRFJLbG1oOUsrcnI3cUJTRGNjSHVLRFIrZC8vTmhNeHNLTzdh?=
 =?utf-8?B?czR0UFlsQlZXMUxwWXhtNUNxQndiRCtiTjEzV25ZSGpzTExNQUVaUzRpZ1Np?=
 =?utf-8?B?WnQrd1JlV1NDMWoxZTVUVGxobWR0OE5UdS9DWjNSQ0srZVNJSFFqbkhVWEEx?=
 =?utf-8?B?Tjl6Ukg1RU9TU3EyVTlsWU4zcXZ5TzlCTS9jVko4cFNKUDFWZ1dzZEhJMit5?=
 =?utf-8?B?RFZ1STQzYWNYYjNCOE1Qb3lDczVhWnBjZVpXMW9FdGtMUlhrbjF1bWhZWi9r?=
 =?utf-8?B?ZnlCRm04cDNYR2NmaWJQcGpuN2hSdWlxZ3kyUXQ0VkF0SDcyYWxTTFN2VVNk?=
 =?utf-8?B?WE5VbVpiVStYWkJ6R2VoblYrT2h3RzFOSy9IeFVCbjBBeEJIOUZBeDRTU2dB?=
 =?utf-8?B?Z1dtaVJFdmdrN3E4bU9zMmpMVnIzeWh6dHU0QWwzNzdrTVRJRWRkS25DdTNB?=
 =?utf-8?B?U3VRbnpBQkFPTUhyenlibGJtdEtpa1ZKajBJeTFlWEM0SjByd3RJakFTRGpa?=
 =?utf-8?B?RjR2cWNWVUIzQXg5UEQ4N0tTcmFtV0FFUGZ5MnhOMTl5bEM4NStGeXJ6Z1ZR?=
 =?utf-8?B?aGZnQ2t2ekxzSXpXU2FPQVRDSnF5TDQzTTU0WHl1dzRlYzNjRmh2Ukh4Wk1u?=
 =?utf-8?B?Zk4yY0ptdFZLV2RoUHRWSy9rTXdtVEZGVzZ6VFNkRnNkWklTRVZONlV1dW1L?=
 =?utf-8?B?TEZlVVVPdXMyNHcvR1hENkhhZUhRNHNUMWx5MkR5cm1mRDJKVSt5OXBmdURL?=
 =?utf-8?B?UHBDYTA2Z0Ivb1I5MDVhMy9RMVVBVTBaZHZSWlhvd3cyR3lyOHNqNng4Rk9B?=
 =?utf-8?B?Q0UxLzlIQzJlWWJTV3V6Q0h5TkFpdHIzbG45QkNDeVRtVkgwMFRoOWIyaGRD?=
 =?utf-8?B?S3FOcU9OZXhTeGVHRGhDcTJsVlhtV0J3elZzZGpoZm14OHpDWU1BeDVKV2hq?=
 =?utf-8?B?VkpqL3EveVNWeWRuMU9vZ0s2SFhNb3FlTmZCczJwbnI3Tlo1b1gvTUE5KzB0?=
 =?utf-8?B?cE8zdEF6Z0JCbTM0SVFkSmQzVUlGamRlVWptcmZDc29mRXYxLysxbHFwUU91?=
 =?utf-8?B?cURLL1VkSkxnUXpJdUpFQmNqZ1lIVmZaazVvWFY2N2NLNnVOYmYwaDgyNVg1?=
 =?utf-8?B?QWZ4aitKNzQ0M3dVMjM2U0tyMTV4SkZGTUZ6NXg0ZnAyME85SlpyRVZnMFd5?=
 =?utf-8?B?K002Rm5pRStoUnM3MjJlU0J2NjRMQmEraXFWMnFkYUZRRjhWWUdsNE1PSkl1?=
 =?utf-8?B?VndSK0JNMm5FV21nckJTSGRTdXEvUUZpL0NCL3F1UmVhS1V4S1FWU3ZDeTNk?=
 =?utf-8?B?bkVTUFNiY1NObEtua2ZRQU15ZG02QXRZNTJLK1lIOW10MmViSGU2ZDlCRGE4?=
 =?utf-8?B?dnUrQmNVaXFDUWJIb3FVekFZZGhSM3A4d2xWU0kva003WmJhZXhkTGdaRU1p?=
 =?utf-8?B?THN3TG1BUytYNkNEdjUzWUZ2eGRHQk1aVEREbVRrRTJXUFA0NWErdnFTeU1O?=
 =?utf-8?B?R3lOKzI4YzRTRWN0UWF3OFVqaGNXanJWVzVqQlVMQWs2ekhyVHEvUitTeVFG?=
 =?utf-8?B?SW9scWZzZ3loa2VUbkZvZGQ0Tm1sU2plK1paQjBkOCtBbDhiNzJ0TDVjT2FQ?=
 =?utf-8?B?Y3dhbWpFRGNOZHdacFlhejIzZHhPRlY0cW1CemNMNzRZaUpBTXo4VUFsSFd2?=
 =?utf-8?Q?up8M7F3+fBOVMeyG5dhAqf2Zx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4d6d1f-4d4c-4e90-9bdf-08dbe84641cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 14:54:25.1773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Enah9bN8/og0529CNOkvraLtoYZYEyFACuBDzcdNpk5Pu0WEgmsKhDBj0c4YLtqJvoGYhI1PKlxiuR5QR0iyPivsxIbHxcHn3UbAOv8BZVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6391
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+IEZyb206IE1pa2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AaW50ZWwuY29tPg0K
PiA+DQo+ID4gNjRrIHBhZ2VzIGludHJvZHVjZSB0aGUgc2l0dWF0aW9uIGluIHRoaXMgZGlhZ3Jh
bSB3aGVuIHRoZSBIQ0ENCj4gDQo+IE9ubHkgQVJNNjQgYXJjaGl0ZWN0dXJlIHN1cHBvcnRzIDY0
SyBwYWdlIHNpemU/DQoNCkFybSBzdXBwb3J0cyBtdWx0aXBsZSBwYWdlX3NpemVzLiAgIFRoZSBw
cm9ibGVtYXRpYyBjb21iaW5hdGlvbiBpcyB3aGVuDQp0aGUgSENBIG5lZWRzIGEgU01BTExFUiBw
YWdlIHNpemUgdGhhbiB0aGUgUEFHRV9TSVpFLg0KDQpUaGUga2VybmVsIGNvbmZpZ3VyYXRpb24g
Y2FuIHNlbGVjdCBmcm9tIA0KDQo+IElzIGl0IHBvc3NpYmxlIHRoYXQgeDg2XzY0IGFsc28gc3Vw
cG9ydHMgNjRLIHBhZ2Ugc2l6ZT8NCj4gDQoNCng4Nl82NCBzdXBwb3J0cyBsYXJnZXIgcGFnZV9z
aXplcyBmb3IgVExCIG9wdGltaXphdGlvbiwgYnV0IHRoZSBkZWZhdWx0IG1pbmltdW0gaXMgYWx3
YXlzIDRLLg0KDQpNaWtlDQo=
