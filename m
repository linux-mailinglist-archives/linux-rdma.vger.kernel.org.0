Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62CACA3641
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfH3MHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 08:07:00 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:16849
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfH3MG7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 08:06:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltMjtylJrf4p4yMaTFE1YIiM3OwY3VzQR0vZfwWG4jgZWNfInMLnhlffgYw517YGRuJl5iISOfKi2fSGSDS9eJNTgLh2OaG1IFsmGvc5OX/q+N1+wbDyDrfJ7diSIQKPBz9OEj9rMBQ50jBP8swb3sDfRIGwJWC+cZ8De3dYNah+ju63OkUbupzVd3g2RY0OoOkwLaFhr81vf4hBkxFERK1FRXvV2zxDnRQoeeZvnFI/98FGiFTzvtwCrEbYYYGla1TKCQEoKJVeTbyMlH5v2HRN0nnvplgNPII2cJRFrDqfQy0ts6p6evrVcWk9DPGpB3TZ/dPuEZ1j3cxTzfmN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2pWBBUmyG6tvnLTWwXglj4XF4REIJTT30KBrn7mywo=;
 b=cI3dwmU83OvmEz1IeYEOkovjkJyVyQ0HAg9WO10kXe3XUtP2LOpfy7CXRQUssz7R4wnj9deo69izYN9xynBhCzF6k6p2Bam35e7aOdpr0LZgacvhvG/hhZjMJNgbOCRQKeZ6FWHONreVlJxXkB+ujqkjA6nJBx14GratUJF1VcZFf3bihmUoFlYLRNmw9FwJQnGFcK+6hb0HNTLDqKw4uPk//HoT/M5LTIF94OVW+wGnLH3PDCk6mKfzcPsccMR16eyiGl0+zBK0ORcWKsPan8tlk/hIJlMqVx7uPK0tcAOckNz6yk87064dMBORqmW+Eb1dOc9EpU4q5U0B+adUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2pWBBUmyG6tvnLTWwXglj4XF4REIJTT30KBrn7mywo=;
 b=Kl8VopevnwgoY7JWtVi4cflvAWChybhZ9JiJaI2j3dEyXjmJXFSeM+0r6Lu4i4DnIgB1Ew6n7waYIyTav7bN80B+iSW4F+1R99jKGq6julXLqNstK7yzq7nGXA0Zm/aAacF1qtpeIh0nbpaX+CKiuQWo9BWapQx/i2VS5yH04o4=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5058.eurprd05.prod.outlook.com (20.177.40.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 30 Aug 2019 12:06:16 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea%6]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 12:06:16 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: RE: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Thread-Topic: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Thread-Index: AQHVXws90ig9Yg1V4Ua7T78ElUX516cTejiAgAAPY4CAAA4pIA==
Date:   Fri, 30 Aug 2019 12:06:15 +0000
Message-ID: <AM0PR05MB486610B252DCDD895D82EF0DD1BD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-4-leon@kernel.org>
 <AM0PR05MB4866C7620535722AD791DA7FD1BD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20190830111245.GF12611@unreal>
In-Reply-To: <20190830111245.GF12611@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.18.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e333c6f-6545-4b67-6e8f-08d72d42759e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB5058;
x-ms-traffictypediagnostic: AM0PR05MB5058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB50580D6D9FDDF2EC5583DA18D1BD0@AM0PR05MB5058.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(13464003)(316002)(229853002)(33656002)(486006)(11346002)(256004)(76116006)(64756008)(81166006)(7696005)(508600001)(8676002)(25786009)(305945005)(26005)(9686003)(5660300002)(8936002)(55236004)(54906003)(9456002)(53936002)(99286004)(86362001)(66556008)(6246003)(107886003)(71200400001)(76176011)(446003)(66066001)(66946007)(4326008)(66476007)(6436002)(476003)(102836004)(7736002)(14454004)(53546011)(66446008)(6916009)(81156014)(6116002)(3846002)(71190400001)(6506007)(2906002)(52536014)(186003)(14444005)(74316002)(55016002)(79990200002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5058;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E366PK7kM7jS/Nqx3PvZ7hopY/DJoCy5YhSOuTn46g4/LxzSLqXXUXovt3UaS5aeQjXwcwXmue/J436YvLu+ZGQVmTXpAehzNsDDnBgkMFSXNZJK//Ps93v09i096oOu5/q2Ey357N0mZeKR5NDSMGB5KLA4FQwfxK6oaL5YvrR6qFNBCgMhrpWYd9uTxecsaG7YLBKQsVoxCMgojqGuJPXpM0VewI3npVQ+/0QCQ799bhjcdBcuDaleaLGa2zEWjDHw7mw1BAE4Gp79Y5UITm5F2tiHTOsS8SksdmZ/ftcQZmQo9hhmXwVTyzeQ+erTKsU4tfAm70QHT9IEQnpRd6psBmuoSIe8zpCVi6jCKHy1LycudgSKfoDW+KQsEKEUfEinNyNil4W7+Jjc3FHFf7OrFmvj9SUlWRcKCRfMCFT8SOQniE1Ogx/IQvFN6V8ePV1Q7FVBYiR5SOrhEwLcoQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e333c6f-6545-4b67-6e8f-08d72d42759e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 12:06:15.9074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2kYprT3tb4F48Mrzq3eVUqX4utrLiu0J4CAzy1nrg/x4G3YNkPjG+SODafWYpt/3a2gYoOk8OQZEfdSIpYBIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5058
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, August 30, 2019 4:43 PM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>; Erez
> Alfasi <ereza@mellanox.com>
> Subject: Re: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
>=20
> On Fri, Aug 30, 2019 at 10:18:35AM +0000, Parav Pandit wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> > > Sent: Friday, August 30, 2019 1:46 PM
> > > To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> > > <jgg@mellanox.com>
> > > Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> > > rdma@vger.kernel.org>; Erez Alfasi <ereza@mellanox.com>
> > > Subject: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
> > >
> > > From: Erez Alfasi <ereza@mellanox.com>
> > >
> > > Add RDMA nldev netlink interface for dumping MR statistics informatio=
n.
> > >
> > > Output example:
> > > ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
> > >   local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::
> > >
> > > ereza@dev~$: rdma stat show mr
> > > dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0
> > > prefetched_pages 122071
> > >
> > > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > ---
>=20
> <...>
>=20
> > > struct ib_device_ops {
> > >  	 */
> > >  	int (*counter_update_stats)(struct rdma_counter *counter);
> > >
> > > +	/**
> > > +	 * fill_odp_stats - Fill MR ODP stats into a given
> > > +	 * ib_odp_counters struct.
> > > +	 * Return value - true in case counters has been filled,
> > > +	 * false otherwise (if its non-ODP registered MR for example).
> > > +	 */
> > > +	bool (*fill_odp_stats)(struct ib_mr *mr, struct ib_odp_counters
> > > *cnt);
> > > +
> > Requesting ODP stats on non-ODP MR is an error.
> > Instead of returning bool, please return int =3D -EINVAL as an error fo=
r non ODP
> MRs.
>=20
> We don't want to add extra checks in the drivers for something that is su=
pposed
> to be checked by upper layer. If caller asks for ODP statistics, he will =
check that
> MR is ODP backed. Especially if the need to have ODP MR is embedded into =
the
> function name.
>=20
That make sense. In that case return type should be void.
Comment says - "false otherwise (if its non-ODP registered MR for example).=
"

And with that logic,
Below code should be in upper layer instead of mlx5/main.c

+	if (!is_odp_mr(mr))
+		return false;
