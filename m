Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF7A03C2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1NxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 09:53:18 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:2877
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfH1NxR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 09:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFnXwdSXGm6q8jFHribJI1Rzr9tqo4FXsyv/Ukv5YSgck4YO6oAEDSy24J0QEl0MTdhXQWmvHMK0xCtkU5riwM8aALji3znPWr/brcmf2xH7mrGZccML3rxj9+vtSKJ8sFIljMxvgsC2De5AIBW9AhhjpshIGwfdFkgBqjUN/DUMtJacQE3YOW/EwKXIaUX/9MCQYPUhGVrs59IdH0nvcs9nyDiQSmly7AH395Pnp+mw7jnE8IRsOruPvylXujuDptAgbmprIkeC7H2ljd5KxUX6wVBjjmuEw4IYVHS72zaGQeVcDGSrI+UttO3YO9ohAC9NjI3sRdFGpsaZcu17UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbX1BM+IyVhg1I7J9XYA2aKzXxw/bWf7aUAtjk4rxo4=;
 b=VbROHUN4yTQKhEyuQhDP/wj7gqsTGJhvIvBldq1y5rOh49xA1cJL7oYK6qhixvlnxyDvEhKJ8wp2YUqIJvkZO/hQOzUKFco+fxq7p6ZiHKRmK51Iq6Au2hWIW8bqZ/pJU7+Eft94rm8XLJUW+Ec2RTyXhSbCZ1OTHgFp3GLdvv+j5tyG1XrvbJeG1uPVGT/q2yAtjVGiQdI5rq/waUNGMJVw/r/+vPps3WOHIalJf80tWRG0fePzhJLwkKJh4FOqN4qY34N+1N88wfc+/V+hGmg+VcDtv2EgchNRHNr4XfBBzwyG/Bnx/mXGkqRv/KSyuuobmi1OlFkqp67ByRNLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbX1BM+IyVhg1I7J9XYA2aKzXxw/bWf7aUAtjk4rxo4=;
 b=HwNGdyisn02sCYuEqhtSpQZgkulviFa9Tcggg6Ucp7rOExkFECN8j2FyvvdAS0OyrH98mt5hXqvw1j8h6BiByoR3iG7fY2VXnwnLiePwnU6nYCj+Y4VjiOfqsVepK1Bw9fnsPZJz1NYYmRMJ1SB5p07AfjTMuo13KVzRdwch9E0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6045.eurprd05.prod.outlook.com (20.178.204.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Wed, 28 Aug 2019 13:53:12 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 13:53:12 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "oulijun@huawei.com" <oulijun@huawei.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "srabinov7@gmail.com" <srabinov7@gmail.com>,
        "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 5/5] RDMA/nldev: ib_pd can be pointed by multiple
 ib_ucontext
Thread-Topic: [PATCH v1 5/5] RDMA/nldev: ib_pd can be pointed by multiple
 ib_ucontext
Thread-Index: AQHVXYFEn/7D2acVzkGMw1QsYEJ+MqcQlNSA
Date:   Wed, 28 Aug 2019 13:53:12 +0000
Message-ID: <20190828135307.GH914@mellanox.com>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-6-yuval.shaia@oracle.com>
In-Reply-To: <20190828091533.3129-6-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee1d2438-5e7e-4f4d-ae32-08d72bbf1133
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6045;
x-ms-traffictypediagnostic: VI1PR05MB6045:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB60459693650BBB8A9F130ABFCFA30@VI1PR05MB6045.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(8936002)(446003)(478600001)(6512007)(2906002)(229853002)(54906003)(11346002)(316002)(71190400001)(52116002)(4744005)(71200400001)(2616005)(6246003)(81156014)(102836004)(476003)(7736002)(6916009)(3846002)(256004)(81166006)(36756003)(186003)(386003)(99286004)(76176011)(6506007)(26005)(305945005)(66556008)(25786009)(1076003)(4326008)(8676002)(66946007)(7416002)(5660300002)(33656002)(6116002)(66476007)(64756008)(6436002)(486006)(6486002)(66066001)(86362001)(53936002)(66446008)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6045;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sc5btlhLB5I4Azyqrw7ulY0MzXH+N2VDMUVV5V34lGifmZTpY82utr/+2IVo/c3WH5wtI3ZTsav5q4Ew9pKWX7TFYTcH9J8/oudSSPMh4BIbXlkqmkeid8Ig9hcLgmFT/BpKanRrgLjcotWhf9+Bf6Gi/2UdJ1pJ4dBSRlJUMxhku4E4BOOnpgAkTejvY7JZJkOOhUUU9TO279cb34D9UmTsuFrubyMZyLxGb7j227gHBm4zqiUCqsSWlkUESLWVI2Oq4JA19+vfLD8VdRrCA91oImVwNZ8y9+o99puGpRQvJUuuqXn3kYeiYUgIoH8h6/mhozSCpdUuVyinvmAblyEe1bC2j1woo9P36VrjByHYUImiyo3CKnPm2d4yQis8JRIIXz8nrC77YAj9N68eqemu/Jo1erysiFI4KCmBo1E=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A21518F4F0EC74ABB1049D5F62FF112@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1d2438-5e7e-4f4d-ae32-08d72bbf1133
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 13:53:12.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWGNv3BnEIhMatPc8pStRF9btd5oK+pCgnTMvxzmQ1bBgqQNrHnLvqXRn23Sx1ND8ahdIik/lhqs+uIH8YXuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 12:15:33PM +0300, Yuval Shaia wrote:
>  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin=
,
>  			     struct rdma_restrack_entry *res, uint32_t port)
>  {
>  	struct ib_pd *pd =3D container_of(res, struct ib_pd, res);
>  	struct ib_device *dev =3D pd->device;
> +	struct nlattr *table_attr =3D NULL;
> +	struct nlattr *entry_attr =3D NULL;
> +	struct context_id *ctx_id;
> +	struct context_id *tmp;
> +	LIST_HEAD(pd_context_ids);
> +	int ctx_count =3D 0;
> =20
>  	if (has_cap_net_admin) {
>  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, b=
ool has_cap_net_admin,
>  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
>  		goto err;
> =20
> -	if (!rdma_is_kernel_res(res) &&
> -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> -			pd->uobject->context->res.id))
> -		goto err;

How do earlier patches compile?

Jason
