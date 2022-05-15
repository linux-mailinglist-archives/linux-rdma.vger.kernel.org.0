Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF15276CF
	for <lists+linux-rdma@lfdr.de>; Sun, 15 May 2022 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiEOKMR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEOKMQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 06:12:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62836B47;
        Sun, 15 May 2022 03:12:15 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24F66x6E025939;
        Sun, 15 May 2022 03:12:07 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3g29sq2upp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 03:12:07 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24FAC7xV028036;
        Sun, 15 May 2022 03:12:07 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3g29sq2upg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 03:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUHUMcMtmblY3tx7FFR0dR2+h33Qp/defhIXESglpEBUmNPZErldfIEZmb1vGZhRzA0lM/wxLDfO+2v3ZdcR8PFK/NMQ0Jid8X7TqCgOOW6AR0Wsougytd/+AQfiumlX/3kd6sC8ww8luyeFGv6Jh5H23skmsJkM5beZ2dUU66Nd2SVUkc0Eg1YB/q8FEOXSh8/8iyLjYZu459yxwCKk0YZeYOsWvn8aYje5pemLDMMYY6wuYuAQtDWweblI9hYgQmrZWOxl80tGAKxNlqBd9J5CpGjade7/byW970cX5grLDjjqOEXDTWLBQ36gb+NDlufta7ao6FYUA2WxmIfbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBFrVsFLU52IbDXl2C6xksyH0Ihh9FY4hG97E0IWVHs=;
 b=aH1IIedIN773qQipB0kEv4bliekz3aiuLdMstUCUFmVkauctrn4G9WA6r70th8JocpryaVxzSaKn1Lf/gqwmsW3vQ+1nZjnWR089ZjYoSIgyNOE7wnZ+RpJzQZxPVA7ps6KOEuYvFdRNvqN+vi1ha/qOVFWUTZN2iTfdU40XV0uA0JRLRqabldhjyBGnXNaYgIhkoxx6K+UCNbeTYYL6teI6mdgZNCQJ5UzqT1YVp0/UjhXDcz0qWnXfs039sgWgz0v2mAd66a8Sx1vgaaKtmyXKO4EMKC6IwQRL9vYw5WOt1KrcioLrOLuGvtsDYzsJVSeBL+PlEkeFGlkf//eblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBFrVsFLU52IbDXl2C6xksyH0Ihh9FY4hG97E0IWVHs=;
 b=sJTH268vVtTOs3YjAAt1YFm/mbJ16qx2IyjmQQNAaRZLQtEEEAgJi/SsaDPOXQInLUuYGOoE4nGlKMVkr1o9aUy98KGERjs7+nQro4eCeyaCg+AHtYCkPx/5X/oz2P1msWgIBCq6SqOVgC9tpDEOB7zh3sEkKX32JnQ2d98k5tQ=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by MN2PR18MB2415.namprd18.prod.outlook.com (2603:10b6:208:af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sun, 15 May
 2022 10:12:04 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::2107:4c3d:3ac:fd7f]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::2107:4c3d:3ac:fd7f%7]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 10:12:04 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: RE: [EXT] [PATCH] qedr: Remove unnecessary synchronize_irq() before
 free_irq()
Thread-Topic: [EXT] [PATCH] qedr: Remove unnecessary synchronize_irq() before
 free_irq()
Thread-Index: AQHYZqHP5jECl730ekyBCzaItykk5q0fuw7w
Date:   Sun, 15 May 2022 10:12:04 +0000
Message-ID: <CH0PR18MB41293954D3162904680FB6F0A1CC9@CH0PR18MB4129.namprd18.prod.outlook.com>
References: <20220513081647.1631141-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220513081647.1631141-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d8a577b-b6cf-45e4-7b70-08da365b5c84
x-ms-traffictypediagnostic: MN2PR18MB2415:EE_
x-microsoft-antispam-prvs: <MN2PR18MB2415CA7A0038A269460831C0A1CC9@MN2PR18MB2415.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uALpdUj5b19U9VspEW7tQKOg+6CwY5CTO7edXvz2q8SgQo0UGCxQKMQW2P3p35Z8UaclMPdH7HVpWeglhM2ICiS20GSoHWN72So3IBoTvN4clws3T6RUDjNXf6Ni/LRtBWE2o7XOLwLSDosBfgWlc0/qDApQLKfhYFlrCmkduUvvP+j0R7Sx9rOWaHXSW/z0AIsb/5aLnYoHo+Ja4C69Cua1VpDdllLtJgSGND7Mizkksqf/dYUYrbX8OY9TkljX90N8QuPYBfpLsKpcnPkltvM5VTpeQUtZoVevfNyKhXhnI+4RGpzChkvtiEYqO3fYJyac+rACPbYK1HpSvB5POJZgtAWoGrYLXpIY97mXki74FoQFrj0ZtuxkP6p81K0SB2hny9ktp9qhUo1QO0ubRwYe1MwUD2+mIT4Dec3WB01Ya2T5P/f0X/9Bawx2FUm9M2q/KALVIvsEL7sWbK3tZQU/zRdxJZIpmnAZ48thvV50hHmsNIVM4Ht+hQv97vsx+2V0fFiqTLiKpTg3I9E4T5jgzzGu85bkg+K4bUxJc1L4e5weHE+W6HTE7cAt/UGa9wgwj85DjshqAAfUz3Q8yozN7mMDQlAu0CCtyw38ickwRejYdVsAUcqfDrl2oSU0nH0I3JCFm8TbQNu3R531lKDCn/FateCnbPa3AyQufIh2GgAnnPP2IcI/hx6HZEE1VjNCrBHyt7LKFiJDFmJFTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4129.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(54906003)(8676002)(76116006)(86362001)(4326008)(66556008)(55016003)(83380400001)(64756008)(66446008)(66476007)(6916009)(38100700002)(6506007)(53546011)(5660300002)(33656002)(9686003)(26005)(38070700005)(7696005)(186003)(8936002)(508600001)(2906002)(316002)(122000001)(71200400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9gxW2rRIPVEQ8Tk0KwbfgNoRjVUTq4sKrmXMrd83helWEWowxiR7FolZK/?=
 =?iso-8859-1?Q?ebDP52Gp3Lh7K9kcFVouMnuJrNwu9q76I96rMHqn7KVyKksNipWcWEjOE5?=
 =?iso-8859-1?Q?O6+/r4XwnJD+0w1R4bhvFIiw8wvghNxQEWzHKdsluz9GFpnx67LxcQJYao?=
 =?iso-8859-1?Q?rt2BPToOrO6WPLZm9cx/RA+YfN72ykBfxFjSRgc2zwrq1yhKy5wl9Zgs2t?=
 =?iso-8859-1?Q?KshHd8ML+FMCPdJ4iak3Oi2SZo6hcFZvK19bdTufKg3Q+EhxTYkgzMYPVj?=
 =?iso-8859-1?Q?Y/sXuWQHDaaKl9ibDLA30RejjzIDHiSIlpGljvTGkdC0bzqDfU2LqcMgcW?=
 =?iso-8859-1?Q?wA5+jWeO2hhO1Z38DJSa/eW9ZtqoCNpi4xxnCUILXCZiiH6w0aeAqyNy2U?=
 =?iso-8859-1?Q?HEWBccrHEN4spZU09th/BwG2vzJVvEGBNuxv++PHBR14lJ0+UiYHZIp9WI?=
 =?iso-8859-1?Q?R5pqLbWOGy9whfsI+pFI4Z3qUpg7PWamnuMVEb2twKSluSELkUuBL27eW8?=
 =?iso-8859-1?Q?hXo7pRCzdP8qohAKteOqKMbmYSHmPO9vfvVrNfb3v4IF5zEq+ZZIG3QbvE?=
 =?iso-8859-1?Q?mXl+wZvU/8ygDEw7dFSMYm5OO7AUERApLYrthgC+F/9NLm3G0JANylYADR?=
 =?iso-8859-1?Q?WIyRb5aEn/Ki54LSWH2FsmZVltji+xDTC/CSbDiAn0frGnFG6PXsux++bY?=
 =?iso-8859-1?Q?Tjg0ysyppb0YmeiF40tVKgKNrB5TraEE5JrsfPiqS0vkhg2cGUPVK7R6N7?=
 =?iso-8859-1?Q?56g+7KdPyaMqg+lu9k0YeP1aU0nbnSL9TRkDoyKgpDNAXSnCLHaCSSXjRe?=
 =?iso-8859-1?Q?Jb8tf/kAayn/VNwv3tmweUaHCZWil7K2pl3k5CGLB/s73pQB1J1GnxjDcI?=
 =?iso-8859-1?Q?CIgmaOJG1E7Dr2juI5WgBbWD/gOgcTIzIkDeGZL7I43YKF2wYvEuzJjEkx?=
 =?iso-8859-1?Q?wYnmz5a9nTphObDFfsxA4L57dhdx0GjZltkQS95bfmt0s9xVx5D5cHM4ZX?=
 =?iso-8859-1?Q?LEcW759m2liGtS6L/1gZFRj/D8hR3c0kpOdyOGgKeQCvQw1KIXVYa2Fzaz?=
 =?iso-8859-1?Q?hZ1bRB8jXwKgJYtoe1c6ynbXBiT29B+8oHLZs12aY51oygXJ0lV5FRnj6R?=
 =?iso-8859-1?Q?lWZeIBVnBDyU+/Gb0TyI1aIl20uhr6jsZugkJWjTvQImS/dvVnqp9OAqYN?=
 =?iso-8859-1?Q?SQ2wyGb9I7VV9SuWb3d+bEBDL9sQcyMCzQWLgH0vXUikgFOg0LWv9On+xD?=
 =?iso-8859-1?Q?zUekp6hbn9EpTvK5tpv15yXlddpWpTcAOxepqMz6AZTXQkR6B3yOiCcgVt?=
 =?iso-8859-1?Q?9u1yUlkwODxyUFFJNOUc3Nuzspa8aF5kIAv3w11vY5TmwoeZN6ykih99K/?=
 =?iso-8859-1?Q?Ly/NkXSL1FGVU5ytQxVe1+7E1CAd60RVaaloTrS7i7pdFjhSzR7fGw+2Wh?=
 =?iso-8859-1?Q?DbxHCG03FqXPZK8a9dNXZDzC0iPRGJiXEj4URcufhonIBB2UWXWvLFUjOK?=
 =?iso-8859-1?Q?kVGA2sx26OigtDqAvFOMigECr5kHW6veXvrMmkNiqQma/cNlWgtaTqG7bt?=
 =?iso-8859-1?Q?xpLLoaYbILh3u9rYhQLIF8O7a9MEZo3AwgYFWiHEeLvnkTPhKM0XKAEfbZ?=
 =?iso-8859-1?Q?kUZpdnqsRfhnxH/JmimUIrJYlA/RuZKtxvfZH4SXYc2Yvfxp1vouLdB4pm?=
 =?iso-8859-1?Q?DjausMazFIFzmeHZmjTIN6gDOiQ3EPIriLX1K/GGTi9VlAMPj7+aFel3PI?=
 =?iso-8859-1?Q?n3U5MBAshfsN+hX4ovH2xvYWEY28VvTd8icEC0AgQ2QId+AG2+adgX6OW5?=
 =?iso-8859-1?Q?I+zNN8M11Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8a577b-b6cf-45e4-7b70-08da365b5c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2022 10:12:04.7975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4Jvq/8NWtXkIfglRdd1zyufVRB7XnmPRquE97f6SvrL9GVpx8BnY7FEl90P0IXIOy9aU+sm8MkZGUE13KKwRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2415
X-Proofpoint-ORIG-GUID: 7B4neVP-4vEr5sHt5tM4pdpY5m0Vk8tu
X-Proofpoint-GUID: rtdShK8C8L_Shd3SUuO5aEX62fS_aG1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-15_05,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Friday, May 13, 2022 11:17 AM
> To: Michal Kalderon <mkalderon@marvell.com>
> Cc: Ariel Elior <aelior@marvell.com>; jgg@ziepe.ca; leon@kernel.org; linu=
x-
> rdma@vger.kernel.org; linux-kernel@vger.kernel.org; Minghao Chi
> <chi.minghao@zte.com.cn>; Zeal Robot <zealci@zte.com.cn>
> Subject: [EXT] [PATCH] qedr: Remove unnecessary synchronize_irq() before
> free_irq()
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Calling synchronize_irq() right before free_irq() is quite useless. On on=
e
> hand the IRQ can easily fire again before free_irq() is entered, on the
> other hand free_irq() itself calls synchronize_irq() internally (in a rac=
e
> condition free way), before any state associated with the IRQ is freed.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/hw/qedr/main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index 65ce6d0f1885..5152f10d2e6d 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -500,7 +500,6 @@ static void qedr_sync_free_irqs(struct qedr_dev
> *dev)
>  		if (dev->int_info.msix_cnt) {
>  			idx =3D i * dev->num_hwfns + dev->affin_hwfn_idx;
>  			vector =3D dev->int_info.msix[idx].vector;
> -			synchronize_irq(vector);
>  			free_irq(vector, &dev->cnq_array[i]);
>  		}
>  	}
> --
> 2.25.1
>=20

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


