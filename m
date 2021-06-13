Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43D3A59D7
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jun 2021 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhFMRYQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Jun 2021 13:24:16 -0400
Received: from mail-bn1nam07on2091.outbound.protection.outlook.com ([40.107.212.91]:50735
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231902AbhFMRYP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Jun 2021 13:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbEZRrP5isJITAJd/LcDdGdl5F+arZQ7ej1TH9tfykhSoPRES8uzFOr351jljSTYNkTHtCp74HGhzX6KIYN7aS42naJPYyaXjLyremQ33JEO4Dw6+JxRLjVXP8fFQyRraCyPTdncq9qvZdBjRhvsKLaHoyhNWAugzYXRG1h48tts/agOeUret7NI1mXOv81FqKhfmCmx308+sG3f+44yUXbfttt1dbI2tEgZmpg9itiUbcP54XuJxTKkLaPL+3M5hy1HYX84G+DPiJ/lOvOkAOBKJbbzuCOsyy3Gbu7VDXJpIpucLROrUn168Wvf1N0mnoWJ3nxBmBCdUQ5pJabRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slAGYeicS0LHhupXv4tVby7yKQQrWIyZUeYc8ksPOU8=;
 b=Rfp24H4WgLvOv2byfuHZ5C/4X1VXrCB8WbbhfkF6zYWyFyMZhhqPibIrRZn2WnjFym+5uJP+VVMtGKe4xiDx5QUImiK6GTYVvUw86mtxGV16vL7m33obgaBV0PTaunRztY57vOIVsrsexW2/JAd9j/YLUlv0DGKl0/8LOdBCTMCwg1MkTvRQgr29obz7LoB93S0+yCaPGp0rkOPz5Nf1VRhPJgj9ByMKwesDDlhgajzQzUK98wSKb6EvRmkT8kvDHwkaPwuq0nVSCMHf85baBqC5fd9mzrB6JRDswukZoSqPRg8n9C1kOrXJAhloZLR6Sy5KrCGG6LGcMbWgVnhtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slAGYeicS0LHhupXv4tVby7yKQQrWIyZUeYc8ksPOU8=;
 b=lJjCVH77F2Y6viCVGwSBzeoKYuCnHgyEpXhyvTpvE6F4XHSRyWPYO3nM/JDoKVM/CeaLl9qXc2DmQ0Pc5lawL8MsjUKojb72sLo2NC2fg0+5fdYmaoMPkBOrk+Vbho4M7OAlf6gCD88Yvb8yhezoRR+lIPvm8z1NtKmZcVrlXzKIPK4WPHylasDBGDJR7wLU3HBaYcjFesOInJY7+pcOMaf/U0892WTqnHVmfQIAtidckvkBeXunjF1A7U/2HY8S648FaLixi49rcf+ndBzwggw6zW5G6IPhSakdznVmfhjvBy3Nj2IID8yoqm4UwMK0osr/wm0KQrXs8pnAcpXyNw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Sun, 13 Jun 2021 17:22:11 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec%7]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 17:22:11 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: RE: [PATCH rdma-next v2 00/15] Reorganize sysfs file creation for
 struct ib_devices
Thread-Topic: [PATCH rdma-next v2 00/15] Reorganize sysfs file creation for
 struct ib_devices
Thread-Index: AQHXXtruz2O6BBpwCE2mTJm4jI2k06sPGHQAgAMa1FA=
Date:   Sun, 13 Jun 2021 17:22:10 +0000
Message-ID: <CH0PR01MB7153B2E8B70E84CB551FA951F2329@CH0PR01MB7153.prod.exchangelabs.com>
References: <cover.1623427137.git.leonro@nvidia.com>
 <20210611175620.GY1002214@nvidia.com>
In-Reply-To: <20210611175620.GY1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d82547d6-3add-4376-d3c4-08d92e8fc776
x-ms-traffictypediagnostic: CH0PR01MB7091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB70910AAAF7088C2DC0240114F2329@CH0PR01MB7091.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b8+XmwJLU6nRMi9njHQ+Ky/fGlTtgxgMMW77iHEUQueCaZDXmBDALTJxKRQvl6zrOv/6z41eFiVh2NhuiOcGilxE4XWrNP3MM0117ZlvBykREIt+7PA4njThfxrt+yVDZnqwx8ndWR3C8MBOLjloPNpOl8UdokFloh+TmhgoNpRBZI3gapgYA14N9j9zi8Y9DXM0kt0A0Kqi9Dd4HI4MKfEf79FSx9pGUPLu+QUmzcdv8FKxOoQvFCasf0Cqt+As8wcFaAZ9pXQps2WTRQjf8fJnlYln3AS8gMOzxVFlNX8B5IHQ3zafzE9WrfwDOyA+Cr9IS6+Vq/+6+QDj8xZuxrf9TNEck6wqoNJG4TOq5asyrQt33xn83lTcyUbCNCP3QJKObO/QFtFAiJTOGL4Jv2vNZagy7wvrlQ5OtHBB5CpIv23Vionsy0iC/+IICBVYeqUcY8cD2fC9DJZ4J0SydwWX2zeexA3ji6kpmOfTUM7WBPkwQB8glPCTxRrnDI1S+emvOUx+1e1hvfyJwb0fvYiWo4hZS094020oTz0X5sinEUKaW3BauVit/FnqWxX1zuIFyHBi4/6jujyYNCLHdwAugNeybXSBnBg4JuM49YM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39830400003)(136003)(346002)(366004)(5660300002)(558084003)(66946007)(9686003)(76116006)(55016002)(86362001)(66476007)(26005)(4326008)(52536014)(186003)(71200400001)(6506007)(8936002)(2906002)(66556008)(64756008)(38100700002)(122000001)(8676002)(7696005)(478600001)(316002)(110136005)(54906003)(6636002)(33656002)(66446008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AK0SKcQhhG6zg2JbcXQjYuvSsqgCk1jXv1AJgrJuvthokSayIYfeR3olf2AP?=
 =?us-ascii?Q?DFRWI2wQeJXd9oiIZjGgtVJ7cvSlKFLMwmusTpUkoGnVkmoNkwJ4QGbRcG7g?=
 =?us-ascii?Q?MokJarrylv+I2jNjbn5u/Y09b5LuhVIsTMWppSywggfTIhmfA6vZ2b23Thja?=
 =?us-ascii?Q?0pHsgaEcLZvVvzqF7ZJB0JmwQLlaDXZWZBiXw6N5q6WXuuF0cWTuYTPpvz5p?=
 =?us-ascii?Q?4FoAYTjNJiAeofudXlm8X7C7W3941R6YE++EFSKwiUJf2rqOwAUpMxCPuJfp?=
 =?us-ascii?Q?mR1EAcXR/MMre3OnSm6J11SQcJC8+M5eeYdt+5nG4AVZ0jZY1mTCoW+fcDx9?=
 =?us-ascii?Q?VI23YvmtKCJtjrNyXyVrLr02bISvv0ucrKkgdL/iDtx8SDcng7yuZw23No5z?=
 =?us-ascii?Q?+kQ8muELZk5toa1tQSxc2WSI4DAbKuqNArMpQUku0pDltsWlUhn16im1RX26?=
 =?us-ascii?Q?rFWEM/mUxHX19bbJentJHVvyw1Q5VJc9Ud6acQDSDhHzzvcO2D5iTCvKgtKC?=
 =?us-ascii?Q?KOwPXkJsgK4fTCuI6mXQb7GlqXWfHGXXTrB7FkqNFTiJSw5ST/I3OEZgVjKm?=
 =?us-ascii?Q?0B0Uf+xcwkcD9iLKyhhazax2mtdbnOpNzQ+nmEFDnaY3DrBoF83CSRExmQY6?=
 =?us-ascii?Q?Xu6RR8V6JRwiYLjfNHYXUFaxFy3r3Iym2ZfbWSig3y/oMVFanzPzxBhV8t1B?=
 =?us-ascii?Q?+qQlgve1UhSQsf1++18LlZDJFNTZOybhsP0igWEC2cXjPLhUE6OsVZnXEa2L?=
 =?us-ascii?Q?UmWj+LUxuoO0qH+Is1krH+gIYkEHzM7XwRpdjmLCtURemMBiUN70jCcI4N5E?=
 =?us-ascii?Q?1dxftI3IRN2txtOXZACFP9h71mH/FKXN7JApCbN1HOvhlIJ/BwTniiK/asXP?=
 =?us-ascii?Q?8TRYl0ub9qC2BpsIys18abCwVt3nOITmeKwUi6ts5D81n9QNUZyaP9KL+YGq?=
 =?us-ascii?Q?wQce3bbkh0/X+Enzc2gYnMvLsr38wCCmDXbb7WDPcC+OmMsmZU0lb08h6/fe?=
 =?us-ascii?Q?aGYvfz3P5OQ3sQt3n8HbnE/yoSwWbvHkEqmJH1mntQGaZmXhshOf6se0O9Wf?=
 =?us-ascii?Q?8cuQg2srhMU+CfwagE6LL+ij+tXHpKibb49lkFJX53vqnOX7IRLbhSiUNJti?=
 =?us-ascii?Q?iNGUUttJj7HSdBsLqS4aapptSHEl58SptfvIRiJIGazUUrcM7pfQXqy88TIr?=
 =?us-ascii?Q?x9fWNtbMDysRzS9r1U6yJ6Ae7MgvBhZHP1fL7MBF/oV6ryiB8k3cSFxRzdcj?=
 =?us-ascii?Q?ihz3eKwPoGOyAB5XkpPONYXMEGR32dSCqIYunzzDvznm/8F16ucY37JBf+A9?=
 =?us-ascii?Q?mDk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82547d6-3add-4376-d3c4-08d92e8fc776
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 17:22:10.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMWJuPuILVnHV7X7WlMcleCc2ag1k7zMfSlKiwUEEQhNMAFirPrpdknwiPVwwlVQ+RHvMzTp55Pfj+tYCr78OJiFuqDCGaNU85X69Ci9+sVu5QjE3tEKmrWOzz+JwuQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>=20
> Dennis, are you OK with these changes?
>=20
> Jason

Yes.

Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com
