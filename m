Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7710903C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfKYOkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 09:40:37 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:21474
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbfKYOkh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Nov 2019 09:40:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z35lzwqaOJAfWJkqCqKf6scPUDTCYv5LL17EHUbcgKEi2wwgB9vliZ4xMcXGmE3LDy5vRBxBoNXg8y8/d1Wt6XI2OBF5Ck8WC8BGDaWiffFi+9u6z66SHRB4EocsYtWOGyfyf43MZuAcrPIP3WOjCROSzraJ0Pna8osZp4W8oU2Lvtu4R27xKcGYN9JwBWB1yuNIoBIgwvRx0ruVsdzNekSxv2r3JqSOAPv+Bz0yV5TzYVf7GnoXf8wAQM6B1eK4LzH2/JiPMqhfcG6z18KXdaLe/5ig87r0LnCUYXcCLlZzIEgXP7/ERKE0Ya8mEWSYBTTrkJr7epkk91j18quYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtjbnulc9BoQZbIlC1CnBkuN3+OB56YDBb7eRPCmCQ0=;
 b=Vgr1huoB9IAAaPd0CSUHBMtUy0Yk64nrz94PLlIrNkhWzSTtSIY1Es+6DMaQi2fr9BBr1GdIiL1AYCaCLXmVqUGqnsZ1HnR5GLnlhlPpSCAWRDHoNt9mvDgTjOeRK6j3xrTJJKxM2XCSmvpQWh/z6R0ETGeq4j5eYKpZhkCjgIhPK+pgvZFIf7uycgylwGeOgzu5YZ0Gydk+NxfRDVAljZE4XteXHKY2AYeah1ELRIniZzSAEDZddKbLiADDaa0xCcSVxxpXAvkdBpgr5zsTja2eISl3wtl+8Sp1aVk6m35BLE5Edl9RPHgzRrmy8KYcfUkIFjWski0sEH9aDlwhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtjbnulc9BoQZbIlC1CnBkuN3+OB56YDBb7eRPCmCQ0=;
 b=E9vL2XVFxqjPknoid9xslN4zixwB18mKDe9yU0RHj7qrXh8Bi1y8HkGv9gcXNLF7m4Ng287nxcILOptPeFlYmSDg5XaPhlnii3xCCtNEGBw1PsPGYAMy7qpW7rsb2uFYti2Ay1IdFkYaWICWO/rKXqV42zOiNY42bxum3BHdCPI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5374.eurprd05.prod.outlook.com (20.178.8.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 14:40:33 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 14:40:33 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Thread-Topic: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Thread-Index: AQHVoJdh/kr9vbiVpUaAUvWhClYcFqeWFhwAgACsRICABTkAAA==
Date:   Mon, 25 Nov 2019 14:40:33 +0000
Message-ID: <20191125144028.GX7481@mellanox.com>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-5-leon@kernel.org>
 <20191121203836.GK7481@mellanox.com> <20191122065509.GC136476@unreal>
In-Reply-To: <20191122065509.GC136476@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:805:a2::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a619e758-f944-4e64-de7c-08d771b56d5f
x-ms-traffictypediagnostic: VI1PR05MB5374:
x-microsoft-antispam-prvs: <VI1PR05MB53747C6FED7A1EF3FF8B5530CF4A0@VI1PR05MB5374.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(14454004)(25786009)(6916009)(3846002)(6116002)(6512007)(6436002)(1076003)(11346002)(52116002)(66476007)(186003)(2616005)(478600001)(26005)(102836004)(386003)(446003)(5660300002)(6506007)(2906002)(4744005)(76176011)(66066001)(64756008)(71190400001)(71200400001)(7736002)(256004)(14444005)(36756003)(8936002)(316002)(99286004)(33656002)(305945005)(66946007)(66446008)(66556008)(6486002)(86362001)(229853002)(4326008)(6246003)(81166006)(81156014)(8676002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5374;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QS8Y/T2ul9wD/Vkv3I7fGGDrfASWf/Doxy6BTXIn8I+VfYLITqowoHlblRzBWjV69A/f7QXT484XpFSXGXUZy5oD3yEG3+qJ8MKTxPlOguL2qpSlYht9Dq7bbHaTWE8ylOKiNaK836GQsglibLprd+pg7uOjEo2oAip7/9dk7Yb6L8uKnI4KqAytviV5zNO2AWf+8pkd3m1zWagzMPr+AS9iSa9qslUy/UUGD1ZSAiCwB2y6EDVf9iifBDJH4Y7Juwpa5FI/atoHO6I558jqcqf558Av+u0LIEuigm0NAaXJL3xhKCHMJt7yCBenhQ6EfLe9uE4Ao4DsM8+v8lNc2ACXQ9mgy0wrHGcFJCJ3B4JqNY91MIfXWx8HaKxWJ/9QnRgAc0/q7bPmVkBV904gtUujXYlOkaIRoL/e7Stg5cSzUSEYmbB3trGpSDmtQoh7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30FB3B15366C9B49903D68D753E66113@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a619e758-f944-4e64-de7c-08d771b56d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 14:40:33.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2ISS8DYZJbHlb/e9ZwiZ4hXXp7fTzrU8sF90sNogNq8/ICChcS0IfcDYDhtn8JhfPH35kdFVHAwOrZM1I29AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5374
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 22, 2019 at 08:55:09AM +0200, Leon Romanovsky wrote:
> On Thu, Nov 21, 2019 at 08:38:40PM +0000, Jason Gunthorpe wrote:
> > On Thu, Nov 21, 2019 at 08:12:29PM +0200, Leon Romanovsky wrote:
> > > +#define _IBA_GET_MEM(field_struct, field_offset, byte_size, ptr, out=
, bytes)   \
> > > +	({                                                                 =
    \
> > > +		WARN_ON(bytes > byte_size);                                    \
> > > +		if (out && bytes) {                                            \
> >
> > Why check for null? Caller should handle
> >
> > > +			const field_struct *_ptr =3D ptr;                        \
> > > +			memcpy(out, (void *)_ptr + (field_offset), bytes);     \
> > > +		}                                                              \
> > > +	})
> > > +#define IBA_GET_MEM(field, ptr, out, bytes) _IBA_GET_MEM(field, ptr,=
 out, bytes)
> >
> > This should really have some type safety, ie check that out is
> > something like 'struct ibv_guid *'a
>=20
> This GET_MEM is not used yet, because I didn't find a way to model
> properly access to private_data, ari, info and GIDs at the same time.

I'm surprised we don't access the GIDs, how does that work?

Jason
