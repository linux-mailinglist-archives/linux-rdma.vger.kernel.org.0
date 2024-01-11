Return-Path: <linux-rdma+bounces-603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EA82AF96
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854D2286585
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718DD17727;
	Thu, 11 Jan 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dmVqcxzd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2102.outbound.protection.outlook.com [40.107.8.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9855171DF;
	Thu, 11 Jan 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFy9Ep1hOirOawfKEDdOtAiyytg+ULJVQcmFFjEodvfRYAGg2O3cIcdtyws4gtL9q7emlz0+9fEQh7qxfhj1pCv2FbFYRkk8uBSnx0FjVuKE1kQxg3ggOwWwQuDMhwU++r1ejJsezftiUWWKtrU9J8JUgPGes8Fvxoa4LsxEv24wfumOXWju5Lk/0B5nRXLhyg7k2FhQG+BHvDsZXmG/cIxzHCrrVnWonDaehmZwibAcUmKcBI2t+1V9sdelc/Y97anZDaAoiq9vaLhpBnatGuAqO7kxGHlNvcePdp8EWMfh8a9M+wxqDSxxNg1L9leJ4B6YQuKNM8OfVZFE8gzE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwoZTohZORtsDalePvSgpGRAmBG94/oWvJwevkFV0g4=;
 b=aM4ITv2p3EfRiUwaDRBFUKCus4vo5RS+jD/BKXcG61P+a12iJ7bE6+dM7gPKqmVAyT6P2Gt+JqrkMs308p9MSbTVxDna/1Q01RCGQ2T9+zexQe8dVWfcQ1qjjf4hUHSUCkzCEx5pplcTFKuDo8Hd2h5O71LvANkoQ3DFq6FGonLgWzKw807AVV2f9GJoojL3wiypexKc3cgPhiQb0fc/C7cPvCnC0Z+FGS6riMy2dgS1WChQ9wktCw9PtHCncd/8lKmZBYl6xFk0S8SLtQwvbXzzrwnLhtY4cq4BjcjDMzUPPOqHk6FeWwXhnUgEQw8gvf66TYBB3x8owM5+jslspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwoZTohZORtsDalePvSgpGRAmBG94/oWvJwevkFV0g4=;
 b=dmVqcxzd5LiJoUJNrwSvOEZmE+IQaHHaHL+C+b38X8FfIodo3zQJuSXoXZh+ybp6FVmQVq5GoWXl+J1z/4fOVToVrACNeGlhdXKrP6wBgLPC1gP4Rd+NCyfZRqpQWdiRqw81XyoFRAwe/L3P8OQ7K53FPrSFTAzYYodnIWmSSyQ=
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com (2603:10a6:10:322::19)
 by PR3PR83MB0441.EURPRD83.prod.outlook.com (2603:10a6:102:76::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Thu, 11 Jan
 2024 13:21:28 +0000
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::4ec7:773c:339f:3c4b]) by DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::4ec7:773c:339f:3c4b%5]) with mapi id 15.20.7202.013; Thu, 11 Jan 2024
 13:21:28 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
 helper functions to clean mana_ib code
Thread-Topic: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three
 helper functions to clean mana_ib code
Thread-Index: AQHaQ89emdR+YPIkKEuBs/XeeNNOqrDUdwOAgAAjJVs=
Date: Thu, 11 Jan 2024 13:21:28 +0000
Message-ID:
 <DU0PR83MB05537ED5ACE714BACA7288AAB4682@DU0PR83MB0553.EURPRD83.prod.outlook.com>
References: <1704896074-4355-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240111111417.GC7488@unreal>
In-Reply-To: <20240111111417.GC7488@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-11T13:21:25.126Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR83MB0553:EE_|PR3PR83MB0441:EE_
x-ms-office365-filtering-correlation-id: 67072cc4-c225-4b88-8680-08dc12a837fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5+vz3cp+z47E+Wrg63F3wlQAoWuaVJiEtpFuoG5gE2vqFAezgoOPOQDBPKTNqmQpAuS0Y4ykqn1edjO61yqrqk6S2HiSGzZ5q0H0tDu3MJW3WUZXi4sV5Xd+/NcWsBiqTmJnEKq2qwGNx2Xiv+KNzhTdaTXJKWthR0X7azAOpyhIeuJs2Zc4esa+hmAtcJf/6aXwB+lLfsvMQxei8hxoDYuyRrazPgrG+gaU8VxVP1Ky5/3zZb0bfMDiWMJUMTs6qWLFVQ6RfsHC4nZFcNaT2ynQT3lbGuLnp7D+2O2BeLsPb1UyyowTbxMs4T9ZT1cUhC2mTPlxfNSTOtSE6Q/gAatnla2ccHWXyN+UaSQNe61OLGAXB5jB0m8TD79LMni1ObmtZSV8/zXUxvtwPwqh5u9JVA4BztMB98O4bJ/vkiu0TIKSGKN56G6B1s1zG/8KYJXRt/EDBVkbz0w8pK5JgPCkbBR7wiw1XXUaTSYUmHZ9sc/Y3xjbYb3B5InrlOOcLy5bWtXHsiZU9HcgJ6NJaVGOnEraczv97lHB4NRQQRIsg6U+L9EwZikb1Y356vekPv9GMSeC7sfboIxwacyBM2o7XyxOa5tsclBqxpiKhMdjem06G+Cp66dA/mI0+FJ2LVwIt7GdoJ4PRpXloxeTVyaruMDMEY1pzIo/yItD7xfd6m/2+fxqAI7Et7zF+RrA8a4CKVbufblROq6UfOy56bYzwTEo8D+MXrhSXcagC8SoKvSOCadliC+sHSxJufQh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR83MB0553.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(230373577357003)(230173577357003)(230473577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(30864003)(55016003)(66899024)(52536014)(4326008)(86362001)(83380400001)(122000001)(33656002)(38100700002)(82960400001)(82950400001)(6506007)(53546011)(71200400001)(478600001)(7696005)(54906003)(9686003)(38070700009)(66476007)(66946007)(91956017)(76116006)(66446008)(6916009)(64756008)(66556008)(316002)(8936002)(8676002)(2906002)(8990500004)(966005)(26005)(10290500003)(41300700001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zOVORis5UjOPQdlUKbtsc3D1GWHDAjkBnMZn6gyPd6ezVx4rRc0c1Gqq4u?=
 =?iso-8859-1?Q?x/nakrnTXxshzLj3ZRzxugMQqBzbIGrZGjULx/e3gsYvJGEUlOkqR+yqhY?=
 =?iso-8859-1?Q?lPR57t6w3Is5UEiZKGgWuJXNj00gn9St4D53Dodfn1RzuzPkif8EQ6dOY9?=
 =?iso-8859-1?Q?sCMDWF6gumpv+M5p5oUTpyZjAK4mPF1GXW43zLo1PW+VY08LGrTN6XNWYZ?=
 =?iso-8859-1?Q?+DSJCzUFfoaCx0tUinWiZCj7e25G5krrb+jJSfp2BFYlZin8eoAxol8+Ui?=
 =?iso-8859-1?Q?IzsUwQbnl9/b+dMrCvRv6QL+QErzDw8d/RHN2fRgKItsEYHvT+I32AUgw8?=
 =?iso-8859-1?Q?wRUMeFx2UdJF6TKO/us2oG5WP6d10KdHn5s6GeHoq0z/S7zFpLjitIpCta?=
 =?iso-8859-1?Q?6yabmCMGyFdK9VHoVvubacvy5rlTM1hUbUEqxyDX/vFkppNmDMKJjadug+?=
 =?iso-8859-1?Q?BnR6gU5ZdG3vMePJVD0QAOszCY5Dh6J9LGbpxfJ2UEEXCZ1p8Eb+XgxQaK?=
 =?iso-8859-1?Q?L/JjGLqLRAIvv7ZkW5jmqFx6K1Yqe0ieq6WwyVH+ZW13SBAoHcKsXUJo9o?=
 =?iso-8859-1?Q?WquI9l071y+uzbVbd2aVo6WXFjVZe2MzHy6dJpweWW2EhBe4c0mYWwiTWH?=
 =?iso-8859-1?Q?57elJAMWIsgpOLmFc3w0x5DBkUA9FtWe/WpZwWfNa+mSl7Y4a7sU/Cjb/d?=
 =?iso-8859-1?Q?Zss3q+zv1BYu/DuUHfgA4C7cf4nN9/l5Puna7XiFU0un+pkkE4gzBHhkY4?=
 =?iso-8859-1?Q?9a7+ck+fYnILg2ZrY0X7CFJesCXFABL+ZuYOWUU2gR3CCGFMfpOSZtqs0W?=
 =?iso-8859-1?Q?y06CO6AC4m+esL1FpOuYY4eDf01JrXRFrw7J+x2COj6mxrT+DaZhmZvvTx?=
 =?iso-8859-1?Q?wF9UDdZgFehRrSDVkmmrIlXSSFTZEFfR3i1oqtqRjQWwceRLMAqdpaMVxy?=
 =?iso-8859-1?Q?J3hCCRIjuaJbCxib8o3K/KloChiEif0pi/WcjhDCS3rVA1UkFqUks7tlbN?=
 =?iso-8859-1?Q?NM9GVQFMTH1AujsWEaetlCFhp+ms5PGsw3qloNBPanBnkn6TFfcYSFwiZH?=
 =?iso-8859-1?Q?O6wMGoQMsLOrE03/ZkUYfS7QxRRFG95XZSJUFD1Fxu4YmdDPwALoJPxrTb?=
 =?iso-8859-1?Q?GlEqpqAW932GGXOYdVtIN/Bpl1mL68M9dhzAKIXXfWagHc/f9JMGvrlass?=
 =?iso-8859-1?Q?WYlrnZZP/tCHA82AMvEQEZ7YUoGefgxgR+k5BWAWN3VQx2YonjdR+/WvVQ?=
 =?iso-8859-1?Q?kniEVK4aHT5JYTEvHsHaGx/VbInI+Gwx0CL6AVmdIWdumoTK1tx4Ijdc3F?=
 =?iso-8859-1?Q?wuoQIr/rIStZVKiEryMXED/8xCKY6aoYx3Agvw3g9dFNNd0FR2+kZUfhFb?=
 =?iso-8859-1?Q?VUtBiL+ch+YyBy0QCetUq1fprV/pBe8d2e6qTFtvJymUnNGrFs/6C6Dqa0?=
 =?iso-8859-1?Q?rHEUQwqCqtN84/lYNGHNRJz3bpjhdgo0zURwIESc6Ty9j866mnNRZbx+6p?=
 =?iso-8859-1?Q?bN4RMbDZOG8R25DLGJuHr8dVt70+8YTR+PcMdAVbiieNSXU2FSypnmzFRF?=
 =?iso-8859-1?Q?uyXpwkrha4LrQ1lYWp8VqtYS8+AZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR83MB0553.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67072cc4-c225-4b88-8680-08dc12a837fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 13:21:28.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/wi4zHf3cFeXjOLzAecCUFDJbIPf+1ZfveGlBEAh5Wa3oAdAXp48A4BqVBcPusdynRAMjygZdlLhnl4YR8dZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR83MB0441

Hi Leon,=0A=
=0A=
// Sorry for re-sending the email. I did not know that I had to enable plai=
n-text messages in outlook.=0A=
=0A=
thanks for pointing out the merge window. I will resend after it.=0A=
=0A=
I can also split it into 2 commits (mdev_to_gc and mana_ib_get_netdev in on=
e, and CQ cb in the other), if it is required.=0A=
I cannot separate "mdev_to_gc" and "mana_ib_get_netdev " into 2 commits as =
it will double the changes and obstruct the reader.=0A=
=0A=
> And how is it safe now? What is unsafe here?=0A=
=0A=
The issue with the gdma_dev is  the following.=0A=
Our mana HW device has two gdma_devs: one for ethernet and one for rdma.=0A=
And in the code of mana_ib.ko it is not clearly indicated what gdma_dev is =
used. =0A=
So it means in some functions it is ethernet and in some it is rdma.=0A=
The use of a wrong device in the hardware channel leads to errors and waste=
 time of developers.=0A=
=0A=
This problem is addressed as follows:=0A=
We avoid using gdma_dev explicitly in functions of mana_ib.ko except the in=
it.=0A=
As the gdma_context is only one, we abstract it into mdev_to_gc, to prevent=
 the user to declare gdma_dev.=0A=
When a function actually needs to use gdma_dev of the ethernet, it uses net=
dev, which encapsulates the correct gdma_dev. =0A=
Getting netdev is implemented with mana_ib_get_netdev, to prevent  the user=
 to declare gdma_dev.=0A=
When a function needs to use gdma_dev of the rdma, it will use struct mana_=
ib_dev (a child of ib_dev) in its hardware channel requests.=0A=
=0A=
I hope it explains what becomes safer. If it was useful, I can add this exp=
lanation to the commit message.=0A=
=0A=
Thanks,=0A=
Konstantin=0A=
=0A=
________________________________________=0A=
From: Leon Romanovsky <leon@kernel.org>=0A=
Sent: Thursday, January 11, 2024 12:14 PM=0A=
To: Konstantin Taranov=0A=
Cc: Konstantin Taranov; Long Li; jgg@ziepe.ca; linux-rdma@vger.kernel.org; =
linux-kernel@vger.kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three h=
elper functions to clean mana_ib code=0A=
=0A=
[You don't often get email from leon@kernel.org. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
On Wed, Jan 10, 2024 at 06:14:34AM -0800, Konstantin Taranov wrote:=0A=
> From: Konstantin Taranov <kotaranov@microsoft.com>=0A=
>=0A=
> This patch aims to address two issues in mana_ib:=0A=
> 1) Unsafe and inconsistent access to gdma_dev and  gdma_context=0A=
=0A=
And how is it safe now? What is unsafe here?=0A=
=0A=
> 2) Code repetitions=0A=
>=0A=
> As a rule of thumb, functions should not access gdma_dev directly=0A=
>=0A=
> Introduced functions:=0A=
> 1) mdev_to_gc=0A=
=0A=
Which is exactly "mdev->gdma_dev->gdma_context" as before.=0A=
=0A=
> 2) mana_ib_get_netdev=0A=
> 3) mana_ib_install_cq_cb=0A=
>=0A=
>=0A=
=0A=
We are in merge window and cleanup patch will need to wait till it ends.=0A=
=0A=
Thanks=0A=
=0A=
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>=0A=
> ---=0A=
> Sorry that was sent again, I forgot to add RDMA/mana_ib to the subject=0A=
> ---=0A=
>  drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--=0A=
>  drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------=
=0A=
>  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++=0A=
>  drivers/infiniband/hw/mana/mr.c      | 13 +++------=0A=
>  drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------=0A=
>  5 files changed, 63 insertions(+), 66 deletions(-)=0A=
>=0A=
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c=0A=
> index 83ebd0705..255e74ab7 100644=0A=
> --- a/drivers/infiniband/hw/mana/cq.c=0A=
> +++ b/drivers/infiniband/hw/mana/cq.c=0A=
> @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct =
ib_cq_init_attr *attr,=0A=
>       int err;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       if (udata->inlen < sizeof(ucmd))=0A=
>               return -EINVAL;=0A=
> @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_ud=
ata *udata)=0A=
>       int err;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);=0A=
>       if (err) {=0A=
> @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct gdma_queue=
 *gdma_cq)=0A=
>       if (cq->ibcq.comp_handler)=0A=
>               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);=0A=
>  }=0A=
> +=0A=
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q)=0A=
> +{=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(mdev);=0A=
> +     struct gdma_queue *gdma_cq;=0A=
> +=0A=
> +     /* Create CQ table entry */=0A=
> +     WARN_ON(gc->cq_table[cq->id]);=0A=
> +     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> +     if (!gdma_cq)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     gdma_cq->cq.context =3D cq;=0A=
> +     gdma_cq->type =3D GDMA_CQ;=0A=
> +     gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> +     gdma_cq->id =3D cq->id;=0A=
> +     gc->cq_table[cq->id] =3D gdma_cq;=0A=
> +     return 0;=0A=
> +}=0A=
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/ma=
na/main.c=0A=
> index faca09245..29dd2438d 100644=0A=
> --- a/drivers/infiniband/hw/mana/main.c=0A=
> +++ b/drivers/infiniband/hw/mana/main.c=0A=
> @@ -8,13 +8,10 @@=0A=
>  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,=
=0A=
>                        u32 port)=0A=
>  {=0A=
> -     struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;=0A=
>       struct mana_port_context *mpc;=0A=
>       struct net_device *ndev;=0A=
> -     struct mana_context *mc;=0A=
>=0A=
> -     mc =3D gd->driver_data;=0A=
> -     ndev =3D mc->ports[port];=0A=
> +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);=0A=
>       mpc =3D netdev_priv(ndev);=0A=
>=0A=
>       mutex_lock(&pd->vport_mutex);=0A=
> @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, str=
uct mana_ib_pd *pd,=0A=
>  int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_=
pd *pd,=0A=
>                     u32 doorbell_id)=0A=
>  {=0A=
> -     struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;=0A=
>       struct mana_port_context *mpc;=0A=
> -     struct mana_context *mc;=0A=
>       struct net_device *ndev;=0A=
>       int err;=0A=
>=0A=
> -     mc =3D mdev->driver_data;=0A=
> -     ndev =3D mc->ports[port];=0A=
> +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);=0A=
>       mpc =3D netdev_priv(ndev);=0A=
>=0A=
>       mutex_lock(&pd->vport_mutex);=0A=
> @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_ud=
ata *udata)=0A=
>       struct gdma_create_pd_req req =3D {};=0A=
>       enum gdma_pd_flags flags =3D 0;=0A=
>       struct mana_ib_dev *dev;=0A=
> -     struct gdma_dev *mdev;=0A=
> +     struct gdma_context *gc;=0A=
>       int err;=0A=
>=0A=
>       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
>       req.flags =3D flags;=0A=
> -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,=
=0A=
> +     err =3D mana_gd_send_request(gc, sizeof(req), &req,=0A=
>                                  sizeof(resp), &resp);=0A=
>=0A=
>       if (err || resp.hdr.status) {=0A=
> @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct i=
b_udata *udata)=0A=
>       struct gdma_destory_pd_resp resp =3D {};=0A=
>       struct gdma_destroy_pd_req req =3D {};=0A=
>       struct mana_ib_dev *dev;=0A=
> -     struct gdma_dev *mdev;=0A=
> +     struct gdma_context *gc;=0A=
>       int err;=0A=
>=0A=
>       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
>       req.pd_handle =3D pd->pd_handle;=0A=
> -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,=
=0A=
> +     err =3D mana_gd_send_request(gc, sizeof(req), &req,=0A=
>                                  sizeof(resp), &resp);=0A=
>=0A=
>       if (err || resp.hdr.status) {=0A=
> @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibco=
ntext,=0A=
>       struct ib_device *ibdev =3D ibcontext->device;=0A=
>       struct mana_ib_dev *mdev;=0A=
>       struct gdma_context *gc;=0A=
> -     struct gdma_dev *dev;=0A=
>       int doorbell_page;=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     dev =3D mdev->gdma_dev;=0A=
> -     gc =3D dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       /* Allocate a doorbell page index */=0A=
>       ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page);=0A=
> @@ -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibc=
ontext)=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);=
=0A=
>       if (ret)=0A=
> @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev=
 *dev, struct ib_umem *umem,=0A=
>       size_t max_pgs_create_cmd;=0A=
>       struct gdma_context *gc;=0A=
>       size_t num_pages_total;=0A=
> -     struct gdma_dev *mdev;=0A=
>       unsigned long page_sz;=0A=
>       unsigned int tail =3D 0;=0A=
>       u64 *page_addr_list;=0A=
>       void *request_buf;=0A=
>       int err;=0A=
>=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> -     gc =3D mdev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>       hwc =3D gc->hwc.driver_data;=0A=
>=0A=
>       /* Hardware requires dma region to align to chosen page size */=0A=
> @@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev =
*dev, struct ib_umem *umem,=0A=
>=0A=
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_regi=
on)=0A=
>  {=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
>       ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region)=
;=0A=
>=0A=
>       return mana_gd_destroy_dma_region(gc, gdma_region);=0A=
> @@ -447,7 +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struc=
t vm_area_struct *vma)=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       if (vma->vm_pgoff !=3D 0) {=0A=
>               ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff=
);=0A=
> @@ -531,7 +519,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev =
*dev)=0A=
>       req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;=0A=
>       req.hdr.dev_id =3D dev->gdma_dev->dev_id;=0A=
>=0A=
> -     err =3D mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(re=
q),=0A=
> +     err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),=0A=
>                                  &req, sizeof(resp), &resp);=0A=
>=0A=
>       if (err) {=0A=
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw=
/mana/mana_ib.h=0A=
> index 6bdc0f549..6b15b2ab5 100644=0A=
> --- a/drivers/infiniband/hw/mana/mana_ib.h=0A=
> +++ b/drivers/infiniband/hw/mana/mana_ib.h=0A=
> @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {=0A=
>       u32 max_inline_data_size;=0A=
>  }; /* HW Data */=0A=
>=0A=
> +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)=
=0A=
> +{=0A=
> +     return mdev->gdma_dev->gdma_context;=0A=
> +}=0A=
> +=0A=
> +static inline struct net_device *mana_ib_get_netdev(struct ib_device *ib=
dev, u32 port)=0A=
> +{=0A=
> +     struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev=
, ib_dev);=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(mdev);=0A=
> +     struct mana_context *mc =3D gc->mana.driver_data;=0A=
> +=0A=
> +     if (port < 1 || port > mc->num_ports)=0A=
> +             return NULL;=0A=
> +     return mc->ports[port - 1];=0A=
> +}=0A=
> +=0A=
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem=
 *umem,=0A=
>                                mana_handle_t *gdma_region);=0A=
>=0A=
> @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t ib_cq_init_attr *attr,=0A=
>                     struct ib_udata *udata);=0A=
>=0A=
>  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);=0A=
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q);=0A=
>=0A=
>  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);=0A=
>  int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);=0A=
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c=0A=
> index 351207c60..ee4d4f834 100644=0A=
> --- a/drivers/infiniband/hw/mana/mr.c=0A=
> +++ b/drivers/infiniband/hw/mana/mr.c=0A=
> @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *de=
v, struct mana_ib_mr *mr,=0A=
>  {=0A=
>       struct gdma_create_mr_response resp =3D {};=0A=
>       struct gdma_create_mr_request req =3D {};=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>       int err;=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
> -=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>       req.pd_handle =3D mr_params->pd_handle;=0A=
> @@ -77,12 +74,9 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *d=
ev, u64 mr_handle)=0A=
>  {=0A=
>       struct gdma_destroy_mr_response resp =3D {};=0A=
>       struct gdma_destroy_mr_request req =3D {};=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>       int err;=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
> -=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
> @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd,=
 u64 start, u64 length,=0A=
>       return &mr->ibmr;=0A=
>=0A=
>  err_dma_region:=0A=
> -     mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,=0A=
> -                                dma_region_handle);=0A=
> +     mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);=0A=
>=0A=
>  err_umem:=0A=
>       ib_umem_release(mr->umem);=0A=
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c=0A=
> index e6d063d45..e889c798f 100644=0A=
> --- a/drivers/infiniband/hw/mana/qp.c=0A=
> +++ b/drivers/infiniband/hw/mana/qp.c=0A=
> @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_=
dev *dev,=0A=
>       struct mana_cfg_rx_steer_resp resp =3D {};=0A=
>       mana_handle_t *req_indir_tab;=0A=
>       struct gdma_context *gc;=0A=
> -     struct gdma_dev *mdev;=0A=
>       u32 req_buf_size;=0A=
>       int i, err;=0A=
>=0A=
> -     gc =3D dev->gdma_dev->gdma_context;=0A=
> -     mdev =3D &gc->mana;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       req_buf_size =3D=0A=
>               sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_=
SIZE;=0A=
> @@ -39,7 +37,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_de=
v *dev,=0A=
>       req->rx_enable =3D 1;=0A=
>       req->update_default_rxobj =3D 1;=0A=
>       req->default_rxobj =3D default_rxobj;=0A=
> -     req->hdr.dev_id =3D mdev->dev_id;=0A=
> +     req->hdr.dev_id =3D gc->mana.dev_id;=0A=
>=0A=
>       /* If there are more than 1 entries in indirection table, enable RS=
S */=0A=
>       if (log_ind_tbl_size)=0A=
> @@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, =
struct ib_pd *pd,=0A=
>       struct gdma_queue **gdma_cq_allocated;=0A=
>       mana_handle_t *mana_ind_table;=0A=
>       struct mana_port_context *mpc;=0A=
> -     struct gdma_queue *gdma_cq;=0A=
>       unsigned int ind_tbl_size;=0A=
>       struct net_device *ndev;=0A=
>       struct mana_ib_cq *cq;=0A=
> @@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
, struct ib_pd *pd,=0A=
>               mana_ind_table[i] =3D wq->rx_object;=0A=
>=0A=
>               /* Create CQ table entry */=0A=
> -             WARN_ON(gc->cq_table[cq->id]);=0A=
> -             gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> -             if (!gdma_cq) {=0A=
> -                     ret =3D -ENOMEM;=0A=
> +             ret =3D mana_ib_install_cq_cb(mdev, cq);=0A=
> +             if (!ret)=0A=
>                       goto fail;=0A=
> -             }=0A=
> -             gdma_cq_allocated[i] =3D gdma_cq;=0A=
>=0A=
> -             gdma_cq->cq.context =3D cq;=0A=
> -             gdma_cq->type =3D GDMA_CQ;=0A=
> -             gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> -             gdma_cq->id =3D cq->id;=0A=
> -             gc->cq_table[cq->id] =3D gdma_cq;=0A=
> +             gdma_cq_allocated[i] =3D gc->cq_table[cq->id];=0A=
>       }=0A=
>       resp.num_entries =3D i;=0A=
>=0A=
> @@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,=
 struct ib_pd *ibpd,=0A=
>       send_cq->id =3D cq_spec.queue_index;=0A=
>=0A=
>       /* Create CQ table entry */=0A=
> -     WARN_ON(gc->cq_table[send_cq->id]);=0A=
> -     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> -     if (!gdma_cq) {=0A=
> -             err =3D -ENOMEM;=0A=
> +     err =3D mana_ib_install_cq_cb(mdev, send_cq);=0A=
> +     if (err)=0A=
>               goto err_destroy_wq_obj;=0A=
> -     }=0A=
> -=0A=
> -     gdma_cq->cq.context =3D send_cq;=0A=
> -     gdma_cq->type =3D GDMA_CQ;=0A=
> -     gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> -     gdma_cq->id =3D send_cq->id;=0A=
> -     gc->cq_table[send_cq->id] =3D gdma_cq;=0A=
>=0A=
>       ibdev_dbg(&mdev->ib_dev,=0A=
>                 "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", er=
r,=0A=
> @@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, =
struct ib_pd *ibpd,=0A=
>=0A=
>  err_release_gdma_cq:=0A=
>       kfree(gdma_cq);=0A=
> -     gd->gdma_context->cq_table[send_cq->id] =3D NULL;=0A=
> +     gc->cq_table[send_cq->id] =3D NULL;=0A=
>=0A=
>  err_destroy_wq_obj:=0A=
>       mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);=0A=
>=0A=
> base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e=0A=
> prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03=0A=
> --=0A=
> 2.43.0=0A=
>=0A=
=0A=
=0A=
________________________________________=0A=
From: Leon Romanovsky <leon@kernel.org>=0A=
Sent: Thursday, January 11, 2024 12:14 PM=0A=
To: Konstantin Taranov=0A=
Cc: Konstantin Taranov; Long Li; jgg@ziepe.ca; linux-rdma@vger.kernel.org; =
linux-kernel@vger.kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three h=
elper functions to clean mana_ib code=0A=
=0A=
[You don't often get email from leon@kernel.org. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
On Wed, Jan 10, 2024 at 06:14:34AM -0800, Konstantin Taranov wrote:=0A=
> From: Konstantin Taranov <kotaranov@microsoft.com>=0A=
>=0A=
> This patch aims to address two issues in mana_ib:=0A=
> 1) Unsafe and inconsistent access to gdma_dev and  gdma_context=0A=
=0A=
And how is it safe now? What is unsafe here?=0A=
=0A=
> 2) Code repetitions=0A=
>=0A=
> As a rule of thumb, functions should not access gdma_dev directly=0A=
>=0A=
> Introduced functions:=0A=
> 1) mdev_to_gc=0A=
=0A=
Which is exactly "mdev->gdma_dev->gdma_context" as before.=0A=
=0A=
> 2) mana_ib_get_netdev=0A=
> 3) mana_ib_install_cq_cb=0A=
>=0A=
>=0A=
=0A=
We are in merge window and cleanup patch will need to wait till it ends.=0A=
=0A=
Thanks=0A=
=0A=
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>=0A=
> ---=0A=
> Sorry that was sent again, I forgot to add RDMA/mana_ib to the subject=0A=
> ---=0A=
>  drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--=0A=
>  drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------=
=0A=
>  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++=0A=
>  drivers/infiniband/hw/mana/mr.c      | 13 +++------=0A=
>  drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------=0A=
>  5 files changed, 63 insertions(+), 66 deletions(-)=0A=
>=0A=
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c=0A=
> index 83ebd0705..255e74ab7 100644=0A=
> --- a/drivers/infiniband/hw/mana/cq.c=0A=
> +++ b/drivers/infiniband/hw/mana/cq.c=0A=
> @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct =
ib_cq_init_attr *attr,=0A=
>       int err;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       if (udata->inlen < sizeof(ucmd))=0A=
>               return -EINVAL;=0A=
> @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_ud=
ata *udata)=0A=
>       int err;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);=0A=
>       if (err) {=0A=
> @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct gdma_queue=
 *gdma_cq)=0A=
>       if (cq->ibcq.comp_handler)=0A=
>               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);=0A=
>  }=0A=
> +=0A=
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q)=0A=
> +{=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(mdev);=0A=
> +     struct gdma_queue *gdma_cq;=0A=
> +=0A=
> +     /* Create CQ table entry */=0A=
> +     WARN_ON(gc->cq_table[cq->id]);=0A=
> +     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> +     if (!gdma_cq)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     gdma_cq->cq.context =3D cq;=0A=
> +     gdma_cq->type =3D GDMA_CQ;=0A=
> +     gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> +     gdma_cq->id =3D cq->id;=0A=
> +     gc->cq_table[cq->id] =3D gdma_cq;=0A=
> +     return 0;=0A=
> +}=0A=
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/ma=
na/main.c=0A=
> index faca09245..29dd2438d 100644=0A=
> --- a/drivers/infiniband/hw/mana/main.c=0A=
> +++ b/drivers/infiniband/hw/mana/main.c=0A=
> @@ -8,13 +8,10 @@=0A=
>  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,=
=0A=
>                        u32 port)=0A=
>  {=0A=
> -     struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;=0A=
>       struct mana_port_context *mpc;=0A=
>       struct net_device *ndev;=0A=
> -     struct mana_context *mc;=0A=
>=0A=
> -     mc =3D gd->driver_data;=0A=
> -     ndev =3D mc->ports[port];=0A=
> +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);=0A=
>       mpc =3D netdev_priv(ndev);=0A=
>=0A=
>       mutex_lock(&pd->vport_mutex);=0A=
> @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, str=
uct mana_ib_pd *pd,=0A=
>  int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_=
pd *pd,=0A=
>                     u32 doorbell_id)=0A=
>  {=0A=
> -     struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;=0A=
>       struct mana_port_context *mpc;=0A=
> -     struct mana_context *mc;=0A=
>       struct net_device *ndev;=0A=
>       int err;=0A=
>=0A=
> -     mc =3D mdev->driver_data;=0A=
> -     ndev =3D mc->ports[port];=0A=
> +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);=0A=
>       mpc =3D netdev_priv(ndev);=0A=
>=0A=
>       mutex_lock(&pd->vport_mutex);=0A=
> @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_ud=
ata *udata)=0A=
>       struct gdma_create_pd_req req =3D {};=0A=
>       enum gdma_pd_flags flags =3D 0;=0A=
>       struct mana_ib_dev *dev;=0A=
> -     struct gdma_dev *mdev;=0A=
> +     struct gdma_context *gc;=0A=
>       int err;=0A=
>=0A=
>       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
>       req.flags =3D flags;=0A=
> -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,=
=0A=
> +     err =3D mana_gd_send_request(gc, sizeof(req), &req,=0A=
>                                  sizeof(resp), &resp);=0A=
>=0A=
>       if (err || resp.hdr.status) {=0A=
> @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct i=
b_udata *udata)=0A=
>       struct gdma_destory_pd_resp resp =3D {};=0A=
>       struct gdma_destroy_pd_req req =3D {};=0A=
>       struct mana_ib_dev *dev;=0A=
> -     struct gdma_dev *mdev;=0A=
> +     struct gdma_context *gc;=0A=
>       int err;=0A=
>=0A=
>       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
>       req.pd_handle =3D pd->pd_handle;=0A=
> -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,=
=0A=
> +     err =3D mana_gd_send_request(gc, sizeof(req), &req,=0A=
>                                  sizeof(resp), &resp);=0A=
>=0A=
>       if (err || resp.hdr.status) {=0A=
> @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibco=
ntext,=0A=
>       struct ib_device *ibdev =3D ibcontext->device;=0A=
>       struct mana_ib_dev *mdev;=0A=
>       struct gdma_context *gc;=0A=
> -     struct gdma_dev *dev;=0A=
>       int doorbell_page;=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     dev =3D mdev->gdma_dev;=0A=
> -     gc =3D dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       /* Allocate a doorbell page index */=0A=
>       ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page);=0A=
> @@ -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibc=
ontext)=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);=
=0A=
>       if (ret)=0A=
> @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev=
 *dev, struct ib_umem *umem,=0A=
>       size_t max_pgs_create_cmd;=0A=
>       struct gdma_context *gc;=0A=
>       size_t num_pages_total;=0A=
> -     struct gdma_dev *mdev;=0A=
>       unsigned long page_sz;=0A=
>       unsigned int tail =3D 0;=0A=
>       u64 *page_addr_list;=0A=
>       void *request_buf;=0A=
>       int err;=0A=
>=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> -     gc =3D mdev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>       hwc =3D gc->hwc.driver_data;=0A=
>=0A=
>       /* Hardware requires dma region to align to chosen page size */=0A=
> @@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev =
*dev, struct ib_umem *umem,=0A=
>=0A=
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_regi=
on)=0A=
>  {=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
>       ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region)=
;=0A=
>=0A=
>       return mana_gd_destroy_dma_region(gc, gdma_region);=0A=
> @@ -447,7 +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struc=
t vm_area_struct *vma)=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       if (vma->vm_pgoff !=3D 0) {=0A=
>               ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff=
);=0A=
> @@ -531,7 +519,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev =
*dev)=0A=
>       req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;=0A=
>       req.hdr.dev_id =3D dev->gdma_dev->dev_id;=0A=
>=0A=
> -     err =3D mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(re=
q),=0A=
> +     err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),=0A=
>                                  &req, sizeof(resp), &resp);=0A=
>=0A=
>       if (err) {=0A=
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw=
/mana/mana_ib.h=0A=
> index 6bdc0f549..6b15b2ab5 100644=0A=
> --- a/drivers/infiniband/hw/mana/mana_ib.h=0A=
> +++ b/drivers/infiniband/hw/mana/mana_ib.h=0A=
> @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {=0A=
>       u32 max_inline_data_size;=0A=
>  }; /* HW Data */=0A=
>=0A=
> +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)=
=0A=
> +{=0A=
> +     return mdev->gdma_dev->gdma_context;=0A=
> +}=0A=
> +=0A=
> +static inline struct net_device *mana_ib_get_netdev(struct ib_device *ib=
dev, u32 port)=0A=
> +{=0A=
> +     struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev=
, ib_dev);=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(mdev);=0A=
> +     struct mana_context *mc =3D gc->mana.driver_data;=0A=
> +=0A=
> +     if (port < 1 || port > mc->num_ports)=0A=
> +             return NULL;=0A=
> +     return mc->ports[port - 1];=0A=
> +}=0A=
> +=0A=
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem=
 *umem,=0A=
>                                mana_handle_t *gdma_region);=0A=
>=0A=
> @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t ib_cq_init_attr *attr,=0A=
>                     struct ib_udata *udata);=0A=
>=0A=
>  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);=0A=
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q);=0A=
>=0A=
>  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);=0A=
>  int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);=0A=
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c=0A=
> index 351207c60..ee4d4f834 100644=0A=
> --- a/drivers/infiniband/hw/mana/mr.c=0A=
> +++ b/drivers/infiniband/hw/mana/mr.c=0A=
> @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *de=
v, struct mana_ib_mr *mr,=0A=
>  {=0A=
>       struct gdma_create_mr_response resp =3D {};=0A=
>       struct gdma_create_mr_request req =3D {};=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>       int err;=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
> -=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>       req.pd_handle =3D mr_params->pd_handle;=0A=
> @@ -77,12 +74,9 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *d=
ev, u64 mr_handle)=0A=
>  {=0A=
>       struct gdma_destroy_mr_response resp =3D {};=0A=
>       struct gdma_destroy_mr_request req =3D {};=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>       int err;=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
> -=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
> @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd,=
 u64 start, u64 length,=0A=
>       return &mr->ibmr;=0A=
>=0A=
>  err_dma_region:=0A=
> -     mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,=0A=
> -                                dma_region_handle);=0A=
> +     mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);=0A=
>=0A=
>  err_umem:=0A=
>       ib_umem_release(mr->umem);=0A=
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c=0A=
> index e6d063d45..e889c798f 100644=0A=
> --- a/drivers/infiniband/hw/mana/qp.c=0A=
> +++ b/drivers/infiniband/hw/mana/qp.c=0A=
> @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_=
dev *dev,=0A=
>       struct mana_cfg_rx_steer_resp resp =3D {};=0A=
>       mana_handle_t *req_indir_tab;=0A=
>       struct gdma_context *gc;=0A=
> -     struct gdma_dev *mdev;=0A=
>       u32 req_buf_size;=0A=
>       int i, err;=0A=
>=0A=
> -     gc =3D dev->gdma_dev->gdma_context;=0A=
> -     mdev =3D &gc->mana;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       req_buf_size =3D=0A=
>               sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_=
SIZE;=0A=
> @@ -39,7 +37,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_de=
v *dev,=0A=
>       req->rx_enable =3D 1;=0A=
>       req->update_default_rxobj =3D 1;=0A=
>       req->default_rxobj =3D default_rxobj;=0A=
> -     req->hdr.dev_id =3D mdev->dev_id;=0A=
> +     req->hdr.dev_id =3D gc->mana.dev_id;=0A=
>=0A=
>       /* If there are more than 1 entries in indirection table, enable RS=
S */=0A=
>       if (log_ind_tbl_size)=0A=
> @@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, =
struct ib_pd *pd,=0A=
>       struct gdma_queue **gdma_cq_allocated;=0A=
>       mana_handle_t *mana_ind_table;=0A=
>       struct mana_port_context *mpc;=0A=
> -     struct gdma_queue *gdma_cq;=0A=
>       unsigned int ind_tbl_size;=0A=
>       struct net_device *ndev;=0A=
>       struct mana_ib_cq *cq;=0A=
> @@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
, struct ib_pd *pd,=0A=
>               mana_ind_table[i] =3D wq->rx_object;=0A=
>=0A=
>               /* Create CQ table entry */=0A=
> -             WARN_ON(gc->cq_table[cq->id]);=0A=
> -             gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> -             if (!gdma_cq) {=0A=
> -                     ret =3D -ENOMEM;=0A=
> +             ret =3D mana_ib_install_cq_cb(mdev, cq);=0A=
> +             if (!ret)=0A=
>                       goto fail;=0A=
> -             }=0A=
> -             gdma_cq_allocated[i] =3D gdma_cq;=0A=
>=0A=
> -             gdma_cq->cq.context =3D cq;=0A=
> -             gdma_cq->type =3D GDMA_CQ;=0A=
> -             gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> -             gdma_cq->id =3D cq->id;=0A=
> -             gc->cq_table[cq->id] =3D gdma_cq;=0A=
> +             gdma_cq_allocated[i] =3D gc->cq_table[cq->id];=0A=
>       }=0A=
>       resp.num_entries =3D i;=0A=
>=0A=
> @@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,=
 struct ib_pd *ibpd,=0A=
>       send_cq->id =3D cq_spec.queue_index;=0A=
>=0A=
>       /* Create CQ table entry */=0A=
> -     WARN_ON(gc->cq_table[send_cq->id]);=0A=
> -     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> -     if (!gdma_cq) {=0A=
> -             err =3D -ENOMEM;=0A=
> +     err =3D mana_ib_install_cq_cb(mdev, send_cq);=0A=
> +     if (err)=0A=
>               goto err_destroy_wq_obj;=0A=
> -     }=0A=
> -=0A=
> -     gdma_cq->cq.context =3D send_cq;=0A=
> -     gdma_cq->type =3D GDMA_CQ;=0A=
> -     gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> -     gdma_cq->id =3D send_cq->id;=0A=
> -     gc->cq_table[send_cq->id] =3D gdma_cq;=0A=
>=0A=
>       ibdev_dbg(&mdev->ib_dev,=0A=
>                 "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", er=
r,=0A=
> @@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, =
struct ib_pd *ibpd,=0A=
>=0A=
>  err_release_gdma_cq:=0A=
>       kfree(gdma_cq);=0A=
> -     gd->gdma_context->cq_table[send_cq->id] =3D NULL;=0A=
> +     gc->cq_table[send_cq->id] =3D NULL;=0A=
>=0A=
>  err_destroy_wq_obj:=0A=
>       mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);=0A=
>=0A=
> base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e=0A=
> prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03=0A=
> --=0A=
> 2.43.0=0A=
>=0A=
=0A=
=0A=
________________________________________=0A=
From: Leon Romanovsky <leon@kernel.org>=0A=
Sent: Thursday, January 11, 2024 12:14 PM=0A=
To: Konstantin Taranov=0A=
Cc: Konstantin Taranov; Long Li; jgg@ziepe.ca; linux-rdma@vger.kernel.org; =
linux-kernel@vger.kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH next v2 1/1] RDMA/mana_ib: Introduce three h=
elper functions to clean mana_ib code=0A=
=0A=
[You don't often get email from leon@kernel.org. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
On Wed, Jan 10, 2024 at 06:14:34AM -0800, Konstantin Taranov wrote:=0A=
> From: Konstantin Taranov <kotaranov@microsoft.com>=0A=
>=0A=
> This patch aims to address two issues in mana_ib:=0A=
> 1) Unsafe and inconsistent access to gdma_dev and  gdma_context=0A=
=0A=
And how is it safe now? What is unsafe here?=0A=
=0A=
> 2) Code repetitions=0A=
>=0A=
> As a rule of thumb, functions should not access gdma_dev directly=0A=
>=0A=
> Introduced functions:=0A=
> 1) mdev_to_gc=0A=
=0A=
Which is exactly "mdev->gdma_dev->gdma_context" as before.=0A=
=0A=
> 2) mana_ib_get_netdev=0A=
> 3) mana_ib_install_cq_cb=0A=
>=0A=
>=0A=
=0A=
We are in merge window and cleanup patch will need to wait till it ends.=0A=
=0A=
Thanks=0A=
=0A=
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>=0A=
> ---=0A=
> Sorry that was sent again, I forgot to add RDMA/mana_ib to the subject=0A=
> ---=0A=
>  drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--=0A=
>  drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------=
=0A=
>  drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++=0A=
>  drivers/infiniband/hw/mana/mr.c      | 13 +++------=0A=
>  drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------=0A=
>  5 files changed, 63 insertions(+), 66 deletions(-)=0A=
>=0A=
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c=0A=
> index 83ebd0705..255e74ab7 100644=0A=
> --- a/drivers/infiniband/hw/mana/cq.c=0A=
> +++ b/drivers/infiniband/hw/mana/cq.c=0A=
> @@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct =
ib_cq_init_attr *attr,=0A=
>       int err;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       if (udata->inlen < sizeof(ucmd))=0A=
>               return -EINVAL;=0A=
> @@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_ud=
ata *udata)=0A=
>       int err;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       err =3D mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);=0A=
>       if (err) {=0A=
> @@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct gdma_queue=
 *gdma_cq)=0A=
>       if (cq->ibcq.comp_handler)=0A=
>               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);=0A=
>  }=0A=
> +=0A=
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q)=0A=
> +{=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(mdev);=0A=
> +     struct gdma_queue *gdma_cq;=0A=
> +=0A=
> +     /* Create CQ table entry */=0A=
> +     WARN_ON(gc->cq_table[cq->id]);=0A=
> +     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> +     if (!gdma_cq)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     gdma_cq->cq.context =3D cq;=0A=
> +     gdma_cq->type =3D GDMA_CQ;=0A=
> +     gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> +     gdma_cq->id =3D cq->id;=0A=
> +     gc->cq_table[cq->id] =3D gdma_cq;=0A=
> +     return 0;=0A=
> +}=0A=
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/ma=
na/main.c=0A=
> index faca09245..29dd2438d 100644=0A=
> --- a/drivers/infiniband/hw/mana/main.c=0A=
> +++ b/drivers/infiniband/hw/mana/main.c=0A=
> @@ -8,13 +8,10 @@=0A=
>  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,=
=0A=
>                        u32 port)=0A=
>  {=0A=
> -     struct gdma_dev *gd =3D &dev->gdma_dev->gdma_context->mana;=0A=
>       struct mana_port_context *mpc;=0A=
>       struct net_device *ndev;=0A=
> -     struct mana_context *mc;=0A=
>=0A=
> -     mc =3D gd->driver_data;=0A=
> -     ndev =3D mc->ports[port];=0A=
> +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);=0A=
>       mpc =3D netdev_priv(ndev);=0A=
>=0A=
>       mutex_lock(&pd->vport_mutex);=0A=
> @@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, str=
uct mana_ib_pd *pd,=0A=
>  int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_=
pd *pd,=0A=
>                     u32 doorbell_id)=0A=
>  {=0A=
> -     struct gdma_dev *mdev =3D &dev->gdma_dev->gdma_context->mana;=0A=
>       struct mana_port_context *mpc;=0A=
> -     struct mana_context *mc;=0A=
>       struct net_device *ndev;=0A=
>       int err;=0A=
>=0A=
> -     mc =3D mdev->driver_data;=0A=
> -     ndev =3D mc->ports[port];=0A=
> +     ndev =3D mana_ib_get_netdev(&dev->ib_dev, port);=0A=
>       mpc =3D netdev_priv(ndev);=0A=
>=0A=
>       mutex_lock(&pd->vport_mutex);=0A=
> @@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_ud=
ata *udata)=0A=
>       struct gdma_create_pd_req req =3D {};=0A=
>       enum gdma_pd_flags flags =3D 0;=0A=
>       struct mana_ib_dev *dev;=0A=
> -     struct gdma_dev *mdev;=0A=
> +     struct gdma_context *gc;=0A=
>       int err;=0A=
>=0A=
>       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
>       req.flags =3D flags;=0A=
> -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,=
=0A=
> +     err =3D mana_gd_send_request(gc, sizeof(req), &req,=0A=
>                                  sizeof(resp), &resp);=0A=
>=0A=
>       if (err || resp.hdr.status) {=0A=
> @@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct i=
b_udata *udata)=0A=
>       struct gdma_destory_pd_resp resp =3D {};=0A=
>       struct gdma_destroy_pd_req req =3D {};=0A=
>       struct mana_ib_dev *dev;=0A=
> -     struct gdma_dev *mdev;=0A=
> +     struct gdma_context *gc;=0A=
>       int err;=0A=
>=0A=
>       dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
>       req.pd_handle =3D pd->pd_handle;=0A=
> -     err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,=
=0A=
> +     err =3D mana_gd_send_request(gc, sizeof(req), &req,=0A=
>                                  sizeof(resp), &resp);=0A=
>=0A=
>       if (err || resp.hdr.status) {=0A=
> @@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibco=
ntext,=0A=
>       struct ib_device *ibdev =3D ibcontext->device;=0A=
>       struct mana_ib_dev *mdev;=0A=
>       struct gdma_context *gc;=0A=
> -     struct gdma_dev *dev;=0A=
>       int doorbell_page;=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     dev =3D mdev->gdma_dev;=0A=
> -     gc =3D dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       /* Allocate a doorbell page index */=0A=
>       ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page);=0A=
> @@ -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibc=
ontext)=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);=
=0A=
>       if (ret)=0A=
> @@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev=
 *dev, struct ib_umem *umem,=0A=
>       size_t max_pgs_create_cmd;=0A=
>       struct gdma_context *gc;=0A=
>       size_t num_pages_total;=0A=
> -     struct gdma_dev *mdev;=0A=
>       unsigned long page_sz;=0A=
>       unsigned int tail =3D 0;=0A=
>       u64 *page_addr_list;=0A=
>       void *request_buf;=0A=
>       int err;=0A=
>=0A=
> -     mdev =3D dev->gdma_dev;=0A=
> -     gc =3D mdev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>       hwc =3D gc->hwc.driver_data;=0A=
>=0A=
>       /* Hardware requires dma region to align to chosen page size */=0A=
> @@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev =
*dev, struct ib_umem *umem,=0A=
>=0A=
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_regi=
on)=0A=
>  {=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
>       ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region)=
;=0A=
>=0A=
>       return mana_gd_destroy_dma_region(gc, gdma_region);=0A=
> @@ -447,7 +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struc=
t vm_area_struct *vma)=0A=
>       int ret;=0A=
>=0A=
>       mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);=0A=
> -     gc =3D mdev->gdma_dev->gdma_context;=0A=
> +     gc =3D mdev_to_gc(mdev);=0A=
>=0A=
>       if (vma->vm_pgoff !=3D 0) {=0A=
>               ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff=
);=0A=
> @@ -531,7 +519,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev =
*dev)=0A=
>       req.hdr.resp.msg_version =3D GDMA_MESSAGE_V3;=0A=
>       req.hdr.dev_id =3D dev->gdma_dev->dev_id;=0A=
>=0A=
> -     err =3D mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(re=
q),=0A=
> +     err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req),=0A=
>                                  &req, sizeof(resp), &resp);=0A=
>=0A=
>       if (err) {=0A=
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw=
/mana/mana_ib.h=0A=
> index 6bdc0f549..6b15b2ab5 100644=0A=
> --- a/drivers/infiniband/hw/mana/mana_ib.h=0A=
> +++ b/drivers/infiniband/hw/mana/mana_ib.h=0A=
> @@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {=0A=
>       u32 max_inline_data_size;=0A=
>  }; /* HW Data */=0A=
>=0A=
> +static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)=
=0A=
> +{=0A=
> +     return mdev->gdma_dev->gdma_context;=0A=
> +}=0A=
> +=0A=
> +static inline struct net_device *mana_ib_get_netdev(struct ib_device *ib=
dev, u32 port)=0A=
> +{=0A=
> +     struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev=
, ib_dev);=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(mdev);=0A=
> +     struct mana_context *mc =3D gc->mana.driver_data;=0A=
> +=0A=
> +     if (port < 1 || port > mc->num_ports)=0A=
> +             return NULL;=0A=
> +     return mc->ports[port - 1];=0A=
> +}=0A=
> +=0A=
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem=
 *umem,=0A=
>                                mana_handle_t *gdma_region);=0A=
>=0A=
> @@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t ib_cq_init_attr *attr,=0A=
>                     struct ib_udata *udata);=0A=
>=0A=
>  int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);=0A=
> +int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *c=
q);=0A=
>=0A=
>  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);=0A=
>  int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);=0A=
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c=0A=
> index 351207c60..ee4d4f834 100644=0A=
> --- a/drivers/infiniband/hw/mana/mr.c=0A=
> +++ b/drivers/infiniband/hw/mana/mr.c=0A=
> @@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *de=
v, struct mana_ib_mr *mr,=0A=
>  {=0A=
>       struct gdma_create_mr_response resp =3D {};=0A=
>       struct gdma_create_mr_request req =3D {};=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>       int err;=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
> -=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>       req.pd_handle =3D mr_params->pd_handle;=0A=
> @@ -77,12 +74,9 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *d=
ev, u64 mr_handle)=0A=
>  {=0A=
>       struct gdma_destroy_mr_response resp =3D {};=0A=
>       struct gdma_destroy_mr_request req =3D {};=0A=
> -     struct gdma_dev *mdev =3D dev->gdma_dev;=0A=
> -     struct gdma_context *gc;=0A=
> +     struct gdma_context *gc =3D mdev_to_gc(dev);=0A=
>       int err;=0A=
>=0A=
> -     gc =3D mdev->gdma_context;=0A=
> -=0A=
>       mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),=0A=
>                            sizeof(resp));=0A=
>=0A=
> @@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd,=
 u64 start, u64 length,=0A=
>       return &mr->ibmr;=0A=
>=0A=
>  err_dma_region:=0A=
> -     mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,=0A=
> -                                dma_region_handle);=0A=
> +     mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);=0A=
>=0A=
>  err_umem:=0A=
>       ib_umem_release(mr->umem);=0A=
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c=0A=
> index e6d063d45..e889c798f 100644=0A=
> --- a/drivers/infiniband/hw/mana/qp.c=0A=
> +++ b/drivers/infiniband/hw/mana/qp.c=0A=
> @@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_=
dev *dev,=0A=
>       struct mana_cfg_rx_steer_resp resp =3D {};=0A=
>       mana_handle_t *req_indir_tab;=0A=
>       struct gdma_context *gc;=0A=
> -     struct gdma_dev *mdev;=0A=
>       u32 req_buf_size;=0A=
>       int i, err;=0A=
>=0A=
> -     gc =3D dev->gdma_dev->gdma_context;=0A=
> -     mdev =3D &gc->mana;=0A=
> +     gc =3D mdev_to_gc(dev);=0A=
>=0A=
>       req_buf_size =3D=0A=
>               sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_=
SIZE;=0A=
> @@ -39,7 +37,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_de=
v *dev,=0A=
>       req->rx_enable =3D 1;=0A=
>       req->update_default_rxobj =3D 1;=0A=
>       req->default_rxobj =3D default_rxobj;=0A=
> -     req->hdr.dev_id =3D mdev->dev_id;=0A=
> +     req->hdr.dev_id =3D gc->mana.dev_id;=0A=
>=0A=
>       /* If there are more than 1 entries in indirection table, enable RS=
S */=0A=
>       if (log_ind_tbl_size)=0A=
> @@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, =
struct ib_pd *pd,=0A=
>       struct gdma_queue **gdma_cq_allocated;=0A=
>       mana_handle_t *mana_ind_table;=0A=
>       struct mana_port_context *mpc;=0A=
> -     struct gdma_queue *gdma_cq;=0A=
>       unsigned int ind_tbl_size;=0A=
>       struct net_device *ndev;=0A=
>       struct mana_ib_cq *cq;=0A=
> @@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
, struct ib_pd *pd,=0A=
>               mana_ind_table[i] =3D wq->rx_object;=0A=
>=0A=
>               /* Create CQ table entry */=0A=
> -             WARN_ON(gc->cq_table[cq->id]);=0A=
> -             gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> -             if (!gdma_cq) {=0A=
> -                     ret =3D -ENOMEM;=0A=
> +             ret =3D mana_ib_install_cq_cb(mdev, cq);=0A=
> +             if (!ret)=0A=
>                       goto fail;=0A=
> -             }=0A=
> -             gdma_cq_allocated[i] =3D gdma_cq;=0A=
>=0A=
> -             gdma_cq->cq.context =3D cq;=0A=
> -             gdma_cq->type =3D GDMA_CQ;=0A=
> -             gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> -             gdma_cq->id =3D cq->id;=0A=
> -             gc->cq_table[cq->id] =3D gdma_cq;=0A=
> +             gdma_cq_allocated[i] =3D gc->cq_table[cq->id];=0A=
>       }=0A=
>       resp.num_entries =3D i;=0A=
>=0A=
> @@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,=
 struct ib_pd *ibpd,=0A=
>       send_cq->id =3D cq_spec.queue_index;=0A=
>=0A=
>       /* Create CQ table entry */=0A=
> -     WARN_ON(gc->cq_table[send_cq->id]);=0A=
> -     gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);=0A=
> -     if (!gdma_cq) {=0A=
> -             err =3D -ENOMEM;=0A=
> +     err =3D mana_ib_install_cq_cb(mdev, send_cq);=0A=
> +     if (err)=0A=
>               goto err_destroy_wq_obj;=0A=
> -     }=0A=
> -=0A=
> -     gdma_cq->cq.context =3D send_cq;=0A=
> -     gdma_cq->type =3D GDMA_CQ;=0A=
> -     gdma_cq->cq.callback =3D mana_ib_cq_handler;=0A=
> -     gdma_cq->id =3D send_cq->id;=0A=
> -     gc->cq_table[send_cq->id] =3D gdma_cq;=0A=
>=0A=
>       ibdev_dbg(&mdev->ib_dev,=0A=
>                 "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", er=
r,=0A=
> @@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, =
struct ib_pd *ibpd,=0A=
>=0A=
>  err_release_gdma_cq:=0A=
>       kfree(gdma_cq);=0A=
> -     gd->gdma_context->cq_table[send_cq->id] =3D NULL;=0A=
> +     gc->cq_table[send_cq->id] =3D NULL;=0A=
>=0A=
>  err_destroy_wq_obj:=0A=
>       mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);=0A=
>=0A=
> base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e=0A=
> prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03=0A=
> --=0A=
> 2.43.0=0A=
>=0A=

