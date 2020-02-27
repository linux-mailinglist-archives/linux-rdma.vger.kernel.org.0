Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F81717EF
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgB0M5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:57:33 -0500
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:27398
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729056AbgB0M5d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:57:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cntzs/zBzHTljUDHHJ1/kgFR0TMDXjZ4SQgJlLBAFJVrixkUQMp9GqxRxPH2iK/aJ+/nMLhqSYScmWeSWYbiq3yBpdGImsTbTUyRvm3ts8aCFRVB5Ry7dEmQ1uudhOvClfKu/FDE6Ale3G56t40UEOjRDgEVRfAxwdpxtUvf4GZAmkmB65BQ+yqAkXG97TUCwYLU/MbYtT+Uzq/9G0hYl7zNdSvOaEhlMHbLXtTCVHbBqZ1CXXMnv1Oh6MAu19Z9oLEOEemwxFLixNxfPkDTOzeXb74r3n68/w0BYmU6KHRW/Q/yd7NUOs60WFE3urmzhaRrtOi5mWJZiPtSoigorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM+j975oAFHi6Ws+YQ5PK0dwPuxaSZIrraGi3WAvC+M=;
 b=nDB8PCku253KEovoKDMu93kmO0f2/KVOCdJ82LBA0K969BRuTB1f4yyIWm5SuSKEsWTVQnThnZ9C/XLDZEvdfAHun/41DrKKpPmZ2ftap//cNK7EmPAFbFYYr+kdOEj4zZ4g7prTTFTbTE8vb4KxFHt0ygYFKJmXCqW8xsGtONSRKhINrDssrpTliu67uSwVHvjvuuvUttquC2Ar3RNQCSjORZiWxNWbZ+HtFX87CAZUYT6b+gYTF/5lrXHb8SHWJrGZb/D/qLnxDUjmM1BJwkz0ij4oLFFrTPYO9clhP7mSQQhMjia0s3cklM+Ugz+aeGrhLszugvf99ck0xeGcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM+j975oAFHi6Ws+YQ5PK0dwPuxaSZIrraGi3WAvC+M=;
 b=fi3d1HrHM04v8YAa9UQhUlUEZwjvEdt/wuenPdvKPrQd/iZqT3LpAYrh/hIkr2+t1y4vEer4aJ40I2k2OqyXAOeYY8W3Ato3EgRyezMyGRq70R9pkIBcXNjd44e9LHPsi5yxU42kYzzCdT4BkzPOPXQchbHciBCM1WZj1KZhWMc=
Received: from DBAPR05MB7093.eurprd05.prod.outlook.com (20.181.43.74) by
 DBAPR05MB7080.eurprd05.prod.outlook.com (20.181.41.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 12:57:31 +0000
Received: from DBAPR05MB7093.eurprd05.prod.outlook.com
 ([fe80::3992:db02:90fc:8ea5]) by DBAPR05MB7093.eurprd05.prod.outlook.com
 ([fe80::3992:db02:90fc:8ea5%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 12:57:31 +0000
From:   Vladimir Koushnir <vladimirk@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Haim Boozaglo <haimbo@mellanox.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: "ibstat -l" displays CA device list in an unsorted order
Thread-Topic: "ibstat -l" displays CA device list in an unsorted order
Thread-Index: AQHV6z1DMWp/6fBTvEevkqOyQ6SeqKgqvliAgADVi4CAAesAAIAABBiAgAA1oQCAAPWWgIAAVA+AgAABzeA=
Date:   Thu, 27 Feb 2020 12:57:31 +0000
Message-ID: <DBAPR05MB70932DD7E5FC7DCDD71543A3CEEB0@DBAPR05MB7093.eurprd05.prod.outlook.com>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca> <20200226135749.GE12414@unreal>
 <20200226170946.GA31668@ziepe.ca>
 <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
 <20200227124937.GK12414@unreal>
In-Reply-To: <20200227124937.GK12414@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladimirk@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49ebad92-2209-4d08-506b-08d7bb849b5e
x-ms-traffictypediagnostic: DBAPR05MB7080:|DBAPR05MB7080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR05MB70803CA9A707828CD21B959CCEEB0@DBAPR05MB7080.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(189003)(199004)(71200400001)(8676002)(66476007)(64756008)(316002)(66946007)(478600001)(8936002)(66446008)(5660300002)(54906003)(81166006)(110136005)(66556008)(81156014)(76116006)(86362001)(26005)(6636002)(186003)(52536014)(6506007)(53546011)(33656002)(4326008)(2906002)(55016002)(9686003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBAPR05MB7080;H:DBAPR05MB7093.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yl2GEdLLUsu+5mr1QZDa7s7lVeJBIXHGkQtTqhZGoLieXzSi3AtMwmI5z9yjAu7XZs5RFvZbgiXhoBx9xeo3ErZmozc7ykfyO3MyBVqxc2ROkheZXhatw3GorBykmbQG6vWhX+ns+IXoPGVyBmg8fj7K2mBMFZCxuNkBeKLK7h70xD0GJs1FpGaS66bYW980+dN08jIGCyKwPukJbxqH3EWHmA6IMSg+VKNgvzosEOWejg/g4UQGlouoOqiVALDfqfqQKjtRBVTO4r1ERYFaVXfQWHRBRmmE5SRSJfQCrH+v/4TJJjSyjOET66ES/yhCYXOEJf8zJq4OVr+5RaqugBH509ksU2VKH41FNNV/IY6gxLzxCVP1dghiYrRTNZ+lT3Qjr136rcSUrVhk20ShYOtiSXyps7zteTjTw5gd7bryAxx7E8BuQq+ew+xs6Eh0
x-ms-exchange-antispam-messagedata: ZFGvgh2BCX1nH6Y2A42Tm7oTLniWe8NX6PuUPXQlgD67mmwS09sYNRLZhcZgiLrWqW5HTyrk7fTua3fCO8lQg9RPy+FIlzrIA7l2burz+nt3mXj/z54+NYAX5NEUoobF81P1W+ZVgUeh1t0/1uUHQw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ebad92-2209-4d08-506b-08d7bb849b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 12:57:31.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9+NjnmGe7Xm6vM+BK0QvT1bbS1yJ1cZwQB8WJEltD5on8ranOzp8WrEEYJzsEV8pca7RVxHlzce668h6cnHhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7080
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ibstat dumps the current status only.
It has nothing to do with hotplug.

-----Original Message-----
From: linux-rdma-owner@vger.kernel.org <linux-rdma-owner@vger.kernel.org> O=
n Behalf Of Leon Romanovsky
Sent: Thursday, February 27, 2020 2:50 PM
To: Haim Boozaglo <haimbo@mellanox.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order

On Thu, Feb 27, 2020 at 09:48:45AM +0200, Haim Boozaglo wrote:
>
>
> On 2/26/2020 7:09 PM, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2020 at 03:57:49PM +0200, Leon Romanovsky wrote:
> > > On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
> > > > On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
> > > > >
> > > > >
> > > > > On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> > > > > > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > When running "ibstat" or "ibstat -l", the output of CA=20
> > > > > > > device list is displayed in an unsorted order.
> > > > > > >
> > > > > > > Before pull request #561, ibstat displayed the CA device=20
> > > > > > > list sorted in alphabetical order.
> > > > > > >
> > > > > > > The problem is that users expect to have the output sorted=20
> > > > > > > in alphabetical order and now they get it not as expected (in=
 an unsorted order).
> > > > > >
> > > > > > Really? Why? That doesn't look like it should happen, the=20
> > > > > > list is constructed out of readdir() which should be sorted?
> > > > > >
> > > > > > Do you know where this comes from?
> > > > > >
> > > > > > Jason
> > > > > >
> > > > >
> > > > > readdir() gives us struct by struct and doesn't keep on alphabeti=
cal order.
> > > > > Before pull request #561 ibstat have used this API of libibumad:
> > > > > int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
> > > > >
> > > > > This API used this function:
> > > > > n =3D scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> > > > >
> > > > > scandir() can return a sorted CA device list in alphabetical orde=
r.
> > > >
> > > > Oh what a weird unintended side effect.
> > > >
> > > > Resolving it would require adding a sorting pass on a linked=20
> > > > list.. Will you try?
> > >
> > > Please be aware that once ibstat will be converted to netlink, the=20
> > > order will change again.
> >
> > This is why I suggest a function to sort the linked list that tools=20
> > needing sorted order can call. Then it doesn't matter how we got the=20
> > list
> >
> > Jason
> >
>
> I can just sort the list at the time of insertion of each node.

Will you "resort" your list in the hotplug event?

Thanks

>
> Haim.
