Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D88793B56
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Sep 2023 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjIFLcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Sep 2023 07:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIFLcX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Sep 2023 07:32:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F71990
        for <linux-rdma@vger.kernel.org>; Wed,  6 Sep 2023 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693999921; x=1725535921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eDleCBrWezcXk9ulc8I4oB5L9U9hdO6VUXQ15vWJp+4=;
  b=eVqJ2FaxNyFG2dFVFsP/n3EK68CK4wwzdJoh7avn0UCO+w3JwT8v8vJF
   lWlUgKeNh/asVZhp/RLgyNGxptU2akE8I1b0lezeUn69txMvcJAiB4iB3
   59KZy61hVT/Pvf2V/UFpjJ8C3UOsZi3tAwlDG2wrfWHpUcPyjxsLoRXEh
   sftEe1RG7URoYcDEt6FeepEirRh9aNkB/IaXLMHeaK1ZR82oxYXhJHcR2
   F4PTzj7Sow6QRCeU/hiCSpVYhKLQ231x/o7vAC/SpKxor/XmKdn+OcemX
   j55USftTtLX8SMD4xu1WAOhsFkA/XpkhTD3os+2xbLkwgGsnaM0zOfwlw
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,231,1688400000"; 
   d="scan'208";a="247693733"
Received: from mail-bn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2023 19:31:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1aPs7a0NKzNl47g30YbrYY6qkaZghlsulnjSoO95G7vhR3NWQPh7HhdeD3LvK4K5cRTPXOqhtigq6qctzlgmiGl8O5Z/Amn0XAoedQqRBGULv9pyyAVXzpr0Mtcz9qhN18qoKY6IGxxr28IA5cWDwBT/S5nYdRyau0jGyfm6q64rEbrhKxeC8woAXbr4oJ/C07MJzC+j5Cl0gSBuc3qkg8aGt3lgn8txJphMIhD2MHgZ5uykfuF1ofL/SPrqTHQU6ukbH0DddKNmWVso9VAtWCwx89VIz6alOYjGlXxPVH9gZZcCCTDzq2bj8OFBqd3/r2XVxBOC40xCNyVw484/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDleCBrWezcXk9ulc8I4oB5L9U9hdO6VUXQ15vWJp+4=;
 b=UMBeLql7oiGOqxamAgo06Q8YRsaeBcJntAghmE616L+e5gi+2fmG7FbWFXQPi5IjcaG8nOXb6m7b2xFrtkPLccNpRCM3d7NaPZy1rCQORHcketqtT7eihYk6W+XWnTw6AgAReat8fGhBbnu/tSQGQHnyqIpjW3Dg2yIdyFCiIO7z57GJxMmGtxBUyI1brq+WxkhTdmQUMQOlOQ9G0InKWRBdn/LjJNlrFzPzj48xgyEkXyjnnKww7kOYusja+LvKzZ20/9arV1oTcWxybhujg8mARZWk+3PAai6O/Xw6yXxbCORNRw+wer0Ud1Sj+rh5pRu7sr7ZjpdKgfvNhBEgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDleCBrWezcXk9ulc8I4oB5L9U9hdO6VUXQ15vWJp+4=;
 b=iU4PKxMK0HhPV/yDie2c7/WTT/2MuC2eJOeHg6jK5AcwkfUxLeoVQWaNEM+CvbTeuIVMg5dJS1ju3zqeDXFe/+aFwxCm/yxRdudalqu8XLLeA+766tXH7haeVrPeFcriENgHhNwqA9MneCSk6muVGoxvV5b8r37cD95hQ7Mt9R0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6662.namprd04.prod.outlook.com (2603:10b6:610:94::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25; Wed, 6 Sep 2023 11:31:23 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 11:31:23 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Topic: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Index: AQHZnPC2s/8x06ig6k2H99zVQRnT1a+HN4aAgAC/dQCAAMWdgIAATXGAgADmt4CAAKMBAIAAd8UAgIDdfACAAhy6AIAAK7UA
Date:   Wed, 6 Sep 2023 11:31:22 +0000
Message-ID: <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
In-Reply-To: <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6662:EE_
x-ms-office365-filtering-correlation-id: 69c5055c-e7e3-4942-6ca9-08dbaecccc74
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ckzbDHPqS6VXQZnmT6NLoGk3NI2ixawnTAXupr31fa1ACApDLC+3Tt+fEhbQg+HcFXYk/ux+cMhQtANWembgfn//gs6+PC3geaOj/75q4z0zKATfZXGD0QsZ0GGgMzGcC3C49gMiYoSIw+oHZUkVaC2zOKqUDofATE1ej1X+0PuzGR0PdtsS1TW5mUzgmynx1D8E+wtamLb8sHhCnYIp8rtbDzsavWwkjdyRXEK7DnT/RMhVNAY/Rb4AIxjWxuSbBDhAiP3WApPYiHULkamvhTO+bQcxfmKr+QtrHmAf5zi/IcBF94u0P5+oCs71l5O6+TwpFsdk6aOwYYdh0xwryuNB9Ouaf5xpfSmWmgVlYXZ4JtmfK0xiyVJVJcJOfAjVL09cYR+8vK9x50rH+4NQq5VLgoonWcbt7WlTBvGCdK21J/HtQYXaRm4AXGbSQWaOlOSBGdKYNCdRpCQomeynETVHFCU5lkzgPhJMIMkWB5vdjwcEnLd1aS4aXPlz9zCk7aW4+swjfujUsoVntDSqjXVziurkNpL4cS6ope0d0X9xHUg3e+WJnt4n0qOlQGWifIout2muo/IqE85a7sKtkSOa2HdJDQLPQQyYhGUiuLG+acyZI3oJzvtiztJ/FJz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(376002)(366004)(186009)(451199024)(1800799009)(44832011)(5660300002)(8936002)(91956017)(316002)(6916009)(54906003)(66446008)(66946007)(64756008)(4744005)(76116006)(66476007)(66556008)(2906002)(4326008)(8676002)(41300700001)(6506007)(6486002)(26005)(9686003)(6512007)(38070700005)(33716001)(82960400001)(71200400001)(122000001)(38100700002)(478600001)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NfjJARYIaWbYRfUGK62KJMMXL927rRpB/fzWJojzjRc40eFY9BclpriTW0tL?=
 =?us-ascii?Q?GbvKp5FSwnWgbbn6K7RgAIdsykYgZqulfuyVecr1nBI9aX4kA0A8c01oadwh?=
 =?us-ascii?Q?nxzD5l7yZPYSgHHmW5plPW/o01OH1FAXwlScQlY64q+Fb4vI+x3U8ePIkB8r?=
 =?us-ascii?Q?84kJFWHsF+1GoUZ0HM4ygG6YKd2M51MnTis3+7ZvB8MlCcItCZ58gAyEe6V5?=
 =?us-ascii?Q?GDuAdHyB7dfNf8+oWD04AZqvVYPS7hipnz1NrQ47mP8w3nN1h86mZOa56vEO?=
 =?us-ascii?Q?d47jz0DZYzmIca7VL05zshZNrKgaUy9AXi4zDqFdXKiI/YJbO0T56R4xoF1A?=
 =?us-ascii?Q?4AKV7QpKzt0piD+TRYJ8ukwESwPxwotvFpEjxkhqq/OhM8iSICpEjDun82PV?=
 =?us-ascii?Q?xtwaoADJ4VldJZhZO+jCiC5jJjvsB5ctGyrdoMJq9r8VOsxylbOHDI+akQDM?=
 =?us-ascii?Q?lbHUeY5Gynrua7VprF1BPKxbbi1fOeGL5PzSVGfCqJ0KHTieSim/upeQ/chr?=
 =?us-ascii?Q?aaB3p4k14Z54SMN+xh5jyzqG3XKuUGD3+A27M0SwEQE2r7ILIg92pUKNjBrx?=
 =?us-ascii?Q?6z0vaniF17qH8ruazroVdjePosV0pxSMwXtObBi4sucYZ4tUJz4HBAFDPZVZ?=
 =?us-ascii?Q?fPt+KkYsOTCQuFwDV6BMGIHQ5X/Sx27bGe9XAZlvNkg9OO94om/YMrWufeLc?=
 =?us-ascii?Q?yCKU+9zx/brdqvqHoAwNW5nhyZxd1oldb/TLz2vtNT1ONnpRbEoiY2UdT4vR?=
 =?us-ascii?Q?G18ubFoUzglmDo6l8dEijAe3UvldVov8RwlOc/YLoG/dftQsgXN0DnSk42b6?=
 =?us-ascii?Q?vIK9AFRuYamPmmz3Oc3Y9Sf80IR26832PneFvKz6gKhUnaqfhPlxCyN2iUdW?=
 =?us-ascii?Q?WjSiAtlW76XEsnRPUCfh+vYb2upAGqW3drMSnuNjvOsDc89vE3FKRvxE+L/Y?=
 =?us-ascii?Q?/m0Ff5IYkWaCQFw0etg53IdYmy5+CR4eWd/vmZKHgoqFDf+tSZWrdDw5hOb1?=
 =?us-ascii?Q?XlB9g2F8Rh8cbdj7fW7W+BZvmEYyQNPS7MKg1HGz9EUNLz925Apu45DosAgT?=
 =?us-ascii?Q?OKzqefUCJP6cxtToL1PO0kko2eOZOBJ2mFfaUhu3f6HgNnsZ53CncOXpn5zX?=
 =?us-ascii?Q?i0CTUdyhE2jR69zcbDjzcp+WyJVzGzrgtXxlXmemdGk5OPL6QGR2VqDWp9b6?=
 =?us-ascii?Q?eCUlfFoBA6L4XdxygH7Se+hh3mhc/mbS7FzvKHU980Ud065WYDuxaVrpFJjU?=
 =?us-ascii?Q?EVsBTEPHmwDFqQpZoQrXlv7qDAbQWh6SfFiycTf4VUKs1O1xfG6ENJXMe2IL?=
 =?us-ascii?Q?XK/aMSa22sKUyt9AsPfn8kAAJZUay57gycUDfMytoFkUvP8DSXRUvFwLqoYn?=
 =?us-ascii?Q?Z8L8RUjQJDtREfZSXXZugnPcCzxWw+P9jlalOyxFnKebAPbONwzPYRofe02P?=
 =?us-ascii?Q?WSQxgSbxRIEYbeE4ZI22tsOG1kAvuCQR/lHIj+7prp77akGsIyorfZ0vhDwh?=
 =?us-ascii?Q?u8dq5wJfnMfKEnI21cM09Q+urSNDmiJYHjYJp2lilx3CWoJwE0OMedH+WRLj?=
 =?us-ascii?Q?2e9yoBBv3YnfrypQ4vAwq6GTk0C4d18OcMhJxZqGL2B+qVZaAPvFX83aQqIP?=
 =?us-ascii?Q?H1vM4X8R4mk3gi3nPu8VzWI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42BD03B1CBE2364CA3CD39573AEF3EE8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k/pi3no7hI05J4asNhe7oxhgurOrOhmJyIhhz2uT0t+okst6+aXNSjMjzkqNIKuHbee6n7D4xmustAMPSp89sBh8nGq+D8EXPY9eOujrKrWG3zjVbpw/IlD2N4nZAb1UsAMnG84a21nZi5mwjJ9Qc1bnl/CiCCuy17nSkPUNeB4XrV9Z2acDEwUhSQInXcCJ2ZRiE7gdYLRNXmAHz8WEqa6uf3Uomd0VsrLR1wpB9d0VWYPi2oQ1+9Y+atgPwCkugzekYp1OXlfh2XQITFn0Ay9uMXwANUgS6yjdmnQspuqGwVVHbLPteeF2Yv06y9UpHW0Ub0byS3mCJPblNW83acmr2MupiUWvsCbbfTLa75gnoVA6YvCuZH/ELevmJY0nTpIYmtn2XC+caB+OfAGnSLsDPesvsLsF5q3owftkVUIbXhtn4X+ZajI9Si8VvA4ZAHFswOfwrbrwjntioAdif+wjQqIXnOqwRhEYfR63wLCTwNn2NZ+aP9QZNPs2P7iZTnFNmoYmgf3fZAO7QNHXQfy6DD9UgTaAeIBm1Fgim+dSvtjvr1PZQ9vDy/D5rHmGs5jc9qQclMyanTwJwZaq+yD4L+o+MweJ5gs5HfmFVuFfIo8gZ/RXPzg43aBAA0QbNZ5Bc/uOQqUSHyAQPC7WT3KFhSQycRCtapPHKnlOGh92tKNG5zEJcFdhJMst7oEh4PcopmQw/VJsav7SEqEMzpWMcVbVgp9sVoq66xsEhdZUNg2QkefC1S93hU8yD0m1AbZ7A4FaluH4T6K9DgABjbcKf4zzWr3c6GstA7ZEayK9IwVjJZUsx+N5ia6v72YI0whn809sVm3xGdYzipsVn8PP4wmbmvZU2qm853MAXHQiPe1u6+nkWheBo2XnJpB3DBubnMW/9Hl/HZd0EGXdOg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c5055c-e7e3-4942-6ca9-08dbaecccc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 11:31:22.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N9iEpXeFH4IlLYtzyD0oS1G8YIpy68uCNcj/5Xz8NHN4AwDKJbT9+dJhd5lHMlwLyFrR6dfwBjc/ijZ3/61arZdlMzZp82NHPlXGzoUTtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sep 06, 2023 / 10:54, Daniel Wagner wrote:
> On Tue, Sep 05, 2023 at 12:39:38AM +0000, Shinichiro Kawasaki wrote:
> > Two month ago, the failure had been recreated by repeating the blktests=
 test
> > cases nvme/030 and nvme/031 with SIW tranposrt around 30 times. Now I d=
o not see
> > it when I repeat them 100 times. I suspected some kernel changes betwee=
n v6.4
> > and v6.5 would have fixed the issue, but even when I use both kernel ve=
rsions,
> > the failure is no longer seen. I reverted nvme-cli and libnvme to older=
 version,
> > but still do not see the failure. I just guess some change on my test s=
ystem
> > affected the symptom (Fedora 38 on QEMU).
>=20
> Maybe the refactoring in blktests could also be the reason the tests are
> not working? Just an idea.

That is an idea. I rolled back blktests to the git revision of two months a=
go,
but still the failure is not recreated. Hmm.=
