Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D373E4D9D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Aug 2021 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhHIUH6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 16:07:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:12300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233617AbhHIUH5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Aug 2021 16:07:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="194363172"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="194363172"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 13:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="515362681"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2021 13:07:36 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 13:07:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 9 Aug 2021 13:07:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 9 Aug 2021 13:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH5ifyIFhX6NhfQxmkT5Y+rceIZhBIoGhHMU3daoY+pvM6uf6Qi/uKvw5pSoERI/qlUaHHc7/5jrpclCo9d9UShx7IomaPgNqkoFbAVvLC3cIQFU8VCJLgSW6hA1j2rSlWAUTfVchQMo9B8OqKj/6tGFUdR43UYScYaEYEDUOnkBDdbW+QldxInGeGQznx/tXGLwDkWi7tFsFIEAVRnskqoVURaaKO8MgYR7PY816yRhJNuecOFzmuoJEyuMvV5+kBz5rT6RTNY6/9KDUcV8DwmaBXxY5juKzATYruDQS8gTL5XA3LB13LcFd1UbJqep1t2DNAsQR3TV9sPGlq3Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG9od8MMYhHpMv/EyH6FoepOHLKvNKFUVR19j+/VEuQ=;
 b=SkuWHgXOCJW4pVxCIJkAKLqT9e7F4oE3OnbYqDbw5lz2UXw5fNlRjACGIik4ymNWundsyxRtpbUBrP4Puw1GKVl+yeig7GnyNzOZCSzMmn8REJ5qIji5puBAngXJxqTCLQNykWELX6poqLFrC+XU9L8HesxQtOJld5sGicaV2WQKdHVYOGmAPgRugNJqTImAqOnDdm5P51J6xswXgOKiYi3IqLxREEVwtXdyvkudJ8/iMoJvPrUmie7b6hkosybThsYJVdhx3Bip/eDXftokayZgj6fmnjLOYwio0ON53/7GfGMdbTdP0xe29sYQtBehmIwMmFnWwRcaHPgucroXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG9od8MMYhHpMv/EyH6FoepOHLKvNKFUVR19j+/VEuQ=;
 b=ahPymP6BrANhZD+qwyfPa4snqVmylVbUG/GvnZKk6nqOK1A5/wh8xYXAR+nf+2yAeTpT1o6I8ItLr2e9g3IgsB595qZp/u7ZRR89EbNO5x1rcEEmnLYwxncDDcRd12c6Z+t5M7xAYXx3d5SeYTSRq7hYe70fYZSAZ3ijw82SjVw=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB2538.namprd11.prod.outlook.com (2603:10b6:5:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 20:07:32 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c%3]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 20:07:32 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-core] irdma: Restore full memory barrier for doorbell
 optimization
Thread-Topic: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Thread-Index: AQHXihS+EJKXfIrCVkG1+TWSsRynBqtlsKuAgAXsBEA=
Date:   Mon, 9 Aug 2021 20:07:32 +0000
Message-ID: <DM6PR11MB4692155E49A76F8789881338CBF69@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210805161134.1234-1-tatyana.e.nikolova@intel.com>
 <20210806012853.GP1721383@nvidia.com>
In-Reply-To: <20210806012853.GP1721383@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 3f6713ed-b061-4f1b-3ed7-08d95b7152d6
x-ms-traffictypediagnostic: DM6PR11MB2538:
x-microsoft-antispam-prvs: <DM6PR11MB2538C4E6DE5B732BF71BD36CCBF69@DM6PR11MB2538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXXgove0MYDnopT9mQLvXD8ptxWASQfnVHwoaBbmZaDbpPl7MXIyHiMm77dFTjixHonLUnI6BYTxJ/f99ScQNQ2A75CxrCD+qdJBSAqH+W+8To4PML6BfevnzFfNVNMdhkd6N9BEuE3W7N3iyg6ffLVQUEB8MB1Srx95ghlgPx54BffudNunT0pHOsml0K5EHYaogqkaI68cAukz8hJKsghK8q5XB8TpO9wXh54oyVjWz9afOZLcgdX82U6lV1Mu7ur8dSHIbSOjahGiECI30hdp8BEs1EhUAxXK395vJ7QzK0k38dKrHitMjBTpOm56BaNljbDnOX748Hkz7cP4QzVOECWUWeA18ArkwDUbOqoD/aS6bJ2WptKdm7prwRn+0/04WhncrhcUvYeIe844a2GxOJoBFQTJaKhmbl1if/gvJrULP+HQJxtgPl4k5QQw/6T7dabwXGnwrZUNe0kYnjjHRMLKDIoC+RG07PnvX+iWKHcrRIgXpyrg3juIwzNaNZDBbw708t82GMhUzFR2E6MmxOsEj3x+xxvWTlVrpq8Bp19zzb68k5t19DBbduD2NCuOpjVy3dFMFX41RZ8U4j+OdUAP5dO9K5hHraK0YOGkTgFLtfzpzBlNRN4BdXG77LX7dhYC7tzKEL0lP/IJ2++bbLZmqZGOqM+IQeVl9Rk2DpUIa/8HYmxRMZOvH+zfvP2lRDgEsVSGc37z1olnKIPOioi3xciGGiNE8NvOPbr9AaGFlS4BMsHMX9LHRJu0j8qYkOrQQO0iF6ZMro/ej2ywoMJ5Du7yfGojYzDxsc6Mamemq65PbG6uEQw9Iq3WdX+zb125GCzM2agz3K4mJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(122000001)(6916009)(316002)(9686003)(52536014)(76116006)(4326008)(66476007)(33656002)(71200400001)(38070700005)(8936002)(5660300002)(186003)(66446008)(66556008)(38100700002)(64756008)(66946007)(966005)(54906003)(53546011)(86362001)(6506007)(83380400001)(478600001)(7696005)(2906002)(55016002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ONUM+Q2/kj65WvoGo4qdYc/wM0PwUn16/HKUtB8ZLusJhb4wjX92iiwI3GiH?=
 =?us-ascii?Q?Run+Gt4SGEUW78bZvGJ2clyeD+nG+aQmz6iz4fC98bGfcZ1ik+rZ6v9WrgoW?=
 =?us-ascii?Q?rv9b9zKDRRSoiYrlfi97Fnq9etJyjhEIUy+1KOKBxqwkhL8aGmCmDnAYnIxQ?=
 =?us-ascii?Q?CTUxlIPlNv4SAZG6CXqgIl+q7dDLH8RBdKmNc3xgtxUqxARter5f9GaAEsKw?=
 =?us-ascii?Q?ZXWy/oIRO9+4qAWpYR5hgllB4KQX6GeLBLMKWIWattIs1hqL3U70HRywdsH1?=
 =?us-ascii?Q?e1KGB+XH8I69I8xrxFHnb2nlchrLhnqbrQV84ScJNNxtJhpxwxEx069KfY8u?=
 =?us-ascii?Q?pRiUESlwYT7STKjgnJPBibGxlkXEz39x+fIXczf1de5nuAtorgp87UxAJmk8?=
 =?us-ascii?Q?fivuZc0piE3J0dY1qG4mjgRECrMJbi85lVZGJ74O+ZqYxfc+CFYqrEXVz5B0?=
 =?us-ascii?Q?O2VU+6xkUDlUfLAEe+jsPmYowZksyxAzEYVHFmRpG4U/5n8axVb1hjX7Zz1i?=
 =?us-ascii?Q?OdKullT+r4SHgaZ58i/GjM5n6btC1xrvtYCQhVagWpQaLqsNY4w7vEMwP/V3?=
 =?us-ascii?Q?0zb/O9Ss67q8imH+vQa8xM3N0HV/y9wR9VAqmZdywsNpgVuL5v3CwgVtebec?=
 =?us-ascii?Q?hoR67EusrFcQJFfJMtZ/DDrT1/epF4UbJ+IKn2VoI24lJ8U6s04X1ZuwR2/m?=
 =?us-ascii?Q?9BAPN9xNGg46Mg1/6pa+MW8itjNe5U0lbDgxyNSz/wef4/bg7qeEuUWAuThD?=
 =?us-ascii?Q?6n9+XeUR5P6KHMjy4RCGBkyiqHjiISEfYzgz8AEIFl3OtR/is2UTvh6Vo8Hw?=
 =?us-ascii?Q?Dfv3a03xekDq8I9nKvmIlyG1w5/JcEdbLHSpxyo281oLHsiK11Eog6/XWmIG?=
 =?us-ascii?Q?g7t3V9HDLmfD3Iw2QUNo+CIskVN//9ldGU0UoFPWJrMb7rchJWiRdo4IQAwr?=
 =?us-ascii?Q?i9RcrJZK2htdehOFRm36sEGUFLA46UXPZWzc+zmMSvpzWxt6gukeVrHOWm2/?=
 =?us-ascii?Q?HkKp/8h5HM9YdOcB9jclhJ2VU+AiDPu7twHybp8zpVN3/u8iYLmr2e47Snqp?=
 =?us-ascii?Q?Tp3YEm5kuUDhd1/ATplKtfNiFTYoFJXJa9wnvyrgO1rWKfG+Nh8yAY8Mrlzz?=
 =?us-ascii?Q?YCdQ6yvjodnTYzFmUN2elchKd+KQi0pRLto8+Fh01OBw4Gn4hcDX7fq/+YuD?=
 =?us-ascii?Q?XYFQT81UVknS9HL6INPphfOxnRb/9MRNbxzyGHTHL30SVf1b/T2HplhUYTgZ?=
 =?us-ascii?Q?L+81xKLg8LkzYzTuZg2zDmEvJ5xlaP2VMgllzyZ87Hdqm1h22onVX/V/GnTO?=
 =?us-ascii?Q?mFbjWhk+rSDnY/uUhxrq5HSag972YloQgpl+feEXvlxcu6LJAcWU/TplZISn?=
 =?us-ascii?Q?mo9egiZhWoB60NruSvOuPLeeyOPb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6713ed-b061-4f1b-3ed7-08d95b7152d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 20:07:32.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9y5Bws6yFzTa3O5vljY365fI+pIha7dhkWoXIwb2TAxhHDObNRSSjJ2HTPg2VFUFZYFol05Rb+jD853cdtYiZwyg+czzwGyW/ssTTviDw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 5, 2021 8:29 PM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
> doorbell optimization
>=20
> On Thu, Aug 05, 2021 at 11:11:34AM -0500, Tatyana Nikolova wrote:
> > During the irdma library upstream submission we agreed to replace
> > atomic_thread_fence(memory_order_seq_cst) in the irdma doorbell
> > optimization algorithm with udma_to_device_barrier().
> > However, further regression testing uncovered cases where in absence
> > of a full memory barrier, the algorithm incorrectly skips ringing the
> > doorbell.
> >
> > There has been a discussion about the necessity of a full memory
> > barrier for the doorbell optimization in the past:
> > https://lore.kernel.org/linux-rdma/20170301172920.GA11340@ssaleem-
> MOBL
> > 4.amr.corp.intel.com/
> >
> > The algorithm decides whether to ring the doorbell based on input from
> > the shadow memory (hw_tail). If the hw_tail is behind the sq_head,
> > then the algorithm doesn't ring the doorbell, because it assumes that
> > the HW is still actively processing WQEs.
> >
> > The shadow area indicates the last WQE processed by the HW and it is
> > okay if the shadow area value isn't the most current. However there
> > can't be a window of time between reading the shadow area and setting
> > the valid bit for the last WQE posted, because the HW may go idle and
> > the algorithm won't detect this.
> >
> > The following two cases illustrate this issue and are identical,
> > except for ops ordering. The first case is an example of how the wrong
> > order results in not ringing the doorbell when the HW has gone idle.
>=20
> I can't really understand this explanation. since this seemes to be about=
 a
> concurrency problem can you please explain it using a normal ladder
> diagram? (eg 1a3402d93c73 ("posix-cpu-timers: Fix rearm racing against
> process tick") to pick an example at random)
>
Hi Jason,

The doorbell optimization algorithm involves the following operations:

1.	Software writing the valid bit in the WQE.
2.	Software reading shadow memory (hw_tail) value.
3.	Software deciding whether or not to ring the doorbell.
4.	Hardware reading that WQE.

Without the MFENCE after step 1, the processor is free to move instructions=
 around - it can move the write of the valid bit later (after software read=
s the hw_tail value). =20

MFENCE ensures the order of 1 and 2.=20

MFENCE (Vol. 1 11-12)
"The MFENCE instruction establishes a memory fence for both loads and store=
s. The processor ensures that no load or store after MFENCE will become glo=
bally visible until all loads and stores before MFENCE are globally visible=
"

If the order of 1 and 2 is not maintained, the algorithm can fail because t=
he hardware may not see the valid bit and the doorbell optimization algorit=
hm does not ring the doorbell. This causes hardware to go idle even though =
there is work to do.

The failure scenario without the MFENCE is shown in a ladder diagram:

SOFTWARE                        CPU                                  DMA DE=
VICE

Writes the valid bit
SFENCE
Reads the hw_tail value

                                              <Reorders instructions>
                                              Reads hw_tail value=20

Decides not to ring the doorbell.

                                                                           =
             Reads WQE - <valid bit is not set and hardware goes idle>
                                              Writes valid bit
			   SFENCE
=09
The order of 1 and 2 is not maintained which causes hardware to go idle eve=
n though there is work to do.

Our doorbell optimization algorithm has always required a full memory barri=
er because it prevents reordering of stores and loads.
There used to be an MFENCE in the i40iw doorbell algorithm. In a previous d=
iscussion, https://lore.kernel.org/linux-rdma/20170306194052.GB31672@obsidi=
anresearch.com/, you suggested the use of atomic_thread_fence(memory_order_=
seq_cst), which is a C11 barrier, and this did work for us.

Thank you,
Tatyana

=20
> > diff --git a/providers/irdma/uk.c b/providers/irdma/uk.c index
> > c7053c52..d63996db 100644
> > +++ b/providers/irdma/uk.c
> > @@ -118,7 +118,7 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk
> *qp)
> >  	__u32 sw_sq_head;
> >
> >  	/* valid bit is written and loads completed before reading shadow */
> > -	udma_to_device_barrier();
> > +	atomic_thread_fence(memory_order_seq_cst);
>=20
> Because it certainly looks wrong to replace a DMA barrier with something
> that is not a DMA barrier.
>=20
> I'm guessing this problem is that the shadow memory is not locked and als=
o
> not using using atomics to control concurrent access it? If so then the f=
ix is to
> use atomics for the shadow memory and place the proper order
> requirement on the atomic itself.
>=20
> Jason
