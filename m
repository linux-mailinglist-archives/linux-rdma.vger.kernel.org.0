Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0807A79250B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjIEQBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243108AbjIEAjp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Sep 2023 20:39:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC491BF
        for <linux-rdma@vger.kernel.org>; Mon,  4 Sep 2023 17:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693874381; x=1725410381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k6QtIoyIleEHz24oHhFKF+dORARdI2vCONVTjU4bFbo=;
  b=JF0eza6A0TYupqjrP0ctNJhewTX/5f8qTNxn6nkMflOgr+D/ib2kgCez
   OFKz67/BkxKXYQkV8Od74AgfSIO460wHT3fqwe22bjrnL2gEiiB6V9FzX
   VRirHc5KSr6aZQ2H8EqcChCRAyyH22/McFKoRHR6GqVLhySHX64LjWLem
   nJwPlZYCnSADTN6gmKyxJPjwAnQgzSROsWAhh468Ny5kbddB4GBm6Ns9H
   664anS106pE4gOGRTDPEsiJqb8a9+hTCKvMoAi7HgrWJDVSHq7S9cAN27
   R80vBfiFysMF4oi48DNBfdEaV0/o3aftw2PpXNouwBzD6QFb1dINgW4m3
   g==;
X-IronPort-AV: E=Sophos;i="6.02,227,1688400000"; 
   d="scan'208";a="355023591"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2023 08:39:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM4ZjOzh5Okth7HBi3V8cUB+GBZczTSwxzDr7Va9+n+ivnc1ACi1IK+Mgcf9ejpZZErntkOVB7o8gfWBYrqRnoax+ru/RMlC+vTDqALPBIdjYMronvTL7cqpLc/bF2XO6ZaBLmDt38aS3lF+f3oYGstBTwo35xr7MxpP4uCV2Gs3V0BGG5TlILT7d9Jk7LdGFdp4QOvCjK8tCcR6T/TMtY72JCxcxwjN/uMmsUWafMzVpLz8gVbJV8lKFAfnXztt24F0kCkuGWnAWXWtAsq+kq1uGhGCkDOXnodd249oV0TGeOOez4sPlIdldMSNdzi6LIVBrQ5lzTaE06pyKDUoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6QtIoyIleEHz24oHhFKF+dORARdI2vCONVTjU4bFbo=;
 b=gT+09/CwX1PiPIPRs60OZG+AX/mcBORP6HEQxvD+riUQc/Me127WO313EyvlSxDk4YVOx/gdwSi4cZtq320s5nz5wXF1+SIvwPmXgxnxoG0285u+CZnKhdrCxqdY3lAcsiybL+Hh6Ga99wCezqkGbsKHRVpdkr0koMYeNq/o5QiDk8WcNZd59L2TJ3uMQMFV26eV7/cOjoSdtTYfRlhY5NejbBaYXZyWaU1gbXEhwB/Q7jFtZyi61h3J8msZNacFyMI26GSPp7j35y8lJzF/utd3IydIgyiAjo8pXcNBNHBudGDshpcbOlF1/IdGTFU/oVgVbjEP0qlFPLW/59YiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6QtIoyIleEHz24oHhFKF+dORARdI2vCONVTjU4bFbo=;
 b=Oq4Wg0mluPCI0jMI4QnAT8LCKSjTo2YHCu2+3TAfyK1n5AB3twPPYCjhvh9lr2OtwWKm6cF/Z5gjYPzj1XnKCQFDH6JXMk7El1reStSercTcsMKU5k5wXvYLYJD2JF1sv8e04dnLx6l9KnDeYZq83nAfiyj6+E0p+cpBRxMerK8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6330.namprd04.prod.outlook.com (2603:10b6:5:1e4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25; Tue, 5 Sep 2023 00:39:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6768.024; Tue, 5 Sep 2023
 00:39:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Topic: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Thread-Index: AQHZnPC2s/8x06ig6k2H99zVQRnT1a+HN4aAgAC/dQCAAMWdgIAATXGAgADmt4CAAKMBAIAAd8UAgIDdfAA=
Date:   Tue, 5 Sep 2023 00:39:38 +0000
Message-ID: <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
In-Reply-To: <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6330:EE_
x-ms-office365-filtering-correlation-id: a47b8268-afa5-4575-1fc6-08dbada895c3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBuMRPva0HcAIx1BpBtwgsbng20eX60201G1CY7t90ysWWsIQZVUYYBRMEoNNjDx+vvJSWe6chgTkHpvCqOGYYMv01y/c9oQawXd2bFcpfIcDU9a3SimJKjFn5KG3gVGrHJ/OQSc8UG3CAV1Ip48Nr+rzEF48oTEwezJp/p6K8fJyfcCJjxq0UEKqSYnN1LrJ8NwMejKnawOId3utpojfYKNW7SAV2yHygfA2s9aVEhLwpei3sbPNgTFVPyN6wqIN7e+UvDhGXWomu3HkwtSJWrR5XOoBwPDc2bmhoKu06+KUOhu4ecdF5+ryEYkzZU3SOf9SkNTBcR1G3WDIeuLHdXtKU8UPKzuK+i/vJ6GCZPGLvgDQyWxAj74BUNNBwoNtvsG2FkCDQoz5y9R+Zta88r9BPKIt+qDOl4NliFEJWTggi4KLaiI+pPYMCQ5Wyx19WaR5vE12D9lAbNxcFriMCRH9c7UeiCFoCWBk/eCnWQOFbuh7C3nNT9RixiASrgd5WYjQ26M0dfEfa6NDNt9D1Y2FxU0HMTxDm+ETL4n+VUBD2JEKDAbXom/VgYjrzzjOITaTDT5kFdZW9oeg2QPcKJMPhZNIyEES3R5FgfbsjKTf7tcXlOooYIlBimtPtmnXCdNXp6XDatttP6wN8BTJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(82960400001)(38100700002)(38070700005)(86362001)(33716001)(122000001)(6512007)(9686003)(41300700001)(6506007)(6486002)(316002)(6916009)(54906003)(64756008)(91956017)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(8676002)(8936002)(478600001)(71200400001)(44832011)(5660300002)(83380400001)(26005)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SnecTdoi1TDmhzIbOZmv7aqNN7TA02oF6Wv0aJ4K29qwip3K03h54MXDoD0y?=
 =?us-ascii?Q?jno12uEzrRdl3bSaR9bPAGJQLucHCSwjae91Oaig2knjOffEAVcvcaFi9bq5?=
 =?us-ascii?Q?Pw0ZNhKjMCiJPNLOFrHX4dRWYrbenTQsluyDEoelco1Um1JCh00dGkNvBsKn?=
 =?us-ascii?Q?K8kCLLxgmriVNFiEqBOgLc+rqadYBaFNSoJ1lvTHEkXjyWaGGEE9pkA2PP9c?=
 =?us-ascii?Q?K/VIGWKWBr0qibazKs38/WU99McJIN5pCJSns2lhCpH+CkHjxEncUn2ywmq7?=
 =?us-ascii?Q?gLBnraBm2K+eAMrFAHS5EY2fICRFhbXQ4EUSTLh6xfPOBsIb4kxHDmIzJzw0?=
 =?us-ascii?Q?6R2vhWoiPoJs8jl6lWXQ2KCjsqjAAt/Fje+YKWLTcN9pPIqkbWRwvOil3/YP?=
 =?us-ascii?Q?RKPOtjzgpAO8t+FR92F7JKqYuVK2tXko2AnVKsFxEf3TvIGqyRKs28V2YGEO?=
 =?us-ascii?Q?Rv63TKhrj9MHGVoBiIqGYBQqTircPJV3TcIjHOUOM6cQkeHvjKAdOaqsctx3?=
 =?us-ascii?Q?d9xwTtn8R3BoI0WEmJfed/M3mq+MiptIgHNXziOibinrSNZTelubNkE6owKk?=
 =?us-ascii?Q?ivDhmBorBIhZnvAQGvtTFFIqf+kyIQol9HORJDzUx+cEHjKhj1vK29SKJo0B?=
 =?us-ascii?Q?seVrz/kCkyTLnF/rxaKNKP4uKCJYvxjr2kee+VRTOrED/i881Y4Thr8AOE7B?=
 =?us-ascii?Q?8EOjoldv+YPoy2932xJqojMuqwTudSWZEzyJgGRUtsPTj4hBJ2IqrhGf2qlp?=
 =?us-ascii?Q?JGQyOd1zb+ceypIzncqB8AIx2mjKYNiPUQkdciPQ3g4yO206HO4E8vqnCtCd?=
 =?us-ascii?Q?9hiOFxIQ8A+wyD4gEJi7k75U30k5Qdj6q0GdhfN66a+Spu4M1byiQnmefum6?=
 =?us-ascii?Q?0rTa/2QkrVT4u8hKzTlZBDrQnlZVvzWV2rNmKQvsCxzKTbza+A3tyUbLaecq?=
 =?us-ascii?Q?zLzMwusSYbbHnssoCYaLdSK99A5woSw3fH3dV8wolV2KbqiQNdaZcdbtv1H/?=
 =?us-ascii?Q?GPjwSuvrdkbEeEAMFB4Mq9C/LpDPs2QoBDPI6x0Up8EPHv144r9AWtahf6/1?=
 =?us-ascii?Q?DXJtNObo4j66cYfR/BjTN/fqbuh8IPr5nbg0WEF0EZuVS/nJC0mE1QPuqhi8?=
 =?us-ascii?Q?Hd6Sea9gwBwVVr9zbI3ZoXKPWSnN5+HWzULCdISuyZkC2U502txlHCx0s5YZ?=
 =?us-ascii?Q?2TReJKZXT+0LoywelJGaP/gcVJxJPtiMv4xL6tsKV5qo+AV3E6KxqXyPqdDi?=
 =?us-ascii?Q?mVoTuvm0OAlxk6xp7b4fKlKdnuozhIk7OkuTMVCylh7xfTd9I8tBUaGshZ+J?=
 =?us-ascii?Q?VJ0Hjlyf5H5SGxhvaVt8Ll9P7rGKPG9bJ6QThNPIfYBTLeVAA3IOcF/9IJpJ?=
 =?us-ascii?Q?u2G45N6jpdgxoBcg/JL9drv1MNEkUY8vHsJTCDnlx1pe1qLC+Ps/yC+zekOJ?=
 =?us-ascii?Q?N4yrURuATH2TMEBZtemv4zW1CDMApRkTCLdM4kAA6a+lT42apnK+EGhO4f2M?=
 =?us-ascii?Q?nXui6FIWCzRr7RoyuFI0F5m7EalWBMGFGF7vdg0wXOFUuSUFyMTPWljI04rK?=
 =?us-ascii?Q?ljja64eqr5ZTW3KZ59eYfYONjooNFXzCKZjw1o+fJfIoUmEzNNHuJrKjafDt?=
 =?us-ascii?Q?xyxlEksUqL+kezWu0PXHhgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8E50E29852BE44DACD36757C1CAE559@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T90/+0IxpBBXZ4xpA4AzS+nqd1/H1qGaicvl7Bap+nOeIyAVAjwURs6mmOUGeUbUWJ7lyUH8JEvzafx60y75WR/4REve9XJHlLsWeX1ze46hDPt549R7KI/sQJTcFVe91VqUgflJDgSLJXgc80nXAYYjsqJ/7MCetQ7XHHUCqiGYk+wHRDfd0Q7SKiwfZxqnk4D8mahGFBQ1RQXyXj0ZwgSGLQqgPczL5W2kzj7N0tnjLqmNxGSagNHkuFwfjyUKhoCSGDIQYGMSYjU4O0XKY4dzY9tluU49ZYYoyVi+e27peFCcJhg1x/J2vLm+PIlipgc8qkBuHTXQ2th+ZcfEgKSOEqC2CQOwJW4ckTb6v1ApFwNEXUcMh5u97AYBjGJyfK3uDcaVrxjDiOAyneuYCJIL/RcaDorkn+a6WKXHWca/EZmtZEDMM/HRg7gMf46hgZVPO4QrIZEpuJxih24LchkBqUKSWyQdlIqaCbvci3N+95rJmAQM0NyT9YoKWTvIHT9WaRe3Ap1C58ugZSR7pnrnF1uAPa8tGcIXXCJew6cuSb0+AcRKj9+B+3CyWkHttpeMjm1Cnx1MEluFD4KVh342KZPFj8UrrNVSbfgC5/KQRhDXZis4fs5t1xp2EGecxK6Kicj0fhnTnn5gFY798bPcsSlh+xFuEAjBjnVdXnvB58W9YiOk9LjQD4gm/Ijre4iBoW3WIGwiHpsMyF0a0jFa32veGw+Ah/LxxoCXRvxCuQBida2oRMewwZRdnyINSiP5f4g7dbWWYWHI4Tl+pP+Flqf2vDI3c3W3MCQOpsVGhwJZOoNcJSgHxxEhilWQGnPataz3+92fmJyZSNYj7EzkbylaQXm3xdqwmFG8rqGbGkAyHLZyPaE9U56T8DUU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47b8268-afa5-4575-1fc6-08dbada895c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 00:39:38.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nK7mFQ30Crs2rsmdtSaARQAZW+2NLipfnQC7ZFu18pSJIE2e8gKhWhHERPTOpYUOw5JOoBH8BDII06Tw1Srp431EFTMBlfEEv9TTGjTSquU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6330
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jun 15, 2023 / 09:45, Shin'ichiro Kawasaki wrote:
[...]
> I stop my fix attempt here, since it looks beyond my bandwidth now. If an=
yone
> provides fix patches, I'm willing to test them.

FYI, I tried to recreate this failure on my test system this week, and foun=
d it
is no longer recreated. In case your TODO list includes a work item for thi=
s
issue, please put lower priority on it.

Two month ago, the failure had been recreated by repeating the blktests tes=
t
cases nvme/030 and nvme/031 with SIW tranposrt around 30 times. Now I do no=
t see
it when I repeat them 100 times. I suspected some kernel changes between v6=
.4
and v6.5 would have fixed the issue, but even when I use both kernel versio=
ns,
the failure is no longer seen. I reverted nvme-cli and libnvme to older ver=
sion,
but still do not see the failure. I just guess some change on my test syste=
m
affected the symptom (Fedora 38 on QEMU).=
