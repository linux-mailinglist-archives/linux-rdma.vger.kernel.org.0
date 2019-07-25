Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3874875771
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGYS6k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 14:58:40 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:37827
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfGYS6j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 14:58:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/IZ8icWBYMDnX1V61stXnYO89j6uQsP3CSJcmw53K/pVSmS4uQa9zbnHm0ARzEGqyXt7hox81KlmX/6q76Nbt09U3obTBjUuvhHrLrkxpLD4pHIdJNHk2H9uq4U0ZplPGpw0fkVzpthl2T7RwvEkPvJDt5DQMCJupY8WKE/+8SsKHA0Ky1rhv0qxtc+AqvU0mvKI0Q4UHLUOtnVGubLlh4Ck1yyX6900JEsGoX+B9qUXg95wtTnu8QcXY8PGw/uArKSyfVqH9CVB5/wl9caftT9SgH2xEjJ2/LBTmHKNlQCGdI/c03CRjoDTfc10TkyIevgU0a7FYgMWkAVGBJheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg+1wqR7kFZn4dHIllxX8RKuaPg9P407ZVJ+pnzqNws=;
 b=n8ZoJttVvHzlRF/FfAfZCyKPnhotDark/40WM0vU/JEpiPU2pn9LycF9BLlLq3XL+iqd6rBneeT7i2ENgPucRlgeMsipJm6MIoCWcvsN0zGkoH6XqERz9cSNah88RrcLz0OEYnkihlhQVZppzik/YfQCyXNyXUUuj8PSI20FeH0BUf+Kd6rFM3Nn6ERHvdTg+YH3WDI3w3L9GyjzOd2quVABA+izS9aE1bLoKBA3bbUvPK84a0q8CnSgCiEaIzqhM+bcTYSIffuM71ViCdxIvkKAkbbz4+CFX0TN/Mw0IZ21KPKOJ4xAK3shwoJmm8PBzpaGVPuY++HFztVlSLA0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg+1wqR7kFZn4dHIllxX8RKuaPg9P407ZVJ+pnzqNws=;
 b=tBsPK25ITYUfjYbBuXc7uGOcE3Rg5tzwVCs4FDaDp/l/b5h2YGkcQQA8oR9yenHZlziEM+GSMze8R6bXUnYkU49ZJYzCMPA++hjc5HzNLrm9TzBtYhjbx7xhY8TY2N9vcWlqsaHO3VSRtxBFv5FEvzpfKkSV7dKe7oWtI9UzfXM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3358.eurprd05.prod.outlook.com (10.170.238.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 18:58:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 18:58:35 +0000
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
Thread-Index: AQHVQOKBSj2t7d2fJ0uM7qhfiZtzFqbbtCAA
Date:   Thu, 25 Jul 2019 18:58:35 +0000
Message-ID: <20190725185830.GH7450@mellanox.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com>
In-Reply-To: <20190722230859.5436-12-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7346b9bc-6af6-4a5d-7bfb-08d7113218a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3358;
x-ms-traffictypediagnostic: VI1PR05MB3358:
x-microsoft-antispam-prvs: <VI1PR05MB3358BD0AC7D3EB392A2DB80FCFC10@VI1PR05MB3358.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(186003)(6116002)(3846002)(1076003)(11346002)(2616005)(7416002)(256004)(229853002)(14444005)(6916009)(305945005)(446003)(478600001)(8676002)(5660300002)(476003)(81156014)(6436002)(316002)(8936002)(81166006)(54906003)(7736002)(66066001)(2906002)(6512007)(76176011)(6246003)(52116002)(486006)(66946007)(66476007)(64756008)(25786009)(66556008)(66446008)(6486002)(86362001)(68736007)(14454004)(26005)(99286004)(102836004)(33656002)(386003)(71200400001)(4326008)(6506007)(71190400001)(36756003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3358;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xb8s9qmmBk35mkf6tAFRXcBDghSHbMmjLtudf+ZT+2uz892r417r8dyI2HP9gy2yHDM/u9cDodA+s1FNS5oKtB1oHPUVDonC6DLKR+v+eyxa1aHCfqwu+0BDKHExL0Q64Az+Ld6RFqlUzyk56HmX6+DToa3AhvtMkp3CWUqlmUgbOF6mXQvScryfOEYTQ8NW0n3YrEPI+L2xweYiOmlfqM4HHh/YkS7gmOm9loumT9a8iwCT/4GdJmFLna1+cF5VgZ7TT5BPdiPsg8gqLAIa4R1NfzG42fS4Tx250DcRDyZW9AOpnQhi5eXz+7BRON8q9pHI8e6CM99H9fpowqScXhccGQaRF/w9UU5CF03VKz/GMw7vAaYlHq4L25W9a51/Kl3pjNj5NbzDItEkanqcfattkVJotF1waBmnYwXV8BY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BC84EB45B82414699EAB24805241BF7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7346b9bc-6af6-4a5d-7bfb-08d7113218a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 18:58:35.7452
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

On Mon, Jul 22, 2019 at 05:08:56PM -0600, Logan Gunthorpe wrote:
> Any requests that traverse the host bridge will need to be mapped into
> the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
> appropriate.
>=20
> Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 5f43f92f9336..76f51678342c 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -830,8 +830,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, stru=
ct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct dev_pagemap *pgmap =3D sg_page(sg)->pgmap;
> +	struct pci_dev *client;
> +	int dist;
> +
> +	client =3D find_parent_pci_dev(dev);
> +	if (WARN_ON_ONCE(!client))
> +		return 0;
> =20
> -	return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
> +	dist =3D upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> +					client, NULL);
> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
> +		return 0;
> +
> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);

IIRC at this point the SG will have struct page references to the BAR
memory - so (all?) the IOMMU drivers are able to handle P2P setup in
this case?

Didn't you also have a patch to remove the struct page's for the BAR
memory? =20

Confused what the plan is here

Jason
