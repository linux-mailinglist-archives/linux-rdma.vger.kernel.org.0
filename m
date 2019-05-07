Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1426164D5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEGNm0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:42:26 -0400
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:48526
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbfEGNm0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 09:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gyyz5BQNTyyXI7+stvzDR85t3HHvgd1esX5n3S26rlY=;
 b=sJEp4zAEBIQdc2/xsQKZ+Xl7ITNnRwgIr+ubWCe88iwP2GTHtLkJXCNilqkFeItmRS0Yo5aHJ9IKy7zKYbW0DkpZBS/FCbeM/09Lenma3uSY/D7YYaqlD0mDLqnUIBjzLP9kkX3gU7+qYbuYeX3aWt3KgIaXYbaNYimerpdxZ7A=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6256.eurprd05.prod.outlook.com (20.178.205.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 13:42:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:42:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: [PATCH 00/25 V4] Introduce new API for T10-PI offload
Thread-Topic: [PATCH 00/25 V4] Introduce new API for T10-PI offload
Thread-Index: AQHVBNo/qvTIRu6NOEydCCWllJ7Of6Zfq6qA
Date:   Tue, 7 May 2019 13:42:23 +0000
Message-ID: <20190507134217.GX6186@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::44) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1adc4286-e028-408e-63b5-08d6d2f1d570
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6256;
x-ms-traffictypediagnostic: VI1PR05MB6256:
x-microsoft-antispam-prvs: <VI1PR05MB6256B95D305ABB02CC8AE655CF310@VI1PR05MB6256.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(476003)(11346002)(14454004)(2616005)(486006)(316002)(256004)(14444005)(4326008)(478600001)(6246003)(71190400001)(8936002)(305945005)(107886003)(25786009)(6636002)(446003)(68736007)(2906002)(102836004)(66446008)(73956011)(66946007)(66476007)(66556008)(64756008)(6486002)(229853002)(71200400001)(36756003)(81156014)(81166006)(8676002)(66066001)(53936002)(6862004)(6506007)(386003)(54906003)(37006003)(3846002)(99286004)(5660300002)(76176011)(52116002)(6116002)(86362001)(33656002)(6436002)(7736002)(1076003)(186003)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6256;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GELeweQ/SIbGovqxJY+mKA+++/sFRqlCVNrMeUC6oSDMhZ3WjikRmX/2ecHTOZTczfxhuAARtioBSBEgv9YxkPpPTeyz3ioqV2BO71eqGGww7Kqq3zAOJ4E4I+mzS/yEmYxFjunXIQhVSphnZtSNp2AjznuVkAqjyyF26Gbf2BjnbKlw1V+em64X1+vMhAB+e59fEDxAeIOJgXMLuOTI0yGDnFt77/JPeOGenSd+4+eHEg/j2ckU8D8w+k40LM1WcWQYY6iIAQBuxknMLXiGvtTXUXt0avtpRtW0N2apkUV6Yd9i68mhVjiiNyeUoZmDTD0+FYQFdQjBwRJsKDgprCPfDGKmqhqS48DDUKc++pSnZmxeZ6v3X6sqDpQK/GUfFPd58Byrt7EEFLc7NHkBSFk6QX3/wAAbOwiot7zvxME=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8CFDD12D9CCCF64FAB1839DAF82B4417@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adc4286-e028-408e-63b5-08d6d2f1d570
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:42:23.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6256
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:38:14PM +0300, Max Gurtovoy wrote:
> Israel Rukshin (12):
>   RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity
>     API
>   IB/iser: Refactor iscsi_iser_check_protection function
>   IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
>   IB/iser: Unwind WR union at iser_tx_desc
>   IB/iser: Remove unused sig_attrs argument
>   IB/isert: Remove unused sig_attrs argument
>   RDMA/core: Add an integrity MR pool support
>   RDMA/rw: Fix doc typo
>   RDMA/rw: Print the correct number of sig MRs
>   RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
>   RDMA/core: Remove unused IB_WR_REG_SIG_MR code
>   RDMA/mlx5: Improve PI handover performance
>=20
> Max Gurtovoy (13):
>   RDMA/core: Introduce new header file for signature operations
>   RDMA/core: Save the MR type in the ib_mr structure
>   RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
>   RDMA/core: Add signature attrs element for ib_mr structure
>   RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
>     mlx5_ib_alloc_mr_integrity
>   RDMA/mlx5: Add attr for max number page list length for PI operation
>   RDMA/mlx5: Pass UMR segment flags instead of boolean
>   RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
>   RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work
>     request
>   RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
>   RDMA/core: Validate signature handover device cap
>   RDMA/rw: Add info regarding SG count failure
>   RDMA/mlx5: Use PA mapping for PI handover

Max this is really too many patches now, can you please split this
up.=20

Can several patches be applied right now as bug fixes like:

   RDMA/rw: Fix doc typo
   RDMA/rw: Print the correct number of sig MRs
   RDMA/core: Remove unused IB_WR_REG_SIG_MR code
   RDMA/rw: Add info regarding SG count failure

??

Thanks,
Jason
