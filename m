Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB669CFA5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfHZM0d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 08:26:33 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:24294
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731208AbfHZM0d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 08:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d670y3LdewU/HavW3P4k9gItZw2hGGQ8a+GckjSWYN3JwV+m+vvf1aMaGbnNwLJdQ6CFYkd99L1QbfA35qAfsKjBf2az0fnFz+wfz+XTxIOHml3g4GzpsNDwoUWU3CxBM2Ydutt98zr98olW4LtJL5Htcq3QXJFwOb8mSQvfrDqbHIKTwerLLp/YEGxvVvNXM6E5+0x86GXCxgJ34LtHFow0gg1nWg9ppb6x1u8NBdA2g9G1s10dL/5zFUmOdpq9AiiLVonQQ5+zNj/lEpimSsIP7E20Md7HUBbJLC3XvfadE+Vwpfh5Sk+vRfcXMfx2KpvPdLEyyV+XbavflB6Rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg0X10M5RJ8Phph+QsYfQs5G7ttqbLsFcHEJPeBX0e0=;
 b=D3jUH+xFTLZcbNHL9/cqtM4XENkosU5YdYsL4AKzei6yPyc3ilujdAc7t6Sf1BdCq1bP53qCs2TZzAzW3+hdMRiskAfMOrItgYS7R7vlyLA3nlrAK6xQEVP4zUnQ65y/55bOGNQfdvtnMjZKbBKjX1TJ1F1hezdhbG+o+OpVMepgRGC+aFULzLR+yC7GnaI8VhrhBdpybykG3yS3k72RbtvYPAZ8f1AisTwt1JDaVEfhiNlvLvLcA9PpwMZ1MnwIRFyF1/VZbd4jy66J7Pt6vVmnzsuWwwdsHNDr/guxJIejWQzJ0Sn3s4icjGGuijp68QMAhfeB4nY4z49PcoOiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg0X10M5RJ8Phph+QsYfQs5G7ttqbLsFcHEJPeBX0e0=;
 b=E/du9SEpBt6ce6IMTaU1qG33fHExsbkWKtEDKyD6utEk2O699hbMgzOr7lWSBJ6pdzP+1sQnQgSprqOU89flLUekwNGyy6N80jUtRBiQvgZ5osVQOLa3UBCuF4146WiEZ/YlvI87dpVJvJ+qrrnZyL7zPkvz8+7K6kx9sbhgXZs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6127.eurprd05.prod.outlook.com (20.178.205.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:26:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 12:26:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
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
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Thread-Topic: [PATCH v1 00/24] Shared PD and MR
Thread-Index: AQHVWCvPpKVLbk/iqEuq+9fKELazmacGQnyAgACX1YCAAIsLAIAAAT6AgAXbVICAACCpgA==
Date:   Mon, 26 Aug 2019 12:26:27 +0000
Message-ID: <20190826122621.GA27031@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
 <20190822170309.GC8325@mellanox.com> <20190826102926.GF3698@lap1>
In-Reply-To: <20190826102926.GF3698@lap1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d548e369-a792-45cd-5b34-08d72a209dca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6127;
x-ms-traffictypediagnostic: VI1PR05MB6127:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6127537F927A4193246F0856CFA10@VI1PR05MB6127.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(54906003)(6436002)(6116002)(7736002)(316002)(5660300002)(2616005)(14454004)(476003)(486006)(36756003)(3846002)(53936002)(1076003)(25786009)(33656002)(6512007)(4326008)(446003)(11346002)(6246003)(478600001)(4744005)(6486002)(8676002)(66946007)(2906002)(66446008)(64756008)(66556008)(66476007)(229853002)(99286004)(71190400001)(71200400001)(256004)(102836004)(6506007)(386003)(26005)(81166006)(81156014)(6916009)(86362001)(186003)(76176011)(52116002)(305945005)(7416002)(66066001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6127;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g76OR+fYbQUMqPce5RBfaLCvsbQMYWoICLaWix8dnkWNu3IeMpKSGLOxYP1lvWCigMwvCYmzTIXExeESn+2+K7Rd6sSUp2G+78kH509nhJHHp3nH9X4dVAtHDXfdo2ihOdzpSfAeTi4YFDcANCckDownCc5drmJVcRj3HCo5qV9e6tD1RCWRzNKXWxuGg6AhnB5Y/54VS2yRDWFXfxW3pPCMQUV8FNmnlr/lfVFaRRVOPj4LrNDTsHmiolt6gwSyPx9sCbwyW8nN7VjWdmtHs9RgdDSKwkq5mBRKaM2Gk97FOCfyhK19L+Uatma9ADXHm1ZLRsVWBLnm53nMlYHncdjwcYXxd+LvAROIPmZzvpdjhAsKppNzsUqcAWTt9ZvqnOVqb7e32pwfk7fb9nIBUxlnfHsiJ0u0h8lK7XR4RiQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E525152FBDD4D44B3008DBAFA933513@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d548e369-a792-45cd-5b34-08d72a209dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:26:27.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YA2ISZHPuDzPeA+VO4PTwQlJ7vy1UrvtB6gccOQGTZ2N76yT3S9EsXi13Wrw7FnWtsglh0xtCEysdRglllQgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6127
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 01:29:27PM +0300, Yuval Shaia wrote:
> On Thu, Aug 22, 2019 at 05:03:15PM +0000, Jason Gunthorpe wrote:
> > On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:
> >=20
> > > Add to your list "how does destruction of a MR in 1 process get commu=
nicated to
> > > the other?"  Does the 2nd process just get failed WR's?
> >=20
> > IHMO a object that has been shared can no longer be asynchronously
> > destroyed. That is the whole point. A lkey/rkey # alone is inherently
> > unsafe without also holding a refcount on the MR.
>=20
> You meant to say "can no longer be synchronously destroyed", right?

No, I mean a another process cannot just rip the rkey out from a
process that is using it, asynchronously

Jason
