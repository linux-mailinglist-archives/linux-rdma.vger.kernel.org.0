Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B573AE04
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFWA4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 20:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFWA4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 20:56:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B5C2107;
        Thu, 22 Jun 2023 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687481792; x=1719017792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jihsa3Zm59DiAVICVxoD+owYwcbfdI7N2oO0iqEpCLY=;
  b=BT+xy9ZSy9z5YewgUM45yVr/ElRh0ECOBIbvnPjOwuBKNkd+6h5+/8es
   vPAn71yaXc5GeOsjec/w0m7RDfTZc3jB2a/66rrYkspXyuiH/9Fhw5wtT
   G3Vb6PBQJm2lE1iX6MyuENKYCjlLjyw/Cdx86lvMhPqflotAajLWrHh9O
   dYY6H5TjhLKk6T8quDA0MWWyo8fywvxq7dGQQGqxx2090g3GRxiEEfeBk
   UKMBUye4vflu+LHcp3mSaIeBcRhP4qHjAJHm6unwSiDv5r6A4QZ0jtONK
   ixifvwDHH4z0gIH+EQQz6gwFrP88VhzLh9cDGbC1BbMCUtWpuu5024y+F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424341411"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="424341411"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828181978"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="828181978"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2023 17:56:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:56:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:56:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:56:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TietTqy8jR+Qc5p4PpxhVbcgY4LewIPTjgJrS+lUhnPdZjQsKPfkdNECuI1w3+JDwePEWARgAK8jeQWfDYBwORltWW+JVB+7Xvk2LN7E2E/5QU2WYZlG1upgd9Kkai5wRB4F3pNSR51d2sROmcoyZEB51J4FBVfQIM+Nl3LYG3ImkY/wNmSkN1xnnIDEWcHOURN94mJ20Jx1Un2oz3oMlFbVLnF+KixveZcarGVfse6WnC/AA7qcJdN0BrawwC1oPqLQbe+3OmAD3kJ4LgrmTlUqqCuhWJokmhdOdUiSZwLRyI2kgKhKkZDmPoUhC9+Zi1bTKdhdOpQjvo9dwcATmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jihsa3Zm59DiAVICVxoD+owYwcbfdI7N2oO0iqEpCLY=;
 b=HAoKBDHgftofspkEvpGr3NiO0m5VaDIQH2aPie/6rtmuvfRCiMt7Y3T2+WMCBVLQIzjcoZSQVdVW0QBv9hemxw96RW5sPAJC6Jy19q34tsi0g0FBoDJO/gbS39UhM3LhJv6FMRX9qvoiw2whdVWcNZAnRRLXUNwiTI+IutVi5el7FMdwctKvrU2Q55EnjKZ6nDccbXRqTM90Q6Pyy4RuaTqu0WTdocx4+NHrD5JCUw/vPDOE2kORHHKpaFJsiQQBY/pSSHmoQ8UBd9roHDRtGPordwcauRXbQgjpQK+kv6Lq1R/zkuM9hrGngNNgnLDQGPgjg9EFUCxo553xSN0D3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 23 Jun 2023 00:56:25 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:56:24 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>, poros <poros@redhat.com>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
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
        <linux-arm-kernel@lists.infradead.org>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH v8 04/10] dpll: netlink: Add DPLL framework base
 functions
Thread-Topic: [RFC PATCH v8 04/10] dpll: netlink: Add DPLL framework base
 functions
Thread-Index: AQHZmsz8U3VH1egT4ECXATo1u6TwOK+VLr+AgAAJngCAABTBgIACV7Sw
Date:   Fri, 23 Jun 2023 00:56:24 +0000
Message-ID: <DM6PR11MB46578CD80F96AB11AF2F81F49B23A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-5-arkadiusz.kubalewski@intel.com>
 <c7480d0a71fb8d62108624878f549c0d91d4c9e6.camel@redhat.com>
 <ZJLktA6RJaVo3BdH@nanopsycho> <ZJL2HUkAtHEw5rq+@nanopsycho>
In-Reply-To: <ZJL2HUkAtHEw5rq+@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM6PR11MB4721:EE_
x-ms-office365-filtering-correlation-id: d1e3bff7-3736-4b1e-069c-08db7384ab11
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USx6XOt6dF05o6bajM9y+3zWb58H0u2p0VVbMHYb6F59JeWgalKhls1KEGIWk5aiE22hdqBtcyNokWJK1J0gob69iwoXZpI9vmGWoAAnGohkbD/ZUzM+rafPN0w9Q4s5DORMfc6mu6dCm1QCVskUS5Q1D644ZFHGmsPQYzVSYS//vdMayGXK+PXvwyLkyeaPypfVLQVZKFhsD/UxogWZfBT4CiGWj8s5kbgtRswo6tUzMtQIMaNiEeUQegBIe1NYobJ/vBQqglXRo5evj5m6pRN6LDnFOloM7uS/KTO2ERhWysxWJF6B8qr+6EAGz1/XX4qFRJneQ28J2Qup9iFID7XkRvTSExhlh6BKlBV+PT4Cl0RrrfNZbzt6rXZpqFib8PdoMTcjz7/gKy3qYMY9nTAk0Bh5CgdUUHlIH0E9YQl9c3mD/6q2MjceXdNWgjZZmzwJFlS3soc7tfm0BvKQQs+rSqFrkbPnyK42F+0C8PhvGFtdXIHijLFZkaEGWbYXu/Vb1gZ/bEhiY3ZQDYiUqqtuwukmlQUkfIZ/HFlOAtfvpNxNQBQOtYpcIxpOAdjGWztOebqhRq82EOgcy8oK64gmpIewKg3E7cNZQ0y108LFvsoN98mzL/xOUtscgwmS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(8676002)(41300700001)(52536014)(8936002)(316002)(186003)(82960400001)(38070700005)(122000001)(38100700002)(6506007)(7696005)(26005)(9686003)(71200400001)(54906003)(110136005)(478600001)(55016003)(76116006)(66446008)(86362001)(4326008)(66946007)(64756008)(66556008)(66476007)(7406005)(7416002)(2906002)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXFXMmRWTGxGOEhXTFk3T0xPMVl1a3dYTndGTCtkZ0dVUmViRml0WUtxbjVT?=
 =?utf-8?B?YWhhbUxpWkNMUGFLV2JPV0U2a2JoemRsSnJzV3BJNWwybURDNEhwQ3RldEZn?=
 =?utf-8?B?NmYremtzclhMOGFwOVZNcnV3Y0dudFZzeU9CQ0JQL3VVYnhvREhKSitGdFMr?=
 =?utf-8?B?SEhCSjFoYmpIemExbnlRNTVuUXhmRUJQZ29xYWxOSGdTRDRETjl2VWVYM2dO?=
 =?utf-8?B?bzY2ZWZaVTlXUWQ3S3hUVWpOUHZvd1d3c1A4SXlJVVhNV2xmWDZWbmg1ZFRL?=
 =?utf-8?B?b1VmYlRHbkFXdjNvRDFxb2hlM0pZbHFxaDNMbTJEMC9RTitnNGV3Si9ialRI?=
 =?utf-8?B?NTdIVFQwTk1uMSs1bzV2ZUZ5ZWoxS28yL0REYUhBbFhBU3dCcUdBMTBEeDZB?=
 =?utf-8?B?K0I3V3lLbEExL21IMm5tNkE0UlhXQi9ZOGZnK3RWUVk4OG1keG9NWktjNnFZ?=
 =?utf-8?B?YWF1SVV1NnhsTm1NQVkwa2NReUI0QkpLMXlRVnZ2UE5RV0NzTFp2aWtoNUFq?=
 =?utf-8?B?Zm9VK1lpQmFtSHFJcG9BOUV3WDh5QkpSR09rcmZRWkhtYnBjMTNBaVRUN1Yr?=
 =?utf-8?B?cjBvQXUrbTFMS1V2TFFRU3J3SmNVMGEwS0FyQWl2NFp2VkVNOVdqaitxYW0v?=
 =?utf-8?B?MUNnQ1RuNlkwWG5iYmtUaEx6Rnc1QkpNbEE0cTNIWEV0Y3JMUXhIaVRLOTVo?=
 =?utf-8?B?U0xBZFIySFZBcTB5YW5MT0I2allETFJBOE9VTU1zU0xRZUU3STRFRE0yWW1F?=
 =?utf-8?B?bm9ET0k0RFhSNjdtdUtSYW1kUmhrNC92WWRMSkVKVzI2QzU1ZTQ4U3FHeGJB?=
 =?utf-8?B?dkF5Q0VlWU54eUpKanp6NGw0WFQzL0J2QTl3TGQ5dDk5TjJBUXMvb3hsRVdR?=
 =?utf-8?B?N2VMaGtVMm05YmVKTnNwMzN1eTNOYVduSkYzUXJZb2d0NmRLVWc5NlFIbHM3?=
 =?utf-8?B?N0hvVkRLQ1MzNUtSQm5SbStwYzlGM1ZLZkVubGVvTXl1YUQ4ZEoxYkdrK2FJ?=
 =?utf-8?B?K0luaG1Ed0xGNlhZVjh6MDlMcitHS0l4Zml0NzY2ZVJJeXZkN1JpbmZUN1c2?=
 =?utf-8?B?WG01VDdLL1FTclh0ZUdMWGxkanRqRXVHN3QvcFhkWmw1MFhSWCtwT3ZFVzdy?=
 =?utf-8?B?WFM3SVdkRUVSYXlWdjdwczZsWEpSbXlBbWpxbUZKRzF4Lzg2WXlEajZNTmhr?=
 =?utf-8?B?cnJkWHR1UVNRb1VqQ2pLbXFIQ0dua0YydlI2WDVvcjVTd2dNVDBYUEQzN3ZY?=
 =?utf-8?B?aDZkRUZJT3VUY0pxemU0S1VXZ3dnK1Yxc1poRWxMNnpOL2Y5T1djNnY2a01O?=
 =?utf-8?B?K2E4akpBQmZtSkF2L2hVQUk2NkJmT01jdW5rK1ZUbmFDa0NxVkplZ3NtSU5a?=
 =?utf-8?B?MXJTRUxxdnFXZXpJR3V2bkY3dU9rZVZpSmpEam9aY05rcFRVR0NVaEUrK0hI?=
 =?utf-8?B?QXVoVStuREJPQythSDNoSnBtRFVXQ09HYmFyS3VLa2RIUnFUcEUrdmFoYjZp?=
 =?utf-8?B?RXlWcElpQmJGM3RJcDErME1ZT3plZ3lHUXZsZ1lTTVI0SWxrclBQWUVYV1hP?=
 =?utf-8?B?WHRSNzh6WEszR0c4b0VnUFN1U2dsK1l0VmhwKy9XUG5Sa29GbjFuNHdoU3JN?=
 =?utf-8?B?WmFIa3l2blB1U2dPNGcvYVpOSUh5QXdVL3IxTXJWS3gzL0I4SkxWeXUwd3lT?=
 =?utf-8?B?RU0yY3lXVGZ3akZHa09KcFBzbGdUeE55MGxYeVdSMVpzM1E4OGUyZWlZYUdp?=
 =?utf-8?B?RWpFWHI0NU5RU0N2UDd5T20zNnkrSW9lTXVabzdLRnBOaGZoa3p3NEt0S3VD?=
 =?utf-8?B?T3VDdmx4a29OQ2w0Q3F0UmFFVjN2ajlpbStJbWUra0ViemxDV3IyenJxRFp5?=
 =?utf-8?B?NWNyZ1Z2UmREYU9FOVp5US9iY3F2dGFaTjJSVm5DMkhrd2JNYy9JcHdxeFhs?=
 =?utf-8?B?d3FMakw1R09IOWRValhCOHhvdWNEQ0tKZFg1c1gyQ28wdHlBUkFOT0t1ZEdk?=
 =?utf-8?B?V3g0MWtFUjhtcFppUm9UTlVvWGRoVmhVYzk3bXlEQVk3WWVvNmFmcG5ySUJi?=
 =?utf-8?B?anVrc3lwUjJBUTZodm42WTNGK3lYR0ZnQlRON3Vva0FFNEdhWHpwOHczNzZh?=
 =?utf-8?B?ckVDcEpwck1GWmJzZ3NiaHY1bHpQYTdYNkxxSWV5aERPY1VJckx2cU9yVmFN?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e3bff7-3736-4b1e-069c-08db7384ab11
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 00:56:24.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNsHv7j9lh4px9MKuyEUjK2J+Hx0XZXgeFwOl2fax5pYKLWtWCWDmb3pe3rUtGCQyoblrZqLHuSLLNRCo2U0gLR6lzJQZDDVg5eG0ElkE3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PkZyb206IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+DQo+U2VudDogV2VkbmVzZGF5LCBK
dW5lIDIxLCAyMDIzIDM6MDggUE0NCj4NCj5XZWQsIEp1biAyMSwgMjAyMyBhdCAwMTo1MzoyNFBN
IENFU1QsIGppcmlAcmVzbnVsbGkudXMgd3JvdGU6DQo+PldlZCwgSnVuIDIxLCAyMDIzIGF0IDAx
OjE4OjU5UE0gQ0VTVCwgcG9yb3NAcmVkaGF0LmNvbSB3cm90ZToNCj4+PkFya2FkaXVzeiBLdWJh
bGV3c2tpIHDDrcWhZSB2IFDDoSAwOS4gMDYuIDIwMjMgdiAxNDoxOCArMDIwMDoNCj4+Pj4gRnJv
bTogVmFkaW0gRmVkb3JlbmtvIDx2YWRpbS5mZWRvcmVua29AbGludXguZGV2Pg0KPj4NCj4+Wy4u
Ll0NCj4+DQo+PkNvdWxkIHlvdSBwZXJoYXBzIGN1dCBvdXQgdGhlIHRleHQgeW91IGRvbid0IGNv
bW1lbnQ/IFNhdmVzIHNvbWUgdGltZQ0KPj5maW5kaW5nIHlvdXIgcmVwbHkuDQo+Pg0KPj4NCj4+
Pj4gK3N0YXRpYyBpbnQNCj4+Pj4gK2RwbGxfc2V0X2Zyb21fbmxhdHRyKHN0cnVjdCBkcGxsX2Rl
dmljZSAqZHBsbCwgc3RydWN0IGdlbmxfaW5mbw0KPj4+PiAqaW5mbykNCj4+Pj4gK3sNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGRwbGxfZGV2aWNlX29wcyAqb3BzID0gZHBsbF9k
ZXZpY2Vfb3BzKGRwbGwpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmxhdHRyICp0YltE
UExMX0FfTUFYICsgMV07DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoGludCByZXQgPSAwOw0KPj4+PiAr
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoG5sYV9wYXJzZSh0YiwgRFBMTF9BX01BWCwgZ2VubG1zZ19k
YXRhKGluZm8tPmdlbmxoZHIpLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ2VubG1zZ19sZW4oaW5mby0+Z2VubGhkciksIE5VTEwsIGluZm8tPmV4dGFjayk7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoGlmICh0YltEUExMX0FfTU9ERV0pIHsNCj4+PkhpLA0KPj4+DQo+Pj5I
ZXJlIHNob3VsZCBiZSBzb21ldGhpbmcgbGlrZToNCj4+PiAgICAgICAgICAgICAgIGlmICghb3Bz
LT5tb2RlX3NldCkNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KPj4NCj4+V2h5PyBBbGwgZHJpdmVycyBpbXBsZW1lbnQgdGhhdC4NCj4+SSBiZWxpZXZlIHRo
YXQgaXQncyBhY3R1bGxhbHkgYmV0dGVyIHRoYXQgd2F5LiBGb3IgYSBjYWxsZWQgc2V0dGluZyB1
cA0KPj50aGUgc2FtZSBtb2RlIGl0IGlzIHRoZSBkcGxsIGluLCB0aGVyZSBzaG91bGQgYmUgMCBy
ZXR1cm4gYnkgdGhlIGRyaXZlci4NCj4+Tm90ZSB0aGF0IGRyaXZlciBob2xkcyB0aGlzIHZhbHVl
LiBJJ2QgbGlrZSB0byBrZWVwIHRoaXMgY29kZSBhcyBpdCBpcy4NCj4NCj5BY3R1YWxseSwgeW91
IGFyZSBjb3JyZWN0IFBldHIsIG15IG1pc3Rha2UuIEFjdHVhbGx5LCBubyBkcml2ZXINCj5pbXBs
ZW1lbnRzIHRoaXMuIEFya2FkaXVzeiwgY291bGQgeW91IHBsZWFzZSByZW1vdmUgdGhpcyBvcCBh
bmQNCj5wb3NzaWJseSBhbnkgb3RoZXIgdW51c2VkICBvcD8gSXQgd2lsbCBiZSBhZGRlZCB3aGVu
IG5lZWRlZC4NCj4NCj5UaGFua3MhDQo+DQoNClNvcnJ5LCBkaWRuJ3QgaGF2ZSB0aW1lIGZvciBz
dWNoIGNoYW5nZSwgYWRkZWQgb25seSBjaGVjayBhcyBzdWdnZXN0ZWQgYnkNClBldHIuDQpJZiB5
b3UgdGhpbmsgdGhpcyBpcyBhIGJpZyBpc3N1ZSwgd2UgY291bGQgY2hhbmdlIGl0IGZvciBuZXh0
IHZlcnNpb24uDQoNClRoYW5rIHlvdSENCkFya2FkaXVzeg0KDQo+DQo+Pg0KPj5bLi4uXQ0K
