Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73772DA1D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbjFMGrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjFMGrZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 02:47:25 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F510D8
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686638842; x=1718174842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DJh7yBQYN/50MYesl0ixI2/Bqz8WgzWwKqAakdVEn7o=;
  b=SPFD3HHUZ4/Y+h1T/K7TBG89Fkvaj/DxB6AIGGWN1pJdjfAPW1jJxFns
   z9TI3FFQniXVhWgOdahLeU4nzEsIHyamREqCEdJMTSiJgUCZ6s/Mtt2Pq
   omMNZvxpig17AJ5TPIRcKmzU7xxOds3F31Kkp83MoI94eBuzNfvunnNG0
   9Jpvus+g3F3Fl2gfQR7NEWijWUqv7FVel31iOZ1qI0oiRJDowkHwu2I5j
   +7yR11Ohk09ACt13/zBxpF69ufeXXbGpXY0FqRvwsJROTSf/qqT9zfOwZ
   XSXjRk8hdZ/G/X2k5aOYCF64ZNLZf1wPQR3T8CG73LZ6oWGeoyxL3evrw
   g==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681142400"; 
   d="scan'208";a="239921519"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2023 14:47:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3Jz8AIIuF4uircKkGeQ5Gs134d+HVIZpaDhmXmqcBZxGx8pEvFbrIfUXtHHx+VrJyA79Lai1V2LtpUlcVxi58HaFOy/caAfzxtVqcTlPp7sJ2a784CJRw5gmAiH6FsPc5kk9DG5iT1LrCs7BoU1drjSgdhXIfUTDvAroKl6EyCl4ypEXKjVhkMhw1G3p8yld2KLi1QGLZ6IZBudq/5AZc28NQrCq1dijjVQi1B2geInQmKXUw5orui8tUFEl1UrxNm2lPEk8fOzcra8xRlMvmFNirgvA9DnUJdIFeGooVm02YTCTbWaufCB6rT3RN5igmcNVlJqlGSfgXGASehjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJh7yBQYN/50MYesl0ixI2/Bqz8WgzWwKqAakdVEn7o=;
 b=io8TbDquhHf+lLtnuKdtxRhG2rR6nGT/jO7nSzexMB2Vne6TApgFRHzKnPbEPyoSRqlQDqAHLcrCRD+8L3mWoXNGrQaIw2eXqH9DYlOmb87TFb9yTfeP6K7K8O3+RrdeSBPx2xKL7dDDBHsf+oIiuhdfeJhp+A0DmeKZyuqe1Hd6yHqe9JszCxkTq14VhDPBDjAp2KQDjlNZFTQurvYb9o3dldcwFK4jgERkOKdupBpt+RyvARRWuba0Zx1cHbcUPeDKjxxZMu7w6cXCtSHwiS1hkOFTCoKLOvsmeul5eEsHoqnDqDittUxz5e/v5CUBI7evaUawyUS2KMYozjf1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJh7yBQYN/50MYesl0ixI2/Bqz8WgzWwKqAakdVEn7o=;
 b=mtw6GzHEmX3I88f0H7ycus5UlIll9WAM8Fk6C7MKhEPDdV87Loi7v9EusFtOMERrjQ8sfY9Cm20BNIS12c+ToaVy/l8pE3GTnAT0HgScQUkADPVZtJOBJZmPFvOVAXQLmOusp694BnEbCH6dPjfVF7CaMyFMWvQTKfhY4LJ/NsA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8510.namprd04.prod.outlook.com (2603:10b6:a03:4fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 13 Jun 2023 06:47:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 06:47:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Topic: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Index: AQHZnPC2s/8x06ig6k2H99zVQRnT1a+HN4aAgAC/dQCAAFTTAA==
Date:   Tue, 13 Jun 2023 06:47:18 +0000
Message-ID: <6bhvt577yfjsqjgfqdm7h766xtw3g5aahn23zzb6gplnp3lz7y@ylgwlqdwylvw>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
In-Reply-To: <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8510:EE_
x-ms-office365-filtering-correlation-id: 02672d52-b11f-4419-1fb2-08db6bda082a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IllmKGc0DMqz5pCW32O731iM6thukUg3hMSBudrx8roeoEbYFZ7/dvroxB97rYrow85ZLVl4P8UffF7+4+xUUJM6IcqxZPcpgsg2j/yc+ccEA544V8uNY+S/yTX9/GzwBI1HPyaFsd29cnhd1VNINeSe65cQcgHMoXaOvtEnxoFo5Dvd5DEDemPVA8+07j2HonYD+UkdykUrLqf7OKF+RpDgv1+aDpLHkXoGHgatAO/pWsFX+ybGte8GIrHsDurz2+nTm0+iLb4x8OX/VUdBUupoHMqrJpViBV0SDMJlLXPVbaPOGlKMKztYpAi0TKNgLoymRyfB+XdwYkHDpQITQcqcptRvQ6J5noOevmsgBp1e+xwJorTAa8nWxq/iWBLJJQdnhTNFbiODR3nysFikQZR3LrbUN3tDtfV4IdVRPQwFy+vOgwa4afzQOzwrkIYVNLHWNiSt9TorHdUF9dyy8+fC4AmSGWztvUcOzB9HYnJhI5AJl8nQaKrft2yV3IjbpORgIpGYX+35coslupDmR6kHxV0Ij6uUQ6wNuK+HfUWv0oIazlYGIr0ynj+QRyTm230ZDiu7Csch3XQzFNYBVy3fJLKdHNYos9U8Py1A9DWlc6RiqmegfyvGhLE3TtVwKKnFF2Clvk31QiqUdNN1fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6512007)(26005)(6506007)(9686003)(186003)(83380400001)(33716001)(66476007)(122000001)(82960400001)(64756008)(66556008)(66946007)(2906002)(4744005)(76116006)(66446008)(41300700001)(6486002)(71200400001)(54906003)(8936002)(38070700005)(8676002)(86362001)(38100700002)(5660300002)(91956017)(44832011)(478600001)(6916009)(316002)(4326008)(27246005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z2hG4K6XsHedTx4IriCO/MqpAKFNt0s0cQlWzXthCDi+xa6Ex2R27Ck+SxwK?=
 =?us-ascii?Q?9j879Lob/dmEnmXb9WJY+5W5I1d6mAzat1mEObwatN6GGTjOoavzFEafyeXl?=
 =?us-ascii?Q?sRnpAGW9m3Pi1M0QMoVFA7f0uIZ3/maaDu5oOd2bG7BwbN3eY8EDiWS76Oi0?=
 =?us-ascii?Q?lmsXHy8tK4huq4q7y1BtiS6vV0Arj0oH/tyTXr3PHJEHUJXFslKuhvM3FpGj?=
 =?us-ascii?Q?pm4xZv45xgdLpTim5KPnAPOQA+hNCXS6MZk1EeSqcw7YozbPnDwhkug4hk9e?=
 =?us-ascii?Q?wKVHwiSXE0q4yxUWePw3gZ7bYqNuYpqvewX8vOSqgY+i5fcKt44Vf7enFb12?=
 =?us-ascii?Q?iS6afslRp+krnquPEhO9dbs9To5HSgW5m+IlYD1iTSdP0XXv5TVAnmJKk1Bt?=
 =?us-ascii?Q?pn/0nFW4x4N4dK7sC6cen3THmHNq8E1xdZ0lCjd++BtqQM+LUGWoL0n5E9Cg?=
 =?us-ascii?Q?pTjhzPr7FdZdWJvblonJ8ADGo5YjgYDD2x0FRR0tm0PIAMcsAOvudUeBLLsi?=
 =?us-ascii?Q?t9RPEwaWMVkSUymtno8YMDyJeF3dehohofSwwM3Zy/FU+WagJjzafJAUbRsa?=
 =?us-ascii?Q?ufehHd9DV2selwuqBKkoK4/MKg2SCpyuqVfH9NAp0j9eOVn54XB24gpyNoAy?=
 =?us-ascii?Q?79WJnE+xTaRMTVDxzoJAO/rvB4wP0QNrdUteit2oaGp38ElTzGb67T564oMw?=
 =?us-ascii?Q?uKSbruqF+qcxatch2SGSkqDZJYlCustzsNJ3tH9B0ojLB2MoPpcUlfj4nVnB?=
 =?us-ascii?Q?ru6tZVFQ8hpT+KpORxInF/F4KaV9bs9caveHQ5oC2bcreCSGQpCf3GFeLLWh?=
 =?us-ascii?Q?SA0V/ARkgE3OF+Hn3I4piokxMSDf2fErFO87PjrYv1iYVOwh7ZRw7C4Qenak?=
 =?us-ascii?Q?0t3/PS94lQeXFEenXJ1vMqolxDEq18jxqujobyVd0KsXS+D82R6nvW7226xv?=
 =?us-ascii?Q?boRZda45Gan58aQzXRoVHBhfVHWL2lE3jgIRIiFmKVDyQWOOH+thrJoGDO8g?=
 =?us-ascii?Q?ItPaWl+SW0CbaLTLXuBEAQkuQpAm2vP/UGQRexH23LnYeCKJa01vKfpIuNwk?=
 =?us-ascii?Q?LfRcmUEQ+cMzXwCf5k1ImkbOacuGvfgzQuUhf7mT5fxLlU1HsYOGIMdJh6DM?=
 =?us-ascii?Q?AKW473ZKbzYOG0H2Hqe0W0dVnG3weuGIwwT/f/9aYECA0HnqGg2ybgQN6nSt?=
 =?us-ascii?Q?IWLiZve5swHj4GeEutpduwltDn0YMvc3eX3LA+35vHJ0f3/YEpRhOjwN/Sm8?=
 =?us-ascii?Q?aean+/2Gegg/NJgM4hrNfkJ+tvKghHmke8cr6PdkwCE7o6B5pCTbCgVnGQ4I?=
 =?us-ascii?Q?5vt/m/CTVsnLSUfP8UgBTdBdDbV5DYDA7i4xvQBFmOdqDVbTgnE6QV2A1fQ+?=
 =?us-ascii?Q?cYNbNugGpTNTj2o/c7XOIJgeXzAtISS+Ox8MajNT6XQ8Kalqv6uzPeeDaqBW?=
 =?us-ascii?Q?XWQSkVFkb7ak64nO9G6UeUYIzF2qnmf3LaD62MKZY1Muk8dvgAic/Qtj/2Ft?=
 =?us-ascii?Q?KZs7lsE2t1UKNBsZvwG9CWtdc/KEnrQ7o6RJG9pG1nkvgf5iI0NfiQBouBaU?=
 =?us-ascii?Q?rCGr1FzxAMkbON+1kWF0UpzOfYDeu1vXkWhnbI4EQnbyPRqDmpkM0lgzysjj?=
 =?us-ascii?Q?cHC3k7mSJdZ0XD9ok0JKUlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBF3718A8271E341A0C1952AF5D4B8C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /Rje7eabyguokFEVh3JnrjT5I2TsfT7CPEkorEIaxNI17tr4zu9oekSZiW1HQ2TnNDo0TrYEvfu4oql5ObHCwtlcpp4TpCZPeqCRb0xlk4DnhnmTSmjMmg/B7O2iFAF8kavJ+OEHJBdOp3Igy/fdwePpXLsbgVcjVMvZ1EbektIrfiHtHbwX5WOOTCvwW6ZGeF1w5j4eXPk2EXB4qUU6ta8+b9IO3U48d9qhIsqXXOiDKCMlFs3Hfhhn17U9DfAcMXOu9JsjJPJINtMw5Fw5o3SLth7yuIZUyD46J4Psv2oldqaNrc052jR8/v51da3KOeL8lVBQ6SPN7Q+dRvDDoR6L161lGCiaOZ/f0xCO1VWrO5JMj8RVm5hPvGMVe0K8bEw4ivNbrXhB74i+p0EsWVQRW6GXQQxGtIgPnrrmJ46XooJ5VuKoqfgM+qsNIFVSird69+dAGSMetH9yt9bMpjG+gnqYD/gVbpiWR54aEU3WaHbp0yR0j1Ban2RWrzRS8n0zdrgxqQCAJA5xd/KoQe3xef1rebgwcJm81GJnLXtA1tIloPCsGiBTDuWn3vsT4FIOhr/QhPVOlGmQ6x8nMYDVBN46aI8kxSg8TY3HImVmtolfol885BIYc6QyJg6tHXqJqd0Xy8EDZEcuppJGbH4WkSkkfgUUduT9NHX7IrU5m1RF2ughqNW238kHZzJQ1jHnrmLGCx1bIyxCJQvU7V5PkF/+ZLNQ4Ko3QXLn4k/ZSdaF7npRSFkWLtAJmPJC5wWbineCR3xueLb5nsCHm1HNK/O9RTddJq/VtN7QtX57wKE963AOYKqjrH99BE19LxPnhG86/Lzbtt0Y6+6WOt7Hk238WrvwExEDjllOI2aL8WQqTJ2Ulfue+JYA31Un
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02672d52-b11f-4419-1fb2-08db6bda082a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 06:47:18.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0PkusqEwRtOYfHNBxXXW2dAww9vH/Qh+FNBXTK2cSqsOByQZGog0/I/L5oWwkKm48nsBkILuODlfmXJQX1g2sE8Zd8N6qIEoxpN7WgmyBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8510
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jun 13, 2023 / 10:43, Shin'ichiro Kawasaki wrote:

[...]

> My understanding about the call chain to rdma id destroy is as follows. I=
 guess
> _destory_id calls iw_destory_cm_id before destroying the rdma id, but not=
 sure
> why it does not wait for cm_id deref by cm_work_handler.

I found the commit 59c68ac31e15 ("iw_cm: free cm_id resources on the last
deref") looks related the issue. Its commit message says that it "removed t=
he
block in iw_destroy_cm_id()" to avoid potential deadlock. So it looks cm_id=
 ref
no longer guards rdma id destroy. I'm not sure how to fix this issue at IW =
CM
level.
