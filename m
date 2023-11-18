Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F637F0036
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Nov 2023 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjKRO7q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Nov 2023 09:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKRO7p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Nov 2023 09:59:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CEA2
        for <linux-rdma@vger.kernel.org>; Sat, 18 Nov 2023 06:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700319582; x=1731855582;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cyKrxfWIi/DnoecwIUfGvr9wbO5Z9PxANGspIfW/GpY=;
  b=V2Br8AwDzc0nWer/VJkaBTHYSv/t3sw0Hb9i9Fl/pdmeEMlzn1uYZ/vN
   iq+b5m13uMtVac0bPlK5PCKX4B2QjbLOi8r4WOimCMFeDysrVvgEUgHlg
   TE/Gy3gx7YFgn/MxuPkw5Mx5N/f2NlnUkUsnv6KL2eAN9Uz9GbsKwt8ep
   CKJ516EbrR4dYKH6MODmUlzchJ57hyX/7sn8AY8YkdaGsqKBYjx5CK42P
   wBtwsyGtrM8GpGPlW0WiYuwkXkYhAGumyQV/KhngZ1SDXLsNs0pDVGyn2
   +fGDNwJixA3LuHY2/ubU6W0r9Sqk0PsL6HzyezvkuR+CJAY7VSwYU9D6p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="371607969"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="371607969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 06:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="7125425"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2023 06:59:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 18 Nov 2023 06:59:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 18 Nov 2023 06:59:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 18 Nov 2023 06:59:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 18 Nov 2023 06:59:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlAczSirk6ZrvtNdFhW+aaBygX9HsWBGilnthNBNH7X6fUGQwkaIlrL3vFmZ+FXVw82sz4RwFTxoxHf/ffzEyAbWT4TO/zthgicAwV6Eo9gf7OgvIppPbzYg5MqAZDf18r59932hRpODHmHXiYwi8qXIayvpc7mZe0wJYMTek0iWIluEc3L/r3t9gtu9Yb8xPCcdmC1VcK/w6n9qJ04U91NP5XbYoPVZ4A590TpNMnWRA8FxG3ILXZdRrd5xpNwBRRQmoPEsL2blNbHJ77y8ND/9X3bPfAAS/nOuKBYY9LE+cl4gCR5QzpIhxOgRKs222agN2Alf9TXzu2SqrOjlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyKrxfWIi/DnoecwIUfGvr9wbO5Z9PxANGspIfW/GpY=;
 b=eD4enzyKSdAKWjCz+t1xUasQ3OZfiTgi/TYANtAuvMT7G4IOHRLCcU8t8skcTUupK3cXxmpZ6aWtY+F9E35lQve7wa8lzX1fkCQVm2sOZj7NtU95byxGWQSyAlYrWJ/38eI6fBaO7FSLwWse52hCU//QC0bCpw8/nqIRUPzE41Xip/BgRMWIBcmILjdP8lmZLZSDDrCZPoOdj2pYALqHeBXV4oQu0WswxTD1+iSwY5bQQr6OXjx0LxCJAGdM6rzZocgZjKIwT4Z2Dxd/N4NXutcUXn360tiApyDeoWd8YcvwNxy1GOPiIejjXwa1ZyPxGt53+skh/5sUNjlgasQo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 14:59:39 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::8a71:5126:4858:e1cb]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::8a71:5126:4858:e1cb%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 14:59:39 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE is
 greater then HCA pgsz
Thread-Topic: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE
 is greater then HCA pgsz
Thread-Index: AQHaF/h9mIGliMQYi0WcvhC4HtkgjLB+bxYAgAG4MxCAAAhFQA==
Date:   Sat, 18 Nov 2023 14:59:39 +0000
Message-ID: <SA1PR11MB6895EEF12064285FADA8142686B6A@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
 <20231115191752.266-2-shiraz.saleem@intel.com>
 <093f16a6-2948-4103-8d27-ea349aa6909c@linux.dev>
 <SA1PR11MB6895E230B7CFE2D293DAFAA886B6A@SA1PR11MB6895.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6895E230B7CFE2D293DAFAA886B6A@SA1PR11MB6895.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|SJ2PR11MB7426:EE_
x-ms-office365-filtering-correlation-id: bbed1d2b-1c6f-410a-511a-08dbe846fd05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9hunqol3a82NP6WJt9V8q4c2pxDX95E7z/EyujcMFXdrFp2e6aF0MV9Z8zOc10ju1p30vg/cIJrussQZ7nz07rJ+ntas6yA1wOiQaG4jDrvcuS0h7C2iUmtscyQvHOwo7KxxXmzZ/IaW1/2ngU/YIChjV90ewuXFmxiOhDYMRr4kkrZd/GSQ+PiYEQ4Aktr34aPwzy08qyfY1Asp+z3dYrGHrT+IbJz8nr8vWrz5fm8CuyhiXg+a8jyH+XoaAu1ay0H0DzC9aM3tk4lF/9Rf9IdFsm34KI/Oxj9RFu4Qgcc0AJg7MtjxAzEM+AAm3JYfZ6QxUCRGd2ZwqpYMrZnj2+9C7QyL6MGmWlIAir6FMwslt7uHgK2WKGSxo6hNJtjSswtdgj/z1WaivHv0P9HlLEdOPWaIrgVnWsCspg58jsp7nM++Rgeyg4wDYWcvWRfPzuFXUoQImAu5plOSXHXc6dIuPTZcWenbYb6hnNMEDmRKtjJ+Zhrtj10zyfQCRoDN0PdISytL/ngB6BCrvdMwtEVdrrbRKmkoZN7pbHto4DJJrkexqK9xn47zwNCICQi4/Gk3OsFSQQYk+/jPx7OFlJ6a8gcKJfAFKMZVVHRdAWIFaZ7gFnIQonCmkyapDls
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(122000001)(82960400001)(38100700002)(38070700009)(86362001)(558084003)(33656002)(2940100002)(9686003)(6506007)(26005)(7696005)(478600001)(71200400001)(41300700001)(8676002)(8936002)(52536014)(76116006)(66556008)(66946007)(110136005)(316002)(64756008)(66476007)(66446008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTIxNU0yczBVTkpTNXdMUFdOUURyMUlNS21nNVVya2RndlN2UE5YcUVBOW5r?=
 =?utf-8?B?WnZkam5vN1gvMnE1anFFRXgyVUVIRGNtdTd5akYyM1lHd1B4cUZwTVRsaWtR?=
 =?utf-8?B?TVZraW5teXZZZUxqS2xpa2xXWERsSjJ0ckloMmtONmFQeE9UQmVkVGkyTEJy?=
 =?utf-8?B?NVdHeUMyT3NQRGdnS0U4aUhXVWQzQlVGRENYQVZiYmV1OEZsTHNMSGozL0My?=
 =?utf-8?B?OVd4K3oyTWsvMHIvK0JvbWFETmd6amhEa3VmVXMzVG01WkFOaFVFejR2TDg2?=
 =?utf-8?B?TFlBd1ZIWkYyZDMwK1o2amtCVE5qR1c3K0owaGVKSGFQTHArOGJXYVZTV2ZO?=
 =?utf-8?B?S2FDRmVENUs3cjhkMnZKaHFNekl1b2d5bVFUU3lZMi9RcUZPNytjMmEzMU1D?=
 =?utf-8?B?YnoxejhTQzJjV0tDY3FQRk05RmU0dk1EQ01jUTRxd3ZXd3ZESE5BVlBSYmZF?=
 =?utf-8?B?TFRKUy9hMldaTTM0R2tWOXFnN2hiNUJWSEljTDFJSHB1MTlST0hORGQ2NnBr?=
 =?utf-8?B?R2hxdlNWYlEwTUkraDBIV0tDRW9hTE5SL2FCaVI3NUVIVThsYm4vcWU4YTZv?=
 =?utf-8?B?ekJvNWc1a1BKckhxQmg1MUtqZkIyb0dHczVKWmpOWkZ2N2tSYmVaaDJqZXky?=
 =?utf-8?B?SDJhejZmMGpLWVQxb1k2SE8ycDV6c2lVRTdHMEVlU25UbW5ObitmNUZKT2Zl?=
 =?utf-8?B?eGkxRTlkNzdVMnJPcnlLN3N5RC93RDlFY2JJUGdCaGRmbkM1OHhpeWJNTGdX?=
 =?utf-8?B?NkdCRjBCQWxkZ1hXQU1NcEJhcmVmSytzQW53TWlqdnhONDFFSFlHbTl2Nnli?=
 =?utf-8?B?THArMDFsSGR5TnF4Qnc3eEZZUW82OVR3N1NhaVFrbFVYUlJ2TDdQaHdMK2lT?=
 =?utf-8?B?NnBlVDd0RE5hT2J3ZVNhMWhqTHRuNVNIYlpUdzJJTFhpZWtGVUw0dUluNmFW?=
 =?utf-8?B?bUVoek12TU1NcFJ4S0RuMTB4dHJpejBEanlkVmV1dGI2bGlBZzhiQ1c0azVQ?=
 =?utf-8?B?M0lJS29ibURNQlBWSG90aGhHMDBvd3lMTkVJM1dzUkx1Z0JHV2R4NzRTdzVF?=
 =?utf-8?B?NVA2a1NnYVk5YWZIM3VtUHBnZHpaN3NYaFBlYnhxM3VPdHJ2cU9JL1VzRzJs?=
 =?utf-8?B?NU5FVmNCdFRTRGhuU3FYcUtXdFpqQ2praStLYWZHY2E5dmJveThjUEpSN0RB?=
 =?utf-8?B?b0dNWXB4WVJNSzFSYS9UaXFWaEtzdWh6dXN5MWVtVDZDc1EwRWZDdVFvNSsz?=
 =?utf-8?B?LzZYSyt4YmprakVtbllDV2xWNkdOT080aG1CalJZaUhPMFVYbVJzeWQrZnhq?=
 =?utf-8?B?Y1k4cFpRMFlTdS8yZ1p1MWdNQVRwZlZ5Uzl4NHZFQnArZmRuMGdZRkZpZWR1?=
 =?utf-8?B?WC9QKzdBTVRYY2srZVpURENhRnpMdmJTYlo0R1hBb1EwbkhoZjlLbTlIWHZB?=
 =?utf-8?B?WnR6a0NwelBZSW1OT3dUK2xMMlBVU3hrOVhTTzFHREpVbURsVE5COVVudCts?=
 =?utf-8?B?N2ZOWmdSdW11dDRlZVR5VG96OHVDQzBPRFlib2tldWVNeXR6UVdJRk1MeStm?=
 =?utf-8?B?TVNYdGlJaDlUYStNZzE1KzBBRlVtWVB3azU0aGZvWUpjREREbDU3NHlqaGFQ?=
 =?utf-8?B?THR1Wi9ZNmpHOThYUWhkbnRhODAxN1pnUlpDMmo3TDZuejFvaDJlRDR6UjNk?=
 =?utf-8?B?U2twcm1BMkhVaDcrWDBkN2FkY2N4Q3VoUWhYTmRFRVpLdHhCMEp2dm9EL3lX?=
 =?utf-8?B?SVZ0RHFVTEdIY2pOTzFiMEd5ZjJJSm1VbjZKVi9yVG5JUVBZdHpLaHZGVVMx?=
 =?utf-8?B?WFArWEszWGl4azhNbnM3cEhzZTMrZE51SEFCK2R1SmVUQU9raXcvM1NOVmZJ?=
 =?utf-8?B?ZXozQlFFV2Z3Y2dMSzZJY0FJN2kwdVlXZmxtaGs3TmlaV2txbTNmY2gwOEVV?=
 =?utf-8?B?WU9mV2F2eXYvOUw1a0dlYW10YmlUM2JYVlVibW9GV0RYL0diaXJzL0JhK256?=
 =?utf-8?B?Vm00ZlBxRk5rUWM3WEJJcTQyeE9xSm1KZk5LODdSTDRhYzNtTXNORHlkays4?=
 =?utf-8?B?Z0JVK3dZdzhGbjc3TklXTHZYQ1paTXE1cjJublhyRWJhak9uN1BBUE4zNUgv?=
 =?utf-8?Q?lofr7B6KC7s+GASwclmTkG+vH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbed1d2b-1c6f-410a-511a-08dbe846fd05
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 14:59:39.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J86O+fAZfyPfAJ4QjQGY0AxYvNmlggGKsodY7SbPaIqVJQLCppHgDLt2D5nhpijpS3m9Ostu1WSMDfW5KMFOecko912nxuxJ1LKluz4mRkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gVGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIGNhbiBzZWxlY3QgZnJvbQ0KPiANCg0KLi4u
IG11bHRpcGxlIHBhZ2Ugc2l6ZXMuDQoNCk1pa2UNCg==
