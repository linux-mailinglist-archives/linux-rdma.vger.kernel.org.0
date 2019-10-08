Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E6D0161
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfJHTpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:45:35 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:4902
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729647AbfJHTpf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 15:45:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+F6ssytyY4TnLtygMBcHyBUaYKRa+NIpjK0Rl0yYS6mKKly5HzvB4mPcKDwP8ZZWGNkQDzwn0YbhR1U6r8eypHORDdlf9dbW4wnIKbFg9aAp5kmGSD5jatVcOi99vyEFq+RdMe3a2LO3AmJBMCxZ/dwjk6l/AzzFh+qf/ylL1xSW5LF5SmXsAnZxM6g10KEeQ/LzdiT8O14rH6h8Bf3CrhpQuI1Hu4SZbTkviUVMrZCugXhVTLXxNud7eriWQ/AmxQ4wjyHM1Gwx6F9oZEFALpPsfD8CKjgALm9NGPLT7fqjDnruwN1K0APt75wofiaSw2QWQTiVKOCkDZGxaPBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65b5cbeCer7mxF1bj5fBoeH/82Oxi+w2AA/wlgV6auU=;
 b=Mo/xlXX7JE+D7p67XmKSSFblZcODEuCk/a/fZH0NnIQ4HkpNno1TA3hDlax7haIcfs8b5GtwatHw/NdvOa4ugH9xhEccGGd1HJfDTY0tT2vFs7DGh0hqWDu/sjSYdmSlpy41yMuIT71hbtJ9peouXU0aOE8SO0qAikvtM+6TgTc7fuTT4OtQHJE/Yv9ZoHaJxLzbqlJG2N7VrC3GZPgiBhzVU0W6Q3Zo4RVr1t89v7Jmmx1FNDuPrit0ric0sFyRV1vToFoFuOgoVRM3zS9RNh27EkRLDQp5sfXSGlImhZqDUoUPQA1ilrkof3ppY+2/TaIzHEPsA3QvTu3okL2/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65b5cbeCer7mxF1bj5fBoeH/82Oxi+w2AA/wlgV6auU=;
 b=KwJN6QgJUum+w9L5sCayeDqlOTjLP+1jKyEWyep5ZHGdeprdv0EpXopzpqKiYTLx68FBqJt3pAxBdlBo/+uM9f+F311qdMJm/4LzgoYGVPIv1/dzB1++dfloyWMO8WSWtzTNN0v8OIvB0b6egr8fIbQIWYDzIg/OBQa5sfR0MHs=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6481.eurprd05.prod.outlook.com (20.179.33.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 19:44:49 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 19:44:49 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH rdma-next] IB/cma: Honor traffic class from lower
 netdevice for RoCE
Thread-Topic: [PATCH rdma-next] IB/cma: Honor traffic class from lower
 netdevice for RoCE
Thread-Index: AQHVeRu7APklED6//0qYIliB9nIFH6dRJcSAgAAJNCA=
Date:   Tue, 8 Oct 2019 19:44:48 +0000
Message-ID: <AM0PR05MB48668C582A96F040B4F4C7D4D19A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191002121959.17444-1-leon@kernel.org>
 <20191008191005.GA13576@ziepe.ca>
In-Reply-To: <20191008191005.GA13576@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2038768a-8ac5-4d27-c68f-08d74c27fabd
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR05MB6481:|AM0PR05MB6481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB64817F66B7DAF12BB8632B23D19A0@AM0PR05MB6481.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(13464003)(199004)(189003)(26005)(316002)(186003)(55016002)(6506007)(53546011)(486006)(76176011)(7696005)(9686003)(102836004)(54906003)(86362001)(110136005)(66946007)(5660300002)(74316002)(66446008)(64756008)(66556008)(66476007)(7736002)(76116006)(305945005)(52536014)(6436002)(6116002)(14444005)(66066001)(256004)(2906002)(6246003)(107886003)(14454004)(3846002)(8676002)(8936002)(81156014)(81166006)(71190400001)(4326008)(478600001)(99286004)(229853002)(71200400001)(476003)(446003)(11346002)(33656002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6481;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PImrTrrwT75sfp7rmC5E9OcNCYSKnqHQztFrojtme7CC74d5kU4aNVZys4GcGe3rQ1sV3bmyOoLTY4Nho7hW9RDca6/Nk+Wmb4tAFJQKVe1Lt47CAPM56oG3b5hJgbnZZbaKKqWIneTiYVqNltAHVXr+cKJK3wpSpo1ckfmMNFsJcbw5J/g9VCXiKUHVCc33Tr+jt92ItqmtHW1UypJbqbs2w+M3JT4AOkqGjrX2zrMw/UwSpKDgmOsPjkzAaKtBpAmGPoZSaLByq45UcZ/syj4AScOoA5PhmTaDctsSmcOEK23DAES47FU3YkD60CB3kHVRGwMUiwJJG8W+GG1dPC+Qp4RVNv2I7ss0zRFGx9ztT2Y6lHoRIKtPUAo/jY+LPymk2UqkdACsPauDCIOKsg3ocPaLun+srLJSZ+YdUCw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2038768a-8ac5-4d27-c68f-08d74c27fabd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 19:44:48.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Y49KLjHg/UVSPIApmITw5EbcSMcM8RQ9phQPgESBpgSJlDfomZOslMnPdQuSaJBTaBYd6Mq0f03Tr55sBI4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6481
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 8, 2019 2:10 PM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> <parav@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Leon Romanovsky <leonro@mellanox.com>
> Subject: Re: [PATCH rdma-next] IB/cma: Honor traffic class from lower
> netdevice for RoCE
>=20
>=20
> On Wed, Oct 02, 2019 at 03:19:59PM +0300, Leon Romanovsky wrote:
> > From: Parav Pandit <parav@mellanox.com>
> >
> > When macvlan netdevice is used for RoCE, consider the tos->prio->tc
> > mapping as SL using its lower netdevice.
> > 1. If lower netdevice is VLAN netdevice, consider such VLAN netdevice
> > and it's parent netdevice for mapping 2. If lower netdevice is not a
> > VLAN netdevice, consider tc mapping directly from such lower netdevice
> >
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > drivers/infiniband/core/cma.c | 59 +++++++++++++++++++++++++++++------
> >  1 file changed, 50 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cma.c
> > b/drivers/infiniband/core/cma.c index 0e3cf3461999..18b5ad8c7d5f
> > 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -2827,22 +2827,63 @@ static int cma_resolve_iw_route(struct
> rdma_id_private *id_priv)
> >  	return 0;
> >  }
> >
> > -static int iboe_tos_to_sl(struct net_device *ndev, int tos)
> > +static int get_vlan_ndev_tc(struct net_device *vlan_ndev, int prio)
> >  {
> > -	int prio;
> >  	struct net_device *dev;
> >
> > -	prio =3D rt_tos2priority(tos);
> > -	dev =3D is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> > +	dev =3D vlan_dev_real_dev(vlan_ndev);
> >  	if (dev->num_tc)
> >  		return netdev_get_prio_tc_map(dev, prio);
> >
> > -#if IS_ENABLED(CONFIG_VLAN_8021Q)
> > +	return (vlan_dev_get_egress_qos_mask(vlan_ndev, prio) &
> > +		VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT; }
> > +
> > +struct iboe_prio_tc_map {
> > +	int input_prio;
> > +	int output_tc;
> > +	bool found;
> > +};
> > +
> > +static int get_lower_vlan_dev_tc(struct net_device *dev, void *data)
> > +{
> > +	struct iboe_prio_tc_map *map =3D data;
> > +
> > +	if (is_vlan_dev(dev))
> > +		map->output_tc =3D get_vlan_ndev_tc(dev, map->input_prio);
> > +	else if (dev->num_tc)
> > +		map->output_tc =3D netdev_get_prio_tc_map(dev, map-
> >input_prio);
> > +	else
> > +		map->output_tc =3D 0;
> > +	/* We are interested only in first level VLAN device, so always
> > +	 * return 1 to stop iterating over next level devices.
> > +	 */
> > +	map->found =3D true;
> > +	return 1;
> > +}
> > +
> > +static int iboe_tos_to_sl(struct net_device *ndev, int tos) {
> > +	struct iboe_prio_tc_map prio_tc_map =3D {};
> > +	int prio =3D rt_tos2priority(tos);
> > +
> > +	/* If VLAN device, get it directly from the VLAN netdev */
> >  	if (is_vlan_dev(ndev))
> > -		return (vlan_dev_get_egress_qos_mask(ndev, prio) &
> > -			VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> > -#endif
> > -	return 0;
> > +		return get_vlan_ndev_tc(ndev, prio);
> > +
> > +	prio_tc_map.input_prio =3D prio;
> > +	netdev_walk_all_lower_dev_rcu(ndev,
> > +				      get_lower_vlan_dev_tc,
> > +				      &prio_tc_map);
>=20
> Kinda looks like you have to hold rcu before calling this?
>=20
Oh yes, my bad.
rcu lock unlock calls are missing around netdev_walk_all_lower_dev_rcu().
Will respin through Leon's tree.

> Jason
