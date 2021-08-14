Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10563EC000
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Aug 2021 05:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhHNDEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Aug 2021 23:04:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21716 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236697AbhHNDEY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Aug 2021 23:04:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17E2wFrE021399
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 03:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2021-07-09;
 bh=Nvi3zkSLTtGbk6Ars3oZEWy6ukPYvBJrcUOTmXl+hQI=;
 b=bbXZSWT8WpTpIlrfiO1Knz4gxbAOYnnydBFII1MOwQULOEdJXb4OPKhuzYopiVzOM3T0
 KECukI2nu9rqz7r8opQWJ/HU50xlmdSrQZC7BVTeR6vEhatH52QqhGq8SOxcuZQZRZBF
 ZRscAirMJlEZyY2wOQWfyAj21wU6QOi1CFvW3M5Ub6q63SjRYLICgk3sYVuqUzG0UUVq
 +VpL1n+SilSxFlmCDM1JgriZKXtU6siT1i88N5gaMQ3zygHZcbHZd4V2+bEoYdqYR12N
 tdHg1Aa+aP8bXyPc/oljZsppfItK4N4FEOTZY6DUkCRo6OfBBRJ56pcEs26dG+PmzUB8 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2020-01-29;
 bh=Nvi3zkSLTtGbk6Ars3oZEWy6ukPYvBJrcUOTmXl+hQI=;
 b=cMEl76RQt3H7OzJebkQfcV6muTF1fWojBStI0HuO1nEF9eRJOp0dZeYOt2PgtYjvahBo
 CCOkyv8tZ81J2QTWs08LuJ7vy5sz5hOs4YoXDm0oit2rrGTIyV05zv+7bLNl9oqjpvav
 N+r/PpqeZ2qaDh4K4swHUscL65+H5EUEMBG9/btnWu639n+a5kpI8LdV7raVRjSLAPC7
 Mb29PAKRbVrI+hnjETjF1dD53TwNVgb+KG7V3IKwUeXSahPyBO5eHM/5M7IItveK0FOv
 07IaVwebsPT8gDDHHe7r4bXHvS7PUhTE6HuslevjP7g5o7O1JhAjNrWOwfpMxQe/GjFp rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ae48ag2eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 03:03:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17E30ZHf195147
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 03:03:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3ae55hh1fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 03:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV3XLnqFv6t3ZMNb9ezeuy/akfU7aUU9UXVtqedxvLef0tOGsSfSqVuAb1ZBLfTM32PanSILG1YrsMKLlJ7srOS/OzIxsVwmwhTs8sTqp6XWp2XOyiCYaysHRqCfeBo81Cp16w/q0KV5E7hSDbP5YjepOyNLFdM8SUeGAL8+sK4EisB9VAbIsUnnvCKxbCl9Wo766O/lIO+NXszT4Yau/MYtPrOdGTq/XrJFz4xgwLYofiIxeMXVtb9lAEnrBtix40Hm+86Q706NhQSbXEa3BLJse2poCRDXtzb6AMnld8xKCO/EEEC72sXtXNJUQNpzpfHe5yfzldIGQfz+8BJyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvi3zkSLTtGbk6Ars3oZEWy6ukPYvBJrcUOTmXl+hQI=;
 b=iXA669bCaXK5V2qTeGUY3lyxi5R5c8WX3GH3/awoakq8eyT7k9MXAqocBxf2Z7OizvPBKwSTmIt6c3idpfzy+nw662sev0TPjX7rvWi6gCU+DJjBMWtvyWgNjG+MJ2Fm/358NEwk2arasHfw8A0ONj9MMKoo4ILN5JDZfI6mXMqZAx+VXq/LTVpS3MbSGtso4Dmg70HdWJbT0XvGebjC1L1sg0yaHv6zDm5IAdY4+NaY6K8a5C3SbPlIjt47ia1Y8uOKZJHnpwSJl0M6StKpMmhGnWq+cQKnysGMWxeqUeu5K30MRFPQldLOGx4ZG/8btW5q72jTF8YmDaTdL+V1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvi3zkSLTtGbk6Ars3oZEWy6ukPYvBJrcUOTmXl+hQI=;
 b=yIhRW6fnJUjJnSi9tEW2hbjy9h9OUJPqtXdhSFEXjhjorkZAYa8C/j3npthmF15kYMA+aS+k0yV7lYHO34Lq0c8OTOrZWkEb40cTV14Xd5mZQiMaUApGf1GOtXhXjqPbKD95wgla2DWY0Gy71pV9XwnaUs22b+u6Q3U/urNw/Bw=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB2023.namprd10.prod.outlook.com
 (2603:10b6:903:127::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Sat, 14 Aug
 2021 03:03:52 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f%6]) with mapi id 15.20.4415.021; Sat, 14 Aug 2021
 03:03:52 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Misunderstanding of spec?
Thread-Topic: Misunderstanding of spec?
Thread-Index: AQHXkLkCIPitYkFdqkyuJfFE2DOfDg==
Date:   Sat, 14 Aug 2021 03:03:52 +0000
Message-ID: <63A948DF-4EA1-450A-BC84-D12B1C59E7E8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.21)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd07602-ad6b-4989-5103-08d95ed02591
x-ms-traffictypediagnostic: CY4PR10MB2023:
x-microsoft-antispam-prvs: <CY4PR10MB20239BAB100AD3F842A03DF681FB9@CY4PR10MB2023.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ssF9ZeiaRuVddDh9IxPGa0o9IXZcqBC/3s5edANKqGu9eq162JnpivtftFJKfBlXMkGnWs9h3a8l7DSG0NOJuNJskCNRmX2snwjGDqrIt44tUoqIrMXN7aPqKR+bTiwg6WnjXRVptSzhVkH4gHMI5fp+t7lFuFUw63DotgN/KR/6uU5Dclt2MW3yFl2FnivGFdqt9WVudSoTuZcgiO6NPISS8BS+9SfyM34c9Cs+Qa/miuZKsPUwTm8eULXzVO0Mx7W8ImDPCHoQ6kmSJDEoVnI+sk86DCAv3Vf3XyZVJARR62L5fNbFxU5DnS6QIK75uNwyiPze5jaRkrf5TlIl+vLtDHJAHYz9czS/3QFPFCPXp6rVwHY45reqnTB6ulErYq2e3QV2/oJ/f7EPmZqdLfZpz70v0a01JFuzdEN9K9XqOhU5528LAw/4W69UM5WT4YPVPcyAlyWj1ysnGOODXtXGies3Fv1zE7wvmTryhJJq6e0yiiv/L5S325qpRcTYrU9ilaJY5NEpelgv9ZaoCABJiZpCmaHbG78PWFurRX4uv84wdiPP2uqdVams4G6/fAxM1UOeHdFlMCmY+PeAwvaWHRBCknl/YrCXHk6eE+34BGZSXmoutSOOrM9TSSgAEWpCbyYuW1bpDsHxCmIle8TwkYPJWdanOqUkl/lI2JSUzhl31ugkiPbQvrudMB3YLOqMDIogaetSVfhKu3pbOqdv62dFAaq2Ee72nYD4dDu5fu7mqbeyR85SEpT0DnE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(66556008)(122000001)(91956017)(76116006)(86362001)(64756008)(6486002)(66446008)(66476007)(66946007)(316002)(478600001)(2616005)(8936002)(83380400001)(33656002)(3480700007)(66574015)(44832011)(38100700002)(8676002)(6512007)(2906002)(6506007)(7116003)(5660300002)(36756003)(71200400001)(6916009)(186003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xd8cCR5DEMT66SdBfs1Oa2TTrTIOeRJzyxUSUAirMax9dc/a1UZxePUkyHq7?=
 =?us-ascii?Q?Ly3MGrS334M9Q7ciV4bdnBrk/MUIFF3wjhNLRGtuk0OcMHaxkZqVWovd53sW?=
 =?us-ascii?Q?3a2+P8GunSLzbip16wcUzv5O5wp859tZw8/ehI/+lm4SQX7El45f/+u9+GFe?=
 =?us-ascii?Q?pnSwZtQYaI2ip+kQBhyqjbre2Ad2jaBHpoJ4zadFPRnmKbKGDKLStx8c7dta?=
 =?us-ascii?Q?50UkE0bE9KGNWrY+IPzlEwYkLWiKNIb4CWcWAbk4swVRxM+mQzKmhSpw8OiS?=
 =?us-ascii?Q?q98C0/Cs+CQJsTDsrefEWXBtevlXZw8+BBMO8KuvFXDztGhoVjLFBEgG1/2A?=
 =?us-ascii?Q?hRFlpZcSjrQYjP4rDai8c2QSpp9hZAARclxtFade5fMzaGusGdAUYuwOEXVw?=
 =?us-ascii?Q?PmF6agu4kpxbJqdaod7ZTlGOhxmh1Wiwi0alBFmF2ATO5l+S6Z/BjxCMH5Cc?=
 =?us-ascii?Q?rphQNsIBFG170nwFxt89UIG2788LNqxeVVZoeaN7NfQ//GoUGp53q6YqJgoV?=
 =?us-ascii?Q?aN/eyegDLDrI/ZNfLqYVjxA0H79cJq+7+n+IZtNeTHSvUfsh1kKDjzHJx0Ew?=
 =?us-ascii?Q?DPCz3RnA8rzcKq3FFj9on/Up2ePqkP9j6jMSUhfOBCBVAhCQgVfu9dqmP054?=
 =?us-ascii?Q?/ZSva5TP3rKrXFBK1fOg38DS5IShhdDPbtLKUXjp33TWvd+hIFo307hOhktP?=
 =?us-ascii?Q?pmM/rBWjX5btSEHCbIugAdLl4ZGv21RSKoO7xxoaAoJtmhe13TcgHSCNs4pB?=
 =?us-ascii?Q?a/MCBoQlzpb1KV8EFRShoRDXW/tg8qQDkf0NC/PnUSP24fX5o6tF37B/3C9u?=
 =?us-ascii?Q?CHZf5LNw/3YodscqQbRGLkvU7ETvIx3nUDF7qKBaraDPefVO4620sFTKjAfE?=
 =?us-ascii?Q?2fxzIBS7p/jPzRG8bBt1TdyEI0LSnAGSMpwNtIs0U5bajQ/YgZYm4EvM5uDJ?=
 =?us-ascii?Q?IRcXOnDXOAB6fBjCAb8cnLXO98EDFY6DcXxaByPlkS7eVxqTmhciLn77vbMU?=
 =?us-ascii?Q?+/7Nplid7kThDpfYL9aVsgITd+cT42kXUl6z/XF1s7lbVaz1UzJBjGBo+Ou3?=
 =?us-ascii?Q?bPGh6NBxl+1ZXMQwnewuPr2QL6HcsCTGK2hE9FpJxVRRrmE3TOxpC6F29nPw?=
 =?us-ascii?Q?4huTrTuR2JFbkWXobarnADZbCtWNbSViM9l3v9fapaBCzWdrsAbJ5dFI280r?=
 =?us-ascii?Q?kBmoMQ73sKB5M8/yODqpo8rSmi+Wr8fIlROzi/6K6h1fNTsptVy8wBgK7dQT?=
 =?us-ascii?Q?2m4lumkFA/UthWX5PEVzRbr1edOHgcVyuDe1d2amsV5fit8jOy6xK+Yn8FlI?=
 =?us-ascii?Q?q33xFB1pxaeQbl3x2VJa0H4LZhntPXES3UURaMqr9CNfmXg2ZO2fn/4cw6zP?=
 =?us-ascii?Q?Cxp/nOc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D06D47C607711E458982DDE35D76F373@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd07602-ad6b-4989-5103-08d95ed02591
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 03:03:52.4505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hNkDu7G7wr99bzHPcA0DoSiE8bJiPITnLwbjBUrxNinSL1b5dIrXD8tFOyrkvBh4tQpI/rPP9d0/uv6xh1yyDoPPbcrNqVz3aWqFxQodHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2023
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108140016
X-Proofpoint-GUID: 1v7AfklhiLv_COs_SIzRT3fXIdWK5l6x
X-Proofpoint-ORIG-GUID: 1v7AfklhiLv_COs_SIzRT3fXIdWK5l6x
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I noticed that under certain circumstances, GID 0 for some interfaces is re=
ported as all 0s, or empty.

This seems to be correlated with code in drivers/infiniband/core/roce_gid_m=
gmt.c in the routine
ndev_event_link(), which does this:
=09
	/*
	 * When a lower netdev is linked to its upper bonding
	 * netdev, delete lower slave netdev's default GIDs.
	 */
	cmds[0] =3D bonding_default_del_cmd;
	cmds[0].ndev =3D event_ndev;
	cmds[0].filter_ndev =3D changeupper_info->upper_dev;

bonding_default_del_cmd will result in a call to del_default_gids().

However, given version 1.2.1 of the IB spec, looking at page 145, line 20:

4.1.1 GID USAGE AND PROPERTIES

1) Each endport shall be assigned at least one unicast GID. The first unica=
st GID assigned shall be
  created using the manufacturer assigned EUI-64 identifier. This GID is re=
ferred to as GID index 0
  and is formed by techniques 3(a) or 3(b) described below.

2) The default GID prefix shall be (0xFE80::0). A packet using the default =
GID prefix and either a
  manufacturer assigned or SM assigned EUI-64 must always be accepted by an=
 endnode. A packet
  containing a GRH with a destination GID with this prefix must never be fo=
rwarded by a router,
  i.e. it is restricted to the local subnet.

3) A unicast GID shall be created using one or more of the following mechan=
isms:

   a) Concatenation of the default GID prefix with the manufacturer as
      signed EUI-64 identifier associated with an endport. This GID is
      referred to as the default GID.

   b) Concatenation of a subnet manager assigned 64-bit GID prefix and the
      manufacturer assigned EUI-64 identifier associated with an endport.

   c) Assignment of a GID by the subnet manager. The subnet manager creates=
 a
      GID by concatenating the GID prefix (default or assigned) with a set =
of
      locally assigned EUI-64 values (at GID index 1 or above).

      Each endport must be assigned at least one unicast GID using (a). Add=
itional
      GIDs may be assigned using (b) and/or (c). Note: A subnet 2 shall onl=
y have
      one assigned GID prefix (non default) at any given time.

make_default_gid()and add default_gids() seem to have that all taken care o=
f.

What concerns me is the code that removes GID index 0, as page 436, line 35=
, states:

C10-2: For each GID Table, the first entry in the table shall contain the r=
ead-only invariant value of GID index 0.

So is it actually OK to remove GID 0 when removing default GIDs via del_def=
ault_gids(), or should it be preserving GID index 0 at all times?

This is because it appears a call to rdma_query_gid() (as in ib_find_gid())=
 will return -EINVAL for a table if GID 0 has been deleted.

Am I misreading the spec, or is there a bug here?

Thanks,
    William Kucharski

