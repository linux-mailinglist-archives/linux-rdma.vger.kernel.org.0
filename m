Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC417795C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 15:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgCCOm2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 09:42:28 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36516 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727576AbgCCOm2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 09:42:28 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023EKVAo013472;
        Tue, 3 Mar 2020 06:42:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hgMqVgxeQgZXhH5dHM2+tSw7Ia85yeTv+6xpACiI47w=;
 b=a7Tuw65wg6yO6ihkyJClho++cEpRUweWxxYq7DxePwIVBYl5uPJKhO7wlpgOW/okrgLG
 JUmWK5M2p0QdRCrowe5H4vroMIthuL3LbAnrpjKY+moY1hJJxzczJkVXGO0Xz+1Jq5xT
 bmw5PZk0xmq8uMS3Suk3+rDgq19Qjqd4mDy9kBlL/dKYHxNt9clqX0L6Mx1yk/Ptdh6B
 G9vX/nUxFWObWS535hZ6sozPwO728I6a1gjiW+5LkauXgIonX5Mzbv9WZE/QvrPiAhp9
 YQooZsthlpTFm0SiLaOqi/VHUWymStpWf3vW0wo6MtSR5RkRM94/FD0vplhRuZSxCit0 Pw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0xs68f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 06:42:20 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Mar
 2020 06:42:17 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Mar
 2020 06:42:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 3 Mar 2020 06:42:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQeuUJ2gqCqCUSqjyLRox+fRqOnFfittvI11FxISIKGsnR81BwyS36Itk2gHmCIMWBFrldjWWPwNpL/ZZybpfJ0nmB9V0tvHNNFvsgLMPZ4XR+DN90j2yLWESMeGCcutky/EjDG1TfjZL21KB2+7YWXNaro3aoiHVARJ+9phzWAP//QUspH5b5bjnYsk3yPyzaeiQFp2z5TSWouLefkD70jnRLkbz/m/cQ2IfSZr6d7ZO0N/jda5d+wCnVpsi5kgUmR63jyy11XjVcggUFHlf0+UOz/dn1j6s2vHuO8Qgh1c3ufVMSxKMHBWs+OiY+3ILy1u3aQPITJHHsDltrvgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgMqVgxeQgZXhH5dHM2+tSw7Ia85yeTv+6xpACiI47w=;
 b=DvyXI0tSMVbz+SZhboVLQOZJf7Fn3hDjuCoobLotBajuaHBxJ+WJh1HX9cq/OI0TxM46sSuX6tsjjj1y0BzkiU6alIcJulwmN+inDJtCbsuCvHqqHME4XLuXO7JUQft+IYhstXIXyGOJILZlcuqyckxRS7BrIeTeqF+6vsWbJm4tVyl517UzErnt9nBrir0LYn01YBa4fNKVq15XAhJlo7tKy5XZy/YnjrkGtmnAoDrfDbCRdxJBYCaYcQnrUCARV39wK/k7pXSEj2Gff2Fj1n+5mARE1TA1HfsmOkcpiprSdtyLfnKRd1wodgdy6nsgTxOjns0hx93RDSq4zixmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgMqVgxeQgZXhH5dHM2+tSw7Ia85yeTv+6xpACiI47w=;
 b=HUUvAFxJhIT2Q7bO4WgP21rVZj1K9Loqyhnrlo4Cpc4lDP4O8VffFoQ7JyEV7Yz4SivkC5wFUhxKaRth0FDv1zUgo5ayqfPXL57uF458a5/vdW8f6y/igKGDvqnTUjjH5Y9pcc9H2emXvSSonPZ6TgkySpPydHgp6jYDqW97cnk=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB2927.namprd18.prod.outlook.com (2603:10b6:208:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 14:42:15 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ed5e:f764:4726:6599]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ed5e:f764:4726:6599%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:42:15 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: RE: [EXT] Re: rdma-core new/old compatability
Thread-Topic: [EXT] Re: rdma-core new/old compatability
Thread-Index: AdXtbVWfLJHDmaJ9RpWO761kWPyf5wACDwqAAPyjk3A=
Date:   Tue, 3 Mar 2020 14:42:15 +0000
Message-ID: <MN2PR18MB318285FCB1291FAEF1C406B6A1E40@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <MN2PR18MB3182F6910B11467374900AD9A1EB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20200227135529.GH26318@mellanox.com>
In-Reply-To: <20200227135529.GH26318@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1ef2ca3-8b81-4b81-8aeb-08d7bf8110df
x-ms-traffictypediagnostic: MN2PR18MB2927:
x-microsoft-antispam-prvs: <MN2PR18MB2927A1CC46E54002DBB5407CA1E40@MN2PR18MB2927.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(9686003)(55016002)(478600001)(76116006)(7696005)(186003)(8676002)(81156014)(8936002)(66946007)(6916009)(81166006)(86362001)(6506007)(66476007)(66556008)(64756008)(66446008)(54906003)(2906002)(316002)(19627235002)(71200400001)(4326008)(52536014)(5660300002)(33656002)(966005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2927;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPy7UfZSUkqeDSPCKq39LfbNjSfLUqXRBVJTH+JvtHRG2F9GBa7rqz3SuvNiGUPoq6Yodg9GhR7oPMnS02FIjuXdD3U/nTfZ42jz3IDKBL+4EUi1wN+lUpoQp1T6IecKOMJw3VHH1VBpAXMubSFtEt9PLTRs6g6m+ORim6J0znj+Slh25rQX94a91KBennQBBOhsD89V85ioMFRhi5lD7v0uDUpuFV3SWRTfOkV/vPqYt6p3C+WD7SJwF/LJn4xvbz8e1/WigRRbwxQ2hcrKFXUqpY+XxDQKfgchO4VZ5j1ckAcJiy9XK3xUt/63n5Je40pyG0nS8MTz6oG4YqpjPH1QtOY9wcWqUZzj4y/Qe5R9l8tNKSD5sE3EOggNb/ZXhHsZAoPzRQmpW3Wfcaeex+LWIFkxDSPc3YylU8VkcEO7wONHEL9IYvQrD7d7nAcTOCBSYY8lexNaNVxxo40cVMiE7n/veMRJqqcDZwXUQdnyOz8zTr/VRobgnaZ4MvP3SFO+IYoYoeZuO3n0UiaCPw==
x-ms-exchange-antispam-messagedata: PufeT7PGB8vBdCoTJHajjSMZlLNXQSkY93V1BfrasoNRakwv746yyCL4nyMLV3xMlzGnLhh1Yyzy2SqY2o3oulEIj5uD7bFVXNWlrRoZgu2lRAAK34iA0Es/F2sfIRKGeyjepmXEB5Dq6WtVXOQOgw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ef2ca3-8b81-4b81-8aeb-08d7bf8110df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 14:42:15.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YylGodBtHxmIqVugZh4zONvwNo2gV31qCsuyR97RN6oHcbyQCQCXVAwGyehTm5DWiagfK+mEabMQp10C75y+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2927
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Thursday, February 27, 2020 3:55 PM
>=20
> ----------------------------------------------------------------------
> On Thu, Feb 27, 2020 at 01:11:13PM +0000, Michal Kalderon wrote:
> > Hi Kamal, Jason,
> >
> > Running a version of ibv_devinfo compiled against an old rdma-core
> > (ibv_devinfo from libibverbs-utils-16.2-3-fc28.x86_64 ) failed to run w=
ith
> rdma-core release 28.0 for qedr.
> >
> > The patch that caused this is commit c2841076
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_linux-
> > 2Drdma_rdma-
> 2Dcore_commit_c28410765bdfe5cbed3cb2cdb1584eac3941469c-23d
> > iff-
> 2D8da8bc8b2790169de557d5dee83a278e&d=3DDwIBAg&c=3DnKjWec2b6R0mOyP
> az7xt
> > fQ&r=3D5_8rRZTDuAS-6X-cGRU9Fo4yjCnkS1t7T3-
> gjL4FQng&m=3D8roKblaWiyWNhzEkhi8
> > gJYJs1ZHqJ0lqf_0OMh3fHBM&s=3Dx5-
> fhg21NUEcxJ2zxM135ujpopHtey138zz9waiflS8
> > &e=3D
> > c28410765bdf
> >
> > libibverbs: Fix incorrect return code ...
> >
> > The proper return code is EOPNOTSUPP when an operation is not
> supported.
> >
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >
> > The reason it failed is because qedr doesn't have a query_device_ex
> > callback, so vctx->query_device_ex returns EOPNOTSUPP, and old
> > libibverbs Compares the return code to ENOSYS
>=20
> This is surprising and unfortunate
>=20
> > I think applications compiled against old rdma-core should continue to
> > run on new ones as well.  Can this commit be reverted?
>=20
> I would prefer to only revert the little bit that might be needed for
> compatability.
>=20
> Perhaps we should change the dummy function to implement
> query_device_ex for all providers? Zeroing the extended data should be
> sufficient I think.
I've submitted pull-request #713 that implements the dummy function.

Thanks,
Michal

>=20
> Unfortunately we are changing return codes inadvertantly quite often, and
> the providers tend to use different codes.
>=20
> Jason
