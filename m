Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4B25B1C
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 02:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEVAWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 20:22:50 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:52486
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfEVAWt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 May 2019 20:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/3hWM56EtRq+6gX+wWONpWIM0NhOrH8YwfB1wlEZ0E=;
 b=mVEZb1onH/Y2/trQJT/AlgSQHMZL4MWUj0hxYgBCAZwaLJzbnb+vMBczesJKurwqcBnbrVY9JK8rkFPtRATxrxWH1/U/eQWz0ZXoUmJ/1CPmm3HfM06kCC3mM7Nk56Bd7ptNsm/r0PKb3GhSesttxmQtPrcQjCLpxl1GEwuovvg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6543.eurprd05.prod.outlook.com (20.179.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 22 May 2019 00:22:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 00:22:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Gal Pressman <galpress@amazon.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH for-next v2 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Thread-Topic: [PATCH for-next v2 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Thread-Index: AQHVDuF1DOqAXpFGBkqC6rsta48O16Z2SyeA
Date:   Wed, 22 May 2019 00:22:42 +0000
Message-ID: <20190522002237.GB30833@mellanox.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-5-shamir.rabinovitch@oracle.com>
In-Reply-To: <20190520075333.6002-5-shamir.rabinovitch@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f8ef171-eead-4086-ee59-08d6de4b9af4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6543;
x-ms-traffictypediagnostic: VI1PR05MB6543:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <VI1PR05MB6543482CF4C9714800382D88CF000@VI1PR05MB6543.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(229853002)(66476007)(66556008)(4744005)(64756008)(66446008)(478600001)(14454004)(66946007)(52116002)(4326008)(256004)(66066001)(6486002)(6436002)(7736002)(1076003)(73956011)(71200400001)(71190400001)(53936002)(305945005)(6246003)(26005)(2616005)(11346002)(2906002)(186003)(86362001)(486006)(476003)(54906003)(8936002)(81166006)(68736007)(446003)(81156014)(8676002)(25786009)(5660300002)(6512007)(316002)(99286004)(7416002)(33656002)(76176011)(6916009)(6116002)(3846002)(102836004)(386003)(36756003)(6506007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6543;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 16mFfVh+C7o7rdND+2HVCKxafvfQXfkMii+9saoQS+C/ce9SygZu2uA5y43PQdmXrh2E9hpLOeNp3THyMEKZM3pRp5PuAv9FXSaYNFNUIm6hKNTb5IqU1NhOLAo4AE1bKe6thF5SYQBcgqGTI/oAF0UJEivSjg6IssrPWRFAXTgbmP2q6O9kza9gv11UhJVs2yRe+Ql/mQIbqbrKZq5LgNtDaBipfbxe+ZSsFt9u+NJXB4hrDQmhy4jPbPip90bcLTISdsNTQLLFrta0o6Mdm/1lNMKYsISOFZV5CFotXnkXJyh1VIAgglcxJxdNiaj9QPN6YYwxP00szJEyp+1C19yolVDWuW8KCYPj+5HaqZyDHfMVMFYFk+uAJoV3IoA+ZJBQXoy9VPtb6FF1dZ9UiRzdVK+TMv4Eyg7uVZHMRIM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <684EEA4358A59A4A8E78D774DB046230@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8ef171-eead-4086-ee59-08d6de4b9af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 00:22:42.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6543
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 10:53:21AM +0300, Shamir Rabinovitch wrote:
> future patches will add the ability to share ib_pd across multiple
> ib_ucontext. given that, ib_pd will be pointed by 1 or more ib_uobject.
> thus, having ib_uobject pointer in ib_pd is incorrect.
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c       | 1 -
>  drivers/infiniband/core/verbs.c            | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
>  drivers/infiniband/hw/mlx5/main.c          | 1 -
>  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
>  include/rdma/ib_verbs.h                    | 1 -
>  6 files changed, 2 insertions(+), 6 deletions(-)

Please remove the uobject from the mr as well, those are the two
objects I want to see be sharable to start.

Jason
