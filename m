Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66CB2A3684
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBW0Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 17:26:25 -0500
Received: from mail-dm6nam08on2106.outbound.protection.outlook.com ([40.107.102.106]:46065
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgKBW0Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 17:26:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHdbK6VKbHXqhRVsDT7uZ5kK6lpEE6fyLpbO28mYXwGw6PXrwY0jTZKo01JVphyrrCQcZmDfnqfoxyXAlwMxY8GGlbH2TTOalCWRbXH5MJhGtS/8skFosLjMNscna/6Qg5dJ1ibLVaFLNqZhFkiSjADd/HW2rhFv3Th2lrN+CEIWV0RhDG7Fe33Vgouknusj1aqPIBVj8IAHLIkMlzb4ZPGGuBnREH/qxp8O1AwtCuf2JM2FhZgj1FFiAIMOCxvWVg0ldWyAEzXZA8Rb8lSYqpIs/zPcgFyAnGLXZNcoOaKE20cR6RLQYVtDzGYVH0dMZCRXm4MTUEeYuz60XQ7hDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE2qDmQ3ZRwv0hMyj0aDmKNq8xhk2lGtl+tuyL0ALz4=;
 b=DQ2tt2WKtTjR53Iwjq/mVNf3Qur9xZ0lYSYj8uB2JAEnLoiLmJJnpHBGP7ZQD8jVFjlqGehRbDccURIXUx1pP19GIC1pWRCSnathkwjr3agAeThlGOw6PY8W54W434R7v6/50s3mypjAvCKTUfvs65o5nhVbrKtNU43DgR+CK8gE88rw3yj3d4q0UJeLwnZt/wPrGsMocTCd33n+Mrn3qE6iS9hSwEaHc9Ji1zPtdd1eyAd5RLdvTxSx6w4NsCkgBvBL/ArkSYjnDP08TEDRfesKLv8NOG2Gz46O8i0Yo7Z9MYM88QHZ/bkxmExQaXaId9cCFB10loC335VXJWn1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE2qDmQ3ZRwv0hMyj0aDmKNq8xhk2lGtl+tuyL0ALz4=;
 b=C9Q3LTxTo+Un1bC5DwiQo2uljavid37CaEhGfvpJoDY0avMf+JQQ70HCrD4vfK4gsfUmkyKw3ISFWYF1p6jBPB4qNeiJLhL2/gNxyZYWqaTwu63EpKO/9Io40mhVmTurVUV658F+BxOgWVUOCDG0cA5gO9A/NC+Rq1KsfBn15jM=
Received: from BN6PR06MB2532.namprd06.prod.outlook.com (2603:10b6:404:2a::10)
 by BN8PR06MB5922.namprd06.prod.outlook.com (2603:10b6:408:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 22:26:23 +0000
Received: from BN6PR06MB2532.namprd06.prod.outlook.com
 ([fe80::2c22:5dbb:becd:88d]) by BN6PR06MB2532.namprd06.prod.outlook.com
 ([fe80::2c22:5dbb:becd:88d%3]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 22:26:23 +0000
From:   Changming Liu <liu.changm@northeastern.edu>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        yaohway <yaohway@gmail.com>
Subject: RE: How to fuzz testing infiniband/uverb driver
Thread-Topic: How to fuzz testing infiniband/uverb driver
Thread-Index: AdawkarIjS+Q8tCzT3S+sAjKAmsjCQAodNCAAAzcBsA=
Date:   Mon, 2 Nov 2020 22:26:22 +0000
Message-ID: <BN6PR06MB2532A64BB4D75A9D8D02E310E5100@BN6PR06MB2532.namprd06.prod.outlook.com>
References: <BN6PR06MB2532A875B6C3AC57072570B6E5130@BN6PR06MB2532.namprd06.prod.outlook.com>
 <20201102161617.GE971338@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201102161617.GE971338@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=northeastern.edu;
x-originating-ip: [173.48.78.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f00bab8-8f8d-4232-b99f-08d87f7e5454
x-ms-traffictypediagnostic: BN8PR06MB5922:
x-ld-processed: a8eec281-aaa3-4dae-ac9b-9a398b9215e7,ExtAddr
x-microsoft-antispam-prvs: <BN8PR06MB592257160006AEB14BB03D06E5100@BN8PR06MB5922.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvf3oQYqxhOi9s1T75YraorcB3ONCqVVtXwubaG0ubv6c2XwSpP5oZpMRfoJEwNztuh6sim/Dns3gi7e5USRf0zBFuxkXjA0ie+7R9jwyjp7QO1K1bX35mdLPrFtKHDgY7p0Uaopf354oYpD99sy8CYTc5SZ/37lF0uPXVxROpihS5HebfwAFWW8iKOkSLl6CMNYncl0OG/FUhMtgVSDHirU8kwhwavZkN2kFS6Bm5MP1GV22eLF2FXwB4UT1kF0eX8PQFIe57/ARTwEouYaFJcbxqf63s3bHsQmMjQoRnxYP89+ZHYripHJmHMPE7eupABzfwNa/Tz4B1ue2NfM3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB2532.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(86362001)(5660300002)(6506007)(7696005)(786003)(9686003)(478600001)(52536014)(66946007)(66556008)(66446008)(316002)(53546011)(75432002)(64756008)(2906002)(4326008)(8936002)(76116006)(8676002)(83380400001)(4744005)(71200400001)(26005)(186003)(54906003)(55016002)(66476007)(6916009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: E1xznToDh5Y3nrYhhOV34JtaXbeRIluXakNqUCfRNbAQwkmctGa45CaAXwmeoSJL22Csac7GHGCy+QuuyvIWaQLrWGZTfwI/0HatR0i0/EQm9fkD5qlPb28OHbUSyLCAuzISZ1J42R/Ziy6XSxNl1b3vdG4DEM1FKEXfZZNO+KBO8EeWRWB4J1rneH0LYpxtHNgad+AlVc6AsfJSuYguf8feGFKPIu70t52nU0S3699NRFL6vl1W5wCdAx6+L90XdYPzQyqQr2YvpvdUYXAmiHQXjMd+pbowa4X0QHIiGjvO4bb6G2BGL8VTI/8GmJGv27w6eap3EIJCasBBZPsRyoZhYjmDd17o/udf9dyHi7/T73gpqLLTcR9K9dATiilGgA0d/WkS5Li9wA8Xev1G7CNn+ihHfjLSdta37iVOVckbnOgU/c+7YIQKfWUUT2xEKiwAvC4Cr8mhSCIDdyK6Db9BKT2Uuobtup5VUH7dky214Iw2RzckZe8k528xwrC7iguJ5sc+iI0zmUFf7WmMfrtbhWb2PxobpBFsPFxagj3xq+RHbot5xtzxhnXWYrZ7Sg7ou7VNpqrLOIqRbu7EG5T3zXFD6bTNPOx3yh3OHwMI/yIr7IHahc02IVTzQTH8SdahlI6gkFbktfBFp7kFmA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB2532.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f00bab8-8f8d-4232-b99f-08d87f7e5454
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 22:26:22.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehXUEATDEQW5zuJPBbas2vNGYEzOf4unW4QEnmaUj+hB9rtKthT5NSIjUzyeYF+JAZSGZXkEmu5P5iL6SjUky3yeRzoLR3TIy9ubtI8VfYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5922
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Ira Weiny <ira.weiny@intel.com>
> Sent: Monday, November 2, 2020 11:16 AM
> To: Changming Liu <liu.changm@northeastern.edu>
> Cc: jgg@ziepe.ca; linux-rdma@vger.kernel.org; yaohway
> <yaohway@gmail.com>
> Subject: Re: How to fuzz testing infiniband/uverb driver
>=20
> On Sun, Nov 01, 2020 at 09:00:13PM +0000, Changming Liu wrote:
> >
> > there is no 'uverbs0' file created under /sys/class/infiniband or
> > /dev/infiniband/. So may I ask how to properly set up my testing
> > environment so that I can fuzzi testing this driver? Is a physical
> > device required?
>=20
> A physical device is not required.  Look at one of the software drivers l=
ike rxe.
>=20

Thank you so much for your guidance,=20
now uverb0 has appeared and syzkaller works!

Best,
Changming
