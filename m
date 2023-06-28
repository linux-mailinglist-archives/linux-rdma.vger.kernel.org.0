Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9A740DAB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 11:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjF1Juk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 05:50:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:27601 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235793AbjF1JgZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jun 2023 05:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687944985; x=1719480985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CDA7GFzy+kd2TEeu1M5kuE59OhxVg1VSQtYPcUCMZXw=;
  b=KFIa7aQTvERnaU9wgFbA7Gd8LzbtGIHTLpblYOlamAFG6zPry5KfzcsM
   9R7okIq3cJ/48wt2iCRagM/OGe/JnGTEqwUYgwwSbyWbN/IVIjVC5t/1S
   TJqNzn1AhSRdAwczISjjJBzCWTz8hl9AHyfxA33sZwhnlGBNSCXLSoRZm
   5P1APZeCMagD2fH8HWXBjmIfcF6iTlyUoX3cdNLdA/YEvFU/iHxzcIwwo
   /nBdFLvLsBk+hrOn4m2/bQlfu8UDl4zEP7B+Z4tDmTXVXOkhHE0xz7RbS
   byjC32BhGGRjV6aNqPgcONoztWLU0goVzmMUx0S1GoSsuW/WyrEN3FxB6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365255725"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="365255725"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 02:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716874914"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="716874914"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2023 02:27:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 02:27:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 02:27:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 02:27:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 02:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWEJ/tA4ZQQzOAofLgmDtfTUDeF2gVa7DI2nlIle+3nMGXjzCTNNfJNhpD1D7CHjv0Bd6V/JSvU8ZTnG7x0GzjbeyVKN3iqruzFlkLxT7LDidS1MbPUPBfy/KrvYp00MSVpAkQlew3ogOgz1Q0OdSBB5V0iy3Aas73weFN3jhiNTNjsQA0XMG33qqe4PUq01A0b9PylfB72ooL9Sw/tAxZJJjB3MkOWpZK+16gp7SFzHbncNfGaiY33aLpxXVhBnRAGDXB9tlRbEI3L6pSwLvLNMCMKk6E0QCzV/o+MlDwVfr1ocxiPvhOv66VQtUHFcAkvw/bzIU7Jf/50T5yrRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdzrLfeX4pmY7a1iEAwe9ktLInbVH7YJ+D75gUkDjwg=;
 b=SQ4OwXmGV7R2kB1QsMidEbL4YZFE0cGLCNnpDjs5Gf2/ULjArhZMZfPq+CbGxnUKyslqgZIa3x7iLCEq9E8TxvzoPhtc4KXaDHOmXj0+gdArRaibo1Kt33i9SE1JNS1vPz4mAndeTpinvAXIqUPCRw2WXfOyyyKuqGRT6/S69keL/01U/z5UJCRofIx4p2lg+za+1SAD0CwF2w7VcPMaoTI7HF4O/eNKHBRJANzEUryLGLzejeYEWkLfFP+rUIhpJwwgdUA0Co+F6K3Fb1XXv64yL90k+wBHcovMq3f36JCKqlWONsnk2iHObdxmuhMPoafEnaQwIFgCZml1izRQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 09:27:11 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 09:27:10 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>
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
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH v9 00/10] Create common DPLL configuration API
Thread-Topic: [RFC PATCH v9 00/10] Create common DPLL configuration API
Thread-Index: AQHZpc/u2XBvfmJQckCFu+3HjTH4RK+edcOAgAF/xCCAAAJWMA==
Date:   Wed, 28 Jun 2023 09:27:10 +0000
Message-ID: <DM6PR11MB4657A1ACB586AD9B45C7996E9B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
 <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA0PR11MB7281:EE_
x-ms-office365-filtering-correlation-id: c89e42ce-f0a8-4763-3a0d-08db77b9d960
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aec9IrTrX4aPMpEKCsOHXXlJo0hNBR2VAh4fUxg2v4dwfWGXFXV63FaT/WXjYhcuUf5MjCWQenc8eL3TwpNPs0aKf3gCHmGFfv8///+Jxh7YfdpmCyJRTXfICPXiwd0g6jBm13sulx8zepWdxd/fLh4BIqxnrtnBtJncl7T74WujljI1tj6jY72AHVMvCJQvahhHpb1ytR8JzkqAym2HcX2qSNDw8YY0jf8ns5ZlQLfwfXovcNmFTNv1aaDQBWaQpaPMMRGAZobU4OGsZZekFYargm0FbdiJw/toPjOehElC2L9ukdsnHU1UB3OYZILK3tidud8O7rUv57+m3Tu4jkD2z3sChrii+jUSQbQFOdGjUm84UJYpkX0ts+qD57sR4HcjOTnDwleyxG+9ajJXIYYE68gLGxElEMhhpBmrsJNxfnW5cShOwOWI41W6Xp/5x/L57RwHX21Zx1tDcy27sNoqWqjYT98zuozY3qjjqtVxXjSJCNS9uiMsRxXzytq22mfDwEpH5lhkFxR6b5//CQ8f51k610nfEuN/vsdZhjq9Bm3SpPr8QkYsdfN3lNUxcYiNOMaR78T3C6D51HaRbALrzxPbw7cHlEh1ImWPF2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(7416002)(7406005)(5660300002)(52536014)(66946007)(76116006)(33656002)(66556008)(64756008)(66446008)(4326008)(66476007)(6916009)(478600001)(316002)(8936002)(8676002)(2906002)(55016003)(54906003)(38070700005)(41300700001)(71200400001)(186003)(7696005)(86362001)(26005)(6506007)(9686003)(2940100002)(122000001)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PE7PCzHeFtiKQewZbf5b1E+IyXcRsQ8QuV5mCQ468MUIm5e6RPE4o9+AaN/z?=
 =?us-ascii?Q?fg4nS+MmOoCH1KeYWQuyXlQRQ2Vbg1rNdmyAoyseF6uXqIINyfWv2h4C7Ydi?=
 =?us-ascii?Q?y/66OmqbocOoImpfcCd/Q5LzB+VxwjG7yQG2UxycwXRj2vvVspTko0Gni/Xr?=
 =?us-ascii?Q?fBYn6tsBb/+Xwyv40t4J4Ez2vjGMfmRKWQrf8BzstxIWcCX+Sx9ugSkPtx+d?=
 =?us-ascii?Q?A9jJCeqtnvddwOTZLq7vzXAhTAr5B7G068jQtVkjbm2ATw+cL//nqUmMKFXI?=
 =?us-ascii?Q?2AESDyD2sYkYNLt3D+5Ut3zl/htMjdT9CFcr5iRn2Ypyz+XhPG/FjHgWXZrd?=
 =?us-ascii?Q?XuicmpysHwvzcgMZD8LgIfrF0Cxx9Sc51SkEXoVMq2CnTSMyeejauUc76grk?=
 =?us-ascii?Q?pLu7ls9XMwrU4oSh4bDoSUO0KLCn/0ii57Rb02OaJ2/SO3bo6+ycW156XN80?=
 =?us-ascii?Q?zrGGqS1/o4febH6Jdkxf877Ai1Oefqp7uTR9Zd2AwGAoTdXBOLKUkztxsJxR?=
 =?us-ascii?Q?soHdGvzgCBjOPxEBYF7b05BGgYK7nxsynCTVaYkGZsWPq3WJIW8IwGp8YjPK?=
 =?us-ascii?Q?vGrGkJV/INalh9LLqN9I8TB2LOZi5aPkyK3vcnaSM7yBG72ZyATOSUffEBc2?=
 =?us-ascii?Q?nUOGV2/chieKGRLO6C9bpNf5n8WuvTABoFYhT5PDnSZbxEvYvqhIe5rrIS04?=
 =?us-ascii?Q?ieGM9jRxTj/RzC/c3vntWdCS9lQ7JQzvcVXplJVtPhGpMnYlvtaRjso5D9zz?=
 =?us-ascii?Q?eF2QYb+xmz31sAHoZYwFamuwRUaxos6r0Xg63s1bOCVal7XTMoyJhrqPEYFp?=
 =?us-ascii?Q?EOIOPl1txFMAFx7CChnnA0xm9lcJhxMNCSYvFgpkblAWM9Ntf+HCMGEP7IjQ?=
 =?us-ascii?Q?/hPPCJfPAHXjSJBS7SZ9Ux9jvAVD2ravooHuzX+f7+4z5z4kKap7B96J7hNX?=
 =?us-ascii?Q?2kpThdbI+GZDFwsQso6qkHW33ilAUq4j2SmO32agrp20ifCNUI3Knyfqr7OB?=
 =?us-ascii?Q?cBY5EBNbWkWBHy2vXLEbjnyGvjQDlpxdkUOl5CK1CF8a2T/4tmLrDMfKH987?=
 =?us-ascii?Q?/H2ODJ26R6TCAOxhvjhyk8FGMdxOAomZr7/ttGR8UHxVIufFWjv2r7376vJl?=
 =?us-ascii?Q?j0yLH9EDAJMax6Vb19gn48hih9r1c/Dhn4RKcZrwoDz1ydmL0nPD9cp/dwlj?=
 =?us-ascii?Q?T8C7Q1NpeI/sSUTs98U9tZBC+gfHNqSkUTtS1adajQYWWvC8UP/d/bvc10sp?=
 =?us-ascii?Q?VStc85g+lLNUPdf+Zpb4a/amYasTsRXj4Km8DGw9mqp0BdypBzUCVfOO2mV8?=
 =?us-ascii?Q?r/DNKWiB6CyARlxzg6b1UAqA3dVUky/qMO3ZQ1gQsOnn3oZ/4IdI8pst2LzE?=
 =?us-ascii?Q?3P1496HDTvs3/92hb+cnNleu1SrudHeMIwtuR+kDdk+sLAohJNzGcLlwJpYv?=
 =?us-ascii?Q?agWCWeWkU9V/ShvWgdoM3xQUy+eWlh+P4Apv4Cy21iLhg8CiA42xO4gTdq1J?=
 =?us-ascii?Q?EpiNnVEviKSuMoNyxiEZzMVJARzNzI3drOgc0bhFFU8WgVu4O0yrkWwDMDys?=
 =?us-ascii?Q?b+X35Ju9z05Awil5tNoItqvEGIge5KZb+u2I6SgWtcrJZh//nsuiTmGoaqcR?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89e42ce-f0a8-4763-3a0d-08db77b9d960
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 09:27:10.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UppCb700ZNILxZqIdToW5Y4zZHEnFPQSEZhFy2/UrNBZwBqidqlIBuzdINXXFq6UKBmjcS347vJ+VDcYm4977I9y7AAFoq5LWVuElheupmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Kubalewski, Arkadiusz
>Sent: Wednesday, June 28, 2023 11:15 AM
>
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Tuesday, June 27, 2023 12:18 PM
>>
>>Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com
>wrote:
>>
>>>v8 -> v9:
>>
>>Could you please address all the unresolved issues from v8 and send v10?
>>I'm not reviewing this one.
>>
>>Thanks!
>
>Sure, will do, but first missing to-do/discuss list:
>1) remove mode_set as not used by any driver
>2) remove "no-added-value" static functions descriptions in
>   dpll_core/dpll_netlink
>3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
>   after each patch apply
>4) remove function return values descriptions/lists
>5) Fix patch [05/10]:
>   - status Supported
>   - additional maintainers
>   - remove callback:
>     int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
>6) Fix patch [08/10]: rethink ice mutex locking scheme
>7) Fix patch [09/10]: multiple comments on
>https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
>8) add PPS DPLL phase offset to the netlink get-device API
>
>Thank you!
>Arkadiusz

If someone has any objections please state them now, I will work on
all above except 5) and 7).
Vadim, could you take care of those 2 points?

Thank you!
Arkadiusz
