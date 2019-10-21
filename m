Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCADF579
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJUS5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:57:47 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:59448
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbfJUS5q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv7E1gT7C/Ynymgl8YNFMcqYljTzh+J5LjKwrVwBleY1hhxDybKnRXuo7rCg4cWtg0qvyFSuhLbHXLAgQ6SAGFkIMnoiVgagAyWQ9bni9iFZyUX4rWfrpb70LfVEruxEP+3I1MkgJyriAtoCo5mGkX87JBDflU0C1MT93eCcOApaSS2KDGRdSQBKY2osHHTjP6AzmWmY2+q4GoRrG89/1Sf9jv1WfiurnZhKokjsYO0KUt7FRbXv+zK2/9oJs/UFrII4DhzoTKOTDYSlEuX321yl5yNMCcQicOOiViZFKmWQgO5CPu6F5N966vE5BF0PC3+M4fG+nk/JBlqCbIqmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyjmVYKuEJheZR+mPSV4oncME0AobZ0x4p/0lHK1Pes=;
 b=kMDOLiWLuT8gYTaV+xvs4FJZglHDCaLHzWVTCFdekQcXqSLP8grwbuR9HUS+Rskk+FuR/IG6hGpWuqNHsb2q+0xq8EjndZTFRv2K5wqQseA0fD32P9kh6JKTk7J8XQ7CxwyFU3igFVd1npAEQBvMBG4SDKta7wX926NaEcCpymq9PNvnob0VLbCz23Gk1mnLq6q7rH2nvk/YGvN6lgdjj+XXkzifWYaDyA9FID+vG5yw7+nuDoZphbP1vMgRRQv33L9+VwzJBsV+GThRmpAIiIhRecAuzuRYtKvTSAX4223SyB70yet3Ruk6cPd2l/QmuKKgpyAAmd63aRYyHecYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyjmVYKuEJheZR+mPSV4oncME0AobZ0x4p/0lHK1Pes=;
 b=kUjLVOxFsvzhE2gS+f+y03MCZdmnaQwnANzgflTVhU5BsPUsrgD5Q8fx5g0sASJ8lKJrUXKbGq9aH7sAjoms+9KuMFV7h9U842TAXq8o6FR8Z0AQ30+p+cJQTRbn0Cvl0wyv1IcWxyrK0iziEMj49A7ptH+sPwXE6XO6T9Z4Jeg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4191.eurprd05.prod.outlook.com (52.134.122.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 18:57:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 18:57:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 15/15] mm/hmm: remove hmm_mirror and related
Thread-Topic: [PATCH hmm 15/15] mm/hmm: remove hmm_mirror and related
Thread-Index: AQHVg4SywcbuimcjREqJNp41R1BK1KdldmcAgAAFYAA=
Date:   Mon, 21 Oct 2019 18:57:42 +0000
Message-ID: <20191021185738.GH6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-16-jgg@ziepe.ca> <20191021183824.GE3177@redhat.com>
In-Reply-To: <20191021183824.GE3177@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:208:35::48) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57e0870c-c9e7-4acd-0215-08d756588d1f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4191:
x-microsoft-antispam-prvs: <VI1PR05MB4191F433A5EBEF8A72E7D72ACF690@VI1PR05MB4191.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(66476007)(33656002)(6436002)(66946007)(64756008)(6506007)(66556008)(6116002)(316002)(476003)(7416002)(54906003)(6486002)(4326008)(71190400001)(71200400001)(386003)(36756003)(3846002)(25786009)(229853002)(186003)(2616005)(11346002)(6916009)(66446008)(7736002)(1076003)(14444005)(446003)(86362001)(99286004)(81166006)(76176011)(5660300002)(6512007)(478600001)(102836004)(6246003)(26005)(486006)(2906002)(66066001)(8936002)(14454004)(52116002)(256004)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4191;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVB2BKyQWSpwrUc3vLyrml9di3pbVk/A+6m1CA56Q7QP/c+BwIpRWxIRbIAE+w+wd3uYnD9MFJ7aGNqKON1kTs2AM2cpZOByVP/a1tpTLyj4a8Qy/roNWdepZHCXepWHdmYuoZc1JrKzxNNSetQPLrKYquqiPVA1K1q8Se6cfyfGm5k5BhHzxzSM0LhROrE6yu1f2xc+CggLqUUsC4OdM5F3rMLL7FLACKA6Zz50kKKALE2FoBIN8d1xDVcEHG4RlboPS1knSu4Q/N+72Rc4LyHfDBOkZdbYT/DENEL0h1QUmFcBDEy8cTvSFDIl1TuLjuBgUaFjRmqncKadT/fViUTYJ7TFBaDlopVxF6iFP58ccsC1ZXQblTZ9FyepPUHMhTR39tXyCfVYG64TSSVnU7TDIZUcxnkYkk+uagnhMwc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08002827BBC4AD498462229A8A58EBB7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e0870c-c9e7-4acd-0215-08d756588d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 18:57:42.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yj26yeaHwQG/b6beP5Fb/8PQ9D7NwBgtBYbjTOiEUeeZ85UxYUizDHfh0Uw9M9cCiLwJYCnPv2G79WC8j4C2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4191
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 02:38:24PM -0400, Jerome Glisse wrote:
> On Tue, Oct 15, 2019 at 03:12:42PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > The only two users of this are now converted to use mmu_range_notifier,
> > delete all the code and update hmm.rst.
>=20
> I guess i should point out that the reasons for hmm_mirror and hmm
> was for:
>     1) Maybe define a common API for userspace to provide memory
>        placement hints (NUMA for GPU)

Do you think this needs special code in the notifiers?

>     2) multi-devices sharing same mirror page table

Oh neat, but I think this just means the GPU driver has to register a
single notifier for multiple GPUs??

> But support for multi-GPU in nouveau is way behind and i guess such
> optimization will have to re-materialize what is necessary once that
> happens.

Sure, it will be easier to understand what is needed with a bit of
code!

> Note this patch should also update kernel/fork.c and the mm_struct
> definition AFAICT. With those changes you can add my:

Can you please elaborate what updates you mean? I'm not sure.=20

Maybe I already got the things you are thinking of with the get/put
changes?

Thanks,
Jason
