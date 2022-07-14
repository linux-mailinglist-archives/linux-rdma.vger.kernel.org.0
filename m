Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967C574A68
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiGNKSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGNKSy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 06:18:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD801C101;
        Thu, 14 Jul 2022 03:18:53 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3eqcQ019044;
        Thu, 14 Jul 2022 03:17:41 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3habegs5w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 03:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZG/LZrSf8yw78uR0cK00xa3EVotEbciVxKr2KDXmmsp9TLs5PGV6DcNcVjHLEF6Ot303LeHdEfiAYsPsg6fs1LFBdGf4+6pBjNFpthmwSLaAxkTeOrVxSl0BmYHxU3O91uPZNuY3B5n+uFtHCbAJgx0ftxzbuPKPWyGXzqo5589UStz8PrhCPk38h+rjaodRx4Brhtat8gN4fO2RnPeDLsQxgqeVbMpPCuUJBHUGQXRsucIDTHg9Vs852NHSeaQ0YILVbot8scWRkBAoQrAnHFhLJvSw2Ri2uQaEnoM+vK7QxAlf3z4IJ6YTXfJzUgO7idqhf5nOnqm9wkJylgS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAlRLH5TM6GnFFcOk1MmWFCO2daboxwcttOYjvYS29M=;
 b=Z53xr52mxWX8oZGlTwB3QkcopMITCiZtjtYDzsLQoZmeAsu7RtN5UCuj2R22ovCGY8g930aLyyG669yMyvBnOGnHMroRXasOI1IuGd/LqEkOQsq+EJtbonoV0CepMtJq06VI9Md3xrwU1svar4KRHdHOSlsXmvvPxZfvC1p8EwxEkrUGeBLqOz0TQYPp4i4gcKoaQFKBC+J1RNQON7el02vZL+NQxOWTT2/nc61ApJwngL4EszoD6MXujZemKbSGvrm/kxA6FG45ircI9Qy9z11trvTDMv93Qd1M3Ltt0uxGbFf1NabrUGdY1kfCc49J9cnUpbdvSCLqDFxe51xUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAlRLH5TM6GnFFcOk1MmWFCO2daboxwcttOYjvYS29M=;
 b=hss9E/EbFkZCkAsXREnmBhAUnE6/6MOIQoFgkNuHLr3GagV1P8HkmsJqzfJPWhHbi6lIeI83M0B9XT+Ar5goTsgK5q5RWRTtq+IrcuCNXrMOwbK9K0iix1ZQKr+l5/ZFvJkG5ZloB5ZaIBoTS3Bl2yfobIb8gk+CQh54RugFZuk=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by DM5PR18MB2151.namprd18.prod.outlook.com (2603:10b6:4:b0::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 10:17:38 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::d9ec:4e02:fac9:22cd]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::d9ec:4e02:fac9:22cd%5]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 10:17:38 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jianglei Nie <niejianglei2021@163.com>,
        Ariel Elior <aelior@marvell.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] RDMA/qedr: Fix potential memory leak in
 __qedr_alloc_mr()
Thread-Topic: [EXT] [PATCH] RDMA/qedr: Fix potential memory leak in
 __qedr_alloc_mr()
Thread-Index: AQHYl0khiwQearHL+UiF9wPULANmRa19pyMA
Date:   Thu, 14 Jul 2022 10:17:38 +0000
Message-ID: <CH0PR18MB41299978AED8B666E5CC7F79A1889@CH0PR18MB4129.namprd18.prod.outlook.com>
References: <20220714061505.2342759-1-niejianglei2021@163.com>
In-Reply-To: <20220714061505.2342759-1-niejianglei2021@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWthbGRlcm?=
 =?iso-8859-1?Q?9uXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?iso-8859-1?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmQ0NzJjZmYtMDM1ZS0xMWVkLTljMz?=
 =?iso-8859-1?Q?UtNTA3NmFmMzM2Y2NkXGFtZS10ZXN0XDJkNDcyZDAxLTAzNWUtMTFlZC05?=
 =?iso-8859-1?Q?YzM1LTUwNzZhZjMzNmNjZGJvZHkudHh0IiBzej0iMjExNyIgdD0iMTMzMD?=
 =?iso-8859-1?Q?IyNjc0NTQ5OTQxOTU0IiBoPSJsZGNFZ1dIKzRrVXY4RTFmQ2Uzb1lPU1BD?=
 =?iso-8859-1?Q?T289IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-1?Q?ZOQ2dVQUFDUUVBQURDSnAvdmFwZllBZk1sVzBqZGhmNlU4eVZiU04yRi9w?=
 =?iso-8859-1?Q?UUdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFDMEF3QUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQXBkcWNrZ0FBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUo0QUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0?=
 =?iso-8859-1?Q?FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJsQUhJQWN3QnZBRzRBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0Ix?=
 =?iso-8859-1?Q?QUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFBRzBBWWdCbEFISU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQU?=
 =?iso-8859-1?Q?c4QWJRQmZBSE1BY3dCdUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpBQmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQXdBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc214376-c072-47e4-1699-08da6582140b
x-ms-traffictypediagnostic: DM5PR18MB2151:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9KaSUXvJUK4gYSnvnKwydct7Uc13QboHgTxrZYf3PEmUFXPnSv71kNvTOWi4Jr4bxAS9McP52NIF3qKBd3pc1+2ySexHqZ87cNhneFsJhzHfwqubyC6had7iuvD+EnWre6vNRZW8tdSkPcbTMBEA6KnWVFTdxKTtl2ILTPOn3cDd82gXsAQgAsKDAZfWpHEax3ZZ30bN9XTY+JvBGB2TGb9h+EkdURsoKumesfl8bwMKdSumn3REqfFv/GvNb0Uh09rIwg3UYX5g3BA8vL2SSG3h6JQnRL4WITfsWvFTYVdYGnrK/nRk2jPMa9Eg0I8WObP49atyhiQSHUlm2YX6kRT/TcZ/EC2IOV0bf8eoHofOWtK7GMJXITXqCvOuVEM/hk6PkR/Cqa9eCDddCKlc3P1eBFZyWj68JWf0L0jVYLg+i01yGJePEiOxolu2P1dTeGUOWgz4krR2O6R4xnZs8X3J7QwonsbY0law88SxmgX0STNMhWdzWGd9og3l+G1FYqVNXyRQPynrVLJ5h+65r2ghikLRxbrhxpBSWRhIVPb67Ium/e/ANWjiQp3nyqrFMJkJCM4LG72ayj7acdaGFl9J0lFPdTEAFAlNA8nuCqCTl8z/XTgP78bjk7+xpMCt2q4PxCSkhwWq5DZiPUXXxxWYL5SEpCUFBdBZcRijHMmFvyJBIgygdUqa1xEc6hlhSS3XtShH4bPpZ6gLVdv7BreV5KDRCgAuPWo3j9qAjHIjSw2kSuohuFfRClhGruOyfwa7Erb0vvjOSQKb0OxJNq6jGLC6pocjbNxBIasgw3TXVuaWZBSP0R2iiodXyPD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4129.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(52536014)(38100700002)(38070700005)(5660300002)(7696005)(71200400001)(76116006)(64756008)(6506007)(4326008)(66476007)(66446008)(83380400001)(26005)(316002)(9686003)(41300700001)(66946007)(8676002)(66556008)(2906002)(110136005)(55016003)(33656002)(8936002)(122000001)(186003)(478600001)(54906003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C0LM9LGGaI5X5WhLKEP5bzN0RnwbNgjWuX5xoDiWR9xaucX3hgCsti9I8v?=
 =?iso-8859-1?Q?cURlvLVg55sUK7XeFLA3MOm9Ua2BUBoSJ41G8eRv5qzoZY7Fsj0j2/Kkg7?=
 =?iso-8859-1?Q?/8FFqxciEcOacGJRcWLRbFl6TyrKb5ifpRels6oVNloFChqerJsScguTsT?=
 =?iso-8859-1?Q?UnY71lCHVOqnbIZv5X8DE87kvFWLXwcA1t/qviidMJsL0dVYETfbo85/GY?=
 =?iso-8859-1?Q?fjKI3mUi9WhcP7HNNceTFYRJ6DH62ZSLiIQIUy8dr90cUbEeiqPNEP7XvU?=
 =?iso-8859-1?Q?cqOYqJgYwOSdqErpe10SAnajKOUA3ZlYQ3tFV1kuliUWzGDhbWz1nuhmKy?=
 =?iso-8859-1?Q?DL4L0c2rzb7QbkqZHq3CaNUlBkxFIYTz4ltkBATpByeIDS/1Hed0AWMe6P?=
 =?iso-8859-1?Q?a6MrZGs5AWmIu7a5ai/S7pIGvh8nAlrNjKm5GdLV1KlIYUE3xQKjP053gL?=
 =?iso-8859-1?Q?qZ0wVzaWcWYWEXsQbOIgvwHL4Mfq5nShaAW/C0YPyZ3iGImyl8+irH/Rww?=
 =?iso-8859-1?Q?uw3N/hF9sQTr4AE/jao50kFiYpReKgyjdG3Y+Zmbs5Sw3E2r9PZs1SGg+C?=
 =?iso-8859-1?Q?SEDKT/tejy+qDSvMgBkAZAf68k9jRSPeLnL9assXCzXaNHubdVyWKlNjMw?=
 =?iso-8859-1?Q?KVk+wmUMdJtIJnJpIqSNrVpVWBAGCNUSZT8UZwaO3V46r6qiKBO2FiNNQ6?=
 =?iso-8859-1?Q?e9HI25EdgC73Vy/WP9HgUkv5nXEivriNYVHUvTTvnwuVJL29TEFlXawweP?=
 =?iso-8859-1?Q?v5gTph1ZR0NvGvEAFRcPgEMCnQAvgXBWYHsR6EuEB2UUy21K8V4Fa5Kj3J?=
 =?iso-8859-1?Q?CQjX4OK+BdiPxHL5HTOpnISynh0ZHyI432DTY8eau7mbCzkgx84JTDg4lA?=
 =?iso-8859-1?Q?NXPTG9IBElwavhUVvMwAFWrNjFw2Segax4mDjb8LIopsSmaz2TTK2nCF/X?=
 =?iso-8859-1?Q?rjN/lJhV5GZQkR3zWa6zO7s3j3MJRRY+s0HTFUA3BZiaixLpYXVv76QDZv?=
 =?iso-8859-1?Q?n8RySfv/9Yan1AnS4EDWL8TzcJoZOBt1IMIp6OA9F+UxGRYBrmaVwSprRF?=
 =?iso-8859-1?Q?V8V7UuspJ3EgcCOALA4szGhjSuxJC0PwgN1l3EqqJTB3AGRiAU2CFSj+h3?=
 =?iso-8859-1?Q?t+QVL4gyZazM1ebcDXdRDjIHkLD4/rjydPgjqKFXSKIWHAytVpUomnlMhQ?=
 =?iso-8859-1?Q?WZsfhiSVJzpYpIYaolP9yKlwEdzDth8BVYVBzgQJcnrrpMbAbbCUcdSs79?=
 =?iso-8859-1?Q?HYPifl8WamkZ7w6WRv9ln4o5vtey09TAehTrRWA7XVrdTKmKKFPypY7Pbm?=
 =?iso-8859-1?Q?PJV4uGfori7R1zAyXutyOlzfyzUwS7kxvTKup66OKp+SPuaXLs2Wv67arA?=
 =?iso-8859-1?Q?ZxqzePTwI4p/jP9pRnWBWXDejARZEs95vRZSv3X5B5uUETM2pwMq+yTAhB?=
 =?iso-8859-1?Q?sxRmzGaU+QQX+5JwQi9baTsUZL2aRBOZN2CJhAerI2P4Z7KSfQC5fAKdXN?=
 =?iso-8859-1?Q?9wWJ6LbmQg7J2M27JfDzFkfcqGp3VrVZ1XU+CDPgliTzpb2c1qWJ6KIwsE?=
 =?iso-8859-1?Q?9+b/GoC61f1Zo/X3ILHB0/6Wc+0OCSK1opkPcp7uctYZ8F6tMYH4YPk2+6?=
 =?iso-8859-1?Q?pS90oJmc5+SyRaw4L7b4eYFEoHtt14vXw2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc214376-c072-47e4-1699-08da6582140b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 10:17:38.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw3KWULgjyRF+7PB0XtN0w5mQO4XCispOC1DF2vz/gcjm5lOELMEYOZLN9SRrOS/7O2CUS/CyFLqevhnIBQeAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2151
X-Proofpoint-GUID: dPK2nUsVF4ioe0TZnUzcNkImlKbmhW0O
X-Proofpoint-ORIG-GUID: dPK2nUsVF4ioe0TZnUzcNkImlKbmhW0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_08,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jianglei Nie <niejianglei2021@163.com>
> Sent: Thursday, July 14, 2022 9:15 AM
> ----------------------------------------------------------------------
> __qedr_alloc_mr() allocates a memory chunk for "mr->info.pbl_table" with
> init_mr_info(). When rdma_alloc_tid() and rdma_register_tid() fail, "mr"
> is released while "mr->info.pbl_table" is not released, which will lead
> to a memory leak.
>=20
> We should release the "mr->info.pbl_table" with qedr_free_pbl() when
> error
> occurs to fix the memory leak.
>=20
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 03ed7c0fae50..d745ce9dc88a 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -3084,7 +3084,7 @@ static struct qedr_mr *__qedr_alloc_mr(struct
> ib_pd *ibpd,
>  		else
>  			DP_ERR(dev, "roce alloc tid returned error %d\n", rc);
>=20
> -		goto err0;
> +		goto err1;
>  	}
>=20
>  	/* Index only, 18 bit long, lkey =3D itid << 8 | key */
> @@ -3108,7 +3108,7 @@ static struct qedr_mr *__qedr_alloc_mr(struct
> ib_pd *ibpd,
>  	rc =3D dev->ops->rdma_register_tid(dev->rdma_ctx, &mr->hw_mr);
>  	if (rc) {
>  		DP_ERR(dev, "roce register tid returned an error %d\n", rc);
> -		goto err1;
> +		goto err2;
>  	}
>=20
>  	mr->ibmr.lkey =3D mr->hw_mr.itid << 8 | mr->hw_mr.key;
> @@ -3117,8 +3117,10 @@ static struct qedr_mr *__qedr_alloc_mr(struct
> ib_pd *ibpd,
>  	DP_DEBUG(dev, QEDR_MSG_MR, "alloc frmr: %x\n", mr-
> >ibmr.lkey);
>  	return mr;
>=20
> -err1:
> +err2:
>  	dev->ops->rdma_free_tid(dev->rdma_ctx, mr->hw_mr.itid);
> +err1:
> +	qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
>  err0:
>  	kfree(mr);
>  	return ERR_PTR(rc);
> --
> 2.25.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


