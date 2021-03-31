Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED034F53C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 02:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhCaABu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 20:01:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39755 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhCaABo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 20:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617148926; x=1648684926;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rVufyeAzcuwedA18L/slH+6HvMjLOmvvK3JkX/3Droc=;
  b=JXnuej7uZ/kN033svSZOh0XQfM6spPvnQJ8bDEDd3cvG5b8B6WR4HCKW
   3HiuD7TviSim+VR2Tq9yID7ppMq79+Fp0KybgEfFlykyzHh11Q3zSStma
   +DsHJAe2G4xwS8PcqNVcs0peZAnkN68XgRIyJSWl94zmnC9fWvovbYfjh
   ekiYyI0p/41l+q/mmc58SK2U2vlE6OBDmocmvf0HL5UOX4334xNh1PzUi
   v7IcZ5ZohBmAWOolhObGOalEdg9EyoIb6JAIPkDkUrOH4QaxWRV9CLTr3
   RD9XpYKuJ+Mkqvq39SQnGJ+6iEPaboIQ3vk/9ABHGI4iTZAZ9tvEdrXWV
   Q==;
IronPort-SDR: DMunnjuEdqmpTFWF8Pc+ghx5MG8Dh8rBD/qY2+MY5JpT3qo2RituUPSMJsBhn8KzEi+yCRAPAP
 T3QRS2qF3cIvllYfnCMLIaEydUno+TvRbG+0b1ORsDjiV46ypn4qLILxNl2AUgDLAxWFvxuBrl
 ar3Ab2B4iuPm0G6k/sQnRdFiPKgMfVXSYfWI6qgATPPxB1Cwp2ElfyxCbglkR/nbVYs+3SVJrg
 SG4DDrqcBnTS1ej+rzN/whb+dt7NkO5ChTwcrvPG22Mbli52USJkV+GvcF7Qz2yyv+j/rfgxWv
 7D0=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="267821031"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 08:01:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/BGFLdouxZ3f1I3x/oGlCA/wIQkBO945ZlKr7vnmzHLHPGlbssmEp+z4MLIEPDuRNwTYgsBXj3R2BKHIVMrxRRlxzKV97IQiWpXuNA41rler7f0DvEuT6LzEZx5urCoJTMFon1+chP0cowInpV085JCK6IxOKfCZp0JdHxKR1466NuqKX2xbVJous+E1qS3dFPj2I7M4Q4LHbo/Q+KZfNk6EpAl6pBcjg2KUKo2rnEl48E3taRgqbhaoxPt4nC4n+Ezi+cED9YgKE17/d9ytzZ5Wb7XtyKYG5IT8hnKTcKP688nGn/ctADgUxSlieR8FqgT6FSrzdUZfpn8y8bEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVufyeAzcuwedA18L/slH+6HvMjLOmvvK3JkX/3Droc=;
 b=Ok8KSh4dN9cPnB0dC7uzxZ6UffCGl0X1nEc/k3QGAjB8Wf9t6HlSDX8ebMGcmKrKcoN8rQN95IPV+PhUwa3J60YEX8Tn2SEz7O1ptzOOnk/5jzRmoDLaYT4dUCaBmI/03MXYLQBkftCuUSqxM2aCRexa62YoLyiU8xIdLfSlvH6zB9DOD9g0gV9FnCyZbfYvhjR5vWpisCV4XDrRmKLmrC9sqBfsh753Epjcoi3Qmdu8Ukm9SinzXqx5S46HVMGuN1feAZCZKYB0aQsoNQQItyBZTYfBfTWYc8X0F6GpV9MZscMg6vtqq6C7immPfbgIqldrujsEMic+QBH7+uCz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVufyeAzcuwedA18L/slH+6HvMjLOmvvK3JkX/3Droc=;
 b=lJUS7FGZZgrHdF/qOKBFEFec9v+yjOxjqgvD9gcam8GNZdoYjhO2Ou91v56k8reHMRxK8jLNz/0V9kNsEyEG2KuOiBpN1ddNBarDgYlQVOqzzyQR8CtO9PW3HYCkr/InVbxevViLrjmqVA4oqsxhmH+3dp1e1B3V32R50/45ync=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 00:01:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 00:01:11 +0000
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@ionos.com>
Subject: Re: [PATCHv2 for-next 13/24] block/rnbd-clt: Replace {NO_WAIT,WAIT}
 with RTRS_PERMIT_{WAIT,NOWAIT}
Thread-Topic: [PATCHv2 for-next 13/24] block/rnbd-clt: Replace {NO_WAIT,WAIT}
 with RTRS_PERMIT_{WAIT,NOWAIT}
Thread-Index: AQHXJTfYDcfMRH55e0WY8HhHKxbdfQ==
Date:   Wed, 31 Mar 2021 00:01:11 +0000
Message-ID: <BYAPR04MB49654C33E410460764D47D5A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-14-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48aacef5-71dc-4860-e046-08d8f3d8180a
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB655254CDD1F5092838CE0126867C9@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwYqV3Dsl/Y/bcE9xOg9v6qOVlGIQhiVoE4usaCTqEjxFa+RRrAVRBcj+z7qvLHSbby3lwifM2x8g3wURI8JDUUIEJH01xKWonZK5SnY0KEfKnPpGXtpAZAFcW/Qea5Wf5M+WZ+4iMw74RmUZXjR/GApsSJvw+LNsH7wvDPm0RVgi74nU81ep5iw4Eue/2xuHzrclmBD8PV/Yqwos1nXqC8uydKRtmRdbADBPBrf3REjrxJqiHoqG6QMvAIP9BoZfSsyTtSDJcK6oavjWLN14xwqbKIL/22kxdMsSmrWvKbbJeR0SZlXng90HMp44zhXyk422bxqwpei9aePryO/HU3wfTPgI0iCcfxbIdJ1kqpBQpHX8Vm8EAgwbPOu44DLE2qDTfMB8OgvrzLsrjDUeSeeT48HT/FTjtO8zwgKW+nCdZGpv6eLMPIQHmZR4n4ayx7jnXK98D7zrDIAfprhD0JSWEqeElP3I2qyhg/KZiJTlA2q6qtJ+vtnUX31tn7kqz6kGQJZrlkBzZJ7HHGOIyzk8t/D9fzg1BhyH4aT9KN+jM9SBePC5pqdX7xV5TJzFd1x1nm1T0abVfSgPMLabIyyw1pYX6RZ6u1Xj6g99UjRAhdYa6cu7AcTexGkvk8A738FmT6L061fKDCySp7L0pjlfKLgYYy9sJWqHLI/e1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(66556008)(66946007)(4744005)(66446008)(66476007)(5660300002)(33656002)(64756008)(55016002)(71200400001)(52536014)(4326008)(38100700001)(2906002)(9686003)(7696005)(6506007)(53546011)(316002)(54906003)(110136005)(186003)(26005)(7416002)(8676002)(478600001)(8936002)(86362001)(83380400001)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wLnnujRBquM6JKx10jYCvghEjWS4W7lXe+dB36RqREkjym0rNCWv9lnI2Yf1?=
 =?us-ascii?Q?H0IQTmW0oNDwWHuOdabiZvPYNO92mHN11dnv4ikgHz/Fkk43jdA0eyGMA+Rg?=
 =?us-ascii?Q?ilx4b0YRMr2T1MaY5+HqBfa8ztxTvnlNOyJDbhmZ7But/xHmjtf0Q5RhW0pa?=
 =?us-ascii?Q?tOH3CA0UYBEmZob0cJx/DFZPJKmNwceEsKxJ1JTIULZJOu2Q5G29aQAeFsjy?=
 =?us-ascii?Q?hlL2gULSbwAoHw5cdeL+EjBnMRFSh8v9D8suqVtfHNEAgTSODaBRLCWwLRBw?=
 =?us-ascii?Q?qrAG9iKZ816i1jDUEhDgObUk2FqndHiXspH7i0RiDcTe82OK40BEx8wScr9S?=
 =?us-ascii?Q?/k976ple3YnCc26RqkvDkupn01mU0znOxtQB3zFFaLtUKc1IEbcrIDuroSEJ?=
 =?us-ascii?Q?wOvz8QHDnw4Nc4FApqPN4ugGyx+I198PFLSjX19gH6iwYNv0COKbJkmUIyfC?=
 =?us-ascii?Q?yS+hf5uJ1cx0x8FxOCseqd/nVBLU9OAbMfO/IxPunkp31kB6XF+PpXTKiFhP?=
 =?us-ascii?Q?ryB+4jcIQi7GI2HuV1NgEsO98+XKoA1XUXck7eT26XKuioJyDfEFXpZ89/X6?=
 =?us-ascii?Q?FklV4BXpBveRTiXGhoXbyGhzGiZWGx7hcPkeOfZLht4jt2MBS/OSUb0cdUgS?=
 =?us-ascii?Q?AVI5tdJJuwmnHfnPKw7zXVTh6PcYiNhv9NrkqmKvz4x/GDd0gjJyC8sRSzV7?=
 =?us-ascii?Q?UvsHJjgO4O9eJuZhrjJI9DrmIZs1KVG6GYht6ZRQGQY7dsxG15i41QWDiyKH?=
 =?us-ascii?Q?iaeXS6yX/gXF4jMwHX+8TpEubPiDSDAIkKF508L7QPgAetwvrypmb5pEyZeL?=
 =?us-ascii?Q?p0xMtdjMc4u/YEnQMOeNfF0S3TJrjwLu21ODDaZrIEosSZBci0RpAYyuNUY0?=
 =?us-ascii?Q?vz77URDcJcVUAIz4G/CyDokGNhO3uejpJ5wVqjIXxcIMjDicDwTPNsTADlpB?=
 =?us-ascii?Q?RsP8bKNgnduPS8qlINyZvMkGLpOQVmizZgV77DYhNBz0J8/sJEzkjgiBmuZW?=
 =?us-ascii?Q?+tjhRVg6G6lmMmr6UzIBA4WLRPSY46h4zjK4/nmH6gVaLLFDimqogGsEGO2Y?=
 =?us-ascii?Q?aZ4WroxzYp141TlwnwtWLJ/foTtR/7tZU0Nk+84zYFtBxzOnKT87zX51AVX0?=
 =?us-ascii?Q?ImlgG4oWKtgmtUNQGG8vanrpTXgKfAqWqoHoN2EH4s07A4wqQt/bgy7MIXeZ?=
 =?us-ascii?Q?wmjaHSAqE3IeZzOJIZfTdSJ34fb2LFbVbIo9uoFYr+JOCjKgK4zfVichU/ts?=
 =?us-ascii?Q?0YsadERKbP9vP7+y8sdgqPYFf8w9PCuwXuihOoR+LHr93481Y3re016Mxvxq?=
 =?us-ascii?Q?0R6gxBr+SOq5cW5tBqjDd4qHpp7ShfVyghIPh4B7io/QZw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aacef5-71dc-4860-e046-08d8f3d8180a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 00:01:11.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WTJJOI5P6q7E5k61lSOcQKzqNYwtwtW3Bw1SHyHkP5dx+CBQdWnwBwa8Hpg4jSWcEwsFzWW8E2o/TDtOIVkBAiLf7l+Wh3kZumXO2CuHsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/21 00:39, Gioh Kim wrote:=0A=
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>=0A=
>=0A=
> They are defined with the same value and similar meaning, let's remove=0A=
> one of them, then we can remove {WAIT,NOWAIT}.=0A=
>=0A=
> Also change the type of 'wait' from 'int' to 'enum wait_type' to make=0A=
> it clear.=0A=
>=0A=
> Cc: Jason Gunthorpe <jgg@mellanox.com>=0A=
> Cc: Leon Romanovsky <leonro@nvidia.com>=0A=
> Cc: linux-rdma@vger.kernel.org=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>=0A=
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
=0A=
It makes sense to not duplicate the enums, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
