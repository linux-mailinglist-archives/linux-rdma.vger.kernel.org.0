Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526367A1F0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjAXS4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 13:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjAXS4I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 13:56:08 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8244DCD5;
        Tue, 24 Jan 2023 10:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJVXI19vAMbDiQ3irxK47OHOWP+uhkBWC1mA3naox+c7CoziTpc94JfXAZO2PX1rLolScfCW5jvizdbu75ClrfGW1Quzteih3Jb4+XnW2ZxQ9PQ2qIhRhae72API2n/qxqabilcokQNAMMz7kQwdMhdYsIbcztpslinz1K1+3mAUyXvpc9/3wjgpP8VpSUYODfm10qiSlsnCXDeIIZiTi4DaBSV5qB/Z3Ohzo2VPbk12M+pdKkw8dPxUcAEOevA0D9F9GbYeEZ5PnLTn+Na0Qv7ndfmjP1r3NyhrievdwBOSKqYZP4/qD3erQ/TxDyMX9qC+Ej61HZoFri0ZTy43MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mME8FARB4dSGK29g9XHV9askesAK2bSM036M5Vut2pM=;
 b=GqPViJITomE2COcg9QjK5J9AZaP6+3z4wkeuFdAyyGs+zturoyXkQeqMMYGiNekFXpxdxpkmUi1dPEeFnA0QT4oRGwX8tDHcgaLlFBTsGfeGe5XJCuFJBrDi3d3WB56tkJBuRZG08+Kbo+3HxQ1zDsh90/WxixDKBAovK0Xqaz1oPm5nEMqY6KG8s3zwyo/QrzKxV7tR+oGAVXFXIDPJXO3qL7zC9wwT6xVR5M8P13u7Sdjx20LTGqAl4EabRZXgW2WUQ9qQOdMyShy8YGF5fpzgGa6D2/TAmGmrwUWU3ED0dZFdfy0vLj2odJiVjcjawfti88E0U+3FF1H+GsnVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mME8FARB4dSGK29g9XHV9askesAK2bSM036M5Vut2pM=;
 b=aU7SSXuhEaDHWHTL+sC6Y9dhcI11yN0hShR+u2ZFevzPFRi11CmWBsqGIvuIMslaj+dqEYmZTrt080/guVHYGr5pv5eDgCKoXXxIxFPVFK3kOglkPcq30qZnYU6Mzh0rzmTVDj4Jn7DI3PmN70YoDf7YtgpONMXH56qZrKfv2Qw=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SA3PR21MB3912.namprd21.prod.outlook.com (2603:10b6:806:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.4; Tue, 24 Jan
 2023 18:54:43 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7388:5f0b:577a:d9e6]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7388:5f0b:577a:d9e6%9]) with mapi id 15.20.6064.004; Tue, 24 Jan 2023
 18:54:43 +0000
From:   Long Li <longli@microsoft.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     Ajay Sharma <sharmaajay@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Thread-Topic: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Thread-Index: AQHZMAd6D83rME9v5k6DPqU5ey3Mu66t6bqw
Date:   Tue, 24 Jan 2023 18:54:43 +0000
Message-ID: <PH7PR21MB3263AA0044F1710C16F41197CEC99@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <Y8/3Vn8qx00kE9Kk@kili>
In-Reply-To: <Y8/3Vn8qx00kE9Kk@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e036d91-cf49-43d3-b236-30101b8f3f0f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-24T18:51:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SA3PR21MB3912:EE_
x-ms-office365-filtering-correlation-id: bd09d5ea-56d2-4a1f-386b-08dafe3c74bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdBr0zDcfHH3iXs0hEjsmIXXPOPu8DeSMJ/Wi85YMoyOsfA5aCI8ckODlxf4AdEU1agnD/TacjtuhSr8BkfpYYtPDt9xoL8YOXRb1Z4OsVDI4ZVY/NBuII8mnlcTopMemAOKRxKoeYcmy13aLXPQa4QPLPKv3FHCbkwg5e3sN/cdv3dfIOvTnRC750R9pWOKtv6p93t8L6MpRSMeAV8FzZj+SqKnmA4BPuy3IiYiVZ2i5xaTfvQVIYNPAGOW4rIzKPgO0WJIyAjrr0EjimJRuqT29yqjzMKej9sx9iRAfBjqib9kfqi3IQxQchMs5dTJOX7NPPxDERtyvWY6ONSkw3edqzYAaTLp472yqthAP4iyU9jdQXbbwrei6/HQWsyLRPutpB85CAM395sieX1jOg+x6OWcmnSqQoIT1bVrr14dG6+uNLX84BMoqqfihAsy1dpmEGR6oRvS/gY8OyiaR5BMz0x7hALoMRNRqb5WPlDKsZu+kAgF9XgYSGHVejZDrXREMxKSOcpEVEcrPCKXtsqUpgEk6nd1Cymlo+62gQZ96TWlta8nptX4pP7xXAgJoqAJl6e/MU0AuOL3oEHKmMtEbn/JOMh3Aj2nh1h/MIgGnGwSjZhUxFmxSbjNgUjssMHf8aG6V2i/N5SdVk+dslEA+9tbTwsXlX79q5wOtFQNNWk69MkYOv9q7dW8Kr/RglNVYn8q/FwaTMMUcZbp1sJtRdupt7EUswWcMl0Q2LLrtcVjwUnUFNy/egJ6U54d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230024)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199017)(82950400001)(6916009)(82960400001)(8990500004)(8936002)(122000001)(83380400001)(26005)(38100700002)(5660300002)(52536014)(2906002)(66476007)(54906003)(316002)(86362001)(55016003)(33656002)(38070700005)(41300700001)(478600001)(186003)(7696005)(10290500003)(71200400001)(6506007)(64756008)(8676002)(9686003)(66556008)(66946007)(4326008)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G7Dj4miCxnCfRIn5T/C3h6X4xLhj6BJT1Jt+8FlEGdEn1Dbw55b/zZ6TKjPH?=
 =?us-ascii?Q?Hk/DgKKtsGsoyIXVdbRvWaYqaEvE5BoCJoPbs4+3I/bQfnNrRzvO7EHzvG1i?=
 =?us-ascii?Q?Gw4aYPzz8YvpMDHX6tTyi9VgIhU+LKD1yKNrNlv+L5nmm/Sya00ck1kaS7Gu?=
 =?us-ascii?Q?1sAJdckKyRbbRRmxitNNufYGC0p+eapvVO5D8FsJY3P/6RhG2cSYaBKR5glN?=
 =?us-ascii?Q?QdDV60KD27Zw0rnc2x3LJViU0/26F1zlNGFiKXFFqFNWUzPS/uALNdz1zt83?=
 =?us-ascii?Q?DT1w5O6b1j+BLAf3Yjswkzaq64QPSFiq+qpNT4doLrYgsC47NzqEilmoTnMd?=
 =?us-ascii?Q?MB/ja02Pd6lbW00v3RGXzJ8bSflUBOFVIlCeDkDrKgMxTN2Q1YO7S7YJI2LO?=
 =?us-ascii?Q?3Gy4zfjOhul4arfqvEndyE0gzSWACY0IJ3UY4yMkWhCEYEYnuYcB1RjVWx65?=
 =?us-ascii?Q?0H8oJiBYYKWPBQiZR0827XTXKSzGXo34M0zqCBRuTpBF59DXw4wNonUzZ4KN?=
 =?us-ascii?Q?eOqrB9cc7kPk3vCYVqatTSz3TU2Le0rdjuJbWrwDNk62nAApipTCYszjXCxX?=
 =?us-ascii?Q?BJglZ1VhxB+mo1iCgpJPTlzioUsrF/kepNPowRWtf09Le3fM5sGMf9kL74tb?=
 =?us-ascii?Q?hxHV3tjDHZT2DhY0wIh72K74z5nTSaU5jwxqRFIWMeE2UHHcevhRknwK4PZ9?=
 =?us-ascii?Q?cF2m+rAQ0ggr2KMXJ8sEdHfOdqekgim4bCA+LXVkdSeyChygztkkpsxiR+Ex?=
 =?us-ascii?Q?YaLza4PrsEcGuhkXRk8ekJa9CU7WmcGUNqXh7TrFfAjEKMrik0IKgHEZYeE7?=
 =?us-ascii?Q?iqU2SrLkBwtN4a+rtUZ2yhOIAVNafk6Ut6zTYH4RC3mh/QantqWo8tbEYBVl?=
 =?us-ascii?Q?rM56aVjgXxN4/rBpWfIjjzu30vTb5PhbYZrof5HxdS/AV/V/b/A6IK2qbjVh?=
 =?us-ascii?Q?z9LLRU2cWCXvDvU1WbcSidblf1Fg7DFZplNMR3JnRsbM+gZdtGL1UFyfBMNG?=
 =?us-ascii?Q?nkAajKae6Xx4jRQpjg4x8SQlWu1goFlGfi5dXS0gnJ0urltm4/zsz3OcVZBM?=
 =?us-ascii?Q?3Oj6uFB7w8Ipktml0nwjoJ4G6dt0YDKrdteBkEwrUHpMyz5/Cjfmb6/iRyDd?=
 =?us-ascii?Q?uwKysblfYY2e2vJDTInzA2yNWd2tjrLWduPyEEGZazb8HOkDsyouuRDFqI3U?=
 =?us-ascii?Q?mmisdeJrYaBRCnUbS7/+uoIZ0BIRx4r22fMdsLX0RADnZBAunEjSaFdMKwvm?=
 =?us-ascii?Q?UL6BryiRTeZPADmiHp0z6qIoCv6haP6+zR5ACAhrRgEelzSRhQ8e40koFFtN?=
 =?us-ascii?Q?c0cjMO9Dt0pzKB20xn4t5ng/rWCSOZbB7Nx469SD3C2rOGKptLy2eXzLNnfq?=
 =?us-ascii?Q?DnqKgfT9KumFNdP8m4ojo8wV+foUReAdekrFELC1YECd4xwQR4TqKpapwnmU?=
 =?us-ascii?Q?L9kidD7hDns2ytTbGAYCMnN+P118R9uLC5wfwk4g84MnW6n3GHZbFUgpksOQ?=
 =?us-ascii?Q?CF5Ch+rRPl/DklqsyY2MvgSNWf/zlPzzctiZ0tuHKt99BkJPatZ4h+r6tveR?=
 =?us-ascii?Q?MGKXn+Cl7N28GZRr5LpC+soejeUcn00VbCEnziFE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd09d5ea-56d2-4a1f-386b-08dafe3c74bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 18:54:43.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPzVcGuDYQB4dWAw3o96qy6tbQfN11Z4E9pm5eiE1ou3GrLhlDOvLeiTZzFCbBxrLh1jBUqlDj/YDsUzfU1rbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/mana_ib: Prevent array underflow in
> mana_ib_create_qp_raw()
>=20
> The "port" comes from the user and if it is zero then the:
>=20
> 	ndev =3D mc->ports[port - 1];
>=20
> assignment does an out of bounds read.  I have changed the if statement t=
o fix
> this and to mirror how it is done in mana_ib_create_qp_rss().
>=20
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Thank you.

Acked-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index ea15ec77e321..54b61930a7fd 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>=20
>  	/* IB ports start with 1, MANA Ethernet ports start with 0 */
>  	port =3D ucmd.port;
> -	if (ucmd.port > mc->num_ports)
> +	if (port < 1 || port > mc->num_ports)
>  		return -EINVAL;
>=20
>  	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
> --
> 2.35.1

