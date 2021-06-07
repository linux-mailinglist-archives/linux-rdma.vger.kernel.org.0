Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4720539DD9A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGNbw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 09:31:52 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:39188
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230177AbhFGNbv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 09:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ4DHZgfa1lrnGl14jBix6GN2QyW7tfjNWOs/Sin/b+VFiFHhU4uYok7SLqoRNog/RsUzcBoYX4suG9cM2DBKYVx1LcfCFd2nU9SHlA7XQgO+yJjKhL8H0O3xYZ9oY2mHjbWL/ZsLxEfeMpBZnasMLLXQdlf5XBE2LqiUvfZw9OU9RwevYc9ebALH8LUsngcy2Tn+7TDaWD7rml9vmL02eVJv3LvgHIS4KHmSirAIzp/8B3wcKd0kTNbdI9Uir6ecIVpJeyLzIGZnBa5/e9qRx+Z6kvg8FAWavEJSkOIpTTmK0QIKRaT4rLUPqF+DvhMG4NpG2beMcslSnDwLpD0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOHeeB0yY8Vu6Q/GObAJe7mirW8YqQOUX5YUM/Ifvq8=;
 b=VSgW7CussRhvIpZIjg1TE1eeTryYvID9f+nBfTjqfP5Qg+HCoxWtszh5cqWPvakLc0qilYw+bfcc76PxnwYy+g0WXIhtxnTsIXyugppPvy14vg70kw5ii5rdP/jVpSeMb0Mqwm/vEH7eUjm2h3ohJ9TuQib3Y3QQ9Oudy8/H8BpHR3ctQE8qhuqaDW35xEAAwdW5tITJF76icL7AdBGhTQrUPFEQKiIrhnAqc5q9fKIy02e68syxb6pemrtdhvWh1gulmYmiDI32URAR/MjB+KtOvjVXo+xNKk+oarjaOYcKsaemJXJADtSlbPIukrf+ZG2hwLDFilBjMR1mFgzLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOHeeB0yY8Vu6Q/GObAJe7mirW8YqQOUX5YUM/Ifvq8=;
 b=BurDxBNbcHt2Q9BVfJU2claTHqtYvUzc9SJdfZPXP7V5qCmhPYRrs8+tJj1p7w/x3tFncnYihiayFPFt+xgweRtpYkvWEfKfxLBkEq3B0BGy5RaywNBr9mD8Ec5slN3iEm8tVMgmr251NVEjsMGGTRw9A5UPqWMYlpH+6b61J4/NlySo+2pOiP8qBuCl7ziO/Vj6mOswOolqnkzskz0XLylLXCiZq+1Ey36UtFo2IzO9JQ3+KdLHhQuiRLE+k/MnvAa7R+hVVOikVtzmJxgDAH3s+dxCGNXnzujWEX7eZgtUP7xYqv7lHt4GOv+YTjIQOqZ4PGGTcqDqqq8JAWA3ZA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 13:29:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 13:29:58 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: RE: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be
 used with namespaces
Thread-Topic: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be
 used with namespaces
Thread-Index: AQHXW3XTgmUrShoLP0aSfA0ttnjNH6sIiqTA
Date:   Mon, 7 Jun 2021 13:29:58 +0000
Message-ID: <PH0PR12MB5481C3DE73C097E938B4E5D1DC389@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
In-Reply-To: <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.218.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f273cb05-4e94-4352-e562-08d929b85868
x-ms-traffictypediagnostic: PH0PR12MB5450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB545053E293DAA6B3234867DFDC389@PH0PR12MB5450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5WuCjxhYh6DXCA4PXlcDNW+5zogulLSR6xI4g7LQWnXizMFoAsj6QYHXJkolupsUlY5zRuGQHsm9ItqGL1+CVVFnt5mOlu23P+fr9UT7OAcdDv7VBFiK7LDVgioiBbnAfGNiP3/D8Fp3CvQ8hGJUEiiTNo0Msvtrz+5btGozMApEhq70nGwgzTLUJW0oDl2hoFVfBdm3cuCrdDu5lKdguS8dxFCS0YlaZkWFGjFxx4YaTcxqnI0g87i4jYoHb+6mCsTXxud0eRwIZIpokT2OTuDcq3I9ahDpO4LWaTQUb3BupfnVLU0282mS7fROeLJX91ZYZVJdZq1nn66aZbUrdyGadfxTs7Y1S3QJpNwo9GDTig8at5ZOW5kc+/4IgBdTWENssW3gllkXScc85C0LxxUEBjR/vsfzaa38U+E9kA9WWVfAhWBSCcUF7m0Ggye8UR0bKgNJ13A5MrYZo/BsfjZPB6Gtm5BT7e75/Z+xUxkOzf+vz9lz1WY+7mGiO0zGcRb/PpMpnH1YiIP+h/dqlLgrdUShMLR1ScJngIzWyq4n+aNJTSZj4NKG9ESJ/yySDC1XzCNlO/po2ifIYwcEXo2WZ4tui13gsk6+qilJr4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(4326008)(5660300002)(55016002)(6636002)(54906003)(110136005)(7696005)(52536014)(6506007)(316002)(2906002)(83380400001)(7416002)(71200400001)(9686003)(86362001)(26005)(186003)(122000001)(33656002)(8676002)(66946007)(8936002)(478600001)(38100700002)(66556008)(66446008)(66476007)(76116006)(64756008)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pn1yZUeOj0SUA72s1TFJYYSBI3mEmwslXqhI8mi4X5n22CkTfEGHFd9mL5PW?=
 =?us-ascii?Q?FUkCt3qlBang+n4AohUiFA5mWdgRvymabJm1SvJcsilLmiuMolX7hGhn3Xsm?=
 =?us-ascii?Q?8M5n6XeFkb11aMbxnOCXiLbqM/qn3a8FGjpE5s1HDewJOYpK3Ny9GeD6Bxwl?=
 =?us-ascii?Q?/X82MivEvxlk3dmj6L4czPh5kkC/TgG9FPo07wShhHmEqhi29/0z74BGt4hZ?=
 =?us-ascii?Q?LsXWbCCFoh7VOEgsGUhX/EXb+OLkx669RfaCh+al6+9bU2+gznJMXGySeDXR?=
 =?us-ascii?Q?M5DcbjQVyXdZXEU/V9A6oJNMqcdqt7F7ITpuwubhUOykWjKQkvBC5N/4HQoP?=
 =?us-ascii?Q?jIUQywRv1Ihx+fvPGFsdK4BpTBPGYPwLSv6474j0TVV4phGAk5wb0F3CLNBh?=
 =?us-ascii?Q?046U/pHnqnEbyzbLxeRsFcsW3MlmdNPiyvPK6RPFGtbzY2cE8ntgLfhvi4vn?=
 =?us-ascii?Q?TW0hZzkDi+0ZbfI9CNen79zTjLIUHQFs5I6jChpSjPQOUq5diB/h5pM3uvy4?=
 =?us-ascii?Q?KwOUGcHPgB2q+f519nqqdFsrCq+DYqT+OTlHxn3Lb/PeavkmCuSR+XMQ1K+a?=
 =?us-ascii?Q?mJIRhwaxBG/TsLt5JvFQcsUQ9obaE0eC01aRo1h9RZLb1hwkvf0/nkmpumK9?=
 =?us-ascii?Q?Gshzl+L+hri91LRXS8KRDWJkKRAwJuiwFi1j+u4OqVeoC41xdxmitScXG175?=
 =?us-ascii?Q?QpIDHFFQ4ojF0/vWYmqhfWTKwqPo1CVUW5qBcPkYIN/zZ47u8uao0HJfRw4t?=
 =?us-ascii?Q?FWUtfxPFD+jaUVrw5L9pZ8f26eQ7BtnJP5YLxcpadEhHYyMaqn3tGBiBb9Nc?=
 =?us-ascii?Q?XZzkuJwS5RT9/DFobUgv2GADfW8uH64Vm/TY4ZjHpV20PoSThUAlzaxN0Y4Z?=
 =?us-ascii?Q?ZRZG0s32HAUajOwt1U0WTyqjrrL6/s1l9sr68WHjo1ofmtVX/EJU3MIDbpfU?=
 =?us-ascii?Q?MWsmc0t0oexjdNnmjIHYTKrZN2J130oVFRz+cbTyx0A+kT3nNRLYnTt9bSoT?=
 =?us-ascii?Q?DSC2R+UYgJyToKUIPjFWhYdScVonSBsCruLuuYiAwdBBSEGuvvKJ95d80mCU?=
 =?us-ascii?Q?84H+hGAsOuUIC723f1pQQv/P+SutpWG0PzkkS/6x7vl8b0GCGso2VW4ZeNx2?=
 =?us-ascii?Q?LmR/IIVroKWkbil3oi2+B2OXUHcO5Kze686UX5nMwJg0+9PIBrubjIYfUyyG?=
 =?us-ascii?Q?COYxppi9OCWnZp7CHqfSCk2+Jy2cqq4CEBk7F/g+7mi8wdkrPkS01GKyIBK/?=
 =?us-ascii?Q?xz362A1kHfbEuCmEevpxvNkOUzWsqVFGp9Lcobj4ybTnk6Coa4/L7m/GzX/p?=
 =?us-ascii?Q?UKLqlt2v3vbv685sYgZ9futj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f273cb05-4e94-4352-e562-08d929b85868
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 13:29:58.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njFbctC6g1YJFqVoKAwPlCFrJICxTnRfCAHt2wJcT2zJgEGWv34oCYd1b09H694iBb0BY5q4BFthDFDsNJeF6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, June 7, 2021 1:48 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Now that the port_groups data is being destroyed and managed by the core
> code this restriction is no longer needed. All the ib_port_attrs are comp=
atible
> with the core's sysfs lifecycle.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/device.c | 10 ++++------
> drivers/infiniband/core/sysfs.c  | 17 ++++++-----------
>  2 files changed, 10 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index 2cbd77933ea5..92f224a97481 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1698,13 +1698,11 @@ int ib_device_set_netns_put(struct sk_buff
> *skb,
>  	}
>=20
>  	/*
> -	 * Currently supported only for those providers which support
> -	 * disassociation and don't do port specific sysfs init. Once a
> -	 * port_cleanup infrastructure is implemented, this limitation will be
> -	 * removed.
> +	 * All the ib_clients, including uverbs, are reset when the namespace
> is
> +	 * changed and this cannot be blocked waiting for userspace to do
> +	 * something, so disassociation is mandatory.
>  	 */
> -	if (!dev->ops.disassociate_ucontext || dev->ops.port_groups ||
> -	    ib_devices_shared_netns) {
> +	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
>  		ret =3D -EOPNOTSUPP;
>  		goto ns_err;
>  	}
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sy=
sfs.c
> index 09a2e1066df0..f42034fcf3d9 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1236,11 +1236,9 @@ static struct ib_port *setup_port(struct
> ib_core_device *coredev, int port_num,
>  	ret =3D sysfs_create_groups(&p->kobj, p->groups_list);
>  	if (ret)
>  		goto err_del;
> -	if (is_full_dev) {
> -		ret =3D sysfs_create_groups(&p->kobj, device-
> >ops.port_groups);
> -		if (ret)
> -			goto err_groups;
> -	}
> +	ret =3D sysfs_create_groups(&p->kobj, device->ops.port_groups);
> +	if (ret)
> +		goto err_groups;
>=20
This will expose counters in all net namespaces in shared mode (default cas=
e).
Application running in one net namespace will be able to monitor counters o=
f other net namespace.
This should be avoided.
