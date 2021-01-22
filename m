Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB4300F75
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 22:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbhAVV6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 16:58:09 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:13598 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730134AbhAVVtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Jan 2021 16:49:41 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MLYOKK010009;
        Fri, 22 Jan 2021 21:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=9wJIYyUxdDqLLEn/RW24kbLnzjne5xd7oMf3lTbbsiU=;
 b=VGQCjjektGkM4djV6dWKBq54DoJSqfdTXTRfHEneTL9sXfURBWWY3+XJSb4QEDKOIgFD
 epsSZHhSuqIis/CRFDgQnOTsIcalqIGi7FAjBgrbh2IYR8YfVxEy2SwirUtD32cC8GgD
 VRX/sbx55A0bcuJYcg3hewUEVRfzLG1b9c0v7VV9tGGlf7UZGwodf8SNOhwzvieRfaQy
 sBbPGC447P57rMJmq30R8RGBiRVqP34PGXCd5xCRRThfaUTLDJlAEoF+6yhLAwTQtDFL
 P6Y3bGewQUPGnUaCFla6pFIL2P7iPu3Arkg4TRNSyiNWDda4ISIJoilWWH33p/I26Jm6 6w== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 367jnx8j96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 21:48:44 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 3997DB4;
        Fri, 22 Jan 2021 21:48:42 +0000 (UTC)
Received: from G4W9331.americas.hpqcorp.net (16.208.32.117) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 22 Jan 2021 21:48:23 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G4W9331.americas.hpqcorp.net (2002:10d0:2075::10d0:2075) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 22 Jan 2021 21:48:23 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 22 Jan 2021 21:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT7lNDSOcAey0ppMzgCiiYp3cRKgyPVZvw/45uBPnzntiZRfg1/+KcN63sGPj7Hip/HPYBTK5ZKUSxTKVK6YdlG46nm2DF1tiZlde12RYkQgn1n7B28qfvvXpxQBHbLQjNcZNuKjwMcGNmJa1xbrC/Jp5N6KrVdd2GQ2DjqyVK9axZ+Mqrg+ophLoavN94bZ+0k26GEzFW4No0I4HtB5NcVXywWJ56QcDAPuij9Viw5iNuoMAm5Pjab/krasyeTz05McnOMfS0B1TF4B8jIdtTfdLSGfzusZ4IDUwUPcBXSl+OhzfdDu+DHpChnLPYPHDldQ9LUyNvqBPmA67Zxzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wJIYyUxdDqLLEn/RW24kbLnzjne5xd7oMf3lTbbsiU=;
 b=MxXrGLSGIx5R0a3vgDw5lB9OZH2xgHIh32XkQqek5cyEH1KeOaCKiYa7YvhnuP3WX+r+6OHCDYERaFS9lQsSESVWPk3UHrx75VC4PhBLNaaaUUE8RmVvizFcLC3a/Vvu8xkl6ynzeb/Q+zsfWFIndMU0XLKu74j7IGDMj97Hda0nKFDBfS+z9+B4dJFPCUWS6rcXH4U/oQpZxGTLMdibmsGAKrz4ULJ77+9NrG2BRMrN0RE4nTpMgYoTQws6fmlwNcIFdWgfkwkOtffyDNbuCjTEK762p+4hutD7YdCAdGI/vHUoxUDo08VazbbIR87TI9Yf98OH0yfIsKoZNO7N/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0726.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 21:48:21 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6df1:c76f:a5e7:844e]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6df1:c76f:a5e7:844e%2]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 21:48:21 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: RE: [PATCH for-next 2/5] RDMA/rxe: Fix misleading comments and names
Thread-Topic: [PATCH for-next 2/5] RDMA/rxe: Fix misleading comments and names
Thread-Index: AQHW8HZacLSL/5nJnkSJxxUpyxxcaKo0CE2AgAAmh4A=
Date:   Fri, 22 Jan 2021 21:48:21 +0000
Message-ID: <CS1PR8401MB0821842A2477AB7CE0B8290DBCA00@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210122042313.3336-1-rpearson@hpe.com>
 <20210122042313.3336-3-rpearson@hpe.com> <20210122192725.GG4147@nvidia.com>
In-Reply-To: <20210122192725.GG4147@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:9dfe:2aed:77f3:f265]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a55060a-bf94-4455-0849-08d8bf1f701e
x-ms-traffictypediagnostic: CS1PR8401MB0726:
x-microsoft-antispam-prvs: <CS1PR8401MB0726667E63C15BF29354C174BCA09@CS1PR8401MB0726.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kar4vZ/K5f47jZtEb9WNzIlJKho6wPWlh3Jdq4py83TCWMjB/ZmBcjl0DFcAAxZqoMH3Cr6OS0bE8gTwxnr1ekroVXNBTmyHNvgM1TJWfVk5iV/U7527gpHH44A7HD5Ts1AEyH97dCXcr/RbNj46A5Jzm/JjgzNjXM+XNZDoCJzQd08ZNswD6lgJBpbI/wN7/+dAkakZzbaycECLYE+MMO8jgut+xtQuWzUBGo2k87323BPVHPpmIcTLOyDmH314m2JSTOkzCHGhZ33RvKt+H5EIvDTrqgdkScTXriBN+24vgLCdnSvW4Kc8eKv9YbawC4x+q1Azcdlt11i+tXRtP7s4was9UQUSk+ISteDupWuOtPrWr5G01dEptrR0GWRt0AzbMTzYCHtMRtdZZ2I1Vg19J4gf8TcWnuVQX60/IxINGJS1LgQk9gvHyIfY+t4y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(33656002)(71200400001)(4326008)(66446008)(66556008)(8676002)(53546011)(52536014)(186003)(6506007)(83380400001)(55016002)(7696005)(9686003)(2906002)(5660300002)(110136005)(54906003)(86362001)(8936002)(64756008)(478600001)(66946007)(66476007)(76116006)(316002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OorgWmJXRezvMwoU2LQkHeIxHx2J4JKQPRsclX+NEEQu+P48TxHQIIuy7x9n?=
 =?us-ascii?Q?E6N1/piLB/deuH0OrtBfbEUx69RwFUfNkfVdilGue+n+1DQVurIq3ug516tE?=
 =?us-ascii?Q?kzR/h0eWACct9GFKtgUVWsKvi5lUfnpFoZ0kXBop1TsD/zBDAF3o+ZaLYbd2?=
 =?us-ascii?Q?KHl+OKd+CczR1j8ArQiV123fBw3lNE3mF1QKHAzVwv2gAjLrA+ng5vD8Qmgh?=
 =?us-ascii?Q?iSR+fLAT8F0068md3GJk60DP6OBwJpq4TEIIQX/Z3OU3lYuxI3Ckues/o2kX?=
 =?us-ascii?Q?9eHj1GGioRNj4lgI6TDawt9uOWbvjdSKjC71Oa8zQkhilHNaPMHFIhaTFQVU?=
 =?us-ascii?Q?DxNfLyfCe2Hovo2GIL1UvTknx7KtS6fERmkbVY/WzOulpNkWk88JrHURLaMH?=
 =?us-ascii?Q?86hQGVzxOYclAh26KD4+e//8e/+kiud6TwEKHCSarcWdOhMaDRmtkSSmjjdn?=
 =?us-ascii?Q?3ZoAWUbLyVkdWUjxdD1d1CqNA6Il9wWhoeMPUXwpSKp5uM3X/4flHLmWPyjw?=
 =?us-ascii?Q?l6Cso5l1szBQRFjbm6s5UBoW4LfM4HDf24iDBqrVS9doRRU7svY/WEuSFelt?=
 =?us-ascii?Q?a+WnnX72BvAKC4oO+Z0Zu0NX9dImHbyjF4a9i+rD6sz8klzY639XKnUl1VSG?=
 =?us-ascii?Q?DMlqsYY5/4p6DDJ366STuVGWBOLElbmUpsZAOAt8z1SRe/dVZgo8zJEkB6b/?=
 =?us-ascii?Q?4IJjxSe92iA2MEyVHb6PlbBnkFnrxrxU/ss5Y9RgtJtZnT9CMVndyYfnNPgE?=
 =?us-ascii?Q?iTH6N6vT5aoLXLjsMRY1H57wfc6Udn1Yr2OpLRdjv7EP/abYmDv/knj+KU3r?=
 =?us-ascii?Q?9cVbNlkRqgXhOJB3/NiZ3rum4N+bb4mEwsszAFXDFXjU1SQ7keKZn5aXR/06?=
 =?us-ascii?Q?xjvervVkkbESLVDcuWsUKcgDY66EgVvifKN1X8rNViRqukmHMuymtT3xO7Pg?=
 =?us-ascii?Q?AgBkX2Hx/Q2MFqFDCjtD51j3ESZfLxqKvUsxMNkWczcpYkHaHuAPibFYouuM?=
 =?us-ascii?Q?ChPbO4CGuvRiUh0EHLhi8zmX+QRx2/sjfnJkbRCjQ8oS7Qs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a55060a-bf94-4455-0849-08d8bf1f701e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 21:48:21.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aERuUV3t0hOKw6bCXmYMBqs8XZ4KfUL0Y9n4o4lEfTePA9cd2LALNCJaRuzA51L/rhiLgpiN4bFZx1TV6uh59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0726
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_15:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Friday, January 22, 2021 1:27 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org; Pearson, Robert B <ro=
bert.pearson2@hpe.com>; Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH for-next 2/5] RDMA/rxe: Fix misleading comments and nam=
es

On Thu, Jan 21, 2021 at 10:23:10PM -0600, Bob Pearson wrote:
> The names and comments of the 'unlocked' pool APIs are very misleading=20
> and not what was intended. This patch replaces 'rxe_xxx_nl' with=20
> 'rxe_xxx__' with comments indicating that the caller is expected to=20
> hold the rxe pool lock.
>=20
> Reported-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mcast.c |  8 ++-- =20
> drivers/infiniband/sw/rxe/rxe_pool.c  | 22 +++++------ =20
> drivers/infiniband/sw/rxe/rxe_pool.h  | 55 +++++++++++++--------------
>  3 files changed, 42 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c=20
> b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 5be47ce7d319..b9f06f87866e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -15,18 +15,18 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *=
rxe,
>  	int err;
>  	struct rxe_mc_grp *grp;
> =20
> -	grp =3D rxe_alloc_nl(&rxe->mc_grp_pool);
> +	grp =3D rxe_alloc__(&rxe->mc_grp_pool);

Everything else seems fine, but this trailing __ is too weird

If a lock is supposed to be held then name it foo_locked() or locked_()

If it auto-locks then name it foo()

If there is some #define wrapper then it is=20

#define foo() __foo()

Jason


I have both in some cases. A #define and a locked version in some cases. I'=
ll try xxx_locked().
To be clear that means caller should hold some lock, yes?

bob
