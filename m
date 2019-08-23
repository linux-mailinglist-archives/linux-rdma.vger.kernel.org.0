Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940219AE7B
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393132AbfHWL5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 07:57:47 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:3054
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393004AbfHWL5r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 07:57:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFBtQwm2MedoWRQCOv1lPeHKha7Ms43F6Hu5Qhn6AhAZt+63+YPzyZKhA+d/OPB+oPtcflO9aPsNVyxEZ2vCdnE7jfUnaeS+9/7hrZ+e0Ex4bX9s8z8fsawW5/oInMib6ii+JYVOBmLRLKcZX4dfiAXqSnhnFrH76HbZUryu194GVQEO00IrqUI4pWTT4exwYI6eDiUlJEZ8MAHJ+Zf9ebkfDw7+LgfxqkuW5aG/Ph00U6KsmroP2g3js514Ndyesoud15sBmI1S0uyfh+MS/oTTEdvZCGDxEptSIV1goRwjsjk4CZbveL+X9IZiyhUplrw2+hU29RNvZvlPa+UCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOISsYmbS8N58345FqC1JRv9e6Qr5kPHvprvt47YW5A=;
 b=d9LZP0dWfmGp+ecU2WCtADJ6PHcJDGQ+abxRE6xp310iYGkQAH3T7it7RGIF0DjQW7hRQKPf4XSDXCnICKJUxyZCORCeh/UP+8PEgqszZmZIihWBcnZqKWoi1xPt2K0YtiKL3lJJAOZrldhONUmMr+5eu3pCeyPe+0CT44pQGz5x593h+xovpE+vxx5IM8TDHSamDphu/MCGZfknKmqttdlzNKBYuBB9flgDE3bMrb4F/GmydOVzGpH3FdQ10+kXkDtwWIWQSH70M96UOal7+Nwx9wq9qdLR6aV45ikBlh+DdXDmieLAsoK0xNsXPGZJUuG6co2LeGOLsIhfiYPqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOISsYmbS8N58345FqC1JRv9e6Qr5kPHvprvt47YW5A=;
 b=EJBmYolSDMMEHz3T41g+5Qlj736YVpnL8TDG8I5Cl+gh1Wcj9HWSNJQ3dKwHnzK3oKuWkILRZicXmI97OYykhWEQr1xXxOz7jqiMIzSqYBUfUigD7TUkn7HE5Ih2svfg/oeCfOAT2OC8AWMFKMQuBQML9lRrKKDhnVnOSYyIz8c=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4927.eurprd05.prod.outlook.com (20.177.51.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 11:57:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 11:57:36 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
CC:     Yuval Shaia <yuval.shaia@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Thread-Topic: [PATCH v1 00/24] Shared PD and MR
Thread-Index: AQHVWCvPpKVLbk/iqEuq+9fKELazmacGQnyAgACX1YCAAIsLAIAAAT6AgAA0QICAAQiwgA==
Date:   Fri, 23 Aug 2019 11:57:36 +0000
Message-ID: <20190823115731.GA12847@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
 <20190822170309.GC8325@mellanox.com>
 <2807E5FD2F6FDA4886F6618EAC48510E898ADD18@CRSMSX102.amr.corp.intel.com>
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E898ADD18@CRSMSX102.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3623cfd9-9007-468f-3c56-08d727c116e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4927;
x-ms-traffictypediagnostic: VI1PR05MB4927:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4927CB35D4C4733D5DC061DBCFA40@VI1PR05MB4927.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(186003)(5660300002)(86362001)(14454004)(66946007)(7416002)(102836004)(66556008)(6506007)(386003)(99286004)(25786009)(14444005)(256004)(26005)(76176011)(8676002)(11346002)(66066001)(446003)(52116002)(8936002)(486006)(54906003)(476003)(2616005)(6512007)(6436002)(6486002)(1076003)(66446008)(66476007)(229853002)(6916009)(305945005)(71190400001)(71200400001)(316002)(478600001)(3846002)(7736002)(6116002)(4326008)(6246003)(53936002)(33656002)(81156014)(2906002)(36756003)(81166006)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4927;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pF8/COZqvyQ0HA1v7cz3b2+ilubXkIpUNC+vOSajjI0E3smwn+8QT0UzU9vllP/RHiZYRUygCAOt/seIdYWLTDpUPvf+KLDU7wQ+/nC1YgganY4HF26/K1Fhn6A4td4OkRCkF5qEyfX409IOQ+gPbn44aicOme/4uehKMQ6TquLsBQlFSZdTFG6bms0ZJ/0tzPP5VT2eqo7O7vBhAuhKZ+xNvtsPgd2OT10XRRqXCoDL7cron26HhSLi7rW23wMgx74sUjqCxIzvKgRCbV9Qq2W72mW46wYymfGnTbiWJBxfl+wJnV1VijHIwio/ixEmC4JNfDF9b/I+9DOV1MX/tSClT7S5DtA6kHnXf54MoiXsapL0zC0EIgC4N/0h+ERE4oY14MmrBL2y9Y+adAzrnIOK5hcZpgMdpt6VPxOLhQI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E995BA5741D7E46A52ED350BD3C7B7A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3623cfd9-9007-468f-3c56-08d727c116e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 11:57:36.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZg1iyr+Piz56zSKkY+UNqBW4bpNdA8FNylILQgH4D9TBERzjmPVIyMpjKIFC1xhbT1AHqQwJb5a71wXogVakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4927
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 08:10:09PM +0000, Weiny, Ira wrote:
> > On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:
> >=20
> > > Add to your list "how does destruction of a MR in 1 process get
> > > communicated to the other?"  Does the 2nd process just get failed WR'=
s?
> >=20
> > IHMO a object that has been shared can no longer be asynchronously dest=
royed.
> > That is the whole point. A lkey/rkey # alone is inherently unsafe witho=
ut also
> > holding a refcount on the MR.
> >=20
> > > I have some of the same concerns as Doug WRT memory sharing.  FWIW I'=
m
> > > not sure that what SCM_RIGHTS is doing is safe or correct.
> > >
> > > For that work I'm really starting to think SCM_RIGHTS transfers shoul=
d
> > > be blocked.
> >=20
> > That isn't possible, SCM_RIGHTS is just some special case, fork(), exec=
(), etc all
> > cause the same situation. Any solution that blocks those is a total non=
-starter.
>=20
> Right, except in the case of fork(), exec() all of the file system
> references which may be pinned also get copied. =20

And what happens one one child of the fork closes the reference, or
exec with CLOEXEC causes it to no inherent?

It completely breaks the unix model to tie something to a process not
to a FD.

> > Except for ODP, a MR doesn't reference the mm_struct. It references the=
 pages.
> > It is not unlike a memfd.
>=20
> I'm thinking of the owner_mm...  It is not like it is holding the
> entire process address space I know that.  But it is holding onto
> memory which Process A allocated.

It only hold the mm for some statistics accounting, it is really just
holding pages outside the mm.

Jason
