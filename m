Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA2173B14
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgB1PMI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 10:12:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:1929 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgB1PMI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Feb 2020 10:12:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 07:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="231118324"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2020 07:12:07 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Feb 2020 07:12:07 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Feb 2020 07:12:06 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Feb 2020 07:12:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 28 Feb 2020 07:12:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GatWtFhZ34xOHfmcGrV+fl6H7ytRAbRWexdNV2ozqstJNCPyRXzBfCfQU7QHh6BcjWa9xRB+P8Czwt2uoLu0VBT8mH9PO0bMYLsxlHKQ0jzmYgDLL3E/uBq5W86/pyz/x3HY/BO2I2CwbDOzvJP38xSD+rsPzksWOB5Qq2Wot8WIYv/RtkqaK3MTpU6seGMpeWlhxl9eSqFgQDZYr10WLqhK3kEKZwIBpmm2J/9TAR8RjXrN6syyQr8yxaw/Gs0kSxm4+kR7WVFJgdNJlsENpczbMUanzZVTnKRpeFmoNt0uAcBkQ+/yMLd5Vg9lOgMZv/PfoqxIFwNOh6Vfn627Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTf5U1SjGJvihPNQ7rm0vWaS+ahCIJqA+SYi3DVNP+U=;
 b=JU9UyRIKKSLdRLxMu9cPn9+Iw7jCKdAF7uvVhGuEDRPKykK+geI/deMI7/UxE43wJ8DKU/KKPNTw5+xsA3fNRANbmRRmPuWJF7pFugP6h73eDcihCZhf4GFWuEVkRURxvplhgafGkj90m/JCt71LHqf1PiAM8ZFrBbmBZgm7LRjhSkfKVS7pUM6w38AdDfpl4AicoLh1jQ7bHhl9nB3byj2m9/rsWVhQJChRyqCcp9LXWeTxsHAOHl8tKYjVSDht25xlKbj6tN8ViVlVu8SyniX9qgYqleMu2ONY10KTgoVEoSAiIPF4fXhqNd2oTuhb1qHVL61ulTa8kCxuQOFLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTf5U1SjGJvihPNQ7rm0vWaS+ahCIJqA+SYi3DVNP+U=;
 b=Wo7zzXUObvXoqcybk6cqVAjSbQEMk2e0/RIaVy+JhdO+b7LfEF/d8UqhCvCSW1hFJ8CygewI4QDreGvRysFa4lpGIH5csCYDpvEPon+OIvkclQUVxpPsd8Eo5jZZBupUJG5UzXg2j6/TMoAerx3wObO/YY1HN9WJT6pTEklTABo=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 (2603:10b6:301:52::23) by MWHPR1101MB2238.namprd11.prod.outlook.com
 (2603:10b6:301:55::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 15:12:03 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::105c:a59b:7fca:234c]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::105c:a59b:7fca:234c%7]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 15:12:03 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Thread-Topic: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Thread-Index: AQHV7W2M4yEpf3CQsUeYRETD+oyVSKgvDcVggABX/gCAADwrYIABE3kAgAAB4QA=
Date:   Fri, 28 Feb 2020 15:12:03 +0000
Message-ID: <MWHPR1101MB22712F39F1C24B86416CF02586E80@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <20200227125728.100551-1-leon@kernel.org>
 <CY4PR1101MB2262DAEFBC6C06EDF69B0F1286EB0@CY4PR1101MB2262.namprd11.prod.outlook.com>
 <20200227190126.GO12414@unreal>
 <MWHPR1101MB227182E4E00015AD2850AFF486EB0@MWHPR1101MB2271.namprd11.prod.outlook.com>
 <20200228150244.GT26318@mellanox.com>
In-Reply-To: <20200228150244.GT26318@mellanox.com>
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
x-ms-office365-filtering-correlation-id: 9a615119-defe-4ce0-2868-08d7bc609169
x-ms-traffictypediagnostic: MWHPR1101MB2238:
x-microsoft-antispam-prvs: <MWHPR1101MB22387100B75800F94C4619BD86E80@MWHPR1101MB2238.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(76116006)(478600001)(33656002)(7696005)(186003)(64756008)(55016002)(6916009)(9686003)(66476007)(66946007)(316002)(66556008)(54906003)(66446008)(5660300002)(6506007)(26005)(71200400001)(8936002)(4326008)(81166006)(2906002)(81156014)(86362001)(53546011)(8676002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2238;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfcrIkl87TDUOvGHBlNoDrHlkY1FeZuX9hxeJ1bB0xKqzgQo+u6EkQlVnY39Vos78hShsciTyY68OwCESAlHdcDCofrN4tot5ZAdmYuF7oiLK3ukbeqrwGoLsXX6/+c/KcdeLI7tZ/vPNP7rvSXxjhy86rRJiIgQVjxrMY+pWBHjrA6F6IgPHiLdmxHB7nHV0bCaMVCRnyqooTsUSWJMD7ampEVifEwpcjbdgjFrepODIIO5P7uxkYQ1XQlx8Z68eREFWd6vNVWyj8xD/Z2v5TBacernWtSKUonmC4JXOWWS2f9xZ45eACYJW9eM3Q3lOXNlJhOyKegpUOsylXsUpqHS8WGzj9fba5tDohZr1IITwBcbzSkptG31NDfLm6KHKs9Q8yf9BIKZ1cUihTQDf7LED8HZKiPJ8wFZxnRKnQ/gkbfxm3qRET9XN2c5uBKn
x-ms-exchange-antispam-messagedata: vytKB3IvDBBUkLAo6mgdkVxD6uMZnpDp4AzFUgAL8zbB+nkqSbehaAaH0BjPhIgHFXk2xLpzk1idv6dasI1Z3/gTRsKVGLj1zVIYU1zNJme1vOVina3BIHdfkL6ezfY4SqIQy187FYkbjP0FgQMD0g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a615119-defe-4ce0-2868-08d7bc609169
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 15:12:03.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbYph8q/684t/KUQpUqBQu3hpPQQ3MWkBstZf+CCMtZUmHuEA1a0pHCxozX0Y6dlrrksa9HvVyDh7IwMqvoh8FNQdigAfW3Vk91Dz/xLsjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2238
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Friday, February 28, 2020 10:03 AM
> To: Marciniszyn, Mike <mike.marciniszyn@intel.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Doug Ledford
> <dledford@redhat.com>; Maor Gottlieb <maorg@mellanox.com>; linux-
> rdma@vger.kernel.org
> Subject: Re: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
> get_new_pps
>=20
> On Thu, Feb 27, 2020 at 10:49:45PM +0000, Marciniszyn, Mike wrote:
> > > On Thu, Feb 27, 2020 at 02:07:10PM +0000, Marciniszyn, Mike wrote:
> > > > >
> > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > >
> > > > > When port is part of the modify mask, then we should take
> > > > > it from the qp_attr and not from the old pps. Same for PKEY.
> > > > >
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in
> > > > > get_pkey_idx_qp_list")
> > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > >  drivers/infiniband/core/security.c | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/core/security.c
> > > > > b/drivers/infiniband/core/security.c
> > > > > index b9a36ea244d4..2d5608315dc8 100644
> > > > > +++ b/drivers/infiniband/core/security.c
> > > > > @@ -340,11 +340,15 @@ static struct ib_ports_pkeys
> > > *get_new_pps(const
> > > > > struct ib_qp *qp,
> > > > >  		return NULL;
> > > > >
> > > > >  	if (qp_attr_mask & IB_QP_PORT)
> > > > > -		new_pps->main.port_num =3D
> > > > > -			(qp_pps) ? qp_pps->main.port_num :
> qp_attr-
> > > > > >port_num;
> > > > > +		new_pps->main.port_num =3D qp_attr->port_num;
> > > > > +	else if (qp_pps)
> > > > > +		new_pps->main.port_num =3D qp_pps-
> >main.port_num;
> > > > > +
> > > > >  	if (qp_attr_mask & IB_QP_PKEY_INDEX)
> > > > > -		new_pps->main.pkey_index =3D (qp_pps) ? qp_pps-
> > > > > >main.pkey_index :
> > > > > -						      qp_attr-
> >pkey_index;
> > > > > +		new_pps->main.pkey_index =3D qp_attr->pkey_index;
> > > > > +	else if (qp_pps)
> > > > > +		new_pps->main.pkey_index =3D qp_pps-
> >main.pkey_index;
> > > > > +
> > > > >  	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask
> &
> > > > > IB_QP_PORT))
> > > > >  		new_pps->main.state =3D IB_PORT_PKEY_VALID;
> > > > >
> > > >
> > > > I agree with this aspect of the patch and it does fix the panic, be=
cause
> the
> > > correct unit
> > > > is gotten from qp_pps.
> > > >
> > > > My issue is that the new_pps->main.state will come back as 0, and t=
he
> > > insert routine will drop any new pkey index update.
> > > >
> > > > The sequence I'm concerned about is:
> > > >
> > > > 0x71 attr mask with both pkey index and port.
> > > >
> > > > A ulp decides to change the pkey index and does an 0x51 modify
> without
> > > setting the unit.
> > > >
> > > > I see new_pps->main.state being returned as 0 and
> port_pkey_list_insert()
> > > will early out.
> > >
> > > I see, maybe we can store the main.state in qps and restore it from
> there?
> > >
> >
> > I don't think we need to go that far.
> >
> > I think all we need to do is
> >
> > 	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask &
> IB_QP_PORT))
> > 		new_pps->main.state =3D IB_PORT_PKEY_VALID;
> > 	 else if ((qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) &&
> qp_pps) {
> >                              /*
> > 		 * one of the attributes modified and already copied above.
> > 		 *
> > 		 * correct the state based on qp_pps state
> > 		 */
> > 		if (qp_pps->main.state !=3D IB_PORT_PKEY_NOT_VALID)
> > 			new_pps->main.state =3D IB_PORT_PKEY_VALID;
> > 	}
> >
> > I'm ok will a follow-up patch after Maor's patch to fix remaining issue=
s.
>=20
> Are you then OK with the patch Maor posted? Please add a tag. I'm
> waiting for you :)
>=20

Yes, I'm ok with Maor's patch.   It certainly fixes the panic.

I will try the above approach in a subsequent patch.

Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

Mike
