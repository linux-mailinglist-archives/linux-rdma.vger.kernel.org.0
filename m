Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B79DE23
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 10:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfD2Ikm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 04:40:42 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:2742
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727669AbfD2Ikl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 04:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbEAUzLwetTsFIWonlfRbbR5y2mgGjoJEavXtQj4LD8=;
 b=Q7kpApKT1Z7pd0YQgjC68vWkHS4SW3c4ES8Wckon6WaqS21LifwVaPAAemrZjhP+QfBJaZzy6hzoai3YNibXsVgE37uCclkDI6FmIvjjki0hZjJTtlOXflP+ij9wz/I9ADxwl9NfJo5y1knHqKDEhYouTKAhtSaEw3kkkuSt4E4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6542.eurprd05.prod.outlook.com (20.179.27.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Mon, 29 Apr 2019 08:40:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 08:40:37 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Doug Ledford <dledford@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHU/bjRDQW4dOHvME6ENVPTZDYrA6ZSqNmAgAAqHAA=
Date:   Mon, 29 Apr 2019 08:40:37 +0000
Message-ID: <20190429084030.GA4275@mellanox.com>
References: <20190428115207.GA11924@ziepe.ca> <20190429060947.GB3665@osiris>
In-Reply-To: <20190429060947.GB3665@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.114.94.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4f6bca-093a-4789-cb74-08d6cc7e5a23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6542;
x-ms-traffictypediagnostic: VI1PR05MB6542:
x-microsoft-antispam-prvs: <VI1PR05MB6542BE5E958D29C346796662CF390@VI1PR05MB6542.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(25786009)(386003)(478600001)(7736002)(53936002)(36756003)(102836004)(99286004)(186003)(6506007)(26005)(11346002)(33656002)(446003)(2616005)(6436002)(476003)(4326008)(14454004)(52116002)(6246003)(305945005)(5660300002)(76176011)(486006)(66066001)(6512007)(71190400001)(6116002)(68736007)(71200400001)(2906002)(3846002)(110136005)(6486002)(54906003)(316002)(1076003)(97736004)(229853002)(66446008)(81156014)(66476007)(64756008)(66556008)(73956011)(66946007)(8936002)(8676002)(81166006)(256004)(86362001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6542;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ArqG0BnGywa8siasxGSbCTHrqpGWIPLch8bStkWxc0JrlCUq57cyqHV7kNzMeR0zXGy+vA9MreKUJHMEPKT2bsMK67YqUbs3vL9fUFqJpICnqx5JGcivzpThrv5zgLQKUwUX84239R5W6cghq/dPS0slvbqZavuI7wYQrKeHlv5bIU3XhQNBkQy9/Jgy06qCvT7OH5NbJ3tEMo195xemRug4SNOSFca5mB1mArqo6H0CsjmVJjEf4WzfR9hOE83ShFF65ofTNcSY6jkxtcHe1pWnoFHcHGBZjmdPRlsTg8NXrxwJBKwSmI2VPF5f5916adLEg9UcuMWYYmIfi/Nu4/Z/7kdUGvjjDwayLoF3B3fCuD601enkBET6TvG7fX2Tf3QKsh7YL2KL2BnWcdvW//+UxaSSFMjFz4gW67kaumQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D84A4BA2DBDFB64FAFEE2F21A1758E89@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4f6bca-093a-4789-cb74-08d6cc7e5a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:40:37.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6542
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 08:09:47AM +0200, Heiko Carstens wrote:
> On Sun, Apr 28, 2019 at 11:52:12AM +0000, Jason Gunthorpe wrote:
> > Hi Linus,
> >=20
> > Third rc pull request
> >=20
> > Nothing particularly special here. There is a small merge conflict
> > with Adrea's mm_still_valid patches which is resolved as below:
> ...
> > Jason Gunthorpe (3):
> >       RDMA/mlx5: Do not allow the user to write to the clock page
> >       RDMA/mlx5: Use rdma_user_map_io for mapping BAR pages
> >       RDMA/ucontext: Fix regression with disassociate
>=20
> This doesn't compile. The patch below would fix it, but not sure if
> this is what is intended:
>=20
> drivers/infiniband/core/uverbs_main.c: In function 'rdma_umap_fault':
> drivers/infiniband/core/uverbs_main.c:898:28: error: 'struct vm_fault' ha=
s no member named 'vm_start'
>    vmf->page =3D ZERO_PAGE(vmf->vm_start);
>                             ^~
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/c=
ore/uverbs_main.c
> index 7843e89235c3..65fe89b3fa2d 100644
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -895,7 +895,7 @@ static vm_fault_t rdma_umap_fault(struct vm_fault *vm=
f)
> =20
>  	/* Read only pages can just use the system zero page. */
>  	if (!(vmf->vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
> -		vmf->page =3D ZERO_PAGE(vmf->vm_start);
> +		vmf->page =3D ZERO_PAGE(vmf->vma->vm_start);
>  		get_page(vmf->page);
>  		return 0;
>  	}
>=20

Thanks Heiko, this looks right to me.=20

I'm surprised to be seeing this at this point, these patches should
have been seen by 0 day for several days now, and they were in
linux-next already too..

Doug, can you send this to Linus today?

Thanks,
Jason
