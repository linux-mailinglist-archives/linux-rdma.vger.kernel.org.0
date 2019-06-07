Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18DB38C70
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfFGORW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 10:17:22 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:44208
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbfFGORW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 10:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=498yq0m+SHUwWSq8e+SHH+wyGc7fgwEQ3BhNsZt4ya8=;
 b=nCu10o7PN1wZvzjF7TNJjd0UUDugqJ19ulToaLF8odHHGA9oHxig6WG2PdRmMHJXNWqcohu5Qv24qA2qborFMAxHjPHdRXpbiqaZnQfFImRf6njhisUxgwSer3X398ioLV/U43D1PFo1ADiFQOQqXkC411NLqCk2qP7W4JqPLPc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6141.eurprd05.prod.outlook.com (20.178.205.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 14:17:18 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 14:17:18 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 01/11] mm/hmm: Fix use after free with struct hmm in
 the mmu notifiers
Thread-Topic: [RFC PATCH 01/11] mm/hmm: Fix use after free with struct hmm in
 the mmu notifiers
Thread-Index: AQHVEX0K7JKRenZ5i0yE9OOqwFE+2qaPY2+AgADxAIA=
Date:   Fri, 7 Jun 2019 14:17:18 +0000
Message-ID: <20190607141715.GC14771@mellanox.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-2-jgg@ziepe.ca>
 <20190606235440.GA13674@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190606235440.GA13674@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26aff798-13f4-4096-10c3-08d6eb52d91c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6141;
x-ms-traffictypediagnostic: VI1PR05MB6141:
x-microsoft-antispam-prvs: <VI1PR05MB61416E67D450A9870407A720CF100@VI1PR05MB6141.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(346002)(136003)(376002)(199004)(189003)(256004)(6506007)(102836004)(71200400001)(71190400001)(6246003)(76176011)(53936002)(52116002)(386003)(14444005)(14454004)(229853002)(486006)(6916009)(25786009)(4326008)(36756003)(3846002)(2906002)(478600001)(54906003)(68736007)(6116002)(99286004)(6436002)(66946007)(66476007)(66556008)(64756008)(66446008)(476003)(6486002)(5660300002)(66066001)(86362001)(73956011)(6512007)(1076003)(8936002)(26005)(316002)(446003)(11346002)(2616005)(33656002)(81166006)(81156014)(305945005)(186003)(7736002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6141;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S9PkCY1ICVuPK3MQ2qDYV4gAFsv+fn80mXAjICfCHo2KGasdWny+Vn09vRRJtHO2rGbYW+fan7RvqUwlcnx3ZJTkCWb3apHioR8fTrPHUmxtyolq/dHDheIlVBPzJHTF4/qLNS1M94NzSpph+mtXp3uZftDYCDKBVDDopMBiCp9NE/TiTYglPRzFTldzSKY81PRejIVZSkY4EMB1nTcaMmU4u6s5mStcDXQpNELVqEZo1S30McBwWRN6k6x7x05qrqyFhLjxFSc2prs+Y82vSAnBB0289Hsf7L4qEibNFYNGK53wLzpIm1jI2M9MRABuZCJgNM9lyz970ZRrFmHoFJ+pG93hnlcqrcUOSIR7r0TmawxWy+H8G56jwyWvOqfwT4lLFGoPYEB9tEAASxBDpCgnW0EPbY5l6SYXcrzxuUQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E7B450F71F8AF44AD1259D6AFA5DCC3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aff798-13f4-4096-10c3-08d6eb52d91c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 14:17:18.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6141
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 04:54:41PM -0700, Ira Weiny wrote:
> On Thu, May 23, 2019 at 12:34:26PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > mmu_notifier_unregister_no_release() is not a fence and the mmu_notifie=
r
> > system will continue to reference hmm->mn until the srcu grace period
> > expires.
> >=20
> > Resulting in use after free races like this:
> >=20
> >          CPU0                                     CPU1
> >                                                __mmu_notifier_invalidat=
e_range_start()
> >                                                  srcu_read_lock
> >                                                  hlist_for_each ()
> >                                                    // mn =3D=3D hmm->mn
> > hmm_mirror_unregister()
> >   hmm_put()
> >     hmm_free()
> >       mmu_notifier_unregister_no_release()
> >          hlist_del_init_rcu(hmm-mn->list)
> > 			                           mn->ops->invalidate_range_start(mn, range=
);
> > 					             mm_get_hmm()
> >       mm->hmm =3D NULL;
> >       kfree(hmm)
> >                                                      mutex_lock(&hmm->l=
ock);
> >=20
> > Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
> > existing. Get the now-safe hmm struct through container_of and directly
> > check kref_get_unless_zero to lock it against free.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  include/linux/hmm.h |  1 +
> >  mm/hmm.c            | 25 +++++++++++++++++++------
> >  2 files changed, 20 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 51ec27a8466816..8b91c90d3b88cb 100644
> > +++ b/include/linux/hmm.h
> > @@ -102,6 +102,7 @@ struct hmm {
> >  	struct mmu_notifier	mmu_notifier;
> >  	struct rw_semaphore	mirrors_sem;
> >  	wait_queue_head_t	wq;
> > +	struct rcu_head		rcu;
> >  	long			notifiers;
> >  	bool			dead;
> >  };
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 816c2356f2449f..824e7e160d8167 100644
> > +++ b/mm/hmm.c
> > @@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_str=
uct *mm)
> >  	return NULL;
> >  }
> > =20
> > +static void hmm_fee_rcu(struct rcu_head *rcu)
>=20
> NIT: "free"
>=20
> Other than that looks good.
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Fixed in v2, thanks

Jason
