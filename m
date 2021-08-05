Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0043E1AB4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhHERqX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 13:46:23 -0400
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:54833
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232866AbhHERqW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 13:46:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa4igyG9ptrJVCTgPmfIGfwpRTep0NzEe7mpRy+WnNm0B0u+BTY8u5hzxqyKOcqPfmx6t3tCM4P5eE6fTzdHf+F6d+H5CMOMzjcLOOL1d0OaXI64VVR8UTZz93Q2ysVTyuO5AztgTrOgbD0Au4Zt4Y0x6d5/E9IONhob2CU2e1v4EJvaFhDTF9n7u1rabhyrgVRJrkJyEoJ35OF17pvHRwmpnLizUTP1Aw6UQQGwJp/3hs6pKrrOzFtnosn9KCOIZ6RRvmQht2FxONzrwnZ0gxWeqLqrNnM2PAtm/t+Rmxsqu4qtHcMNqgHCMRDmL0HviUbcePwyOy70R+zv5dijUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPEygOEvk/c1VPB9PcZgyclpaH/CEHbXUq/ZRkvDdMw=;
 b=iZ6niOuUs07QzAakLCbAQpTcNfnZ+HUbNatyKCazoOCsGzOgczeHsHFU0LI3BfQn0U8xNT/cjRv9nTk3SWamG8zOhaJgUXOzRnm5CxKj33m206nRrPQ9mMhlcaOYWfmgVJ8asugHDpBTAtHavl6RIh0EnEgu9YY4PU3/GeWk6kjqD/yatnjQdgIAP4gUrcQSa1dFBKywnT6Nb4Az1kxDyotQ1vYzvIHjRhLY82DNz0x5lxULW5SG/kyO97iAEH+OQOvkXoS3RDl62JNyT+P9nNX0/WHMRvDdhK6M3pAtLMef/2hMW70MMKD3b9FOc6sZ17RcGaGjwY3X+kfylIfB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPEygOEvk/c1VPB9PcZgyclpaH/CEHbXUq/ZRkvDdMw=;
 b=k4WS9D/mqkNXuD0wmiuvfZ91tGv0LWX6fHJtAl1a659XgqbBDBnbIM1BPSKcTcq4iRduxtg3DCAb2CChCdXgRInsy2VUl2gon4yUugcPorxTk8O27bw/5Dm5bNSx1IpinSZHV2d86BdKnFYKuHENqDXwBelhTHF7/03JaE4IcroOxCzjf0q/tUzLFTBD1svFV/n5T+DhGNiVFpuGNyKI7RUtx50lt8bx5Fsid6QCvIlnaPO745PJXqErxhYdNBUrneVJZgQJmZ3bfKkip39RuaZ7GdyNVthY9yupocA8RxnMGOPvUcP9cWwJ2S2ukW38ze8yaUJVk4YAYtzKonvURQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7092.prod.exchangelabs.com (2603:10b6:610:f3::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Thu, 5 Aug 2021 17:46:06 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745%7]) with mapi id 15.20.4394.018; Thu, 5 Aug 2021
 17:46:06 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Tuo Li <islituo@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: RE: [PATCH] IB/hfi1: Fix possible null-pointer dereference in
 _extend_sdma_tx_descs()
Thread-Topic: [PATCH] IB/hfi1: Fix possible null-pointer dereference in
 _extend_sdma_tx_descs()
Thread-Index: AQHXifUD6iEcfIFB3E6FFgZLqkJIZqtlKtHQ
Date:   Thu, 5 Aug 2021 17:46:05 +0000
Message-ID: <CH0PR01MB7153B254480BACBE8D2028EFF2F29@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210805122412.130007-1-islituo@gmail.com>
In-Reply-To: <20210805122412.130007-1-islituo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df08dc8e-5d34-48f1-54a6-08d95838e6a2
x-ms-traffictypediagnostic: CH0PR01MB7092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB70929BF7CC16ACF819D75B43F2F29@CH0PR01MB7092.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C44701t2PkNQL4aOWbSO+vY1JYu96qkxgJx8HDGwuXOMjMdOtid5xjBxorQxNbqG+f8n0jXRTmiz94Psc8TqOVTN3nZLPzCsaHEbXz01cmg8e5aQBSDTJ/+O8yD5tyqmFBqG54HsFOQeVLG5DdMXF9jri+YYL47Ma5/rRAtuyFr5i4vAH4se0IxH6wJksxbGwbM3OYIy+ULXmtLWAwR/l3K8P9ADmY0E4WRnWoa/6p7IIQuIP/Y2Kdk9eXhFDiQyQWcsniVmpbKjYVV6uDXJrBdOOaDVdalw20pM8FWSudy6lM8NfsJk0JrwKh3DAeZwVwap7OHHXAvvfB5YE8aOl6eKmURtatVcBfgI26Cnk8NqsRLpVz8OPET7puqkEOXkyAN4ZrJc1PNDts2sVIekrfen8QNUGRfmXfZjGGVMuh0fy3yhekph9K1BuO/mcPUeTMLxW4YkXActc1OiQ1UoFaAjAeUzdulo5dxzlSDOtSr3jMwzYUtBih5yJel61HbobjR4AfbB7Tp9NQLIt/1IJoJ824R05CNOlCd/RXka6C+qBY/XEWG4bwcyQLZmf9/owp6DprslkOr7KDhv00YanSw7PQokhz5WMeWy0d/DVaZSjjP7cn7cGSxuzKQMa1MW57Xng51MntwxdOnCsFWDKleoATfgGPeSbA4HI2N0mozSSaAU6g5EeENJcaq4JUcc5bP7aUW5U4Rc3pfbyuaQBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(366004)(396003)(136003)(376002)(8936002)(71200400001)(86362001)(38100700002)(316002)(478600001)(2906002)(38070700005)(33656002)(4326008)(122000001)(55016002)(54906003)(7696005)(66446008)(64756008)(66556008)(66476007)(26005)(76116006)(52536014)(66946007)(9686003)(186003)(110136005)(6506007)(83380400001)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MXgLLujP7//GNHo5ftOr7+xjscDXOw+aordl23+qJ5IzXfu9hOqVGZ3AubDo?=
 =?us-ascii?Q?Rz0DS/D5zZiafoiWPHxOx8fOf/Fnqpxkf2P6zGkr2SxU0bfMwvr+XVM8lwqq?=
 =?us-ascii?Q?0jlsNRPknQUjHCihH3gnLH63+OH4erq55h2KASgEQA2MLT4PDh8vC+71wZp+?=
 =?us-ascii?Q?cxtkkQujAjrUWty6Z9Lkxrf6gzD97ZylYk8i7N+w+sSgiGtx/zwUG1ZQ4vv+?=
 =?us-ascii?Q?YSEpAk1W/GNuaoIVuqpFCDYASJD46hxCGWAMHIBz1VG7K6fj2MUpwAJ4g1sf?=
 =?us-ascii?Q?7Hy/4ct6BQjIwxZx5qilBS6TZPUIB29wxuwfVMhNViwL31imyzlvKDS7KL32?=
 =?us-ascii?Q?bhjsDLjUC5XwGjNBa0X+wnRq4i4b5lQh+RBGL3JDIJ2lK+Yr6SE3calZx7uc?=
 =?us-ascii?Q?WHgCLYZDL4vlLToTEk21h9lOfnnI/Acc1XbdS8/Kz7uHVItC2TaG+wcwUvSF?=
 =?us-ascii?Q?ygTcCwxsUYxCqrr0ed9On3+R/fC0H7h0Uzh14qQ52WeR8YkKOc//XG8CpVf+?=
 =?us-ascii?Q?rRMqbUFXqYOwqi3NUGzroAXkNfGjZCWboQPKSf01YgGRVsooUGkB4kfd3uiD?=
 =?us-ascii?Q?fhDouwrC4QUdP8luBSf0W1si/+twsSw6vaQVfyD52ueZkJRFlrFKjNbdd24h?=
 =?us-ascii?Q?6KA9mhkBWbYVLWEb4guD7IpJ1wsOaXC57ZRuFPTpOOwUGstbPpuWqBVz1AHX?=
 =?us-ascii?Q?S6GEdWyifFIkcAtfVhdGXgSOSIoQ0XpwiX9JFE49520lLrgkKxsgr7wbWau/?=
 =?us-ascii?Q?OvZ3Hgf9vy8nYta8P/u0zVA6OOdMbVed3LdZoL6ukJrWkD6A2w4w8grdSLEz?=
 =?us-ascii?Q?eHlPbGZ+YcFOYDR3ypJ5vhMk35f5PYqez9WIvjxXtUQ8SwdunZ9Ay6bvudvz?=
 =?us-ascii?Q?Z3WnIy/bIQPbLd0ZLZaR7vaYm+zqeHqP2k7zIVsRPc86obNYa2mMILaR73nO?=
 =?us-ascii?Q?bwxnzHkVjReJWUFbKhv9JHchqUYWTznJhX1TpGMQnV9BGFlC6DfUhxseZERp?=
 =?us-ascii?Q?livS76YEDXU2GiCPZvKSBM35ToYxiBpyI4w067b3noL5zbv1uC4o/nEGxdxN?=
 =?us-ascii?Q?5iqvIZcBvwIPii8wr/qf9Vtu972kfU/IBbYOq8bAI0MkGodA87PGbZ1yGwSt?=
 =?us-ascii?Q?Zy/fnXWoSBivIUaobP3gAuAykVDTh3WOoSvNnA4VOIl6wn80wN3/PtoWfZR2?=
 =?us-ascii?Q?PZ8gjDnBG80lHok+4hPfzNPmuWZ9TTVsrW3gWvl+mHAhAgnZBeN6cApUkwfu?=
 =?us-ascii?Q?42oL/bQHKqqOCo583/8AdLyiQB7Riu7lNaKBHiT0d06q/k+JzY4nBYDnOqhJ?=
 =?us-ascii?Q?fag=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df08dc8e-5d34-48f1-54a6-08d95838e6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 17:46:05.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+BD09poYcRRM8HhK6seZ62xgZ9SowPowbVG1LElSGLN/TdUrPpW+d6eJzqlthB4sex5CPqXZ/mxkhgNHFOJgXdjqrXom4ktxG8RcmEuZIKA9p5lQmgS9q8+G6uZQDng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7092
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] IB/hfi1: Fix possible null-pointer dereference in
> _extend_sdma_tx_descs()
>=20
> kmalloc_array() is called to allocate memory for tx->descp. If it fails, =
the
> function __sdma_txclean() is called:
>   __sdma_txclean(dd, tx);
>=20
> However, in the function __sdma_txclean(), tx-descp is dereferenced if
> tx->num_desc is not zero:
>   sdma_unmap_desc(dd, &tx->descp[0]);
>=20
> To fix this possible null-pointer dereference, assign 0 to tx->num_desc i=
f
> kmalloc_array() returns NULL.
>=20
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/hfi1/sdma.c
> b/drivers/infiniband/hw/hfi1/sdma.c
> index eb15c310d63d..00e29c3dfe96 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.c
> +++ b/drivers/infiniband/hw/hfi1/sdma.c
> @@ -3079,8 +3079,10 @@ static int _extend_sdma_tx_descs(struct
> hfi1_devdata *dd, struct sdma_txreq *tx)
>  			MAX_DESC,
>  			sizeof(struct sdma_desc),
>  			GFP_ATOMIC);
> -	if (!tx->descp)
> +	if (!tx->descp) {
> +		tx->num_desc =3D 0;
>  		goto enomem;
> +	}
>=20
>  	/* reserve last descriptor for coalescing */
>  	tx->desc_limit =3D MAX_DESC - 1;

Thanks for seeing an issue here, but the correct solution is to store descp=
 locally first.

Once the allocation is shown to be non-NULL, then store to tx-descp:

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1=
/sdma.c
index eb15c310d..b6c554a 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3055,6 +3055,7 @@ static void __sdma_process_event(struct sdma_engine *=
sde,
 static int _extend_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txre=
q *tx)
 {
        int i;
+       struct sdma_desc *descp;
=20
        /* Handle last descriptor */
        if (unlikely((tx->num_desc =3D=3D (MAX_DESC - 1)))) {
@@ -3075,12 +3076,12 @@ static int _extend_sdma_tx_descs(struct hfi1_devdat=
a *dd, struct sdma_txreq *tx)
        if (unlikely(tx->num_desc =3D=3D MAX_DESC))
                goto enomem;
=20
-       tx->descp =3D kmalloc_array(
-                       MAX_DESC,
-                       sizeof(struct sdma_desc),
-                       GFP_ATOMIC);
-       if (!tx->descp)
+       descp =3D kmalloc_array(MAX_DESC,
+                             sizeof(struct sdma_desc),
+                             GFP_ATOMIC);
+       if (!descp)
                goto enomem;
+       tx->descp =3D descp;
=20
        /* reserve last descriptor for coalescing */
        tx->desc_limit =3D MAX_DESC - 1;


