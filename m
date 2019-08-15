Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289338F495
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfHOT3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 15:29:50 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:6237
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730560AbfHOT3u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 15:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az1PEDhsvv03aIeLInIQQiW+mnUo8oZmqBYkj9vbcB2RRAomfwxHjAdZN8z1kRE6wDE/yiAbhryFvpW9IYDW/D/HKHNnFYtW1i+6gkj+iV/MxfinrDnDN5kJVHi6PIGuGDi8YVW/R9kbVS0vA2QjxircvSkHhrmzOY12uTPMFkSf0j3ui2hQ7CX6tScRBxRixL4xqMBdsXvEKubKWBSsyNvpkoIyFddt2lcX6CoBWxWptx/faXrRmNTCuzfpAmCMhrMhgEHPieux3MLt8jfy+GYGFpA57c8Pu9m0I+EZtUVy9I1OynoE8W3qtNw6wgW8puyy8WFDzlVFDP6nPle3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkU1KbSy7b00xqkB8/Sew1SRkNgxQmhAYR+xgSjBxS8=;
 b=kFWt6KSvuzterOBhnfC9iQkgWhw+1bRMKtz++yYTwF/aFyCBy0re0RrRTc1+aikKrvBMo57PlYbjtw2iOnle3idcytjPBWLRO8zh6BrkVFIrr/L62qHAsNF0+VfI8str2zo9wAPzkmxWbERfOBwxBrOPyQG/+oIW3QHiTwZYM/f3RUkbU91LOoLFNy0X/88jaSCoVFAE70P3DKh3nTlnGsJOfRW2fkUMvyA/Cr1b2g9u9r4mvudF+7rUmCPr/Qoj863W1UI4qoxBZMlSsMWP2Wso9NF/+5jpVCVN1HcDbR6QIwT6lJWDxaAdxvC4xzslEkxikzKTSfkAi3R+gxfppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkU1KbSy7b00xqkB8/Sew1SRkNgxQmhAYR+xgSjBxS8=;
 b=MtaZbXtJT0SGa/gyn5yjTvrwYSwZ/EuxdlUQfhnCZxmb1/ct75AAcCqnl4Q4A34QVlWV7zBC6espMy0xFlMJxNVs8UsSB7Plrc6vBt2Xby0TLOHQ+ni2zlZX7W8oPRtfwCni5nBIsdiHQbYHiDyYx2gNb6GGcFbE/1WqSoMMjZA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4302.eurprd05.prod.outlook.com (52.133.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 15 Aug 2019 19:29:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 19:29:45 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>, Moni Shoua <monis@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "Guy Levi(SW)" <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/8] Fixes for v5.3
Thread-Topic: [PATCH rdma-rc 0/8] Fixes for v5.3
Thread-Index: AQHVU0TYn1Az9I/VSkKM7aiSteS8gKb8mQYA
Date:   Thu, 15 Aug 2019 19:29:45 +0000
Message-ID: <20190815192940.GS21596@ziepe.ca>
References: <20190815083834.9245-1-leon@kernel.org>
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d56b8846-e58c-4727-5ed5-08d721b6ed81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4302;
x-ms-traffictypediagnostic: VI1PR05MB4302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4302B0BE73A983699F644DB0CFAC0@VI1PR05MB4302.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(186003)(476003)(86362001)(229853002)(110136005)(5660300002)(11346002)(14444005)(8936002)(14454004)(3846002)(6512007)(7736002)(9686003)(54906003)(4744005)(446003)(53936002)(81156014)(2906002)(107886003)(316002)(36756003)(26005)(6246003)(25786009)(256004)(66066001)(81166006)(6506007)(102836004)(99286004)(71200400001)(66946007)(478600001)(6436002)(66476007)(386003)(8676002)(4326008)(71190400001)(64756008)(66556008)(6636002)(66446008)(76176011)(1076003)(52116002)(6116002)(486006)(305945005)(33656002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4302;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L1uFuW2sO7YRFHfSkSKa9LqhPCtYCJBJGC7y4SfRZZUzRqfMBQ5dpEC2jfm/vQFoo++FbpJ3gKSEP/MQx5d4NnpTJeZZeNEvJ83vlt6/OE4bXJFYFaTgl0m6S/LWzvBNIYKrvskxuSpq3l8K4AYEJEnQ0XaNlrKuif8WBgxnDFSO1zshaksUP2cWETp9zo0MZaIFMZj7BmGaoc5EEppEV8j3mEJ7AcWprD20xcgaMq8KkvaCTpr8XChttPceGXzOFql5FYxy1Uz1gYc+6NkiIFrFMIgnn4j4chtSrpb6Yc5ul2Okly7tNSG4ZhYa2+kWgn4ZAPz8QEnzV4/y4mfAo2FzkZ4XyaPxRXanBKaW66PbLtgvKL5cVXvc5xUMhffNgOogQZUKgaLN/otZgZgSvQwoJ9cVv3bOU54h13tz86E=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0647C6642090747A93D0B776D83CD90@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56b8846-e58c-4727-5ed5-08d721b6ed81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 19:29:45.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38RhE1BJZLIK40+eozrfRC3Gs9FKmVb0dqLRCqFlcvLbNz18VPEXPjvY1xFHAzxVEE5p5m/zSV/1Crp2e/KShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4302
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 15, 2019 at 11:38:26AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> This is a collection of new fixes for v5.3, everything here is fixing
> kernel crash or visible bug with one exception: patch #5 "IB/mlx5:
> Consolidate use_umr checks into single function". That patch is nice
> to have improvement to implement rest of the series.
>=20
> Thanks
>=20
> Ido Kalir (1):
>   IB/core: Fix NULL pointer dereference when bind QP to counter
>=20
> Jason Gunthorpe (1):
>   RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
>=20
> Leon Romanovsky (2):
>   RDMA/counters: Properly implement PID checks
>   RDMA/restrack: Rewrite PID namespace check to be reliable
>=20
> Moni Shoua (4):
>   IB/mlx5: Consolidate use_umr checks into single function
>   IB/mlx5: Report and handle ODP support properly
>   IB/mlx5: Fix MR re-registration flow to use UMR properly
>   IB/mlx5: Block MR WR if UMR is not possible

I'm a little murky on what thes are fixing? Moni?

Jason
