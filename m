Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7D3DB3C9
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhG3Gqo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 02:46:44 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:25292 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237576AbhG3Gqo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 02:46:44 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U6f160030272;
        Thu, 29 Jul 2021 23:46:30 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-0016f401.pphosted.com with ESMTP id 3a456ts840-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 23:46:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkm5z0Z4qBr+VRvcMvRdjzbvSr+0AeBj/MxzI1NHZ78a8SgQOmm9BVK2qXNA8iiFCyr+BzW2DNsjpowEXHKnYn9epuchmC3j0t95LNeP+C7aSyGV2gdYfbUKeZy+Bu1pMADuavmJO+7UW4LoaeuNQgxxLt07obASJph/12XFyaNt6S8KvgRyiS9ilBR8ei+MAQ30K19mIpRENWSX+LKFaEr8lkM6yT/jWInSRq67M50f2ZGRhSm8KMtOhQCanFwbGhJQCbYVWFsD5QDRm0m5eVfrAOHKEZa+EdDQUW9mElaMSzCatwzUtx893lckYOcj24SSwOIRxW+U13eMXw31nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl3VHRGbm+jo/mTk73bWDxfYdA7wTZOfKwkjpY0VvDQ=;
 b=d3YuA11F2vZnnU6BreCn5pfuDij4u+wvV3hzdU6cKqbNtb9wupb+et7NL1XZHmhYe6im4FcDkg57V8WPYJrpaqnkNTghTljMz8FnGlKLoClFwU8GZe2/NX3CyW0M9QFWKSx/ahvoky9Ep8V6vsuWyeWiT2/5GDF1RtLdPDwYktVtyf5tgONiNq8g9v/p0qlureWIE1SQt4bKDajXx3k1TUBnnsZAAF9S5XueBVZtG2qS20Nuk0u2qBGvuLE/IeUrOr9u0sQPFaTvW2i048LVDn4lSwnwG6hUIuBOvzvIlGOLhmUaxJGp4H5UJHkKAYswBL6sCmGqSUZATzLfH9FEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl3VHRGbm+jo/mTk73bWDxfYdA7wTZOfKwkjpY0VvDQ=;
 b=tns172h275o7qVtu9GEuH9mUT92MJr4DzwFZ+C+TaPkFZqoSbTVLO3/pI5vW/aYLeJxK+dG9Vn9pvzE2fPkDiYD/knqOLLeugeednuRviUWgCQf/oNMxo24/4BoHexDnBQqAGKz43f432NuiQbNtte3JrS5HCVNFkk586Wtx5f8=
Received: from SJ0PR18MB3882.namprd18.prod.outlook.com (2603:10b6:a03:2c8::13)
 by BYAPR18MB2504.namprd18.prod.outlook.com (2603:10b6:a03:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 06:46:28 +0000
Received: from SJ0PR18MB3882.namprd18.prod.outlook.com
 ([fe80::6513:d2ca:d44a:537c]) by SJ0PR18MB3882.namprd18.prod.outlook.com
 ([fe80::6513:d2ca:d44a:537c%9]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 06:46:28 +0000
From:   Shai Malin <smalin@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        "prabhakar.pkin@gmail.com" <prabhakar.pkin@gmail.com>,
        "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH for-next 1/3] qed: add get and set support for dscp
 priority
Thread-Topic: [PATCH for-next 1/3] qed: add get and set support for dscp
 priority
Thread-Index: AdeFDb/8Fvh6z9QaQ+Wj83hjZpQZLA==
Date:   Fri, 30 Jul 2021 06:46:28 +0000
Message-ID: <SJ0PR18MB3882E35D7C0D4D69CE935C87CCEC9@SJ0PR18MB3882.namprd18.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5366ad63-73aa-49d0-e3d3-08d95325c207
x-ms-traffictypediagnostic: BYAPR18MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB250459148D490F1491EBBF31CCEC9@BYAPR18MB2504.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qcJecvz6MWgCWRu9GXBjAyK+RxMQiJg+FhaoeI77mhmel41jd+ER4NoEb1ig3CzFj7ehg8plGzTMtiwvaN+YdlFO1TSFW78z4wnpAoVPW1bcfm9uSAlL3ZBnKk0/WV+CEfmWcd4j+uLSmMekaYz91BBC9noa/eZ0zh+jVMXUejn6HrGxV9Qtt2DIfFupgs6Wk4lI1n8DnZRuZuGDsvtZUYOGOpZT2IB4q3GpgVDmaqdNQEcJwgHrsCk07M3HihGk8xc+WQwSwC96KchAOCSgsree7gECEzg/ABQpr6i8xLWSjaY0sB/RN1xoxZIfZ5VmoIJWIGJPFXSomORMmfdqN6phmB3HZ5t3kn4O8hHI5w9UCbu4l3lm9mfoLAaT4KWr+4XZeiSBOUzLw2SnN2EYtUiuMDyUwR8qvY6eA7xNwrAKISpUSmHT6bZTI+2/ybI5/SNdcHE+a9CupEQBL2XeiOkmph3/F8okp8ASrdpkq0XWyMU4o64IB/vpoL35tdDt/qe6izU9rWc3koinQJzbSZ1tr0CEMhOKz8zme6gr6I65J3RvKKVAY9YL3mxoTOYDXFlZiBVeZ0YcM2c+cz43WbQrSJTzAXN+aGs4SOZLV6LACCiRcfU5yGBstxOj8ujy4MTaK331KNtvS2QSz8+hMaWjZJXC+fYDuKhgpemQqBvwjh/aOUfcYgNwbRR8oRt8HruQoWtXhCG7eq8vQ/3VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3882.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(122000001)(38100700002)(66946007)(86362001)(26005)(66446008)(6506007)(64756008)(478600001)(66556008)(76116006)(7696005)(54906003)(66476007)(6916009)(316002)(33656002)(38070700005)(52536014)(8936002)(71200400001)(5660300002)(4326008)(2906002)(8676002)(186003)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6XugOBH6A7EM7YiVzjIU9svKFHECI6jdfw46C3Mt8sZ5GeMTQp4uug3uH/E?=
 =?us-ascii?Q?W4VfdXdPJ5EZvupxO+wB+RkjSPehO3qc+Pyk57/dAVu64srcF7NNNwJCPTLt?=
 =?us-ascii?Q?yc+Aw5xRfV5g2A3u40q9bEIIVOk8xWRjOj2cIg8wIdODXD1E0yNdEul+XGja?=
 =?us-ascii?Q?KqaWSfaID5p60GWFtqr/r1PJKEuWrNnahe/PbtWaNak+WtOfw4z0cYXdQnoy?=
 =?us-ascii?Q?gQZ2ofb0CMpSZnDf0boeLCN+XtFXtXDMecoBxjkoXa7p+c09K1jjd9Ag8WCq?=
 =?us-ascii?Q?PMc7ee8qQiq5YmOOtv+whBwT0Jm4kr+96yI17Yy0UPd38hZLoMOPmn6A9TEh?=
 =?us-ascii?Q?xVTkmB7G5Yk8BmlTj2AYzqB779zCmuxNYh1qVi4JldHY179hjYSRUAYcl6be?=
 =?us-ascii?Q?ev55jlapJYUKNwNJlVZssumAAIguVbaw440V7/1XlInFcplw78w6JRKVM0hE?=
 =?us-ascii?Q?0eeOuF9u9dCPa7BFGVWd9vqHcVr4QXxNZVLIzEqry/GE8SDnmKuGqzu/deEt?=
 =?us-ascii?Q?I38TjlQE/ANRFcYNQx2bOq5ID7xOY+VBo4likSPt+TcDK/nqx96tiwrR67Sf?=
 =?us-ascii?Q?lE/dmDO6gmaB6I2kAt4CFQJT09rMI5RJUkvMca8bUNUSfaedynbcvqs8oYXF?=
 =?us-ascii?Q?0ZiL6to1g882EDyuoQWdj1B9+6NWSqLffde2gNsn1GUEMZUc6ZM3fys3FNhl?=
 =?us-ascii?Q?j/3MKCQ+BlAvs0n1hGi7rhlbSedFe3TSXylwz3Xz03o8vmjF/bYoVupAP0yd?=
 =?us-ascii?Q?J8BwiurO0L7zX+ZEXZDxuTfoN8Tr6ldpaqJbJbK0W7S+0TFIgFi11tZay06f?=
 =?us-ascii?Q?5jty3qf5Ixwc6YK3DFH6osuxTjohSDK+s9CJbUR1qWsdf6p6iV8nYFPabqF6?=
 =?us-ascii?Q?q398GPzAEPobeoWcbeMFvdK7zvnX7dd2gaVSnf150MB0J42+sLzqYQ0XY661?=
 =?us-ascii?Q?Z+L5NdeQAjmQ3BrQZDCV1wQKAYPPmIQEtE2SRTXJMlJx/sTEDBvvfIyw5Hea?=
 =?us-ascii?Q?7JEj4TpIvRX6BqvO5j3R63bIzS5CNcPDL3z67ApgR5B1mZbNMIOUwSN40Dyo?=
 =?us-ascii?Q?gDZlzwQ0hfBqfNMQNqKC8a6/uEdiz+n64zvNErwHwjPWm6Y+2mxpyUSfP97t?=
 =?us-ascii?Q?T6vBieI6wvIRsPr85BRoFGFjW7gNqUoN62WrVaVC2PHK3B+6bvn1MK2dRBA8?=
 =?us-ascii?Q?qWpon/ueBfk+VwaI3qC1UgR3A+ECelxeoDcNw+g47kzVnnayaoLfdcs+rev0?=
 =?us-ascii?Q?fqi280UdgHdqPSRuvEH4O//WtCpKBFiNgEyhKuTBE8g6E/HK1X9gKqMaa/eq?=
 =?us-ascii?Q?waiJO72uW2ZUcbnhguI21Xo0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3882.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5366ad63-73aa-49d0-e3d3-08d95325c207
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 06:46:28.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUSIz6CqETUrQk5bVBEdwl5MEWBwJZK7/qwYRL7G25tKYG+BTO7sG/EBjsFTwL0ghQTamXgK2fs2Oo8V7ZctYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2504
X-Proofpoint-GUID: SSwZKlb7WHVJuX9Wjks95YH0JZlvZC3d
X-Proofpoint-ORIG-GUID: SSwZKlb7WHVJuX9Wjks95YH0JZlvZC3d
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_04:2021-07-29,2021-07-30 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 08:22:00PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 29, 2021 at 04:30:30PM +0300, Shai Malin wrote:
> > From: Prabhakar Kushwaha <pkushwaha@marvell.com>
> >
> > This patch add support of get or set priority value for a given
> > dscp index.
> >
> > Signed-off-by: Shai Malin <smalin@marvell.com>
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > ---
> >  drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 65
> ++++++++++++++++++++++
> >  drivers/net/ethernet/qlogic/qed/qed_dcbx.h |  9 +++
> >  include/linux/qed/qed_if.h                 |  6 ++
> >  3 files changed, 80 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> > index e81dd34a3cac..ba9276599e72 100644
> > --- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> > +++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> > @@ -1280,6 +1280,71 @@ int qed_dcbx_get_config_params(struct qed_hwfn
> *p_hwfn,
> >  	return 0;
> >  }
>=20
> <...>
>=20
> > +	p_dcbx_info =3D kmalloc(sizeof(*p_dcbx_info), GFP_KERNEL);
> > +	if (!p_dcbx_info)
> > +		return -ENOMEM;
> > +
> > +	memset(p_dcbx_info, 0, sizeof(*p_dcbx_info));
>=20
> This is open-coded kzalloc().

Thanks! will be fixed.

>=20
> Thanks
