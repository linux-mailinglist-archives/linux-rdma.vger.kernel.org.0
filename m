Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474D4194C3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhI0NGs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 09:06:48 -0400
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:10048
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234454AbhI0NGs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 09:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXt2naogi3vjNQoKL7N7nQyb6xIBkRv8KvljjAUxGVGR3CuBvp6FmpTJe4q/q8RGgLCfE3Je/PUwPcWaIquH2dncBjKEN+MFy8tHl6/Bcha5wM424TdmcAZhaqed53fG1uoxt8aHkctDLqhZJB4JPtQWwpRWkdHvoOROxQ1cYRzriFwS9jZruDq8wQSX/dCNTAU2G8VFps8hdoAw5aPzMhFkIdH8HHU36ebzVZ9xzVmh6CqdGBcb/51d2eu489ClIGlS7VfGcgddC1Etsjw5kohNYw3Acz4s3biOF1UdxF/w8bxwQcaA9u5R57JSUIBR8GDqlP8bIVwynMSNZGs0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cMs8cKMRC0+yld1I3WpswU7qiY59Xn0KUymN9u6FHSU=;
 b=KXjqMQ68CF5aD87O5ov80CUhQ5fggXMI3gr/xUVTscB61Y4QPfNzWIw6/9WmpTH6Kw3Z3ByNS1OaHIa62yg0bw8eFsG+88veYvcwXXmW4ooTsPR86pEiT6zzv79d/QqTbxBPt12NuFquoc2KWMDEvbnKr/RKyOPsk3sKNAMMlrgWyetsPtvwcRLG8p0wDoBPaZxEOYZkZKOHACQgQ8Px66lQuUschedGKEJa9/IYTbVCm9CXahMT2ybEMCnoWNmBGHPA718PMKNw8SevXJqnoa+0huuEVjOO8whPfYGeBEjL+VBmFc0SmWRh3kpt9Bsfk2v7ugtug3TBUNThLMDa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMs8cKMRC0+yld1I3WpswU7qiY59Xn0KUymN9u6FHSU=;
 b=SENBRCpoo5Gm2Ov4yEBxvSRJcwRfECd+OYTJUGbtfXZNwL3bANCyOGLMF+g47VuRQcqoWh7x2T4Gv8vwQCNaSYHZ9bMMey28qoA+Yh6TGHYq3cNcYI0OvKd9qd33suUvBYXnNpCspzu5V2BbHRllvbQdECiBu/ORDiCwSxu9z2LwEcQFKS3x1GJt5Gl3SjtP9P4ymtsfSjQt9/jZaAuxqDMyrhXb3NyJ/u7lNx+qwauGuLbQ/rf0PziH8PE01RQ9llGbOetN3uEq+8KWsURWUKTAMAsBj1dBKQxlIUJ9727gUzgAw9yf4qHp75KvW3msvaFpyRx5rxfAhKxMNxIqoA==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5941.prod.exchangelabs.com (2603:10b6:610:4a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Mon, 27 Sep 2021 13:05:07 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 13:05:07 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROau34IPg
Date:   Mon, 27 Sep 2021 13:05:07 +0000
Message-ID: <CH0PR01MB7153E9B96065CEB8308816B2F2A79@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sjtu.edu.cn; dkim=none (message not signed)
 header.d=none;sjtu.edu.cn; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbcbbd02-9dc9-4f8d-aa8a-08d981b76de7
x-ms-traffictypediagnostic: CH2PR01MB5941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB59413628C19993E25B8D585DF2A79@CH2PR01MB5941.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNZ3hNe+o3TQ/vozAMLNbmyQ2Khw4GHgpGprhsEXXkLwus9TkIwZZQyWiWqpIpZXLLdg0JGVz/pCfjw7ovkkRoAEbu6q8jHgS2I/BjqdfqgOwMzRqsGaNmpipTAI8MLeQ392sILwhgSVgUvERTFyNT8RSd0UB4fV0+Wln9uYDVKa97p4mcIjuwPOk4j8cmx4CXHzucbk8tWTysOPFj013UAPShnAfL+u05WqIIagNO8KyavUQSmUKveaz7/AAEXdjPe5gp3rXl4gExFxJxoiCh3bfvUf85+V0Nuf+RPbFqc4AEd0ot7idjtnPgaEDVfP/Jop5HbL4fW1oRUR8PONKWmbPdZQ5pqawP2GqDNqEJ2K3XO7mDuMO828sHaBGijgmUO2esaWsMMv9QJVihSlABnJqAMci9UyfX6J1NGlMpZM+I6/BDzeNHTWoyOxHMZSXVquwXWrIwoGjlTuF+jaJcmCjzXjDMiG4Xcb4wf1zUZQzReQciCqWJwpPCVGsLJ7/RiiPbW9l1yX8Ja1RCVdyZvYBZpl0D8ulnGL7sEEFqvD2B3MbPYklSeXKE4ZIT84lyWBQ239RICdpAC3HvFq/ybbXNOBdS8+FuRIKp2N8w83on9Co5jcHAqyZiVySqrWXj5nHxl7Lqv1WlnzfeLOPvCE/cpMvr9IPoj6wgjz91eaOjHibnVoABqwosh4mIWy+SdZ4zme5aVQIvgch+7QbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39830400003)(66946007)(38100700002)(83380400001)(52536014)(33656002)(71200400001)(4326008)(9686003)(5660300002)(86362001)(55016002)(66446008)(122000001)(508600001)(66476007)(66556008)(64756008)(6506007)(76116006)(186003)(8676002)(7696005)(2906002)(26005)(316002)(8936002)(54906003)(110136005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9fM00J2UTWx/KJ2rKIurchb+RltwdcxBAW9AssS3SX7X7IiLOo1mvtnuFe3?=
 =?us-ascii?Q?+pglFPElqrELXDC62Mb4xq6J6Kk9SKiOS3WlnBekzD73otlvhD9PoW9XK0Kl?=
 =?us-ascii?Q?FdSiROtrWfDfnkU1eMHKq74+SykXmCZQ3XzeqcY6Xjm302eoaQEE+rC76lsI?=
 =?us-ascii?Q?DQy9shpg+JHNnnZQyClmxVyS2W+H0xa/HZLW0kCY801BbJ2nWb1yWX/r5Cfp?=
 =?us-ascii?Q?Ugx1VzVQNA5HHSRf5rLi2NfF/1H1mXZ/LwefB/eJqBz+skxO4SNy/5PasU0y?=
 =?us-ascii?Q?C9hWb3rbQzWzeK1vgucbhphSF14k1oxCTpm1MwJ/hElbH4Xeqec3opzSz8nK?=
 =?us-ascii?Q?PdX+8CZ4uLf0vgJzuoMjlwUZgX0WEbPpp+0pZ8RUCf6zpglUVl9U0M8hu2tC?=
 =?us-ascii?Q?zKgEkVBqufR1bCF8vnvIf3ZmDTpMimND3JQO96BC1lxy6KfnGLgQdKxehESw?=
 =?us-ascii?Q?ZnZx4jVl9a00XSlzYAHolIKehWizflVYMi3u4cm6989BReP5jJgHL5BSNHDw?=
 =?us-ascii?Q?5mD/zZpp3bMxiqkaclg+VGTyhOlfrMd2tzprB4vgIo5Zw2uZO3JDsiRZzZSq?=
 =?us-ascii?Q?W22eHSJsdx7nx2Sn1Bkqw7mOTO2f6bp4X25kIKBwR0DeVFNcRfFzF+0chWrn?=
 =?us-ascii?Q?rs77/EDvSeSWGcsGaqgLLW/DaQn/Iw+jF6FHmGNsh3ibixDyjDWgihVxfbR8?=
 =?us-ascii?Q?oJxTZv/24Qu3+opOyjzqrjWMFZnonKBdSCeOcf+kpPBfLVXFliZHNBJ/Ty1b?=
 =?us-ascii?Q?TXdhnJc6o/MI6lhHJuZEztTZdTZlJ1QErOtM5aVubTH6l9/uAp4+mSh64VDj?=
 =?us-ascii?Q?dt93sbPm4FxP+lAqM8f1aXyrW0J5WyZliiciEBAHuyD1AECWQO9UwL0vF3pg?=
 =?us-ascii?Q?u9iJCU76Eq6zvyGXg0bM0VcD9gujcNE/YSra2boAP2VrszR2+k1B/6vvGa3D?=
 =?us-ascii?Q?3dbfYDJ5wluqmxo+K/26QkFl+RkUTbbyx9fQwPFoNDAbrxCDlxfN2I/o4RG0?=
 =?us-ascii?Q?pJrzuU60XZkD9O34Y2QlsPeNe3f9ljDg5PPQXzbuT9MJi2G0f/x/GJ1ujZV7?=
 =?us-ascii?Q?BqMO2g5C/57VYa7Y6EesqwMxU9SPewksfNiiN3SSUyoulZhDFzJPQ45r2EfN?=
 =?us-ascii?Q?e9oHu4QKVBQuSlL9qE7an1fR+cvDsMDz7AsrG+wK4OB60JWGl/iwtFQRovm7?=
 =?us-ascii?Q?lGzKQAYE1n07rSPj56/FakL7Z8gOWYibmT9AAz95xsBnrlXByoj24opTvl3j?=
 =?us-ascii?Q?XAiyEVs0Z9SkRpd7xC0BgLdRvGWFPrGoKSxrDeWbnSTV7d5aY6Rl7KVOdBly?=
 =?us-ascii?Q?/E8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcbbd02-9dc9-4f8d-aa8a-08d981b76de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 13:05:07.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDYB7FhMbqCW2xmfyqzCdvPFObQCU2sV9f+u7oF8LE8pQfIryEv+gHeM/sIEXntLEDpc4p4bUxzTOysFU9zzlIq2py4Xkr/JznyuWPvYF1QX4yFapn1BQ1hnegJU0m6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5941
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
>=20
> Pointers should be printed with %p or %px rather than cast to (unsigned l=
ong
> long) and printed with %llx.
> Change %llx to %p to print the pointer.
>=20
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_tx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> index e74ddbe4658..15b0cb0f363 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> @@ -876,14 +876,14 @@ void hfi1_ipoib_tx_timeout(struct net_device
> *dev, unsigned int q)
>  	struct hfi1_ipoib_txq *txq =3D &priv->txqs[q];
>  	u64 completed =3D atomic64_read(&txq->complete_txreqs);
>=20
> -	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d
> no_desc %d ring_full %d\n",
> -		    (unsigned long long)txq, q,
> +	dd_dev_info(priv->dd, "timeout txq %p q %u stopped %u stops %d
> no_desc %d ring_full %d\n",
> +		    txq, q,
>  		    __netif_subqueue_stopped(dev, txq->q_idx),
>  		    atomic_read(&txq->stops),
>  		    atomic_read(&txq->no_desc),
>  		    atomic_read(&txq->ring_full));
> -	dd_dev_info(priv->dd, "sde %llx engine %u\n",
> -		    (unsigned long long)txq->sde,
> +	dd_dev_info(priv->dd, "sde %p engine %u\n",
> +		    txq->sde,
>  		    txq->sde ? txq->sde->this_idx : 0);
>  	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
>  	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
> --
> 2.33.0

This patch has the correct case, but is not noted as a V2.

Jason, this one is ok.

Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
