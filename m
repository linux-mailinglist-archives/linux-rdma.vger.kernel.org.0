Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0696A1230E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfEBUQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 16:16:25 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:18658
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfEBUQY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 16:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CemP38IYiZDmihI4L5vhEHEKkoQtLyFEoem4yVvz4s=;
 b=YhpdzndTXDP0bIuoJ1MPCw5+MtNHcXlrfw9x73FsScAq/UJ68KSwW09sMZlB12eXSJsFxBWhxAV9hLxfa6IbCcpzZFpnzhbZ/HXqrmTulrsa051slIyRbQcbzeC+19cut5Zw5sNIapdMEFgLH94XnGyMPa1m7tZAZCK4dQRsr+k=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3136.eurprd05.prod.outlook.com (10.170.237.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 2 May 2019 20:16:20 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 20:16:20 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
Thread-Topic: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
Thread-Index: AQHVASPnIrh2vMXjiUWrnjVnf9r2bw==
Date:   Thu, 2 May 2019 20:16:20 +0000
Message-ID: <20190502201616.GA11472@mellanox.com>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
In-Reply-To: <1556613999-14823-1-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR19CA0053.namprd19.prod.outlook.com
 (2603:10b6:404:e3::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eefc33cd-4573-4a74-648d-08d6cf3b0a11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3136;
x-ms-traffictypediagnostic: VI1PR05MB3136:
x-microsoft-antispam-prvs: <VI1PR05MB313673ED13BB527A8078312FCF340@VI1PR05MB3136.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:170;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(346002)(396003)(189003)(199004)(52116002)(66556008)(6486002)(478600001)(486006)(76176011)(99286004)(71190400001)(66476007)(6916009)(53936002)(66946007)(71200400001)(86362001)(73956011)(3846002)(256004)(64756008)(4744005)(229853002)(66446008)(6116002)(6436002)(1076003)(7736002)(33656002)(4326008)(5660300002)(36756003)(68736007)(102836004)(26005)(2906002)(6512007)(81156014)(66066001)(8676002)(6246003)(305945005)(316002)(8936002)(6506007)(186003)(14454004)(25786009)(386003)(11346002)(446003)(2616005)(54906003)(81166006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3136;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +4G73sThJufTyorzm97oyMoBQXeuKS+55w5S6Jfzu9rnZOr3UwPW0uB/FjqZhRodoBRcHWdF+Uc5OJliufHLIdhacnggCP+z0TYMdeQJBUDVC+Oceb5f92JCqkJN5wZagA1qTm/4Zhc7QCV0nsHfzgtQWLJZuw1ayo7R07LRMXCh/F8w9/hnVoDF/4vHHtWjV+udC9OkCpYcyi7a5o905vAEk+3dSBj4W2Y2yTgKHBaBZZH4LRaZQ2n0uYcix3h3zw8sUaSmXKYhjQuHZCX0PRgoIILMOd+xe3JRDwdnt0sBoY1xAT74zmQ255P8+W6xWFaSmT5s3TEnlriV/PoJcsafxlWiMmjWh49hCXvJMV/7A0OKjYj9FWoIfi+S/vQvmZDjZJSqKDAb4DElyrZL/fyMIatjkzRpFUUyZ5Y4DM4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2674C1370D6C0E429B9AFB712837EAEF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefc33cd-4573-4a74-648d-08d6cf3b0a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 20:16:20.1388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3136
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
> Cited commit introduced the udata parameter to different destroy flows
> but the uapi method definition does not have udata (i.e has_udata flag
> is not set). As a result, an uninitialized udata struct is being passed
> down to the driver callbacks.
>=20
> Fix that by clearing the driver udata even in cases where has_udata flag
> is not set.
>=20
> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path"=
)
> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/uverbs_ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next thanks

Jason
