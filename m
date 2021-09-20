Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D173412700
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbhITTqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 15:46:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:38024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346526AbhITTou (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 15:44:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="245632917"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="245632917"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 12:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="435641297"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2021 12:41:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 12:41:26 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 12:41:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 20 Sep 2021 12:41:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 20 Sep 2021 12:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E93ezgFULA7dP69RXPNecBlakx2k9qFGSUnJO7PSgKjgkeZ88xSkG0ic1S9/gsGShVmcjT7koHi+u/g2ci6Kh9t8tlwOcQtQotw3MZAECC0Zbgej7uTvgx5LT9PhuRxHoNGBcMHnQLGhn6DL1suHBqGz7/B2pmsFr5W6kmWaX+H0mMOzdBwPVasa0EBfAGtSWh7wVOECK0gi7174zYpbhXC+LOoAd8mM0xNJ1G2+MrdFj5yzBWPKK2L4k05Q4PIwR98K2rfWpJSs4aFVrOXlboK4qo07Y8WdcpzC7XxzpQkVYV0rhzkRfLOvhCfunLbJKzxSMCynUYgqMnPuSgQRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sWAOLC94xYBiowMx2a8AcozXaRQ2gOEXsp6xJIkpGBI=;
 b=Ucmx69XxwfQLdHuENfd3jmuw8P1pC5bMyNh4wzG9b+BWbryH1Xc93CvAVQaPyjZ5VRHg1pGZmaozQWoY6Cg8TWu/nyBy42RQ4qftHHKsKAaNVNka4hyN7VKer3C1BLjWy5FbOwikeUO3nQt0usoSw80+RLcCaxY8EmzMBUoBRAekTf28H4sbmvmT5bPwbZ7igDWS6IRH2MdVGVIAvD0cBAllQjDTTM9uPIfvKlMNKx21Ya81tGuzVLdty+jNp5sNYU76mlcsJ8OiY6HxWBn8qlh++nigpUoBloWFqerba9gd+60PQpSIeyhmGkZrpSNWUPosAH8mc4N5gwlORdiLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWAOLC94xYBiowMx2a8AcozXaRQ2gOEXsp6xJIkpGBI=;
 b=twGneGyKk1TH2S3j4Bt3Eko6yL7oBpq9IXkf0h2UCVgYuoD8aQsti3ScyJJP4Oz+sDw0FRl4zb+1GaNKKaCkyaJhCOry9ddI5dC9fn+XIeOlSgOD1vMYphOVa4commdrGElnn5TMirzmIf13a+2wb1nKUz0wL9I5A9mk3Ob7478=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB3596.namprd11.prod.outlook.com (2603:10b6:5:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 19:41:21 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::98ba:804c:acaa:a049]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::98ba:804c:acaa:a049%3]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 19:41:21 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJCAAATrgIAcjKoA
Date:   Mon, 20 Sep 2021 19:41:21 +0000
Message-ID: <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
In-Reply-To: <20210902154003.GW1721383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 856474c8-97d5-43a1-e40f-08d97c6e9fb6
x-ms-traffictypediagnostic: DM6PR11MB3596:
x-microsoft-antispam-prvs: <DM6PR11MB3596D4912E0B591CD3BF9FBDCBA09@DM6PR11MB3596.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iT097R3/umNgDl+ET3z9660nAH7AR7bR0QiTFHYIjEak9Gtlid2l98YBNzFiy/vTpmow8+lR1iOQYQ43mduik1dCURIGwo7CcPTu+6TOZ4XMUdue+MzLRT2KaxN2j5nhf27CFzAZ834D/fjGYOVVLXi2QHlPQ4h/PUS5xOkHiAbcE/mkq2ZGL4Fg4FuvRZJzHv30IBLZJ2HILvpT6o28fWaqAZcSmk/6TOwjnf0KcUmmPorgo8abiZI+RioJR/6rd7427H5QR2pm5l1Q0Dvhz325FkgcuRv8wgK033w/Hw4VgAnY2+G+dmMhJrONs3lR5urRCOiZ0QEHPsVvmq8lkEFnnx0FVLRI7JDVgi+eLcRzzgE9eogOi7w0l3XomMZeizkYzXPL4B2xhw3TYjaVSskd3yD3RzNUXLW/naPFSC6RzVMNSB6xhVGLlz4LIG7MaI8kPVacC+g11UBaPEoB5mMowPIlv7Cx1mzWh2PAuxQUDDugYIUpmdSOiFUSA7UNCMDHWX3vZTvk3jZG9UxblcfVtsXDfx/21Iy7If3ttb3Ks0LwLBgN0LjLCpSF2d0mYn2n29codj4F2517MU3Y3jyArR1MjuK60c6qXkZXbfDQ1BNNAK+lUfVwW9zo3sKrCZbf9EYDiMc3lmSxRg5QHoITT1YXmuD4uiFh8SUWDYbzqoWHh0mG1ylOwIiIESLHkWnUY+nbI/LZF1SqIM+jiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(8936002)(38070700005)(316002)(83380400001)(478600001)(186003)(8676002)(122000001)(4326008)(6916009)(54906003)(9686003)(26005)(33656002)(53546011)(52536014)(66946007)(2906002)(6506007)(66556008)(64756008)(38100700002)(66476007)(71200400001)(7696005)(86362001)(5660300002)(76116006)(66446008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qEHaCyB9tj4cPypLj9SfPbwPWe77kfbmDx9jVnYU852LjOCDtR0+I9LYAJXH?=
 =?us-ascii?Q?3VnraiMyso4KkXjypFKcOXusVC+LiUgkjS/TxTjJrzojn32N7VMO5pP4fRQC?=
 =?us-ascii?Q?kigccXmaD02fWQ7pbyiblmNe2kbVMzQmUq5QjelJEA9xJFsTTrBaknAh5A4O?=
 =?us-ascii?Q?VI3Zsw7R5xcAoeMvo96PepyAO5Mqoa3q0lqGD87a9K/CcUem6HWbLAUCwAfx?=
 =?us-ascii?Q?mO5LTjDsZbdiaUa9KmgyMctIjwuVJ+QDT2XOaXBu7HtXSwK5JQITMPP3eLq4?=
 =?us-ascii?Q?5u2U+8Qy8gcl8uqeSD+chde5WCIrby+nMzD/y05WQZLpLAY3+uSE6A3LeMYs?=
 =?us-ascii?Q?Y6P79UJCnQ0Pv/qh8rxUPM8DaKqBZkZHe4cgIlfU6Kht/0pKY43SVkJcxA2J?=
 =?us-ascii?Q?L0Z7fFLvI9NMj8M7pwSrK1UoVXFvH2TXTMahMUL0L7vdG2cxWyG6CVIR4ymP?=
 =?us-ascii?Q?803REulv+HjlKMfyKPV63qLz6JJInIN0o4Mht+AFUMJ4SAznC/g3YeNLJHfA?=
 =?us-ascii?Q?XgEW/rmIHmtDAusjfFzomg1VRaV/GYnE9W91qFB8YPOC0PUtOXUCWou+Qmwr?=
 =?us-ascii?Q?m7JUdJy8ja4xTuN3KiYs0u49wKa8HOD4u6zBrcoyPPrhcBUpeprYfVHBTBbb?=
 =?us-ascii?Q?3TmWC535xhWn+rtVv521LMoehdmppoowVwDovvJsk47I8EBIwQUOxdxYUQG9?=
 =?us-ascii?Q?q43cDlXsT9OXlYH8qCpzpLWL9xIfJBExlZw0VJIc6ECBqQv6kJPjE3jmfm4A?=
 =?us-ascii?Q?kosmgo8KH3AMqbUV0yGzGW8JPUcrqjDotpkqSj4yB5lFYnrPHwWXA2GLeYgc?=
 =?us-ascii?Q?ERCvgV7dKkX7vBXhSinmdnWDXdlJE0JaU3LxZwahsgwJLw2Ej92IxvfDtdXW?=
 =?us-ascii?Q?CU9w/YDYASCstSPDcy0HLAPMoysc3WybhPQjQ3LXbQYlY65QCO9SobMYimT5?=
 =?us-ascii?Q?/K2QvaF1oDJ5QA5Bg5lSIJqzWGkkyZCg6Uj7w5k8/YbajzLu2YLde+0ngJVe?=
 =?us-ascii?Q?simZaAuNy2CzcNymNbQH90yl4tnLtbMd0+gEhV1wZbtbfND8m8E1JGFEMaVH?=
 =?us-ascii?Q?yyBlPdm9QkUpj06K/lxWBVkBSFLbV5tC/Owfb3C0wXeAgtt4u6SkteoMCmmA?=
 =?us-ascii?Q?IKSerLlklaPunjGbsDSqsBbYYgKnUFWcBUbUnRfO/vUJo5+zPjPVUMfT0kxY?=
 =?us-ascii?Q?MwwcO8inJrn7KZ3bywOWZCXXz6OJdD/Zdy8dPY+DRj8K367aQMBsDwANhJeF?=
 =?us-ascii?Q?EDh2WABbzHQSIJL8mjxX0ZcXza4zzW1qcbRtOoJ0XG31w5QYFm9IlXqUfTyS?=
 =?us-ascii?Q?rq5kTGjs/Ubkqke6GNv4Mdlf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856474c8-97d5-43a1-e40f-08d97c6e9fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 19:41:21.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7KW1HXLW7pw5ZsoCfR1HcgaImSiXVL4P1noD3rj8xoNxLLxNhZWp40DDeNfHD2J50tSFFOU+yhyneAByx5HYAMIXEYYrMuuP24gk4DvibM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3596
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 2, 2021 10:40 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> rules
>=20
> On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> > > Given that ice is both iwarp and roce, is there some better way to
> > > detect this? Doesn't the aux device encode it?
> >
> > Hi Jason,
> >
> > We tried a few experiments without success. The auxiliary devices
> > alias with our driver and not ice, so maybe this is the reason?
> >
> > Here is an example of what we tried.
> >
> > udevadm info
> > /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DRIVER=3Dirdma
> > E: MODALIAS=3Dauxiliary:ice.roce
> > E: SUBSYSTEM=3Dauxiliary
> >
> > udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DRIVER=3Dirdma
> > E: MODALIAS=3Dauxiliary:ice.roce
> > E: SUBSYSTEM=3Dauxiliary
> >
> > Given the udevadm output, we put the following line in the udev rdma-
> description.rules:
> >
> > SUBSYSTEMS=3D=3D"auxiliary",
> DEVPATH=3D=3D"*/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0/*=
",
> ENV{ID_RDMA_ROCE}=3D"1"
>=20
> What is the SUBSYSTEM=3D=3D"infiniband" device like?
>=20
> This seems like the right direction, you need to wrangle udev though..
>=20

Hi Jason,

After more research and given the udevadm output, we revised the irdma udev=
 rule to make it work. Could you please review the patch bellow?

diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-descript=
ion.rules
index 48a7cede..09deb451 100644
--- a/kernel-boot/rdma-description.rules
+++ b/kernel-boot/rdma-description.rules
@@ -1,7 +1,7 @@
 # This is a version of net-description.rules for /sys/class/infiniband dev=
ices
=20
 ACTION=3D=3D"remove", GOTO=3D"rdma_description_end"
-SUBSYSTEM!=3D"infiniband", GOTO=3D"rdma_description_end"
+SUBSYSTEM!=3D"infiniband", GOTO=3D"rdma_infiniband_end"
=20
 # NOTE: DRIVERS searches up the sysfs path to find the driver that is boun=
d to  # the PCI/etc device that the RDMA device is linked to. This is not t=
he kernel @@ -40,4 +40,9 @@ DEVPATH=3D=3D"*/infiniband/rxe*", ATTR{parent}=
=3D=3D"*", ENV{ID_RDMA_ROCE}=3D"1"
 SUBSYSTEMS=3D=3D"pci", ENV{ID_BUS}=3D"pci", ENV{ID_VENDOR_ID}=3D"$attr{ven=
dor}", ENV{ID_MODEL_ID}=3D"$attr{device}"
 SUBSYSTEMS=3D=3D"pci", IMPORT{builtin}=3D"hwdb --subsystem=3Dpci"
=20
+LABEL=3D"rdma_infiniband_end"
+
+SUBSYSTEM!=3D"auxiliary", GOTO=3D"rdma_description_end"
+KERNEL=3D=3D"ice.iwarp.?", ENV{ID_RDMA_IWARP}=3D"1"=20
+KERNEL=3D=3D"ice.roce.?", ENV{ID_RDMA_ROCE}=3D"1"
 LABEL=3D"rdma_description_end"

Thank you,
Tatyana
