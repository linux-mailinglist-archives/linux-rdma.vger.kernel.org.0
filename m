Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18DC3DAD60
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhG2UUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 16:20:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:46049 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhG2UUT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 16:20:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="209859432"
X-IronPort-AV: E=Sophos;i="5.84,279,1620716400"; 
   d="scan'208";a="209859432"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 13:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,279,1620716400"; 
   d="scan'208";a="666734059"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2021 13:20:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 13:20:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 29 Jul 2021 13:20:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 29 Jul 2021 13:20:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFh8kBIFwQFiYDoufeBI0ZIs73NNWPYTxhaZf2JwcjBLJYzagTyxSk2AF2igklkBZf+W+jAwIRkn4XkCeJOxpyMcuSbZmrILk/mz54I1r40Vr38nXWzNRV+NFHZP6T2TfvrXzC36s4qV6lZHWTzDFjACZRMtrYV1aD5I0Vcsnboj8p3s3RhO0a3APNPe6M9xJ+UAMfeMMyq5p44UgbHb0rgHle0jexWE6WrPMH6RgNLipLkgJ/PjiR5mrq+xhgWQ1md0doZxEP0PHUKVDz1Nz7vl8dCrmQsuIcwiLld0nj5CdkG0iqsMQNgf3Nd7fNzTh1UmlEtOGge2Gb7+lpOhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJCb1PlXKi8BFZGx/oyoZR6QpUoedJervuk1bwURlgg=;
 b=N78uC9CpJRmy/g4dmKWqpvksHzP24+hRfdfc9gaES/V7XA89KYq5hlj2LPo0mo36Q3Qxvfg9oEbSV2GT/BGmx38XoaGcbtQvabjL6T2gPx5PnBkNSaiASiaVoCc+M1NiR5C1B1PqVYaETM2OyXt5tl3r0OKY4D5rffNhex7JdvBEwr3QgnWE2DJhfgzYyI5W6191OZ6M5AfHosf8DIEF0iFZvoC7HC4Fg/wcUBsqQzRaeVsae9sFh2um3fs2oPXEVnWjJQdaMPHIrZd4QIf4/1vR8RafAeqYg812aWcTddw0X0NLFzCLfaeaSkC3/BQhcwqB1CMbj3xfYklO2N8/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJCb1PlXKi8BFZGx/oyoZR6QpUoedJervuk1bwURlgg=;
 b=NantuIepQr9TmJWysuvfBn+i5+JjOlVEI1rzlxe54fsC9clqDDQxy3uKQZLYgFzdslePTUKmy6gHPjHN9koomeS4QVFHiip/5E7poxaBeAJmBorrt33wTc9P19xsWaGeaAgt4R4EFoTRcuYLD6Q7zf3FG8GYfuStUYThDwviegs=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM4PR11MB5471.namprd11.prod.outlook.com (2603:10b6:5:39d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 20:20:10 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b528:9dc5:64b6:d69]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b528:9dc5:64b6:d69%5]) with mapi id 15.20.4373.020; Thu, 29 Jul 2021
 20:20:10 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@cornelisnetworks.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: RE: [PATCH rdma-next v1 8/9] RDMA: Globally allocate and release QP
 memory
Thread-Topic: [PATCH rdma-next v1 8/9] RDMA: Globally allocate and release QP
 memory
Thread-Index: AQHXf7eowNS7iVsuPkqt1zRSUKhpTKtabZCQ
Date:   Thu, 29 Jul 2021 20:20:10 +0000
Message-ID: <DM6PR11MB4692A02D96DB65FA5378130ACBEB9@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <cover.1627040189.git.leonro@nvidia.com>
 <48e767124758aeecc433360ddd85eaa6325b34d9.1627040189.git.leonro@nvidia.com>
In-Reply-To: <48e767124758aeecc433360ddd85eaa6325b34d9.1627040189.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9db8bb4b-c3b9-461e-fadc-08d952ce43fa
x-ms-traffictypediagnostic: DM4PR11MB5471:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5471AD0EB09AE8EB5FEE15BACBEB9@DM4PR11MB5471.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+arJjI7ZS4dBF7SOCeu8ltVj2AEuO8jVo5qQK5kIvm4m4SJhvHGwUx3t0w2JJ4xAOpCjPthG7f05aG8IDtyb1UWItDaYhDPMhQ1vCl9BFy7JrxRJGtm8PEoz6K0aPpqnZdZz87AApy046caD2gukHa3kuVmQaxOwX+WWcBXNCuuxp4/wxLZqWBpuMUFq9gV82IqdWX779y3e2aOC427f3WV+kSMRZZFhdeI12HTjmrRRqG0WUtCynXK2RwWy9uFq9kxX5YVnm6LQZchwPAqwbZF+Dgepanjg0RTFuXaTIxrZWFjN0UP1sRBksnzZIr+lr1qf/yiC6FR38RJRn/FYTrSwMu9UVij/aqY4X6sFp+M/lfqhueN5Tq++GIRZsX2cAnDVRMNuzyXTc93yDq0eSF4/473MplGFLLwe4Cxo+aYt4b9hT0298eIcSmoD3spgiXY0MiEzXCg0WP1K9IFpz/gWd65Cke7jsLKtLxHxS299Yw1CmPA6L7KIL6w6GokSikOhBYpA66GWdOIunUWuPWpJjbX5you2G8Q7y7xMu8+UruPVemTa1J3b5pwNlnA95BsyK9nRGCPCUqsM85StvkJEFA6RENQnJlZ7//8JNdK+/Re7V9TlRhJvZT3dOUzxDB/dWDu8GCGrJVxNQMSK+l1zUAWoMnFFWfUy7TjlHgVQefsBRyk9iyHVpSqaraFpuV1FIlOP7JHpXwLf9TToA/JVWVYqew/i3QbBKejdoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(4326008)(38070700005)(33656002)(186003)(7416002)(52536014)(86362001)(30864003)(316002)(122000001)(38100700002)(9686003)(26005)(66476007)(55016002)(8676002)(54906003)(110136005)(66446008)(8936002)(2906002)(6506007)(64756008)(71200400001)(53546011)(76116006)(66556008)(83380400001)(5660300002)(7696005)(478600001)(66946007)(569008)(579004)(559001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qwklOfCsjzUUphSW/YdFiawq+Avj0q3+nl9zZXjUSYHkfHgofaFvnEUEhGKh?=
 =?us-ascii?Q?7bnz5TIVw4P8CwyzaZBzR/Kuvkx4VRgrxRdkOhvNDVd5uqdx1o0L0XgVyd0I?=
 =?us-ascii?Q?oVjVQ1gmh9eDi3vvzookyiZ9UVKYQf2MD6sZJOJ4h2sQ75G1PCUgzGeJ6mOL?=
 =?us-ascii?Q?JW3D1R9yX6E3Un0cVSJb+h1drgK/sTw6S1HQW5Yajr94PUg4K/ARS7IYufb4?=
 =?us-ascii?Q?BY6oR6zIn1Xr1wfZYDRDn0M9BhhluIfm0EmpJIEhfWPDcBrSp0HeXeaFg8oe?=
 =?us-ascii?Q?pleYdq7zlHi0dGeaVe7XiaUZHewIWk+i8GGR7FVPGiTMu/v+AmJKQFs6FSFC?=
 =?us-ascii?Q?VteNa7rZiMzxY/Yltf0Pb5MszV7CZZXCqA6yX/83liiHuMno7FpUvDtwBo0R?=
 =?us-ascii?Q?D0CPqnGp6YeC/4h09Mj1pC3/jYademy/4R1XYU6i5o1uIWe1eWd8y+hSJU9Q?=
 =?us-ascii?Q?e3aE9BeXnZtRs83td6cxBiyELGB+Ii+VcYxmmjz26t2cZ0lEab6NQiEqbgBK?=
 =?us-ascii?Q?s8m9PZ4kwdIR3FYV0sju2EzeKh77GYa3S/IsAerWVgxRMd6IqNxJtNlbIjiy?=
 =?us-ascii?Q?PAZj8z/3REMIrqA+D/Sy1iDeGjM9kyTkW1ifgTSjIvBApD/2W45GWj7eDypa?=
 =?us-ascii?Q?LvhVYaysI7Nhzku7WNE6SX5JdXwj6+CqWyVrKRvY4NM17ADQcttd8p9/xGca?=
 =?us-ascii?Q?vqcevX72ZTRJa/m9TqAAg8jIbtSzuOLl/l7G2bVQ+q+WAKM2ZhTwRRe6iVJl?=
 =?us-ascii?Q?pgW9NeXSpzNBlhoTKFvKSTMWj9VUQ8rzdO3PlVYcnGtis1SMKgeQ2TEeVZKZ?=
 =?us-ascii?Q?zmqkMGlTpTNeUlvtUMLoAqkNm7rN42uJwVcSQmMuSUZiBBn8OS5JZKFEgBE3?=
 =?us-ascii?Q?97jRyL9kKVn+ZIS/1fgScu+7S6s6IVdI81IkukkSQRTTP0zhVINhXqsBcaQO?=
 =?us-ascii?Q?tVarbKkfw3KNmt0+aLdzyy7DBgH2Vx00/VoHpDocG31Pw9YEkLkrmrotwMK1?=
 =?us-ascii?Q?QATCGAmBrC8qMDpMjPClgNtOsf8fFccrLOcvsgau9iyiFvS0hM7ChbTT3FOw?=
 =?us-ascii?Q?xiu+UfF1vpeo+MaKPEQfVliaAMxJA/Oy3ZO3qLZvuLRBBG3SJjI3rgtAMtp3?=
 =?us-ascii?Q?a7gcCaORfaT1SlA8a7xMVnJ2b5KcKJ1eETjBnWAqWipmkUsW5RE/NV4i6FVi?=
 =?us-ascii?Q?Kz4I7gVCrCzTYqg7NdEIqWULb5nnYNvbEX5kQn1lxS/TVr8ehQydxPTaDsq5?=
 =?us-ascii?Q?Vmq2OUuXp6TSUBm17GgYsySJlicG/sj/PpIfkN3DDq0UQXqWg82DN9Wn9vi+?=
 =?us-ascii?Q?RQYocEybM4to6vzcy99QNPrZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db8bb4b-c3b9-461e-fadc-08d952ce43fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 20:20:10.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCC+N0N1jfpEklVO0lwtv7zbGMV4fYHudarIY7ZwOgrsx9lxag2rJyVyknZd1Gf+DT0JOpFSB/tapgyXuLFlXrIaokPA7fNbcczdc+M36Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5471
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, July 23, 2021 6:40 AM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>; Adit Ranadive
> <aditr@vmware.com>; Ariel Elior <aelior@marvell.com>; Bernard Metzler
> <bmt@zurich.ibm.com>; Christian Benvenuti <benve@cisco.com>; Dennis
> Dalessandro <dennis.dalessandro@cornelisnetworks.com>; Gal Pressman
> <galpress@amazon.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Michal Kalderon <mkalderon@marvell.com>; Mike
> Marciniszyn <mike.marciniszyn@cornelisnetworks.com>; Ismail, Mustafa
> <mustafa.ismail@intel.com>; Naresh Kumar PBS
> <nareshkumar.pbs@broadcom.com>; Nelson Escobar
> <neescoba@cisco.com>; Potnuri Bharat Teja <bharat@chelsio.com>; Selvin
> Xavier <selvin.xavier@broadcom.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Steve Wise <larrystevenwise@gmail.com>;
> VMware PV-Drivers <pv-drivers@vmware.com>; Weihang Li
> <liweihang@huawei.com>; Wenpeng Liang <liangwenpeng@huawei.com>;
> Yishai Hadas <yishaih@nvidia.com>; Zhu Yanjun <zyjzyj2000@gmail.com>
> Subject: [PATCH rdma-next v1 8/9] RDMA: Globally allocate and release QP
> memory
>=20
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Convert QP object to follow IB/core general allocation scheme.
> That change allows us to make sure that restrack properly kref
> the memory.
>=20
> Reviewed-by: Gal Pressman <galpress@amazon.com> #efa
> Tested-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Dennis Dalessandro
> <dennis.dalessandro@cornelisnetworks.com> #rdma and core
> Tested-by: Dennis Dalessandro
> <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com

Hi Leon,

I tested your changes with the irdma driver.

Tested-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>



> ---
>  drivers/infiniband/core/core_priv.h           | 28 ++++--
>  drivers/infiniband/core/device.c              |  2 +
>  drivers/infiniband/core/restrack.c            |  2 +-
>  drivers/infiniband/core/verbs.c               | 40 ++++----
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 26 ++----
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  7 +-
>  drivers/infiniband/hw/bnxt_re/main.c          |  1 +
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  5 +-
>  drivers/infiniband/hw/cxgb4/provider.c        |  1 +
>  drivers/infiniband/hw/cxgb4/qp.c              | 37 +++-----
>  drivers/infiniband/hw/efa/efa.h               |  5 +-
>  drivers/infiniband/hw/efa/efa_main.c          |  1 +
>  drivers/infiniband/hw/efa/efa_verbs.c         | 28 ++----
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  5 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c       | 28 ++----
>  drivers/infiniband/hw/irdma/utils.c           |  3 -
>  drivers/infiniband/hw/irdma/verbs.c           | 31 +++----
>  drivers/infiniband/hw/mlx4/main.c             |  1 +
>  drivers/infiniband/hw/mlx4/mlx4_ib.h          |  5 +-
>  drivers/infiniband/hw/mlx4/qp.c               | 25 ++---
>  drivers/infiniband/hw/mlx5/gsi.c              |  2 -
>  drivers/infiniband/hw/mlx5/main.c             |  1 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  5 +-
>  drivers/infiniband/hw/mlx5/qp.c               | 56 ++++--------
>  drivers/infiniband/hw/mthca/mthca_provider.c  | 77 ++++++----------
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 +
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 25 ++---
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  5 +-
>  drivers/infiniband/hw/qedr/main.c             |  1 +
>  drivers/infiniband/hw/qedr/qedr_roce_cm.c     | 13 ++-
>  drivers/infiniband/hw/qedr/qedr_roce_cm.h     |  5 +-
>  drivers/infiniband/hw/qedr/verbs.c            | 49 +++-------
>  drivers/infiniband/hw/qedr/verbs.h            |  4 +-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c   |  1 +
>  drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c | 34 +++----
>  drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h | 10 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 69 +++++++-------
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  5 +-
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  | 53 +++++------
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  5 +-
>  drivers/infiniband/sw/rdmavt/qp.c             | 91 +++++++------------
>  drivers/infiniband/sw/rdmavt/qp.h             |  5 +-
>  drivers/infiniband/sw/rdmavt/vt.c             |  9 ++
>  drivers/infiniband/sw/rxe/rxe_pool.c          |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c         | 48 +++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.h         |  2 +-
>  drivers/infiniband/sw/siw/siw_main.c          |  1 +
>  drivers/infiniband/sw/siw/siw_qp.c            |  2 -
>  drivers/infiniband/sw/siw/siw_verbs.c         | 54 +++++------
>  drivers/infiniband/sw/siw/siw_verbs.h         |  5 +-
>  include/rdma/ib_verbs.h                       | 30 +++++-
>  53 files changed, 404 insertions(+), 549 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/core_priv.h
> b/drivers/infiniband/core/core_priv.h
> index 647cca4e0240..fa2e0bbaf8c7 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -322,13 +322,14 @@ _ib_create_qp(struct ib_device *dev, struct ib_pd
> *pd,
>  	      struct ib_uqp_object *uobj, const char *caller)
>  {
>  	struct ib_qp *qp;
> +	int ret;
>=20
>  	if (!dev->ops.create_qp)
>  		return ERR_PTR(-EOPNOTSUPP);
>=20
> -	qp =3D dev->ops.create_qp(pd, attr, udata);
> -	if (IS_ERR(qp))
> -		return qp;
> +	qp =3D rdma_zalloc_drv_obj_numa(dev, ib_qp);
> +	if (!qp)
> +		return ERR_PTR(-ENOMEM);
>=20
>  	qp->device =3D dev;
>  	qp->pd =3D pd;
> @@ -337,14 +338,10 @@ _ib_create_qp(struct ib_device *dev, struct ib_pd
> *pd,
>=20
>  	qp->qp_type =3D attr->qp_type;
>  	qp->rwq_ind_tbl =3D attr->rwq_ind_tbl;
> -	qp->send_cq =3D attr->send_cq;
> -	qp->recv_cq =3D attr->recv_cq;
>  	qp->srq =3D attr->srq;
> -	qp->rwq_ind_tbl =3D attr->rwq_ind_tbl;
>  	qp->event_handler =3D attr->event_handler;
>  	qp->port =3D attr->port_num;
>=20
> -	atomic_set(&qp->usecnt, 0);
>  	spin_lock_init(&qp->mr_lock);
>  	INIT_LIST_HEAD(&qp->rdma_mrs);
>  	INIT_LIST_HEAD(&qp->sig_mrs);
> @@ -352,8 +349,25 @@ _ib_create_qp(struct ib_device *dev, struct ib_pd
> *pd,
>  	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
>  	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
>  	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
> +	ret =3D dev->ops.create_qp(qp, attr, udata);
> +	if (ret)
> +		goto err_create;
> +
> +	/*
> +	 * TODO: The mlx4 internally overwrites send_cq and recv_cq.
> +	 * Unfortunately, it is not an easy task to fix that driver.
> +	 */
> +	qp->send_cq =3D attr->send_cq;
> +	qp->recv_cq =3D attr->recv_cq;
> +
>  	rdma_restrack_add(&qp->res);
>  	return qp;
> +
> +err_create:
> +	rdma_restrack_put(&qp->res);
> +	kfree(qp);
> +	return ERR_PTR(ret);
> +
>  }
>=20
>  struct rdma_dev_addr;
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index 9056f48bdca6..f4814bb7f082 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2654,6 +2654,7 @@ void ib_set_device_ops(struct ib_device *dev,
> const struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, get_hw_stats);
>  	SET_DEVICE_OP(dev_ops, get_link_layer);
>  	SET_DEVICE_OP(dev_ops, get_netdev);
> +	SET_DEVICE_OP(dev_ops, get_numa_node);
>  	SET_DEVICE_OP(dev_ops, get_port_immutable);
>  	SET_DEVICE_OP(dev_ops, get_vector_affinity);
>  	SET_DEVICE_OP(dev_ops, get_vf_config);
> @@ -2710,6 +2711,7 @@ void ib_set_device_ops(struct ib_device *dev,
> const struct ib_device_ops *ops)
>  	SET_OBJ_SIZE(dev_ops, ib_cq);
>  	SET_OBJ_SIZE(dev_ops, ib_mw);
>  	SET_OBJ_SIZE(dev_ops, ib_pd);
> +	SET_OBJ_SIZE(dev_ops, ib_qp);
>  	SET_OBJ_SIZE(dev_ops, ib_rwq_ind_table);
>  	SET_OBJ_SIZE(dev_ops, ib_srq);
>  	SET_OBJ_SIZE(dev_ops, ib_ucontext);
> diff --git a/drivers/infiniband/core/restrack.c
> b/drivers/infiniband/core/restrack.c
> index 033207882c82..1f935d9f6178 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -343,7 +343,7 @@ void rdma_restrack_del(struct rdma_restrack_entry
> *res)
>  	rt =3D &dev->res[res->type];
>=20
>  	old =3D xa_erase(&rt->xa, res->id);
> -	if (res->type =3D=3D RDMA_RESTRACK_MR || res->type =3D=3D
> RDMA_RESTRACK_QP)
> +	if (res->type =3D=3D RDMA_RESTRACK_MR)
>  		return;
>  	WARN_ON(old !=3D res);
>=20
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c
> index 7036967e4c0b..a164609c2ee7 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1963,30 +1963,32 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct
> ib_udata *udata)
>  		rdma_rw_cleanup_mrs(qp);
>=20
>  	rdma_counter_unbind_qp(qp, true);
> -	rdma_restrack_del(&qp->res);
>  	ret =3D qp->device->ops.destroy_qp(qp, udata);
> -	if (!ret) {
> -		if (alt_path_sgid_attr)
> -			rdma_put_gid_attr(alt_path_sgid_attr);
> -		if (av_sgid_attr)
> -			rdma_put_gid_attr(av_sgid_attr);
> -		if (pd)
> -			atomic_dec(&pd->usecnt);
> -		if (scq)
> -			atomic_dec(&scq->usecnt);
> -		if (rcq)
> -			atomic_dec(&rcq->usecnt);
> -		if (srq)
> -			atomic_dec(&srq->usecnt);
> -		if (ind_tbl)
> -			atomic_dec(&ind_tbl->usecnt);
> -		if (sec)
> -			ib_destroy_qp_security_end(sec);
> -	} else {
> +	if (ret) {
>  		if (sec)
>  			ib_destroy_qp_security_abort(sec);
> +		return ret;
>  	}
>=20
> +	if (alt_path_sgid_attr)
> +		rdma_put_gid_attr(alt_path_sgid_attr);
> +	if (av_sgid_attr)
> +		rdma_put_gid_attr(av_sgid_attr);
> +	if (pd)
> +		atomic_dec(&pd->usecnt);
> +	if (scq)
> +		atomic_dec(&scq->usecnt);
> +	if (rcq)
> +		atomic_dec(&rcq->usecnt);
> +	if (srq)
> +		atomic_dec(&srq->usecnt);
> +	if (ind_tbl)
> +		atomic_dec(&ind_tbl->usecnt);
> +	if (sec)
> +		ib_destroy_qp_security_end(sec);
> +
> +	rdma_restrack_del(&qp->res);
> +	kfree(qp);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ib_destroy_qp_user);
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 283b6b81563c..634d1586a1fa 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -815,7 +815,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct
> ib_udata *udata)
>  	if (ib_qp->qp_type =3D=3D IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp) {
>  		rc =3D bnxt_re_destroy_gsi_sqp(qp);
>  		if (rc)
> -			goto sh_fail;
> +			return rc;
>  	}
>=20
>  	mutex_lock(&rdev->qp_lock);
> @@ -826,10 +826,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct
> ib_udata *udata)
>  	ib_umem_release(qp->rumem);
>  	ib_umem_release(qp->sumem);
>=20
> -	kfree(qp);
>  	return 0;
> -sh_fail:
> -	return rc;
>  }
>=20
>  static u8 __from_ib_qp_type(enum ib_qp_type type)
> @@ -1402,27 +1399,22 @@ static bool bnxt_re_test_qp_limits(struct
> bnxt_re_dev *rdev,
>  	return rc;
>  }
>=20
> -struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
> -				struct ib_qp_init_attr *qp_init_attr,
> -				struct ib_udata *udata)
> +int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr
> *qp_init_attr,
> +		      struct ib_udata *udata)
>  {
> +	struct ib_pd *ib_pd =3D ib_qp->pd;
>  	struct bnxt_re_pd *pd =3D container_of(ib_pd, struct bnxt_re_pd,
> ib_pd);
>  	struct bnxt_re_dev *rdev =3D pd->rdev;
>  	struct bnxt_qplib_dev_attr *dev_attr =3D &rdev->dev_attr;
> -	struct bnxt_re_qp *qp;
> +	struct bnxt_re_qp *qp =3D container_of(ib_qp, struct bnxt_re_qp,
> ib_qp);
>  	int rc;
>=20
>  	rc =3D bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
>  	if (!rc) {
>  		rc =3D -EINVAL;
> -		goto exit;
> +		goto fail;
>  	}
>=20
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		rc =3D -ENOMEM;
> -		goto exit;
> -	}
>  	qp->rdev =3D rdev;
>  	rc =3D bnxt_re_init_qp_attr(qp, pd, qp_init_attr, udata);
>  	if (rc)
> @@ -1465,16 +1457,14 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd
> *ib_pd,
>  	mutex_unlock(&rdev->qp_lock);
>  	atomic_inc(&rdev->qp_count);
>=20
> -	return &qp->ib_qp;
> +	return 0;
>  qp_destroy:
>  	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
>  free_umem:
>  	ib_umem_release(qp->rumem);
>  	ib_umem_release(qp->sumem);
>  fail:
> -	kfree(qp);
> -exit:
> -	return ERR_PTR(rc);
> +	return rc;
>  }
>=20
>  static u8 __from_ib_qp_state(enum ib_qp_state state)
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index d68671cc6173..b5c6e0f4f877 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -78,9 +78,9 @@ struct bnxt_re_srq {
>  };
>=20
>  struct bnxt_re_qp {
> +	struct ib_qp		ib_qp;
>  	struct list_head	list;
>  	struct bnxt_re_dev	*rdev;
> -	struct ib_qp		ib_qp;
>  	spinlock_t		sq_lock;	/* protect sq */
>  	spinlock_t		rq_lock;	/* protect rq */
>  	struct bnxt_qplib_qp	qplib_qp;
> @@ -179,9 +179,8 @@ int bnxt_re_query_srq(struct ib_srq *srq, struct
> ib_srq_attr *srq_attr);
>  int bnxt_re_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
>  int bnxt_re_post_srq_recv(struct ib_srq *srq, const struct ib_recv_wr
> *recv_wr,
>  			  const struct ib_recv_wr **bad_recv_wr);
> -struct ib_qp *bnxt_re_create_qp(struct ib_pd *pd,
> -				struct ib_qp_init_attr *qp_init_attr,
> -				struct ib_udata *udata);
> +int bnxt_re_create_qp(struct ib_qp *qp, struct ib_qp_init_attr
> *qp_init_attr,
> +		      struct ib_udata *udata);
>  int bnxt_re_modify_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
>  		      int qp_attr_mask, struct ib_udata *udata);
>  int bnxt_re_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c
> b/drivers/infiniband/hw/bnxt_re/main.c
> index d5674026512a..3edf66818e4b 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -709,6 +709,7 @@ static const struct ib_device_ops bnxt_re_dev_ops =3D
> {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, bnxt_re_cq, ib_cq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, bnxt_re_pd, ib_pd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, bnxt_re_qp, ib_qp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, bnxt_re_srq, ib_srq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, bnxt_re_ucontext, ib_uctx),
>  };
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index 3883af3d2312..6a2a415ec791 100644
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -989,9 +989,8 @@ int c4iw_destroy_srq(struct ib_srq *ib_srq, struct
> ib_udata *udata);
>  int c4iw_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *attrs,
>  		    struct ib_udata *udata);
>  int c4iw_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata);
> -struct ib_qp *c4iw_create_qp(struct ib_pd *pd,
> -			     struct ib_qp_init_attr *attrs,
> -			     struct ib_udata *udata);
> +int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
> +		   struct ib_udata *udata);
>  int c4iw_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  				 int attr_mask, struct ib_udata *udata);
>  int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c
> b/drivers/infiniband/hw/cxgb4/provider.c
> index 881d515eb15a..e7337662aff8 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -499,6 +499,7 @@ static const struct ib_device_ops c4iw_dev_ops =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_cq, c4iw_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_mw, c4iw_mw, ibmw),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, c4iw_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, c4iw_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, c4iw_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, c4iw_ucontext, ibucontext),
>  };
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c
> b/drivers/infiniband/hw/cxgb4/qp.c
> index a81fa7a56edb..d20b4ef2c853 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2103,16 +2103,15 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct
> ib_udata *udata)
>  		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx, !qhp->srq);
>=20
>  	c4iw_put_wr_wait(qhp->wr_waitp);
> -
> -	kfree(qhp);
>  	return 0;
>  }
>=20
> -struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr
> *attrs,
> -			     struct ib_udata *udata)
> +int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
> +		   struct ib_udata *udata)
>  {
> +	struct ib_pd *pd =3D qp->pd;
>  	struct c4iw_dev *rhp;
> -	struct c4iw_qp *qhp;
> +	struct c4iw_qp *qhp =3D to_c4iw_qp(qp);
>  	struct c4iw_pd *php;
>  	struct c4iw_cq *schp;
>  	struct c4iw_cq *rchp;
> @@ -2124,44 +2123,36 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd,
> struct ib_qp_init_attr *attrs,
>  	struct c4iw_mm_entry *sq_key_mm, *rq_key_mm =3D NULL,
> *sq_db_key_mm;
>  	struct c4iw_mm_entry *rq_db_key_mm =3D NULL,
> *ma_sync_key_mm =3D NULL;
>=20
> -	pr_debug("ib_pd %p\n", pd);
> -
>  	if (attrs->qp_type !=3D IB_QPT_RC || attrs->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	php =3D to_c4iw_pd(pd);
>  	rhp =3D php->rhp;
>  	schp =3D get_chp(rhp, ((struct c4iw_cq *)attrs->send_cq)->cq.cqid);
>  	rchp =3D get_chp(rhp, ((struct c4iw_cq *)attrs->recv_cq)->cq.cqid);
>  	if (!schp || !rchp)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>=20
>  	if (attrs->cap.max_inline_data > T4_MAX_SEND_INLINE)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>=20
>  	if (!attrs->srq) {
>  		if (attrs->cap.max_recv_wr > rhp-
> >rdev.hw_queue.t4_max_rq_size)
> -			return ERR_PTR(-E2BIG);
> +			return -E2BIG;
>  		rqsize =3D attrs->cap.max_recv_wr + 1;
>  		if (rqsize < 8)
>  			rqsize =3D 8;
>  	}
>=20
>  	if (attrs->cap.max_send_wr > rhp-
> >rdev.hw_queue.t4_max_sq_size)
> -		return ERR_PTR(-E2BIG);
> +		return -E2BIG;
>  	sqsize =3D attrs->cap.max_send_wr + 1;
>  	if (sqsize < 8)
>  		sqsize =3D 8;
>=20
> -	qhp =3D kzalloc(sizeof(*qhp), GFP_KERNEL);
> -	if (!qhp)
> -		return ERR_PTR(-ENOMEM);
> -
>  	qhp->wr_waitp =3D c4iw_alloc_wr_wait(GFP_KERNEL);
> -	if (!qhp->wr_waitp) {
> -		ret =3D -ENOMEM;
> -		goto err_free_qhp;
> -	}
> +	if (!qhp->wr_waitp)
> +		return -ENOMEM;
>=20
>  	qhp->wq.sq.size =3D sqsize;
>  	qhp->wq.sq.memsize =3D
> @@ -2339,7 +2330,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd,
> struct ib_qp_init_attr *attrs,
>  		 qhp->wq.sq.qid, qhp->wq.sq.size, qhp->wq.sq.memsize,
>  		 attrs->cap.max_send_wr, qhp->wq.rq.qid, qhp->wq.rq.size,
>  		 qhp->wq.rq.memsize, attrs->cap.max_recv_wr);
> -	return &qhp->ibqp;
> +	return 0;
>  err_free_ma_sync_key:
>  	kfree(ma_sync_key_mm);
>  err_free_rq_db_key:
> @@ -2359,9 +2350,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd,
> struct ib_qp_init_attr *attrs,
>  		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx, !attrs->srq);
>  err_free_wr_wait:
>  	c4iw_put_wr_wait(qhp->wr_waitp);
> -err_free_qhp:
> -	kfree(qhp);
> -	return ERR_PTR(ret);
> +	return ret;
>  }
>=20
>  int c4iw_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> diff --git a/drivers/infiniband/hw/efa/efa.h
> b/drivers/infiniband/hw/efa/efa.h
> index 2b8ca099b381..1a1e60eee1dc 100644
> --- a/drivers/infiniband/hw/efa/efa.h
> +++ b/drivers/infiniband/hw/efa/efa.h
> @@ -132,9 +132,8 @@ int efa_query_pkey(struct ib_device *ibdev, u32
> port, u16 index,
>  int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>  int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
> -struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> -			    struct ib_qp_init_attr *init_attr,
> -			    struct ib_udata *udata);
> +int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
> +		  struct ib_udata *udata);
>  int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>  int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr=
,
>  		  struct ib_udata *udata);
> diff --git a/drivers/infiniband/hw/efa/efa_main.c
> b/drivers/infiniband/hw/efa/efa_main.c
> index 203e6ddcacbc..997947d77de6 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -271,6 +271,7 @@ static const struct ib_device_ops efa_dev_ops =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, efa_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
>  };
>=20
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c
> b/drivers/infiniband/hw/efa/efa_verbs.c
> index b1c4780e86be..e5f9d90aad5e 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -450,7 +450,6 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  				qp->rq_size, DMA_TO_DEVICE);
>  	}
>=20
> -	kfree(qp);
>  	return 0;
>  }
>=20
> @@ -609,17 +608,16 @@ static int efa_qp_validate_attr(struct efa_dev
> *dev,
>  	return 0;
>  }
>=20
> -struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> -			    struct ib_qp_init_attr *init_attr,
> -			    struct ib_udata *udata)
> +int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
> +		  struct ib_udata *udata)
>  {
>  	struct efa_com_create_qp_params create_qp_params =3D {};
>  	struct efa_com_create_qp_result create_qp_resp;
> -	struct efa_dev *dev =3D to_edev(ibpd->device);
> +	struct efa_dev *dev =3D to_edev(ibqp->device);
>  	struct efa_ibv_create_qp_resp resp =3D {};
>  	struct efa_ibv_create_qp cmd =3D {};
> +	struct efa_qp *qp =3D to_eqp(ibqp);
>  	struct efa_ucontext *ucontext;
> -	struct efa_qp *qp;
>  	int err;
>=20
>  	ucontext =3D rdma_udata_to_drv_context(udata, struct efa_ucontext,
> @@ -664,14 +662,8 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  		goto err_out;
>  	}
>=20
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		err =3D -ENOMEM;
> -		goto err_out;
> -	}
> -
>  	create_qp_params.uarn =3D ucontext->uarn;
> -	create_qp_params.pd =3D to_epd(ibpd)->pdn;
> +	create_qp_params.pd =3D to_epd(ibqp->pd)->pdn;
>=20
>  	if (init_attr->qp_type =3D=3D IB_QPT_UD) {
>  		create_qp_params.qp_type =3D EFA_ADMIN_QP_TYPE_UD;
> @@ -682,7 +674,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  			  "Unsupported qp type %d driver qp type %d\n",
>  			  init_attr->qp_type, cmd.driver_qp_type);
>  		err =3D -EOPNOTSUPP;
> -		goto err_free_qp;
> +		goto err_out;
>  	}
>=20
>  	ibdev_dbg(&dev->ibdev, "Create QP: qp type %d driver qp type
> %#x\n",
> @@ -700,7 +692,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  						    qp->rq_size,
> DMA_TO_DEVICE);
>  		if (!qp->rq_cpu_addr) {
>  			err =3D -ENOMEM;
> -			goto err_free_qp;
> +			goto err_out;
>  		}
>=20
>  		ibdev_dbg(&dev->ibdev,
> @@ -746,7 +738,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>=20
>  	ibdev_dbg(&dev->ibdev, "Created qp[%d]\n", qp->ibqp.qp_num);
>=20
> -	return &qp->ibqp;
> +	return 0;
>=20
>  err_remove_mmap_entries:
>  	efa_qp_user_mmap_entries_remove(qp);
> @@ -756,11 +748,9 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  	if (qp->rq_size)
>  		efa_free_mapped(dev, qp->rq_cpu_addr, qp-
> >rq_dma_addr,
>  				qp->rq_size, DMA_TO_DEVICE);
> -err_free_qp:
> -	kfree(qp);
>  err_out:
>  	atomic64_inc(&dev->stats.create_qp_err);
> -	return ERR_PTR(err);
> +	return err;
>  }
>=20
>  static const struct {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h
> b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 991f65269fa6..0c3eb1163977 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -1216,9 +1216,8 @@ int hns_roce_destroy_srq(struct ib_srq *ibsrq,
> struct ib_udata *udata);
>  int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)=
;
>  int hns_roce_dealloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udat=
a);
>=20
> -struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
> -				 struct ib_qp_init_attr *init_attr,
> -				 struct ib_udata *udata);
> +int hns_roce_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr
> *init_attr,
> +		       struct ib_udata *udata);
>  int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		       int attr_mask, struct ib_udata *udata);
>  void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp
> *hr_qp);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c
> b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 078a97193f0e..23b88a5a372f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -454,6 +454,7 @@ static const struct ib_device_ops hns_roce_dev_ops
> =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, hns_roce_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, hns_roce_cq, ib_cq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, hns_roce_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, hns_roce_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, hns_roce_ucontext,
> ibucontext),
>  };
>=20
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c
> b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index c3e2fee16c0e..fd0f71acd470 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -959,8 +959,6 @@ static int set_qp_param(struct hns_roce_dev
> *hr_dev, struct hns_roce_qp *hr_qp,
>  	struct ib_device *ibdev =3D &hr_dev->ib_dev;
>  	int ret;
>=20
> -	hr_qp->ibqp.qp_type =3D init_attr->qp_type;
> -
>  	if (init_attr->cap.max_inline_data > hr_dev->caps.max_sq_inline)
>  		init_attr->cap.max_inline_data =3D hr_dev-
> >caps.max_sq_inline;
>=20
> @@ -1121,8 +1119,6 @@ void hns_roce_qp_destroy(struct hns_roce_dev
> *hr_dev, struct hns_roce_qp *hr_qp,
>  	free_qp_buf(hr_dev, hr_qp);
>  	free_kernel_wrid(hr_qp);
>  	free_qp_db(hr_dev, hr_qp, udata);
> -
> -	kfree(hr_qp);
>  }
>=20
>  static int check_qp_type(struct hns_roce_dev *hr_dev, enum ib_qp_type
> type,
> @@ -1154,22 +1150,18 @@ static int check_qp_type(struct hns_roce_dev
> *hr_dev, enum ib_qp_type type,
>  	return -EOPNOTSUPP;
>  }
>=20
> -struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
> -				 struct ib_qp_init_attr *init_attr,
> -				 struct ib_udata *udata)
> +int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_at=
tr,
> +		       struct ib_udata *udata)
>  {
> -	struct ib_device *ibdev =3D pd ? pd->device : init_attr->xrcd->device;
> +	struct ib_device *ibdev =3D qp->device;
>  	struct hns_roce_dev *hr_dev =3D to_hr_dev(ibdev);
> -	struct hns_roce_qp *hr_qp;
> +	struct hns_roce_qp *hr_qp =3D to_hr_qp(qp);
> +	struct ib_pd *pd =3D qp->pd;
>  	int ret;
>=20
>  	ret =3D check_qp_type(hr_dev, init_attr->qp_type, !!udata);
>  	if (ret)
> -		return ERR_PTR(ret);
> -
> -	hr_qp =3D kzalloc(sizeof(*hr_qp), GFP_KERNEL);
> -	if (!hr_qp)
> -		return ERR_PTR(-ENOMEM);
> +		return ret;
>=20
>  	if (init_attr->qp_type =3D=3D IB_QPT_XRC_TGT)
>  		hr_qp->xrcdn =3D to_hr_xrcd(init_attr->xrcd)->xrcdn;
> @@ -1180,15 +1172,11 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd
> *pd,
>  	}
>=20
>  	ret =3D hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
> hr_qp);
> -	if (ret) {
> +	if (ret)
>  		ibdev_err(ibdev, "Create QP type 0x%x failed(%d)\n",
>  			  init_attr->qp_type, ret);
>=20
> -		kfree(hr_qp);
> -		return ERR_PTR(ret);
> -	}
> -
> -	return &hr_qp->ibqp;
> +	return ret;
>  }
>=20
>  int to_hr_qp_type(int qp_type)
> diff --git a/drivers/infiniband/hw/irdma/utils.c
> b/drivers/infiniband/hw/irdma/utils.c
> index 5bbe44e54f9a..e94470991fe0 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -1141,10 +1141,7 @@ void irdma_free_qp_rsrc(struct irdma_qp *iwqp)
>  			  iwqp->kqp.dma_mem.va, iwqp-
> >kqp.dma_mem.pa);
>  	iwqp->kqp.dma_mem.va =3D NULL;
>  	kfree(iwqp->kqp.sq_wrid_mem);
> -	iwqp->kqp.sq_wrid_mem =3D NULL;
>  	kfree(iwqp->kqp.rq_wrid_mem);
> -	iwqp->kqp.rq_wrid_mem =3D NULL;
> -	kfree(iwqp);
>  }
>=20
>  /**
> diff --git a/drivers/infiniband/hw/irdma/verbs.c
> b/drivers/infiniband/hw/irdma/verbs.c
> index 9712f6902ba8..9b8c451e2426 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -792,18 +792,19 @@ static int irdma_validate_qp_attrs(struct
> ib_qp_init_attr *init_attr,
>=20
>  /**
>   * irdma_create_qp - create qp
> - * @ibpd: ptr of pd
> + * @ibqp: ptr of qp
>   * @init_attr: attributes for qp
>   * @udata: user data for create qp
>   */
> -static struct ib_qp *irdma_create_qp(struct ib_pd *ibpd,
> -				     struct ib_qp_init_attr *init_attr,
> -				     struct ib_udata *udata)
> +static int irdma_create_qp(struct ib_qp *ibqp,
> +			   struct ib_qp_init_attr *init_attr,
> +			   struct ib_udata *udata)
>  {
> +	struct ib_pd *ibpd =3D ibqp->pd;
>  	struct irdma_pd *iwpd =3D to_iwpd(ibpd);
>  	struct irdma_device *iwdev =3D to_iwdev(ibpd->device);
>  	struct irdma_pci_f *rf =3D iwdev->rf;
> -	struct irdma_qp *iwqp;
> +	struct irdma_qp *iwqp =3D to_iwqp(ibqp);
>  	struct irdma_create_qp_req req;
>  	struct irdma_create_qp_resp uresp =3D {};
>  	u32 qp_num =3D 0;
> @@ -820,7 +821,7 @@ static struct ib_qp *irdma_create_qp(struct ib_pd
> *ibpd,
>=20
>  	err_code =3D irdma_validate_qp_attrs(init_attr, iwdev);
>  	if (err_code)
> -		return ERR_PTR(err_code);
> +		return err_code;
>=20
>  	sq_size =3D init_attr->cap.max_send_wr;
>  	rq_size =3D init_attr->cap.max_recv_wr;
> @@ -833,10 +834,6 @@ static struct ib_qp *irdma_create_qp(struct ib_pd
> *ibpd,
>  	init_info.qp_uk_init_info.max_rq_frag_cnt =3D init_attr-
> >cap.max_recv_sge;
>  	init_info.qp_uk_init_info.max_inline_data =3D init_attr-
> >cap.max_inline_data;
>=20
> -	iwqp =3D kzalloc(sizeof(*iwqp), GFP_KERNEL);
> -	if (!iwqp)
> -		return ERR_PTR(-ENOMEM);
> -
>  	qp =3D &iwqp->sc_qp;
>  	qp->qp_uk.back_qp =3D iwqp;
>  	qp->qp_uk.lock =3D &iwqp->lock;
> @@ -849,10 +846,8 @@ static struct ib_qp *irdma_create_qp(struct ib_pd
> *ibpd,
>  						 iwqp->q2_ctx_mem.size,
>  						 &iwqp->q2_ctx_mem.pa,
>  						 GFP_KERNEL);
> -	if (!iwqp->q2_ctx_mem.va) {
> -		err_code =3D -ENOMEM;
> -		goto error;
> -	}
> +	if (!iwqp->q2_ctx_mem.va)
> +		return -ENOMEM;
>=20
>  	init_info.q2 =3D iwqp->q2_ctx_mem.va;
>  	init_info.q2_pa =3D iwqp->q2_ctx_mem.pa;
> @@ -1001,17 +996,16 @@ static struct ib_qp *irdma_create_qp(struct ib_pd
> *ibpd,
>  		if (err_code) {
>  			ibdev_dbg(&iwdev->ibdev, "VERBS: copy_to_udata
> failed\n");
>  			irdma_destroy_qp(&iwqp->ibqp, udata);
> -			return ERR_PTR(err_code);
> +			return err_code;
>  		}
>  	}
>=20
>  	init_completion(&iwqp->free_qp);
> -	return &iwqp->ibqp;
> +	return 0;
>=20
>  error:
>  	irdma_free_qp_rsrc(iwqp);
> -
> -	return ERR_PTR(err_code);
> +	return err_code;
>  }
>=20
>  static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
> @@ -4406,6 +4400,7 @@ static const struct ib_device_ops irdma_dev_ops =3D
> {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, irdma_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, irdma_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_mw, irdma_mr, ibmw),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, irdma_qp, ibqp),
>  };
>=20
>  /**
> diff --git a/drivers/infiniband/hw/mlx4/main.c
> b/drivers/infiniband/hw/mlx4/main.c
> index ae4c91b612ce..f367f4a4abff 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -2577,6 +2577,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops
> =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mlx4_ib_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, mlx4_ib_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, mlx4_ib_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, mlx4_ib_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, mlx4_ib_ucontext, ibucontext),
>  };
> diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> index e856cf23a0a1..c60f6e9ac640 100644
> --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> @@ -792,9 +792,8 @@ void mlx4_ib_free_srq_wqe(struct mlx4_ib_srq *srq,
> int wqe_index);
>  int mlx4_ib_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr =
*wr,
>  			  const struct ib_recv_wr **bad_wr);
>=20
> -struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
> -				struct ib_qp_init_attr *init_attr,
> -				struct ib_udata *udata);
> +int mlx4_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_att=
r,
> +		      struct ib_udata *udata);
>  int mlx4_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata);
>  void mlx4_ib_drain_sq(struct ib_qp *qp);
>  void mlx4_ib_drain_rq(struct ib_qp *qp);
> diff --git a/drivers/infiniband/hw/mlx4/qp.c
> b/drivers/infiniband/hw/mlx4/qp.c
> index 4a2ef7daaded..8662f462e2a5 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -1578,24 +1578,19 @@ static int _mlx4_ib_create_qp(struct ib_pd *pd,
> struct mlx4_ib_qp *qp,
>  	return 0;
>  }
>=20
> -struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
> -				struct ib_qp_init_attr *init_attr,
> -				struct ib_udata *udata) {
> -	struct ib_device *device =3D pd ? pd->device : init_attr->xrcd->device;
> +int mlx4_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_a=
ttr,
> +		      struct ib_udata *udata)
> +{
> +	struct ib_device *device =3D ibqp->device;
>  	struct mlx4_ib_dev *dev =3D to_mdev(device);
> -	struct mlx4_ib_qp *qp;
> +	struct mlx4_ib_qp *qp =3D to_mqp(ibqp);
> +	struct ib_pd *pd =3D ibqp->pd;
>  	int ret;
>=20
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp)
> -		return ERR_PTR(-ENOMEM);
> -
>  	mutex_init(&qp->mutex);
>  	ret =3D _mlx4_ib_create_qp(pd, qp, init_attr, udata);
> -	if (ret) {
> -		kfree(qp);
> -		return ERR_PTR(ret);
> -	}
> +	if (ret)
> +		return ret;
>=20
>  	if (init_attr->qp_type =3D=3D IB_QPT_GSI &&
>  	    !(init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI)) {
> @@ -1618,7 +1613,7 @@ struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
>  			init_attr->create_flags &=3D
> ~MLX4_IB_QP_CREATE_ROCE_V2_GSI;
>  		}
>  	}
> -	return &qp->ibqp;
> +	return 0;
>  }
>=20
>  static int _mlx4_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
> @@ -1646,8 +1641,6 @@ static int _mlx4_ib_destroy_qp(struct ib_qp *qp,
> struct ib_udata *udata)
>  	}
>=20
>  	kfree(mqp->sqp);
> -	kfree(mqp);
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/hw/mlx5/gsi.c
> b/drivers/infiniband/hw/mlx5/gsi.c
> index 541da52470cb..3ad8f637c589 100644
> --- a/drivers/infiniband/hw/mlx5/gsi.c
> +++ b/drivers/infiniband/hw/mlx5/gsi.c
> @@ -193,8 +193,6 @@ int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp)
>=20
>  	kfree(gsi->outstanding_wrs);
>  	kfree(gsi->tx_qps);
> -	kfree(mqp);
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c
> b/drivers/infiniband/hw/mlx5/main.c
> index bcdbc3033b0a..7a6bafc19c9b 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -3805,6 +3805,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops
> =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_counters, mlx5_ib_mcounters, ibcntrs),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, mlx5_ib_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, mlx5_ib_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, mlx5_ib_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, mlx5_ib_ucontext, ibucontext),
>  };
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index f2c8a6375b16..d662896e7fba 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1237,9 +1237,8 @@ int mlx5_ib_post_srq_recv(struct ib_srq *ibsrq,
> const struct ib_recv_wr *wr,
>  			  const struct ib_recv_wr **bad_wr);
>  int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
>  void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
> -struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
> -				struct ib_qp_init_attr *init_attr,
> -				struct ib_udata *udata);
> +int mlx5_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_att=
r,
> +		      struct ib_udata *udata);
>  int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		      int attr_mask, struct ib_udata *udata);
>  int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int
> qp_attr_mask,
> diff --git a/drivers/infiniband/hw/mlx5/qp.c
> b/drivers/infiniband/hw/mlx5/qp.c
> index d6c6bfe9921a..18b018f1db83 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -3116,7 +3116,6 @@ static int mlx5_ib_destroy_dct(struct mlx5_ib_qp
> *mqp)
>  	}
>=20
>  	kfree(mqp->dct.in);
> -	kfree(mqp);
>  	return 0;
>  }
>=20
> @@ -3154,25 +3153,23 @@ static int check_ucmd_data(struct mlx5_ib_dev
> *dev,
>  	return ret ? 0 : -EINVAL;
>  }
>=20
> -struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr
> *attr,
> -				struct ib_udata *udata)
> +int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
> +		      struct ib_udata *udata)
>  {
>  	struct mlx5_create_qp_params params =3D {};
> -	struct mlx5_ib_dev *dev;
> -	struct mlx5_ib_qp *qp;
> +	struct mlx5_ib_dev *dev =3D to_mdev(ibqp->device);
> +	struct mlx5_ib_qp *qp =3D to_mqp(ibqp);
> +	struct ib_pd *pd =3D ibqp->pd;
>  	enum ib_qp_type type;
>  	int err;
>=20
> -	dev =3D pd ? to_mdev(pd->device) :
> -		   to_mdev(to_mxrcd(attr->xrcd)->ibxrcd.device);
> -
>  	err =3D check_qp_type(dev, attr, &type);
>  	if (err)
> -		return ERR_PTR(err);
> +		return err;
>=20
>  	err =3D check_valid_flow(dev, pd, attr, udata);
>  	if (err)
> -		return ERR_PTR(err);
> +		return err;
>=20
>  	params.udata =3D udata;
>  	params.uidx =3D MLX5_IB_DEFAULT_UIDX;
> @@ -3182,49 +3179,43 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd
> *pd, struct ib_qp_init_attr *attr,
>  	if (udata) {
>  		err =3D process_udata_size(dev, &params);
>  		if (err)
> -			return ERR_PTR(err);
> +			return err;
>=20
>  		err =3D check_ucmd_data(dev, &params);
>  		if (err)
> -			return ERR_PTR(err);
> +			return err;
>=20
>  		params.ucmd =3D kzalloc(params.ucmd_size, GFP_KERNEL);
>  		if (!params.ucmd)
> -			return ERR_PTR(-ENOMEM);
> +			return -ENOMEM;
>=20
>  		err =3D ib_copy_from_udata(params.ucmd, udata,
> params.inlen);
>  		if (err)
>  			goto free_ucmd;
>  	}
>=20
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		err =3D -ENOMEM;
> -		goto free_ucmd;
> -	}
> -
>  	mutex_init(&qp->mutex);
>  	qp->type =3D type;
>  	if (udata) {
>  		err =3D process_vendor_flags(dev, qp, params.ucmd, attr);
>  		if (err)
> -			goto free_qp;
> +			goto free_ucmd;
>=20
>  		err =3D get_qp_uidx(qp, &params);
>  		if (err)
> -			goto free_qp;
> +			goto free_ucmd;
>  	}
>  	err =3D process_create_flags(dev, qp, attr);
>  	if (err)
> -		goto free_qp;
> +		goto free_ucmd;
>=20
>  	err =3D check_qp_attr(dev, qp, attr);
>  	if (err)
> -		goto free_qp;
> +		goto free_ucmd;
>=20
>  	err =3D create_qp(dev, pd, qp, &params);
>  	if (err)
> -		goto free_qp;
> +		goto free_ucmd;
>=20
>  	kfree(params.ucmd);
>  	params.ucmd =3D NULL;
> @@ -3239,7 +3230,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
> struct ib_qp_init_attr *attr,
>  	if (err)
>  		goto destroy_qp;
>=20
> -	return &qp->ibqp;
> +	return 0;
>=20
>  destroy_qp:
>  	switch (qp->type) {
> @@ -3250,22 +3241,12 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd
> *pd, struct ib_qp_init_attr *attr,
>  		mlx5_ib_destroy_gsi(qp);
>  		break;
>  	default:
> -		/*
> -		 * These lines below are temp solution till QP allocation
> -		 * will be moved to be under IB/core responsiblity.
> -		 */
> -		qp->ibqp.send_cq =3D attr->send_cq;
> -		qp->ibqp.recv_cq =3D attr->recv_cq;
> -		qp->ibqp.pd =3D pd;
>  		destroy_qp_common(dev, qp, udata);
>  	}
>=20
> -	qp =3D NULL;
> -free_qp:
> -	kfree(qp);
>  free_ucmd:
>  	kfree(params.ucmd);
> -	return ERR_PTR(err);
> +	return err;
>  }
>=20
>  int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
> @@ -3280,9 +3261,6 @@ int mlx5_ib_destroy_qp(struct ib_qp *qp, struct
> ib_udata *udata)
>  		return mlx5_ib_destroy_dct(mqp);
>=20
>  	destroy_qp_common(dev, mqp, udata);
> -
> -	kfree(mqp);
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c
> b/drivers/infiniband/hw/mthca/mthca_provider.c
> index adf4fcf0fee4..ceee23ebc0f2 100644
> --- a/drivers/infiniband/hw/mthca/mthca_provider.c
> +++ b/drivers/infiniband/hw/mthca/mthca_provider.c
> @@ -459,52 +459,45 @@ static int mthca_destroy_srq(struct ib_srq *srq,
> struct ib_udata *udata)
>  	return 0;
>  }
>=20
> -static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
> -				     struct ib_qp_init_attr *init_attr,
> -				     struct ib_udata *udata)
> +static int mthca_create_qp(struct ib_qp *ibqp,
> +			   struct ib_qp_init_attr *init_attr,
> +			   struct ib_udata *udata)
>  {
>  	struct mthca_ucontext *context =3D rdma_udata_to_drv_context(
>  		udata, struct mthca_ucontext, ibucontext);
>  	struct mthca_create_qp ucmd;
> -	struct mthca_qp *qp;
> +	struct mthca_qp *qp =3D to_mqp(ibqp);
> +	struct mthca_dev *dev =3D to_mdev(ibqp->device);
>  	int err;
>=20
>  	if (init_attr->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	switch (init_attr->qp_type) {
>  	case IB_QPT_RC:
>  	case IB_QPT_UC:
>  	case IB_QPT_UD:
>  	{
> -		qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -		if (!qp)
> -			return ERR_PTR(-ENOMEM);
> -
>  		if (udata) {
> -			if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
> {
> -				kfree(qp);
> -				return ERR_PTR(-EFAULT);
> -			}
> +			if (ib_copy_from_udata(&ucmd, udata,
> sizeof(ucmd)))
> +				return -EFAULT;
>=20
> -			err =3D mthca_map_user_db(to_mdev(pd->device),
> &context->uar,
> +			err =3D mthca_map_user_db(dev, &context->uar,
>  						context->db_tab,
> -						ucmd.sq_db_index,
> ucmd.sq_db_page);
> -			if (err) {
> -				kfree(qp);
> -				return ERR_PTR(err);
> -			}
> +						ucmd.sq_db_index,
> +						ucmd.sq_db_page);
> +			if (err)
> +				return err;
>=20
> -			err =3D mthca_map_user_db(to_mdev(pd->device),
> &context->uar,
> +			err =3D mthca_map_user_db(dev, &context->uar,
>  						context->db_tab,
> -						ucmd.rq_db_index,
> ucmd.rq_db_page);
> +						ucmd.rq_db_index,
> +						ucmd.rq_db_page);
>  			if (err) {
> -				mthca_unmap_user_db(to_mdev(pd-
> >device),
> -						    &context->uar,
> +				mthca_unmap_user_db(dev, &context->uar,
>  						    context->db_tab,
>  						    ucmd.sq_db_index);
> -				kfree(qp);
> -				return ERR_PTR(err);
> +				return err;
>  			}
>=20
>  			qp->mr.ibmr.lkey =3D ucmd.lkey;
> @@ -512,20 +505,16 @@ static struct ib_qp *mthca_create_qp(struct ib_pd
> *pd,
>  			qp->rq.db_index  =3D ucmd.rq_db_index;
>  		}
>=20
> -		err =3D mthca_alloc_qp(to_mdev(pd->device), to_mpd(pd),
> +		err =3D mthca_alloc_qp(dev, to_mpd(ibqp->pd),
>  				     to_mcq(init_attr->send_cq),
>  				     to_mcq(init_attr->recv_cq),
>  				     init_attr->qp_type, init_attr->sq_sig_type,
>  				     &init_attr->cap, qp, udata);
>=20
>  		if (err && udata) {
> -			mthca_unmap_user_db(to_mdev(pd->device),
> -					    &context->uar,
> -					    context->db_tab,
> +			mthca_unmap_user_db(dev, &context->uar,
> context->db_tab,
>  					    ucmd.sq_db_index);
> -			mthca_unmap_user_db(to_mdev(pd->device),
> -					    &context->uar,
> -					    context->db_tab,
> +			mthca_unmap_user_db(dev, &context->uar,
> context->db_tab,
>  					    ucmd.rq_db_index);
>  		}
>=20
> @@ -535,34 +524,28 @@ static struct ib_qp *mthca_create_qp(struct ib_pd
> *pd,
>  	case IB_QPT_SMI:
>  	case IB_QPT_GSI:
>  	{
> -		qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -		if (!qp)
> -			return ERR_PTR(-ENOMEM);
>  		qp->sqp =3D kzalloc(sizeof(struct mthca_sqp), GFP_KERNEL);
> -		if (!qp->sqp) {
> -			kfree(qp);
> -			return ERR_PTR(-ENOMEM);
> -		}
> +		if (!qp->sqp)
> +			return -ENOMEM;
>=20
>  		qp->ibqp.qp_num =3D init_attr->qp_type =3D=3D IB_QPT_SMI ? 0 :
> 1;
>=20
> -		err =3D mthca_alloc_sqp(to_mdev(pd->device), to_mpd(pd),
> +		err =3D mthca_alloc_sqp(dev, to_mpd(ibqp->pd),
>  				      to_mcq(init_attr->send_cq),
>  				      to_mcq(init_attr->recv_cq),
>  				      init_attr->sq_sig_type, &init_attr->cap,
> -				      qp->ibqp.qp_num, init_attr->port_num,
> -				      qp, udata);
> +				      qp->ibqp.qp_num, init_attr->port_num,
> qp,
> +				      udata);
>  		break;
>  	}
>  	default:
>  		/* Don't support raw QPs */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	if (err) {
>  		kfree(qp->sqp);
> -		kfree(qp);
> -		return ERR_PTR(err);
> +		return err;
>  	}
>=20
>  	init_attr->cap.max_send_wr     =3D qp->sq.max;
> @@ -571,7 +554,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd
> *pd,
>  	init_attr->cap.max_recv_sge    =3D qp->rq.max_gs;
>  	init_attr->cap.max_inline_data =3D qp->max_inline_data;
>=20
> -	return &qp->ibqp;
> +	return 0;
>  }
>=20
>  static int mthca_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
> @@ -594,7 +577,6 @@ static int mthca_destroy_qp(struct ib_qp *qp, struct
> ib_udata *udata)
>  	}
>  	mthca_free_qp(to_mdev(qp->device), to_mqp(qp));
>  	kfree(to_mqp(qp)->sqp);
> -	kfree(to_mqp(qp));
>  	return 0;
>  }
>=20
> @@ -1121,6 +1103,7 @@ static const struct ib_device_ops mthca_dev_ops =3D
> {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, mthca_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mthca_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, mthca_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, mthca_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, mthca_ucontext, ibucontext),
>  };
>=20
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> index f329db0c591f..7abf6cf1e937 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> @@ -185,6 +185,7 @@ static const struct ib_device_ops ocrdma_dev_ops =3D =
{
>  	INIT_RDMA_OBJ_SIZE(ib_ah, ocrdma_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, ocrdma_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, ocrdma_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, ocrdma_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, ocrdma_ucontext, ibucontext),
>  };
>=20
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 58619ce64d0d..735123d0e9ec 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1288,19 +1288,19 @@ static void ocrdma_store_gsi_qp_cq(struct
> ocrdma_dev *dev,
>  	}
>  }
>=20
> -struct ib_qp *ocrdma_create_qp(struct ib_pd *ibpd,
> -			       struct ib_qp_init_attr *attrs,
> -			       struct ib_udata *udata)
> +int ocrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
> +		     struct ib_udata *udata)
>  {
>  	int status;
> +	struct ib_pd *ibpd =3D ibqp->pd;
>  	struct ocrdma_pd *pd =3D get_ocrdma_pd(ibpd);
> -	struct ocrdma_qp *qp;
> -	struct ocrdma_dev *dev =3D get_ocrdma_dev(ibpd->device);
> +	struct ocrdma_qp *qp =3D get_ocrdma_qp(ibqp);
> +	struct ocrdma_dev *dev =3D get_ocrdma_dev(ibqp->device);
>  	struct ocrdma_create_qp_ureq ureq;
>  	u16 dpp_credit_lmt, dpp_offset;
>=20
>  	if (attrs->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	status =3D ocrdma_check_qp_params(ibpd, dev, attrs, udata);
>  	if (status)
> @@ -1309,12 +1309,7 @@ struct ib_qp *ocrdma_create_qp(struct ib_pd
> *ibpd,
>  	memset(&ureq, 0, sizeof(ureq));
>  	if (udata) {
>  		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
> -			return ERR_PTR(-EFAULT);
> -	}
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		status =3D -ENOMEM;
> -		goto gen_err;
> +			return -EFAULT;
>  	}
>  	ocrdma_set_qp_init_params(qp, pd, attrs);
>  	if (udata =3D=3D NULL)
> @@ -1349,7 +1344,7 @@ struct ib_qp *ocrdma_create_qp(struct ib_pd
> *ibpd,
>  	ocrdma_store_gsi_qp_cq(dev, attrs);
>  	qp->ibqp.qp_num =3D qp->id;
>  	mutex_unlock(&dev->dev_lock);
> -	return &qp->ibqp;
> +	return 0;
>=20
>  cpy_err:
>  	ocrdma_del_qpn_map(dev, qp);
> @@ -1359,10 +1354,9 @@ struct ib_qp *ocrdma_create_qp(struct ib_pd
> *ibpd,
>  	mutex_unlock(&dev->dev_lock);
>  	kfree(qp->wqe_wr_id_tbl);
>  	kfree(qp->rqe_wr_id_tbl);
> -	kfree(qp);
>  	pr_err("%s(%d) error=3D%d\n", __func__, dev->id, status);
>  gen_err:
> -	return ERR_PTR(status);
> +	return status;
>  }
>=20
>  int _ocrdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> @@ -1731,7 +1725,6 @@ int ocrdma_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>=20
>  	kfree(qp->wqe_wr_id_tbl);
>  	kfree(qp->rqe_wr_id_tbl);
> -	kfree(qp);
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> index b1c5fad81603..b73d742a520c 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> @@ -75,9 +75,8 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  int ocrdma_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
>  int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>=20
> -struct ib_qp *ocrdma_create_qp(struct ib_pd *,
> -			       struct ib_qp_init_attr *attrs,
> -			       struct ib_udata *);
> +int ocrdma_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
> +		     struct ib_udata *udata);
>  int _ocrdma_modify_qp(struct ib_qp *, struct ib_qp_attr *attr,
>  		      int attr_mask);
>  int ocrdma_modify_qp(struct ib_qp *, struct ib_qp_attr *attr,
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index de98e0604f91..755930be01b8 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -233,6 +233,7 @@ static const struct ib_device_ops qedr_dev_ops =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, qedr_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, qedr_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, qedr_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, qedr_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, qedr_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_xrcd, qedr_xrcd, ibxrcd),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, qedr_ucontext, ibucontext),
> diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> index 13e5e6bbec99..05307c1488b8 100644
> --- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> @@ -319,20 +319,19 @@ static int qedr_ll2_start(struct qedr_dev *dev,
>  	return rc;
>  }
>=20
> -struct ib_qp *qedr_create_gsi_qp(struct qedr_dev *dev,
> -				 struct ib_qp_init_attr *attrs,
> -				 struct qedr_qp *qp)
> +int qedr_create_gsi_qp(struct qedr_dev *dev, struct ib_qp_init_attr *att=
rs,
> +		       struct qedr_qp *qp)
>  {
>  	int rc;
>=20
>  	rc =3D qedr_check_gsi_qp_attrs(dev, attrs);
>  	if (rc)
> -		return ERR_PTR(rc);
> +		return rc;
>=20
>  	rc =3D qedr_ll2_start(dev, attrs, qp);
>  	if (rc) {
>  		DP_ERR(dev, "create gsi qp: failed on ll2 start. rc=3D%d\n", rc);
> -		return ERR_PTR(rc);
> +		return rc;
>  	}
>=20
>  	/* create QP */
> @@ -359,7 +358,7 @@ struct ib_qp *qedr_create_gsi_qp(struct qedr_dev
> *dev,
>=20
>  	DP_DEBUG(dev, QEDR_MSG_GSI, "created GSI QP %p\n", qp);
>=20
> -	return &qp->ibqp;
> +	return 0;
>=20
>  err:
>  	kfree(qp->rqe_wr_id);
> @@ -368,7 +367,7 @@ struct ib_qp *qedr_create_gsi_qp(struct qedr_dev
> *dev,
>  	if (rc)
>  		DP_ERR(dev, "create gsi qp: failed destroy on create\n");
>=20
> -	return ERR_PTR(-ENOMEM);
> +	return -ENOMEM;
>  }
>=20
>  int qedr_destroy_gsi_qp(struct qedr_dev *dev)
> diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.h
> b/drivers/infiniband/hw/qedr/qedr_roce_cm.h
> index d46dcd3f6424..f3432f035ec6 100644
> --- a/drivers/infiniband/hw/qedr/qedr_roce_cm.h
> +++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.h
> @@ -50,9 +50,8 @@ int qedr_gsi_post_recv(struct ib_qp *ibqp, const struct
> ib_recv_wr *wr,
>  		       const struct ib_recv_wr **bad_wr);
>  int qedr_gsi_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
>  		       const struct ib_send_wr **bad_wr);
> -struct ib_qp *qedr_create_gsi_qp(struct qedr_dev *dev,
> -				 struct ib_qp_init_attr *attrs,
> -				 struct qedr_qp *qp);
> +int qedr_create_gsi_qp(struct qedr_dev *dev, struct ib_qp_init_attr *att=
rs,
> +		       struct qedr_qp *qp);
>  void qedr_store_gsi_qp_cq(struct qedr_dev *dev,
>  			  struct qedr_qp *qp, struct ib_qp_init_attr *attrs);
>  int qedr_destroy_gsi_qp(struct qedr_dev *dev);
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index fdc47ef7d861..9cf94dc768ec 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2239,34 +2239,30 @@ static int qedr_free_qp_resources(struct
> qedr_dev *dev, struct qedr_qp *qp,
>  	return 0;
>  }
>=20
> -struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
> -			     struct ib_qp_init_attr *attrs,
> -			     struct ib_udata *udata)
> +int qedr_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
> +		   struct ib_udata *udata)
>  {
>  	struct qedr_xrcd *xrcd =3D NULL;
> -	struct qedr_pd *pd =3D NULL;
> -	struct qedr_dev *dev;
> -	struct qedr_qp *qp;
> -	struct ib_qp *ibqp;
> +	struct ib_pd *ibpd =3D ibqp->pd;
> +	struct qedr_pd *pd =3D get_qedr_pd(ibpd);
> +	struct qedr_dev *dev =3D get_qedr_dev(ibqp->device);
> +	struct qedr_qp *qp =3D get_qedr_qp(ibqp);
>  	int rc =3D 0;
>=20
>  	if (attrs->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
> -	if (attrs->qp_type =3D=3D IB_QPT_XRC_TGT) {
> +	if (attrs->qp_type =3D=3D IB_QPT_XRC_TGT)
>  		xrcd =3D get_qedr_xrcd(attrs->xrcd);
> -		dev =3D get_qedr_dev(xrcd->ibxrcd.device);
> -	} else {
> +	else
>  		pd =3D get_qedr_pd(ibpd);
> -		dev =3D get_qedr_dev(ibpd->device);
> -	}
>=20
>  	DP_DEBUG(dev, QEDR_MSG_QP, "create qp: called from %s,
> pd=3D%p\n",
>  		 udata ? "user library" : "kernel", pd);
>=20
>  	rc =3D qedr_check_qp_attrs(ibpd, dev, attrs, udata);
>  	if (rc)
> -		return ERR_PTR(rc);
> +		return rc;
>=20
>  	DP_DEBUG(dev, QEDR_MSG_QP,
>  		 "create qp: called from %s, event_handler=3D%p, eepd=3D%p
> sq_cq=3D%p, sq_icid=3D%d, rq_cq=3D%p, rq_icid=3D%d\n",
> @@ -2276,20 +2272,10 @@ struct ib_qp *qedr_create_qp(struct ib_pd
> *ibpd,
>  		 get_qedr_cq(attrs->recv_cq),
>  		 attrs->recv_cq ? get_qedr_cq(attrs->recv_cq)->icid : 0);
>=20
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		DP_ERR(dev, "create qp: failed allocating memory\n");
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
>  	qedr_set_common_qp_params(dev, qp, pd, attrs);
>=20
> -	if (attrs->qp_type =3D=3D IB_QPT_GSI) {
> -		ibqp =3D qedr_create_gsi_qp(dev, attrs, qp);
> -		if (IS_ERR(ibqp))
> -			kfree(qp);
> -		return ibqp;
> -	}
> +	if (attrs->qp_type =3D=3D IB_QPT_GSI)
> +		return qedr_create_gsi_qp(dev, attrs, qp);
>=20
>  	if (udata || xrcd)
>  		rc =3D qedr_create_user_qp(dev, qp, ibpd, udata, attrs);
> @@ -2297,7 +2283,7 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
>  		rc =3D qedr_create_kernel_qp(dev, qp, ibpd, attrs);
>=20
>  	if (rc)
> -		goto out_free_qp;
> +		return rc;
>=20
>  	qp->ibqp.qp_num =3D qp->qp_id;
>=20
> @@ -2307,14 +2293,11 @@ struct ib_qp *qedr_create_qp(struct ib_pd
> *ibpd,
>  			goto out_free_qp_resources;
>  	}
>=20
> -	return &qp->ibqp;
> +	return 0;
>=20
>  out_free_qp_resources:
>  	qedr_free_qp_resources(dev, qp, udata);
> -out_free_qp:
> -	kfree(qp);
> -
> -	return ERR_PTR(-EFAULT);
> +	return -EFAULT;
>  }
>=20
>  static enum ib_qp_state qedr_get_ibqp_state(enum qed_roce_qp_state
> qp_state)
> @@ -2874,8 +2857,6 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>=20
>  	if (rdma_protocol_iwarp(&dev->ibdev, 1))
>  		qedr_iw_qp_rem_ref(&qp->ibqp);
> -	else
> -		kfree(qp);
>=20
>  	return 0;
>  }
> diff --git a/drivers/infiniband/hw/qedr/verbs.h
> b/drivers/infiniband/hw/qedr/verbs.h
> index 34ad47515861..031687dafc61 100644
> --- a/drivers/infiniband/hw/qedr/verbs.h
> +++ b/drivers/infiniband/hw/qedr/verbs.h
> @@ -56,8 +56,8 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  int qedr_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
>  int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>  int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
> -struct ib_qp *qedr_create_qp(struct ib_pd *, struct ib_qp_init_attr *att=
rs,
> -			     struct ib_udata *);
> +int qedr_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
> +		   struct ib_udata *udata);
>  int qedr_modify_qp(struct ib_qp *, struct ib_qp_attr *attr,
>  		   int attr_mask, struct ib_udata *udata);
>  int qedr_query_qp(struct ib_qp *, struct ib_qp_attr *qp_attr,
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c
> b/drivers/infiniband/hw/usnic/usnic_ib_main.c
> index c49f9e19d926..228e9a36dad0 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
> @@ -360,6 +360,7 @@ static const struct ib_device_ops usnic_dev_ops =3D {
>  	.reg_user_mr =3D usnic_ib_reg_mr,
>  	INIT_RDMA_OBJ_SIZE(ib_pd, usnic_ib_pd, ibpd),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, usnic_ib_cq, ibcq),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, usnic_ib_qp_grp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, usnic_ib_ucontext, ibucontext),
>  };
>=20
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
> b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
> index 0cdb156e165e..3b60fa9cb58d 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
> @@ -665,13 +665,12 @@ static int qp_grp_id_from_flow(struct
> usnic_ib_qp_grp_flow *qp_flow,
>  	return 0;
>  }
>=20
> -struct usnic_ib_qp_grp *
> -usnic_ib_qp_grp_create(struct usnic_fwd_dev *ufdev, struct usnic_ib_vf
> *vf,
> -			struct usnic_ib_pd *pd,
> -			struct usnic_vnic_res_spec *res_spec,
> -			struct usnic_transport_spec *transport_spec)
> +int usnic_ib_qp_grp_create(struct usnic_ib_qp_grp *qp_grp,
> +			   struct usnic_fwd_dev *ufdev, struct usnic_ib_vf
> *vf,
> +			   struct usnic_ib_pd *pd,
> +			   struct usnic_vnic_res_spec *res_spec,
> +			   struct usnic_transport_spec *transport_spec)
>  {
> -	struct usnic_ib_qp_grp *qp_grp;
>  	int err;
>  	enum usnic_transport_type transport =3D transport_spec->trans_type;
>  	struct usnic_ib_qp_grp_flow *qp_flow;
> @@ -684,20 +683,15 @@ usnic_ib_qp_grp_create(struct usnic_fwd_dev
> *ufdev, struct usnic_ib_vf *vf,
>  		usnic_err("Spec does not meet minimum req for transport
> %d\n",
>  				transport);
>  		log_spec(res_spec);
> -		return ERR_PTR(err);
> +		return err;
>  	}
>=20
> -	qp_grp =3D kzalloc(sizeof(*qp_grp), GFP_ATOMIC);
> -	if (!qp_grp)
> -		return NULL;
> -
>  	qp_grp->res_chunk_list =3D alloc_res_chunk_list(vf->vnic, res_spec,
>  							qp_grp);
> -	if (IS_ERR_OR_NULL(qp_grp->res_chunk_list)) {
> -		err =3D qp_grp->res_chunk_list ?
> -				PTR_ERR(qp_grp->res_chunk_list) : -
> ENOMEM;
> -		goto out_free_qp_grp;
> -	}
> +	if (IS_ERR_OR_NULL(qp_grp->res_chunk_list))
> +		return qp_grp->res_chunk_list ?
> +				     PTR_ERR(qp_grp->res_chunk_list) :
> +				     -ENOMEM;
>=20
>  	err =3D qp_grp_and_vf_bind(vf, pd, qp_grp);
>  	if (err)
> @@ -724,7 +718,7 @@ usnic_ib_qp_grp_create(struct usnic_fwd_dev
> *ufdev, struct usnic_ib_vf *vf,
>=20
>  	usnic_ib_sysfs_qpn_add(qp_grp);
>=20
> -	return qp_grp;
> +	return 0;
>=20
>  out_release_flow:
>  	release_and_remove_flow(qp_flow);
> @@ -732,10 +726,7 @@ usnic_ib_qp_grp_create(struct usnic_fwd_dev
> *ufdev, struct usnic_ib_vf *vf,
>  	qp_grp_and_vf_unbind(qp_grp);
>  out_free_res:
>  	free_qp_grp_res(qp_grp->res_chunk_list);
> -out_free_qp_grp:
> -	kfree(qp_grp);
> -
> -	return ERR_PTR(err);
> +	return err;
>  }
>=20
>  void usnic_ib_qp_grp_destroy(struct usnic_ib_qp_grp *qp_grp)
> @@ -748,7 +739,6 @@ void usnic_ib_qp_grp_destroy(struct
> usnic_ib_qp_grp *qp_grp)
>  	usnic_ib_sysfs_qpn_remove(qp_grp);
>  	qp_grp_and_vf_unbind(qp_grp);
>  	free_qp_grp_res(qp_grp->res_chunk_list);
> -	kfree(qp_grp);
>  }
>=20
>  struct usnic_vnic_res_chunk*
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
> b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
> index a8a2314c9531..62e732be6736 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h
> @@ -89,11 +89,11 @@ extern const struct usnic_vnic_res_spec
> min_transport_spec[USNIC_TRANSPORT_MAX];
>  const char *usnic_ib_qp_grp_state_to_string(enum ib_qp_state state);
>  int usnic_ib_qp_grp_dump_hdr(char *buf, int buf_sz);
>  int usnic_ib_qp_grp_dump_rows(void *obj, char *buf, int buf_sz);
> -struct usnic_ib_qp_grp *
> -usnic_ib_qp_grp_create(struct usnic_fwd_dev *ufdev, struct usnic_ib_vf
> *vf,
> -			struct usnic_ib_pd *pd,
> -			struct usnic_vnic_res_spec *res_spec,
> -			struct usnic_transport_spec *trans_spec);
> +int usnic_ib_qp_grp_create(struct usnic_ib_qp_grp *qp,
> +			   struct usnic_fwd_dev *ufdev, struct usnic_ib_vf
> *vf,
> +			   struct usnic_ib_pd *pd,
> +			   struct usnic_vnic_res_spec *res_spec,
> +			   struct usnic_transport_spec *trans_spec);
>  void usnic_ib_qp_grp_destroy(struct usnic_ib_qp_grp *qp_grp);
>  int usnic_ib_qp_grp_modify(struct usnic_ib_qp_grp *qp_grp,
>  				enum ib_qp_state new_state,
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> index 57d210ca855a..06a4e9d4545d 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> @@ -168,30 +168,31 @@ static int usnic_ib_fill_create_qp_resp(struct
> usnic_ib_qp_grp *qp_grp,
>  	return 0;
>  }
>=20
> -static struct usnic_ib_qp_grp*
> -find_free_vf_and_create_qp_grp(struct usnic_ib_dev *us_ibdev,
> -				struct usnic_ib_pd *pd,
> -				struct usnic_transport_spec *trans_spec,
> -				struct usnic_vnic_res_spec *res_spec)
> +static int
> +find_free_vf_and_create_qp_grp(struct ib_qp *qp,
> +			       struct usnic_transport_spec *trans_spec,
> +			       struct usnic_vnic_res_spec *res_spec)
>  {
> +	struct usnic_ib_dev *us_ibdev =3D to_usdev(qp->device);
> +	struct usnic_ib_pd *pd =3D to_upd(qp->pd);
>  	struct usnic_ib_vf *vf;
>  	struct usnic_vnic *vnic;
> -	struct usnic_ib_qp_grp *qp_grp;
> +	struct usnic_ib_qp_grp *qp_grp =3D to_uqp_grp(qp);
>  	struct device *dev, **dev_list;
> -	int i;
> +	int i, ret;
>=20
>  	BUG_ON(!mutex_is_locked(&us_ibdev->usdev_lock));
>=20
>  	if (list_empty(&us_ibdev->vf_dev_list)) {
>  		usnic_info("No vfs to allocate\n");
> -		return NULL;
> +		return -ENOMEM;
>  	}
>=20
>  	if (usnic_ib_share_vf) {
>  		/* Try to find resouces on a used vf which is in pd */
>  		dev_list =3D usnic_uiom_get_dev_list(pd->umem_pd);
>  		if (IS_ERR(dev_list))
> -			return ERR_CAST(dev_list);
> +			return PTR_ERR(dev_list);
>  		for (i =3D 0; dev_list[i]; i++) {
>  			dev =3D dev_list[i];
>  			vf =3D dev_get_drvdata(dev);
> @@ -202,10 +203,10 @@ find_free_vf_and_create_qp_grp(struct
> usnic_ib_dev *us_ibdev,
>  						dev_name(&us_ibdev-
> >ib_dev.dev),
>=20
> 	pci_name(usnic_vnic_get_pdev(
>=20
> 	vnic)));
> -				qp_grp =3D usnic_ib_qp_grp_create(us_ibdev-
> >ufdev,
> -								vf, pd,
> -								res_spec,
> -								trans_spec);
> +				ret =3D usnic_ib_qp_grp_create(qp_grp,
> +							     us_ibdev->ufdev,
> +							     vf, pd, res_spec,
> +							     trans_spec);
>=20
>  				spin_unlock(&vf->lock);
>  				goto qp_grp_check;
> @@ -223,9 +224,9 @@ find_free_vf_and_create_qp_grp(struct
> usnic_ib_dev *us_ibdev,
>  		vnic =3D vf->vnic;
>  		if (vf->qp_grp_ref_cnt =3D=3D 0 &&
>  		    usnic_vnic_check_room(vnic, res_spec) =3D=3D 0) {
> -			qp_grp =3D usnic_ib_qp_grp_create(us_ibdev->ufdev,
> vf,
> -							pd, res_spec,
> -							trans_spec);
> +			ret =3D usnic_ib_qp_grp_create(qp_grp, us_ibdev-
> >ufdev,
> +						     vf, pd, res_spec,
> +						     trans_spec);
>=20
>  			spin_unlock(&vf->lock);
>  			goto qp_grp_check;
> @@ -235,16 +236,15 @@ find_free_vf_and_create_qp_grp(struct
> usnic_ib_dev *us_ibdev,
>=20
>  	usnic_info("No free qp grp found on %s\n",
>  		   dev_name(&us_ibdev->ib_dev.dev));
> -	return ERR_PTR(-ENOMEM);
> +	return -ENOMEM;
>=20
>  qp_grp_check:
> -	if (IS_ERR_OR_NULL(qp_grp)) {
> +	if (ret) {
>  		usnic_err("Failed to allocate qp_grp\n");
>  		if (usnic_ib_share_vf)
>  			usnic_uiom_free_dev_list(dev_list);
> -		return ERR_PTR(qp_grp ? PTR_ERR(qp_grp) : -ENOMEM);
>  	}
> -	return qp_grp;
> +	return ret;
>  }
>=20
>  static void qp_grp_destroy(struct usnic_ib_qp_grp *qp_grp)
> @@ -458,13 +458,12 @@ int usnic_ib_dealloc_pd(struct ib_pd *pd, struct
> ib_udata *udata)
>  	return 0;
>  }
>=20
> -struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
> -					struct ib_qp_init_attr *init_attr,
> -					struct ib_udata *udata)
> +int usnic_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_=
attr,
> +		       struct ib_udata *udata)
>  {
>  	int err;
>  	struct usnic_ib_dev *us_ibdev;
> -	struct usnic_ib_qp_grp *qp_grp;
> +	struct usnic_ib_qp_grp *qp_grp =3D to_uqp_grp(ibqp);
>  	struct usnic_ib_ucontext *ucontext =3D rdma_udata_to_drv_context(
>  		udata, struct usnic_ib_ucontext, ibucontext);
>  	int cq_cnt;
> @@ -474,29 +473,29 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
>=20
>  	usnic_dbg("\n");
>=20
> -	us_ibdev =3D to_usdev(pd->device);
> +	us_ibdev =3D to_usdev(ibqp->device);
>=20
>  	if (init_attr->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	err =3D ib_copy_from_udata(&cmd, udata, sizeof(cmd));
>  	if (err) {
>  		usnic_err("%s: cannot copy udata for create_qp\n",
>  			  dev_name(&us_ibdev->ib_dev.dev));
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>=20
>  	err =3D create_qp_validate_user_data(cmd);
>  	if (err) {
>  		usnic_err("%s: Failed to validate user data\n",
>  			  dev_name(&us_ibdev->ib_dev.dev));
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>=20
>  	if (init_attr->qp_type !=3D IB_QPT_UD) {
>  		usnic_err("%s asked to make a non-UD QP: %d\n",
>  			  dev_name(&us_ibdev->ib_dev.dev), init_attr-
> >qp_type);
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	trans_spec =3D cmd.spec;
> @@ -504,13 +503,9 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
>  	cq_cnt =3D (init_attr->send_cq =3D=3D init_attr->recv_cq) ? 1 : 2;
>  	res_spec =3D min_transport_spec[trans_spec.trans_type];
>  	usnic_vnic_res_spec_update(&res_spec,
> USNIC_VNIC_RES_TYPE_CQ, cq_cnt);
> -	qp_grp =3D find_free_vf_and_create_qp_grp(us_ibdev, to_upd(pd),
> -						&trans_spec,
> -						&res_spec);
> -	if (IS_ERR_OR_NULL(qp_grp)) {
> -		err =3D qp_grp ? PTR_ERR(qp_grp) : -ENOMEM;
> +	err =3D find_free_vf_and_create_qp_grp(ibqp, &trans_spec,
> &res_spec);
> +	if (err)
>  		goto out_release_mutex;
> -	}
>=20
>  	err =3D usnic_ib_fill_create_qp_resp(qp_grp, udata);
>  	if (err) {
> @@ -522,13 +517,13 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
>  	list_add_tail(&qp_grp->link, &ucontext->qp_grp_list);
>  	usnic_ib_log_vf(qp_grp->vf);
>  	mutex_unlock(&us_ibdev->usdev_lock);
> -	return &qp_grp->ibqp;
> +	return 0;
>=20
>  out_release_qp_grp:
>  	qp_grp_destroy(qp_grp);
>  out_release_mutex:
>  	mutex_unlock(&us_ibdev->usdev_lock);
> -	return ERR_PTR(err);
> +	return err;
>  }
>=20
>  int usnic_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
> b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
> index 6b82d0f2d184..6ca9ee0dddbe 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
> @@ -50,9 +50,8 @@ int usnic_ib_query_gid(struct ib_device *ibdev, u32
> port, int index,
>  				union ib_gid *gid);
>  int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>  int usnic_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
> -struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
> -					struct ib_qp_init_attr *init_attr,
> -					struct ib_udata *udata);
> +int usnic_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_at=
tr,
> +		       struct ib_udata *udata);
>  int usnic_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata);
>  int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  				int attr_mask, struct ib_udata *udata);
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> index 8ed8bc24c69f..b39175837d58 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> @@ -185,6 +185,7 @@ static const struct ib_device_ops pvrdma_dev_ops =3D =
{
>  	INIT_RDMA_OBJ_SIZE(ib_ah, pvrdma_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, pvrdma_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, pvrdma_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, pvrdma_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, pvrdma_ucontext, ibucontext),
>  };
>=20
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> index 67769b715126..f83cd4a9d992 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> @@ -182,18 +182,17 @@ static int pvrdma_set_sq_size(struct pvrdma_dev
> *dev, struct ib_qp_cap *req_cap,
>=20
>  /**
>   * pvrdma_create_qp - create queue pair
> - * @pd: protection domain
> + * @ibqp: queue pair
>   * @init_attr: queue pair attributes
>   * @udata: user data
>   *
> - * @return: the ib_qp pointer on success, otherwise returns an errno.
> + * @return: the 0 on success, otherwise returns an errno.
>   */
> -struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
> -			       struct ib_qp_init_attr *init_attr,
> -			       struct ib_udata *udata)
> +int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_at=
tr,
> +		     struct ib_udata *udata)
>  {
> -	struct pvrdma_qp *qp =3D NULL;
> -	struct pvrdma_dev *dev =3D to_vdev(pd->device);
> +	struct pvrdma_qp *qp =3D to_vqp(ibqp);
> +	struct pvrdma_dev *dev =3D to_vdev(ibqp->device);
>  	union pvrdma_cmd_req req;
>  	union pvrdma_cmd_resp rsp;
>  	struct pvrdma_cmd_create_qp *cmd =3D &req.create_qp;
> @@ -209,7 +208,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  		dev_warn(&dev->pdev->dev,
>  			 "invalid create queuepair flags %#x\n",
>  			 init_attr->create_flags);
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	if (init_attr->qp_type !=3D IB_QPT_RC &&
> @@ -217,22 +216,22 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	    init_attr->qp_type !=3D IB_QPT_GSI) {
>  		dev_warn(&dev->pdev->dev, "queuepair type %d not
> supported\n",
>  			 init_attr->qp_type);
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	if (is_srq && !dev->dsr->caps.max_srq) {
>  		dev_warn(&dev->pdev->dev,
>  			 "SRQs not supported by device\n");
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>=20
>  	if (!atomic_add_unless(&dev->num_qps, 1, dev->dsr-
> >caps.max_qp))
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>=20
>  	switch (init_attr->qp_type) {
>  	case IB_QPT_GSI:
>  		if (init_attr->port_num =3D=3D 0 ||
> -		    init_attr->port_num > pd->device->phys_port_cnt) {
> +		    init_attr->port_num > ibqp->device->phys_port_cnt) {
>  			dev_warn(&dev->pdev->dev, "invalid queuepair
> attrs\n");
>  			ret =3D -EINVAL;
>  			goto err_qp;
> @@ -240,12 +239,6 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  		fallthrough;
>  	case IB_QPT_RC:
>  	case IB_QPT_UD:
> -		qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -		if (!qp) {
> -			ret =3D -ENOMEM;
> -			goto err_qp;
> -		}
> -
>  		spin_lock_init(&qp->sq.lock);
>  		spin_lock_init(&qp->rq.lock);
>  		mutex_init(&qp->mutex);
> @@ -275,9 +268,9 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>=20
>  			if (!is_srq) {
>  				/* set qp->sq.wqe_cnt, shift, buf_size.. */
> -				qp->rumem =3D
> -					ib_umem_get(pd->device,
> ucmd.rbuf_addr,
> -						    ucmd.rbuf_size, 0);
> +				qp->rumem =3D ib_umem_get(ibqp->device,
> +							ucmd.rbuf_addr,
> +							ucmd.rbuf_size, 0);
>  				if (IS_ERR(qp->rumem)) {
>  					ret =3D PTR_ERR(qp->rumem);
>  					goto err_qp;
> @@ -288,7 +281,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  				qp->srq =3D to_vsrq(init_attr->srq);
>  			}
>=20
> -			qp->sumem =3D ib_umem_get(pd->device,
> ucmd.sbuf_addr,
> +			qp->sumem =3D ib_umem_get(ibqp->device,
> ucmd.sbuf_addr,
>  						ucmd.sbuf_size, 0);
>  			if (IS_ERR(qp->sumem)) {
>  				if (!is_srq)
> @@ -306,12 +299,12 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  				qp->npages_recv =3D 0;
>  			qp->npages =3D qp->npages_send + qp->npages_recv;
>  		} else {
> -			ret =3D pvrdma_set_sq_size(to_vdev(pd->device),
> +			ret =3D pvrdma_set_sq_size(to_vdev(ibqp->device),
>  						 &init_attr->cap, qp);
>  			if (ret)
>  				goto err_qp;
>=20
> -			ret =3D pvrdma_set_rq_size(to_vdev(pd->device),
> +			ret =3D pvrdma_set_rq_size(to_vdev(ibqp->device),
>  						 &init_attr->cap, qp);
>  			if (ret)
>  				goto err_qp;
> @@ -362,7 +355,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>=20
>  	memset(cmd, 0, sizeof(*cmd));
>  	cmd->hdr.cmd =3D PVRDMA_CMD_CREATE_QP;
> -	cmd->pd_handle =3D to_vpd(pd)->pd_handle;
> +	cmd->pd_handle =3D to_vpd(ibqp->pd)->pd_handle;
>  	cmd->send_cq_handle =3D to_vcq(init_attr->send_cq)->cq_handle;
>  	cmd->recv_cq_handle =3D to_vcq(init_attr->recv_cq)->cq_handle;
>  	if (is_srq)
> @@ -418,11 +411,11 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  			dev_warn(&dev->pdev->dev,
>  				 "failed to copy back udata\n");
>  			__pvrdma_destroy_qp(dev, qp);
> -			return ERR_PTR(-EINVAL);
> +			return -EINVAL;
>  		}
>  	}
>=20
> -	return &qp->ibqp;
> +	return 0;
>=20
>  err_pdir:
>  	pvrdma_page_dir_cleanup(dev, &qp->pdir);
> @@ -430,10 +423,8 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	ib_umem_release(qp->rumem);
>  	ib_umem_release(qp->sumem);
>  err_qp:
> -	kfree(qp);
>  	atomic_dec(&dev->num_qps);
> -
> -	return ERR_PTR(ret);
> +	return ret;
>  }
>=20
>  static void _pvrdma_free_qp(struct pvrdma_qp *qp)
> @@ -454,8 +445,6 @@ static void _pvrdma_free_qp(struct pvrdma_qp *qp)
>=20
>  	pvrdma_page_dir_cleanup(dev, &qp->pdir);
>=20
> -	kfree(qp);
> -
>  	atomic_dec(&dev->num_qps);
>  }
>=20
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> index 544b94d97c3a..78807b23d831 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
> @@ -390,9 +390,8 @@ int pvrdma_modify_srq(struct ib_srq *ibsrq, struct
> ib_srq_attr *attr,
>  int pvrdma_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
>  int pvrdma_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
>=20
> -struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
> -			       struct ib_qp_init_attr *init_attr,
> -			       struct ib_udata *udata);
> +int pvrdma_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr=
,
> +		     struct ib_udata *udata);
>  int pvrdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		     int attr_mask, struct ib_udata *udata);
>  int pvrdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c
> b/drivers/infiniband/sw/rdmavt/qp.c
> index 14900860985c..da2d94a5a9c2 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1058,7 +1058,7 @@ static int alloc_ud_wq_attr(struct rvt_qp *qp, int
> node)
>=20
>  /**
>   * rvt_create_qp - create a queue pair for a device
> - * @ibpd: the protection domain who's device we create the queue pair fo=
r
> + * @ibqp: the queue pair
>   * @init_attr: the attributes of the queue pair
>   * @udata: user data for libibverbs.so
>   *
> @@ -1066,47 +1066,45 @@ static int alloc_ud_wq_attr(struct rvt_qp *qp, in=
t
> node)
>   * unique idea of what queue pair numbers mean. For instance there is a
> reserved
>   * range for PSM.
>   *
> - * Return: the queue pair on success, otherwise returns an errno.
> + * Return: 0 on success, otherwise returns an errno.
>   *
>   * Called by the ib_create_qp() core verbs function.
>   */
> -struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
> -			    struct ib_qp_init_attr *init_attr,
> -			    struct ib_udata *udata)
> +int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
> +		  struct ib_udata *udata)
>  {
> -	struct rvt_qp *qp;
> -	int err;
> +	struct rvt_qp *qp =3D ibqp_to_rvtqp(ibqp);
> +	int ret =3D -ENOMEM;
>  	struct rvt_swqe *swq =3D NULL;
>  	size_t sz;
>  	size_t sg_list_sz =3D 0;
> -	struct ib_qp *ret =3D ERR_PTR(-ENOMEM);
> -	struct rvt_dev_info *rdi =3D ib_to_rvt(ibpd->device);
> +	struct rvt_dev_info *rdi =3D ib_to_rvt(ibqp->device);
>  	void *priv =3D NULL;
>  	size_t sqsize;
>  	u8 exclude_prefix =3D 0;
>=20
>  	if (!rdi)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>=20
>  	if (init_attr->create_flags & ~IB_QP_CREATE_NETDEV_USE)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	if (init_attr->cap.max_send_sge > rdi->dparms.props.max_send_sge
> ||
>  	    init_attr->cap.max_send_wr > rdi->dparms.props.max_qp_wr)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>=20
>  	/* Check receive queue parameters if no SRQ is specified. */
>  	if (!init_attr->srq) {
>  		if (init_attr->cap.max_recv_sge >
>  		    rdi->dparms.props.max_recv_sge ||
>  		    init_attr->cap.max_recv_wr > rdi-
> >dparms.props.max_qp_wr)
> -			return ERR_PTR(-EINVAL);
> +			return -EINVAL;
>=20
>  		if (init_attr->cap.max_send_sge +
>  		    init_attr->cap.max_send_wr +
>  		    init_attr->cap.max_recv_sge +
>  		    init_attr->cap.max_recv_wr =3D=3D 0)
> -			return ERR_PTR(-EINVAL);
> +			return -EINVAL;
>  	}
>  	sqsize =3D
>  		init_attr->cap.max_send_wr + 1 +
> @@ -1115,8 +1113,8 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  	case IB_QPT_SMI:
>  	case IB_QPT_GSI:
>  		if (init_attr->port_num =3D=3D 0 ||
> -		    init_attr->port_num > ibpd->device->phys_port_cnt)
> -			return ERR_PTR(-EINVAL);
> +		    init_attr->port_num > ibqp->device->phys_port_cnt)
> +			return -EINVAL;
>  		fallthrough;
>  	case IB_QPT_UC:
>  	case IB_QPT_RC:
> @@ -1124,7 +1122,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  		sz =3D struct_size(swq, sg_list, init_attr->cap.max_send_sge);
>  		swq =3D vzalloc_node(array_size(sz, sqsize), rdi-
> >dparms.node);
>  		if (!swq)
> -			return ERR_PTR(-ENOMEM);
> +			return -ENOMEM;
>=20
>  		if (init_attr->srq) {
>  			struct rvt_srq *srq =3D ibsrq_to_rvtsrq(init_attr->srq);
> @@ -1135,9 +1133,6 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  		} else if (init_attr->cap.max_recv_sge > 1)
>  			sg_list_sz =3D sizeof(*qp->r_sg_list) *
>  				(init_attr->cap.max_recv_sge - 1);
> -		qp =3D kzalloc_node(sizeof(*qp), GFP_KERNEL, rdi-
> >dparms.node);
> -		if (!qp)
> -			goto bail_swq;
>  		qp->r_sg_list =3D
>  			kzalloc_node(sg_list_sz, GFP_KERNEL, rdi-
> >dparms.node);
>  		if (!qp->r_sg_list)
> @@ -1166,7 +1161,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  		 */
>  		priv =3D rdi->driver_f.qp_priv_alloc(rdi, qp);
>  		if (IS_ERR(priv)) {
> -			ret =3D priv;
> +			ret =3D PTR_ERR(priv);
>  			goto bail_qp;
>  		}
>  		qp->priv =3D priv;
> @@ -1180,12 +1175,10 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  			qp->r_rq.max_sge =3D init_attr->cap.max_recv_sge;
>  			sz =3D (sizeof(struct ib_sge) * qp->r_rq.max_sge) +
>  				sizeof(struct rvt_rwqe);
> -			err =3D rvt_alloc_rq(&qp->r_rq, qp->r_rq.size * sz,
> +			ret =3D rvt_alloc_rq(&qp->r_rq, qp->r_rq.size * sz,
>  					   rdi->dparms.node, udata);
> -			if (err) {
> -				ret =3D ERR_PTR(err);
> +			if (ret)
>  				goto bail_driver_priv;
> -			}
>  		}
>=20
>  		/*
> @@ -1206,40 +1199,35 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  		qp->s_max_sge =3D init_attr->cap.max_send_sge;
>  		if (init_attr->sq_sig_type =3D=3D IB_SIGNAL_REQ_WR)
>  			qp->s_flags =3D RVT_S_SIGNAL_REQ_WR;
> -		err =3D alloc_ud_wq_attr(qp, rdi->dparms.node);
> -		if (err) {
> -			ret =3D (ERR_PTR(err));
> +		ret =3D alloc_ud_wq_attr(qp, rdi->dparms.node);
> +		if (ret)
>  			goto bail_rq_rvt;
> -		}
>=20
>  		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
>  			exclude_prefix =3D RVT_AIP_QP_PREFIX;
>=20
> -		err =3D alloc_qpn(rdi, &rdi->qp_dev->qpn_table,
> +		ret =3D alloc_qpn(rdi, &rdi->qp_dev->qpn_table,
>  				init_attr->qp_type,
>  				init_attr->port_num,
>  				exclude_prefix);
> -		if (err < 0) {
> -			ret =3D ERR_PTR(err);
> +		if (ret < 0)
>  			goto bail_rq_wq;
> -		}
> -		qp->ibqp.qp_num =3D err;
> +
> +		qp->ibqp.qp_num =3D ret;
>  		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
>  			qp->ibqp.qp_num |=3D RVT_AIP_QP_BASE;
>  		qp->port_num =3D init_attr->port_num;
>  		rvt_init_qp(rdi, qp, init_attr->qp_type);
>  		if (rdi->driver_f.qp_priv_init) {
> -			err =3D rdi->driver_f.qp_priv_init(rdi, qp, init_attr);
> -			if (err) {
> -				ret =3D ERR_PTR(err);
> +			ret =3D rdi->driver_f.qp_priv_init(rdi, qp, init_attr);
> +			if (ret)
>  				goto bail_rq_wq;
> -			}
>  		}
>  		break;
>=20
>  	default:
>  		/* Don't support raw QPs */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	init_attr->cap.max_inline_data =3D 0;
> @@ -1252,28 +1240,24 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  		if (!qp->r_rq.wq) {
>  			__u64 offset =3D 0;
>=20
> -			err =3D ib_copy_to_udata(udata, &offset,
> +			ret =3D ib_copy_to_udata(udata, &offset,
>  					       sizeof(offset));
> -			if (err) {
> -				ret =3D ERR_PTR(err);
> +			if (ret)
>  				goto bail_qpn;
> -			}
>  		} else {
>  			u32 s =3D sizeof(struct rvt_rwq) + qp->r_rq.size * sz;
>=20
>  			qp->ip =3D rvt_create_mmap_info(rdi, s, udata,
>  						      qp->r_rq.wq);
>  			if (IS_ERR(qp->ip)) {
> -				ret =3D ERR_CAST(qp->ip);
> +				ret =3D PTR_ERR(qp->ip);
>  				goto bail_qpn;
>  			}
>=20
> -			err =3D ib_copy_to_udata(udata, &qp->ip->offset,
> +			ret =3D ib_copy_to_udata(udata, &qp->ip->offset,
>  					       sizeof(qp->ip->offset));
> -			if (err) {
> -				ret =3D ERR_PTR(err);
> +			if (ret)
>  				goto bail_ip;
> -			}
>  		}
>  		qp->pid =3D current->pid;
>  	}
> @@ -1281,7 +1265,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  	spin_lock(&rdi->n_qps_lock);
>  	if (rdi->n_qps_allocated =3D=3D rdi->dparms.props.max_qp) {
>  		spin_unlock(&rdi->n_qps_lock);
> -		ret =3D ERR_PTR(-ENOMEM);
> +		ret =3D ENOMEM;
>  		goto bail_ip;
>  	}
>=20
> @@ -1307,9 +1291,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  		spin_unlock_irq(&rdi->pending_lock);
>  	}
>=20
> -	ret =3D &qp->ibqp;
> -
> -	return ret;
> +	return 0;
>=20
>  bail_ip:
>  	if (qp->ip)
> @@ -1330,11 +1312,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  bail_qp:
>  	kfree(qp->s_ack_queue);
>  	kfree(qp->r_sg_list);
> -	kfree(qp);
> -
> -bail_swq:
>  	vfree(swq);
> -
>  	return ret;
>  }
>=20
> @@ -1769,7 +1747,6 @@ int rvt_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  	rdma_destroy_ah_attr(&qp->alt_ah_attr);
>  	free_ud_wq_attr(qp);
>  	vfree(qp->s_wq);
> -	kfree(qp);
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/sw/rdmavt/qp.h
> b/drivers/infiniband/sw/rdmavt/qp.h
> index 2cdba1283bf6..bceb77c28c71 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.h
> +++ b/drivers/infiniband/sw/rdmavt/qp.h
> @@ -52,9 +52,8 @@
>=20
>  int rvt_driver_qp_init(struct rvt_dev_info *rdi);
>  void rvt_qp_exit(struct rvt_dev_info *rdi);
> -struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
> -			    struct ib_qp_init_attr *init_attr,
> -			    struct ib_udata *udata);
> +int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
> +		  struct ib_udata *udata);
>  int rvt_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		  int attr_mask, struct ib_udata *udata);
>  int rvt_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
> diff --git a/drivers/infiniband/sw/rdmavt/vt.c
> b/drivers/infiniband/sw/rdmavt/vt.c
> index ac17209816cd..d4526f38427e 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -131,6 +131,13 @@ static int rvt_query_device(struct ib_device *ibdev,
>  	return 0;
>  }
>=20
> +static int rvt_get_numa_node(struct ib_device *ibdev)
> +{
> +	struct rvt_dev_info *rdi =3D ib_to_rvt(ibdev);
> +
> +	return rdi->dparms.node;
> +}
> +
>  static int rvt_modify_device(struct ib_device *device,
>  			     int device_modify_mask,
>  			     struct ib_device_modify *device_modify)
> @@ -380,6 +387,7 @@ static const struct ib_device_ops rvt_dev_ops =3D {
>  	.destroy_srq =3D rvt_destroy_srq,
>  	.detach_mcast =3D rvt_detach_mcast,
>  	.get_dma_mr =3D rvt_get_dma_mr,
> +	.get_numa_node =3D rvt_get_numa_node,
>  	.get_port_immutable =3D rvt_get_port_immutable,
>  	.map_mr_sg =3D rvt_map_mr_sg,
>  	.mmap =3D rvt_mmap,
> @@ -406,6 +414,7 @@ static const struct ib_device_ops rvt_dev_ops =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, rvt_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, rvt_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, rvt_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, rvt_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, rvt_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, rvt_ucontext, ibucontext),
>  };
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c
> b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 0b8e7c6255a2..ffa8420b4765 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -41,7 +41,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES]
> =3D {
>  		.size		=3D sizeof(struct rxe_qp),
>  		.elem_offset	=3D offsetof(struct rxe_qp, pelem),
>  		.cleanup	=3D rxe_qp_cleanup,
> -		.flags		=3D RXE_POOL_INDEX,
> +		.flags		=3D RXE_POOL_INDEX |
> RXE_POOL_NO_ALLOC,
>  		.min_index	=3D RXE_MIN_QP_INDEX,
>  		.max_index	=3D RXE_MAX_QP_INDEX,
>  	},
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index f7b1a1f64c13..267b5a9c345d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -391,59 +391,52 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq,
> const struct ib_recv_wr *wr,
>  	return err;
>  }
>=20
> -static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
> -				   struct ib_qp_init_attr *init,
> -				   struct ib_udata *udata)
> +static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *ini=
t,
> +			 struct ib_udata *udata)
>  {
>  	int err;
> -	struct rxe_dev *rxe =3D to_rdev(ibpd->device);
> -	struct rxe_pd *pd =3D to_rpd(ibpd);
> -	struct rxe_qp *qp;
> +	struct rxe_dev *rxe =3D to_rdev(ibqp->device);
> +	struct rxe_pd *pd =3D to_rpd(ibqp->pd);
> +	struct rxe_qp *qp =3D to_rqp(ibqp);
>  	struct rxe_create_qp_resp __user *uresp =3D NULL;
>=20
>  	if (udata) {
>  		if (udata->outlen < sizeof(*uresp))
> -			return ERR_PTR(-EINVAL);
> +			return -EINVAL;
>  		uresp =3D udata->outbuf;
>  	}
>=20
>  	if (init->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	err =3D rxe_qp_chk_init(rxe, init);
>  	if (err)
> -		goto err1;
> -
> -	qp =3D rxe_alloc(&rxe->qp_pool);
> -	if (!qp) {
> -		err =3D -ENOMEM;
> -		goto err1;
> -	}
> +		return err;
>=20
>  	if (udata) {
> -		if (udata->inlen) {
> -			err =3D -EINVAL;
> -			goto err2;
> -		}
> +		if (udata->inlen)
> +			return -EINVAL;
> +
>  		qp->is_user =3D true;
>  	} else {
>  		qp->is_user =3D false;
>  	}
>=20
> -	rxe_add_index(qp);
> +	err =3D rxe_add_to_pool(&rxe->qp_pool, qp);
> +	if (err)
> +		return err;
>=20
> -	err =3D rxe_qp_from_init(rxe, qp, pd, init, uresp, ibpd, udata);
> +	rxe_add_index(qp);
> +	err =3D rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
>  	if (err)
> -		goto err3;
> +		goto qp_init;
>=20
> -	return &qp->ibqp;
> +	return 0;
>=20
> -err3:
> +qp_init:
>  	rxe_drop_index(qp);
> -err2:
>  	rxe_drop_ref(qp);
> -err1:
> -	return ERR_PTR(err);
> +	return err;
>  }
>=20
>  static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> @@ -1145,6 +1138,7 @@ static const struct ib_device_ops rxe_dev_ops =3D {
>  	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>  	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h
> b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 959a3260fcab..ac2a2148027f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -210,8 +210,8 @@ struct rxe_resp_info {
>  };
>=20
>  struct rxe_qp {
> -	struct rxe_pool_entry	pelem;
>  	struct ib_qp		ibqp;
> +	struct rxe_pool_entry	pelem;
>  	struct ib_qp_attr	attr;
>  	unsigned int		valid;
>  	unsigned int		mtu;
> diff --git a/drivers/infiniband/sw/siw/siw_main.c
> b/drivers/infiniband/sw/siw/siw_main.c
> index cf55326f2ab4..9093e6a80b26 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -297,6 +297,7 @@ static const struct ib_device_ops siw_device_ops =3D =
{
>=20
>  	INIT_RDMA_OBJ_SIZE(ib_cq, siw_cq, base_cq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, siw_pd, base_pd),
> +	INIT_RDMA_OBJ_SIZE(ib_qp, siw_qp, base_qp),
>  	INIT_RDMA_OBJ_SIZE(ib_srq, siw_srq, base_srq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, siw_ucontext, base_ucontext),
>  };
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c
> b/drivers/infiniband/sw/siw/siw_qp.c
> index ddb2e66f9f13..7e01f2438afc 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -1344,6 +1344,4 @@ void siw_free_qp(struct kref *ref)
>  	siw_put_tx_cpu(qp->tx_cpu);
>=20
>  	atomic_dec(&sdev->num_qp);
> -	siw_dbg_qp(qp, "free QP\n");
> -	kfree_rcu(qp, rcu);
>  }
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> b/drivers/infiniband/sw/siw/siw_verbs.c
> index 3f175f220a22..1b36350601fa 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -285,16 +285,16 @@ siw_mmap_entry_insert(struct siw_ucontext
> *uctx,
>   *
>   * Create QP of requested size on given device.
>   *
> - * @pd:		Protection Domain
> + * @qp:		Queue pait
>   * @attrs:	Initial QP attributes.
>   * @udata:	used to provide QP ID, SQ and RQ size back to user.
>   */
>=20
> -struct ib_qp *siw_create_qp(struct ib_pd *pd,
> -			    struct ib_qp_init_attr *attrs,
> -			    struct ib_udata *udata)
> +int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
> +		  struct ib_udata *udata)
>  {
> -	struct siw_qp *qp =3D NULL;
> +	struct ib_pd *pd =3D ibqp->pd;
> +	struct siw_qp *qp =3D to_siw_qp(ibqp);
>  	struct ib_device *base_dev =3D pd->device;
>  	struct siw_device *sdev =3D to_siw_dev(base_dev);
>  	struct siw_ucontext *uctx =3D
> @@ -307,17 +307,16 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
>  	siw_dbg(base_dev, "create new QP\n");
>=20
>  	if (attrs->create_flags)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>=20
>  	if (atomic_inc_return(&sdev->num_qp) > SIW_MAX_QP) {
>  		siw_dbg(base_dev, "too many QP's\n");
> -		rv =3D -ENOMEM;
> -		goto err_out;
> +		return -ENOMEM;
>  	}
>  	if (attrs->qp_type !=3D IB_QPT_RC) {
>  		siw_dbg(base_dev, "only RC QP's supported\n");
>  		rv =3D -EOPNOTSUPP;
> -		goto err_out;
> +		goto err_atomic;
>  	}
>  	if ((attrs->cap.max_send_wr > SIW_MAX_QP_WR) ||
>  	    (attrs->cap.max_recv_wr > SIW_MAX_QP_WR) ||
> @@ -325,13 +324,13 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
>  	    (attrs->cap.max_recv_sge > SIW_MAX_SGE)) {
>  		siw_dbg(base_dev, "QP size error\n");
>  		rv =3D -EINVAL;
> -		goto err_out;
> +		goto err_atomic;
>  	}
>  	if (attrs->cap.max_inline_data > SIW_MAX_INLINE) {
>  		siw_dbg(base_dev, "max inline send: %d > %d\n",
>  			attrs->cap.max_inline_data, (int)SIW_MAX_INLINE);
>  		rv =3D -EINVAL;
> -		goto err_out;
> +		goto err_atomic;
>  	}
>  	/*
>  	 * NOTE: we allow for zero element SQ and RQ WQE's SGL's
> @@ -340,19 +339,15 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
>  	if (attrs->cap.max_send_wr + attrs->cap.max_recv_wr =3D=3D 0) {
>  		siw_dbg(base_dev, "QP must have send or receive
> queue\n");
>  		rv =3D -EINVAL;
> -		goto err_out;
> +		goto err_atomic;
>  	}
>=20
>  	if (!attrs->send_cq || (!attrs->recv_cq && !attrs->srq)) {
>  		siw_dbg(base_dev, "send CQ or receive CQ invalid\n");
>  		rv =3D -EINVAL;
> -		goto err_out;
> -	}
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		rv =3D -ENOMEM;
> -		goto err_out;
> +		goto err_atomic;
>  	}
> +
>  	init_rwsem(&qp->state_lock);
>  	spin_lock_init(&qp->sq_lock);
>  	spin_lock_init(&qp->rq_lock);
> @@ -360,7 +355,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
>=20
>  	rv =3D siw_qp_add(sdev, qp);
>  	if (rv)
> -		goto err_out;
> +		goto err_atomic;
>=20
>  	num_sqe =3D attrs->cap.max_send_wr;
>  	num_rqe =3D attrs->cap.max_recv_wr;
> @@ -482,23 +477,20 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
>  	list_add_tail(&qp->devq, &sdev->qp_list);
>  	spin_unlock_irqrestore(&sdev->lock, flags);
>=20
> -	return &qp->base_qp;
> +	return 0;
>=20
>  err_out_xa:
>  	xa_erase(&sdev->qp_xa, qp_id(qp));
> -err_out:
> -	if (qp) {
> -		if (uctx) {
> -			rdma_user_mmap_entry_remove(qp->sq_entry);
> -			rdma_user_mmap_entry_remove(qp->rq_entry);
> -		}
> -		vfree(qp->sendq);
> -		vfree(qp->recvq);
> -		kfree(qp);
> +	if (uctx) {
> +		rdma_user_mmap_entry_remove(qp->sq_entry);
> +		rdma_user_mmap_entry_remove(qp->rq_entry);
>  	}
> -	atomic_dec(&sdev->num_qp);
> +	vfree(qp->sendq);
> +	vfree(qp->recvq);
>=20
> -	return ERR_PTR(rv);
> +err_atomic:
> +	atomic_dec(&sdev->num_qp);
> +	return rv;
>  }
>=20
>  /*
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.h
> b/drivers/infiniband/sw/siw/siw_verbs.h
> index 67ac08886a70..09964234f8d3 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.h
> +++ b/drivers/infiniband/sw/siw/siw_verbs.h
> @@ -50,9 +50,8 @@ int siw_query_gid(struct ib_device *base_dev, u32
> port, int idx,
>  		  union ib_gid *gid);
>  int siw_alloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
>  int siw_dealloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
> -struct ib_qp *siw_create_qp(struct ib_pd *base_pd,
> -			    struct ib_qp_init_attr *attr,
> -			    struct ib_udata *udata);
> +int siw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attr,
> +		  struct ib_udata *udata);
>  int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
>  		 int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
>  int siw_verbs_modify_qp(struct ib_qp *base_qp, struct ib_qp_attr *attr,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 2dba30849731..8cd7d1fc719f 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2268,8 +2268,13 @@ struct iw_cm_conn_param;
>  			 !__same_type(((struct drv_struct *)NULL)-
> >member,     \
>  				      struct ib_struct)))
>=20
> -#define rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, gfp)                   =
      \
> -	((struct ib_type *)kzalloc(ib_dev->ops.size_##ib_type, gfp))
> +#define rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, gfp)                   =
       \
> +	((struct ib_type *)rdma_zalloc_obj(ib_dev, ib_dev-
> >ops.size_##ib_type, \
> +					   gfp, false))
> +
> +#define rdma_zalloc_drv_obj_numa(ib_dev, ib_type)                       =
       \
> +	((struct ib_type *)rdma_zalloc_obj(ib_dev, ib_dev-
> >ops.size_##ib_type, \
> +					   GFP_KERNEL, true))
>=20
>  #define rdma_zalloc_drv_obj(ib_dev, ib_type)                            =
       \
>  	rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, GFP_KERNEL)
> @@ -2435,9 +2440,8 @@ struct ib_device_ops {
>  			  struct ib_udata *udata);
>  	int (*query_srq)(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
>  	int (*destroy_srq)(struct ib_srq *srq, struct ib_udata *udata);
> -	struct ib_qp *(*create_qp)(struct ib_pd *pd,
> -				   struct ib_qp_init_attr *qp_init_attr,
> -				   struct ib_udata *udata);
> +	int (*create_qp)(struct ib_qp *qp, struct ib_qp_init_attr
> *qp_init_attr,
> +			 struct ib_udata *udata);
>  	int (*modify_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
>  			 int qp_attr_mask, struct ib_udata *udata);
>  	int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
> @@ -2635,11 +2639,18 @@ struct ib_device_ops {
>  	int (*query_ucontext)(struct ib_ucontext *context,
>  			      struct uverbs_attr_bundle *attrs);
>=20
> +	/*
> +	 * Provide NUMA node. This API exists for rdmavt/hfi1 only.
> +	 * Everyone else relies on Linux memory management model.
> +	 */
> +	int (*get_numa_node)(struct ib_device *dev);
> +
>  	DECLARE_RDMA_OBJ_SIZE(ib_ah);
>  	DECLARE_RDMA_OBJ_SIZE(ib_counters);
>  	DECLARE_RDMA_OBJ_SIZE(ib_cq);
>  	DECLARE_RDMA_OBJ_SIZE(ib_mw);
>  	DECLARE_RDMA_OBJ_SIZE(ib_pd);
> +	DECLARE_RDMA_OBJ_SIZE(ib_qp);
>  	DECLARE_RDMA_OBJ_SIZE(ib_rwq_ind_table);
>  	DECLARE_RDMA_OBJ_SIZE(ib_srq);
>  	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
> @@ -2746,6 +2757,15 @@ struct ib_device {
>  	u32 lag_flags;
>  };
>=20
> +static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
> +				    gfp_t gfp, bool is_numa_aware)
> +{
> +	if (is_numa_aware && dev->ops.get_numa_node)
> +		return kzalloc_node(size, gfp, dev-
> >ops.get_numa_node(dev));
> +
> +	return kzalloc(size, gfp);
> +}
> +
>  struct ib_client_nl_info;
>  struct ib_client {
>  	const char *name;
> --
> 2.31.1

