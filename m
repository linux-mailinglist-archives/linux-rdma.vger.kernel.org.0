Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCF171E93
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgB0O23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 09:28:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:53676 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbgB0OHT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 09:07:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 06:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="272205388"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2020 06:07:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 06:07:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Feb 2020 06:07:16 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 06:07:16 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 27 Feb 2020 06:07:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV/lq2cHAK07pJdFzJ3ekkHrt4+Ebm0L8g2VdAXB/HZaxEXWhjUiYGBtZjgbTG0bKYHmNzRmPct3BYQhPFjUGa9KAlQBkcZe6wOaklnY6nIuKdDsttTGq2+OV482p9Feygm7HixurmSbLqhtRDBC9Sie3+sFhR13dHk0Me11/XWsmqhO38TZW0/hCQdHJpE4JMuaLW0sc22pgn+CE76lkM+QL9JmEtfKJMjqeNeE9mu4trojrIHh0bm/Th6VSmNX1KlMcurFjuPmmusMND3OIw3Z611o8r08sktqhPqn/z1R7YJWOL/J3Ce2iBpCalNdFB7qmvGVXhaFqh3emB5W4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMQcaKVRW/SIeeNpXVpAMLSwA61k3ZPMi+SMh+g04sk=;
 b=h7qh6t9uAmAiPftZZjepoCyXal0olbNXJuRh1olJjwYpvHM6S/d9jBA6+RwhtMKg22H/KjfUu4Tskf9I7RBscy2jbovq8/v5WT3LisnMNcm7G9cl/IkMvvXiP4AiO5OhGJrLXpgoAjwcohSF68vVkADsM3YLOEGDOMrXxyhr8cXpzoqa0E/J88Og450fdROJUJRU0qh2o+OK10zF4N6kkNeiWs/kRZSYXXxTYx6/15jOj0yox13S6OOswkbB6ArqK/j8ubeLxAYeeF6itkue3EGsPDzix6TBf+58YlQgKVFz7OWgcTmzp0mZMmyiaFI03qQ061V9oFq1MgtdD7wI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMQcaKVRW/SIeeNpXVpAMLSwA61k3ZPMi+SMh+g04sk=;
 b=r/TdSoGSBSAH8b1Hui16bTA48bmbcg81DgaU0hEhNJcY0ItEGFLpApnqjb5k7ktF/CIQvgWAadYwPXV/phNwBcVKWVBX0g/PtbZFNIfT0mdikGkUpUGlSrtOS6s8UNu//nd9cCh05ScoBTPUCROzXyZAVKk+7aDCGo7qXBCsQ64=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (2603:10b6:910:18::7)
 by CY4PR1101MB2104.namprd11.prod.outlook.com (2603:10b6:910:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 14:07:10 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::41d8:8839:d18d:3f9d]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::41d8:8839:d18d:3f9d%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 14:07:10 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Maor Gottlieb <maorg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Thread-Topic: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Thread-Index: AQHV7W2M4yEpf3CQsUeYRETD+oyVSKgvDcVg
Date:   Thu, 27 Feb 2020 14:07:10 +0000
Message-ID: <CY4PR1101MB2262DAEFBC6C06EDF69B0F1286EB0@CY4PR1101MB2262.namprd11.prod.outlook.com>
References: <20200227125728.100551-1-leon@kernel.org>
In-Reply-To: <20200227125728.100551-1-leon@kernel.org>
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
x-ms-office365-filtering-correlation-id: 719618b7-cb30-409f-dd9c-08d7bb8e5662
x-ms-traffictypediagnostic: CY4PR1101MB2104:
x-microsoft-antispam-prvs: <CY4PR1101MB2104582FF89B5BCA2AEBA0EE86EB0@CY4PR1101MB2104.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(6506007)(52536014)(2906002)(76116006)(4326008)(5660300002)(54906003)(966005)(498600001)(86362001)(66946007)(33656002)(110136005)(7696005)(186003)(55016002)(9686003)(26005)(71200400001)(66476007)(81156014)(8676002)(81166006)(8936002)(66556008)(64756008)(66446008)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2104;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRHI3ISVGulMx8uoZ7V9sw79Mn5sYC0P2oYXTpdb1q45rn9Xktt2j2saAA2EA0GnmH90usYamD+6CdX10ZOBbF0ZuLV2Q4aG8B5xBK/LhBmcvmKVz6gOCS4lv452g4580wCqzobeMkSHttyzEB770fII5/2qevzs/nFGpJ0Rpvae5lQg3OY//g2Tae68UhLGhmAN2UU28UgQyu0i+pOiA0b6qtyi42QfZzRrh0+Yvx3vsWNWskaNtSMN+Oa/SHl9I/MN2U1n3y184+ZKA8ju3Vtg8+xeb4oblHFLoNyuOgI3RUV579nEv+3p2GCHahK8//ZlnTI3ziy+ihWt2K8S/DS1yEi1fRNV85CIusKz78siNZLE2iduLgyDzbdCAbwH3Mk98/dVJ5QN29Uak2+EqFQqq7GzvCc2Jo2NpOm/DEclOFnugE3EmSp7gWJU8Ozo2vwPAq+lqnHj1t88+xtEGAEn3Iij39kDpftopMXydJlfQea+mcJ79sgaWdpln23F6QbmCz8JfbqoBT9twhzYC5O5hQlzOtn/KqBEIYbOxSqQMqQhn9wxXVdWK0JvALiW
x-ms-exchange-antispam-messagedata: CxNpgcbgOnh6zB1KzVUckymf1oeOAunO72bD+U4RccN6I5r0aoRhJQRE4rc7d8YZOOMfK0+TrED9WQZjksgb8REjrZ1olYIPlB99aC7phT0d45Cjz2vn5Jh7jaar1TlG7n7XPWAz+Fhr0FSxhCU1UQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 719618b7-cb30-409f-dd9c-08d7bb8e5662
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:07:10.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9EENtYa0wpr78OTcOAQu6CwqpnVWOXYrJ/16hcgKCOh5K41OkHM/nRU6UeXToXOvi0vQwAnt2x9Lihck7i+MD2dsnHwW6x7lBhtu6Al+ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2104
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>=20
> From: Maor Gottlieb <maorg@mellanox.com>
>=20
> When port is part of the modify mask, then we should take
> it from the qp_attr and not from the old pps. Same for PKEY.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in
> get_pkey_idx_qp_list")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/security.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/security.c
> b/drivers/infiniband/core/security.c
> index b9a36ea244d4..2d5608315dc8 100644
> --- a/drivers/infiniband/core/security.c
> +++ b/drivers/infiniband/core/security.c
> @@ -340,11 +340,15 @@ static struct ib_ports_pkeys *get_new_pps(const
> struct ib_qp *qp,
>  		return NULL;
>=20
>  	if (qp_attr_mask & IB_QP_PORT)
> -		new_pps->main.port_num =3D
> -			(qp_pps) ? qp_pps->main.port_num : qp_attr-
> >port_num;
> +		new_pps->main.port_num =3D qp_attr->port_num;
> +	else if (qp_pps)
> +		new_pps->main.port_num =3D qp_pps->main.port_num;
> +
>  	if (qp_attr_mask & IB_QP_PKEY_INDEX)
> -		new_pps->main.pkey_index =3D (qp_pps) ? qp_pps-
> >main.pkey_index :
> -						      qp_attr->pkey_index;
> +		new_pps->main.pkey_index =3D qp_attr->pkey_index;
> +	else if (qp_pps)
> +		new_pps->main.pkey_index =3D qp_pps->main.pkey_index;
> +
>  	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask &
> IB_QP_PORT))
>  		new_pps->main.state =3D IB_PORT_PKEY_VALID;
>=20

I agree with this aspect of the patch and it does fix the panic, because th=
e correct unit
is gotten from qp_pps.

My issue is that the new_pps->main.state will come back as 0, and the inser=
t routine will drop any new pkey index update.

The sequence I'm concerned about is:

0x71 attr mask with both pkey index and port.

A ulp decides to change the pkey index and does an 0x51 modify without sett=
ing the unit.

I see new_pps->main.state being returned as 0 and port_pkey_list_insert() w=
ill early out.

I asked this exact question in https://marc.info/?l=3Dlinux-rdma&m=3D158278=
763015030&w=3D2.

I also asked about the logical or, and you answered that pointing to an add=
itional patch.

You but didn't address the main.state being 0 and losing the pkey_index upd=
ate in the 0x51 modify.

Mike






