Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D323B3F8D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfIPRWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 13:22:07 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:36423
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727593AbfIPRWH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 13:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8ViuJrwAsgGp1Y0aeJ5Kc7Dytcjb8c57jNeoutAT6laPcdYUcahQMNCFWIwtpJqbyXZwEGKD0vAfPLe8sZWa3uXx8XgJNCbWzrlILFGMUc4N7/rwgbWLPtzIHN2B5jeKJ+17lZ9f+9XB2kQAZe5UncKAdjGlwdvDcuqbLY/s24l0MODY+PfO2ZMQg07HIOGr4IsEMAy7sc/pW17Y0DZdX3wKmq0MKkztbX5ecDVLYKmY8j4aJpo5cmSuAzNppGQ7/dxSIQ5rvvyiXicmB/wRoe7eT/8+5a/lfZ1fFpgiKFiTbA8+CxMeNKnbhPDhyhTwi6c8ciPaEKTNYzGHeU9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZXm5akbtWZjBvLgrIvS8forSt4YBilXf5KWwn/gfXA=;
 b=T7xC9cZNszSndu67XljO4wtLGip/HIyZP5VEq92ss9JjShhSRDefjNp+0q/L35VhCKm46UoZeoHjUhZ+1ZRafwzddMwIVxyPRb5fDy6mIZkcLny8TfbJ6qd0NJvb+xEY3MVdByiR2ytAefg2AdkF/MLI3qRxG1QdJN6Ztxs5LWtcoZ2tdbpILKN6hPhiW4DY+BUphG/tkrLFTL/G95jjBQMErghSdS8JJoSeWMoy8h6BF9h+HALId6UyWn+FVSyfvlWPASmhOorjVxXLkcoPdn639zxOUBXjmRNt1vthL2UwDmcdwzgqQ0wDiAO30S2g1WAc8lsT7in1ZlfJGx08aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZXm5akbtWZjBvLgrIvS8forSt4YBilXf5KWwn/gfXA=;
 b=rbUppWo2h5bLBQNzOENC48pHYAzN/auxSRJeuF53JNBElg28/LKflcgzXJo14cRKYapDzobDTyZurpBThvfgtCbZDsDwxMGvb11qM4MqXd+qMeLYEUw0FQimhEf/Gk1v5UXjjWTP4MUFWWe6PhzG2W0UN+Au6f6ssRALWKFAlAg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4670.eurprd05.prod.outlook.com (20.176.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 17:22:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 17:22:03 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH 0/2] Two fixes for this merge window
Thread-Topic: [PATCH 0/2] Two fixes for this merge window
Thread-Index: AQHVbFq/Ahx2+6x+KkeWQqeTjjpbE6cujcaA
Date:   Mon, 16 Sep 2019 17:22:03 +0000
Message-ID: <20190916172157.GC2585@mellanox.com>
References: <20190916064818.19823-1-leon@kernel.org>
In-Reply-To: <20190916064818.19823-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46314cb4-22e4-4247-b229-08d73aca6425
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4670;
x-ms-traffictypediagnostic: VI1PR05MB4670:|VI1PR05MB4670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB46703EFD5E3FFDFA5F20369BCF8C0@VI1PR05MB4670.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(66446008)(64756008)(66556008)(229853002)(26005)(76176011)(386003)(6916009)(446003)(3846002)(71200400001)(6506007)(476003)(486006)(99286004)(71190400001)(33656002)(7736002)(305945005)(186003)(6116002)(53936002)(107886003)(6246003)(2616005)(1076003)(11346002)(4326008)(316002)(5660300002)(54906003)(8676002)(81156014)(81166006)(66476007)(8936002)(6512007)(66066001)(36756003)(102836004)(256004)(14454004)(86362001)(52116002)(66946007)(6486002)(4744005)(478600001)(2906002)(6436002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4670;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OsGEfJP+ICaBQNy1ZLL3cZJ1zL/AZxjPFIoq+lvn+eLikdjtjuROWa7IoRsASlyOQjkMrlZer4/N13pc3gai+4CbYrU/5V/4hN7V246hcXvFWJhWbeZbD8V2iqw2U8tBQima+YOkVWlrO//Fl6N3rexJesPcZ/sj3eJ1k24uxDJU46nfBYyA2zki4pg8WaiJhe8YW87OnLZzqFmSqWjIBclGViPySCVgXw7yAtOnNl/PYvcODSJ+rFPNYi/tCScSnAY/NlH+fCyQeZDX/gm7vlOOaR2zteOcYiBtL0Ost7BFo/6wXNeok8jprX/u44v7BQk1SZQpFa8NoQdM20WB7HfigHh9Jm1VCfleJve+huC0bGGQHJjUCH2PwAinpuowH9D7T5g0NnscG3UhCHL/Lt/CY/xQAQqbv0kN2YS+qko=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F9EC5B6C672CF44BDDDB49A116547B9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46314cb4-22e4-4247-b229-08d73aca6425
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 17:22:03.6469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIO0ppYKYPam9L0gCWNIS6R50oz6kB45ass3xrADE97MZ3Gpdxf+4Hyd4WLFsf1z4VUx6shs4RPCd1y1MqO1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4670
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 09:48:16AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> We are in merge window so I didn't know if I should put -next or -rc,
> but they are better to go this cycle.
>=20
> Thanks
>=20
> Danit Goldberg (2):
>   IB/mlx5: Free page from the beginning of the allocation
>   IB/mlx5: Free mpi in mp_slave mode

Applied to for-next

Thanks,
Jason
