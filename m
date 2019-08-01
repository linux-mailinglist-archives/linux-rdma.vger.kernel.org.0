Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F317DA07
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 13:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHALKh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 07:10:37 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50120 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfHALKg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 07:10:36 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x71BAB6c011913;
        Thu, 1 Aug 2019 04:10:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EGK51eWlmCGPfX0zzRve/bK0xuPZoZRY49sZkgF9s6c=;
 b=fFN3cYXvy55JHnrr6R4K86rq/fSHmvvwZPSuwXPRmIrcdxYy132mkniRmRZG5jUmnKpK
 BsZWzHZ753dI3CNZvwK24fgm7UNO1XZqtupi6K6k3I2Tq1hdias+O+6cIhlWGqDWWCmi
 Bqzx495/I0Wn0Qmh2oGwll41BSSUuakLZkka3IwqIsNd+GTkLTdlpWlhTa3M7WGabUe3
 Fo+OcpLOX++WiNUs+dnXIg+Q6Z0qHiBEJBaMsnhg2aQxx5KaMniadzPXqCjSarX9sWhs
 joUEJ7HQDQep60yY5t2r8Zgl77B/1x3+IpGI8uCHIw+C4qjDBY5uAGo2Eep9Msp/I0Wt mA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2u3jujjnby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:10:13 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 1 Aug
 2019 04:10:12 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 1 Aug 2019 04:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDbh/AJdHW3+HdRMXBU9XvgJW2Z2qrDPjEWS7dXPKCX+70AtPPWtcVNwQok/k31/CeqtxbUx8srPHlnGa199xczXdOS1s9r+vQGrdn6plg3Dg5Mu8vcHhePKUNi9GKiGJlOSJHk1Nvk0HSdRxnOTYAnlfj608JuuNqUUe3WYas2Ygz5AD1PVDhi8zGYQKrIKw+strgV+OtSpImhN7e71qM6X1ov0qeeYiH9ASIBzkdVbEGWoBZcAQhgOAas/DDEu7VKlWiAsYqTBMP0JsaT/5wDwahgJ3VBCYjp/5Bkfm2zie7YHbuzqYtmWj4KiLDJuYDop0S/YfwoShZ3CicOaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGK51eWlmCGPfX0zzRve/bK0xuPZoZRY49sZkgF9s6c=;
 b=d+0rTiO/iuE9sigdmFJM6MT/D7YGNF60n/67YjY75HRxBYRa8glaK2N63nR6Da16p9gI2QxPfWAGuFnDGgSvssP4XuhrfVzYA17dofCIDf3NUUxVNQcOFRS8r3r3Arw8XYd5qIl6j5m8XPbUpyK2YwQUlZPMgEny+d33wnRp0iQjP+heQmEzuEOkZZ6oppbigM85n3BldXvQFCzu4shxXT6wjw9whH2V+GZ769ot1hq7Xk9mQ8gZRjLa+TMTh6FNImqEiz51zfofcovdPdYQ7BLSUwGcTQof2OPKASTk8NgxNt0HC4+SGgnlU7AgbLt1DQ5+DNEDOTQGPhzjzoBUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGK51eWlmCGPfX0zzRve/bK0xuPZoZRY49sZkgF9s6c=;
 b=dqb5eQLH+J8zPYQbgxkX0GhLGAfgSIeEMsxYENn/Lvvi+iNIxJLIwAt+wjHH51AVHooJeDmPFmEDXEG/uDpfKMgBsLb758xnROzMMhbwbrZYE5Joxr6rF2sCsDYrpP3HeB7SRMLZAhdW1XmB1+CDBaeu/nPzxjH6+ATLsTh0Ipc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3085.namprd18.prod.outlook.com (20.179.21.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 11:10:11 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 11:10:11 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        "Moni Shoua" <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>
Subject: RE: [PATCH for-next V2 3/4] RDMA/core: Add common iWARP query port
Thread-Topic: [PATCH for-next V2 3/4] RDMA/core: Add common iWARP query port
Thread-Index: AQHVR94V6gQKyDKZS0a1tcQLvU05c6bmIXLQ
Date:   Thu, 1 Aug 2019 11:10:11 +0000
Message-ID: <MN2PR18MB3182171DC6B1F23380A5B67EA1DE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190731202459.19570-1-kamalheib1@gmail.com>
 <20190731202459.19570-4-kamalheib1@gmail.com>
In-Reply-To: <20190731202459.19570-4-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92dd84a-1196-4d55-1c6c-08d71670d230
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3085;
x-ms-traffictypediagnostic: MN2PR18MB3085:
x-microsoft-antispam-prvs: <MN2PR18MB3085DD21BA0BA7FFC62FFFEDA1DE0@MN2PR18MB3085.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39850400004)(136003)(396003)(376002)(189003)(199004)(3846002)(6116002)(7696005)(99286004)(76176011)(68736007)(6506007)(7416002)(478600001)(26005)(71200400001)(66066001)(316002)(186003)(14444005)(256004)(71190400001)(305945005)(14454004)(54906003)(110136005)(74316002)(5660300002)(33656002)(6246003)(53936002)(52536014)(446003)(229853002)(11346002)(8676002)(2906002)(81166006)(81156014)(8936002)(66946007)(86362001)(2501003)(102836004)(486006)(55016002)(9686003)(4326008)(66446008)(66476007)(7736002)(66556008)(6436002)(476003)(25786009)(76116006)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3085;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e4wiVYhGbDopTj7b5M523N6fmEM4THsM6ppHepIH7sTFOq2PsKNZ2Vo2s6fpk6/BUErkyt6MOVPHPc7ic4FSds1pB/5NHtemMDkaurtvCgjAfa2nejXPwd9Bn7D7BMwL7+r/DPp+O8NIQ3muSLxbmWr+pDipUe6M7SbtaxeLwwMdZY/eQ+wpNUp5Z1Hhw6e03/G5Wbf3hhYvPhtl5HsprL0IQaxgMhZ2QkpmPndCqifspjeQdq8dU1/lDf0kFBbQDPgKYyU5s5Icv3t9LJ9ITt0x72KAl7vXTq4/xKdOWDUaSs/kr/vs/4iF+bEztARXbdPknov+s5oky7fMxjoQuoQTHR8VEH9xAG7vAtnZMGwSgeqxAtAmcFy3YxXMhtwwydMIS35MMJGhl+lynRrYKlDf2PZKoI1oVseA7EWaLWs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a92dd84a-1196-4d55-1c6c-08d71670d230
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 11:10:11.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3085
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-01_06:2019-07-31,2019-08-01 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Kamal Heib
>=20
> Add support for a common iWARP query port function, the new function
> includes a common code that is used by the iWARP devices to update the
> port attributes like max_mtu, active_mtu, state, and phys_state, the
> function also includes a call for the driver-specific query_port callback=
 to
> query the device-specific port attributes.
>=20
Thanks, the qedr is also a iWARP device but it has most of the code common =
with
The RoCE part, so we'll need to split the code earlier between the protocol=
s.=20
However, why not make the code for port-state and mtu common for Both iWARP=
 + RoCE?=20
=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 87 ++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index 9773145dee09..860c08ca49e7 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1940,31 +1940,64 @@ void ib_dispatch_event(struct ib_event *event)
> }  EXPORT_SYMBOL(ib_dispatch_event);
>=20
> -/**
> - * ib_query_port - Query IB port attributes
> - * @device:Device to query
> - * @port_num:Port number to query
> - * @port_attr:Port attributes
> - *
> - * ib_query_port() returns the attributes of a port through the
> - * @port_attr pointer.
> - */
> -int ib_query_port(struct ib_device *device,
> -		  u8 port_num,
> -		  struct ib_port_attr *port_attr)
> +static int iw_query_port(struct ib_device *device,
> +			   u8 port_num,
> +			   struct ib_port_attr *port_attr)
>  {
> -	union ib_gid gid;
> +	struct in_device *inetdev;
> +	struct net_device *netdev;
>  	int err;
>=20
> -	if (!rdma_is_port_valid(device, port_num))
> -		return -EINVAL;
> +	memset(port_attr, 0, sizeof(*port_attr));
> +
> +	netdev =3D ib_device_get_netdev(device, port_num);
> +	if (!netdev)
> +		return -ENODEV;
> +
> +	dev_put(netdev);
> +
> +	port_attr->max_mtu =3D IB_MTU_4096;
> +	port_attr->active_mtu =3D ib_mtu_int_to_enum(netdev->mtu);
> +
> +	if (!netif_carrier_ok(netdev)) {
> +		port_attr->state =3D IB_PORT_DOWN;
> +		port_attr->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
> +	} else {
> +		inetdev =3D in_dev_get(netdev);
> +
> +		if (inetdev && inetdev->ifa_list) {
> +			port_attr->state =3D IB_PORT_ACTIVE;
> +			port_attr->phys_state =3D
> IB_PORT_PHYS_STATE_LINK_UP;
> +			in_dev_put(inetdev);
> +		} else {
> +			port_attr->state =3D IB_PORT_INIT;
> +			port_attr->phys_state =3D
> +
> 	IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
> +		}
> +	}
> +
> +	err =3D device->ops.query_port(device, port_num, port_attr);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int __ib_query_port(struct ib_device *device,
> +			   u8 port_num,
> +			   struct ib_port_attr *port_attr)
> +{
> +	union ib_gid gid =3D {};
> +	int err;
>=20
>  	memset(port_attr, 0, sizeof(*port_attr));
> +
>  	err =3D device->ops.query_port(device, port_num, port_attr);
>  	if (err || port_attr->subnet_prefix)
>  		return err;
>=20
> -	if (rdma_port_get_link_layer(device, port_num) !=3D
> IB_LINK_LAYER_INFINIBAND)
> +	if (rdma_port_get_link_layer(device, port_num) !=3D
> +	    IB_LINK_LAYER_INFINIBAND)
>  		return 0;
>=20
>  	err =3D device->ops.query_gid(device, port_num, 0, &gid); @@ -1974,6
> +2007,28 @@ int ib_query_port(struct ib_device *device,
>  	port_attr->subnet_prefix =3D be64_to_cpu(gid.global.subnet_prefix);
>  	return 0;
>  }
> +
> +/**
> + * ib_query_port - Query IB port attributes
> + * @device:Device to query
> + * @port_num:Port number to query
> + * @port_attr:Port attributes
> + *
> + * ib_query_port() returns the attributes of a port through the
> + * @port_attr pointer.
> + */
> +int ib_query_port(struct ib_device *device,
> +		  u8 port_num,
> +		  struct ib_port_attr *port_attr)
> +{
> +	if (!rdma_is_port_valid(device, port_num))
> +		return -EINVAL;
> +
> +	if (rdma_node_get_transport(device->node_type) =3D=3D
> RDMA_TRANSPORT_IWARP)
Raising a question, in some places we use the macro above and in others
rdma_protocol_iwarp(device, port_num), any reason to prefer one over the ot=
her ?=20
 thanks,

> +		return iw_query_port(device, port_num, port_attr);
> +	else
> +		return __ib_query_port(device, port_num, port_attr); }
>  EXPORT_SYMBOL(ib_query_port);
>=20
>  static void add_ndev_hash(struct ib_port_data *pdata)
> --
> 2.20.1

