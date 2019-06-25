Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115C7555F0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 19:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfFYRbw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 13:31:52 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:13703
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727652AbfFYRbw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 13:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzULloRbj8zMd3G7TVi+k3daP21BFZV2Jng2lpwPQ+I=;
 b=eVHKbcex8ahxJX6OMNMe8haqr4ZcAf5izrdrxovl7pIoj/FE/ak7Sif7Q+utkqmLH9VVClHvUFFWY1eBNbZQpu/LvxmDt+YJE2NZ3Qh/Ed3PPpRSRckkJeGZhbviTZJ9a7CwjQ8OdtPP1JpQtBfIMtnPGj6acEv3wz4SMEOqHew=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4829.eurprd05.prod.outlook.com (20.177.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 17:31:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 17:31:48 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
Thread-Topic: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
Thread-Index: AQHVK3vdFO1ecOcGo0ymGtnUdjnt0g==
Date:   Tue, 25 Jun 2019 17:31:48 +0000
Message-ID: <20190625173144.GA27947@mellanox.com>
References: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0049.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9ef2ba0-5698-468f-03fe-08d6f9930047
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4829;
x-ms-traffictypediagnostic: VI1PR05MB4829:
x-microsoft-antispam-prvs: <VI1PR05MB48297917AE190E02668387BFCFE30@VI1PR05MB4829.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(54534003)(6506007)(66946007)(386003)(11346002)(4744005)(73956011)(81156014)(6486002)(5660300002)(1076003)(8676002)(66446008)(52116002)(76176011)(14444005)(66556008)(81166006)(316002)(99286004)(36756003)(7736002)(64756008)(256004)(102836004)(33656002)(66476007)(186003)(14454004)(6916009)(86362001)(6246003)(8936002)(26005)(2906002)(25786009)(54906003)(66066001)(305945005)(6436002)(229853002)(6512007)(53936002)(71190400001)(486006)(476003)(71200400001)(68736007)(478600001)(446003)(2616005)(4326008)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4829;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9lq+qiSYSU0gS8dH06p4WGXzIiiyJP2PieNunY76qY6UgSOtNLpH3dql2hmE9vhUkzPqEC24u4H0uMWgcCFYLCT8h2oXZ9HF6wd9vduSdCGneboUf2v9gBpUV1LSKfiGuWiWzVSByon0Aoy7J7gwlG0kXPuJPWfWEb82ufjF5w1ZZbSr03MLayD+ePEZXowRW7UqYReK8yL/5J3u4H+M+O0YYqixEIzw0jI+HXxSUOiCCmNRRnpSMbb9xhGuoNdVIlIR7fdhf8cO9eZfCq3xcd1D5wXsP57kXPEG/Gx7ddWE/dSH9pt11TPZg93gW9vGXNzGu3i9K2GFpuTKUcW3Kts3XaDBOBWlTH+zau5mZGroydf6WSDtLPT/+XjSZk7viOZX63lEo4lwTmgAPzI1gcSQ7MAYNgS5q1BlUnejge8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FBF9663961DC1438BD70D8D84B9D689@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef2ba0-5698-468f-03fe-08d6f9930047
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 17:31:48.3004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4829
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 14, 2019 at 12:25:28PM -0400, Dennis Dalessandro wrote:
> This is really a resubmit of some code clean up we floated a while back. =
The
> main goal here is to clean up some of the stuff which should be in the ua=
pi
> directory vs in in the driver directory. Then to break the single lock fo=
r=20
> recv wqe processing.
>=20
> The accompanying user bits should already be in a PR on GitHub.
>=20
> Change log documented below each commit message.

The conflicts with other hfi patches are too big for me, please respin
this on wip/for-testing and resend.

Thanks,
Jason
