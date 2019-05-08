Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E717B8B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfEHObu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 10:31:50 -0400
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:53487
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbfEHObu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 10:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bypMe+H7Hoqi6B5lRccPfqOwGEvfkFq8k6DvXn2tRNc=;
 b=EHl4pOxjaYHDWpuTZ4M6jId0RAbLzxNDcAxAvT5vBVn6uv9GtXy93vnZAsj0P3Un2VvbqUySv04Vt1H14o+EH6TFlcDBlXM1B2nKuG5cmB3r0zgcTuoMcwP1rh8UkANKjGl3ZS7aBWTEK2boab0Ikw1Edj2Dlknp/5E7lN3wW1Y=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6110.eurprd05.prod.outlook.com (20.178.204.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 14:31:44 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 14:31:44 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Topic: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Index: AQHVBJQ03rON3H5UMUmK3O/KPKwCrqZfnnCAgABUfYCAAVligA==
Date:   Wed, 8 May 2019 14:31:44 +0000
Message-ID: <20190508143133.GG32297@mellanox.com>
References: <20190507051537.2161-1-aditr@vmware.com>
 <20190507125259.GT6186@mellanox.com>
 <266697af-bf5e-07a1-489e-fed7cf8c695a@vmware.com>
In-Reply-To: <266697af-bf5e-07a1-489e-fed7cf8c695a@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a548ddd6-a549-41bd-a090-08d6d3c1e4e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6110;
x-ms-traffictypediagnostic: VI1PR05MB6110:
x-microsoft-antispam-prvs: <VI1PR05MB611065122296D90C395E205CCF320@VI1PR05MB6110.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(53936002)(66066001)(102836004)(6436002)(2616005)(68736007)(54906003)(73956011)(316002)(6246003)(386003)(6506007)(6916009)(14454004)(478600001)(25786009)(8936002)(81166006)(8676002)(486006)(446003)(11346002)(33656002)(476003)(81156014)(186003)(6512007)(26005)(36756003)(3846002)(6116002)(71200400001)(71190400001)(66446008)(256004)(64756008)(66556008)(76176011)(66946007)(66476007)(229853002)(6486002)(86362001)(1076003)(99286004)(7736002)(305945005)(5660300002)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6110;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AqzXanHx8+4DHQDcuenDX9wQJdYIGXc1wwdRIrQ4WKv0wpigqkLlyUU83sxcvaIv3+tZ1nRYOIJsL3fqemBTsPIQaEDIguAxRqPW6xKubLnCO5hDzPfxUCGdwbVkcTTLlbo8qZpp24R1qAecgbhbVwZAttVe+jx6uNqYlrjKwBrCa1jr8aDUh41IpdqnLVzB7/cfCtN7PkZXpwcdkuD8WlIejsEhcM0RgoTP+6ALl/tarHqg3SoTxvpgtnXTm0l/rQiQJPVHlLxMCVDTSKt7Ffkzlpvs94z4KGCGnK8ZohqKfG7CwBeT2L/uJKE0Rx1VPH3/DJSVy19lEsWlLoLKiaXeIfuE19vddMKE+a1htfxucxt/2Z321AVZEdHfcTGjNdynWulB3iEkYO1Uf0TGDiIRCQwSA78+J11n2/y9R94=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7BA47DEEF940C429AD77CB4A7C31EDD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a548ddd6-a549-41bd-a090-08d6d3c1e4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 14:31:44.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6110
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 05:55:25PM +0000, Adit Ranadive wrote:
> >>  // Configuration defaults
> >> =20
> >>  #define IBACM_SERVER_MODE_UNIX 0
> >> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> >> index 1766b9f52d31..2cab86184e32 100644
> >> +++ b/libibverbs/verbs.c
> >> @@ -967,7 +967,6 @@ static inline int create_peer_from_gid(int family,=
 void *raw_gid,
> >>  	return 0;
> >>  }
> >> =20
> >> -#define NEIGH_GET_DEFAULT_TIMEOUT_MS 3000
> >>  int ibv_resolve_eth_l2_from_gid(struct ibv_context *context,
> >>  				struct ibv_ah_attr *attr,
> >>  				uint8_t eth_mac[ETHERNET_LL_SIZE],
> >=20
> > Really compile time configurations are not so useful, what is the use
> > case here?=20
> >=20
>=20
> In the general sense I agree with you. Pre-built RPMs may not have this
> set to anything other than the default value.=20
> However, in our internal testing we've seen timeouts when trying to
> resolve the DMAC when creating an AH. Instead, of simply increasing
> the #define value here I thought it would be mildly helpful to expose=20
> this out.
>=20
> If this is not going to be useful I can drop it but I thought it would=20
> atleast make rdma-core a bit more configurable..

Stuff like this should not be configured.. if you are hitting timeout
it sounds like a bug of some sort to me.

Jason
