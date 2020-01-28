Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FEF14BF34
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 19:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgA1SJT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 13:09:19 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:33665
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgA1SJT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jan 2020 13:09:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eblogwpr47T6V9pcx6psM0YK0iGqMY18Gsbnuk3EyhLKTgJT5/DtpkNFeFct3imPD9polLFClskGO/KZxemWMy3wqyNG+WGyyr0qDm2E7rNSQkvD91xE4ZL7K0MRs0LBuisqQTNG23IIkih9Vs/yrxBuNHNiqv64qafB/lHrbGeDZI6hiBGVqlr1Rqe+BP0YJPFFOWvnmBBU3Ilk/373c5NCSF65xAKYj/V4s7o0GiFdrJUsEZQoCW2DWejjIHjKbE7qbUvyuglvY7zXcAC2LIfdrC34IMMlrMsuhDcjrn4YxxOzD3Gh15GuzVnWZ7d8NYytuTXrkcX07Cp7mhlt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV9SRyPmv5gQXvDPJnsDHzzjX5/ZurjbsmOdGJh2tv4=;
 b=TQ9p21/HjXinL5QRpAdSNdC+orO4KaIaCNKsvcMRV41qdP69yKyrIb2wX0lPSWZKzQnCSpqtHW2lxZo/mf1hWhhcdWJFoJrUhVehCJWNyUKXVZr5u6v290Hq+6RZeiwLzlG2mW98qJd5CbAUKlGzALCfAFwJjZEZTpWndFL/2uyUb/Z9dXarGt+2gPCVdGLgJHcEWU/Axn4KCrNYF1qYjQjsNBafW1A/sRDQRXf1i4OnHVlFVCJ56Ig17wJa3IesyjtDpf+ej5Sr4zspCLXxb6YjcZMTGg1spBNQff+qWclbSK5P1L2euanaeJZVo/AEYbW+w3OBWBBSP9zEDmRoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV9SRyPmv5gQXvDPJnsDHzzjX5/ZurjbsmOdGJh2tv4=;
 b=D02gMx8MTsZKZzw5woQ2Y4rmtiYSzVvh8GxfrDHqCPTVUNJ+awdAcyqCcbNGGabd/bFJqKhwhmIKkI8TjZFJUwbLTCktWh+cnJCZpaq/G1R8zrKL2AvI+6BCaD1030xYDOJ3U3U+qglih2XVIoktMCdbyHAlICjVZBfnNAJJ3y8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6365.eurprd05.prod.outlook.com (20.179.24.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 18:09:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 18:09:15 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 18:09:15 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iwVIV-0006Ao-H6; Tue, 28 Jan 2020 14:09:11 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Thread-Topic: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Thread-Index: AQHV0nqOllcH33mzDEKpmcLxvFc1Iqf9BRIAgAEf+gCAAAYsAIAAOK2AgAAWDwCAABlUgIAB09eA
Date:   Tue, 28 Jan 2020 18:09:15 +0000
Message-ID: <20200128180911.GL21192@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
 <20200126142928.GG2993@unreal>
 <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
 <20200127080216.GK3870@unreal>
 <CANjDDBj_vieac6bzbNHNa-WhzpRoSJfOG-bQNqK7U8fN7A+WaA@mail.gmail.com>
 <20200127124404.GP3870@unreal>
 <CANjDDBh4afTVznxGo8U0bafm9LQv0p+w5VHU6rcXu+Q9htvdQg@mail.gmail.com>
In-Reply-To: <CANjDDBh4afTVznxGo8U0bafm9LQv0p+w5VHU6rcXu+Q9htvdQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:408:70::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c408436-0445-4ce8-e477-08d7a41d2f6e
x-ms-traffictypediagnostic: VI1PR05MB6365:
x-microsoft-antispam-prvs: <VI1PR05MB6365EB4FFCDA93296A824AFACF0A0@VI1PR05MB6365.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(66946007)(4326008)(478600001)(66476007)(1076003)(54906003)(52116002)(4744005)(316002)(5660300002)(64756008)(66446008)(66556008)(33656002)(186003)(2616005)(26005)(9786002)(8936002)(8676002)(81156014)(81166006)(2906002)(36756003)(6916009)(71200400001)(86362001)(9746002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6365;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ztlBLkyK7ITXQd852o4vEjBnesuKo2OP177eDs79Q/9BkANJ+wYg45iyX7biHAgZ7LsQhDm7NtiFlwzL93FyqEw67MWBnlUH5LaWcLh9RLi3i/gZCsDaMW3K2u/20TFx8+D/ZfSZDFfck/MUNmABL88r6419pC0tkGdjV5ERn7N/uTkP63yJEUVBmRD/gYffRLqUfZWiBHukuWVo+Usi8NpRnJdmq6aLVcvcxoBPvuGmCe5nFGIQhHfP4TEPFsptHzYLTKsKuIepVTqy3jOQjWibilQGX7nF2+hbq21MxLcHpIqZc8y/A6+MMlir1MsqNYgcfVIVay1+bmpC1M8hnqHDUxfMTXHyFN7SoXlPLW3v1o5HvnB8dKAXjELF2dgi7MG98ZLaRVuPhlkWfJ+65oN5AlIvhZMXZn2lE5O/wj8H7PLkOdycNxj8T6EsX/SeARiB/xtYCaEz38oQ3RmlQQqC4opC13YAwR/fG9F7XMFjOxCYVHFBrc/Jfwpx0Kk
x-ms-exchange-antispam-messagedata: FXQ9pBUC0xE2sdu8taMVDk0Du7lJxh8qtDkI+YbyYamkGPTClgEo5IhttNKjXPEvReUTIGOLFcTwdUX+8nqqSXtuhwdhVXAtpK32xOph3b2pzQxSx17kLa/rayfB0SKnIw54fNfOLwmQE/+SLfn94Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1E026A6B147F04F9F49FDC05D73F0C7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c408436-0445-4ce8-e477-08d7a41d2f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 18:09:15.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i98I8yY6OkUm7m+xqdYVZN4wadNrSP+1PN1GWAcvA4b2bKcyu8nPvBnyMBamyukliIqM1yb9a/L21rRBq+QQag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6365
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 07:44:43PM +0530, Devesh Sharma wrote:
> > > I will have to duplicate it again to report the precise warning but
> > > based on my memory, sparse or smatch was shouting about "pointer
> > > converted to integer without cast"
> > > I guess that was because rattr.dma_arr is a pointer and static
> > > initialization was assigning value 0 while it should had been NULL. I=
f
> > > you insist I would send you exact warning msg and tool-version-number
> > > soon.
> >
> > Yes, please, because NULL is 0 and has special meaning in C standard.
> This is what sparse warns about:
> make C=3D2 CHECK=3D"/data2/upstream/tools/sparse/sparse"
> CF=3D"-D__CHECK_ENDIAN__" drivers/infiniband/hw/bnxt_re/
>   CHECK   drivers/infiniband/hw/bnxt_re/main.c
> drivers/infiniband/hw/bnxt_re/main.c:1010:43: warning: Using plain
> integer as NULL pointer

Yes, this is entirely expected, you should not use the {0} pattern, it
is not reliable. '=3D {}' is preferred.

Jason
