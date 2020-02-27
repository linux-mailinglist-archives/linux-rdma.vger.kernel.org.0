Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC88172BC0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 23:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgB0Wtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 17:49:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:50862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgB0Wts (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 17:49:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="285485191"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2020 14:49:47 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 14:49:46 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 14:49:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 27 Feb 2020 14:49:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWHJDo74VFQpo9TecMliz9J3KRkxxJRgEHk227OEEFvps+G1SdeKKEmb+i7ou1L/u3VrNBrS3xTufyHPFbvNONd+p4a90awZc0YtnnBN1Ex/ionHJr4ed0oKFcHNScd52ICVvRtOIeugs2fFGapLBn5LY4TcxaQxhr12DQvPShrgY0Q4I3dy4+R4j9aCcg0BpjOu7oPtbT4whjWSV70Sm9OMUCrS6ySw7CqPS5aZfbk6Gpg/9O54B4hfyC5vT5r9LrgZ0sPsfNd/t3jY5ahQeyFwfODXkYGa0UfoJWHu8CqXz+9i30t4hPaVGjhiHK4IgerTh1AXvt6nPsyDLmpXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbcH+LeuhHYoFyVks1FquYIw7YXy1r/3bS93t/sg5Vo=;
 b=SF/0MupuQ4qFDO+WQN+fRrWSndKhcBdCQcPqr9BCAWhKPWiuQeWGGQXiAKkonMLVQk7f6j7/KiHBSGPifPAqhpmXmAymuSOsMvC9LHiga6sPKrvNqZE5X0mzsgWfjlElBidJPC5qrBvPv2Ylx84qW2QcaEi5mS3XnHLbMjjoLT2dEY+47p2KQPyXXxXYLqe3KmU6i5fOLN2Qb8y0RQ9G7jQVE5jdm/UhK0fHo0bdLP2gDI31HeS1YiHDrXBXNzJ8RFV/D21AFsMY2TtQXjGSzEc9Pzeifk08rl5AGsc3cGxWMaOKZs9R4zROvDVj4s7NzoOzFJgb/Vz8BWO9SXHmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbcH+LeuhHYoFyVks1FquYIw7YXy1r/3bS93t/sg5Vo=;
 b=Xjglsp/tjlRZ4NZtavmjb2m30cKz7O8QsiVjG6uCkjN9rTK6/749TVBJPE+G4jL+MXMO7n9bCdQLEMQUNZFKL3BKseZ4g8EJ3MXE8Ek8726+O1Hfv8XwRh4YpZiMJHLwEnmxPQkdz2/3TTAe72/ilBARfhDHgEF3qm4uLjNmCPk=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 (2603:10b6:301:52::23) by MWHPR1101MB2223.namprd11.prod.outlook.com
 (2603:10b6:301:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Thu, 27 Feb
 2020 22:49:45 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::105c:a59b:7fca:234c]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::105c:a59b:7fca:234c%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 22:49:45 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Thread-Topic: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Thread-Index: AQHV7W2M4yEpf3CQsUeYRETD+oyVSKgvDcVggABX/gCAADwrYA==
Date:   Thu, 27 Feb 2020 22:49:45 +0000
Message-ID: <MWHPR1101MB227182E4E00015AD2850AFF486EB0@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <20200227125728.100551-1-leon@kernel.org>
 <CY4PR1101MB2262DAEFBC6C06EDF69B0F1286EB0@CY4PR1101MB2262.namprd11.prod.outlook.com>
 <20200227190126.GO12414@unreal>
In-Reply-To: <20200227190126.GO12414@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fde6f3e9-9807-4ab4-4a2a-08d7bbd757ae
x-ms-traffictypediagnostic: MWHPR1101MB2223:
x-microsoft-antispam-prvs: <MWHPR1101MB22237FE404ADA9D0815E453B86EB0@MWHPR1101MB2223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(186003)(9686003)(8936002)(316002)(86362001)(66946007)(8676002)(5660300002)(54906003)(66556008)(55016002)(66446008)(64756008)(66476007)(81166006)(81156014)(6916009)(76116006)(26005)(4326008)(2906002)(478600001)(71200400001)(7696005)(6506007)(52536014)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2223;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jiNM8t+rkFIL20i5DM3zACQ3/OvqI/vGhlV9ul8MLX8ZGSorboC3nZlAY7DqPAF2QBysl0NVk+WCNGje2/exZBtxDNKWY76PYge06aPsSZPlxDaO8El24xjKhuzFFPJzMEQNre6hcwOab3BDsQ4r8r4aI/QJcYjchxtvv2Fh0uff1Bul3uxhmEna+h1vd410/ibnMdM6d7Fug0dswZiUIT5u/joaZEXnLEHdKDUku04UeCDXAC8FGHQMaw03qxwoaCisFx2+TWiAGJvIriGwIZU+62N0SHgBp8n7M0lqcnRQOiKYqYYX2zMYChGJlN4taN0Tg9c8tdpU8Z3LuKt4e++U2R4+3MN31dV4m/422xnLp5bmpYtjoTuDKzP8HRTZ6xFrRjj8zIc3IFeL9dyDy2QRJ9urO8lMUv7i14fD64q7lmN5Q/HlHw2k1SkeDZ4z
x-ms-exchange-antispam-messagedata: C5nrkrDxOwSEcP9TjLGpti48zQhJKOWdqSw0TRXvk+7A9qtkfT/MIXlB5iQavgHNJwQh9qe6EvTdbgdwdseJK9JeQJc0uv6ErLwlebQYheL75vIsexStQBPLMw7gn+8awLEbEpGDJwkrCrCMxmj5tQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fde6f3e9-9807-4ab4-4a2a-08d7bbd757ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 22:49:45.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkFb0/f5Fp0bMBabMGcz+W7YD5Ur30K+/ZePBtXUEXkI/uHLFxJgl5m/OIdmG573tBqgT+5BNHv0EffGKNuQVd6fL/os2UQ+6cA/w0Hzb6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2223
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Thu, Feb 27, 2020 at 02:07:10PM +0000, Marciniszyn, Mike wrote:
> > >
> > > From: Maor Gottlieb <maorg@mellanox.com>
> > >
> > > When port is part of the modify mask, then we should take
> > > it from the qp_attr and not from the old pps. Same for PKEY.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in
> > > get_pkey_idx_qp_list")
> > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > ---
> > >  drivers/infiniband/core/security.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/security.c
> > > b/drivers/infiniband/core/security.c
> > > index b9a36ea244d4..2d5608315dc8 100644
> > > --- a/drivers/infiniband/core/security.c
> > > +++ b/drivers/infiniband/core/security.c
> > > @@ -340,11 +340,15 @@ static struct ib_ports_pkeys
> *get_new_pps(const
> > > struct ib_qp *qp,
> > >  		return NULL;
> > >
> > >  	if (qp_attr_mask & IB_QP_PORT)
> > > -		new_pps->main.port_num =3D
> > > -			(qp_pps) ? qp_pps->main.port_num : qp_attr-
> > > >port_num;
> > > +		new_pps->main.port_num =3D qp_attr->port_num;
> > > +	else if (qp_pps)
> > > +		new_pps->main.port_num =3D qp_pps->main.port_num;
> > > +
> > >  	if (qp_attr_mask & IB_QP_PKEY_INDEX)
> > > -		new_pps->main.pkey_index =3D (qp_pps) ? qp_pps-
> > > >main.pkey_index :
> > > -						      qp_attr->pkey_index;
> > > +		new_pps->main.pkey_index =3D qp_attr->pkey_index;
> > > +	else if (qp_pps)
> > > +		new_pps->main.pkey_index =3D qp_pps->main.pkey_index;
> > > +
> > >  	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask &
> > > IB_QP_PORT))
> > >  		new_pps->main.state =3D IB_PORT_PKEY_VALID;
> > >
> >
> > I agree with this aspect of the patch and it does fix the panic, becaus=
e the
> correct unit
> > is gotten from qp_pps.
> >
> > My issue is that the new_pps->main.state will come back as 0, and the
> insert routine will drop any new pkey index update.
> >
> > The sequence I'm concerned about is:
> >
> > 0x71 attr mask with both pkey index and port.
> >
> > A ulp decides to change the pkey index and does an 0x51 modify without
> setting the unit.
> >
> > I see new_pps->main.state being returned as 0 and port_pkey_list_insert=
()
> will early out.
>=20
> I see, maybe we can store the main.state in qps and restore it from there=
?
>=20

I don't think we need to go that far.

I think all we need to do is=20

	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
		new_pps->main.state =3D IB_PORT_PKEY_VALID;
	 else if ((qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
                             /*
		 * one of the attributes modified and already copied above.
		 *
		 * correct the state based on qp_pps state
		 */
		if (qp_pps->main.state !=3D IB_PORT_PKEY_NOT_VALID)
			new_pps->main.state =3D IB_PORT_PKEY_VALID;
	}

I'm ok will a follow-up patch after Maor's patch to fix remaining issues.

Right now, all of our upstream testing (5.6 rc3+, stables) is dead because =
of 1dd017882e01.

Mike




