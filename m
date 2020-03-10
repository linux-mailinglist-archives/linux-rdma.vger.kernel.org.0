Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19417EEC8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 03:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCJCn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 22:43:56 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:14406
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgCJCn4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 22:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTizFCRsJRfImCCAQrlY50vrArCPws5h9GHVHFy67zelCVa8eb8Z2/y8ZhGJTY3/S1ZYf/bxhnTsjqKvhmpVDcTrPeIZXuWP7ooV+PXSS/JEzzzELo4SH2ObdDhFrFRSIgdLz2qKXpQFqxDmUxZFJTkyBTGhWUdiw47/SgvfJ2qr/toB6RXjQNxMIckdKU1j+Hj7Ohf+FBF3ixfh6LH4mlTuyCOKpqdagidAJTn3S+pR2Iu605+/Xqf8MtT53y7VX6EXHkoCvXQ22hCcVVuEaSOmFBTb9X8p27Y30YUuM9qgTQ1zQJvgapnmOM5vbrvq7E/5TCNZSW/RwG7t8vyfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdS16QVZD4rlxfanJ3olFmGa0HwRNH8Lk0v3d5qyMss=;
 b=WLuoelcGxFZ5B+EyfDfaYakhTWWv6IiE1w9DAQxtBiSsbG+kBYdeTffoOzxPGN9JgSgC6FX74SEurIo0PalVkuwChWz4Vft3TXtAFQUjLNuRFOa5ARvXNDgQFlNp1XtlWjVj9sJQiCE1ABdHlzzKDStPcSeUPFSWO/lA0AqaZ+6A8gdoyTBq9wv8mAhCrupZnhlrceKLSydzODneB/cx+d+E7wx38iqdgHT4AYCWnogsdGeCXtVhpEUu00rS9ccBd/lXzdzSEhzzy2ejkGwbN4QrnJb6o7jesLsLNHpbSjlJt7udD2HUesHIAEGWOsCfQy9DtpMwRcFEOKj8O6ISNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdS16QVZD4rlxfanJ3olFmGa0HwRNH8Lk0v3d5qyMss=;
 b=k6Ph42KgrXv5Oz/IZ9Iox8K2hZd+Vssmy3/tONcsAB+eFNAK1mypT1U6Kdg8DTXfGABJ/t09EfhWtcCiSa6+Ejv2g9JvE3BpxW+j1jZCyxb5MtcbIgRfqYY/j2twi4lDZMM0eJQ/OR7qBHpPE+Gx2iC/QP2RQLRx9BX88TbbfT8=
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com (20.177.33.13) by
 AM6PR05MB5990.eurprd05.prod.outlook.com (20.179.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 02:43:51 +0000
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::cbb:a034:c324:138b]) by AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::cbb:a034:c324:138b%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 02:43:51 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: KASAN: use-after-free Read in rxe_query_port
Thread-Topic: KASAN: use-after-free Read in rxe_query_port
Thread-Index: AQHV9jkJCU28FFAXfky+bua200OhVqhBGZPg
Date:   Tue, 10 Mar 2020 02:43:51 +0000
Message-ID: <AM6PR05MB5014AD481B61AB9238396CD4D8FF0@AM6PR05MB5014.eurprd05.prod.outlook.com>
References: <0000000000000c9e12059fc941ff@google.com>
 <20200309173451.GA15143@mellanox.com>
In-Reply-To: <20200309173451.GA15143@mellanox.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yanjunz@mellanox.com; 
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e77ed10-f437-4050-f81d-08d7c49cde0b
x-ms-traffictypediagnostic: AM6PR05MB5990:|AM6PR05MB5990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5990BCBE93E4EFC9115C85D3D8FF0@AM6PR05MB5990.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(186003)(8676002)(81166006)(81156014)(110136005)(316002)(8936002)(54906003)(33656002)(7696005)(2906002)(66446008)(64756008)(66946007)(66476007)(66556008)(76116006)(6506007)(26005)(86362001)(52536014)(478600001)(4326008)(53546011)(71200400001)(9686003)(55016002)(966005)(5660300002)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5990;H:AM6PR05MB5014.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO5yVR4ggEpmC+fYE80ltiWamzu3w36GKXvNaWmszDdV/rMgC6/uizyDCAsCE0LTEOhGF1xsXqYgNGKXbVXG3UZqaukK/+Q7YFzND1cnx0XTHwO2tJW/IKfyUUiPx0SeINQSIBsKz9hwuYGeb98Rb3eqnpHzVgcI/HmzeN8WUKOAynYCPN+3mwZMBtA52Bh4mUAu3GxwcE/7ls+ULJvuXR+Xjs33b+U8U8N77h/uwjBenkX3A1e/1P9Rv3M/mYkdA/nrBKxzY0ks8bvDvq9KiWQZMm/BrsYOjE5s8CC1OIIa/wO875K7+XNTr+dkwO+/1qcuonilUM/QHs327bUQP1maiL8VfW1JBzM9XBcw4VYPCAuRyO6HecfPGKFJyIkQSmvFg/0wXRGPjZklwWKTKgKek41fORn4gUadV3GMWOg1TqfLc6Eb4F+S6S6HHwvZfNnoU8FKyX3iAJGVqE8wff8AvDcKzFldzXBnlkhfILjt0ZjC99Eb3QNHrImuOHllHk47OYpt/WtZv04+JlXky/8EqZtGQgfP8yow2tz11r8qUsfV6VTE/fQwi5/EdGXnJA7cEiNbQtGGRtq034jOwkJOl575y3VoWlUXRnkr3YqQ+nPPMxwMHryg3PoVgrrGpEIbTh9uOcJ+qp7kj6WN0Q==
x-ms-exchange-antispam-messagedata: 2u/iEUKEjJCLo6vs1RepsN0qBsatTpgPQ5rud1ypbpB9z4aNAPK1nnbFj8noz0IEcw80K8Vb7kJC99k54L3SISYNI/cI+dui3ZCHv/ph35S9RfZjrQXKUNtWmra7LMc26k2FD8QtymVETHUsIEv7JA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e77ed10-f437-4050-f81d-08d7c49cde0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 02:43:51.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TssSOKmXzBDFY1rfXHErbI02vzIwpvTzL5pwYx/0SWn8P8DUUrOUKEnP+DyHiwOOLxHYa2nOah/x1MvmDmJqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5990
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Jason

I checked the source code and the symptoms.
1. In dmesg " rdma_rxe: ignoring netdev event =3D 10 for netdevsim0 ", this=
 indicates that the NIC which the rxe is based on is set to down.
Then the following will run:
"
ib_unregister_work
    __ib_unregister_device
        disable_device
            remove_client_context
                kfree
"
Finally the port is freed.
2. Cocurrently this port is accessed by the function=20
"
ib_query_port
    __ib_query_port
        rxe_query_port
"
So the use-after-free problem occurs.

Please comment.

Thanks a lot.
Zhu Yanjun

-----Original Message-----
From: Jason Gunthorpe <jgg@mellanox.com>=20
Sent: Tuesday, March 10, 2020 1:35 AM
To: syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>
Cc: dledford@redhat.com; linux-kernel@vger.kernel.org; linux-rdma@vger.kern=
el.org; Moni Shoua <monis@mellanox.com>; syzkaller-bugs@googlegroups.com; Y=
anjun Zhu <yanjunz@mellanox.com>
Subject: Re: KASAN: use-after-free Read in rxe_query_port

On Sun, Mar 01, 2020 at 03:20:12AM -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    f8788d86 Linux 5.6-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D132d3645e0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9833e26bab355=
358
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De11efb687f5ab7f=
01f3d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> Unfortunately, I don't have any reproducer for this crash yet.
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com

Yanjun, do you have some idea what this could be?

Thanks,
Jason
