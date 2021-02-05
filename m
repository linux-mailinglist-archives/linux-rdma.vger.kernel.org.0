Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA34310EA1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhBEPoM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 10:44:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:11022 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhBEPl6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Feb 2021 10:41:58 -0500
IronPort-SDR: sjyB/wnVxbajtyLTqwajAov2ZGFaG6w6Av/zo+3xu0OV9rh5KaBV/G72cnDwTh5SwdccLbWLjp
 y2YyrSSHH1dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181610016"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="181610016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:23:17 -0800
IronPort-SDR: NVg/z/bgmJV4wZO/Sbma8nGmvjmNNWAuY/EYKv7AJA0YWRpBhF7I6ksJ4XugpMeFu1hCNFw7A/
 B3JgSSrX+4ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="434538024"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 05 Feb 2021 09:23:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 09:23:16 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 09:23:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 5 Feb 2021 09:23:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 5 Feb 2021 09:23:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax8DV/aZFpOFYjIXnuuurFx3kWCmQuk5mZRS/TL9KkpG4ArrZGi4OtqRwbvl71Vt61dMcY1KJahwvVNKmDYc1VSDk6rLgoXWsSnzBs9cyeTtO3jKiHkS6EsUIIUMV7pQ4Jy+LxBwfEkwcdNRANfysP9x1PbyNfCmLJBXQPvzG5QjMA9IXrRxG2KvHVA0bsn0uHQjKhjGi3VbsZrdy2uO76DqA8QKhYFsvajMdsqa5atec3cei8v4kk3prh5bjBMZMfv9gWVD+BDroiF232Dl99uG/IzFWvhBOom6t9zUcskiFNG88xfJxsVYAkQGk4ndSOVpifSpxJ41MoTQII1vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPt4qok7zBiZjSmUx4WBahTC6NOURlWTlIh0XNCuCoU=;
 b=SSstut9UYZUfFnIZ2Pk4qsjnTpHYnmX72M6n/+TQJHTvY2tffaODldvIJlm+zvQeLBfvduD8u+4PERcSknD2bhPo3HoKjsrylWR/L7UKZhSTUYRY3RFmMAGl0ONo7CrfcS0WHI9NTyVGBuTLfZOrI1o9F8Dn4NA10rvPon61d7a3h7JD6dydy5rHTbqIpg2GrjyqywxQ67wyDJ/f+rr6CeREGypkiM/kETajlagbyvIRlK/3/LmrArnYHjDGJz9Vm//UNH2dg65SRonZ1rq719rOfQN4PlCyc4FInvRkseoeuqvNTmubthK4/CjuRUxIajo6cIdutss0Z8PQo/2MDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPt4qok7zBiZjSmUx4WBahTC6NOURlWTlIh0XNCuCoU=;
 b=LktL2PH1hqf7aQDMFBBk7eL2kpvNXyUosLgKaxbx0om0n+AmnXn59fVcVii0q8+982Y5QERDizjfv9SmgRy/5Z3+C+7eX740dXYtoNCmL+5vlZmOsZi7ZssLhcPXWevb8piyvkPNuJ1rkN86jvlrCunx/rhiGgvQBZ9SLqttFQA=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 17:23:14 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28%6]) with mapi id 15.20.3805.033; Fri, 5 Feb 2021
 17:23:14 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Edward Srouji <edwards@nvidia.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Gal Pressman <galpress@amazon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Ali Alnubani" <alialnu@nvidia.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [PATCH rdma-core v2 3/3] configure: Add check for the presence of
 DRM headers
Thread-Topic: [PATCH rdma-core v2 3/3] configure: Add check for the presence
 of DRM headers
Thread-Index: AQHW+1PeGZRkK9WaZki5kJTvZ7J+3apJjTkAgAAI1oCAADRZsA==
Date:   Fri, 5 Feb 2021 17:23:14 +0000
Message-ID: <MW3PR11MB4555B63081B758D1E4A8C798E5B29@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1612484954-75514-1-git-send-email-jianxin.xiong@intel.com>
 <1612484954-75514-4-git-send-email-jianxin.xiong@intel.com>
 <20210205132224.GK4718@ziepe.ca>
 <CAKMK7uG4M3vBVB_gH4gJOOATdCk9HfUWEWAP5g87mDVM78P23A@mail.gmail.com>
In-Reply-To: <CAKMK7uG4M3vBVB_gH4gJOOATdCk9HfUWEWAP5g87mDVM78P23A@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 16338fce-8c3e-413d-969e-08d8c9fab846
x-ms-traffictypediagnostic: CO1PR11MB4898:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4898DC6909EBADB55F34BF2BE5B29@CO1PR11MB4898.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+XMtE2RF3GuVwcr/HBOi/5Bp7s7DQa/CRXdNb+Wukp+rLRgNBZjk4p1eLfjZYWUVa2IaQp/HgLUm5gYxYy4XOps07QODTRlgUIt012URqleW1Iu9Menle7u5Ho8vv/K6PnE2C4McauD/SUsYC9jLjj6FFtwyvJwxXws2/n7biav/6eOM0olH1rD3XJ/w+IxLhbD47bQvs4Ru9AVivCS920F5aJV0z7cjhLEi9vpgiJKcEtzNedcyD546cioqYFxHXbWowaD8B1sPe58Mjkn2w0T23vb5JN7rz3aGinJBqc1RW5+O5VYeYwDhQeAW+Hfr8qQA8IzhYXcVkjGtZwgpLRf3AY9mjxnCnpprfQh3sxE4hRHGlQZmztPG5ozRQXHeC1Qtf/4dbc1Fn2J+AFQtV2uEJuewH5WPVM0pzOAA9dvg7fhoCgUJYPflCf4XBlJxcupR5N7VWd/Dje19swpWWH/YmvE+ojRxDhe0TRD/iDhmECmch6mPqIY0ZfK8QuNhTbYWwaCnaSsOVxzomgrX6WjDXTyWdcd25I0VqmZszPC3us+REHV5oR3lNwHnOH+/LHDAjZjTGcDcAJA5RmbMTkhinyjYrfWd5vb/72ntFzPbXG+BF+qo4atw1lWMFMgxELTYmJhXSWc0v8K2IMHzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(71200400001)(8676002)(86362001)(2906002)(9686003)(55016002)(6506007)(53546011)(33656002)(186003)(7696005)(83380400001)(110136005)(54906003)(26005)(316002)(83080400002)(478600001)(52536014)(7416002)(966005)(4326008)(5660300002)(66446008)(8936002)(66476007)(64756008)(66946007)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OXN6MjRSZ25RelBJb2orYWNWdnBvN0hJVWtwbWhrcW85VmFRTWQ2L1NCTStT?=
 =?utf-8?B?TkJvUUFMSUljR0JEdmU3WVIwejJkVHRldXp1Z3Z5SEtBdEFUdVEyM0VFSVo3?=
 =?utf-8?B?NnNLRnNaZ2JNTG91dTNCNlJBRTUyM2FOL1V6S3lSMGV2ZHRteGZSbDlKZ0hR?=
 =?utf-8?B?WVY0MEQ0WUJuOHVJaVo4amlUdVpuNEZnUUx5cTZjM0syUFpEVnEvUXJGOHRZ?=
 =?utf-8?B?M0ttbWd1MzczM2VCdTB3cjAyUEdGTkpWTEpRbjhEVlJaOHNFWVh4RURyL3Bv?=
 =?utf-8?B?ZWs3TjZndk1PN043UW83M3FSTjBhVzZjbVRBS3QvRWpTS3VqbmZTblorNW1H?=
 =?utf-8?B?RWdrQVE5Q01BTkx5TzNXZWZST2RsVlZkb1h1a25EWld2TVlwQ1phVlVUa0xk?=
 =?utf-8?B?dFhEQnZKMUJ1NmJ3WVAreEZwOEk0TFk2TUMxUWhVcCtBM2xhNkE5MUNYWHg0?=
 =?utf-8?B?eXdmZGhBQUpjajRXc3EwTkF4S3BleHNHdytvUWg3R29rbUF1VkpSRHB2WURz?=
 =?utf-8?B?czE3dWZFYW02L0ZJYjBYRWFOYmlZR2VTaFFtV3lyNnZvSGpQSFJWVFJJa0Z2?=
 =?utf-8?B?SnF6aGg3VmFnOVNrMDhubWVKOTRwRlpmQmRoNVVYMGxVWHZ5RmJIWjIxNGZW?=
 =?utf-8?B?UjFoVGZiKzhNbklucHh5U3lHSmlKZS9LdDdDd1FueHoyTyszY3pUb0JxQ1pS?=
 =?utf-8?B?WWErdnV6OVdGTHZwdlVEYzU1d0kvbXFjOGR1N0pHZWpwTzJrWVRvUklRek13?=
 =?utf-8?B?NjBzUW1sZHNaRm5NaTRhdXFINmtTRzN3ZmxkR3Y3b0xFZjFNMlNKUENrYi8y?=
 =?utf-8?B?TGxUMGRCRC9kVVhEYlE2TFF1cmp2cnh5NW9CVzZuNXpsalh6RzljR2tIc1Bi?=
 =?utf-8?B?YTc1Y1J4Q2ZBQ1B4SzhvRHVCM1ZJTEs2NHFXaGdDVndPVFBWTFpBWkJpRVVl?=
 =?utf-8?B?RVUxRVV4NUxFU0lRaG5wZXY4Vjg1UlJCcnhVS3R2eHZPUHUwRUQyVUpicUkw?=
 =?utf-8?B?cWdpSjluK0xmb0lkM0NvVFBFRHlBYnEyc2t3cmpaRkdwRjV2SVgwUnB3MFNw?=
 =?utf-8?B?ZWVrck5SU1QzQmFHcTdYNVR5VkZKRkw4U0FteEdXZC9tVEE4WE5aRGhTVXVo?=
 =?utf-8?B?SlFqK3g2L2R2MkFXSUplS3ZVTFJIdUxVZk1VdVl0QVA2WVVZTFhkR1FqaEJN?=
 =?utf-8?B?aVRJTFFvZ3c2aFp3Q3VMVUk2YWlWZ2VWL21sWkJKcHZMa1kwRlNtMDErdmpv?=
 =?utf-8?B?M3BCb1ZYMExVeUphcXZwSFRieVd5ZEtvTzdDa0lxdHlyalFZZVpEU2F2VjYx?=
 =?utf-8?B?ZkJiVi9EbFltOURpRWsreHIyUWR3djdmZE1mRzYxblRBdWdiQVRVck1UdWRS?=
 =?utf-8?B?T3UxTjU0Z0cvZGZBeEpEdFpvU3ovaDZLSWUyem1FeEpWRFd4L3RWeWtKNjZp?=
 =?utf-8?B?QTJZckNLQjc3dUhWckJ4cG9LMWhHa3FGRVQzQWtqSmN6TGRpK0RNa1FhbzVP?=
 =?utf-8?B?c1ZDMWRFL1pOSmw0VVZRL1cySzZsY1dUUHVUTmd0NTJmYVdFQjVDU3VIYWxj?=
 =?utf-8?B?KzNkUGNvYXV2R05tbFJOTm1mOUY5RUkvdzdsNDBMblc4YktNWTNvbDBRK1pr?=
 =?utf-8?B?eWUydFE5cFhSWFR0bFRjb1hKOVVBR1dub3B1cWZjeHNoMWtKWFYyWjhXY01o?=
 =?utf-8?B?ZXdqZjhjaG1mQVFxb2psZXovWUpnMXB2NXp6VGNFanFuWkl4MWhwME0xeFl0?=
 =?utf-8?Q?wQU/Dw1Mk5j59mI274=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16338fce-8c3e-413d-969e-08d8c9fab846
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 17:23:14.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3fewijp3/mpeJddqCQQnBObH/K60E5S2EJs8ZBCLdvzPrFiEe6nMXd+nve0VEOfOBwe/kf6UB6LkcztEOiOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMDUsIDIwMjEgNTo1NCBBTQ0K
PiBUbzogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IENjOiBYaW9uZywgSmlhbnhp
biA8amlhbnhpbi54aW9uZ0BpbnRlbC5jb20+OyBZaXNoYWkgSGFkYXMgPHlpc2hhaWhAbnZpZGlh
LmNvbT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgbGludXgtcmRtYSA8bGlu
dXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnPjsgSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlk
aWEuY29tPjsgRWR3YXJkIFNyb3VqaSA8ZWR3YXJkc0BudmlkaWEuY29tPjsgRW1pbCBWZWxpa292
DQo+IDxlbWlsLmwudmVsaWtvdkBnbWFpbC5jb20+OyBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFt
YXpvbi5jb20+OyBkcmktZGV2ZWwgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBE
b3VnIExlZGZvcmQNCj4gPGRsZWRmb3JkQHJlZGhhdC5jb20+OyBBbGkgQWxudWJhbmkgPGFsaWFs
bnVAbnZpZGlhLmNvbT47IFZldHRlciwgRGFuaWVsIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT47
IENocmlzdGlhbiBLb2VuaWcNCj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCByZG1hLWNvcmUgdjIgMy8zXSBjb25maWd1cmU6IEFkZCBjaGVjayBmb3Ig
dGhlIHByZXNlbmNlIG9mIERSTSBoZWFkZXJzDQo+IA0KPiBPbiBGcmksIEZlYiA1LCAyMDIxIGF0
IDI6MjIgUE0gSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IHdyb3RlOg0KPiA+DQo+ID4g
T24gVGh1LCBGZWIgMDQsIDIwMjEgYXQgMDQ6Mjk6MTRQTSAtMDgwMCwgSmlhbnhpbiBYaW9uZyB3
cm90ZToNCj4gPiA+IENvbXBpbGF0aW9uIG9mIHB5dmVyYnMvZG1hYnVmX2FsbG9jLmMgZGVwZW5k
cyBvbiBhIGZldyBEUk0gaGVhZGVycw0KPiA+ID4gdGhhdCBhcmUgaW5zdGFsbGVkIGJ5IGVpdGhl
ciB0aGUga2VybmVsLWhlYWRlciBvciB0aGUgbGliZHJtIHBhY2thZ2UuDQo+ID4gPiBUaGUgaW5z
dGFsbGF0aW9uIGlzIG9wdGlvbmFsIGFuZCB0aGUgbG9jYXRpb24gaXMgbm90IHVuaXF1ZS4NCj4g
PiA+DQo+ID4gPiBDaGVjayB0aGUgcHJlc2VuY2Ugb2YgdGhlIGhlYWRlcnMgYXQgYm90aCB0aGUg
c3RhbmRhcmQgbG9jYXRpb25zIGFuZA0KPiA+ID4gYW55IGxvY2F0aW9uIGRlZmluZWQgYnkgY3Vz
dG9tIGxpYmRybSBpbnN0YWxsYXRpb24uIElmIHRoZSBoZWFkZXJzDQo+ID4gPiBhcmUgbWlzc2lu
ZywgdGhlIGRtYWJ1ZiBhbGxvY2F0aW9uIHJvdXRpbmVzIGFyZSByZXBsYWNlZCBieSBzdHVicw0K
PiA+ID4gdGhhdCByZXR1cm4gc3VpdGFibGUgZXJyb3IgdG8gYWxsb3cgdGhlIHJlbGF0ZWQgdGVz
dHMgdG8gc2tpcC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFueGluIFhpb25nIDxq
aWFueGluLnhpb25nQGludGVsLmNvbT4NCj4gPiA+ICBDTWFrZUxpc3RzLnR4dCAgICAgICAgICAg
ICAgfCAxNSArKysrKysrKysrKysrKysNCj4gPiA+ICBweXZlcmJzL0NNYWtlTGlzdHMudHh0ICAg
ICAgfCAxNCArKysrKysrKysrKystLQ0KPiA+ID4gIHB5dmVyYnMvZG1hYnVmX2FsbG9jLmMgICAg
ICB8ICA4ICsrKystLS0tDQo+ID4gPiAgcHl2ZXJicy9kbWFidWZfYWxsb2Nfc3R1Yi5jIHwgMzkN
Cj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkgIGNyZWF0ZSBt
b2RlDQo+ID4gPiAxMDA2NDQgcHl2ZXJicy9kbWFidWZfYWxsb2Nfc3R1Yi5jDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL0NNYWtlTGlzdHMudHh0IGIvQ01ha2VMaXN0cy50eHQgaW5kZXggNDEx
MzQyMy4uOTVhZWMxMQ0KPiA+ID4gMTAwNjQ0DQo+ID4gPiArKysgYi9DTWFrZUxpc3RzLnR4dA0K
PiA+ID4gQEAgLTUxNSw2ICs1MTUsMjEgQEAgZmluZF9wYWNrYWdlKFN5c3RlbWQpDQo+ID4gPiAg
aW5jbHVkZV9kaXJlY3Rvcmllcygke1NZU1RFTURfSU5DTFVERV9ESVJTfSkNCj4gPiA+ICBSRE1B
X0RvRml4dXAoIiR7U1lTVEVNRF9GT1VORH0iICJzeXN0ZW1kL3NkLWRhZW1vbi5oIikNCj4gPiA+
DQo+ID4gPiArIyBkcm0gaGVhZGVycw0KPiA+ID4gKw0KPiA+ID4gKyMgRmlyc3QgY2hlY2sgdGhl
IHN0YW5kYXJkIGxvY2F0aW9ucy4gVGhlIGhlYWRlcnMgY291bGQgaGF2ZSBiZWVuDQo+ID4gPiAr
aW5zdGFsbGVkICMgYnkgZWl0aGVyIHRoZSBrZXJubGUtaGVhZGVycyBwYWNrYWdlIG9yIHRoZSBs
aWJkcm0gcGFja2FnZS4NCj4gPiA+ICtmaW5kX3BhdGgoRFJNX0lOQ0xVREVfRElSUyAiZHJtLmgi
IFBBVEhfU1VGRklYRVMgImRybSIgImxpYmRybSIpDQo+ID4NCj4gPiBJcyB0aGVyZSBhIHJlYXNv
biBub3QgdG8ganVzdCBhbHdheXMgY2FsbCBwa2dfY2hlY2tfbW9kdWxlcz8NCj4gDQo+IE5vdGUg
dGhhdCB0aGUgZ3B1LXNwZWNpZmljIGxpYnJhcmllcyBhcmUgc3BsaXQgb3V0LCBzbyBJJ2QgYWxz
byBjaGVjayBmb3IgdGhvc2UganVzdCB0byBiZSBzdXJlIC0gSSBkb24ndCBrbm93IHdoZXRoZXIg
YWxsIGRpc3Ryb3MgcGFja2FnZSB0aGUNCj4gdWFwaSBoZWFkZXJzIGNvbnNpc3RlbnRseSBpbiBs
aWJkcm0gb3Igc29tZXRpbWVzIGFsc28gaW4gb25lIG9mIHRoZSBsaWJkcm0tJHZlbmRvciBwYWNr
YWdlcy4NCg0KVGhlIGhlYWRlcnMgY29tZSBmcm9tIHRoZSBsaWJkcm0tZGV2ZWwgcGFja2FnZSwg
d2hpY2ggcHJlc2VudCBpdHNlbGYgYXMgImxpYmRybSIgDQp1bmRlciBwa2ctY29uZmlnLiBUaGUg
Z3B1LXNwZWNpZmljIHBhY2thZ2VzIG9ubHkgaW5jbHVkZSB0aGUgbGlicmFyaWVzLCBub3QgdGhl
IGhlYWRlcnMuDQoNClRoZSBrZXJuZWwtaGVhZGVycyBwYWNrYWdlcyBkb2Vzbid0IGhhdmUgcGtn
LWNvbmZpZyBpbmZvIGFuZCBjYW4ndCBiZSBjaGVja2VkIHZpYSBwa2dfY2hlY2tfbW9kdWxlcygp
Lg0KDQpPbmUgY2hhbmdlIEkgY2FuIG1ha2UgaGVyZSBpcyB0byB1c2UgZmluZF9wYXRoKCkgb25s
eSBmb3IgdGhlIGhlYWRlcnMgaW5zdGFsbGVkIGJ5IHRoZQ0Ka2VybmVsLWhlYWRlcnMgcGFja2Fn
ZSAodGhlICJkcm0iIHBhdGgpLiBUaGUgImxpYmRybSIgcGF0aCBpcyBjb3ZlcmVkIGJ5IHRoZSBw
a2dfY2hlY2tfbW9kdWxlcygpIGNoZWNrIGFueXdheS4NCg0KPiAtRGFuaWVsDQo+IA0KPiA+DQo+
ID4gPiArIyBUaGVuIGNoZWNrIGN1c3RvbSBpbnN0YWxsYXRpb24gb2YgbGliZHJtIGlmIChOT1QN
Cj4gPiA+ICtEUk1fSU5DTFVERV9ESVJTKQ0KPiA+ID4gKyAgcGtnX2NoZWNrX21vZHVsZXMoRFJN
IGxpYmRybSkNCj4gPiA+ICtlbmRpZigpDQo+ID4gPiArDQo+ID4gPiAraWYgKERSTV9JTkNMVURF
X0RJUlMpDQo+ID4gPiArICBpbmNsdWRlX2RpcmVjdG9yaWVzKCR7RFJNX0lOQ0xVREVfRElSU30p
DQo+ID4gPiArZW5kaWYoKQ0KPiA+DQo+ID4gVGhpcyBuZWVkcyBhIGh1bmsgYXQgdGhlIGVuZDoN
Cj4gPg0KPiA+IGlmIChOT1QgRFJNX0lOQ0xVREVfRElSUykNCj4gPiAgIG1lc3NhZ2UoU1RBVFVT
ICIgRE1BQlVGIE5PVCBzdXBwb3J0ZWQgKGRpc2FibGluZyBzb21lIHRlc3RzKSIpDQo+ID4gZW5k
aWYoKQ0KDQpUaGFua3MsIG1pc3NlZCB0aGF0Lg0KDQo+ID4NCj4gPiA+ICAjLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ID4gICMgQXBwbHkgZml4dXBzDQo+ID4gPg0KPiA+ID4gZGlmZiAt
LWdpdCBhL3B5dmVyYnMvQ01ha2VMaXN0cy50eHQgYi9weXZlcmJzL0NNYWtlTGlzdHMudHh0IGlu
ZGV4DQo+ID4gPiA2ZmQ3NjI1Li45MjIyNTNmIDEwMDY0NA0KPiA+ID4gKysrIGIvcHl2ZXJicy9D
TWFrZUxpc3RzLnR4dA0KPiA+ID4gQEAgLTEzLDggKzEzLDYgQEAgcmRtYV9jeXRob25fbW9kdWxl
KHB5dmVyYnMgIiINCj4gPiA+ICAgIGNtaWQucHl4DQo+ID4gPiAgICBjcS5weXgNCj4gPiA+ICAg
IGRldmljZS5weXgNCj4gPiA+IC0gIGRtYWJ1Zi5weXgNCj4gPiA+IC0gIGRtYWJ1Zl9hbGxvYy5j
DQo+ID4gPiAgICBlbnVtcy5weXgNCj4gPiA+ICAgIG1lbV9hbGxvYy5weXgNCj4gPiA+ICAgIG1y
LnB5eA0KPiA+ID4gQEAgLTI1LDYgKzIzLDE4IEBAIHJkbWFfY3l0aG9uX21vZHVsZShweXZlcmJz
ICIiDQo+ID4gPiAgICB4cmNkLnB5eA0KPiA+ID4gICkNCj4gPiA+DQo+ID4gPiAraWYgKERSTV9J
TkNMVURFX0RJUlMpDQo+ID4gPiArcmRtYV9jeXRob25fbW9kdWxlKHB5dmVyYnMgIiINCj4gPiA+
ICsgIGRtYWJ1Zi5weXgNCj4gPiA+ICsgIGRtYWJ1Zl9hbGxvYy5jDQo+ID4gPiArKQ0KPiA+ID4g
K2Vsc2UoKQ0KPiA+ID4gK3JkbWFfY3l0aG9uX21vZHVsZShweXZlcmJzICIiDQo+ID4gPiArICBk
bWFidWYucHl4DQo+ID4gPiArICBkbWFidWZfYWxsb2Nfc3R1Yi5jDQo+ID4gPiArKQ0KPiA+ID4g
K2VuZGlmKCkNCj4gPg0KPiA+IExpa2UgdGhpczoNCj4gPg0KPiA+IGlmIChEUk1fSU5DTFVERV9E
SVJTKQ0KPiA+ICAgc2V0KERNQUJVRl9BTExPQyBkbWFidWZfYWxsb2MuYykNCj4gPiBlbHNlKCkN
Cj4gPiAgIHNldChETUFCVUZfQUxMT0MgZG1hYnVmX2FsbG9jX3N0YnViLmMpDQo+ID4gZW5kaWYo
KQ0KPiA+IHJkbWFfY3l0aG9uX21vZHVsZShweXZlcmJzICIiDQo+ID4gICBkbWFidWYucHl4DQo+
ID4gICAkKERNQUJVRl9BTExPQykNCj4gPiApDQoNClN1cmUsIHdpbGwgY2hhbmdlLg0KDQo+ID4N
Cj4gPiBKYXNvbg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+ID4gZHJpLWRldmVsIG1haWxpbmcgbGlzdA0KPiA+IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbA0KPiANCj4gDQo+IA0KPiAtLQ0KPiBEYW5pZWwgVmV0dGVyDQo+
IFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbg0KPiBodHRwOi8vYmxvZy5mZnds
bC5jaA0K
