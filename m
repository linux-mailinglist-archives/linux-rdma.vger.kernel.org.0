Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0A10F519
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 03:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCCm6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 21:42:58 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:11933
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfLCCm5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Dec 2019 21:42:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct7UHaUPSpFaLIa6lPVbMcWaUiWA05081C1hoDvya0funM/PohZOzWoLdZVfjiJ9Gvq/lQaxG/QGiO2Y3Tu2VUaykrg0COxek9t1UesSBzWc/MfZGWxbJoTSvnTy88z8w9hKlifWmZgaq+hCRqDeW1HVRlEx4m8uHz5IQtc8Gc8smN0d5A48Oq8rVN/kFSVIb+8QoIvauo6MZKCv3wcrK/7h0v1rjY1K89jKn3MW8n6FILo45vNhnxM7Ae+1JM5QgRqe6WBtTaX3i3UB0vuPfvf3KmSGOWn9C5L3L05S/MBwo139BxWVy1NF8Ui1gypOr032sS43/aQXOKN/bMmYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G+Qqtza+y1neOxrnvHVHceJezEdg/XV3qQ42E8X/rA=;
 b=ayYeqldqNDeBnqIn72ZAGym1i3zPHGD0pvlHqbUfgnHu9DOta18VozRGoXqkJgqxeB9kjxPGc1RcdL+Um1xj343JTvJloDug0GtMTOYMsflJVEi6DVfV/pARknL16f7tsQUM60Ue4xnolrVW8funb8ZlEPdX0bv44ZeiSij4y4M6x2CCa2RJxP+Gu8tURxbLyD+CRKyjNoudzvsyVKuspQq/KnENDAlDJGFObMFA9hnTo7DO4mkj72jqw8FjYRwrP0OLY6ggDVuCHCIynSOvwiqKzQzTTtD3HZzHFvyotWeUoUAvXfv0pW4ZfcMiPLXCddLihYj7HD8PaHTqs1n3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G+Qqtza+y1neOxrnvHVHceJezEdg/XV3qQ42E8X/rA=;
 b=F4fcuyugYr+BrQlwnSQ4u939mvhC9j6lk6x7NnRRXvGy0IikPetWLo1x3KTMqar+nG5L+LKI2Hq0lO5Mp/xFH8Px/tHiM+Tx8TuQP4xtxL01xulkunsLUoTR7FmyA315VK9G1O1+Rch61Yio26MGx1Bc92NpM6auiO/Ro4sFSq8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6477.eurprd05.prod.outlook.com (20.179.26.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 02:42:12 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18df:a0fe:18eb:a96b%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:42:12 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull hmm changes
Thread-Topic: [GIT PULL] Please pull hmm changes
Thread-Index: AQHVo9Dog/MtwM8aJU6I/7345tJKuKekCWkAgAAFfoCAA6/3AA==
Date:   Tue, 3 Dec 2019 02:42:12 +0000
Message-ID: <20191203024206.GC5795@mellanox.com>
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
In-Reply-To: <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.225.245.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9689ac42-e33a-4c6f-c9ab-08d7779a65fb
x-ms-traffictypediagnostic: VI1PR05MB6477:
x-microsoft-antispam-prvs: <VI1PR05MB64774132CBCB09497040C538CF420@VI1PR05MB6477.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:312;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(6486002)(4326008)(229853002)(186003)(6916009)(26005)(11346002)(2616005)(7416002)(76176011)(7736002)(66556008)(305945005)(3846002)(6116002)(256004)(14444005)(66066001)(71190400001)(71200400001)(2906002)(446003)(66476007)(66446008)(64756008)(66946007)(8936002)(81156014)(6436002)(5660300002)(1076003)(386003)(102836004)(52116002)(6506007)(53546011)(8676002)(33656002)(81166006)(6512007)(316002)(478600001)(14454004)(25786009)(86362001)(36756003)(99286004)(54906003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6477;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+WH8HPf4I6ZRvacYs3zzF9Im+onpEnMe8sZ/II0AJdFNJBal5ox4StAIqEL3BE98sKh8ZFajT/V+Z6y0vweE6P/UAgUk9K7vbnTLHQtbJPdRnY/fbrjDwfBTU+tORo9Ud7P3L2cYGtBHhMzoSgvZjGkLVMVsvMOeT7/rlMIKYdnEea0jDh6yWuzZmwvhkbG37JcDbtD1kBx17erB2uX/wE08sX4hq2WtSl8ET0aNM4iRWdqdiiTtYINAlixx1jQSI6Bf9hOBoRP+vAe9PefqXoQ4oBor9QuqolMLIbKXDq05elsiVxAGze4El3K/fvxLh41iGThxgne9PMKHY4cCAyoC4Xwk2lvPT8sruhThzL2wSKJD7Nk1zdx8qpfdgdmTQqLSD92PHnjjdGOsOkY3qlP+EndvP6DTXRY304pT1E0PtZeUxglzvgHe4kOpW50
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3389EC944B5C79428295421F186466CD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9689ac42-e33a-4c6f-c9ab-08d7779a65fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:42:12.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9FSlYEZp3/79VyfFiDDWMjZwGdPZPtlKcycRU/pZMZocaGQZVDXn+hDwerrFsdRUSLI2Zv/ulk/DAoI42tmXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6477
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 30, 2019 at 10:23:31AM -0800, Linus Torvalds wrote:
> On Sat, Nov 30, 2019 at 10:03 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'll try to figure the code out, but my initial reaction was "yeah,
> > not in my VM".
>=20
> Why is it ok to sometimes do
>=20
>     WRITE_ONCE(mni->invalidate_seq, cur_seq);
>=20
> (to pair with the unlocked READ_ONCE), and sometimes then do
>=20
>     mni->invalidate_seq =3D mmn_mm->invalidate_seq;
>=20
> My initial guess was that latter is only done at initialization time,
> but at least in one case it's done *after* the mni has been added to
> the mmn_mm (oh, how I despise those names - I can only repeat: WTF?).

Yes, the only occurrences are in the notifier_insert, under the
spinlock. The one case where it is out of the natural order was to
make the manipulation of seq a bit saner, but in all cases since the
spinlock is held there is no way for another thread to get the pointer
to the 'mmu_interval_notifier *' to do the unlocked read.

Regarding the ugly names.. Naming has been really hard here because
currently everything is a 'mmu notifier' and the natural abberviations
from there are crummy. Here is the basic summary:

struct mmu_notifier_mm (ie the mm->mmu_notifier_mm)
   -> mmn_mm
struct mm_struct=20
   -> mm
struct mmu_notifier (ie the user subscription to the mm_struct)
   -> mn
struct mmu_interval_notifier (the other kind of user subscription)
   -> mni
struct mmu_notifier_range (ie the args to invalidate_range)
   -> range

I can send a patch to switch mmn_mm to mmu_notifier_mm, which is the
only pre-existing name for this value. But IIRC, it is a somewhat ugly
with long line wrapping. 'mni' is a pain, I have to reflect on that.
(honesly, I dislike mmu_notififer_mm quite a lot too)

I think it would be overall nicer with better names for the original
structs. Perhaps:

 mmn_* - MMU notifier prefix
 mmn_state <- struct mmu_notifier_mm
 mmn_subscription (mmn_sub) <- struct mmu_notifier
 mmn_range_subscription (mmn_range_sub) <- struct mmu_interval_notifier
 mmn_invalidate_desc <- struct mmu_notifier_range

At least this is how I describe them in my mind..  This is a lot of
churn, and spreads through many drivers. This is why I kept the names
as-is and we ended up with the also quite bad 'mmu_interval_notifier'

Maybe just switch mmu_notifier_mm for mmn_state and leave the drivers
alone?

Anyone on the CC list have advice?

Jason
