Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C22217607
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGGSLS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 14:11:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6828 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728029AbgGGSLS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 14:11:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067IADWi002756;
        Tue, 7 Jul 2020 11:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=frrOR/I0n+jjvNYGel2uRhcTaC/7GqLFoy6LyVbVAVI=;
 b=XVh5+hlZkWuxEiwhe43RxDp2F41Flw22BmwMWPprB1pjOeEmJF9mcTz7eH/F0TKITVPF
 pb3Acbpk0YrpsIZbe2Rvkyz6SNJcDhqy7ruwqZDNYKxPjlpbGFLzM4gv5css9VovwMbo
 S0SZOBBPu74ADOMwR9hU9A5mrHfpkSBuXhzUbzYYGg9kHdEmEO1lo8VjR2QwvuiSuQEL
 XSeIDqg5QaxNXx07NFhLn8SYwtmpteNaK30USg9kFD2Qmpc8nmakbG+X6ootDWWMhxbv
 I8HAJX78j8afW6VcTmmCktQbi2yPpav8b/8dC1j10e8o2gY6d2FQ1Rxbe5zpFTlP4kcC pA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 322q4pw2mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 11:11:15 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Jul
 2020 11:11:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 7 Jul 2020 11:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3uTRvUUfXJ9FGG48l9AgfS+GhcW/MJ57KaSvobFMj7LDZlqYJKL7XFGFDouiXPrIgJdnQa77vjlTIBxSHZxp8Qh5GjWecLEnEtPrO3WTHQ8ue1FesVdTSuGO5XrARPnDxAhVJzuYiAeoeZll7i0hicPZYiKTDZlz1iEv2sjmxz4CKsYE3WICD4WBEeAhWTdn8MHWB1YCYTckDoVlMwVFhU1ZVqvxTgMC1pLiOol8xm3CpSQ16ujnoyON6nIPsw3kvV/4lefp/3cu4b7wGMSHl/GGQK+bqMoceJBwr910g0zHJizEohfuMCc6ZnS8M8+9xwQJNAauMKkbTQdHrGMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frrOR/I0n+jjvNYGel2uRhcTaC/7GqLFoy6LyVbVAVI=;
 b=GZEL1bvDGHmbbMy/9Ho81NxIIYCharyr29MGQ8IWVgCOPfPcWt7FLOLJZEjglWtczlNehv2QHuGRYzK9FbO22sRz/G8JougrauvcZNXjIqlhvbxGJZLtOxPX6PH1wlm3AR6Kp7aHyp4elUYl4zSRkqild46z2EUmgy/63NNCTQ+PHmQ6T8+5Pa4Xn5w7d1sqJYCqGh4MI/CUnWdKO6zqHZf2+47NxfKh1lwIRQ0owwpPhYm6yWberz326gpe+dm8tcIQNLzgY/6VGGzm0/PtXhmm9Egs4DoDYtEWPnR09WPWYZGTaA38jTFE4KEnZWqDtTEc35Tedm2Zjp+XWIvOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frrOR/I0n+jjvNYGel2uRhcTaC/7GqLFoy6LyVbVAVI=;
 b=XiudYA+UwqkMFy2kjbAy1YpJQxsPdHaMx9jBSnBkxHxgiCUVsuaA2hpMhHsh+SfTK5Yu8rrQHmV3Iph64HJr67u4yaQluBVkeewYMyociqAa0d4SAOdtyIoIfp6nWUCk95JT9UhmIHkiE+9pzM3Oy3co4hCZM8le3K6RJo/OsKQ=
Received: from DM5PR18MB1387.namprd18.prod.outlook.com (2603:10b6:3:b3::23) by
 DM6PR18MB2842.namprd18.prod.outlook.com (2603:10b6:5:162::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Tue, 7 Jul 2020 18:11:12 +0000
Received: from DM5PR18MB1387.namprd18.prod.outlook.com
 ([fe80::7d05:d5bf:f5c3:f5e3]) by DM5PR18MB1387.namprd18.prod.outlook.com
 ([fe80::7d05:d5bf:f5c3:f5e3%2]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 18:11:11 +0000
From:   Yuval Basson <ybason@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: RE: [EXT] Re: [PATCH rdma-next] RDMA/qedr: SRQ's bug fixes
Thread-Topic: [EXT] Re: [PATCH rdma-next] RDMA/qedr: SRQ's bug fixes
Thread-Index: AQHWU47mjdLk5jBFL0WtNstIJWMwg6j6yuYAgAGhElA=
Date:   Tue, 7 Jul 2020 18:11:11 +0000
Message-ID: <DM5PR18MB138769F410AB44FCB15596BBD0660@DM5PR18MB1387.namprd18.prod.outlook.com>
References: <20200706111352.21667-1-ybason@marvell.com>
 <20200706171512.GV25301@ziepe.ca>
In-Reply-To: <20200706171512.GV25301@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [31.210.177.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48e8ff9a-1b0f-4ce7-e859-08d822a1216f
x-ms-traffictypediagnostic: DM6PR18MB2842:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB2842473909327D6209FFC519D0660@DM6PR18MB2842.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ckzami45SGcl4oy7pQNP9GO5XWW+gJIrKoaP7b/S20vPKn2R5KyIR6QAml0tUJMoDkrL6qZmK8hO/JKDju9XMQwXXmNlQlYI99fUPK6kMMofPr3sDSgjmsBVue+kAbEpcxFwdbOFwUcMaqFc1Fb+JfkusagUUmdzNu9xLXNhvcRWDFmtNGJO/NS3ScHf6NrRttSsvA3bHh/oizm42wxUr+943sYwoN6vCJKLbtRRRTFZYMhE+bWF5+xcaRs3ntWhNBBoXLy+WRHCYQGvgA7RAHeUx7Xkq1HfM7vtdX3242MOMGCCPpFkGta6urSxhVdWC4ciXwkd7nFnqy9Vgs2f/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1387.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(7696005)(71200400001)(76116006)(64756008)(186003)(5660300002)(316002)(2906002)(66946007)(66446008)(66556008)(52536014)(66476007)(54906003)(83380400001)(8936002)(6916009)(8676002)(6506007)(86362001)(26005)(33656002)(478600001)(9686003)(55016002)(4326008)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yA3tS7P8hEPzJqOGzPpx0/kaja9YJiGw3Au0oZr7CVBI5iiU/TTtCiFF5pOzbfWNReJcQ1B0QqztN4HTDEwPHarNL3gHOuaDSXRuyD6tXMBDd1dYJjhGUWRitYHQZxV2++9sWLPjLnP9R01Z6MlSOZjm0oM+B45OzEpinhq3/2C4ypvRuMAjLx/XM6Zu5+lf+X/Kx3UOHXFuo+pIk3QiyeBs0mqniWvxT/S5ctfRmYEAAp9QJsH3r2XK9lDRa2mpN0VcUeMCqpZgI2Wwb+243TPwxK+i27LBEWvKiIcFtS5H9xU3MZ62gf/20k0vwMfCYqrF6VqUDULYOtAV5Mj3z7tpLF7Ob6fMncyRc2Y72BJy9A/nv1IAScbDWtd9TEZp7dFn0LX+DKCYR+sGWWNW2+43EDdXkKeUNhunvct+yrtp1nWOmAlQDDc2uSc0bozQOqQTWEydpN5rrtv5VG/NZYOgEHyCYjLQqP/ofTL3rVbNY//qKu9MmnjO4RB/2nzB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1387.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e8ff9a-1b0f-4ce7-e859-08d822a1216f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 18:11:11.8126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQivcNDb3FZPKi9xqRzsrp0XJYaynkHqwpdp0sBm5PLUHtB7uk3+j7lbY0+EQxvAXVGUBsjeoAcl2x5tUBuSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2842
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_10:2020-07-07,2020-07-07 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Mon, Jul 06, 2020 at 02:13:52PM +0300, Yuval Basson wrote:
> > QP's with the same SRQ, working on different CQs and running in
> > parallel on different CPUs could lead to a race when maintaining the
> > SRQ consumer count, and leads to FW running out of SRQs. Update the
> consumer atomically.
> > Make sure the wqe_prod is updated after the sge_prod due to FW
> > requirements.
> >
> > Fixes: 3491c9e799fb9 ("RDMA/qedr: Add support for kernel mode SRQ's")
> > Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> > Signed-off-by: Yuval Basson <ybason@marvell.com>
> > drivers/infiniband/hw/qedr/qedr.h  |  4 ++--
> > drivers/infiniband/hw/qedr/verbs.c | 23 ++++++++++++-----------
> >  2 files changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/qedr.h
> > b/drivers/infiniband/hw/qedr/qedr.h
> > index fdf90ec..aa33202 100644
> > +++ b/drivers/infiniband/hw/qedr/qedr.h
> > @@ -344,10 +344,10 @@ struct qedr_srq_hwq_info {
> >  	u32 wqe_prod;
> >  	u32 sge_prod;
> >  	u32 wr_prod_cnt;
> > -	u32 wr_cons_cnt;
> > +	atomic_t wr_cons_cnt;
> >  	u32 num_elems;
> >
> > -	u32 *virt_prod_pair_addr;
> > +	struct rdma_srq_producers *virt_prod_pair_addr;
> >  	dma_addr_t phy_prod_pair_addr;
> >  };
> >
> > diff --git a/drivers/infiniband/hw/qedr/verbs.c
> > b/drivers/infiniband/hw/qedr/verbs.c
> > index 9b9e802..394adbd 100644
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -1510,6 +1510,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct
> ib_srq_init_attr *init_attr,
> >  	srq->dev =3D dev;
> >  	hw_srq =3D &srq->hw_srq;
> >  	spin_lock_init(&srq->lock);
> > +	atomic_set(&hw_srq->wr_cons_cnt, 0);
> >
> >  	hw_srq->max_wr =3D init_attr->attr.max_wr;
> >  	hw_srq->max_sges =3D init_attr->attr.max_sge; @@ -3686,7 +3687,7
> @@
> > static u32 qedr_srq_elem_left(struct qedr_srq_hwq_info *hw_srq)
> >  	 * count and consumer count and subtract it from max
> >  	 * work request supported so that we get elements left.
> >  	 */
> > -	used =3D hw_srq->wr_prod_cnt - hw_srq->wr_cons_cnt;
> > +	used =3D hw_srq->wr_prod_cnt - (u32)atomic_read(&hw_srq-
> >wr_cons_cnt);
> >
> >  	return hw_srq->max_wr - used;
> >  }
> > @@ -3701,7 +3702,6 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq,
> const struct ib_recv_wr *wr,
> >  	unsigned long flags;
> >  	int status =3D 0;
> >  	u32 num_sge;
> > -	u32 offset;
> >
> >  	spin_lock_irqsave(&srq->lock, flags);
> >
> > @@ -3714,7 +3714,8 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq,
> const struct ib_recv_wr *wr,
> >  		if (!qedr_srq_elem_left(hw_srq) ||
> >  		    wr->num_sge > srq->hw_srq.max_sges) {
> >  			DP_ERR(dev, "Can't post WR  (%d,%d) || (%d >
> %d)\n",
> > -			       hw_srq->wr_prod_cnt, hw_srq->wr_cons_cnt,
> > +			       hw_srq->wr_prod_cnt,
> > +			       atomic_read(&hw_srq->wr_cons_cnt),
> >  			       wr->num_sge, srq->hw_srq.max_sges);
> >  			status =3D -ENOMEM;
> >  			*bad_wr =3D wr;
> > @@ -3748,22 +3749,22 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq,
> const struct ib_recv_wr *wr,
> >  			hw_srq->sge_prod++;
> >  		}
> >
> > -		/* Flush WQE and SGE information before
> > +		/* Update WQE and SGE information before
> >  		 * updating producer.
> >  		 */
> > -		wmb();
> > +		dma_wmb();
> >
> >  		/* SRQ producer is 8 bytes. Need to update SGE producer
> index
> >  		 * in first 4 bytes and need to update WQE producer in
> >  		 * next 4 bytes.
> >  		 */
> > -		*srq->hw_srq.virt_prod_pair_addr =3D hw_srq->sge_prod;
> > -		offset =3D offsetof(struct rdma_srq_producers, wqe_prod);
> > -		*((u8 *)srq->hw_srq.virt_prod_pair_addr + offset) =3D
> > -			hw_srq->wqe_prod;
> > +		srq->hw_srq.virt_prod_pair_addr->sge_prod =3D hw_srq-
> >sge_prod;
> > +		/* Make sure sge producer is updated first */
> > +		barrier();
> > +		srq->hw_srq.virt_prod_pair_addr->wqe_prod =3D hw_srq-
> >wqe_prod;
>=20
> That is not what barrier does
>=20
> This is DMA coherent memory and you need to ensure that a DMA observes
> sge_prod before wqe_prod? That is the very definition of dma_wmb()
Yes. I though barrier() will suffice (on x86 for instance). I'll fix in V2.
>=20
> >  		/* Flush producer after updating it. */
> > -		wmb();
> > +		dma_wmb();
> >  		wr =3D wr->next;
>=20
> Why are there more dma_wmb()s? What dma'able memory is this
> protecting?
Redundant. Ill remove in V2.
>=20
> Jason
