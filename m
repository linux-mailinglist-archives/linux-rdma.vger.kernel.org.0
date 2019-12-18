Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053BC123B78
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 01:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfLRAWX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 19:22:23 -0500
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:24293
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfLRAWX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Dec 2019 19:22:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hySS7TkC3Q2T3nEJtCK89nGE4dtheHFg7G6M6DO06cUyNH4nJKwRtSmkUgMZN/uippjFsALVa0ieJqUP1LSu10zU+be2d1VgFF+jWif99OogIdG00Qm2J7wfqk9JdTF478jSJLSBHLsjfTJ9quoLGsu5VxQoKQqSW2WYUce7DVStPoS+3oQDwhLs0HTlhWqOG1n6q6hdDHVe9AcADuBRUbOJ4QaJPUXz0O30wU+FU9yuI/+LOQg/8eVKnGwck5rl6r37AcawLGrGqUDRIsezBm3o0fY4u94/U8VKEvzpk0Ij1/6lO7HRVIs/u+8p2qUnXWCXsiUr5j6Zm+6NFcR3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LLuEBlfjGYDslFsqrugjQ8vIpCnNGeiRxMHE9ZZJKg=;
 b=T4RCD+E7A1eDHClPzYC4QwWh/pEfKZO1c3zi8Fgf5rh9yfKdM4xFpVrdH2MooqVsUS69n+4zA60hQ1s+1tmf0WxBMwGXPboys3lk7q2bbMio7iXXHPx0jRivXlCpyl3itsinmwsvJxMHnYeZRZ3Ned5YIgvs/4OCcsO2bY15hIACE1bMa+c7QbbxS0ZazyFrVaE9zVVVAkrdTAAXJwhS9SYZ4+0KMtTa4Os6blK/+n97YxLireaDAqc1zp1Vkp6g8f1gjrlqW3JWqNUyLlFZFHMAujgcq8PfEfNsB8DLxJqbfkjexkw8QGNl5i4pW9nhP1ty3wAJ4Cajh5AnNO9gOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LLuEBlfjGYDslFsqrugjQ8vIpCnNGeiRxMHE9ZZJKg=;
 b=j2TJTioLM3Us0aUCyZzBMP4XPryy23YpXQNa3PSvLFgS8WNa3aQpjFAmS+JkeKRiKVrSchDyj4X0e/jpqhBdMgLVFlfQdHfDhKp69CA+ckiJqtVC2DihLq8LFrPQOfx59QfxeyJ0iv4Nr9U3Y10XJJbT3844AOaQIFnoeBlJQ5U=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4526.eurprd05.prod.outlook.com (20.176.7.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 00:22:19 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 00:22:19 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v9 0/3] Proposed trace points for RDMA/core
Thread-Topic: [PATCH v9 0/3] Proposed trace points for RDMA/core
Thread-Index: AQHVtCkCpkkMdtEp20WJZMhNN3z0bae/ChIA
Date:   Wed, 18 Dec 2019 00:22:19 +0000
Message-ID: <20191218002214.GL16762@mellanox.com>
References: <20191216154924.21101.64860.stgit@manet.1015granger.net>
In-Reply-To: <20191216154924.21101.64860.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:207:3c::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e45235a1-0a0b-46b6-0d18-08d7835057cc
x-ms-traffictypediagnostic: VI1PR05MB4526:
x-microsoft-antispam-prvs: <VI1PR05MB45269EA07EAA151D13245FEACF530@VI1PR05MB4526.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(53754006)(189003)(2906002)(4326008)(8676002)(1076003)(558084003)(86362001)(6506007)(33656002)(26005)(66446008)(64756008)(186003)(52116002)(71200400001)(6512007)(36756003)(6486002)(8936002)(2616005)(316002)(478600001)(54906003)(81156014)(5660300002)(81166006)(66946007)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4526;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 68fOTfAnNDnDK1PfwdMqCT5vU2cjsfjt+sR3BtVxnSBeTima9uzr3pzssTbouRMMrsJCMs7ikX3knZjvKeFHNpJ5dFcff6aIGXqrYUEDNOlOcyJBAH+lUrFpIPp0aOK3akQuygv4AmS7DQ/fEU6JtkdlF1MiNdUgp2lppiOJp9wzd1ZLbegoXdoWYLqtlGK/B5LGrmK4+0gafnzXTJv2P5N2aATcENYXWfjrY+AVaYw/xjqJQSwc5IdDNe2HnQ4sgQPW3BmkgogkZPoES5plmyb7KWkHoXFxzJsUkFSuPjEQrQtM0TLIyuJXjEKztKuXa5a0sDQFfLs6Fpox7yPfVXkEJ/GjLbBhUISlMngUAwsViyPz49TYtzUzvBUkfkwQ9YB76wumt4Dk9zj606HcWQYfa39GW+lQn4f/30mwh4tXtKxjl2lXccQOPHVwjg7nBIvRu7dSpjtxxJ70O1/cjhIbs9KWWooDOT5Axt1fAJ2YZ4oRaf7jbWDY4x2+QFUP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <999D04209907164C8032FBEDF102AAF3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45235a1-0a0b-46b6-0d18-08d7835057cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 00:22:19.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+zQrfmnEEYWV5WtkJ+QrctBtFDjVjN8uk4Nzeyf8sDnwVMZ5WZTCEKgbrpmGYjHiqFhpabk3JBrxD1Fiu7mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4526
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 16, 2019 at 10:53:43AM -0500, Chuck Lever wrote:
> Hey y'all-
>=20
> Refresh of the RDMA/core trace point patches. Anything else needed
> before these are acceptable?

Can Leon compile and run it yet?

Jason
