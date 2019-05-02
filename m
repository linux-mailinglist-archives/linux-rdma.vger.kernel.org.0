Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03BE11C1D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 17:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBPDj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 11:03:39 -0400
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:43047
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEBPDj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 11:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1oTpMXlIEe5fQamtQxuHtaqDrU37fnmaZ2nYWfBuUg=;
 b=ZXHkPi31AKcOVELK8huiSZr6BYN2i5ZOeefkId78XbC6yMT6YkeEWhVEamn2PhVhpVAnhkwZje8fX9KFpz3t9YcqMBx684RD76+6JJWtZ08sdJjpIIE8rpo8jY8TSh8qJpGgZECBf/QsUEb8LLkoXxtJtnQ2JbVhXZbZpCypiIs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6429.eurprd05.prod.outlook.com (20.179.27.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Thu, 2 May 2019 15:03:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 15:03:35 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next v1] RDMA/umem: Move page_shift from ib_umem to
 ib_odp_umem
Thread-Topic: [PATCH rdma-next v1] RDMA/umem: Move page_shift from ib_umem to
 ib_odp_umem
Thread-Index: AQHU/93m7HEf6m4izEmJQhOevP6dcaZX8KwA
Date:   Thu, 2 May 2019 15:03:35 +0000
Message-ID: <20190502150330.GA21696@mellanox.com>
References: <20190501052227.23246-1-leon@kernel.org>
In-Reply-To: <20190501052227.23246-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:405:15::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4589d3fe-9ef7-45e9-7240-08d6cf0f59a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6429;
x-ms-traffictypediagnostic: VI1PR05MB6429:
x-microsoft-antispam-prvs: <VI1PR05MB64297D497013B526E0F879BACF340@VI1PR05MB6429.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(136003)(346002)(199004)(189003)(14454004)(68736007)(4744005)(8936002)(71200400001)(8676002)(81166006)(6916009)(54906003)(71190400001)(6486002)(81156014)(316002)(6116002)(1076003)(3846002)(99286004)(52116002)(229853002)(2906002)(6436002)(305945005)(5660300002)(76176011)(86362001)(6512007)(478600001)(36756003)(476003)(446003)(256004)(486006)(7736002)(33656002)(102836004)(66476007)(6246003)(66556008)(64756008)(66446008)(107886003)(11346002)(4326008)(53936002)(2616005)(66946007)(73956011)(186003)(66066001)(25786009)(386003)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6429;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EwbYERkqBTM0GpZR0eLa2f6QB8lnlznBiteV8c7LpuKN/h9np8tRlTqU/lnIIb+s7ztfoWwRtiFEqa0spJZsRq9LHUYC6JVOLqOB/SWTnNLqwIRZMCiL9Nbxc23B1N4xSkrLNAUaNbyZz9Ncnd8WZZU2LN8VEYVsaGP39vSROK/aMNznJscyXxteLv0iFXP7+pqj0YNtAAm1jB0waXIMgCzIFhJvgwX2N0TIs0nJPTbcMES/2T73fHN/SEfqN7c7HoAE9Fd3j8ajUQg/UqqZv8Hkzt/YcIDpeE3teHRFZWhP6FDIYQe8Xx2RBVdcJX06MsoEdZOlAiQDFGmYhfRkMVFUDuNTCSPtdg6G/hBzKZohJbf4loE6suw/mguXy68UWkajjXYA3lFh/Wgnid7bmIKmQPxsAqcWbo15XAKjx7Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6D4A57D490AB648A6BF2FACEF4FFFD1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4589d3fe-9ef7-45e9-7240-08d6cf0f59a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 15:03:35.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6429
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 08:22:27AM +0300, Leon Romanovsky wrote:

> @@ -84,6 +85,24 @@ static inline struct ib_umem_odp *to_ib_umem_odp(struc=
t ib_umem *umem)
>  	return container_of(umem, struct ib_umem_odp, umem);
>  }
>=20
> +/* Returns the first page of an ODP umem. */
> +static inline unsigned long ib_umem_start(struct ib_umem_odp *umem_odp)
> +{
> +	return ALIGN_DOWN(umem_odp->umem.address, 1UL << umem_odp->page_shift);
> +}
> +
> +/* Returns the address of the page after the last one of an ODP umem. */
> +static inline unsigned long ib_umem_end(struct ib_umem_odp *umem_odp)
> +{
> +	return ALIGN(umem_odp->umem.address + umem_odp->umem.length,
> +		     1UL << umem_odp->page_shift);
> +}
> +
> +static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
> +{
> +	return (ib_umem_end(umem_odp) - ib_umem_start(umem_odp)) >> PAGE_SHIFT;

It seems there are some testing failures with this patch, I think the
above PAGE_SHIFT may need to be umem_odp->page_shift

But I need to check it

Jason
