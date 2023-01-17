Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0E670A7A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjAQWAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 17:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjAQV7R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 16:59:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A33B0C4
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673987273; x=1705523273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=587qPNhFs0LdkUmWgdeisZb2IZs8z/EqNORFiWgg2WE=;
  b=JkJdTGp8KBR/n9kez2Tub0ebLBqgf7mf7Ngy8iEgCarV45v4L3zo+bmV
   CZL8TTFTkUBeesNYk4XyyahcBEDmtpQSxPbaBxBRB6yus6KaHV4B0ocEP
   DcEnlMX/eQUjiieujtB77TfKSkEU6K4g1zrwDFjVg2+iCszWD5ojkOacl
   qtJRB5/si+dczMtY0vcYzEOU55JbYjQehzPUSIqkhCdVjZtLRlnSeFLFs
   CmKNoqIHLgdnjcCPZ1e1uKrNSxQcsBccdQbhrpbX/qBsRWdwTpOFVUMgj
   rqpCoHeK4k9Zsv6Vd+ikFXN84lifyJzRfOh6T20t2ZxwDR5BCpINjkP0t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326883605"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326883605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 12:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="833300566"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833300566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2023 12:27:51 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 12:27:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 12:27:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 12:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYT+V39KqX+HFoVl/lAxTLzjrrbP1DfyrA57ck0o2DYnZazNPXGWteAIrPT+3ATI/SnG3GTdJzcNRCCjuFKHVQCsYSOH1kclfx5yRJtv4lyULBHhNJfKq2mc1HlR7JnYWtRsF+2DKDfqk3JCtofnC5WIfkApV9aTliUZx7/HkcHGgDcCVRdcEwmgv1UfcH+UVPwyvSJu782r0kNJQAMxmQa5JGKViDjvxIWKMBLsSwmUoM+azm4KQIkcNKAx0JR1vhHIaqMWumSdOH1ut4ukH4txeUQpKCdrzSqsGpiDQBXjNWpD5WfRm/SqSZhPRo6LDBTeR8V/x4k6/7CT7+gqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHdYNYYVdzO5Zq2JEokRASLnXSvE1e4USU9cw5B2Vr8=;
 b=g092kM1qtnt2uHDIBH9t+t71L08TUPlQl/32xLqoyoJ4C/FrnyFPpgp7B0BWRajKQ6LC6+6Y0fE3S9Sbk45UOCz4ooawNzMY1wXpTLnlFEk0+XS6fNZ96jKJ76ZMC+s4/W2O/cHPAKV6UmSTGmuKv09xFXx6veKL3XKRmzTCr2Vhq2jOMcskJDwkqMCWugvDstCppskbMqR/Z2nAo+b3QPXYYNJSwzyRh/Vsprds9CkSD17OFxQ6Zszs4a0WfXj0opVd3c8IzfGK9GBcfyIdehX/prU9imkM9t+eXsxS5iHMi0tPU7ksKMLnYtptVj7mmw6ZZLgsl5abbKxQHsGLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:27:49 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 20:27:49 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Hefty, Sean" <sean.hefty@intel.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJCAAATrgIAcjKoAgAA+ygCAJXODQIAASCMAglozZJCAC6bcAIBmzhEQgAAFmQCABflH4A==
Date:   Tue, 17 Jan 2023 20:27:49 +0000
Message-ID: <MWHPR11MB0029A8CA81DAB3E79F393FC1E9C69@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20211014233644.GA2744544@nvidia.com>
 <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
 <Y2uu4HfKADHiCzGx@nvidia.com>
 <MWHPR11MB002952D469591FEF43EBC6F6E9C29@MWHPR11MB0029.namprd11.prod.outlook.com>
 <Y8HwxFUb3/NWE1xE@nvidia.com>
In-Reply-To: <Y8HwxFUb3/NWE1xE@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|SJ2PR11MB7428:EE_
x-ms-office365-filtering-correlation-id: 0c015070-a194-4d38-55c0-08daf8c94d56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hOiOAJac2XDMtb9aiKlZR/PuaQjAQB2EPbIcm377iE4m2cwE9CMNPKjbThwVSODQ3SOLxYB00CeYyDgQpoO+O/xCKDRuqn0soSi7V4044kYuqGo8D1z4Li/uay39PHzvjA3q5olx53w6EfwCj5nstTPdRO2e+3CkKzEJmb5MS8ZLHCCzPt9u1MzMnYvVIakoA05++QPstarVw/cu/psJFaEf+SMi4tjtWSKgLiPBB9u+gu2471D8RBD8u6b8il1lb82rQH7nEGf6KUq9Bm8hqowbffuFSbeWSNcXKaKIgY04SlLTjgLmIMe7+GbpT/jjiRnfod75a4yo05OttL1UbP0u+N/jSZ1IC6emJEEnCbrN1ELaGUAm+/gQ9zV+jhHuwGotUCypdxfetHaDCaanAkzfw7U6L2ICFqIUoMaQL6n0Qmjf0W8a3XOi5mdUhhu6a778GfkIKlNxV0e05puxecfYkNA3VKQtW3AZH2Ct6qBys/dop1EWCj1D/gehm1/wBgEPnpPd/fhz2jFK8MWuQiD8WlPerMUBdiedLJjAY6fqm1fv8mAMWHqoDWhqpa7LgJlY5XhpJBl5WLyd/zShM4+7o/UAxmKL5bX1sxG7vraINPCuv1EtFFSM2SgCNum4aS6snXzunic7LVjBidH0NtYy7khzeewIpgayDHs08/amCQBReOUDL1D6p9E0HcJSBaoQ2tcDSNtLDlFDF8OFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(26005)(186003)(478600001)(9686003)(6506007)(7696005)(71200400001)(33656002)(66946007)(76116006)(66476007)(54906003)(316002)(64756008)(8676002)(4326008)(66446008)(6916009)(83380400001)(41300700001)(8936002)(52536014)(122000001)(55016003)(2906002)(66556008)(38070700005)(38100700002)(5660300002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fyeR3QHkIvgg5JKIPn8V1DN053pQ7kQNhhscXRHHWR0rtFkpAyFCR/KsZ1se?=
 =?us-ascii?Q?xC/bOtIOLw7xU+ZanlhbT0wRDU4p5gEJKL87Ssj6r9dsNmPJXXIQQCHDbqYL?=
 =?us-ascii?Q?oOTJpXRcZppmYpaxkyJexgzYRx7G6urHZxah6whJ9M67qfPHuatEMqG52jli?=
 =?us-ascii?Q?H5p08Z/WQYy/FvNUbn8yjJpAQevMbfThIGmFOLGNKXsWtsqCG33pMoN/Wb7y?=
 =?us-ascii?Q?BeD9P1lYbOTt79xZCUSbRLFYT7M1B+zh/1hDZemPlg2QZriCihxeFWrvjt9z?=
 =?us-ascii?Q?9BbEn3wSeJ6NxFm1c/WNLFP1kGa7nLbhd1POYHZMbLFEABv2RIVNRSqtBuh8?=
 =?us-ascii?Q?E358t+R4OTQJj5/aWmE37kkAHwy8/g6HIJj1nMMO/FtmuUBk4N7RGsHxPjoQ?=
 =?us-ascii?Q?udG177y6oFipyjJLGdwEzwzuJoeoAe4c+FDtrobeAmmSIe16i2UzidTI1wZh?=
 =?us-ascii?Q?Igb+QpKyzAt174ElzXxqNGxlfDSCUgYlQBK64KNr4frB4gLzzN4VNbtQ1m8P?=
 =?us-ascii?Q?kunKzM4WNbWARZpUfj503YJjTuCPghtc6l9oL638ZzmsJMNjOgaA5xn6qGSG?=
 =?us-ascii?Q?v4tVXT0hS8vN2FL+EVZeGfwP1RK1J3BpwZOCutsvzTGiIEa2Ej/gt+8uOa7T?=
 =?us-ascii?Q?XySY4gGgz+SCDarX+PF0Z4bWNmqSZPjkGhL3xI6GkiJXCh5ogzLtoU5JBcm6?=
 =?us-ascii?Q?ycl7lcyOGL4J682jPj9Lx1+U1qnRuW4iCvwdxv7eFPoCHOrWOcancvbm/nmZ?=
 =?us-ascii?Q?b/yeVvS+ls/HCnowtM4+GC2wNid9hPiE4q2qO69G5UfKvzV+I0oRWZmoQxFa?=
 =?us-ascii?Q?1Z3RRMpZa8ythFdQFAcY6XVJBRjj624NWrnT3kEw7wFrQUqIRfBFG5g4cYzW?=
 =?us-ascii?Q?Yvrj3kD/qK6nxNjCgbD1H32PRomizNipG433685QhnPr5W9wb8nq9eUtk8QY?=
 =?us-ascii?Q?1CVM0FoZUj6Z2exXUmQbArT8UzpEWQxc4iv/UuFxNfEFr0VR+cVw84gv0r/c?=
 =?us-ascii?Q?z6Cmzb0Yc//KMByhcfVn80b2/KYzvhlwVM+FPFGgaXogQEIXNfMrGtruqeRo?=
 =?us-ascii?Q?uFNf8TfIJJeTyaopyttDh0UtZ49gkIbqEtXCxCVQOJWybie5b6dMSsOYtHOW?=
 =?us-ascii?Q?1vGzcEczQk01nt5xsthAWTS7MKVV8dZEOadRAiSxD9ctq1jYfaAE/fVVDB1T?=
 =?us-ascii?Q?6rzr0z1sOyPi8ASa/vo2CvG94QnQopRz/JmpFAn6P28wYgQvYkxeEbDW34MF?=
 =?us-ascii?Q?wlQL2TWvYPtQ0yJp9xNkAdohqh3k0f/uTk88D/HpFrHuY2A8fI6P9UqO9qIm?=
 =?us-ascii?Q?QopeA4y36iCWCdkHPJpfW5usCqM3/v877QTmSJ3Ar8MVGU/y9YJN2+54kJsD?=
 =?us-ascii?Q?Qk8Gn3C1hLBhA80+ueoggtEjIU8ORsUz6HGK0esYqfcMIwCQf1t8T1uQIBhD?=
 =?us-ascii?Q?MIjfQTt2syn4l8lZZMXoNJveeuA4EwX9YUbTs7CZvvu8SJW8FfGj7hl/rvN1?=
 =?us-ascii?Q?2v0ay5mej41G9VT2KuqFuYlrjCcilwPFXipNwoQVqEkLHoIpk3JgB9U57EuH?=
 =?us-ascii?Q?fZtYDCX8CTee71U9wpHo4y0LIzu8kXg0oo6ShNrX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c015070-a194-4d38-55c0-08daf8c94d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 20:27:49.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLIpR06zwgB89QnRTciQ4GOyJLbYUrswJwT49PUqaXZngVzX/TegdS4IeLNduVDkAgrn5HpkwPjgBNH9p1x3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot=
 rules
>=20
> On Fri, Jan 13, 2023 at 11:57:33PM +0000, Saleem, Shiraz wrote:
> > > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to
> > > kernel-boot rules
> > >
> > > On Wed, Nov 02, 2022 at 04:40:20PM +0000, Nikolova, Tatyana E wrote:
> > > > Hi Jason,
> > > >
> > > > I know it has been a while since we discussed this. Based on your
> > > > feedback, we
> > > are proposing another solution for the irdma kernel-boot rules.
> > > Could you please review it?
> > > >
> > > > > > udevadm info --attribute-walk
> > > > > > /sys/class/infiniband/rocep47s0f0
> > > > > >
> > > > > >   looking at device
> > > > > '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/rocep47=
s0f0':
> > > > >
> > > > > This looks like the problem. For any of this to work the
> > > > > infiniband device needs to be parented to the aux device, not the=
 PCI
> device.
> > > > >
> > > > > mlx5 did not due this for backwards compat reasons, but this is
> > > > > a new driver so it could do it properly.
> > > > >
> >
> > Hi Jason - This also impacts us in terms of backwards compatibility.
>=20
> This is a new driver, it by definition does not have backwards compatabil=
ity.

irdma replaces i40iw (to support x722) which has been there for many years.=
 irdma has been in the kernel since 5.14.
So we have similar concerns about compatibility.

If we are going with such a sysfs update for the ib_device, is it not bette=
r it is done across all vendor drivers using auxiliary bus similar to the r=
estructuring for sysfs HW counters?

For consistency within the subsystem and it could enable a wider ecosystem =
adoption.

>=20
> What you are talking about is drop in compatability against mlx5 which is=
 a very
> different thing.
>=20
> > There are current applications/customers who are looking at
> > "'/sys/class/infiniband/<ib_device>/device/" for sysfs attributes like
> > numa_node, local_cpus etc. under the PCI device.
>=20
> That is just wrong assumptions for how sysfs is structured, sadly.
>=20
> > i.e. assuming the PCI device is ib device parent.
> >
> > With parent change to auxiliary device, they won't be able find these
> > attributes and potentially resort to default configurations that are
> > sub-optimal.
>=20
> Introducing new stuff often comes with an ecosystem upgrade as well..
>=20
> Jason
