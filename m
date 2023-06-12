Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3272B5A6
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFLDFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 23:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFLDE5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 23:04:57 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77DE47
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686539096; x=1718075096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HfP4vFiZS9tAVwqTwGnGOCYXdZPQ/z7QNlpoHyE/27g=;
  b=fbwznjnovZfMm3NG708b+0NHzvp/nDRGOuU2gCP8YDG1oV3Ywilk+lmr
   qDqPXv+QVyHcGPwYw26yDT/0B2riwWpwmBeE0Epc/Zcp4eo3QnJlj21v/
   VrxiLRRdWmqKz6vwM/IIOEhfL16aI3k6+2G9GwKV5ZCPbRRTZXwzpjoAb
   55E2vEyNzXQmDTVStZ2HIN1oVI/2wr1kKlKx0muDqmIrzMqFnhc5x38TS
   n+FbxAAT32qU6duryiudjByBSoL4iEq5XzEBc/RnFeyzsqW5/1dwn+8pd
   VvbqantFGkCpYDCDn7uWqqTnvIwzT6gNQ9wOeC/EVYPM7gsQoHU53uR8W
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,235,1681142400"; 
   d="scan'208";a="340032123"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2023 11:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX34v6jSoI0gmZSr759wLJaiiqJiXPiqCISkvlFSZ5ZMdQFxJInimYD8UtmWpp611cAfcLrK+efQUxgZPxnb2HBXd58LDK6HbRvS/DVuugR+DUpqh6Ru0xPcm06OQ4yhPNkcal8zqaVbiJofnEVI85eyKG5HOpuFBKYvSBXGRPNTe/XnnvM04+R2ZdGDhjD7drkmzfHbWinFY0YsCIhMwQJleGM+wYHyi3uX2WQpsOMSM20JmJVYANwkvyojonaufXn9P/g7kFKC3fwJhTxeWxGeP6cdg+wMOlI7n0kUcFh7G9NkGlho1AlYNouS5PdRPlW3I5ge9JEAg1yfYNZV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxK8t9YHyr5w73KeO+oRMERjnJi5amlyXAH/i8e+HEU=;
 b=cWVLVw03fTzjEkJU433pBZlbjIeHSVVotcCqlPjBPsrRPm2y51E4GBlhOe3Rb+JAvn/w1eyW55Xgr2V+fYGuZcKmeJsKQlDQGG3ySV19QF5MPeNAMkR9p/rARs0TCdLZ4QPa1OclEHgoyYir/RYaK+cDyTJggQtBWqmVPq9dr16Xo7L+aiSjlN3Lv4Wf0lbMsLlyvltvZON97b0Vo0TWXV79Kv/mleOlpHdQgg7fhqRcovoNrvBIloUEOruMObuP/IC9va+0S8UraiMPbsUxK9Z+U1rtFOLkGCY0pa+MlNq5NK3QnUpjdyz48GQ16Ndt/eSWY1kQDxk+k+CgFkBXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxK8t9YHyr5w73KeO+oRMERjnJi5amlyXAH/i8e+HEU=;
 b=YbdtlkfqEb42+reZ03JfD0OxExJ3fwcJlc60gscO6nnY9jqJrAQzJSZIbb1OPnxjZTTBqMFV4W4xuGZ8oWIcA1UM10qlGg+if2AFOhkzl3L47pKM2HpbiVHOSKQ27XByKDo5co/46FvCgWrr0AmklQ7UyHMN5niC6IIgEP9fTBc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 03:04:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 03:04:51 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Thread-Topic: [PATCH] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Thread-Index: AQHZlbTSAgxx2jnCnE2SRIGXfjrpbq+FqDeAgADhk4A=
Date:   Mon, 12 Jun 2023 03:04:51 +0000
Message-ID: <gwd7gnvufcdq2ybzs2tazdncgp4dzyppmvfrxnre4khwzbuhf6@wdlct3ilzqrj>
References: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
 <20230611133707.GE12152@unreal>
In-Reply-To: <20230611133707.GE12152@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6332:EE_
x-ms-office365-filtering-correlation-id: 1c4a5613-977d-41f0-dde2-08db6af1ca4b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P52A7Ewch3fgGbSXFGg3JrnG1myv07EFEnAr0fqLLKjDRVTgng+7TDDmTyYYMGmmX2hjgmLZf++TBXxqYTXXA3ZGJJ/2fRZ/PEI/Pt9knx6Uy5yLobhD6hPy0GPWqvCc2rw7pkhvGHaaByTxnFfLIMOm5nrXbyv7IpwW311fvwrfZ4iwpIvpFqjIIJHNV8ZmBfcVg7HMvDb1jui2cAD/M6nF41WYYqLK3NjK6W5RDGTKn7njhCml+/NX+5V/2RaqQtJoid31zeu3529poftKYktjLMkPFqf39iWgZ9tnGn/yMgAEKS1KcIYECAOQ0A2s/pRAuPoQMuyIWR9rTeyKsaveRhQ8Gp0glkVQ8LqPmY7elsPj/mekWLooCHpnY6zGy4jo07T7gcwgDcAnfAQ+jAYDv7EZdKTI3Z7RULZuKYZnFhGR06PEaIppEBLGQsYqjDtU/ll9dxMxBKTjqpq9a+jvjVkFp7jfsDnCL/R+7ChokLSn/5efCgWAgURssduKHmA/fX6Gq3avMENtFM/nA8fyasktRVvK+QrQN04BgAvClYkOk8SwPW9TwpXu6nWNOBw8y3X/K5Yj4CHZIHa4BJonUrI2BgRBgyh9NKioVAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(76116006)(4326008)(66946007)(91956017)(64756008)(66556008)(66446008)(66476007)(186003)(6916009)(478600001)(2906002)(54906003)(33716001)(8676002)(316002)(966005)(41300700001)(86362001)(6486002)(6506007)(9686003)(44832011)(38070700005)(71200400001)(122000001)(8936002)(82960400001)(83380400001)(5660300002)(26005)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?reYdASLDiMzDK3+lY2q+3BuEa8dMKJStqDvIO3zB55JIpRqgWFPzmMtQSZ4w?=
 =?us-ascii?Q?pcscO+beH4Av4DwuvvR+HrTColSMPPIHBTY8Go4xQWv4XYt7OMDEm5KnhWO2?=
 =?us-ascii?Q?K6cVHwYHILL5GldIPc/isHySwCLv704c/C2kISwP2jBvklfAmZ5a7p8NGyfQ?=
 =?us-ascii?Q?et/zOt93NJnEAMR4cCP8Ma0PW6YwAcFGQ7y5Stv9RahURi+S+lfZvvM4Urx2?=
 =?us-ascii?Q?iuLzXg1PGRFpEmuY52DplRuP/hSVAeFWaa0lIBoNwdTsClZ0maB6cA94obzW?=
 =?us-ascii?Q?cOIC3K666m8L2Igr54G1wwi+J3ZzMW4RVQJSwL04z1LOe9553Y5+ugHLgfqd?=
 =?us-ascii?Q?IDS/MC8V6PM+srcbbpEOL96o30dtBQ1Xcmq+m4Ye/zhQPHiD7pnmqyRZoKdv?=
 =?us-ascii?Q?4g7leIcu9BNhPbFq7WmpPa+bnf+d0PH2P1rbJKkhv94v21OBq1ZAXzdPvBWL?=
 =?us-ascii?Q?4zATQtGh3fbfF5kp+fchLn9vn8G752csYi3MBJvEYYaJVMQq9g0DrGVXh06l?=
 =?us-ascii?Q?M5jP2QB8sUTF1ZHLppr7CfclQjVrisZt9ohBP60r8/PxNJAmxhQmywDdy/b9?=
 =?us-ascii?Q?UlMYsOaRzmfG+aYRt0+vdmJqxvpPcEIMYKKjBSCE+BBQvuFXxrFBe5z34WQ5?=
 =?us-ascii?Q?Whyz3MbYn4YNoXaXVn9dNhwrEA0fIg7CwdwNykotK2ryX07+qKD+Wpu2tl7j?=
 =?us-ascii?Q?W1O8126tpCp99Hav5tpdub8CIYaS6Y2nkgRb7rA7lQl1FwGd3RKbWVJbD9ur?=
 =?us-ascii?Q?6FKpLN7zMwqSsXHqOy2gAm9oy22bFmV9QFCAmbh3GOF6ph5LLWcojG4dPy22?=
 =?us-ascii?Q?ZfmD+YylvUewkoqXPZGMYZMs9e5jmNu5UOx1On5BGhg4GvGQMLfWkFo1HhQ9?=
 =?us-ascii?Q?WCxqOveMG5mPSyzL0XW9hlyQr81HpUxacSJq7xmTdc6XQ8Ot80U26d5N7drA?=
 =?us-ascii?Q?LfRpXsKPARanV0nwwOPgmWEjeIUeZEmGNu7tK9yhmrfNZnH4JyDDeF5xD96p?=
 =?us-ascii?Q?NdAq4QKoonjZouDj88BUJlSQtKm7lP3wcu6yIJz06qk98anBEw3V2MOZKi63?=
 =?us-ascii?Q?j3HwLk161g1lP/tNDL0IVac47utctBalTrteMBVb4701oeWyS1SsFsr/4n16?=
 =?us-ascii?Q?60VVsZ3qO+P4LF3V4/LpDb9rxE5/3kM6FXW/yZqWvnmpZdRdcfpt8Su6vJBl?=
 =?us-ascii?Q?sfNaglc1PTtcvwYigF/qtA1YolMKCYlKzvoe+Eo74OMbDPn0oQSocSoYSh3I?=
 =?us-ascii?Q?M8Q1hy3VQFzbKNJa1g2dU9/5/0bMbYJUsewYPnNUHl8rEdj7pjaKdFhVCplO?=
 =?us-ascii?Q?/o1gVxPhDK+rf5bTkppqbpBeKKqQxYaBa0fqdyo404fhsgYcLGTN13EaXX6f?=
 =?us-ascii?Q?0+3fMdMyMnQT5xEWUljzSdsjqEN/l3sgb5d7ePZT6fJEFMTqwz87VGtrNtcg?=
 =?us-ascii?Q?ioaZ9MGtz0/EsEej0E9Z+zvcLnlreRnXPdUr/FQcRJTCBfuOCyMn3uwqdRu1?=
 =?us-ascii?Q?kDznMKkdhhuvRTkTEnOj1I3qseHHl3S29olrThy4yyibcMg8AK2l3wdoMKOC?=
 =?us-ascii?Q?I8ioQJ92qylcEPf5AyMVwyXoZBJ1G/s0JLGudMYrrB80fyobNa4p0yqqxNKY?=
 =?us-ascii?Q?KqUGziT77VL/NptdAOVvEgA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0173E42FF2EBEB4AA63CB31C9921435B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uJacDpxEOmuIk38T95BrBfOq76UXORwcihR+I26qECupRdFPj5WGHMLi1H8sg/5SjXagQ9riH5CAHNkblKslqMG5xiL2qA8bWh+4EBa8EvHto4yLI/JSgr5WpIfKAzy4IvogLpxfV3UdOeDguckJT5ZRSVB4hM+7rV8i51GU46momiquQcD7uZn68oKmXDqZwJtdgJsnaOBALUXKSNYK5KvTmZUcEMa5B5cENoB+cXcREpeTSCWhhGoZ3uqKOYH74FwBTSpRDsPnTM58eplRbxW8qEz6K7aeN6xnWhCmTLYQvN6YJlrqheauWyqQGQYcr6YIg06J3EVTFnQg6EfGPDwO33uQwi2El8W9/W907n/bZSyGn/3nvPdkUgHPO9m69k1aXoCuKh6sR1ulvtWkAFMa/3JtTIMMRntyuNrdH6yDm4H3Jg4Jt5pXc/pz1iJv8/eylhwBQRXnrEpnbxMYypEu5Im/k5+6MDmcKl3wWAeTCzjgs5slEsbbtV81bzOyKKcElp+QSSF2j1lbri5oVV37MbezfSwUV5lFHfBzS731R2qJ8hm5AQ0wuM8KXli2q+gUDPwJzypYrV0FfJO8TDDa+Ug15j7R/fp9BlOR7nHYks0L6iYaBAufpo/mif+HHBW67EffCwJeOHhAkxVBk/yK0Bt59xfveqXIrKdoQDBYWuR+w2n9HKSIkXFEAg19mJwNFPlhJzWVYVSNvCYeAE3v4c/dwSbOddfYAxtxRYWXcUafBOhxUBFtOxGqLMOQE5y3s0UotZNZxv2zizM5wXiJNcgLSypWW/DoVlaCvJ2iWHCJhY4LfK7mEg8bc9MhANUlXtbBfc+FyQzz/sd4017FDdObVsWQNjWglaGi0OTtDomV6Ccpy+UxznASV+ZR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4a5613-977d-41f0-dde2-08db6af1ca4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 03:04:51.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmmfTkYwYUvYudN7tdWWDWZSHJTQQLqSXp44K536FiFkk2OXrbRC0WolgzxUFFmDAWpaR+iE77Sef82mvDpDigWCdBchG1eeoFUWDr6CJfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for the comments.

On Jun 11, 2023 / 16:37, Leon Romanovsky wrote:
> On Sat, Jun 03, 2023 at 09:46:20AM +0900, Shin'ichiro Kawasaki wrote:
> > When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_privat=
e
> > *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> > KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler().
> > To prevent the destroy of id_priv, keep its reference count by calling
> > cma_id_get() and cma_id_put() at start and end of cma_iw_handler().
>=20
> Please add relevant kernel panic to commit message.

Sure, will do in v2.

>=20
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Cc: stable@vger.kernel.org
>=20
> Add Fixes line when you are fixing bug.

I see. I checked commit logs of drivers/infinibad/core/cma.c. It looks the =
issue
has been existing since the commit de910bd92137 ("RDMA/cma: Simplify lockin=
g
needed for serialization of callbacks") in 2008, which modified the method =
to
guard id_priv. I'll add the Fixes tag with this commit.

>=20
> > ---
> > The BUG KASAN was observed with blktests at test cases nvme/030 or nvme=
/031,
> > using SIW transport [1]. To reproduce it, it is required to repeat the =
test
> > cases from 30 to 50 times on my test system.
> >=20
> > [1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5=
owkqtvybxglcv2pnylm@xmrnpfu3tfpe/
> >=20
> >  drivers/infiniband/core/cma.c | 3 +++
> >  1 file changed, 3 insertions(+)
>=20
> The fix looks correct to me.
>=20
> Thanks=
