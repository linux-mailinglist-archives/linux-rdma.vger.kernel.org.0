Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1946E75740
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfGYSwk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 14:52:40 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:6082
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbfGYSwk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 14:52:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK+LV7i6YHO9/migAxqkMk4Vmcmfk7auNvQDGxW6bAkQxTbAgTLI6KDsu2+gr5phAVJuFczdT2DyF4HOKbkL7lesZFbdqSRqfwj5ZLkizgT0MRjfWGJSHFotl7RJctXvTTs1P20hH7Rv6aX4033s8HN9acEOdb8zrUcerHuUn13fRC3qhAgYfx1LhhS9gyqdDMNSvS9a79CVifIoh+dA6iejAMxAmBORVyRp1/T0cRwVJq/nX/Y1DT9SloMQkBe68x/EQhJnN13/NkoEuQacNdcKNgmtzGdVV0MDLM0KDl9sa5sPV8QxnOiuf3lDvRuoNvdBi9lAIsX+HclFRQOVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBO66a3QGuTu9B2KIJUgnGF7/Corv+KLAnmOAZSj3xw=;
 b=I33y/oqvpvyFETWQKOZFrw0SEpgvip801nTJ4t//o3MMZHPPHLXKvMsIYgquuiaGpavEwgHx3EN2I1BQ5woiBtAhGtd3U7bUI/KTPLKzcIBZFO7b+MoAtnpf95TlM5MgEDDfdhiShoJ9kgMxzbyWkQrNvP2xEmdMosQhbw2dxOzyZIspLtWpEZyyvIwwAZj9Y2raHO9lr1B0FoFf2wc8905MMTIF7n7AD1HoOnrr6m2cxsdSMvx0m0+jqt2k14xz8iqUGNKhH0kYpknj1qb2BCS3yQeel5XRtI2LDWNVVxYhgTNumGXWNjZjrRkRmv/zwHfs6P7zqSgNMGD+pxjTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBO66a3QGuTu9B2KIJUgnGF7/Corv+KLAnmOAZSj3xw=;
 b=fmEbt+msL1qJyULMhGzRBdmgl84mQiLbiwgPzHPng2rbxPfGG64DF9qu+ghhewB2mv/MjEkhxBWtfstKuBKm7F0o8ZbWF7P79NjS7hOQCAaJGnG5bzsn4sVZiKpaIllmC5mOIAPUDghG6neIefM/W5RDiiH4kqzr3enStyWDeuc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3358.eurprd05.prod.outlook.com (10.170.238.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 18:52:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 18:52:36 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 06/14] PCI/P2PDMA: Add whitelist support for Intel Host
 Bridges
Thread-Topic: [PATCH 06/14] PCI/P2PDMA: Add whitelist support for Intel Host
 Bridges
Thread-Index: AQHVQOKA2Us7gXzzBkKJHgxgIGkDSabbsnMA
Date:   Thu, 25 Jul 2019 18:52:36 +0000
Message-ID: <20190725185230.GG7450@mellanox.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-7-logang@deltatee.com>
In-Reply-To: <20190722230859.5436-7-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef2d2cb7-d562-47e4-ca15-08d71131426a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3358;
x-ms-traffictypediagnostic: VI1PR05MB3358:
x-microsoft-antispam-prvs: <VI1PR05MB33581BB96C57DE5E2609F64CCFC10@VI1PR05MB3358.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(186003)(6116002)(3846002)(1076003)(11346002)(2616005)(7416002)(256004)(229853002)(6916009)(305945005)(446003)(478600001)(8676002)(5660300002)(476003)(81156014)(6436002)(316002)(8936002)(81166006)(54906003)(7736002)(66066001)(2906002)(6512007)(76176011)(6246003)(52116002)(486006)(66946007)(66476007)(64756008)(25786009)(66556008)(66446008)(6486002)(86362001)(68736007)(14454004)(26005)(99286004)(102836004)(33656002)(386003)(71200400001)(4326008)(6506007)(71190400001)(36756003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3358;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5zv/PNXQZX/h9bNqK/9ciD+cLCa3xdOSNNDguKFP0peleL9gzbqUPzC46rXy0e8/AGRTnVRQYsCqw7IBQt63Wl7BWd1Q6ffuRoha9pEZKwcn8h8nmeezLKaDMeY0jhKS0LcpMl7TNBC1bEEtr9L2Q0Ndu8r7is4hlBBQYfd5bBjXCVCNZ/iDwfiTZ1/EvoWzPpXVAVpXemBC1XWBMiLumziet9I9Xb1PrsNJ/l81UVfYu95+zjddS8KCvfa46PT00ZE3s/rfdDz97lzNQZRZWpCx7ZvFsKWE3UeegPStcEI+ZhHANoohNQ/sJu0U6iV1ybB/EqjBPHDUAl/X41r+k453jVYYsskXY03s7kQFqe56uG5IuGltKNpM9HsqDO7a81G1jl2o1TY3kBhcsMkYspQr4RHFuX2s+SwHB4gezc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F92BB72B415A740B49C55296D8E5B71@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2d2cb7-d562-47e4-ca15-08d71131426a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 18:52:36.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3358
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 05:08:51PM -0600, Logan Gunthorpe wrote:
> Intel devices do not have good support for P2P requests that span
> different host bridges as the transactions will cross the QPI/UPI bus
> and this does not perform well.
>=20
> Therefore, enable support for these devices only if the host bridges
> match.
>=20
> Adds the Intel device's that have been tested to work. There are
> likely many others out there that will need to be tested and added.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index dfb802afc8ca..143e11d2a5c3 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -250,9 +250,28 @@ static void seq_buf_print_bus_devfn(struct seq_buf *=
buf, struct pci_dev *pdev)
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>  }
> =20
> -static bool __host_bridge_whitelist(struct pci_host_bridge *host)
> +static const struct pci_p2pdma_whitelist_entry {
> +	unsigned short vendor;
> +	unsigned short device;
> +	bool req_same_host_bridge;

This would be more readable in the initializer as a flags not a bool

Jason
