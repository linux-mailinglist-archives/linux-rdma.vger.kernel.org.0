Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF471CEF31
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgELIeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:34:02 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:26342
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgELIeC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 04:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drhv4ptRitoKiSoaMQLWu5MC8sY5LdxJQvWKZRXEZkUFT/wiMYTiegmbnLC+Z7mJ/bE0cUNB51nl158aXDUulJ80K034WhQYu4/hzAULEVunYkso891b7TVSV1LrOfZf9WrRvRo6VWND2vxPw7t0ItmbKqSgccAlSMW03fqNOjV9GRsVNU5iyB9YbBrFn9AwSGmhaVwYehzXoVf5yR0jDTlWvvfFxLNLVsei3cECFHzmR3W7vv8b3oPkVc3Y3+yJKtveicKm/IuDu3s1VHjEL+i2sJr6uIgbIJhXBLSvGM6ajtTGNsBzDsoVfKkQTSje3iNsDqeTyl+NZ1yQOdd0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cvGFs88DYwANYtkO1rny5gCliD41hFjulf4cm1/WGA=;
 b=e5FtFhrcSALobtrIE53C3vBhm9ji6YXaviHq6Bw958kgFpci4kapMKK7SZhe/DxIU5T9lZ6XRGFIuPYwNAKXxvqt4tTlb7ly96uyoRd86xmWgp6veF50hBxR24frUfqPZ285Ww/bGFWFIo4n9VFPheaPtfp0qRjYms3zrbuR4h+apZcjCJg0U/OlFTY3ZXU3FLdLX+orZTj35XA/OI5idvN91zeI3TfaMeBd22GxsTpG57OthRHFoYLvnt9KFX67TUHC1fW00/7bh6uptDr9tONIXtQEywCrURBb2ljQxIecuGSiQdh7vkuZT8FPhm0Q5DJmE4pEehUTlqgqcalyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cvGFs88DYwANYtkO1rny5gCliD41hFjulf4cm1/WGA=;
 b=heIof0ZydpHPkk6icpNA9Q4FyFW+gcnL3Gnore9JFqfYMFAsrtmZrxlN3JJUibAjyEsG1E5m0xLgMh/1J95Bm5Kmb8T8Mu9rIAzHKMzdRHGJskgXvOuyBh/UhIeDsHRR3cEa7QjtsTxOFiHmUgyI4IhNnBoNA5Q3zNCKm4gNTjM=
Received: from AM6PR05MB6263.eurprd05.prod.outlook.com (2603:10a6:20b:5::31)
 by AM6PR05MB5703.eurprd05.prod.outlook.com (2603:10a6:20b:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 08:33:57 +0000
Received: from AM6PR05MB6263.eurprd05.prod.outlook.com
 ([fe80::6dad:73a3:a3af:c829]) by AM6PR05MB6263.eurprd05.prod.outlook.com
 ([fe80::6dad:73a3:a3af:c829%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:33:57 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Thread-Topic: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Thread-Index: AQHWJ8NJYVVyKN0IEUq6MA/gyfBb3qij/eIAgAAJEYCAABT4AIAAA+uAgAAAnIA=
Date:   Tue, 12 May 2020 08:33:57 +0000
Message-ID: <AM6PR05MB62630AC146F51635E181AA44D8BE0@AM6PR05MB6263.eurprd05.prod.outlook.com>
References: <20200511183742.GB225608@mwanda> <20200512062936.GE4814@unreal>
 <20200512070203.GG4814@unreal> <20200512081706.GJ9365@kadam>
 <20200512083107.GI4814@unreal>
In-Reply-To: <20200512083107.GI4814@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01029ec5-2c49-4008-6282-08d7f64f3688
x-ms-traffictypediagnostic: AM6PR05MB5703:
x-microsoft-antispam-prvs: <AM6PR05MB570366B55674DB6A281FDDA1D8BE0@AM6PR05MB5703.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lPUbn8kT77XkzvvqvkydiMdeob2o/6XuClko0XZ2w5RwozX5oo0jKETm8VJSCI8iEH1xHd36WOizQKFqNSWKiyXFjIwO2PZlAsr5+yKU8W1q90U7DtQBlwkZryoGp6OOBzYwy5U3UTtcoCSskJtKG8P3xQzQFuj6tg7oGeVTAXl+rxQd3XrVphH823Zhvcb8pyf2ASnoo7l3QIGhfE9K3wriBF48n6mHy0t+1Ov89jRkEyuCtqoiWXuzNpUkWG+YdFRkPYe57VCcdk/X502Q7/JiiRnaQFpIXGB6gqvpPtsb/V4+PxwF96aBp4E9b4GZ8Oc0n2f9AlClTmu+NNWckrWJ7DB4i4jSpJCwacdXlR83fb4NO23coCP4yJTFGD7Dybqinwcg5uTCivihI+mYv+T9MifAF5OrwD/eel3w48LvxbL+9ASWsLR0VmkvRZrN5VknxFed7JOFoQYFQC1UtO6XxTZRS2IsRysI6wQ9Mp4BjkSzEdGJzvsVOkw5FlkzLHVGj0w5J42zDNF4aX5OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6263.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(33430700001)(53546011)(6506007)(2906002)(8676002)(316002)(9686003)(55016002)(52536014)(64756008)(478600001)(66446008)(33656002)(33440700001)(66556008)(66476007)(26005)(110136005)(186003)(54906003)(4326008)(76116006)(7696005)(5660300002)(86362001)(66946007)(8936002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IUvNYgtYx34FlF06NfcBjzhRN8Q0SI8RxkBtIbmRUDxGlc2Y0WmvV/QDPh+mE+N0lajRePQDsldHJ7PNPk8wefYIuG0Pn42PgVHQ7Ny0EwtQ4pLlHOGvUZwToDVL9cWUbLqX9cowOvngOopsMLvJUkxmFBEgKGKrGU+Yq/f2VjI4czpXjSC//ZQ4vlXcmNlaWzyuZdHrXRJQRGN14gTEz5SGI7LzekP27G3GmBjvwRKi03RUWOnQOtscwzObq7+d3YYpXz7wD78MED0xt57qqtIDcl7+WhiCwsvqNsyVflAow4PB8nXu7AndyZUZvhboas9gCeuIsXdD1cvd3bq592sglkBPw6kOdoGmbAgqs+H8AfoIvvi2CqsUwOQ6MjPICkx2JNm1R9ATAcnZAvLiVt/yXLQcF4VYse80Eh5GDxY95IbxVY/b2NySzEEvS09PmiRS48qXvSP6nzyh3t9i43Wt4zDFzBxLXROHqd7HtZMk+A7dU7QVT5xW3KR5dTBW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01029ec5-2c49-4008-6282-08d7f64f3688
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 08:33:57.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxwDqIrXyrcV4BpZ26wSAcWM1u8Z/DQMVoXT8Ep29UOmy+sv+k9LtemE0ugWKgQejc8uMWDKZgi2jdx0882T6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5703
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Tuesday, May 12, 2020 4:31 PM
To: Dan Carpenter <dan.carpenter@oracle.com>; Jason Gunthorpe <jgg@ziepe.ca=
>
Cc: Yanjun Zhu <yanjunz@mellanox.com>; Sudip Mukherjee <sudipm.mukherjee@gm=
ail.com>; Doug Ledford <dledford@redhat.com>; linux-rdma@vger.kernel.org; k=
ernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails

On Tue, May 12, 2020 at 11:17:06AM +0300, Dan Carpenter wrote:
> On Tue, May 12, 2020 at 10:02:03AM +0300, Leon Romanovsky wrote:
> > On Tue, May 12, 2020 at 09:29:36AM +0300, Leon Romanovsky wrote:
> > > On Mon, May 11, 2020 at 09:37:42PM +0300, Dan Carpenter wrote:
> > > > This function used to always return -EINVAL but we updated it to=20
> > > > try preserve the error codes.  Unfortunately the copy_to_user()=20
> > > > is returning the number of bytes remaining to be copied instead=20
> > > > of a negative error code.
> > > >
> > > > Fixes: a3a974b4654d ("RDMA/rxe: Always return ERR_PTR from=20
> > > > rxe_create_mmap_info()")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >  drivers/infiniband/sw/rxe/rxe_queue.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > >
> > > Thanks,
> > > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> >
> > Actually Yanjun is right and "err" can be removed.
> >
> > Thanks
>
> I don't know if the code you guys are looking at is older or newer=20
> than linux-next...  :P

> We both looked on rdma-next, but the wrong code was added to -rc.

Yes. I agree with you.

Zhu Yanjun

> Jason, that patch was marked as stable@.

Thanks
