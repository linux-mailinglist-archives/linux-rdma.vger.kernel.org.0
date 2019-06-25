Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567E455025
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfFYNWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 09:22:40 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:54015
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbfFYNWk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 09:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd64fUJ+K7gMLHQTomaab8stTVPmoyBy23gNW9aKG5g=;
 b=GS7Vy7iOrdxDB9fr4KvVloAhQYmS7Iv/7NfpDLuIzVZWlrGJN22dYfKOLrudAVh84A7547vDHA/xnZ+ZsFXdSlWBi9qaUzllMeBLG7AWyJ5MLMACVwHLdZ8m4DwDOtL3by82YCwCeahi7bp0u3m1Zw37FLyLWAmiPB+UNj3qepU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4847.eurprd05.prod.outlook.com (20.177.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 13:22:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 13:22:36 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
Thread-Topic: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
Thread-Index: AQHVK1kNtWjiORJg2UGqRIUc3s7J+w==
Date:   Tue, 25 Jun 2019 13:22:36 +0000
Message-ID: <20190625132232.GA14438@mellanox.com>
References: <20190608092714.GE28890@mwanda>
In-Reply-To: <20190608092714.GE28890@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:203:69::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b3a78b2-a4ed-4527-51dd-08d6f9702ff2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4847;
x-ms-traffictypediagnostic: VI1PR05MB4847:
x-microsoft-antispam-prvs: <VI1PR05MB4847157DD07D066E5DA40618CFE30@VI1PR05MB4847.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(76176011)(71200400001)(71190400001)(66476007)(25786009)(476003)(2616005)(446003)(66066001)(3846002)(8676002)(14454004)(81156014)(81166006)(5660300002)(486006)(73956011)(66556008)(64756008)(66446008)(6116002)(316002)(99286004)(256004)(11346002)(36756003)(33656002)(66946007)(54906003)(1076003)(4744005)(305945005)(52116002)(6486002)(386003)(6916009)(4326008)(26005)(2906002)(86362001)(478600001)(6436002)(186003)(53936002)(229853002)(68736007)(6506007)(6512007)(7736002)(102836004)(8936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4847;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sZ2B5wWwBuls65X9YWxPHfChagoTu1izjm3KSS2UCRG6rHQHeWGr79XrTt3eO6B6RjAFS59pTWr3tLBQdqkmrxfGG0dZDTJ6lFz128EkuHNTekO4iiDiRsX3kKbFegxGlPXbIVbN+sxAP0fhjlcLw1Ft68HYeOmV5M3YkcJCvuDcuvbLHVqD9/7M2hL1tqh5+08wXtkONwK9l8bZsQ4RpGRV8ucnUrBP86E23XKvjN4SSauXlBa4DIQwuwH8GrDAjH3UjBx639Nxfd/AEf1zAw/zISowwAhEk116DIFtoejEUPgh3syIjAtNnenRgSbLw081fY7MU004R6Lyn6b7ALcjiHKmm/ObPhwoBOqB27HWatKQKlQOkkbXJJ9FgFE9OxugeRDd/DWjGm/shTuFxoG/SkMEpojSqeIfw/92W8M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6BDF49F39441B4A9917E94465014996@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a78b2-a4ed-4527-51dd-08d6f9702ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 13:22:36.0244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4847
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 12:27:14PM +0300, Dan Carpenter wrote:
> This function is supposed to return negative kernel error codes but here
> it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
> to IS_ERR() and since it's not an error pointer it leads to an Oops in
> hns_roce_v1_rsv_lp_qp()
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis.  Not tested.

Applied to for-next, thanks

Jason
