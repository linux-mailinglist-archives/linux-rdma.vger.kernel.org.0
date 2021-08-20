Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5252E3F3625
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 23:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhHTVrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 17:47:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:7747 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhHTVrA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 17:47:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="216573516"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="216573516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 14:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="425156081"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2021 14:46:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 14:46:21 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 14:46:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 20 Aug 2021 14:46:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 20 Aug 2021 14:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyjseOGAUwt2EB1b+ynN4ws5NtHPM8Xi0KNL3Heeq37jOCwdGWv+lZ6Y6e50EsjUQVByMzaq1/5kzht95NZT40Xqfw/FUhBHXdDF5fMqRpZALaTJuvaC3sofsk/ejgT1Uj/wIGDOzYdbooCHfANMI6PbP7bji28uyFQiNkJPXm4kaSMmTjsUmwrHlvD9z326VFO3hF/b3YN+ZSsox7nx5gCGhaMdjXNbiybvVd1zjxWoirxqRNXzAgaDrB7KsecudaLZpLpqTihghPxvAwVLJ+QEtnCC2YzUPZqa1OU1QfAolpTVFktE083GcvSxi9Q+uGWoC5dr/UJEXSQqi+s/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPcQb0cBD0ivLh647NJiMhsIUvm+Y6FRS5vkM8KpqsA=;
 b=bSIEDGGydPQRvVIv6rEC7cL9GH7WqU3ZdttGHZ8Tz3Ygo9wCo+XwbsAx4DIRoTR/D71xuK2fhyH/1CFbUQ267hZAhEBvbuHdpO40v8Ko86TymqM1KORWVWC8dyi1id3JSYub3kupqncmc43Mh6I2BxYE900jXgkYnq0LfOc9SnjuBc5Q19mP0hTbYonyR00gDiCGmHH5kzVcJAxM54p3jO1Z+RgXNP1vndSADRT0uMxofkpaWamYm8pz2FCAy93q3fKXxGapfbENACAo+W1F/OMO48qzYRSI/h5e5xj7kLVIqtYdwzfzjEyguGixiYp3G9AIkIFaUVeZ3o7HbQA4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPcQb0cBD0ivLh647NJiMhsIUvm+Y6FRS5vkM8KpqsA=;
 b=ye5rINLLzPg51sb8tLA0bzZP+QLXfFCRdZfB1JcdCRXvpbeVwWP/lGimTAr+TGVY9NugvscX9BK0UjUyFLXH9y2g/RLrJKQEPK/Guc498v/385zElbDSXJVt1lRAwQ/ba9UPina+c0aAu2JtQxVUwnWS5cnr03FlwX08MLkXjz4=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB2859.namprd11.prod.outlook.com (2603:10b6:5:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 20 Aug
 2021 21:46:19 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c%3]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 21:46:19 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Thread-Topic: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Thread-Index: AQHXiuy2O6WjqvACUkanT+uendkIz6tmy/YAgAnA3ACACP5dgIADdu4Q
Date:   Fri, 20 Aug 2021 21:46:19 +0000
Message-ID: <DM6PR11MB469202DCC6359485037E02FFCBC19@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210806175808.1463-1-tatyana.e.nikolova@intel.com>
 <20210806182852.GS1721383@nvidia.com>
 <DM6PR11MB4692C424F3B5AB513B0EBBDACBF99@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210818164557.GB5673@nvidia.com>
In-Reply-To: <20210818164557.GB5673@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4199670-8414-4085-ac31-08d96423f1f3
x-ms-traffictypediagnostic: DM6PR11MB2859:
x-microsoft-antispam-prvs: <DM6PR11MB28595A56B984489AFDFAEE63CBC19@DM6PR11MB2859.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QibtZ6jDcUtv8jy/SWUhKWyKeL9/EX0kyuXOuoXl3fn/Xk4cRaFxHzZR28RjrkpXyDeQCKucK+PLOZ/FcpP9oLkyzaT3RG2xsRDv7TWWAlKyft66CY3iJ76Bk6o/EPp6/PoqIQ5k4BG0tU4qZjsp/X6OOlTedMbexQP/tH+JGrjAOxEgCVTNmfkxEZxyfgJwZFIowmlyQpkcszzU/W69sa8BPUQbUBv9oqCemcZyXXQ5wgRDF1SemkbY0UtfemAa31j5cdfKmOZiE8HQtK0RAG2342k0sCKI9ZPa7he/3r9QUEkxWC7AFxBjutgibiebfgs0u/9n6MFH/67FUELu9hgTv09RB9gJ+DrjaXuWkuyeX/uzuYUxcwWiAT9WJnpHTPKdhzTm/ArZDYRX7+rtnAbHVRjTqldp2SYeSk6jmDoU2zwGE8X7JxXjElBRW+B0QkU3Q+KkwYWNo6yFAEbKhZedT1QOKkhYeKtbENW+pzyEi2Oc30v6jvgYT3JvPxz8rd8S34wrmecznk4VcMS+7VCePI2NUTZOIiY1eA4bz1D9YYvIDF6bcJwxKnlzPVTtGCCpCT/bkUglkDRX5l6kkrXXZQ7AFZ6E1RPpMH32QUjbgcikMXf0ENHz5OnnQxlaR+Gsmas6W8vUQk4f0vTBHRURHwHH9sGsU9oQiVjEbIKkih5g+I336dUcUmACWv86
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(71200400001)(66476007)(66946007)(38100700002)(7696005)(2906002)(38070700005)(316002)(8676002)(64756008)(8936002)(186003)(86362001)(122000001)(76116006)(478600001)(5660300002)(4326008)(6916009)(52536014)(53546011)(55016002)(66556008)(66446008)(54906003)(9686003)(33656002)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LfYDFH1jIHQFLeBErawAJ4tS4J2DRuL/4S4jQL3NvDRulQYbZ2snTpZT1stO?=
 =?us-ascii?Q?gW0u5/Vn8ijWs2JdOpOTFhQSQgdh7zL9okQt0Lcnx+m5zsHQ8bmiyQdER6QF?=
 =?us-ascii?Q?3VfYwkRJ3lRF+S7+5zY+EHUMqPPUfQGyDA3bVfGYYk15f9x7TlT6AtmbZqIL?=
 =?us-ascii?Q?goj8m8EEUe+tGztcqHwDQ3/SgHwHUmRPJXAmEoGX0KVSPEwrSw4XRBrsnc9i?=
 =?us-ascii?Q?czw1i0WjFLMdpj1s4ocdwFlhpbdNKwKkoR1zx9NkaAOEe9b/2huFyORxo4Dz?=
 =?us-ascii?Q?vjexvphFhVYhXa5IVjlFc/aXxn9r7CeYjI7fHu8QJmqX2FQF3hcuvwnAe5fv?=
 =?us-ascii?Q?OIlAMwktxRdfCN+/gzCb6sthdM5WXGphEVlonAmhNaZQIHYX40zUbF7jmwyq?=
 =?us-ascii?Q?WjElJbN57dht0yWEsc6Kt61Xgmlm+2ChmDma16EyH/qNVuS9/Bq3gAvia17P?=
 =?us-ascii?Q?TMTE6OY0QkGppzPqeB9UuejxZeJTuDbswoJqIqty7Lccc6N4avKSvdS25c6z?=
 =?us-ascii?Q?vY8qkuFozvXkiPZoDdvvtdm6JMq7DPjAemMWgP3CCVGSlFExaENX2WoecAER?=
 =?us-ascii?Q?xgBOYf2ADkofJgf4hnVCQlz2xH7xSNOG4KtqNnJD+IDgEh9VO3qlib+NAxgO?=
 =?us-ascii?Q?mWgBMty4NITXL9eKiZRaFI7NzHFleK/tPJnFjq24Mp422C4aA0JxMbHQg02U?=
 =?us-ascii?Q?/rgFwP11QrggF8zLY0XNF82PpPLefNRUPIoM9EFrY0Gx2uV2S38oyaTskEOc?=
 =?us-ascii?Q?X6L0RVYqaB9Y+g/UX7/E4tbveD68LR0bYPFad+2Jm9pBj4fXSgc2NDngz7MX?=
 =?us-ascii?Q?8q4l9GzlFK/QIKo4YZg3ZHmbTlXhv5T5O2ZsFkc2MXd9CNmbC049MP6z9UP2?=
 =?us-ascii?Q?wGvvbBgZ3HIal7dDRN2P90nV0bWMspLcW76CPSpPsAsTgD0X8jwgSKa36VA6?=
 =?us-ascii?Q?ekA6NxXu1siqejmBDmyhCPZp+sF2lz+0UUDJ+hN++wf2Abl5Ht1BJ6Gjo97J?=
 =?us-ascii?Q?dH96Eg0jEY2A2fUMzZeQrG0Aht3ZAHmxR85ChytTF470uvHZ4eAIJ5UhZCsT?=
 =?us-ascii?Q?/5tomJ3lxPBzsJ6LUrrt5qrxo4PKIRaBjE2AngFGQXVuzevqXdGG2YsNJaIJ?=
 =?us-ascii?Q?nRXHqcCT+MYic787Iru+SR3L+8fCjYiJhbGMdKoozR2EiNc/e0OxYjrDCtwh?=
 =?us-ascii?Q?Jm7Cipg61ylGRlCD//YhyM3fwMYzeuQP26fsbMxGJOVQd2XvxsDOEIWh4ubf?=
 =?us-ascii?Q?V/+nFRnTSJiaUQwgl+QZ+QSMaBIk1bR6DPWYcN9VsbUntd6xHAmP7wNFg6Q4?=
 =?us-ascii?Q?BLtVO+S+as3rxT7IeQGR/sYQQuD8KjbUyJqKgJmjoPwlG601UXrANTGbKGD/?=
 =?us-ascii?Q?oXhL/w90ieR77mkyU5zpaHD+iiq5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4199670-8414-4085-ac31-08d96423f1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 21:46:19.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3vU4/n2YbJCYDtuZvpYSk1MKe9anfYOcpKEviNGFnhtN1AhvUZEDu/82KhG7sAG4ufWZzsy1U0Bi4M5xcHF51i6uj1yrh0yjwzgNWiYmsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2859
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 18, 2021 11:46 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH] irdma: Add ice and irdma to kernel-boot rules
>=20
> On Thu, Aug 12, 2021 at 11:33:04PM +0000, Nikolova, Tatyana E wrote:
> > > > @@ -12,6 +12,7 @@ ENV{ID_NET_DRIVER}=3D=3D"bnxt_en",
> > > RUN{builtin}+=3D"kmod load bnxt_re"
> > > >  ENV{ID_NET_DRIVER}=3D=3D"cxgb4", RUN{builtin}+=3D"kmod load iw_cxg=
b4"
> > > >  ENV{ID_NET_DRIVER}=3D=3D"hns", RUN{builtin}+=3D"kmod load hns_roce=
"
> > > >  ENV{ID_NET_DRIVER}=3D=3D"i40e", RUN{builtin}+=3D"kmod load i40iw"
> > > > +ENV{ID_NET_DRIVER}=3D=3D"ice", RUN{builtin}+=3D"kmod load irdma"
> > >
> > > This should not be needed, right? The auxbux stuff triggers proper
> > > module autoloading?
> >
> > Hi Jason,
> >
> > Our module depends on the auxbus, but we don't know how the auxbus
> > could trigger loading of irdma. Could you please explain?
>=20
> It should simply happen automatically once the aux device is created. If =
it
> doesn't something is missing in the kernel.
>=20
> It works the same way as any loading a module for any other struct device=
,
> the aux device exposes a modalias and the userspace matches it to the
> modules.alias file and then loads the specified module.

Thank you for the explanation. The modalias is exposed by the aux device as=
 you described.

Tatyana
