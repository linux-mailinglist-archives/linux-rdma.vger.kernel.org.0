Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C51163F1D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 09:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSIan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 03:30:43 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:50702
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbgBSIan (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 03:30:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeVmjPiMM+v/zOvwzYx/kHc3B0QonnKDhqXTtuJWQ3A4Lt2uJnF/7YQA2bbUKmkai3oYF8cMJVfz43q053sVuNtzQjukKeTFyyRkF6xYdyfhDnNxkGVxea/iTEGtX9jMY0kNSY9YhRIpowv0cy7xel9sL6zKesDH8n870oHpqKLGtEiQ8s2E3qKAz5dWoydVSv8ucmcEWtfWc9RdvxCzJZva71Vr/2dgmVrpxy6E9zB8YGWFcS+xoRdU3kaNmC32q1bfuvGn82m451EVMCJOlubZLAN66TyEVTXwhfsYiWgDwqD+QxuvsfGrog/eTUH484POZiVogdKHfkrIehZktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G1AKftDORrhtQ+cPsZTeDAfnWFc6BYzIQHR24M++Xw=;
 b=Ww9dyKaqJlkxzRvs7X0hMJ7Ek64AWKTfqsWuwVD9Bi6HcPJMWmtOeoRAUcWTr7cxKNGPML+cINcc6Uyi8QFPFldoAyFkef4G2bqNlJjf2mQKAQFJoKuiUcF5uh3DO+i9i7uHM2G1fgcaZIqmX1Wp/NQvvVEtXnZP04gtZEqYXjm7eJ9eof4AcjCZYU5MCKWIPkd9IQgaWhNRJcy0gK7jFtywyP2L/OROzOSbBhmvneFUBZPb1Y+79ZaJ8CntCAQUn6ZC+xigep3uIb/Rgxz8qxvLJtN4SGHFKe+GdNCCoR0+rAux5/UyhrN310b0wj+34PNWuANiGH7+ufdoX7mtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G1AKftDORrhtQ+cPsZTeDAfnWFc6BYzIQHR24M++Xw=;
 b=ZRoK1NDciS9ZVoeNfWUvQ0i/WsFg/ABVou1gRQzaxb5g53CM/PjWlvdicF9byxsXtos2VnIgnmwiSUJZcn9XCDO3rs8JPFSlqe73qH1pnnzCAMMoQu9q/qfD6URqr1Y7WuAaGBmKyiMINMUIAL2Xj03u9Nr8uMeviIrqKoNqKv4=
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB4949.eurprd05.prod.outlook.com (20.177.33.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 08:30:40 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:30:40 +0000
Received: from localhost (2a00:a040:183:2d::b82) by PR3P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 08:30:39 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair
 attributes
Thread-Topic: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair
 attributes
Thread-Index: AQHV5dTbPFFk6Ot3bkeVZUUeQQJsaaggtwEAgAA2sgCAAMO0gIAAgKWA
Date:   Wed, 19 Feb 2020 08:30:40 +0000
Message-ID: <20200219083035.GG15239@unreal>
References: <20200217205714.26937-1-bvanassche@acm.org>
 <CAD=hENff-t-xCrYOnCFLMKYgKDodxEamm-Z++U4W202MprEWDg@mail.gmail.com>
 <20200218130942.GB3846@unreal>
 <CAD=hENfcwDYGwEKG+zz3S7C35y8wrcz=UEvL3WvTnHfZvTeJ-g@mail.gmail.com>
In-Reply-To: <CAD=hENfcwDYGwEKG+zz3S7C35y8wrcz=UEvL3WvTnHfZvTeJ-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR3P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::26) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a00:a040:183:2d::b82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b86fd08f-f9a2-4d79-bbcd-08d7b51600a1
x-ms-traffictypediagnostic: AM6PR05MB4949:|AM6PR05MB4949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB494960B799103E914C890184B0100@AM6PR05MB4949.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(52116002)(16526019)(558084003)(81166006)(81156014)(71200400001)(186003)(33716001)(6496006)(8936002)(6666004)(8676002)(6486002)(6916009)(9686003)(1076003)(66556008)(86362001)(107886003)(4326008)(66946007)(2906002)(478600001)(33656002)(64756008)(66446008)(316002)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4949;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GS7ePZEiNblbmIVJXx/wdmarJy7qAiEIEglbgWX8IhsBpUr0a1Un9XVehQe3Y+bJFXq3HyIPyJDp/xiMDW7ha0PADuqguT+9n5sWRLl2uM3DlJiFbpQSBCNku+aogUxaKwIaUOpIvS5IhNUEdP7IfhZxVod06f1Vqcsxp1IU92ejoAbwmiIh5n9IEGK71XWZkNraLU4FlixYYuzUsjdURge3I+TDz6kS1HxDTenoc4uaHOZ9h9AVO+evGV7A8M2jDyv9yxNb0g8icwKSL/QNAXuF2okH2rvik/xIuKEr3qX+i8Lcvq0qdcaLPt7QUh/H7ekKgkQCz94NG19qoFVLosv8P3NpeqM2yUpapAdpOVE3uyGKyBsPedt6GOs7qNAIw1vnaw+4dKe1x0y7sRhiXrIIJdDyi66YflWTt89/lSKQhgz6XqW/2L0swVYRt7SK
x-ms-exchange-antispam-messagedata: LnY+Y54MR9sxz+HOpcq/tiBl2fKxWF8blTaFPIR9AK9P6eSAptya29nVftP6xt8cO2GGmS0O1k8tcx0VTIbOiQ9gTw57fpsq/IKg1HjH9zqucjYOml1cyQLc+3JfxxlscpZ2L9jZoPEZEwHJI3k+rBdlUILo6lL0qyn+aWwUvjE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FA2E1233BEC7E4DBBB4D1687EB3FF82@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86fd08f-f9a2-4d79-bbcd-08d7b51600a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 08:30:40.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMnai2aNRcopSf4rh4feRoccCjTSZcrmbVSLWLkuvroxRwITN3G3bGExhknif5jYqpvHbg0U5DVz17mQjgYFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4949
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 08:50:09AM +0800, Zhu Yanjun wrote:
> Thanks. I am fine with it.
>

I'm fine too.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
