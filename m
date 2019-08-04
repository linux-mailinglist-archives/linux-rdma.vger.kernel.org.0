Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48239809FB
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2019 10:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfHDI2z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Aug 2019 04:28:55 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:49472
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfHDI2z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Aug 2019 04:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT9QiAM7YGtwwMWNsECF1KeNvejDeGW1OuXRtpkHHCLF0ZCd5ELYWK7MnJ40qKleynFaWwLAqd+tjrj4darIbWC4d8KSnk29tGMgzW33rFDdzsceNsiYE6+drNmnTY6iYIk7qY5cP7uhjvWg0kcg6fsUxbgQy8K7bYvo9hlXSXElatilYXA4M5zDFCoabqJtEt+zA8/S0/DDGa/ijWwwXozomgWexnGPn9UB3kVH0gNcZds/0Ym8kIXP4J1zDFdAudJdraC58s4/iHc3bbp57xlLA/uY/59NZDyNO+i62D7U/GLN2n+4HMYkNp61xWRE3h6y8Vc4a/R6zaZUZmRQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N5oA7tXZ3FAyJOYvAYArRPPuc5JBnZVdgvrT3e1K1U=;
 b=muUaLLmOkP49/nSh+ZLKr0bAnxOZ9SaMgU4zdl35pvhBt2AC00lcgC1MZPiYe5eifkPXwDhgPfYygtug0s5VShz1TN+6d4tnwDONSMuVYrgeWG+QaessW6y2m1APwjdK/pmki1PT5A3fEN0mrYcSqqV3uQNB+TTVQ83rsGn9sAmwOOHv8O0UH2e71EkE+sqX46EIpq3S1wkcNs6G08dZarlanLuFQ1oqvBk/nwzWpkWlcbGtfbsZ02CI9etlXhhp+X9IK4opHMsLb780owlW9yItYguWRbAVqvgVF58Yg5Jsq9mD/rXOd7WT+sOiXfMjplKmLorKTr5MUtlP/CiM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N5oA7tXZ3FAyJOYvAYArRPPuc5JBnZVdgvrT3e1K1U=;
 b=hLsRzHX4qvKF55l2kp0+gdN87lKwtflzB/0nIm4Cu9GImD7wJxPS3QRJDjZATgVJmG/JdSe2pGHMv9gjSY7bQB+01s8iYgn3YNnSr4g/FKpzNKW9TFNowWtXp931DhzibM5JIRcjrDtv/oPe9jYqbrCGZLBJg4cGYw16c8kpFAQ=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3444.eurprd05.prod.outlook.com (10.171.187.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Sun, 4 Aug 2019 08:28:50 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6%7]) with mapi id 15.20.2136.018; Sun, 4 Aug 2019
 08:28:50 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] Enable QUERY_LAG over DEVX
Thread-Topic: [PATCH rdma-next 0/2] Enable QUERY_LAG over DEVX
Thread-Index: AQHVR5S9Ls7mwhFI+0WkYc2JIL3DkabqrhwA
Date:   Sun, 4 Aug 2019 08:28:50 +0000
Message-ID: <20190804082848.GF4832@mtr-leonro.mtl.com>
References: <20190731114014.4786-1-leon@kernel.org>
In-Reply-To: <20190731114014.4786-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0217.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::13) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 750abaff-3eb0-4121-38f4-08d718b5c731
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3444;
x-ms-traffictypediagnostic: AM4PR05MB3444:
x-microsoft-antispam-prvs: <AM4PR05MB344499176267C916E8EE7A2EB0DB0@AM4PR05MB3444.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0119DC3B5E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(346002)(39830400003)(199004)(189003)(2906002)(66556008)(66476007)(66946007)(6246003)(6512007)(6436002)(66446008)(6486002)(53936002)(25786009)(316002)(9686003)(107886003)(81156014)(8676002)(81166006)(229853002)(5660300002)(305945005)(4326008)(71190400001)(64756008)(66066001)(4744005)(71200400001)(14454004)(7736002)(99286004)(33656002)(3846002)(68736007)(1076003)(6116002)(186003)(6506007)(102836004)(26005)(256004)(11346002)(86362001)(446003)(76176011)(8936002)(486006)(476003)(386003)(52116002)(6636002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3444;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hPz82TaUbqAE+JLcnfn+uEBR9QYSAm3s22Peo+1YZ644WREFkN1ejhlcDU/JdDmmTUlIZOIm+osWQ0+qrWBKDp9Yxe6rQqZHg2obREbC2QgA2yCpcrAYoaGRLbK/rDxaGXpQFSLniu8s4ymM3ifSsN7lZAPRw/XSy6i8nIaUbxTvNhnd72Gpph497/k01fVN370XI8t+FFwEvBQmUye5FIJzCAGIULc2cLOeWuGb+CeoBjFMwFeqWVGNdI0g/RlI4cd+7RNlQdCoFwIWM9b8jAeDwUqEpOGp0J8zzyRxjnfBILb6mOGT0iUivGf1BFwidDy7qbbpPe4Qua2N2x4vyjs4ydoTu9Vj8cBz7fqRM76/0gHcm4fRpuXm/AQkVoZDhEc50u7VoQxzgh58l7EGIbeWGkLPf3lK4aFApwCCT3Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <042E7D0E8970BA48AB27B7DC0CA96B70@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750abaff-3eb0-4121-38f4-08d718b5c731
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2019 08:28:50.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3444
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 02:40:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Hi,
>
> Enable QUERY_LAG command over DEVX. That command was added to the mlx5_co=
re,
> but were not used and hence has wrong HW spec layout which is fixed in
> first patch. The second patch actually makes this command available for
> DEVX users.
>
> Thanks
>
> Mark Zhang (2):
>   net/mlx5: Fix mlx5_ifc_query_lag_out_bits
>   IB/mlx5: Support MLX5_CMD_OP_QUERY_LAG as a DEVX general command

Both patches are applied to mlx5-next.

Thanks,
