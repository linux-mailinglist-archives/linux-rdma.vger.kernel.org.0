Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E879CD00FF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfJHTL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:11:58 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:64438
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfJHTL6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 15:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2xROmF4d+Pp4YYBtbmkt0KthK/VLbXg9ULia+Cdq1hLIVYB1MKYlDp38090SeIJYKehFA5LuE+jQg4AWnMQgS80An17rQhjbZ5VCcyrToM+U8gtOhxcKUCBCWD0AOg/HZv8sQOTFDA+Z8tbZPaOYsYdoB9kKW7D3QnhFtSXNNcGhaZf8pnaI8Zs7T2x+3t6Jx96Zb5FjoR4gzHi/3NtvkUcdOX3hBymcZC3uYjBHJgcphIyx7/bjDrGrPPJPS7Oiqx0LglpldMfrDX7YSrJkh21tVZcMB31f4rwMDUGeRk4TczVVrRv/napOiEAkKz5kO8oQAY96R8A3EHbGIaZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8htpNZDASIGmPw3i8Kun1QKyEHCZw33Ybq64DNR5OI=;
 b=TjvU3I7e3je3fj8sg8e2UHI7Thp68DgpN/w3baiCPOJoJFh52i3fcRpo6hFIjmx7Nhu90LVM3Q7vLBzZROXGk3HmKWLduGpztxHWDeNFnQPOYgbyDZvaDY0QiH5bbqZnwes26eOCaxT9jWqlONROmBuuxudFTz5WiWjB8gEAQoW4fN8YFZ8aPuV4oCZHZ//pYbvZ0xCytJVUct8CEtw3EclJaYpUwTyJQKhYEKxOqaoN1q0zy6juXWDavj+yjqhE1Xc9pgEWMIVanBCrbIiBI7F0h7KHQ2bAOCxIA3eF/52gAUGUuz8mY9vF582P1aCGoZnz0cE63yxVu1XF5P3JVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8htpNZDASIGmPw3i8Kun1QKyEHCZw33Ybq64DNR5OI=;
 b=XAc8zjZo/c1H3LaWYd0XETMJyPkcbRMPg2jGRbxM2ifvuNmYPOvZOH5IsWfYlmXHoyNr+9KJmxkdbgBFxxUp3xPLoRNpW9LQY6UJwhfhzRv1N8XUIhpSJdrXUqy3Bg9fWYkDwICbcv7cplwJ6Xs66j7GsgoHk214njqvy3YBgrY=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5801.eurprd05.prod.outlook.com (20.178.107.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 19:11:55 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 19:11:55 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Parav Pandit <parav@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Thread-Topic: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Thread-Index: AQHVeR2GNtAqj5zxy0SbSlG1bpnDoKdPkBuAgAGWJIA=
Date:   Tue, 8 Oct 2019 19:11:55 +0000
Message-ID: <20191008191151.GD22714@mellanox.com>
References: <20191002123245.18153-1-leon@kernel.org>
 <20191002123245.18153-3-leon@kernel.org>
 <AM0PR05MB4866CB24D8105C83B31988A3D19B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866CB24D8105C83B31988A3D19B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae263ca3-5f7a-46ce-e948-08d74c236236
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB5801:|DB7PR05MB5801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB58019515D37BD63E592A661ACF9A0@DB7PR05MB5801.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(229853002)(6862004)(478600001)(99286004)(102836004)(6486002)(52116002)(86362001)(25786009)(71190400001)(6636002)(186003)(26005)(71200400001)(6246003)(81156014)(8936002)(4326008)(6436002)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(81166006)(14454004)(6506007)(386003)(6512007)(76176011)(2616005)(1076003)(5660300002)(4744005)(7736002)(486006)(446003)(66066001)(256004)(11346002)(305945005)(476003)(37006003)(36756003)(54906003)(316002)(3846002)(6116002)(2906002)(33656002)(26730200005)(19860200003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5801;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ah1BVc0jmipTMOO6m2Be9gcSmjt5B05avBgGAva5mHhEmvsUx8G9GniB79GxNCiDme3cjC1xA8tvvINxEdH/3hMMeLuyYpKG8sQBXwzTBp9CpOYceyz16SEhjomgKogC6CCpnh8z/oTRjiS1SetQcG4dgc2ELdY+KmBfMKi7wO9CmDIpHvatJj+wh+YMcrN6Y/2GXlIRzkTOqxpMNHaWyM5qoodePDyIZ5pIrPW1uc1tMg3PFog2dvCr4lfSa/soRxwDAatiK41ROa1WW3oogvp1qiwEdeioruQCY1i8T0peeH/kdzXh5XDXWgNo9bzaE+bu4BCtPOuApNIL2ZfJ3abNCuzI9fFqOh+HaR0rF0XjEMLcRCtBhVJb35oAlo2x0uchup83OgDJYjoW3uzbpc79BMNjQSZwveB54T+8wwI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <705ADE423DC8D04BAE0EDF8F67E9DF68@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae263ca3-5f7a-46ce-e948-08d74c236236
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 19:11:55.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOcihfQsbHXl4RwxCzNq5aOt/pH4C5J/9sBKaKrAMT07jjw3ZW1lQ+C2IIyZMeiWscPFuA24DuDTTdMi2KhMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5801
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 07, 2019 at 06:58:13PM +0000, Parav Pandit wrote:
> > +	 * 2. Task is dead and in zombie state. There is no need to print PID
> > anymore.
> > +	 */
> > +	if (pid)
> > +		/*
> > +		 * This part is racy, task can be killed and PID will be zero right
> > +		 * here but it is ok, next query won't return PID. We don't
> > promise
> > +		 * real-time reflection of SW objects.
> > +		 */
> > +		err =3D nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
> > +
> > +out:
> > +	return err ? -EMSGSIZE : 0;
> >  }
>=20
> Below code reads better along with rest of the comments in the patch.
>=20
> if (kern_resource) {
> 	err =3D nla_put_string(msg, RDMA_NLDEV_ATTR_RES_KERN_NAME,
> 			     res->kern_name);
> } else {
> 	pid_t pid;
>=20
> 	pid =3D task_pid_vnr(res->task);
> 	if (pid)
> 		err =3D nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
> }

I tend to agree, that the pid =3D=3D 0 happens for !kernel is pretty
indirect

Jason
