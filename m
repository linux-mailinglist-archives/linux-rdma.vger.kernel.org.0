Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716C07390E6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 22:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFUUjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 16:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFUUjF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 16:39:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372219A2;
        Wed, 21 Jun 2023 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687379944; x=1718915944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+STLdUDi/2k2yfVjuV1CdDCgzql4KieukM+ka+WZaSY=;
  b=IJyCtqZXumw/okXaUSiPB1Ct2KX89pPaW5e/D7vMai229Uoxp/l35smj
   lc0OQYerhZTCEjuqKK77u/JDcGFYFCLLZlofHoqdazKOIMlujsYdWmcuL
   8a3rmUa/BK2kV8BnOQI5cCBeikqf3Ox187b21SYECjihE8DZtRvMWXGdV
   bNTZd9rfpxGB3IemRPmly718RPgVerfJdb3CppmjWjkhQmTNX9B5T1Vc4
   zK/jPqSYPBMjo3FP+x0Q5i/Fa10vi2vjttxyzPT6IwWTsB4SlbZ2Cs2Bl
   ofSKx7H7pbLLEx9NGInovllxo1qskYkpemdp6ZeqlZ4AZ8azQR2MTzH95
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="345027039"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="345027039"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 13:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664795046"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="664795046"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 13:39:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 13:39:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 13:39:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 13:39:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 13:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOmN7qSYSqAWI5NhnpB8ZAPO3mwaG4gl2pFEDUF2KFfakeSdgT+3VYWdhJB8vHpoKiBgMOFdL2VtbF5WAPuppsDWdr36mcWoJoTNrGlUJFIVuwPXhiIA7eZQ8AcXjGvj+NNDvAPkdoDy40UlkwMSJiPEcKsf+x0aIp2MeeKmcKkSPrBg4tZ6OmFHi2RSQcVZVbqYYZcCTkhp5uO43xGLT81vwA1Mr/fMa+78pX2KcyNa81AkMSITS41zP14VEln20ZfLCpZ6tFNIV8qjB6FUmzaBpsaH/REIg5i02q4J52c4CLM3oL5ywKSSPCo2x0kAE78PlvaPUTXAkNSoD8+R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+STLdUDi/2k2yfVjuV1CdDCgzql4KieukM+ka+WZaSY=;
 b=YWcrdnGjLhKgE4PyWOsrKhN2rJGNdNX53ghQFjGI8nIHGw7D65lTDOV9AelnZkc/Jf6pe8XDdx06JIVtya3Tm5xPGV5T5kBwzsbtViSfImywceqFfvlCsq+nkeRH/hXQST8hxxJDZE9CnJmk9UtGvx790/4X9Md8VgZzH3I4TRNZkr7W4TdMvcLgl+n3+rv2MmzRlkGT60iVc5/3rxNrcQ7eBT5DEwVgENl+An9v06GuArDilSXRLKdeh3L6waQg+n5y0YHlz6MAttEx8F4Gl14pFBY6QUFT0hunuwi48ussxrnKX72SZdCzps3FDftkF/G4Ohu01G+BCAbIV3h98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 20:38:55 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 20:38:55 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Thread-Topic: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Thread-Index: AQHZmsz08ds9noNj60q1X/LUfA+qnK+FWuwAgAFtfwCADwJFUA==
Date:   Wed, 21 Jun 2023 20:38:54 +0000
Message-ID: <DM6PR11MB465704BE971D2E51DE78EFF29B5DA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
         <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
         <ZIWVuPMyKRPv6oyh@nanopsycho>
 <38dad5cb196741e56d018cea155982928694b2cc.camel@redhat.com>
In-Reply-To: <38dad5cb196741e56d018cea155982928694b2cc.camel@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB7192:EE_
x-ms-office365-filtering-correlation-id: 322338ab-ee92-44d3-61fa-08db729787fc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfY8AyCFtXJcj5ChmJrcRg8IM7hN5+dOPO0KD0tdNOnAgLl7d+VVU/YcQuKwSy4/MAb/a10ZG2EhMChKphP3msIVwSTv7plpcQwC7n++6agtN8d5M61QognFXbzQVa4x6RoGY/lPWHm3BlDzrO62SeK4T/Fvfs/BOL628iK446hkCC7nXNJ+KmoAwR5uuNZi1btI7YlRxyNsXFj3digwcIqXTp+tjp8PpleE/6767E5jFQQGQK8+JwfukWZtat9K+1ymrEXFvYkPW64xpS3SLuql7k4M0CqsJlwDs8BHi+L8mq7HmOsQjKq9eqPXQoYm9P9nmBkynfj8xrVW6nEiJcSCY4+iyoD75SreesjoorqadJOUgZ7A6pi19w0DuGU1t9WVqOIZpQypFMUQH/LuhCYMldbufXoYXwcLFIe9aCBrvTL4FSDA6Qfc/r35FxERx/Lm7yxco460BudFCdZaVIFTMEYotfx4UkbV79KKuz8jTg0ao/ylU+iQYCcrs+PY1RilMmYYjhKi0t9Gny0GlDj4TF9NRJUAuJ4n2B0+/llatsIUSgCvrjBQIAgKvk2g7zlFUzncmw/FJuchb7BHTBAU0XL8GCVIW8+ytFpbPZzUORUmPtObM6An6EieBFca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(7696005)(71200400001)(478600001)(83380400001)(122000001)(38100700002)(86362001)(186003)(38070700005)(55016003)(33656002)(82960400001)(6506007)(9686003)(26005)(8936002)(8676002)(41300700001)(7406005)(7416002)(52536014)(5660300002)(2906002)(110136005)(54906003)(316002)(66946007)(66476007)(66556008)(66446008)(64756008)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkk0QUg1bFJXREJxMjZ1V3R6ODNDaDFkcGgyb1N2VkgyVnRnMTFOYXpWZEYy?=
 =?utf-8?B?K2FnY3BrRUg4TWpSd0I2b2tnR216eE9WSE5Td09COWs3THZmVDZxc1hWTTlt?=
 =?utf-8?B?U2ROY2tDdnJyRzVQZi9QRjNzdXd6YVdiaVBXK1JJNkpVd0NQNUc2WjNvclFD?=
 =?utf-8?B?em16RHg5M1gyUnd4ZkgyN2swWk1Gd1huSlZaUHM0SzB3TGd5RngwK05NNzdP?=
 =?utf-8?B?MFkxTDJFakdJUmlvazh6NjZ2OW0zR2NqQnkzcGgrZ2NqWEhyV0VTNGxlTGhC?=
 =?utf-8?B?aTJuMTEyVkxPZ2pIazVpaGM0RGNiZXUwcXdqVGlzQ1hwKzlSUFc1bzEvWUpJ?=
 =?utf-8?B?U29xZTllUkVGSkJIL3lvZi95eTBLZ3Y3ckpBa2UzcVVtczJZcWd5Ym96dDZk?=
 =?utf-8?B?bWRRajB2K1RKelZ4VUM2ZDMzUk9lTnJmWDh2QjhHMndOY281cDZYWU1aUnMx?=
 =?utf-8?B?ZUEzbUJ4WUpCcDgrMy9BOXY3MUVUTUVUQ1VjZEpwT0ZmV05VWXBBN1ZoOVR5?=
 =?utf-8?B?U0dLc29Ndy9RZ3lGUlJJVEdQNlhpeS9uNW9XaDI0cjdScUZhUnZVUUljNVJW?=
 =?utf-8?B?SFA1WDN2TndtYjlkQ0Fwc0RNWkFDNmJ2dGxvTm1UM3FUSDJPWVB5bU9tYWx5?=
 =?utf-8?B?SE5SUGRUdkc0V3RzSmdwL1E2WjhvcVc2Mm9vMzY0OXdwRDZTMHZGYnN5L29I?=
 =?utf-8?B?elFrOHpmUm5MdnJ5YVRUbThkb1NTZVRPQUtteXhNK3lyTFk4WWJBdzFxdTAz?=
 =?utf-8?B?NEdEdUYwZWxuM0QxY0p5eUpxVDI3R2Evejgzd3B6SUNDRTFMeWJ4OWYyUm9S?=
 =?utf-8?B?Tm1GaFRlRXpqenc5OW9kNXhBWCtWRmEzUWlsbjUvRXUwbnd3aC9wZzNaR01S?=
 =?utf-8?B?MGdlaWxBYTc4U2dJRGtKb2VyZ3dJS01nenVaUDJkRU9WVUpFY1J6M0dNbU16?=
 =?utf-8?B?dWNXU3o4cEd6NDRlYm85Q2FWbk5hODlJQ3dQdGpFSXVId21haDVvM3hpYjIv?=
 =?utf-8?B?aEtEdkJTdTUwQXBBV3Btb09vQWxRTWFlN0czemZNSzR2YU8vcVNOSnBNTzEz?=
 =?utf-8?B?VlkxcEJDcXhQQlBOM2ZqMTA5TE9Xa0lYbjV0RDNpWnhvblVmbmFIOC9nbWpx?=
 =?utf-8?B?T254S00wN1d0RjRYRjE0Rm56VXVPTENxR2RYYWpZL0xuYmpkaWpqS0dCNEJM?=
 =?utf-8?B?TitFL0ZmWFpTUGZIQkNMRHJrTy9GempHV3N1UTlXSFJ2VmtaYnRxYWNNWE5h?=
 =?utf-8?B?NVlWQmVYTm9wYjZ6TlJRR0VOcFNIOEZzVTZuWkVCQkNEWHhacVZXdDlFeDhh?=
 =?utf-8?B?NVR1SzVVU25vN2lOa1pCK0MzYy9aREpZM0IvdmlHQllSUjJPeXVnbmhaTks1?=
 =?utf-8?B?V3pteWJJZlNEVDMxdjA0djErY2huNTA0dnFkc1dDcEtzU2M5TDdZUi9PRkg4?=
 =?utf-8?B?dWNUQW4xaW1xcndUdW14Nm9VdUFmNGF2cFlYQnF3N3c1RVRJWDFWZHpjeEp2?=
 =?utf-8?B?ZlJqOUR5K05SRVprZGpxdlhFQkExZm10ZzFJcjgxdUovc0NCOG4rT0RKMTdX?=
 =?utf-8?B?clQ5dFkyU1E2cEVRRnR1d1c0Tjdxbmg5aldobFVFckdjblhnejFET0FFTCtr?=
 =?utf-8?B?UHgrSVF4RnpBaTJoS1k3LzhMbUdRUFV3V09LM0xXemQ5cEZLQnFXODNGd0Q4?=
 =?utf-8?B?N0IwVGlONkUvemozbjJWVGhibFFZYjJIT3dsNWVjTWVIQi9oS3pQcURpMFI4?=
 =?utf-8?B?Sml5THAyL2FzZnhWMDYreXNEUEZpNTNRRlBYMGhPUjhBeHBaazIzQzZoa004?=
 =?utf-8?B?N3NWMWVnbU1mS0UyN0U0VUxYZ3owbEREcFNuY2l2dzBrQzI3dVFWK1R2OE53?=
 =?utf-8?B?YVFZUDk3ZTYrTVVIUWVDUXQrR2l0Z1NTZENKVGxQcXFHS1VZWmVxNHZKQ2l5?=
 =?utf-8?B?NHZvYTZnYjRpVktFWVI2aE5YTHFMN3RUc2RzSHNuWE1XWlZQZ2dpNDhucXFS?=
 =?utf-8?B?dU5iM2dEb21NeEJzVXZ5bE9qRjQyQ05mNWZ0VVNTZ1RJS1g4dlg2bHJSR0N3?=
 =?utf-8?B?Mmh6RWFjTkxubGVWT0pFNGduS2dmUUFka2xGVFJKRjd6d0s4VkY0T1ZYYlFi?=
 =?utf-8?B?RVArUzl6OFBJdW15eGkrOUNhUmhjY1A2cFJ2VTFSVEE0VU1HTnA1bGhWL0Jp?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322338ab-ee92-44d3-61fa-08db729787fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 20:38:54.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFImGmEWLI06IQ429jHwdDf3w17LNLXZByLx2XXELsAk3lP+nGHw3BES+yl0DQP8SwsyQx7F63bHkn/awmGn7EhPkGlubF/fC/vo1gDEZ1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PkZyb206IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIEp1
bmUgMTIsIDIwMjMgOToyNSBBTQ0KPg0KPk9uIFN1biwgMjAyMy0wNi0xMSBhdCAxMTozNiArMDIw
MCwgSmlyaSBQaXJrbyB3cm90ZToNCj4+IEZyaSwgSnVuIDA5LCAyMDIzIGF0IDAyOjE4OjQ2UE0g
Q0VTVCwgYXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tDQo+d3JvdGU6DQo+PiA+IEZyb206
IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj4+DQo+PiBbLi4u
XQ0KPj4NCj4+ID4gK2ludCBkcGxsX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZHBsbF9kZXZpY2Ug
KmRwbGwsIGVudW0gZHBsbF90eXBlDQo+dHlwZSwNCj4+ID4gKwkJCSBjb25zdCBzdHJ1Y3QgZHBs
bF9kZXZpY2Vfb3BzICpvcHMsIHZvaWQgKnByaXYpDQo+PiA+ICt7DQo+PiA+ICsJc3RydWN0IGRw
bGxfZGV2aWNlX3JlZ2lzdHJhdGlvbiAqcmVnOw0KPj4gPiArCWJvb2wgZmlyc3RfcmVnaXN0cmF0
aW9uID0gZmFsc2U7DQo+PiA+ICsNCj4+ID4gKwlpZiAoV0FSTl9PTighb3BzKSkNCj4+ID4gKwkJ
cmV0dXJuIC1FSU5WQUw7DQo+PiA+ICsJaWYgKFdBUk5fT04odHlwZSA8IERQTExfVFlQRV9QUFMg
fHwgdHlwZSA+IERQTExfVFlQRV9NQVgpKQ0KPj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ID4g
Kw0KPj4gPiArCW11dGV4X2xvY2soJmRwbGxfbG9jayk7DQo+PiA+ICsJcmVnID0gZHBsbF9kZXZp
Y2VfcmVnaXN0cmF0aW9uX2ZpbmQoZHBsbCwgb3BzLCBwcml2KTsNCj4+ID4gKwlpZiAocmVnKSB7
DQo+PiA+ICsJCW11dGV4X3VubG9jaygmZHBsbF9sb2NrKTsNCj4+ID4gKwkJcmV0dXJuIC1FRVhJ
U1Q7DQo+PiA+ICsJfQ0KPj4gPiArDQo+PiA+ICsJcmVnID0ga3phbGxvYyhzaXplb2YoKnJlZyks
IEdGUF9LRVJORUwpOw0KPj4gPiArCWlmICghcmVnKSB7DQo+PiA+ICsJCW11dGV4X3VubG9jaygm
ZHBsbF9sb2NrKTsNCj4+ID4gKwkJcmV0dXJuIC1FRVhJU1Q7DQo+PiA+ICsJfQ0KPj4gPiArCXJl
Zy0+b3BzID0gb3BzOw0KPj4gPiArCXJlZy0+cHJpdiA9IHByaXY7DQo+PiA+ICsJZHBsbC0+dHlw
ZSA9IHR5cGU7DQo+PiA+ICsJZmlyc3RfcmVnaXN0cmF0aW9uID0gbGlzdF9lbXB0eSgmZHBsbC0+
cmVnaXN0cmF0aW9uX2xpc3QpOw0KPj4gPiArCWxpc3RfYWRkX3RhaWwoJnJlZy0+bGlzdCwgJmRw
bGwtPnJlZ2lzdHJhdGlvbl9saXN0KTsNCj4+ID4gKwlpZiAoIWZpcnN0X3JlZ2lzdHJhdGlvbikg
ew0KPj4gPiArCQltdXRleF91bmxvY2soJmRwbGxfbG9jayk7DQo+PiA+ICsJCXJldHVybiAwOw0K
Pj4gPiArCX0NCj4+ID4gKw0KPj4gPiArCXhhX3NldF9tYXJrKCZkcGxsX2RldmljZV94YSwgZHBs
bC0+aWQsIERQTExfUkVHSVNURVJFRCk7DQo+PiA+ICsJbXV0ZXhfdW5sb2NrKCZkcGxsX2xvY2sp
Ow0KPj4gPiArCWRwbGxfZGV2aWNlX2NyZWF0ZV9udGYoZHBsbCk7DQo+Pg0KPj4gVGhpcyBmdW5j
dGlvbiBpcyBpbnRyb2R1Y2VkIGluIHRoZSBuZXh0IHBhdGNoLiBCcmVha3MgYmlzc2VjdGlvbi4g
TWFrZQ0KPj4gc3VyZSB5b3UgY2FuIGNvbXBpbGUgdGhlIGNvZGUgYWZ0ZXIgZXZlcnkgcGF0Y2gg
YXBwbGllZC4NCj4NCj5XUlQsIEkgdGhpbmsgdGhlIGVhc2llc3Qgd2F5IHRvIHNvbHZlIHRoZSBh
Ym92ZSBpcyBhZGRpbmcgdGhlIGZ1bmN0aW9uDQo+Y2FsbCBpbiB0aGUgbmV4dCBwYXRjaC4NCj4N
Cj5DaGVlcnMsDQo+DQo+UGFvbG8NCg0KU3VyZSwgd2lsbCB0cnkgdG8gZml4IGFzIHN1Z2dlc3Rl
ZCwgYnV0IHRoaXMgd2lsbCBiZSBtdWNoIGVhc2llciB0byBkbyBvbg0KZmluYWwgdmVyc2lvbiBv
ZiBwYXRjaGVzIGJlZm9yZSBzZW5kaW5nLg0KDQpUaGFuayB5b3UsDQpBcmthZGl1c3oNCg==
