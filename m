Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C33FCB10
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNQt4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 11:49:56 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:7040
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbfKNQt4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 11:49:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZWv7zw1m+dGOLIiq/noTVB7lVR5mmQ8GYo6gTpPUcmx73ZXc30mydvyYKTmc5CrLTo0RLWk4b/YFUKHYpfeXQSt5sYzU/1/OittEpV5rVFshMqpuKcw/6T2+X7/S9P/MyqV73+5ndRYtGXrd9alIAlt2okRL3B0MHiU1zV+F7WR6snIooXYPWsrCeheZ5uT6OqFFMZcWXs75jVfbOPXC2bT1eTpKy2hV2ejZik6sUSS10FvmrjhCggMVfZ76J3H9IUhB3db/k0fTUiQSDhEcg2hrQLVScnqRwHGO6b/AbyoZAoytoPulF8iA18BMUos4PTwfJHupd3lSeqwhi/9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6zC6SYTVrKerFvBLAheM7LwQuGvnQQnlbrz1ziCv18=;
 b=eeOsrMPNXzum5sDcCiSXOcaxlk+svwKLlG7CpecY0DiJFwOvY0lpxOH41hP8TVkUGiQa4cAqisKaVk7sYO91qN7ybajJJMHw2JNw4p5DAKa9RDU3NhBvFCL8yaU/VgaERGHzEVTVubxIZ8/KaoBNVL007klalb0Uf/uvIQH2o2egbVr+uYvV90V8JcCRD7AX1AByJ53Es88ie9Bs29I8/wkYlylYqZPZOQSa0MZGlqI9ve/6a+GiSv0XpOhVRm65+mr7rQ0QtuI4mxxg9qhUHEKmic8L4InvnjXnVZKU+Qoujn6BE5Wo4VXBRo/8iVxx4T1tgmDi4Kox04dScjtI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6zC6SYTVrKerFvBLAheM7LwQuGvnQQnlbrz1ziCv18=;
 b=F+uiFrMGAX9Z7U2RvN8LOzCMn5KXq31I7qGxOVbZ1juPENvDyl5kbK0aOTzfUHM12EV1A2QJWuxmqszhhQA/emFEtQo5H1h/0O1SRGT/zmlNRY3CUxRZk3jGLzt8Lf5ynHwiQSFZDzAgu7SGrohwM18mXq2FBE0XfVTQNQ1rhMM=
Received: from AM6PR05MB4152.eurprd05.prod.outlook.com (52.135.161.21) by
 AM6PR05MB6311.eurprd05.prod.outlook.com (20.179.18.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 14 Nov 2019 16:49:52 +0000
Received: from AM6PR05MB4152.eurprd05.prod.outlook.com
 ([fe80::28c2:5ab:f383:fed]) by AM6PR05MB4152.eurprd05.prod.outlook.com
 ([fe80::28c2:5ab:f383:fed%3]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 16:49:52 +0000
From:   Edward Srouji <edwards@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daria Velikovsky <daria@mellanox.com>
Subject: RE: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Topic: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Index: AQHVms8sbhl+P+e5bkW4yXUEEbCwjqeKrGQAgAA0dOA=
Date:   Thu, 14 Nov 2019 16:49:52 +0000
Message-ID: <AM6PR05MB41527769B215FA0089CEBA90D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-3-noaos@mellanox.com>
 <20191114133954.GT21728@mellanox.com>
In-Reply-To: <20191114133954.GT21728@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=edwards@mellanox.com; 
x-originating-ip: [77.125.32.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 297ffd34-ca52-4547-de75-08d76922abb9
x-ms-traffictypediagnostic: AM6PR05MB6311:|AM6PR05MB6311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6311A248A40B4D92484BF08FD7710@AM6PR05MB6311.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(13464003)(55016002)(9686003)(11346002)(6636002)(186003)(102836004)(476003)(256004)(52536014)(26005)(446003)(53546011)(6506007)(7696005)(76176011)(4326008)(486006)(99286004)(86362001)(2906002)(25786009)(14454004)(71190400001)(71200400001)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(5660300002)(7736002)(54906003)(74316002)(316002)(81166006)(3846002)(81156014)(8676002)(6436002)(8936002)(305945005)(110136005)(6246003)(33656002)(107886003)(6116002)(66066001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6311;H:AM6PR05MB4152.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4r6oA82QLzTYAhsM85/s/Klg6l9ECRwfJWrs7oAfSgwP4ZSQCtIcqVsQGLBY44G/DyLV+M006fFbwOaWUHJEzK9Xxl/fyw0aTdngqrY51fuYW1L/7pqppQ8h7JQE/hXnsifYBYP3eeL/tsoP6fJCJSolW3/Bml8DvJxDBu8NV0rCe23FRgS9bcd/zdJvbOYyCj21XicQp+LXIDCSTj2KmJCeFHmB1MBimLT5Zyco7xh6XdPztmQ3Uu/OH2r2rkXtC4b7xr3pPZMNrq3IyWRapA9kwmgryJaD3ZoXMfq2jr9UXLsXafZpRCTxElhJpkyzQR+l0eKzymoHxgIqKQ05cm1QStG4p36I8einDVeo3JqAwIHd/msXPGm31LkS1WsIkK1ci49+rjPx8t4yERGGv8pJzV4wgWBTxxYL5oLtD3+nuwMBSvbSn5nfC9beK+7p
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297ffd34-ca52-4547-de75-08d76922abb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 16:49:52.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kc0TIfvR/2LbD4IulEZVk0k06RFAvsWVI38T8eOulm5X0h8bMPZ2IcFWyH3OFW8Qvsew2o0Caq4cFTEwzGzfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6311
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

They are defined in mlx5dv with #define and not enums.
I will change to cpdef though.

-----Original Message-----
From: Jason Gunthorpe <jgg@mellanox.com>=20
Sent: Thursday, November 14, 2019 3:40 PM
To: Noa Osherovich <noaos@mellanox.com>
Cc: dledford@redhat.com; Leon Romanovsky <leonro@mellanox.com>; linux-rdma@=
vger.kernel.org; Edward Srouji <edwards@mellanox.com>; Daria Velikovsky <da=
ria@mellanox.com>
Subject: Re: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class

On Thu, Nov 14, 2019 at 09:37:46AM +0000, Noa Osherovich wrote:
> diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/=
mlx5/mlx5dv_enums.pxd
> index 038a49111a3b..b02da9bf5001 100644
> +++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
> @@ -45,3 +45,14 @@ cdef extern from 'infiniband/mlx5dv.h':
>          MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING   =3D 1 << 2
>          MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD   =3D 1 << 3
>          MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN   =3D 1 << 4
> +
> +    cdef unsigned long long MLX5DV_RES_TYPE_QP
> +    cdef unsigned long long MLX5DV_RES_TYPE_RWQ
> +    cdef unsigned long long MLX5DV_RES_TYPE_DBR
> +    cdef unsigned long long MLX5DV_RES_TYPE_SRQ

These are supposed to be enums, and should be cpdef

Jason
