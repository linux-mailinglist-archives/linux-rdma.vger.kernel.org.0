Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A001272D711
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 03:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbjFMBnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 21:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjFMBnt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 21:43:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9703171C
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686620627; x=1718156627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w4X2k+SuMky5x9jPklQ1w4bUNIaSPONxnssk6VKNprc=;
  b=Qd8tag+PjyXQH0SzM2htM4UzJmMosJWCIzENOrCe0hn9DC0eFb6BZzfI
   fY0kTbv8uFtP3UrZfKw5iw+OgwBB6yOyeoYMfMaJxAIud8c45nbbn8iB9
   o9OVn6f3yvbNP19APkdrMzFeDztsI/mumhMnopbfo1AAidmWRtghU4uGA
   jgEQJsIW8jbblTMAAq9hgg4bKGPeO2arHvkXfiwhljJbHQRoul2v4ukI/
   SDHuI5EfePRI/n5o/5VbP6jBmaXZa0S7kaEhCew5bkSQY5/ape8Sn7QX8
   imNUkXdazCqI+b9o9SH4r34gkSslJuCQ+uX8SB4ICj/8OEU4aqBGpfubo
   A==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681142400"; 
   d="scan'208";a="340143178"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2023 09:43:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtnMQnEc2SxLgerAmT6ZLu6r/BRXcKdwK2YPjL4lPHWixafo76ZKbAgSUqJ8CtjOIZj//6Qx5QITLzzHc4sz7VJnXyPtSjRLwTg0S819Kbw5TnVhJGVG2q0kspZekUkM5aszND8d3wZdg/VFl01VY5rG/pSZO1AxbFg/NNMAKsVpgoHQIPXCYAJlSNWoXK66IuWZSWdDjIgiqArQ7SqmMNXOYeGou2iMhw1MmfwzsNyI1pj+Ky+KFSVdYmzNHzkARPkbaNwaZyghdcM/8cUVFGKIO5InNAXkjBB5YvpSDDfoXAIq5PLkFCZxedq3RpBQhSMJLmEuSuFoBTj0rTZZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QorPpQOcapOMIsF0a+SnMv9E3k4nmhAk4Dh8wvBOpWg=;
 b=nq3Oq6vRRQcRGRHKu6S6mgpJI+n4CjMfkMxMAES2qV4n5OOXdMYaME4SlEFoGh7dziRm02OJoXlM7OQh0EPwj8AhPmpSJWUWZGcXpeihY5GuJOzLhlcsrEJUwyFqmIUJcnI6kwdfSSQIEeEnS9qeZuuiXBg9spMe386RxoF/jzw6qKOlJqN7BWMN0xG8bJ5J7fOJ8Hw5VG5jfY3IecKehbrM0dxW2IHb6EVVgGY6qxlIginT/JN36Hvx6OEuQ3NncJYaNWgoJdx679zPKcWvinL0iWHqZBJAG/2DnqmS42OTILWxO62OfwIZbtRXmRConuSb9WJKgAx1Rurd9fFVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QorPpQOcapOMIsF0a+SnMv9E3k4nmhAk4Dh8wvBOpWg=;
 b=amyz8uwfns7MMbtv/WkjEAdrYIvlMnft/iI99Xi3UBxep3CgIYhtk3DkGqYSTa4LsRpdYefAmHbqACwMEyzl4u0uVDD4ivVWHeogbP2ZQb9kkrrTEI6dfOABwEkkyBlKtjGM/8vn6wn4vqyLLNdFpLq+YyZyCRR+fmW+wvEOSb0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8100.namprd04.prod.outlook.com (2603:10b6:610:f0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.39; Tue, 13 Jun 2023 01:43:44 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 01:43:44 +0000
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
Thread-Index: AQHZnPC2s/8x06ig6k2H99zVQRnT1a+HN4aAgAC/dQA=
Date:   Tue, 13 Jun 2023 01:43:43 +0000
Message-ID: <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
In-Reply-To: <ZIcpHbV3oqsjuwfz@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8100:EE_
x-ms-office365-filtering-correlation-id: 6b496c83-ef44-45d6-ac00-08db6baf9f64
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6nxK5VxCPC+h8a8NNwO2Oc/9otA9Sw4zQF75dCl86YKpsG1kuHyyx/jq4lpkOQLf1L00m6RIu0MzUDUSsMOEABDLMk0VlXom8/j2aBoyOpACDQGuLcM2538lbObwS6uDyC23JyN4bYzo0iwFVo5YqpsWp7ZAvUkMUNLBImJWwenFJedYgpc1d/L72MJzI1FYDiWM7M2+GL84V4ZSxdaLa+OF2TRCn039D2J8PAU5qa75YKGd4EtcKIm06fKszQORzhsyqBPUzMGoI2rn58xdKxp2jcoO0Zutmt/cjvopwTnrIgD0rqV5wK7yXOq6PW4/CTjp++btWhdFYW/xMsoQ3FTnRAEihKMwPU3vbcm5QxpQk/to6HhFHetqPO4ZZE6D4eG8nfJ8NdYw8tdUKt+AVsHYyxU3Zrx4Y/jjLFAhSGcoL4wEuZpSZPYE6D+15zndLFaDKzVGW5zxJLEF194C2cyS1BCJDzzJmsZOCMq7vw/ceqQaMFsuxaKMg+vbkczArn1jEqahSTuCiFEDPFlTcyc7EoMKt4Y6FMx1xnuKZEKL3aZQhDD7oF5ucz6m9d6CHOypt6QLMnS6BXKuGgh9TXsdTLr62+0l+hOKGvCTj977BzmO/wB/fiYi0Idh7zh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(6486002)(316002)(41300700001)(2906002)(33716001)(26005)(6506007)(9686003)(86362001)(38070700005)(44832011)(186003)(6512007)(83380400001)(82960400001)(122000001)(38100700002)(8936002)(5660300002)(8676002)(76116006)(66556008)(66476007)(66946007)(91956017)(478600001)(66446008)(71200400001)(54906003)(4326008)(64756008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?up4qBpM0xQemj1mtLtzhdLRJ0GNunhaPshHFNzm9br+5DbalGUt5G4TmTLQV?=
 =?us-ascii?Q?mJcL0RGXRhXkGCEmjg//1rP0aHMYZM277MwqwdhXhgh00deTQCJG9tGzK/hk?=
 =?us-ascii?Q?HWH2OMWLAKJTyDp2y3C14thxaW8Jmaag78NW8+J1V4SdZ69YBgImQAs9n592?=
 =?us-ascii?Q?A4TB2Q96rfPjuBeN0ZMc4e4152sNgoIYdKz6/UPWn311KA4KOogmpwYbfrGp?=
 =?us-ascii?Q?qeInbfZxkl6BT5tzKoW1joGbSbtrkv8UAM3YtMqgcIiVcjqR7G1vodC7D0Ie?=
 =?us-ascii?Q?DQzjD4C/+M8Kdo3j3MnTzZhatdoI/yBz3kJYF5lOj0bKKT91O7VO6lxT+w9O?=
 =?us-ascii?Q?3iWiyVB2kZTTBKuFvXnYSHFPP/Sth0TE3GXczroermcyiEWi3XpK6hLeSuPy?=
 =?us-ascii?Q?1/vhd6EVeeROqtN9XImWk9J3Btk2KH9kXBylKCXBnjRnvvonzthZJN/xiCDz?=
 =?us-ascii?Q?aguMUs0tj1RmMuG8ceydzWwCKMJOi3+ZFPCmHH3su95dQqbQmwHykMUVIeF6?=
 =?us-ascii?Q?39UfP+1ZvSlvKiO0ALTcgWmlIzTvrOF4yWnv/wzuI5LaPzvU0jItJJKTCM7v?=
 =?us-ascii?Q?oDRt8qHhm5NSIOlBTKXKSAf92sB9/TF/0TtILxp0nBDeYyYUfEdMLO71F1Pk?=
 =?us-ascii?Q?mlcup4wzNzJ1KjCLdQ3TSHYOd2Rhnj9LonkUyVKAg4aJFZlltzYejHVQyRFd?=
 =?us-ascii?Q?rDUGeVitJlh0sL8I85tpIsXzfa9ZfhfvwGLTz5OubQa22KjZLT8hl9U3b/AW?=
 =?us-ascii?Q?eTbp3nEkbGfM2TdKAUnmFdDhbbnrSYhoiRhdUJGrFb4juw7OZEMJ23Gi99P2?=
 =?us-ascii?Q?+QlTSlVzL9co+HjTdSSCmNFGQub5pef4u3UrlgNmiNwdVxl7bmhFa8zRd724?=
 =?us-ascii?Q?TBGjVAc6JmiWQnaim4EhAhhJ9AjyIS2vzWlRIBv6tg/WkNXqOY7HXXLvOkSI?=
 =?us-ascii?Q?mq1Q27TkUXgapENyaMtksUmmi3YjEyfR47P5p/EkQIKzBg+A0SccST7bD4DU?=
 =?us-ascii?Q?cmMoNlUAbpHp5dC35XQFluFm6SIHakF7TbewU55l5b6+xBOPm+AeRuud8x29?=
 =?us-ascii?Q?mNOTE4BQZ2XpGAzatxOMrGhu0M8hDI4fgTONdks0tFVLJkqVkHgajAITQ7hY?=
 =?us-ascii?Q?k8a0V653gKYmavw3nEWfJzoPXkI/q+mmwfN7M6WMGCG5xf4YOaHQxy5Tbewn?=
 =?us-ascii?Q?XGo7PTVfw+Bosz5rt4LO0W0hAPMbfHLVBP74bgnnLmgca/ZfiG1BzcZB3iw/?=
 =?us-ascii?Q?qQ0ZFahZdLg/XXmTHGLsrJx0RfVLph5Y8jCgFt8qn6FTkeBVlM4ESaANUiAr?=
 =?us-ascii?Q?Js37Bg2DNBrD+/g3JEFCI70QCtVJThnFFPENQGKE2jBz/6szsj9p+k62jg2M?=
 =?us-ascii?Q?L/tixdLr/lBWkw7eLLpoQqF/4ISKyFGKXFtCKANeYbAirpTnzdhNcr22BsAF?=
 =?us-ascii?Q?uQRGLmXL08YlbFy1uJi7pA94/7luTyx3h1wyE7DYeMAMwki53+XJ0wl2G9CE?=
 =?us-ascii?Q?7uwpTb+nrL3zhqPO1WN1ahBaAifPZmS8igJWzLcSNM5s4H6euzhyJDn8xRSa?=
 =?us-ascii?Q?cqN+1+m+nAIOz8mTSTdu1mk+GrR0iwj3dbQbWzkgpR8+J2ilrbp2z5BxoskS?=
 =?us-ascii?Q?x3+I7sV21nke3yDfGFhml3Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <930A997D3D61A34C809A39DA6B3D2729@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ew/ycRZhI6Tsb0O1KdZbE1Re0v5m4EY4XVLqdwiAAsMrF+5DfPGW7q2mJGj+IoJ6sDQfxJYvY8ZHsk3yPktAqMqYZcxqO2ljgXarQsuXnqZLvbneBe43pqeKa3f/Uyxq63eD8GP74RvBqUZxG1kZpZZgynDACqIDDZrJqTQyV9zxFSY4JOhzfj/0wH4FlWGQdQQ87ddTc7clGuUTKj2KiwKWwb8nhBGoOqoI4NajWxYmEnm0HwhKC1SzHeg5dgCLagw3wlfxanhgLOO2sWN49X46XXyLqmuvLPGWXbK86SnakfY2NCZ4lvFV+3TimaG9YqYrHZZk6sHUJQbIeyxOWwHQ8sJ371HzMth2BeBWZCjRQqtBbmIM50ladSteTatx0WTBKYDvfgwkGkM0TZat5ALneDqzVU4MaDDfaAQIgxHvwFwiXamuny331qic79wvHFOGj9vgd/N1wClpTB1m6vYPOmguwnqLBGLx5If4elvbf6p5kcbArtOs5oQM0cKHRiGHUBa2kmR3cquuFjg64t+yQ493La9Rz8rKP0RN5H8gaQ3fZR6CBBNlnbe7Lx5Usfk949hr4f96kfkZCyhaXz6CxCqRa331zA+p8/3h78692vbSjNVpuX9dA0axzNW7MomLpGlk8jGgNyKWvSLAzfMPhvGYwJtppx4+wMyjI0OaqkhsmXERJ/nFb/TQJeTPWU5Y0Dgc/5bstsrpC9+ZrT08DmCQqtxhHcTm2oeRWTZj2tQNQ/qMnwlr06bhtXkb1ftA9iuaR6InRJwUfVlJ248Y1jYDN4sLezuwnVvZoVoDo3ztAcjXO4ODxzBt1Z5lCG4GrIqaCkzCboRT1EpYc+78hJApb2S8ughD2Y4OAWCvql+LbiLWwqPcRH9KWNyA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b496c83-ef44-45d6-ac00-08db6baf9f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 01:43:44.0309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqnE0BNM9RrGNvJE4g3FP6NhD8BUbht9Aj3W/BeyOGqHx94OPVOnH/lFfXESwda3KkeanzYGMhsi9W4aYwd/PTAjbiDCJBG8ZmI04IP+S/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jun 12, 2023 / 11:18, Jason Gunthorpe wrote:
> On Mon, Jun 12, 2023 at 02:42:37PM +0900, Shin'ichiro Kawasaki wrote:
> > When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_privat=
e
> > *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> > KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler() [1].
> > To prevent the destroy of id_priv, keep its reference count by calling
> > cma_id_get() and cma_id_put() at start and end of cma_iw_handler().
> >=20
> > [1]
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in __mutex_lock+0x1324/0x18f0
> > Read of size 8 at addr ffff888197b37418 by task kworker/u8:0/9
> >=20
> > CPU: 0 PID: 9 Comm: kworker/u8:0 Not tainted 6.3.0 #62
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc=
38 04/01/2014
> > Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x57/0x90
> >  print_report+0xcf/0x660
> >  ? __mutex_lock+0x1324/0x18f0
> >  kasan_report+0xa4/0xe0
> >  ? __mutex_lock+0x1324/0x18f0
> >  __mutex_lock+0x1324/0x18f0
> >  ? cma_iw_handler+0xac/0x4f0 [rdma_cm]
> >  ? _raw_spin_unlock_irqrestore+0x30/0x60
> >  ? rcu_is_watching+0x11/0xb0
> >  ? _raw_spin_unlock_irqrestore+0x30/0x60
> >  ? trace_hardirqs_on+0x12/0x100
> >  ? __pfx___mutex_lock+0x10/0x10
> >  ? __percpu_counter_sum+0x147/0x1e0
> >  ? domain_dirty_limits+0x246/0x390
> >  ? wb_over_bg_thresh+0x4d5/0x610
> >  ? rcu_is_watching+0x11/0xb0
> >  ? cma_iw_handler+0xac/0x4f0 [rdma_cm]
> >  cma_iw_handler+0xac/0x4f0 [rdma_cm]
>=20
> What is the full call chain here, eg with the static functions
> un-inlined?

I checked the inlined func call chain from cm_work_handler to cma_iw_handle=
r (I
recreated the symptom using kernel v6.4-rc5, so, address numbers are differ=
ent):

$ ./scripts/faddr2line ./drivers/infiniband/core/iw_cm.ko cm_work_handler+0=
xb57/0x1c50
cm_work_handler+0xb57/0x1c50:
cm_close_handler at /home/shin/Linux/linux/drivers/infiniband/core/iwcm.c:9=
74
(inlined by) process_event at /home/shin/Linux/linux/drivers/infiniband/cor=
e/iwcm.c:997
(inlined by) cm_work_handler at /home/shin/Linux/linux/drivers/infiniband/c=
ore/iwcm.c:1036

With this, my understanding of the full call chain from NVME driver to
cma_iw_handler is as follows, including task switch to cm_work_handler:

nvme_rdma_teardown_io_queue
 nvme_rdma_stop_io_queues
  nvme_rdma_stop_queue
   __nvme_rdma_stop_queue
    rdma_disconnect
     iw_cm_disconnect
      iwcm_modify_qp_sqd
       ib_modify_qp
        _ib_modify_qp
         ib_security_modify_qp
          siw_verbs_modify_qp
           siw_qp_modify
            siw_qp_cm_drop
             siw_cm_upcall(IW_CM_EVENT_CLOSE)
              cm_event_handler -> refcount_inc(&cm_id_priv->refoucnt)
               queue_work
      -> cm_work_handler
          process_event
           cm_close_handler
            cm_work_handler
             cma_iw_handler

> >=20
> >  drivers/infiniband/core/cma.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cm=
a.c
> > index 93a1c48d0c32..c5267d9bb184 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -2477,6 +2477,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id,=
 struct iw_cm_event *iw_event)
> >  	struct sockaddr *laddr =3D (struct sockaddr *)&iw_event->local_addr;
> >  	struct sockaddr *raddr =3D (struct sockaddr *)&iw_event->remote_addr;
> > =20
> > +	cma_id_get(id_priv);
> >  	mutex_lock(&id_priv->handler_mutex);
> >  	if (READ_ONCE(id_priv->state) !=3D RDMA_CM_CONNECT)
> >  		goto out;
> > @@ -2524,12 +2525,14 @@ static int cma_iw_handler(struct iw_cm_id *iw_i=
d, struct iw_cm_event *iw_event)
> >  	if (ret) {
> >  		/* Destroy the CM ID by returning a non-zero value. */
> >  		id_priv->cm_id.iw =3D NULL;
> > +		cma_id_put(id_priv);
> >  		destroy_id_handler_unlock(id_priv);
> >  		return ret;
> >  	}
> > =20
> >  out:
> >  	mutex_unlock(&id_priv->handler_mutex);
> > +	cma_id_put(id_priv);
> >  	return ret;
> >  }
>=20
> cm_work_handler already has a ref on the iwcm_id_private
>=20
> I think there is likely some much larger issue with the IW CM if the
> cm_id can be destroyed while the iwcm_id is in use? It is weird that
> there are two id memories for this :\

My understanding about the call chain to rdma id destroy is as follows. I g=
uess
_destory_id calls iw_destory_cm_id before destroying the rdma id, but not s=
ure
why it does not wait for cm_id deref by cm_work_handler.

nvme_rdma_teardown_io_queueus
 nvme_rdma_stop_io_queues -> chained to cma_iw_handler
 nvme_rdma_free_io_queues
  nvme_rdma_free_queue
   rdma_destroy_id
    mutex_lock(&id_priv->handler_mutex)
    destroy_id_handler_unlock
     mutex_unlock(&id_priv->handler_mutex)
     _destory_id
       iw_destroy_cm_id
       wait_for_completiion(&id_priv->comp)
       kfree(id_priv)=
