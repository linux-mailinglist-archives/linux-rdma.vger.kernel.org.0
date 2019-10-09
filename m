Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED29AD1178
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfJIOkU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 10:40:20 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:46062
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729491AbfJIOkU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Oct 2019 10:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjvrFnk3A/Iqtoe/L1GpxCpltLBD8BlVBSHO/+3LoXD2LO5kKcYvolmfTi8GejIIDZfPEsQzxy5KHzA17D/HVvp/tn0KXJ5BlR7sNgPQTJ6xwFe1XMO61Ju/bOqZbFYbJfgSS9LzqvHxjIKz05AJKRd+44FlOtZ1225/qorEy8gVnqcZGjKpqhFpiSBenjDsR0UR9r71/m9AII4YOyzLtcKJr2yvJJBwGk8NnjA3vey4it8fFyLazbJpDFrd0SQp1tJQyFhaHaEfm8nHG9IB/f9nUStvkgN9uH/bSaLWqqT1UwbVPi7FUrq3+uxyWCrhVKKinctnqgYcvZg+NEoLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJGZV4qnLdUmFHjipyPrthdODWJjbVG719fOJGbdx44=;
 b=G+QfhC0onu1+UiNx6m/Qagf1pSJURuHi60cstdnMNosDDR3QoSx0uulrq7hIm5SQAyH70CLw45F7LHWMQwU6FXqOTS3aL5R8Cql5M2DzcUe9DkfaQhhQ9jpP/yDL4WMj3Bl+bsPNPfT3Dtg0UkBILpQTE5BDBmUpr889mpUXpgbMzUIDjt66funeMmAXnzS0/tjXFSHg/4WRcUvpO6nCxNvHCvwI46Ih9EclIPDzlAmliQ7hFPcumBfRqzKmEqYtpsqQNc1KHyQap4v06LwpEeqptWL6sPJj/5fJ9Q/OOhxA//WXPg1ZXlFyGddK02zL0xtVUlL4keTDypOztpIa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJGZV4qnLdUmFHjipyPrthdODWJjbVG719fOJGbdx44=;
 b=MXM7+TR+9wwKVGhcNatAIF4vRG7PvB+9QmxBtHym4eMMrjXBbd4hpwc4ubGsjPgO++Qw2OMh9a8xHovqqLH8AaTr14Sfww8dpAtCxN6jHi85uyFDYri5UVmwShbqJmnZMic4UaLzEWjPIJ5LedI39vH9EtDQkNo/zcs0CXqxSMk=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5756.eurprd05.prod.outlook.com (20.178.108.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Wed, 9 Oct 2019 14:40:16 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2327.023; Wed, 9 Oct 2019
 14:40:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/nldev: Provide MR statistics
Thread-Topic: [PATCH rdma-next v2 4/4] RDMA/nldev: Provide MR statistics
Thread-Index: AQHVfF4A2m8QCXadNEO7xAO7BYpkDadSZi0A
Date:   Wed, 9 Oct 2019 14:40:16 +0000
Message-ID: <20191009144012.GJ22714@mellanox.com>
References: <20191006155139.30632-1-leon@kernel.org>
 <20191006155139.30632-5-leon@kernel.org>
In-Reply-To: <20191006155139.30632-5-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:405:75::25) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9beb8a-d88d-425c-d73a-08d74cc699a0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB5756:|DB7PR05MB5756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB5756C716453F95870E999E94CF950@DB7PR05MB5756.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(54906003)(76176011)(316002)(6246003)(107886003)(99286004)(3846002)(6116002)(2906002)(14454004)(5660300002)(71200400001)(71190400001)(478600001)(6512007)(446003)(8936002)(386003)(6486002)(7736002)(186003)(86362001)(11346002)(2616005)(52116002)(25786009)(66446008)(486006)(6506007)(476003)(66946007)(102836004)(36756003)(33656002)(81156014)(81166006)(229853002)(305945005)(256004)(1076003)(6436002)(8676002)(66066001)(6916009)(26005)(64756008)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5756;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67GjGWYA6x7H2vwthMAh2Zd1WL/5SL7KtZXSXkkwfieUH/1b79DPFQRs1IbeVDRSQ7eL4l9azIvqNHPD6EdN0oe/SWUlQYS/waswN/1+eF6GzQe0O8DFwBa+JDAcyp2WiPbFKakG4SUd6NZ5p7JbqX/tgjtfQ83x4R4NBbkBjvZpPbBoK+N3cFOq5Foo5wNXknqhU26TKF81saHSwVc8UsWyviqM75eTMC2DsvM3dIN83ANgCNqEzaY7IC8Gskz5bOvFI0+62Fs+EE1OlNEW/huWKjCPu6YY+szhK9/m5TNcaweWTJOgKkhoFNTYXLIMqslBeQjqKMWLvs3xwBquqREhkbiS6RoKQqW6ccsT2z9jGQcQpwED8TXCLyATS9inbb3WobibpZn7bk53apiF86e95An0pna1G4vyhV2QgDQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <859CB892E71FBD45910860D400E9ED67@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9beb8a-d88d-425c-d73a-08d74cc699a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 14:40:16.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf291JdA60ojWkabPKdnULq1HVJ+LjfbLFAJhAUevUeV2sh4WwsI0o6Bdewu+lS7LZ1v99hJ0xRuPZFWROQ9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5756
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 06, 2019 at 06:51:39PM +0300, Leon Romanovsky wrote:
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> Add RDMA nldev netlink interface for dumping MR
> statistics information.
>=20
> Output example:
> ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
>   local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::
>=20
> ereza@dev~$: rdma stat show mr
> dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0
> prefetched_pages 122071
>=20
> Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/device.c      |  1 +
>  drivers/infiniband/core/nldev.c       | 41 ++++++++++++++++++++++---
>  drivers/infiniband/hw/mlx5/main.c     |  2 ++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h  |  2 ++
>  drivers/infiniband/hw/mlx5/restrack.c | 44 +++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h               |  7 +++++
>  include/rdma/restrack.h               |  3 ++
>  7 files changed, 96 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index a667636f74bf..2e53aa25f0c7 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2606,6 +2606,7 @@ void ib_set_device_ops(struct ib_device *dev, const=
 struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, drain_sq);
>  	SET_DEVICE_OP(dev_ops, enable_driver);
>  	SET_DEVICE_OP(dev_ops, fill_res_entry);
> +	SET_DEVICE_OP(dev_ops, fill_stat_entry);
>  	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
>  	SET_DEVICE_OP(dev_ops, get_dma_mr);
>  	SET_DEVICE_OP(dev_ops, get_hw_stats);
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 6114465959e1..1d9d89fd9ce9 100644
> +++ b/drivers/infiniband/core/nldev.c
> @@ -454,6 +454,14 @@ static bool fill_res_entry(struct ib_device *dev, st=
ruct sk_buff *msg,
>  	return dev->ops.fill_res_entry(msg, res);
>  }
> =20
> +static bool fill_stat_entry(struct ib_device *dev, struct sk_buff *msg,
> +			    struct rdma_restrack_entry *res)
> +{
> +	if (!dev->ops.fill_stat_entry)
> +		return false;
> +	return dev->ops.fill_stat_entry(msg, res);
> +}

Why do we need this function called in only one place?

Jason
