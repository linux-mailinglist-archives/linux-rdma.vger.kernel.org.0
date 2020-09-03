Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38EC25BB76
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICHOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 03:14:05 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33968 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgICHOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 03:14:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0837AQj3005298;
        Thu, 3 Sep 2020 00:13:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=BzaYhcrym24rjXj3MQu5BOqmBdVNuOabiy7gpGU4hjA=;
 b=SZxiDnNTPW4hX8ocJAPrd9TXYVFI/6G9sT/+uulsoHs6L4AwKGX7pB0jCc9+nyTddBu4
 ulUke8vpjlHinMkgp8RYNqHRSuFLNpqd4LKIGfnqO/f+K4XYmYvLz/tJEWVRJwNBxNjz
 hHiqsEoS2Au5VgBXReFunXL6IH6qNhf6VZzdzxLiZgzc/H9QBzaGY+hmi9HXvqKAsEKR
 t5hSO/AzmhwV9rSJkQJK/tTwrKpF3PdmHluSQMKn4f6OBbjUP4aj0fuAIEwOq7Tq00TL
 K5jlCZM6yaNCrw+YEPyAYzeYcu+QFpsbQlCKh/SJxok7cPQi4auIgz/zo1ZOaU7koVm+ hw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 337mcqk0da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 00:13:57 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Sep
 2020 00:13:56 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Sep
 2020 00:13:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 3 Sep 2020 00:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDRSzGS3ISgr9PFm026f94nDeYLkPEuyNjihCeAu6i2kNFCObOrRitwYvyAZowo6D54iIgbctmrZqHbEmsMEWN0ZsanhqKb3GjikFJGnlGe5JcOgEPQ6nlQfagmfC8aUGpfORI2iAA+pyEtxB1OjX7D9AKBDoxTgc41f8S8fRAE+f6UF4OC05cpdJx3mZgn21JxH5ue+dByJ/J7PkYNCzFHrYvOohCCu2pAVM2JDXlciY0bPsFlM0JtbWzTmYCP+OH9NgzrokEO6RHOaDTSVpJjLM/9yHP3D7mMbm3Zp/BZH0dses0IKnrDONa2Wr20UZDaB0ap6J+K2j5RPbnur1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzaYhcrym24rjXj3MQu5BOqmBdVNuOabiy7gpGU4hjA=;
 b=d1LnPFwcNT8z9qZkG0pgfWDmsKEL9ivPEYC3Mgz8FwJhO3ILjva/19ArcromnMDiaJtv1F02xhG2kjbo2E0liNffMy10PSWgmRln62PdaqqkaD9IFtG0lqVGxWDO2kXlZKatLr5EAstwF1uQtZHtc3ndxR/twZ/hpVn9u+W0iPGR30BzFZzV76WcM+jK/E4K03rrLH0L9WZXX9vZ861SHaDSp1KTW8GshEKroz933ou5svbEGVMYsnwYLBM1QKLf904Q2R2wAacaf2aq017fiMtAdIppHQO+i9AZF5HtEE2RIvcFc9J03A6VtgB7xB/lsk5romOsmrLMvFYZVGAFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzaYhcrym24rjXj3MQu5BOqmBdVNuOabiy7gpGU4hjA=;
 b=N6CdJ5+YHZw2/aB4V5R30wzZeWAjTvcHEwmVA61Ppr6ORwPh1ZwpFSdIcf/M4tHO66GRca9Cx5MqPFEu6XQv5MZn2AWmk0nYGMXVMmXI3wzb7OkjNqFZwbjVTuwGrSc9ECTCIOFWcXTWOKklePin+u/rzwKuMRYyZUQGnwhHcTU=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB3296.namprd18.prod.outlook.com (2603:10b6:208:167::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 07:13:54 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c%5]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 07:13:54 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Yuval Basson <ybason@marvell.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH rdma-next] qedr: Add support for user mode
 XRC-SRQ's
Thread-Topic: [EXT] Re: [PATCH rdma-next] qedr: Add support for user mode
 XRC-SRQ's
Thread-Index: AQHWYBqJ8vvLDcEyk0qRuqUUKdi366kbzQ2AgDr2IDA=
Date:   Thu, 3 Sep 2020 07:13:54 +0000
Message-ID: <MN2PR18MB31826DD9DA73E328E80F3D19A12C0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200722102339.30104-1-ybason@marvell.com>
 <20200727184917.GA69703@nvidia.com>
In-Reply-To: <20200727184917.GA69703@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.57.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f69ebc-92e0-4f2e-3a5d-08d84fd8eaf0
x-ms-traffictypediagnostic: MN2PR18MB3296:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3296A18712E6B8FE1374C437A12C0@MN2PR18MB3296.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ea2WnyC7FJ0sC2YCjGOm2BV58b6uNwwTNX0dhZCGUAw40GjJJ060kx+At0AppehDJdMpFWibBdpYzu2+zciNTwf/ynenfzXOoHZKBBJf38pCbdo/oYEFZ8NniMmGtOPVfQKMGOQ+3RV+XWLmIPMK0+BrRV+8KlkEwjLdBhpMR+DnbVUuFQ36MIOmr9SrMYYs2bFJsfB8QuLvxC76CDlJZfhS6e1Dr1Evw54VDD8FnDn0Tcs81hEU3sxLtdvg7N0QsoRrRPElTOgb/nqYM5dsDkMmVGMLVUq9r8Ge1GCeeoNG/2bGSQCvJ1IP8T3Qzv0GKbis0VCeSJpbRg3120xj1lYLPswjJ1OpFmV/l+cIbZkEkXa6/8T0FZV2CLpEB7LpQGuA5IUXDeihIuHUXYTvBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(7696005)(66446008)(76116006)(66476007)(86362001)(478600001)(66946007)(4326008)(4744005)(2906002)(64756008)(66556008)(5660300002)(71200400001)(33656002)(52536014)(26005)(186003)(110136005)(9686003)(6636002)(8936002)(54906003)(8676002)(966005)(316002)(55016002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vN+UgVBVp3/ePgZz0PBi0bZ9H92M493Ep0xYnf9uI/llMOa0UjQTzUt19gLEX5M4H0+FnGWfESWQUy+HkNGFKWgiuX81dN6z6Tr+JF4c2bfAI2thR3RInIwpLy/r7rHa9B9E42Q0vN4hSpIpuuM0j4VLetc0g7kGQtQ7Tsa7kz60rT8Ie4dBOXL0gnQuuVeWXl2mjDjILawNAKDbrLuHfWPF1gM2byZLMTh6PxIHOzhcAVhxcFeGSqCChaTGSiizhnm92ItHolu8BX0DvBvWVxxHFiadmxhhw2XvfN0qk90XpiSOvExZT8Uo8f8VWMHMJhy8zu/RPtaPxTbsZNJ5WEmtm+hc+65wpYNCZiNfYbF8FCqVEsfHRcEug7GhZbgeZTzMdu1wOOwLGeYYWogoHg/2IbzlcyiYDeoW2BQ5MY6dOUTq3e4WcU3d2A5M6MwLEObD5Vn0DyLkZ9hHy+kL3dIzrPgrA5aCgAn6eZhaZCUTHn452qpQ8t5J0fAO9/29wHrV0fCncoWcOxx/42BbFyKF3kmoH8xcOWH7uD1gVN++6erB7d9AopW8y1vPmRQj1DCyI4LYke58/hgle8cUdv//GxNPBN6xEr96TIu2ZMUvkkyubABZl+JmUZ3B8Ip7nJcUxVzYZG3Sz4NdTxFRZQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f69ebc-92e0-4f2e-3a5d-08d84fd8eaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 07:13:54.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3VfvJ+LgAoq4KhpEb7v3dRF5MqBU/XZiuSjC+ih82OdRtai8ZRO8zAN1DFO3DM3ZcYMK3fXiSpesbfP61K/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3296
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_03:2020-09-02,2020-09-03 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, July 27, 2020 9:49 PM
> On Wed, Jul 22, 2020 at 01:23:39PM +0300, Yuval Basson wrote:
> > Implement the XRC specific verbs.
> > The additional QP type introduced new logic to the rest of the verbs
> > that now require distinguishing whether a QP has an "RQ" or an "SQ" or
> both.
> >
> > Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> > Signed-off-by: Yuval Basson <ybason@marvell.com>
> > ---
> >  drivers/infiniband/hw/qedr/main.c  |  19 +++
> > drivers/infiniband/hw/qedr/qedr.h  |  33 +++++
> > drivers/infiniband/hw/qedr/verbs.c | 291
> +++++++++++++++++++++++++------------
> >  drivers/infiniband/hw/qedr/verbs.h |   4 +-
> >  4 files changed, 255 insertions(+), 92 deletions(-)
>=20
> Where is the rdma-core part of this?
Sorry for the delay on this one, it slipped.
Related pull request: https://github.com/linux-rdma/rdma-core/pull/821

Thanks,
Michal

>=20
> Jason
