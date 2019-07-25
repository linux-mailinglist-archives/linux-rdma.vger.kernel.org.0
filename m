Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685C7757DB
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfGYT35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 15:29:57 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:24827
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbfGYT35 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 15:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVLAgQj6bKLI6GEfpekdTNGYTfbZy0hKh1j5UZY2ePS2JqbIpmn0ao0nTlVq9TUycU1wEOQOp0bZRQErBQ/xtVl6Hoam2pKT3FOrqMZ0T/61YKyLTrD/F73j1s0BiewB7P0DXXlsqPf3/lHFqTdt9CFIkiWxv5qGzbDNUi7WYoxxtN1A0O11MIv9cWyHT14vxvoJHAWe5g64a3Ygus1rUjFT689nq9pjvnPEMrwq80TU/ZX9dN9/sIgM19rXACdfEctgvAurHEuWsyaAbR7bgPY1Cpz3QqxOPALw6fCKDoEPuT//E3Raeu23SYw6UgRJVS7DIB22xQ4rgluxfTkAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3FPLuUAvLzM5ewABe3sLYB5sEaP6QaCe81llyV3ZY4=;
 b=Ntfu2BdUM27671y4mOyakooSZN1qzijET7gps30S0xu4gLvpEWev9+wKmZrCXRuu85IiH28EMXg2SdlAHOsfPSMPbczImRHqRN3rOChT2zhPsgDG5a/92Y3uUcOQTtjZ2VtRtMgwqxbSNNhjUg0bKbfB1yPfy6ktSHG7MfdgwC6LOk951jckRAjH8h0HDzyfNmmIhULS4z4/Pf4iEJ7+clYxtoKl6+ohuQW7sx3mtfAdHF+RP4Tm42LiBaeiebcv4z2zTuJpJPRSbBrW0DHC1aK1CH5/oVGWvlQSTBZ3VdckQBXgknLRWNd9HcFwp0TdhNYJi4dzW3q9ckrK7iy8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3FPLuUAvLzM5ewABe3sLYB5sEaP6QaCe81llyV3ZY4=;
 b=KCdQPQo9HC4jix3JU4ykc8GRBDv8FOYQBfUV+Uvudcu9jxtpkbq8qicye8lMKDnOtpoqn0trtNJIS6yXk6hFa+MZZ4yQ9mARrU669+craQjycDXEMw09nSsczjzlDPng8VcjnO5uKFR+5xqyu9LCprn1PCLPkTHCFTThOugCrgo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5294.eurprd05.prod.outlook.com (20.178.12.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 19:29:49 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 19:29:49 +0000
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
Subject: Re: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
Thread-Topic: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
Thread-Index: AQHVQOKBSj2t7d2fJ0uM7qhfiZtzFqbbtCAAgAAFLgCAAAOMAA==
Date:   Thu, 25 Jul 2019 19:29:49 +0000
Message-ID: <20190725192944.GI7450@mellanox.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com>
 <20190725185830.GH7450@mellanox.com>
 <cf61d237-8a8a-e3ac-a9df-466f20b63020@deltatee.com>
In-Reply-To: <cf61d237-8a8a-e3ac-a9df-466f20b63020@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e2b66d-9e1a-4780-bfde-08d711367594
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5294;
x-ms-traffictypediagnostic: VI1PR05MB5294:
x-microsoft-antispam-prvs: <VI1PR05MB52947BE15707CB8D96AADCF5CFC10@VI1PR05MB5294.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(478600001)(316002)(3846002)(52116002)(8676002)(6512007)(54906003)(5660300002)(53936002)(26005)(86362001)(4326008)(7416002)(66556008)(305945005)(36756003)(102836004)(6486002)(386003)(66446008)(6246003)(6116002)(256004)(66476007)(7736002)(68736007)(25786009)(99286004)(486006)(14454004)(81166006)(1076003)(33656002)(81156014)(6916009)(11346002)(66946007)(64756008)(2616005)(476003)(2906002)(8936002)(186003)(53546011)(71190400001)(66066001)(71200400001)(446003)(6506007)(229853002)(6436002)(76176011)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5294;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7CJuxVXM3aH6BJJy7/HN/xKPxqEsqiz4Mxew2hDrOr4rwoltOuAmHU4Hb6e8kbVFaNVeI782napI8huUhrwGdRs4kzZNvKoRGTg7bNO8TuQSKSWwTY31E0H8tJxxYpkorfxCZY9sirsloN9aEN07N6Pw1+577iRSbimOhDUZTzUGTb62MLp84dcWscpptQrRrXfW6f7ipbCz9gttZaKZohN7OWR5oPM7UDnEEK9b/tJ1KUndTKcxAviBdLs63goubEuUULvkANRAl6b+i6d4UFvYhYcamoaN1IgR9qkLOAFFZuWC5IRzIQ6PtWJhQHePXVCubTgei4yWEK689vUoWJVOEhx7J9JC11CuTed1X08+TA1vkVzKMdmgYI2FPBm85kLsCm+0ZG3t+zYAaGMcOGLM7coJ4gkKaR1/sBjM0iU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF60765BC6FB194DA911DEB33C20BF68@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e2b66d-9e1a-4780-bfde-08d711367594
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 19:29:49.6632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5294
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 25, 2019 at 01:17:02PM -0600, Logan Gunthorpe wrote:
>=20
>=20
> On 2019-07-25 12:58 p.m., Jason Gunthorpe wrote:
> > On Mon, Jul 22, 2019 at 05:08:56PM -0600, Logan Gunthorpe wrote:
> >> Any requests that traverse the host bridge will need to be mapped into
> >> the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
> >> appropriate.
> >>
> >> Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>  drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++++++++++-
> >>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 5f43f92f9336..76f51678342c 100644
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -830,8 +830,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, s=
truct scatterlist *sg,
> >>  		int nents, enum dma_data_direction dir, unsigned long attrs)
> >>  {
> >>  	struct dev_pagemap *pgmap =3D sg_page(sg)->pgmap;
> >> +	struct pci_dev *client;
> >> +	int dist;
> >> +
> >> +	client =3D find_parent_pci_dev(dev);
> >> +	if (WARN_ON_ONCE(!client))
> >> +		return 0;
> >> =20
> >> -	return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
> >> +	dist =3D upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> >> +					client, NULL);

Isn't is a bit of a leap to assume that the pgmap is uniform across
all the sgs?

> >> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
> >> +		return 0;
> >> +
> >> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
> >> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> >=20
> > IIRC at this point the SG will have struct page references to the BAR
> > memory - so (all?) the IOMMU drivers are able to handle P2P setup in
> > this case?
>=20
> Yes. The IOMMU drivers refer to the physical address for BAR which they
> can get from the struct page. And this works fine today.

Interesting.

So, for the places where we already map BAR memory to userspace, if I
were to make struct pages for those BARs and use vm_insert_page()
instead of io_remap_pfn_range(), then the main thing missing in RDMA
to actually do P2P DMA is a way to get those struct pages out of
get_user_pages and know to call the pci_p2pdma_map_sg version (ie in
ib_umem_get())?

Jason
