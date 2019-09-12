Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C3B0FE1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbfILN1z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:27:55 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:31556
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732098AbfILN1z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6lxed9RrO/nbox6hzyXw95jUUco9gCy5R6LDB39WymzajWYtRTJ/E8nqY/T+puxbSj1xQHfzLD/hRDfI1B2oZ12b6s7j8ix5C7LHOzjYtAnLpSqDphhGTUBPIpXdZF7vuxSVSbLyEwAM7qU37r5J49Xf1fUBPK7p1NDWnMPYKVjHiyDGbtRyd/cgr4nSuViKP7F3GDfYNh2Xwbu+jhbPTkpidvdapBt7BcQCTVkeSiB7PD+MS0Mi2NkhYNfFvKcF4fOy1pJhN/butuOh1UUcLwsBje9CN/wUcnTtOyifN2h+D59UiwPrscbJNlB5M4xuNE4dOsAxoFuv5pYw0xGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s257Vw00RnfE9gcYIL650VzcMvcpzYnG0ScjUYPm+6w=;
 b=CiRnDr30POz1NI9+vIP1RCDaIvj0V2SDZBzxoj1pM3C5GZRkz+l9FxgyL062vfgjhV1C2CTpc42u8P7x5QdAWAsFVdRQwgDVW+02vaCROInqNP2Vir3YGOi0GqUp10WyfiZgyA6zbHnqVA4ulyRWC8qPiCe8Dw7/BWr0/1QsPT9b0F3CCrqsbN8g5hQyd3TW9UDsvTHUwHuK58mjWPUZyv5iokQKw7p8vmLNai55AsKhXegJPx3QEd5Im7lTB0zBN78FCum64AwH9TQtV6GQ6AOF06vnlcFbBn8/R2Yb/gL2A+sgGFzao7DSsDACkgqeIczLTOVYApGLc88pHetiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s257Vw00RnfE9gcYIL650VzcMvcpzYnG0ScjUYPm+6w=;
 b=J78oq8INaKk15bGYJYINFJGziJ/DD35mTccQsmE2ZXzot+1v3SwJBPkf18v3hpjCX1OkVPVEAJfl674n8Fo2u/ykBgwM5geg2a+sSIErrSp+rwtEDk/Wgc0RUMNHnFbA5uaShPwHZXHVCg2QoUF+Rc83w/TQ0FAMeOxQflXZdYY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6221.eurprd05.prod.outlook.com (20.178.124.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 13:27:49 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:27:48 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Guoqing Jiang <jgq516@gmail.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Subject: Re: [PATCH] Documentation/infiniband: update name of some functions
Thread-Topic: [PATCH] Documentation/infiniband: update name of some functions
Thread-Index: AQHVaW3eLSNUNVfCF0eZv3kFeVdELw==
Date:   Thu, 12 Sep 2019 13:27:48 +0000
Message-ID: <20190912132734.GA18726@mellanox.com>
References: <20190903124519.28318-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20190903124519.28318-1-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR0401CA0084.namprd04.prod.outlook.com
 (2603:10b6:4:75::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d0d3ce7-42b7-4cfc-3d52-08d737850133
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6221;
x-ms-traffictypediagnostic: VI1PR05MB6221:
x-microsoft-antispam-prvs: <VI1PR05MB62218A584AA918D9FA6C4957CFB00@VI1PR05MB6221.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(386003)(66556008)(66476007)(64756008)(66946007)(6506007)(476003)(26005)(6916009)(66446008)(99286004)(66066001)(102836004)(52116002)(14444005)(76176011)(71190400001)(256004)(54906003)(71200400001)(2616005)(446003)(11346002)(316002)(1411001)(4744005)(1076003)(5660300002)(86362001)(305945005)(486006)(36756003)(33656002)(186003)(7736002)(8676002)(3846002)(478600001)(6116002)(6486002)(25786009)(81156014)(81166006)(14454004)(53936002)(229853002)(6512007)(2906002)(15650500001)(6436002)(4326008)(8936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6221;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KZPhr6JCxPiVmQ8JTWCHc7Kx13baxCtNzHJgi5/cq0DgyndRaE7d59TNE0SiguTu9ElvGNZVCJON4UovM6Qy5PlnkaA1TnqOiQc09gFGcftLesFZbQHqUZ/f2Yujl+1j6waVGX+Qp7pDkpBlSdSAscjBdNal/AMYUoduA1d5unwTm0vPXUae2V/U8NwmRBi2D7PSoOgitOdHXgQX2R77BjJXRocb3FX2Gkrheu47id+J6vIE9p5zDdRg20VYU+VG4a+YjCuo5alKGZRI0ebcTOTh+lY+1VvBUkqVJ3stGO2AQfdJ08IzxocS1LSXIu0Az5q7PwPBilKbj5SEs8Ns7apGvpLFzjNDmhV+pzlRdK2H6kHxDq2GPensgcjikOtU+N+zNsnQJ/bUejh4c59vGzdgIA4hhBntx0fCaboB6Kg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF68976BE2F0FC4D9013C9E523BCF3CE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0d3ce7-42b7-4cfc-3d52-08d737850133
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:27:48.8246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxVWQoMZhcjvLVuMpMS3ph0+JHkYb6HmE37WdovMOqUfMVgsAbsrkNiBb8EHKX9pV9XvlaArIPrlVF17OM5K+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6221
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 03, 2019 at 02:45:19PM +0200, Guoqing Jiang wrote:
> Update the document since those functions had been renamed in below.
>=20
> commit 0a18cfe4f6d7d ("IB/core: Rename ib_create_ah to rdma_create_ah")
> commit 67b985b6c7553 ("IB/core: Rename ib_modify_ah to rdma_modify_ah")
> commit bfbfd661c9ea2 ("IB/core: Rename ib_query_ah to rdma_query_ah")
> commit 365231593409f ("IB/core: Rename ib_destroy_ah to rdma_destroy_ah")
>=20
> Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  Documentation/infiniband/core_locking.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
