Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0A73AE08
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFWA4v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjFWA4s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 20:56:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B82682;
        Thu, 22 Jun 2023 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687481803; x=1719017803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oKdOKPoyB0P/yLEZ2LSi8JlQbfKE7b6esRdf0i1AvfI=;
  b=girx81h5VPcvrYw5muwlKh0b6TFyObrI84YEmQcGuNeiVxRtN0XbfPNj
   WoTV7Sq+L2Hvmok9dqww245w3JlIuOBPBJxqVddXqTglMZic/IbAezSVI
   jAltM5JChOyIC3r9t9vbcFxZT2CribVJ70nRIhnVjs2VFOzF2nhQTMSuQ
   2vDpvwqUTzSNow0PQE7SA3dKcAdXKIvwdj0oGEEbUBy1V/UlaFyRhycPk
   AuEyAsvnqpycUBhk6ytPr0TriievHJun0f/8OZlIGgMTIw+ooBHZbIyrY
   C+AQnhRba46H4le/Ci6dfhAiSHMtR0xJ0TKvxTwLbM4aeGxgXuTV3C7HJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426635582"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426635582"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692503525"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692503525"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 17:56:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:56:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:56:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:56:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK2vI+LjpiWc1VDknaOH14TDpIS8bk3SH3X4WyfxphBiZdnVOdRd1Lzh+i9SYeb7h01HdyIj2Unjg6Y4DmyGCbewNEBvOikgTEGHb9LPZ7f+k54iRzM5yeDxQWwjp9nU1+YolnvjzE2FRqwb3woWW2vHpQRNCdDW6McemGriUFch6XwCkK1b94ET1fnL67wmeITpEJRfO3b0/rR62wMrNVx0RO7znu+xHW2lU0bQ6UhKTWLy+1O/iyZL1Rm9OOniutFwKotCrjMVAUfpfHNoUL4rL7R4AxuiKanjpMJEmwq0ryqPvKH+6sm7Y4bJ2EzU2phxgyRaCUO2JPH7+5XqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKdOKPoyB0P/yLEZ2LSi8JlQbfKE7b6esRdf0i1AvfI=;
 b=f08dNOf8ccoZFkdjzTL2m4Jowgj1OlEhj7BXvmFEiJJZzyDuy8HanyufuTcenzuXY+FuIGtH8lnWcAy7YGJj5joK9RyPpyu7HpMTVyV77p/ej/srRuzStQMqlL6tb6UQLkj0ApWbRjmqFuNHdIzsJspcxKVQBWEhUGEw2aR4lQOxGgJWjBzihk3qzcPC76JCMuZNS9PBkbQEYw6D0+ddB32xJRrugkCSmNJCP2Q/2KMGD4f9KPsLriUYIi2TUDwjc8n2XO+hEc2Bl/2jwJMeYcyYH1iG3mz9ZUmAEhx9R8KCbZDJqBfjUusPGtLPEboCEI4BocnBiiWM4QEeoTogUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 23 Jun 2023 00:56:30 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:56:30 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     poros <poros@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
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
Thread-Index: AQHZmsz8U3VH1egT4ECXATo1u6TwOK+VLr+AgAJ1j5A=
Date:   Fri, 23 Jun 2023 00:56:30 +0000
Message-ID: <DM6PR11MB46576DE8177933C8EB923B0D9B23A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
         <20230609121853.3607724-5-arkadiusz.kubalewski@intel.com>
 <c7480d0a71fb8d62108624878f549c0d91d4c9e6.camel@redhat.com>
In-Reply-To: <c7480d0a71fb8d62108624878f549c0d91d4c9e6.camel@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM6PR11MB4721:EE_
x-ms-office365-filtering-correlation-id: ff5610d4-293f-4845-eb05-08db7384aecc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3eCOKjcEPB3w6PNBQ3JwhaTgFjVYjgSf0Kuaox/y6I7qhmRYKokNsgak8+u3x9rh05KcVA4KF0HLzyqRbPihU2IZ8R2A6UAH/dxMvcEzmB5fW8LbJ9c/+hWnME4ISRweeuL6nHi37Ior0O2ye1IDZv8i2K53JgR6n82iTkY7jv2vZMRgi5TZUqwT5oy+pk43x8hgzudPwrZ1cNQFUfqj9j3mKcGvGE89HnRCZxgS3FV30TIbA4nrSJ3uOrQEWf1cHEEpFYCrBHxSRFnKgy36IIQM80e2AflbWVcPkIKOGaEyKJkqDPcfTNktWkECmvlCF1bKwzkCu54CuGdpeIFde+rbgjsXg888bKr3eVlPl3VZ1djDnwNepdz7N3YveccpatJTadYWNDMDcFqo7s+RYb4VQvvftuQBgTy0caoK/BdhWJ7aTEaxzazpK1PTho2q4MvoPCDVBTVJ+4T6h951q0suHH6dld9HbITUEf7PA9vZzvuxvYi9D5ubFG2TuoqdxLXyw73mnEfg/OjQFIf6lQfATsJ0VdfATl61Mu4My42jUwIJHiwTnx53PG1z5ink9d6YCD25LkT1qr7NIbhIKbkXjiUt28sDUj7cax77C4qIMMGpOqGyAu1gLNydYU6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(8676002)(41300700001)(52536014)(8936002)(316002)(186003)(82960400001)(38070700005)(122000001)(38100700002)(6506007)(7696005)(26005)(9686003)(71200400001)(54906003)(110136005)(478600001)(55016003)(4744005)(76116006)(66446008)(86362001)(4326008)(66946007)(64756008)(66556008)(66476007)(7406005)(7416002)(2906002)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTBLYU93WFNEQ3dGc3ptOHR2UjFLcmtUaXQrUlA3Yjd0TkxLbEV6cy9aM3Mz?=
 =?utf-8?B?SGUveFloS3BTYktmelRGSVJxY3JXbGtUcFVUOEJXQ1dkWkZWSDdUU3pwYW1X?=
 =?utf-8?B?Ky9UbW80Njcwb2hwWGw5MDkyTjNTbmY4SDFNVWRQVndpbmVjOVdKejhMMWpn?=
 =?utf-8?B?cEF0Y2dZOUNKdHZ0TFhFeWgyeXZpclF6Z2NFNkdqZXpxdFRxNEt3SnlkMnI2?=
 =?utf-8?B?dHIwT2Z0cWl2Q2xoREQrejR2OHcyVGs3WWRSWDdObHRvQTVEalJkaUszRGla?=
 =?utf-8?B?RER6M2U4VUhDTW5OUUhhR1JiVzk0RTl1SUdCTXdvUWRETGcvS3pjRWJpNkQ3?=
 =?utf-8?B?OVJRdksrbXFUT3lvcGx2SzBQM2RnRCsrbXZUSm9ublFnL3VFU1JqNkl1ZWdD?=
 =?utf-8?B?TUFoNWEvS3gwWm1odThEOVRNZGcvdDc4RjVaUnVFT1Fsb21DaXk3RUlqMks5?=
 =?utf-8?B?ckZOSUxLUENKa2ZDcU9WODhCMWhyWWxPRlNNRHVXemJBSTRpM2Z1ZUxPUE5B?=
 =?utf-8?B?ZFVObkZvZk8wVzNsR0hmNzdQTWl4R2VYckVoRGJHdlBucFg1VGgzcDMyMjZi?=
 =?utf-8?B?QmdIRHYvUzFJSzFsd0VVZ2lqTXFzeDFQSUJ1RkJSNy9zcFZBZUNTdG0yWENr?=
 =?utf-8?B?SmhEOGNLbWxGL1pONWRqWGlad29GUkFWU0Y1UmFDdTFqS2tUcWtQcnAvSGU4?=
 =?utf-8?B?TVpsV25RUlczcGJkVVpVV2Z5RzVDRzQwdE94MEtTMWc2cm93MCtyNCsrRW5N?=
 =?utf-8?B?bWZLK3NndG44VnpiMTVEU1BVUnhsWEVuTjF2TTBCK0V1VXRDbG92NVlaNmpV?=
 =?utf-8?B?RVd1TDVrMFJMVlRnMTNrSEtpckZ3ZVZkcm5Rdk8rdHpDVjlPYWRJeVUvM1hJ?=
 =?utf-8?B?bEhoSVNDZWxnVGYrdWtlN2FKdklhZlhUMXpNQ2VNcVFsSjQ0NFQ4cXlOSlhZ?=
 =?utf-8?B?aUtqSTA4eGtXOHlFamUzS2VHb0N4aTFmMjFMcTBYUkFSMkxrbUNFbjFqTGxM?=
 =?utf-8?B?STJPRXZwaXkwZ1d2MUNKUFVEMkhSaitkWElIVGczeVh5RGJRd1RnNldPRFR5?=
 =?utf-8?B?Y3B6ajdiZkJUZW1adWo0NmtYY2diUlk0dTlsSDF0S290KzJ4ZllxL0Z6SHd3?=
 =?utf-8?B?cE4yblRNSms5cFBzUk91N0Nwd09BTlYydTd3UkZySCtTUGdMa05YUkhhSEsx?=
 =?utf-8?B?VTVBdGVjRS9NUkplVlFkaFRXUFZjeFltT2JKMVlmVURMUW4xeklxb3huMnM5?=
 =?utf-8?B?N1BCMkRaNjgvWlpVQm1OTWdzYkIvaU81ai9GUFc5OUk3VUE1UVJYZ01GZW9U?=
 =?utf-8?B?QytTTkQ0WjNaWG9GRVBkUHpDbHNBZmJ4bDlGM2ZBY3dEUTNXc010TVh3MWlC?=
 =?utf-8?B?VXJOMnEwWURUNGc5NUpqb2hGSlhiM3IxSnBXV09KdmtBZ1hIY21OODFickdm?=
 =?utf-8?B?QnpiZHJmRXVQdFU2SWxuVTFtc2xnM3owNHBXSGx3cklCQ1RlMk14OXAzUlhL?=
 =?utf-8?B?L0FVREg0U3d2REF2S2tKb09TWERidERXeGhOdERVaXlaeHZEaXo2MFljU0xX?=
 =?utf-8?B?YmtUajNXNGRTd0hhQmU1ZDIvQ2d4VHFaSkpCWTN3S0w4MDFpMVRRempYZk1t?=
 =?utf-8?B?NGRuR29VbUxUalJnOWg1Vm1TTE0wbi83eUVVZmladGVjWjBsc1FGbTBuQWYz?=
 =?utf-8?B?QkJXYnZXOVdpYllRRlBsQnQ1VEhjR0hibWF5TWovcVJBRThZTENXd2FWUThY?=
 =?utf-8?B?cDI2dkw2NnExVzhpYjFocGNBSTMwQUdEVlpnb2U4MFZCa05GZVFTZFVYQnRy?=
 =?utf-8?B?NlF2aHdVdDQ4ckNrTlE4cE5ZQ3k0eVN2OC9NeHJwd1pZMmVvS1l0V04rTzY1?=
 =?utf-8?B?ZjlEZjJPRGk2RVl2eDdTRi9mM2hFR3M2SFJTYy9iWi92NVJ0RUZML1NFN1c0?=
 =?utf-8?B?L3kyKy93ejNlK0Q5TUcwWHgwTDdJSjdneHI3cXBrNmdCaEV5Y3hIZmpndFNC?=
 =?utf-8?B?UkxiODMyVkRwelVsQndXMkxpbGFacHZlWVp0aDU3UG5YdGVFeFBZb2FkenBP?=
 =?utf-8?B?TkY2WkY2OERqOUk1cFpFNWVYbWNMeVYyZVFDdDRsWnJWeFVjQXVwNTZWRFIz?=
 =?utf-8?B?M3JFUkw5NmNZRzc5MFA4OHovVDR2OURaUU02T1BHaWVXaEh5OVNIZ3RnK3Qz?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5610d4-293f-4845-eb05-08db7384aecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 00:56:30.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kncAPCN21iW83LIZJPJjbYbmOt6VqD/Ht1qANWBDTTgL2qD1d8pGHtGxUpYsRKikFkqDgWokd6QVjFVnGim4C2ap/6ojf9t/2nT+FTYuBPI=
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

PkZyb206IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIEp1
bmUgMjEsIDIwMjMgMToxOSBQTQ0KDQpbLi4uXQ0KDQo+PiArDQo+PiArc3RhdGljIGludA0KPj4g
K2RwbGxfc2V0X2Zyb21fbmxhdHRyKHN0cnVjdCBkcGxsX2RldmljZSAqZHBsbCwgc3RydWN0IGdl
bmxfaW5mbw0KPj4gKmluZm8pDQo+PiArew0KPj4gK8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0
IGRwbGxfZGV2aWNlX29wcyAqb3BzID0gZHBsbF9kZXZpY2Vfb3BzKGRwbGwpOw0KPj4gK8KgwqDC
oMKgwqDCoMKgc3RydWN0IG5sYXR0ciAqdGJbRFBMTF9BX01BWCArIDFdOw0KPj4gK8KgwqDCoMKg
wqDCoMKgaW50IHJldCA9IDA7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqBubGFfcGFyc2UodGIs
IERQTExfQV9NQVgsIGdlbmxtc2dfZGF0YShpbmZvLT5nZW5saGRyKSwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZW5sbXNnX2xlbihpbmZvLT5nZW5saGRyKSwgTlVMTCwg
aW5mby0+ZXh0YWNrKTsNCj4+ICvCoMKgwqDCoMKgwqDCoGlmICh0YltEUExMX0FfTU9ERV0pIHsN
Cj5IaSwNCj4NCj5IZXJlIHNob3VsZCBiZSBzb21ldGhpbmcgbGlrZToNCj4gICAgICAgICAgICAg
ICBpZiAoIW9wcy0+bW9kZV9zZXQpDQo+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVP
UE5PVFNVUFA7DQo+DQo+UmVnYXJkcywNCj5QZXRyDQoNClN1cmUsIGZpeGVkLg0KDQpUaGFuayB5
b3UhDQpBcmthZGl1c3oNCg0KWy4uLl0NCg==
