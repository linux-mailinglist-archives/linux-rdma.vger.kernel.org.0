Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA02E135D9
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 00:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfECWt3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 18:49:29 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:48709
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbfECWt2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 18:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzegUUx8b8qnqLOYgAQqEbkA4A3LYVl88NTlv2hbywM=;
 b=fJdriu6gHsBycCgs1EqF+1jRmo8VJscEXLsr4335YFSpPs7QMcX90pTm8puWZ6Hff3QWJVvtFZvzpMkALlos9eDcsHfpEjrhbZN8s058t7rKf0M032T568e5d5k7Iidt03xFP0g2uB83h6+35JJCwe4HLBK+2eGFCxXmOGXIGKw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5213.eurprd05.prod.outlook.com (20.178.12.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Fri, 3 May 2019 22:49:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 22:49:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH V2 for-next] RDMA: Get rid of iw_cm_verbs
Thread-Topic: [PATCH V2 for-next] RDMA: Get rid of iw_cm_verbs
Thread-Index: AQHVAgJ0HRjL/V+yeES1Uf2icTICoQ==
Date:   Fri, 3 May 2019 22:49:24 +0000
Message-ID: <20190503135620.GA12262@mellanox.com>
References: <20190429115906.13509-1-kamalheib1@gmail.com>
In-Reply-To: <20190429115906.13509-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.119.211.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1047da72-d59c-41c6-f102-08d6d019964a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5213;
x-ms-traffictypediagnostic: VI1PR05MB5213:
x-microsoft-antispam-prvs: <VI1PR05MB521323B91371C3BBA0E7411CCF350@VI1PR05MB5213.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(256004)(6116002)(3846002)(99286004)(33656002)(66066001)(68736007)(305945005)(6916009)(53936002)(6512007)(66446008)(64756008)(66556008)(66476007)(73956011)(1076003)(4326008)(6246003)(14454004)(25786009)(66946007)(26005)(7736002)(81156014)(8676002)(71200400001)(81166006)(71190400001)(86362001)(6436002)(76176011)(186003)(2906002)(476003)(102836004)(486006)(2616005)(11346002)(52116002)(446003)(8936002)(54906003)(316002)(4744005)(229853002)(1411001)(6506007)(386003)(478600001)(6486002)(5660300002)(36756003)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5213;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HaE+/62LRxfMcXd0rmm0E5pJF7gcguniP/CPewkDyLN8eb/W8qoDu7vCtYwSlv1p0j/kgMSVoF+C63emg5CoJ+ChLLm0WpaVadbXEPlZuvmagFHJB/s9opKzE4TKsRi26e0/RtuBioxasFaqDoCWRD/WnaRLTkE0VOibC8cB+38Tjr114Fdex8rzvboVxsPkrHKRoZA6pEivmDsj+d2k2IwtU2EOFep+AE0z/gLU1CUt4D6zgoTdXWK+epPSoiZVZdihJvbCS8l5rWBvMsKGGmDAml7mVECUD2J2c448j/zvVLPK8RMP5Iv5IA+3EIeuR5818lnJGdMTS7LeCdBsK84NmcgAoICQp1zofS5o26Y/DkYo+RIqLjAjaBe+sXsH/gDp48BqT7r/Lm+V5UB18JDsoZWuKtS/zSdWTZeqv40=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7E073B9798697428ABF5F1F364FB89E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1047da72-d59c-41c6-f102-08d6d019964a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 22:49:24.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5213
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 02:59:06PM +0300, Kamal Heib wrote:
> Integrate iw_cm_verbs data members into ib_device_ops and ib_device
> structs, this is done to achieve the following:
>=20
> 1- Avoid memory related bugs.
> 2- Make the code more cleaner.
> 3- Reduce code duplication.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c            |  8 +++++
>  drivers/infiniband/core/iwcm.c              | 35 +++++++++++----------
>  drivers/infiniband/hw/cxgb3/iwch_provider.c | 32 +++++++------------
>  drivers/infiniband/hw/cxgb4/provider.c      | 33 +++++++------------
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 30 ++++++------------
>  drivers/infiniband/hw/nes/nes_verbs.c       | 27 ++++++----------
>  drivers/infiniband/hw/qedr/main.c           | 25 ++++++---------
>  include/rdma/ib_verbs.h                     | 23 +++++++++++---
>  include/rdma/iw_cm.h                        | 25 ---------------
>  9 files changed, 98 insertions(+), 140 deletions(-)

Applied to for-next, thanks

Jason
