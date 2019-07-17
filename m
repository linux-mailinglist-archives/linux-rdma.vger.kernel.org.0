Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626566B658
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 08:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfGQGLi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 02:11:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27552 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbfGQGLi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jul 2019 02:11:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6H6AiFh021799;
        Tue, 16 Jul 2019 23:11:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ulf4R1+itXisgUUhZrblhOXZf38lotcQ0cako8hfkns=;
 b=zKWTsB5xGjmREJMz9ZPOLJJCBD134+aSmdlsLyb6y4SWuHzqZpIa+WqqTR/J9UojzO8+
 TK0cYftsl3z8ZTUA62ERoguInz475zHGPPEc/I/LRWA3GNps00BAIeAFV9ujCQ3JOIF9
 RW2+YVYwC81Wo6TtY2imprFbYZZ7u+kJ54yIiqSS4JB3kHe/Ulbl+JyEoCqurPD+Ah8h
 K/8rPuqO0Yo8+nbdm9NySnG6IUFcJzIuKiKGYQZwXWLrJwtR2GVQJ1+BSwYJP4yE5Ov5
 Zz2DgAijf/6tfa8I9MbQwktAVMJz8BYYaB+n07qE3iBNqgXtQ9oCblDI2DjLpApJYgcQ uQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ts07vexd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 23:11:34 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 16 Jul
 2019 23:11:32 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 16 Jul 2019 23:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYXNP0+b3pTsxO0owo5Mtrdz7O5eHWuW0E6hrVk6ddcEk5WShSzFobHgpDoH4c7rqpDh4Vl/xkppWhqQVqTC2Y/cp74JidfktGAYi/aT9GLukRxu2FmdLbJUgIAT1g4A7enOZvU3n3ZSwvHNO21kSH73e9B6ydsyEdSDG9krwaPLv9e2Jcyw7HVpmDN51FsM6Cq4KqQkZpitkxivMOfPnrzT45ZuUJEOq4k/4gLeY4dHbZaUoKHzDksOfywAxJp2xD2jie7OPvuoPkEZjlOW+sUwxXkBxMtCjIpXfo26Omn4xidYeYx+RJ9A/x9bs0sTFlm/dTK8CMruZGVUmkkUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulf4R1+itXisgUUhZrblhOXZf38lotcQ0cako8hfkns=;
 b=NP/3W2V88ISvhs3nzYPox06dlYbXEO+5vkNOjysKzB+LbocgfbTv5AH1YAzPRmObL2V5rg8mjxcxhxS7vo6vs3srl0/nLmQnD04tQyEtRzLkg+7I0wgeoYqSU0LEvjthrVATJij/CvMSISRkC9aiSqKSaYUW1GKUv18o6eBYnrmRtseds0F/s0CKxqUK+obPhc+0T1Mv6htSE51EgS0jqCXomkld8BhV1TBhtM4fyL96T0QJEBwR37HzMfa5ZZXBx1ujp7pQcfe3COlpB06as1wE0fq1sGo1IM5X2ZO4p9An1GdQZcrEzQZ0IPE9c8+fCpRyr5UWJkw/ebXmastWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulf4R1+itXisgUUhZrblhOXZf38lotcQ0cako8hfkns=;
 b=oKsBEW53MMflahXaYoMNOIkMuDt2C+N6m+o12n0UzuQDJ7f/Wv/Yky8NL3Yiy0PPVnuD0xE5vMkRKzjabY250JgL++thObXUWQE6cFtx5RnVY5faqg3hXWMGH+HN0OdUkr5/Gk6X360GO/8tJ8Okv14dg1d1xVulNshoilpxqO0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2541.namprd18.prod.outlook.com (20.179.83.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 06:11:31 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 06:11:31 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband: hw: qedr: Remove Unneeded variable rc
Thread-Topic: [PATCH] infiniband: hw: qedr: Remove Unneeded variable rc
Thread-Index: AQHVO/0mS0hjrp/mNUiJzem/6b/FsabOVNtA
Date:   Wed, 17 Jul 2019 06:11:31 +0000
Message-ID: <MN2PR18MB31825F87E4440ED62AB05418A1C90@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190716173712.GA12949@hari-Inspiron-1545>
In-Reply-To: <20190716173712.GA12949@hari-Inspiron-1545>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.183.34.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4f7a10f-371e-4de5-d503-08d70a7d9cf1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2541;
x-ms-traffictypediagnostic: MN2PR18MB2541:
x-microsoft-antispam-prvs: <MN2PR18MB25413880FE0CF459A7541A4BA1C90@MN2PR18MB2541.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:41;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(66066001)(99286004)(110136005)(74316002)(7736002)(2501003)(68736007)(305945005)(8936002)(316002)(11346002)(7696005)(102836004)(8676002)(186003)(446003)(256004)(26005)(66556008)(76116006)(52536014)(66446008)(14454004)(66476007)(81166006)(81156014)(53936002)(64756008)(66946007)(9686003)(2906002)(25786009)(6116002)(3846002)(486006)(2201001)(6436002)(478600001)(86362001)(55016002)(229853002)(476003)(5660300002)(76176011)(6506007)(71190400001)(71200400001)(33656002)(6246003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2541;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 09w3O7Mt8zm2vDXEwo37tlN6gO3fnhbOZm0YqouI1BchIfHWS2aUEqjyLIVT1NGj1aoOsrX/+O4Sl6XR/0FQs+jgsaqm4gQQr6YXLvIRj2H4zDUwcaRibhfISqKas2JFNptzJ1sb+xeLaV52oeaolrqaUslR4K3llI77cmC7XR7UfXSTL1Fdbd8jBJVJ2THmWrhSfd1WL37+44T6bZFzEXrFzetM3xY7hanXMYDA/zYZIv7+IBkkMnX335k2BtcDgcGAaaR45N65oKjA3BkVyNY+ABAkA0UOdRykfBnnK94G0AabUwHiWe5iZHjZL3H4+rnw0sLDmohz0MzC729ek8c3hyDCpZ6oVN+1Z5FVQV4fve/v4utVWZY3TlIvohxkjJxAH7XZjTR7W9LaF3gV3g7KZouiEqH4UNYJDSHG4Fg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f7a10f-371e-4de5-d503-08d70a7d9cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 06:11:31.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2541
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-17_02:2019-07-16,2019-07-17 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Hariprasad Kelam
>=20
> fix below issue reported by coccicheck
> drivers/infiniband/hw/qedr/verbs.c:2454:5-7: Unneeded variable: "rc".
> Return "0" on line 2499
>=20
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 27d90a84..0c6a4bc 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2451,7 +2451,6 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  	struct qedr_dev *dev =3D qp->dev;
>  	struct ib_qp_attr attr;
>  	int attr_mask =3D 0;
> -	int rc =3D 0;
>=20
>  	DP_DEBUG(dev, QEDR_MSG_QP, "destroy qp: destroying %p, qp
> type=3D%d\n",
>  		 qp, qp->qp_type);
> @@ -2496,7 +2495,7 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  		xa_erase_irq(&dev->qps, qp->qp_id);
>  		kfree(qp);
>  	}
> -	return rc;
> +	return 0;
>  }
>=20
>  int qedr_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr, u32 fl=
ags,
> --
> 2.7.4

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


