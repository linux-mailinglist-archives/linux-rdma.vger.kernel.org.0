Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3034F54D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 02:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhCaAJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 20:09:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58534 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhCaAJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 20:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617149361; x=1648685361;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kwATgjbo+gLBRi5+fev3vzJlJ8uXnCtdhXzhaySyna0=;
  b=OFa66FjtOBTXGjEQ8KOrZjYw0pG2bSGGrj90Xy9cN2uRN/H3Ng33UQDg
   Tmh+63w8K/pBjbz0zhi09n/8Zth8S2OhOPEOQ+IfyQ+Q0xXIcYXvQ58gh
   XZiQJAZS9V49t+hGDcZ5I7cZUE5qQLvKbqpxgyty2ckdEe1jelWzm/y3l
   jT1CBHHZCi3a9TcXWf+hRsQbbqKi02jdo4o5T4w7dZDutRquwRDk08opM
   3zRctFopuwRhUTzuF5Rp5L1vCPLXOL2at7sSgkCkt+OkivzLwCYoC5qYC
   iJpGtLjU5Pr++dw41QJIaTVI+bGS9fLDMV6XU63Vp36FvOXhl9aTZldH1
   w==;
IronPort-SDR: kIiAfZ15ogxWSmo0fYE745LYgJcpj/s24Z5Ms3LtM/J93WFDJEtoo4hmJxpmIj7LCSIUy8h3C9
 L+BaIn0UBEkkiTFA7SM3hmRwQJhRBABL7jUplaDWujf3rAAMVzbQb2/IxJ4I+Xlr40U+p4dKVK
 MhzTp262XmhbP6c4diEcn3DWWRhhxWWGZaHTPS2tgMvXtvgZ6zMT6XEpEJUB5qsN4aIAZgqFjr
 h++aGwlneB1Hf+m/lQg6rHLe3w5t9UmN8LENk8v88UZXywCtjP4ovplVDYQ2PgLoNdbjbLv8Ps
 SC4=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="164447023"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 08:07:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvQOnMGf5MocxXP8ivoPp2kDB8P3Ko+kb7Qaok8NxFBfsUuuPtx8U78EaBwNWYfINaJdyeIbV5l+1+RVM27fIeR2gjj87JGIbTwRu2jn1FLevHF/M8D5PHqr2lbM15N1nAR4AddfM8qcsNviI9dzqP5l9HcNFDSj0m5qnxbqWiUFG74Pygfwb8+f15uR3aYEjG1CeuF5TM7bHIzk1Lca9j6hR3ZlbTLKzhDBMkYzz6toyg4LjnhTVPIXAyOu1diEiWOixpJeg2Ecxx6fSlb142ldIJ11J1x6xvqFjObcOLM+SOPrFmRUJlXmKWCBOPiWBblpVHVqLhjwMslhBYa9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwATgjbo+gLBRi5+fev3vzJlJ8uXnCtdhXzhaySyna0=;
 b=dPQBN7RYnC0yP9M6kHGzGdb2bDdygHraAjaBddqBdcMD5I5UvsN2rvWHuI7gHEZyLZqtZ+rE+YxhHsQLU48eJvW+QHmnWeSbb/soCGnPYTxNA8E0Jrpcoc/wdJTmDo11d7xS8LZfTlxg6KPfKQLeoWX5SsqAfX9QwGCqZtiatlmaTZupsG1Ats9SRyNJf549NmXe89EX2a4ro978rk0hajiCFb31MDgyQRYF6hZmjnASzI7iabKXhdXYrbkM4NLP0lT5pPgMjAJm1hjDVevZbt0Hl3bEK4jJoLZp1s0wM5RV/uSBULLkdtlXoW5YWctXnIJndiEZkLZrD+e0CXoqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwATgjbo+gLBRi5+fev3vzJlJ8uXnCtdhXzhaySyna0=;
 b=clOpxTbCppkqD+86PJOsoE2EdWj/kw+rxGHjLpZqBbCgx1lS4f681IAJKicqnUnbxrEbKNqzz/nW+BLRGg88RuzhpYhtHzPGX8omtwlCzo/Nj5ZpiG96Qstb3rvyQOrYLosNVobAU8mHpkRY0v5eTjzK340Fzim0xZOBVVPreYw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 00:07:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 00:07:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: [PATCHv2 for-next 20/24] block/rnbd-srv: Remove unused arguments
 of rnbd_srv_rdma_ev
Thread-Topic: [PATCHv2 for-next 20/24] block/rnbd-srv: Remove unused arguments
 of rnbd_srv_rdma_ev
Thread-Index: AQHXJTgJmGM/WDnodUaNjd58UOAoww==
Date:   Wed, 31 Mar 2021 00:07:10 +0000
Message-ID: <BYAPR04MB49651F9C95E5D6E6BC58E6EF867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-21-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65898c26-7cdd-43c3-c442-08d8f3d8ee1e
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB675380D6CDF7198058923C19867C9@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETMIou1JrcR/Ju+i7y849y1gj47r/ow/R/xePpP/wPlWTGzj0l+LptQIDRL2u6ccUOEhQenz+MTPhffZOwvnApmGXRKjjdqQ9PTZ2bRLoy1d+AI4Zi0tYy3c3hntwQZ2Df3AF9RPxHU9fxR34uivAkEKdrKfMWYUyH+Cq+lS11BZ1qCxbFoEpjUoAG3JH/Pxianm00TWh0QUfUd4pDuaMzOi/varYe8V/NtUBf3un9tgNfA6tGN9cPw9mqcxIbh+UWDF4VZXcgbjM/MZ7lKryCgmmCapxYheavqHkpSLCcHUjp+JQduBNi8ollDfCtXJZVwFDQak9RdPK1aDBJQSM9SiK7wsQOscWDGnTnbXElDIYHa/p09B4Ol35VZ/ySs/j2k9ntqbOcM7FVgpvPRWy7KkGlCFq8CAyQ9Lz0HJox+I/ty51Jaul8tehUFtwmgpV94kAZHlynYNt8/7YKe8KmMSE6QQfkYRkLTkoUmw8Byybq1g4p6+PFCGbosrFbaviXSeDPYJxsyFK0Po2I5KeGAfgfwcSIXz8l9qEcOXUNLnwTaLyizxmXElTuFzXqzLAYCOku8ErxTezBSQpdD81R4aohvf9CtXBinw+TY3081p8ubT0WdZ+1Wj5p1D96OGs9CGAK6WCPdNyrgmndZ7EySITOVjAfDq4OEZiF5Lr04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(64756008)(8676002)(478600001)(186003)(110136005)(52536014)(66556008)(53546011)(4744005)(83380400001)(54906003)(316002)(33656002)(55016002)(4326008)(9686003)(7696005)(38100700001)(7416002)(71200400001)(26005)(8936002)(6506007)(66946007)(86362001)(66476007)(2906002)(76116006)(66446008)(91956017)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P05Lls/4XBUX/CUQzeoGUg1rM4JunGSGsUkMG01JoRVp4o2GWZktj0vZNvrJ?=
 =?us-ascii?Q?iuVHEetpLYRJiOZZa9yJpIX8QdjZqtoATNbWH0RwtDADNW+xN87LsnrRNLjr?=
 =?us-ascii?Q?ASgZ0k07/1spViYpYFR3jvOOk0t19P450aKUgZpDQUJTKR5IL2J95UQxmskd?=
 =?us-ascii?Q?kukI2AkoG0SnGSR4UtMjotx+ns2ojxl9pe7dxeg2OovNj8YXY/fmNqyC32jH?=
 =?us-ascii?Q?ZtuF9vEyKB9SBKzrNzpreZtjiNatEN+t1PdlnukNVYuarO84wmlwM6xqsFnr?=
 =?us-ascii?Q?vf/R5MJyLhGxrcA0mxRF+mevCPfymM5PCgyv9NP3NcPEjRb5K9Xg/mkf9gn5?=
 =?us-ascii?Q?XCwSlKDbEjpf6voTMudHA+FJoQ/XDXho46sHHHDzAd5c0i5wUWbLgqN+x064?=
 =?us-ascii?Q?tkzzdfru+fdiiEF8WXtFPuVRl1bzzeMfReGYsh7A3lVaP7je29vJNkH5lvcK?=
 =?us-ascii?Q?b09qH8w8TgilxS9YYsm5CXpBrVO8sUXsD9ah+Z9py6muYjAlJw/pCIEDqb0a?=
 =?us-ascii?Q?91eFH0fJikK2Z/Rp8N88bicb5z48zlQQQ5Iw3Zzy0+WK7wpY6MWfhL0Izr4t?=
 =?us-ascii?Q?ZQdmQ8o8FY90tE5TycHUINEaZlrid1IYn1fVhwxjRE9qtXNrNomemAAQNe0S?=
 =?us-ascii?Q?hq1Je+ahW/dK2vuFJ1s9LGRcmZwqVRk58elSXy8FumqxKcBNfhCfxc7fDPxZ?=
 =?us-ascii?Q?xnuoRoWjgD8BWlyNErtHbWHhM/tpUMECUB7HN7yVAv30BGPZm1RGZ1zjOZAH?=
 =?us-ascii?Q?b/LhjQT2pCBmVYtLjoeIW9f58HpmnKfB594eDQ9zwwfDQBGe/+q9QAXX0HaR?=
 =?us-ascii?Q?ZwZe04lLNJrYXSOdKgFDbLgXV6FtrcElef0aQAz8zrDB//H0i+PJjfDXdldR?=
 =?us-ascii?Q?7Fk+YWWYTW24TthekqIKbnRtpLA1QfBpBmOWSjFVZASrZ1By73RYJm92fFge?=
 =?us-ascii?Q?n+8ctS1Xzph3u86OHzVBRPNmT12abB925b5pjzVo2xm/bLzCudAYrQ+1d6rl?=
 =?us-ascii?Q?DCUQ5MN3EEm+vN3uddZmnYWV+Ei2aOP4DAEVy2IqFFOBuRyTaqNVyblg7KFN?=
 =?us-ascii?Q?7DCOpk3GAUsfGVEyxsf3vpM5VWMIG/0Q22SbdPUTlxlH+J7ozE90yrt4w66c?=
 =?us-ascii?Q?AHQtk9zQcYFQ08XCC8tNK99djhaSU8tpRvJ1kIzuBjT6o0+BujjxMPNWSDm7?=
 =?us-ascii?Q?ba3pievuWwFW8MCwNNEnv1dK02vbSZfOcTt/oEY2FyZxGwSAErWGIz/5R64W?=
 =?us-ascii?Q?BrMxyB8WqCa9i+iIb3INEQc9qTVesJ8RWz56FS8hyPPF6pE04yATlIz91L4f?=
 =?us-ascii?Q?G5wb/IW97wBKBeZ28VtSIOjFm/NbxtouwSs2H8kdSZT79w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65898c26-7cdd-43c3-c442-08d8f3d8ee1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 00:07:10.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1C189/0uw3+Pz4C51Ox/JuM4LEyc8QNHzWTM+VVewxr1khvWnl8wFOVFO8GBk4uvYPcFOyRpBGAvvGIJiW2/f235g5hGqZuFG87/0qkS0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/21 00:41, Gioh Kim wrote:=0A=
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>=0A=
>=0A=
> struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so=
=0A=
> cleaned up=0A=
> rdma_ev function pointer in rtrs_srv_ops also is changed.=0A=
>=0A=
> Cc: Jason Gunthorpe <jgg@nvidia.com>=0A=
> Cc: Leon Romanovsky <leonro@nvidia.com>=0A=
> Cc: linux-rdma@vger.kernel.org=0A=
> Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>=0A=
> ---=0A=
=0A=
Commit log could be :-=0A=
=0A=
struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so=0A=
cleaned up rdma_ev function pointer in rtrs_srv_ops also is changed.=0A=
=0A=
That can be done at the time of applying patch.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
