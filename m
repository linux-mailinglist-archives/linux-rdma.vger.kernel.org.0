Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1B783DC0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjHVKSX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjHVKSW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 06:18:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308518B;
        Tue, 22 Aug 2023 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692699496; x=1724235496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d1t7w+xkqQWHRitupCj0DF6UoToiKfWZBHojgsmaasc=;
  b=kW3Tu2xaM1sRqS8k3Wk566pneNRdzOZS/MN+YDATtO2XRtgI48ZZUmVR
   jWsxr7w9iQ28NDxzvm5vNaVDnyySjXT7ifQ4wdHznE6UvtxekpARsMovZ
   A7cAJ/Qk8Q62eoUV+b/Qx1zs6pauJFOIQ7JmqPcfZAksK4kRtJzKb9x/W
   wTHgjbKyk/ma1e2wRzDuYLNJG0Xeqr9RRaJtyL52wRkfUdGMJlqbZrVFG
   oF37kkbJqXAgJMKnaiSNCXGf7Hz9ZcautMETcop/LUjRxjywIlP53r+I9
   azib272Yecmw5y23asldfr31ZMxOnw/Z5Ju6yXAvNAhe086kIHf0wW8o8
   A==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684771200"; 
   d="scan'208";a="240059320"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 18:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ugres0DJXQTP+/V60hP1HUgE7DW4eevbrPAtuYBlhvo7LR7qmkBdkgTEmq9HZ9F9oXhaxNAWDJrL6g0k+l7uTZu2KzJa9OtdDPnxvOhMOCYnPF1sGV9/HPPae8kHn98hIJaAgB7+OmpNIhqAwLG7BA4S/6K1VQF4eZWOEf3i8frJLEOyMrnSoIVzbkSQL5cplpjxaBFFed0TamCSCYRvDUv7Fy4yaHyZB0Mj9OV3ANEhnYJZmm8DwQQe2IOqkMvLwj57qzNx0B75DeobJlZSFlcfnsXXNfZ7dg/FKVBXRFDUrhxRbPftsU6FGDv2qFezNZwp79yfPmMItZbhteAWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CgkKt1Y/xI2STmHhMOXBeywmIIiqv+KAr5wkAxQZlU=;
 b=GRSbpUA2eZj9bx0kmNfwaQD3WvKVi2Pccl6f8vgh4LTx1gDQEY6ZFbotXNZRd+bOB1gt2Zxll6vn0tcScco24wY5/O+o4jit3VtynlriPJMczq/0iqHBSxyYpQQBqKs95PtAkRcpoPGDlCgjgPGIldmUBOQfgwSPMJEVGCaMVy8psmbAftbc45kG9btN1wgNGs90He3Ty9092z6f2hFViRgus4RMPOmYEyPlmeu3PnG7zeoghMRIwqx20iKIqROYTseA85LM+DV+K//bhlfTYSIEVEE30+bld8QRDdAKx4L7B2A4pWkXxiI4/Phpv/PRdOzOflZQKfRsgP6fhQ2umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CgkKt1Y/xI2STmHhMOXBeywmIIiqv+KAr5wkAxQZlU=;
 b=ZNgyMoEktzyzqk6LPSl2AtrPElaWV8NttIOHnPmY4oP0TTRwxjkyEuO+zrgM3+QibC626vW6JWlSJIpOxtSf+iHh+4WbDEeaet3G+pEKBW1a3AwWX3ijy4oiltnwONUqIFr8l0l70Ov88g+qdoRjQMoono/4ekuvBo6+N6ifBcw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8546.namprd04.prod.outlook.com (2603:10b6:806:321::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.14; Tue, 22 Aug 2023 10:18:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 10:18:11 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oA=
Date:   Tue, 22 Aug 2023 10:18:11 +0000
Message-ID: <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
In-Reply-To: <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8546:EE_
x-ms-office365-filtering-correlation-id: 8be97c06-a077-4132-4b05-08dba2f916b2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kan/0V/ShlzTITnS9isQWgoMKDhTMisUd3RSIpAa07EEu40YY/53l5QKcq7PYenzI/fMaFhBLjTD9rRTJ3qWmxGsQAAVq0xLl2xrzxveX0jCd+vgHg+GBpg3sOpatkkxarcv0gzOYwsBvaZx/3D0JX7oUUzX/Qzh5v5C1zvwT4oaQ261UTdHMiuqqwKfA4DmCuEzIkajXSjX/SxgIMBtmwbfYCTG7SzW9jGbXu6cYkXNzYDZMMYTFK8g68noR2I+kEF2m9KnL2eA0JWtGj13s4bMYk5Hk6mPmH9CIyCUnyQbTRkggbkQW79JKM+ysv9Aix60uKc+tfminxMAvR+UR/njYjjxw+EQhWnuSbWCk9Qwjzq+pDkN3pxTRFX8W+df2tyHCpf9vt+3jx9Zin2+pP5a2oKP8aydnQMp6EP0GU7zuEvoYBKTI5ujscd3WVyUBlEtnQe6GripqXI+h9BKPYjxOC1MbWwiUop9hj49EN8hrwzQQcvrrf3NSpyg7uoySDjMG720Ixf77GqZ7C9amw1Nag1VH6pxmp43X2LnnTVSOTfUl03m1uw3J/tNiZgMv9O4l7t89mBIUuqt5VcWSd/4auuuq5w0av3DOL85/dN5YblOlb+LK+ou57ZbAjI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(2906002)(30864003)(83380400001)(6506007)(6486002)(38100700002)(5660300002)(44832011)(26005)(86362001)(38070700005)(8676002)(8936002)(4326008)(6916009)(316002)(9686003)(6512007)(66446008)(66556008)(76116006)(66476007)(54906003)(64756008)(91956017)(82960400001)(478600001)(122000001)(66946007)(71200400001)(41300700001)(33716001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8rrRYrqID7en6DAA6onn2xB/vrynfcYnG7zr3s7q8RXpUHXpqAv1x+B1LoSA?=
 =?us-ascii?Q?1kehV3UwmKp5qwHg8qhCby8SXRSs7kvqNKK4EcRGFDU/dMXubL4LmaCGyIF6?=
 =?us-ascii?Q?4x8FDGlK8vc+UKPh/qQ8FOwdDrMyrRpyLC/9hgRAnYXZT+is1dcA0ujQWhwp?=
 =?us-ascii?Q?J7S8o1ml4zMMlyRa09Y1rohKIY9Q1zlsjKatq9set6fedxtf5AqM59D9y7pm?=
 =?us-ascii?Q?qKNEUX4jdKqDgfB/ZcYlxC5U3s0vhc4ipSi+JqbazurXq4/B3Z3RWuXE/FDW?=
 =?us-ascii?Q?6FXzU7DhxAnRhY/ebFBCONSrkJrqAmS06QhCHQidaGpLBS2ZKaNEEUnrY5CB?=
 =?us-ascii?Q?6O/yk9sk59a6PxnYTnSthSg+CNcVoEYcmck2350tRZ30Oq0w2kQCQbRlbNpJ?=
 =?us-ascii?Q?T2KUog2l6uYQpJrbsjFHdBvgpsCOLkPG8/ufLKec3EeN8HVAKKpLXcINTpI6?=
 =?us-ascii?Q?IlNP4TVhot6byGLgyY0LvcwC58mMS9sDMjdbxtLAwvTiQtTmZv3k34iiNhe4?=
 =?us-ascii?Q?lBD3CBiSnmeG2SV2Xr0Dyqnd7h9YbqyTMU0cXUyJzGiUyt/cIHSC1bFHgFfZ?=
 =?us-ascii?Q?z6B3cP9mHkmkcQfMFvlggWQ7FIytkuI/HNHeAnU5qTUvNC7kJswfe1iqsKar?=
 =?us-ascii?Q?nF22SzbeJ5CkIqJEZWOIT6vymyoAaavadxQPz2/zz4g8jjkXa3XDdCUGmsrG?=
 =?us-ascii?Q?9RQDYX63E88df6AvqPLf58fD/KKkR9RyhqTBJs2zX+5z3BtwK54JlFV9EfE7?=
 =?us-ascii?Q?ic6O+xoni23Ewkj+kOtSBQo+zoaAAs4R7MlBSvpuUTpFBliqX47YZg8JaICq?=
 =?us-ascii?Q?Vd1b5Bc+G82U+KeHlFKUWDjKaTpAPidzq/LiUrDDALobnFTTiD2ut7pCmhoD?=
 =?us-ascii?Q?AVCL8CjnpXi89oFGMC/SPVxTSGeGqtwUVWX+t4UIa6HmHCtzQZU+c6y8+Jhz?=
 =?us-ascii?Q?AdHnKAiVQloeMxCGOOHlt7YyjY/8iQzzWS9bTan2SRtfULwr+bChVM/aap9O?=
 =?us-ascii?Q?omyDjOtNB453Nk9JC1D1ERwo1UgH9jtTmmcnQqgQczv4G9l4fbklZGjp2iSu?=
 =?us-ascii?Q?jkPcYtwrR2c0ppRztlJdg4VV5FbNoybS4pWoDClD4QQ4khcb0AAxcR3xwpjy?=
 =?us-ascii?Q?pUjAKtlRONbydcBTaLs42JKwa4Yy50PSaHp84fejq5RnAiaqiSvcHzpeuYVR?=
 =?us-ascii?Q?D3RoEGVlCG4q/uKeYgI1U2bMsJaHd2IpCjDIhrXow40VLRROMbIwOBrTriIh?=
 =?us-ascii?Q?ArRF+NkBbCJSOzUt/ECj7LVHraKM0n8+ZfoJT6cDAuQ3iEC29jiqGhyg/S0v?=
 =?us-ascii?Q?nzs+vjuFxogoETL4jutqS5GYC1KjHX7W8Iy6acO/vNDlySP1X5ZRMoMm4FT3?=
 =?us-ascii?Q?oBRZAPzm54+P55T41evGepaA8wQut3ANoPGl5vssO92w5J8Ak+S5apZ8w/C0?=
 =?us-ascii?Q?860c7bj9W4n0FcMZ/opWdvTCms/DnCmt5R52rA0u+nrhyjatxrzUoLBt/qP/?=
 =?us-ascii?Q?+iIfO/NDBh0rghy5bdyGbmHvuXHnVDyGc/VLir3/auxg/GVfPP12/A5YQTkG?=
 =?us-ascii?Q?9b1JVUYZfNrQzRx0Hg1EXn0LUQas3MI3LL1gM9Nci7W68YJZT/2CRLHRInBD?=
 =?us-ascii?Q?u3XdYgj/EFrRKHNuZqElSdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D24A81D244DFCC4E94E397128EA62631@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GO0lnv7g3x3aLm6cYjMcuF3qO1JIYAltC+FBLRRWIDpvKkRKWvcWf51tvapdmy3eVdgpQh4FIIrn1O7+HVX3ZSwKaVzdO9Q/z3PDiAroSzkIISSDv2klj30BhMLaiy7LkNaTA0TKrmf7W7vSAl9KjTKDO/2GTXIjxtcGXh0JcCs3gkclOInDieulqzCLuGYRDUsaAdql+5faGzIGt9nO0Q4KkaMZ1d++zrPq+xtdHTwaadZ+D1AVVeTTldl5x/HzwFvjHQy+Wwp0o3Y7/RBEy4WVXZBzsOkxdGG+zktD02Utc+Q4rRdrmUNUD9HqAAW0lB3ITeLQvcpAeDp9mKUyfDT4ZjK6qKdUUqFYq8Nuu2uoGPWmmXrv9ebkNmPQAZ7qatVPSzqjavbxhmpdZJIYlPqlzDsQiETpb91dDzmJkDrth1xddaJ8Rj0TwGfI5Pt532hFXtSKsT8p3jMg8LgkfNY0Ig8BK6UoqUeOvKVsc5zeBLHNzejI9OQiALlDqFU7a140sBFsYre/yQWYZJd3mRiuJUjSvJxgVfiNWq9wRhgcb7c2W/hECZ2DP6owLLhi8cbhMUekwWEfCeYKW60rDDDJIC7OP8srw17h2777iqCGP84hLXzRBdugGrUtze51r8NT0nY+V4bmjFI/3/qqXZuHqYoH/0CaUNXRjVyHB5EjDR4l0M4+AqM+IQ7wmr/iW4hjDW5Zvl13qNeKMBseW4PlB5O0iQpuhS0wIBrJean2OqVzmM+2xrp+uSBcZEoLdEW5DpL9kxwH1dwqcbqS/CArfrBgZmUB2iF5EQTuA0XNWwYhb++tsVdPtIVQ5naqbnXP0rdstX95CRWUekO+Pw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be97c06-a077-4132-4b05-08dba2f916b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 10:18:11.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NpofTZc03TMk+2f8yWdzTr52KTM15/gvTzm8LUK92GsRclYXmsp9rMOc3i+R0WUpxS+mHPVdk8xfhXYBHOaf03dKqWB0uJT9TJ2f5NUYWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CC+: Bart,

On Aug 21, 2023 / 20:46, Bob Pearson wrote:
[...]
> Shinichiro,

Hello Bob, thanks for the response.

>=20
> I have been aware for a long time that there is a problem with blktests/s=
rp. I see hangs in
> 002 and 011 fairly often.

I repeated the test case srp/011, and observed it hangs. This hang at srp/0=
11
also can be recreated in stable manner. I reverted the commit 9b4b7c1f9f54
then observed the srp/011 hang disappeared. So, I guess these two hangs hav=
e
same root cause.

> I have not been able to figure out the root cause but suspect that
> there is a timing issue in the srp drivers which cannot handle the slowne=
ss of the software
> RoCE implemtation. If you can give me any clues about what you are seeing=
 I am happy to help
> try to figure this out.

Thanks for sharing your thoughts. I myself do not have srp driver knowledge=
, and
not sure what clue I should provide. If you have any idea of the action I c=
an
take, please let me know.

IMHO, srp/011 hang looks easier to dig in than srp/002, because srp/011 doe=
s not
involve filesystems. And at srp/011 hang, kernel reported many "SRP abort"s=
 [X],
which is similar as the srp/002 hang.

[X]

[  196.330820] run blktests srp/011 at 2023-08-22 17:22:42
[  196.819383] null_blk: module loaded
[  196.870572] null_blk: disk nullb0 created
[  196.886712] null_blk: disk nullb1 created
[  197.081369] rdma_rxe: loaded
[  197.103766] (null): rxe_set_mtu: Set mtu to 1024
[  197.139726] infiniband ens3_rxe: set active
[  197.142649] infiniband ens3_rxe: added ens3
[  197.196229] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @ 00000=
0005234c247
[  197.200354] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues=
 to 0. poll_q/nr_hw =3D (0/1)
[  197.202780] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  197.204566] scsi host3: scsi_debug: version 0191 [20210520]
                 dev_size_mb=3D32, opts=3D0x0, submit_queues=3D1, statistic=
s=3D0
[  197.209853] scsi 3:0:0:0: Direct-Access     Linux    scsi_debug       01=
91 PQ: 0 ANSI: 7
[  197.213521] scsi 3:0:0:0: Power-on or device reset occurred
[  197.217732] sd 3:0:0:0: [sdc] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  197.218797] sd 3:0:0:0: Attached scsi generic sg2 type 0
[  197.219951] sd 3:0:0:0: [sdc] Write Protect is off
[  197.223066] sd 3:0:0:0: [sdc] Mode Sense: 73 00 10 08
[  197.225611] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  197.229701] sd 3:0:0:0: [sdc] Enabling DIX T10-DIF-TYPE3-CRC, applicatio=
n tag size 6 bytes
[  197.232015] sd 3:0:0:0: [sdc] Enabling DIF Type 3 protection
[  197.233863] sd 3:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[  197.235412] sd 3:0:0:0: [sdc] Optimal transfer size 524288 bytes
[  197.241520] sd 3:0:0:0: [sdc] Attached SCSI disk
[  197.654951] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[  197.710283] ib_srpt:srpt_add_one: ib_srpt device =3D 00000000685934b8
[  197.710340] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(ens3_rxe): use_sr=
q =3D 0; ret =3D 0
[  197.710345] ib_srpt:srpt_add_one: ib_srpt Target login info: id_ext=3D50=
5400fffe123456,ioc_guid=3D505400fffe123456,pkey=3Dffff,service_id=3D505400f=
ffe123456
[  197.710657] ib_srpt:srpt_add_one: ib_srpt added ens3_rxe.
[  198.184239] Rounding down aligned max_sectors from 255 to 248
[  198.247444] Rounding down aligned max_sectors from 255 to 248
[  198.311742] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[  198.798620] ib_srp:srp_add_one: ib_srp: srp_add_one: 1844674407370955161=
5 / 4096 =3D 4503599627370495 <> 512
[  198.798630] ib_srp:srp_add_one: ib_srp: ens3_rxe: mr_page_shift =3D 12, =
device->max_mr_size =3D 0xffffffffffffffff, device->max_fast_reg_page_list_=
len =3D 512, max_pages_per_mr =3D 512, mr_max_size =3D 0x200000
[  198.898881] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  198.898908] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  198.898942] ib_srp:add_target_store: ib_srp: max_sectors =3D 1024; max_p=
ages_per_mr =3D 512; mr_page_size =3D 4096; max_sectors_per_mr =3D 4096; mr=
_per_cmd =3D 2
[  198.898947] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  198.910816] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  198.916313] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  198.919848] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 00000000d71a59ab
[  198.920007] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  198.920308] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000a5feaed8 name=3D10.0.2.15 ch=3D00000000d71a59ab
[  198.921661] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  198.921688] scsi host4: ib_srp: using immediate data
[  198.921951] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-18: queued =
zerolength write
[  198.922831] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-18 wc-=
>status 0
[  198.931958] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  198.937206] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  198.939984] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 000000009f3b3382
[  198.940133] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  198.940173] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000c70b88d5 name=3D10.0.2.15 ch=3D000000009f3b3382
[  198.940454] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  198.940460] scsi host4: ib_srp: using immediate data
[  198.940840] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-20: queued =
zerolength write
[  198.941071] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-20 wc-=
>status 0
[  198.950276] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  198.955351] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  198.958102] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 000000002f3d11a8
[  198.958270] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  198.958312] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000008dd11076 name=3D10.0.2.15 ch=3D000000002f3d11a8
[  198.958626] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  198.958632] scsi host4: ib_srp: using immediate data
[  198.959552] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-22: queued =
zerolength write
[  198.959815] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-22 wc-=
>status 0
[  198.968720] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  198.973609] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  198.976219] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 00000000b6291aea
[  198.976369] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  198.976413] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D00000000d8231f1e name=3D10.0.2.15 ch=3D00000000b6291aea
[  198.976694] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  198.976700] scsi host4: ib_srp: using immediate data
[  198.976810] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-24: queued =
zerolength write
[  198.976929] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-24 wc-=
>status 0
[  198.977610] scsi host4: SRP.T10:505400FFFE123456
[  198.987781] scsi 4:0:0:0: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  198.996088] scsi 4:0:0:0: LUN assignments on this target have changed. T=
he Linux SCSI layer does not automatically remap LUN assignments.
[  199.000231] scsi 4:0:0:0: alua: supports implicit and explicit TPGS
[  199.002500] scsi 4:0:0:0: alua: device naa.60014056e756c6c62300000000000=
000 port group 0 rel port 1
[  199.007201] sd 4:0:0:0: [sdd] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  199.007936] sd 4:0:0:0: Attached scsi generic sg3 type 0
[  199.010141] sd 4:0:0:0: [sdd] Write Protect is off
[  199.012388] sd 4:0:0:0: [sdd] Mode Sense: 43 00 00 08
[  199.014718] scsi 4:0:0:2: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  199.015810] sd 4:0:0:0: [sdd] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  199.019705] sd 4:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[  199.021312] sd 4:0:0:0: [sdd] Optimal transfer size 126976 bytes
[  199.023796] scsi 4:0:0:2: alua: supports implicit and explicit TPGS
[  199.025378] scsi 4:0:0:2: alua: device naa.60014057363736964626700000000=
000 port group 0 rel port 1
[  199.029763] sd 4:0:0:2: [sde] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  199.029822] sd 4:0:0:2: Attached scsi generic sg4 type 0
[  199.030670] sd 4:0:0:2: [sde] Write Protect is off
[  199.034314] sd 4:0:0:2: [sde] Mode Sense: 43 00 10 08
[  199.036643] sd 4:0:0:0: [sdd] Attached SCSI disk
[  199.038861] scsi 4:0:0:1: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  199.039148] sd 4:0:0:2: [sde] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  199.046070] sd 4:0:0:2: [sde] Preferred minimum I/O size 512 bytes
[  199.047580] scsi 4:0:0:1: LUN assignments on this target have changed. T=
he Linux SCSI layer does not automatically remap LUN assignments.
[  199.047685] sd 4:0:0:2: [sde] Optimal transfer size 524288 bytes
[  199.049654] scsi 4:0:0:1: alua: supports implicit and explicit TPGS
[  199.053197] scsi 4:0:0:1: alua: device naa.60014056e756c6c62310000000000=
000 port group 0 rel port 1
[  199.056642] sd 4:0:0:1: Attached scsi generic sg5 type 0
[  199.056679] sd 4:0:0:1: [sdf] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  199.057539] ib_srp:srp_add_target: ib_srp: host4: SCSI scan succeeded - =
detected 3 LUNs
[  199.057979] sd 4:0:0:1: [sdf] Write Protect is off
[  199.058888] scsi host4: ib_srp: new target: id_ext 505400fffe123456 ioc_=
guid 505400fffe123456 sgid fe80:0000:0000:0000:5054:00ff:fe12:3456 dest 10.=
0.2.15
[  199.059238] sd 4:0:0:1: [sdf] Mode Sense: 43 00 00 08
[  199.064721] sd 4:0:0:2: [sde] Attached SCSI disk
[  199.066646] sd 4:0:0:1: [sdf] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  199.069653] sd 4:0:0:1: [sdf] Preferred minimum I/O size 512 bytes
[  199.071330] sd 4:0:0:1: [sdf] Optimal transfer size 126976 bytes
[  199.072389] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  199.072952] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  199.072985] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  199.073001] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  199.073012] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  199.083799] sd 4:0:0:1: [sdf] Attached SCSI disk
[  199.095910] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  199.095929] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  199.095959] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  199.095975] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  199.096005] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  199.096020] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  199.096030] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  199.431496] sd 4:0:0:1: alua: transition timeout set to 60 seconds
[  199.433258] sd 4:0:0:1: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  199.456782] sd 4:0:0:2: alua: transition timeout set to 60 seconds
[  199.458737] sd 4:0:0:2: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  199.488105] sd 4:0:0:0: alua: transition timeout set to 60 seconds
[  199.489964] sd 4:0:0:0: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  204.807887] device-mapper: multipath: 253:3: Failing path 8:48.
[  204.856553] scsi 4:0:0:0: alua: Detached
[  204.868122] sd 4:0:0:2: [sde] Synchronizing SCSI cache
[  204.886615] scsi 4:0:0:2: alua: Detached
[  204.919557] scsi 4:0:0:1: alua: Detached
[  204.925989] ib_srpt receiving failed for ioctx 00000000ddab6801 with sta=
tus 5
[  204.926715] ib_srpt receiving failed for ioctx 000000000bc9beb4 with sta=
tus 5
[  204.927759] ib_srpt receiving failed for ioctx 000000002ec13abb with sta=
tus 5
[  204.927762] ib_srpt receiving failed for ioctx 00000000a73075da with sta=
tus 5
[  204.927764] ib_srpt receiving failed for ioctx 00000000db73d7b8 with sta=
tus 5
[  204.927766] ib_srpt receiving failed for ioctx 00000000b7c85b9d with sta=
tus 5
[  204.927767] ib_srpt receiving failed for ioctx 00000000d70acd70 with sta=
tus 5
[  204.927769] ib_srpt receiving failed for ioctx 0000000059193fad with sta=
tus 5
[  204.927771] ib_srpt receiving failed for ioctx 0000000019e9ec9e with sta=
tus 5
[  204.927773] ib_srpt receiving failed for ioctx 0000000033e124b9 with sta=
tus 5
[  205.443422] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-20: queued =
zerolength write
[  205.444973] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-18: queued =
zerolength write
[  205.445056] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-20 wc-=
>status 5
[  205.446047] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-18 wc-=
>status 5
[  205.446190] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-20
[  205.448320] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-18
[  205.506138] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-24: queued =
zerolength write
[  205.506195] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-22: queued =
zerolength write
[  205.506263] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-24 wc-=
>status 5
[  205.506329] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-22 wc-=
>status 5
[  205.506354] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-24
[  205.506381] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-22
[  209.945988] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  209.946026] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  209.946046] ib_srp:add_target_store: ib_srp: max_sectors =3D 1024; max_p=
ages_per_mr =3D 512; mr_page_size =3D 4096; max_sectors_per_mr =3D 4096; mr=
_per_cmd =3D 2
[  209.946055] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  209.958117] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  209.962963] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  209.965421] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 00000000fec65d93
[  209.965591] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  209.965635] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000009f6a881a name=3D10.0.2.15 ch=3D00000000fec65d93
[  209.966180] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  209.966187] scsi host4: ib_srp: using immediate data
[  209.967393] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-26: queued =
zerolength write
[  209.967518] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-26 wc-=
>status 0
[  209.976127] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  209.984015] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  209.988890] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 0000000029b704ac
[  209.989221] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  209.989297] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D0000000078cf4fe1 name=3D10.0.2.15 ch=3D0000000029b704ac
[  209.989641] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  209.989647] scsi host4: ib_srp: using immediate data
[  209.989814] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-28: queued =
zerolength write
[  209.989997] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-28 wc-=
>status 0
[  209.999235] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  210.004184] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  210.006893] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 00000000492e551c
[  210.007050] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  210.007096] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D000000008b9aa995 name=3D10.0.2.15 ch=3D00000000492e551c
[  210.007402] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  210.007410] scsi host4: ib_srp: using immediate data
[  210.007582] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-30: queued =
zerolength write
[  210.008212] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-30 wc-=
>status 0
[  210.017177] ib_srpt Received SRP_LOGIN_REQ with i_port_id fe80:0000:0000=
:0000:5054:00ff:fe12:3456, t_port_id 5054:00ff:fe12:3456:5054:00ff:fe12:345=
6 and it_iu_len 8260 on port 1 (guid=3Dfe80:0000:0000:0000:5054:00ff:fe12:3=
456); pkey 0xffff
[  210.022684] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
[  210.025487] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib: max_cq=
e=3D 8191 max_sge=3D 32 sq_size =3D 4096 ch=3D 0000000033dc05a8
[  210.025663] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr 10.0.=
2.15 or i_port_id 0xfe80000000000000505400fffe123456
[  210.025707] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection sess=
=3D0000000066092653 name=3D10.0.2.15 ch=3D0000000033dc05a8
[  210.026031] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len =3D 8260
[  210.026038] scsi host4: ib_srp: using immediate data
[  210.026169] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-32: queued =
zerolength write
[  210.026743] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-32 wc-=
>status 0
[  210.026940] scsi host4: SRP.T10:505400FFFE123456
[  210.032959] scsi 4:0:0:0: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  210.041064] scsi 4:0:0:0: alua: supports implicit and explicit TPGS
[  210.043448] scsi 4:0:0:0: alua: device naa.60014056e756c6c62300000000000=
000 port group 0 rel port 1
[  210.047197] sd 4:0:0:0: Attached scsi generic sg3 type 0
[  210.047772] sd 4:0:0:0: [sdd] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  210.051913] sd 4:0:0:0: [sdd] Write Protect is off
[  210.053426] sd 4:0:0:0: [sdd] Mode Sense: 43 00 00 08
[  210.054089] scsi 4:0:0:2: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  210.054483] sd 4:0:0:0: [sdd] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  210.060433] sd 4:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[  210.062061] sd 4:0:0:0: [sdd] Optimal transfer size 126976 bytes
[  210.063874] scsi 4:0:0:2: alua: supports implicit and explicit TPGS
[  210.065561] scsi 4:0:0:2: alua: device naa.60014057363736964626700000000=
000 port group 0 rel port 1
[  210.069906] sd 4:0:0:2: Attached scsi generic sg4 type 0
[  210.071244] sd 4:0:0:0: [sdd] Attached SCSI disk
[  210.071438] sd 4:0:0:2: [sde] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  210.075126] sd 4:0:0:2: [sde] Write Protect is off
[  210.076561] sd 4:0:0:2: [sde] Mode Sense: 43 00 10 08
[  210.077417] sd 4:0:0:2: [sde] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[  210.080889] sd 4:0:0:2: [sde] Preferred minimum I/O size 512 bytes
[  210.081559] scsi 4:0:0:1: Direct-Access     LIO-ORG  IBLOCK           4.=
0  PQ: 0 ANSI: 6
[  210.082390] sd 4:0:0:2: [sde] Optimal transfer size 524288 bytes
[  210.090475] scsi 4:0:0:1: alua: supports implicit and explicit TPGS
[  210.092667] scsi 4:0:0:1: alua: device naa.60014056e756c6c62310000000000=
000 port group 0 rel port 1
[  210.096228] sd 4:0:0:1: [sdf] 65536 512-byte logical blocks: (33.6 MB/32=
.0 MiB)
[  210.098474] sd 4:0:0:1: [sdf] Write Protect is off
[  210.099943] sd 4:0:0:1: [sdf] Mode Sense: 43 00 00 08
[  210.100772] sd 4:0:0:1: [sdf] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[  210.104885] sd 4:0:0:1: [sdf] Preferred minimum I/O size 512 bytes
[  210.106065] sd 4:0:0:2: [sde] Attached SCSI disk
[  210.106425] sd 4:0:0:1: [sdf] Optimal transfer size 126976 bytes
[  210.109617] sd 4:0:0:1: Attached scsi generic sg5 type 0
[  210.112866] ib_srp:srp_add_target: ib_srp: host4: SCSI scan succeeded - =
detected 3 LUNs
[  210.112873] scsi host4: ib_srp: new target: id_ext 505400fffe123456 ioc_=
guid 505400fffe123456 sgid fe80:0000:0000:0000:5054:00ff:fe12:3456 dest 10.=
0.2.15
[  210.114809] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  210.114827] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  210.114857] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  210.114873] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  210.114883] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  210.121314] sd 4:0:0:1: [sdf] Attached SCSI disk
[  210.133745] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  210.133764] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  210.133796] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  210.133813] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  210.133846] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  210.133861] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  210.133871] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  210.325220] sd 4:0:0:0: alua: transition timeout set to 60 seconds
[  210.327176] sd 4:0:0:0: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  210.512382] sd 4:0:0:1: alua: transition timeout set to 60 seconds
[  210.514366] sd 4:0:0:1: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  210.537067] sd 4:0:0:2: alua: transition timeout set to 60 seconds
[  210.538788] sd 4:0:0:2: alua: port group 00 state A non-preferred suppor=
ts TOlUSNA
[  217.322048] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.322067] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.322078] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  217.336141] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.336160] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.336190] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  217.336206] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  217.336216] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  217.351059] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.351079] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.351109] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  217.351125] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  217.351155] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  217.351171] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  217.351180] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  217.583935] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.583961] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.583974] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  217.599109] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.599128] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.599158] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  217.599174] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  217.599184] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  217.617214] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.617234] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.617270] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  217.617285] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  217.617316] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  217.617331] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  217.617341] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  217.839147] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.839168] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.839187] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  217.853795] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.853815] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.853846] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  217.853861] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  217.853872] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  217.875042] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  217.875061] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  217.875092] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  217.875107] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  217.875138] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  217.875152] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  217.875162] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.110548] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.110585] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.110603] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  218.127935] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.127959] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.128003] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.128023] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.128036] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.145223] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.145243] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.145274] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.145295] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.145326] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  218.145340] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  218.145351] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.379877] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.379897] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.379908] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  218.399268] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.399298] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.399330] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.399346] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.399356] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.414922] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.414942] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.414973] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.414989] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.415019] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  218.415034] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  218.415044] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.657313] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.657347] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.657365] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  218.672418] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.672437] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.672468] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.672483] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.672494] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.687795] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.687815] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.687846] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.687861] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.687892] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  218.687907] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  218.687917] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.932504] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.932549] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.932561] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  218.948134] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.948155] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.948185] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.948200] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.948210] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  218.961885] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  218.961904] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  218.961935] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  218.961951] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  218.961981] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  218.961996] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  218.962006] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  219.196670] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.196691] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.196701] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  219.213009] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.213029] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.213059] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  219.213075] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  219.213085] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  219.231373] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.231392] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.231424] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  219.231439] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  219.231470] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  219.231485] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  219.231495] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  219.483889] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.483910] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.483920] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  219.498333] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.498365] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.498405] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  219.498425] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  219.498439] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  219.515059] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.515080] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.515110] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  219.515128] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  219.515158] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  219.515173] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  219.515183] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  219.760020] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.760040] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.760051] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  219.777862] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.777896] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.777958] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  219.777987] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  219.778005] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  219.799030] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  219.799051] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  219.799087] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  219.799102] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  219.799133] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  219.799147] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  219.799158] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.086363] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.086383] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.086393] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  227.107902] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.107922] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.107952] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.107968] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.107978] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.125254] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.125274] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.125304] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.125320] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.125350] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  227.125365] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  227.125375] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.355831] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.355852] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.355862] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  227.369483] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.369502] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.369533] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.369572] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.369584] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.386900] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.386920] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.386951] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.386966] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.386997] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  227.387012] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  227.387022] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.610540] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.610603] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.610620] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  227.628902] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.628922] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.628955] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.628971] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.628981] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.645234] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.645255] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.645285] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.645301] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.645334] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  227.645349] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  227.645359] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.873626] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.873646] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.873656] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  227.890838] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.890857] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.890887] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.890903] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.890913] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  227.905153] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  227.905173] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  227.905203] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  227.905218] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  227.905249] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  227.905264] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  227.905274] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.130167] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.130187] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.130197] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  228.151246] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.151271] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.151312] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.151332] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.151345] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.177952] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.177972] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.178003] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.178020] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.178051] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  228.178066] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  228.178076] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.408180] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.408204] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.408217] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  228.429107] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.429133] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.429173] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.429193] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.429206] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.446183] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.446202] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.446233] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.446248] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.446279] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  228.446295] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  228.446305] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.681133] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.681166] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.681180] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  228.699467] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.699490] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.699521] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.699536] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.699547] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.715076] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.715096] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.715127] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.715142] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.715173] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  228.715188] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  228.715197] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.942150] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.942176] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.942190] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  228.957037] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.957068] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.957125] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.957153] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.957172] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  228.973879] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  228.973900] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  228.973931] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  228.973947] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  228.973978] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  228.973993] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  228.974003] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  229.204277] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.204298] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.204308] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  229.224969] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.224989] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.225021] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  229.225037] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  229.225047] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  229.241092] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.241111] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.241142] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  229.241157] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  229.241187] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  229.241202] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  229.241212] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  229.467761] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.467786] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.467797] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  229.483759] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.483790] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.483839] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  229.483866] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  229.483883] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  229.501487] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.501512] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.501581] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  229.501615] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  229.501660] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  229.501680] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  229.501693] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  229.752662] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.752682] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.752692] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  229.764884] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.764903] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.764934] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  229.764951] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  229.764961] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  229.781797] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  229.781817] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  229.781848] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  229.781863] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  229.781893] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  229.781908] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  229.781918] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.010623] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.010643] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.010654] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  230.026757] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.026777] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.026816] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.026832] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.026842] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.047533] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.047671] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.047714] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.047735] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.047777] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  230.047796] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  230.047815] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.276899] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.276919] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.276929] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  230.294911] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.294932] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.294963] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.294979] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.294989] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.316396] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.316417] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.316447] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.316463] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.316493] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  230.316508] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  230.316518] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.543058] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.543081] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.543091] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  230.560038] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.560058] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.560089] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.560105] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.560115] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.580843] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.580864] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.580895] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.580911] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.580941] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  230.580956] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  230.580966] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.821544] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.821589] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.821600] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  230.833829] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.833861] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.833892] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.833908] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.833918] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  230.854790] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  230.854809] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  230.854845] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  230.854861] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  230.854891] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  230.854906] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  230.854916] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.101599] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.101620] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.101630] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  231.122996] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.123015] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.123046] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.123061] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.123072] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.136982] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.137001] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.137032] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.137047] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.137078] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  231.137093] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  231.137103] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.380246] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.380267] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.380278] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  231.393413] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.393433] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.393464] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.393480] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.393490] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.414392] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.414425] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.414487] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.414516] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.414601] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  231.414631] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  231.414649] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.645614] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.645634] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.645645] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  231.664063] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.664082] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.664113] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.664129] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.664139] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.681247] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.681267] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.681298] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.681313] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.681344] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  231.681358] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  231.681368] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.924774] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.924793] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.924803] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  231.944478] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.944499] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.944531] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.944547] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.944557] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  231.962526] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  231.962545] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  231.962606] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  231.962623] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  231.962653] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  231.962668] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  231.962678] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  232.185860] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  232.185880] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  232.185890] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3D10.0.2.15
[  232.202741] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  232.202763] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  232.202794] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  232.202809] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  232.202820] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfec0:0000:0000:0=
000:5054:00ff:fe12:3456
[  232.223744] ib_srp:srp_parse_in: ib_srp: 10.0.2.15 -> 10.0.2.15:0
[  232.223763] ib_srp:srp_parse_in: ib_srp: 10.0.2.15:5555 -> 10.0.2.15:555=
5
[  232.223793] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456] -> [f=
ec0::5054:ff:fe12:3456]:0/167772687%0
[  232.223809] ib_srp:srp_parse_in: ib_srp: [fec0::5054:ff:fe12:3456]:5555 =
-> [fec0::5054:ff:fe12:3456]:5555/167772687%0
[  232.223839] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2] -> =
[fe80::5054:ff:fe12:3456]:0/167772687%2
[  232.223854] ib_srp:srp_parse_in: ib_srp: [fe80::5054:ff:fe12:3456%2]:555=
5 -> [fe80::5054:ff:fe12:3456]:5555/167772687%2
[  232.223864] scsi host5: ib_srp: Already connected to target port with id=
_ext=3D505400fffe123456;ioc_guid=3D505400fffe123456;dest=3Dfe80:0000:0000:0=
000:5054:00ff:fe12:3456
[  242.836918] scsi host4: SRP abort called
[  242.840917] scsi host4: Sending SRP abort for tag 0x3d
[  242.846319] ib_srpt:srpt_handle_tsk_mgmt: ib_srpt recv tsk_mgmt fn 1 for=
 task_tag 61 and cmd tag 2147483649 ch 00000000fec65d93 sess 000000009f6a88=
1a
[  242.846638] ABORT_TASK: Sending TMR_TASK_DOES_NOT_EXIST for ref_tag: 61
[  242.847642] scsi host4: Null scmnd for RSP w/tag 0x0000000000003d receiv=
ed on ch 0 / QP 0x19
[  242.854933] scsi host4: SRP abort called
[  242.857399] scsi host4: SRP abort called
[  242.859682] scsi host4: SRP abort called
[  242.861854] scsi host4: SRP abort called
[  242.863946] scsi host4: SRP abort called
[  242.866014] scsi host4: SRP abort called
[  242.868081] scsi host4: SRP abort called
[  242.870154] scsi host4: SRP abort called
[  242.871974] scsi host4: SRP abort called
[  242.874470] scsi host4: SRP abort called
[  242.876505] scsi host4: SRP abort called
[  242.878640] scsi host4: SRP abort called
[  242.880548] scsi host4: SRP abort called
[  242.882525] scsi host4: SRP abort called
[  242.884463] scsi host4: SRP abort called
[  242.886145] scsi host4: SRP abort called
[  242.887812] scsi host4: SRP abort called
[  242.889573] scsi host4: SRP abort called
[  242.891210] scsi host4: SRP abort called
[  242.892901] scsi host4: SRP abort called
[  242.903730] device-mapper: multipath: 253:3: Failing path 8:48.
[  242.928724] scsi 4:0:0:0: alua: Detached
[  242.948278] sd 4:0:0:2: [sde] Synchronizing SCSI cache
[  242.969091] scsi 4:0:0:2: alua: Detached
[  242.996739] srpt_recv_done: 502 callbacks suppressed
[  242.996743] ib_srpt receiving failed for ioctx 000000002b03f6bc with sta=
tus 5
[  242.996898] ib_srpt receiving failed for ioctx 0000000067119178 with sta=
tus 5
[  242.997255] ib_srpt receiving failed for ioctx 00000000451fc813 with sta=
tus 5
[  242.997850] ib_srpt receiving failed for ioctx 0000000006e2d4c1 with sta=
tus 5
[  242.997853] ib_srpt receiving failed for ioctx 000000007db43a18 with sta=
tus 5
[  242.997855] ib_srpt receiving failed for ioctx 00000000976247d6 with sta=
tus 5
[  242.997856] ib_srpt receiving failed for ioctx 000000008e5c98aa with sta=
tus 5
[  242.997858] ib_srpt receiving failed for ioctx 00000000f17ceb65 with sta=
tus 5
[  242.997860] ib_srpt receiving failed for ioctx 00000000e0ba06d1 with sta=
tus 5
[  242.997861] ib_srpt receiving failed for ioctx 000000007ac01832 with sta=
tus 5
[  243.020721] scsi 4:0:0:1: alua: Detached
[  243.522706] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-32: queued =
zerolength write
[  243.522742] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-30: queued =
zerolength write
[  243.522769] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-28: queued =
zerolength write
[  243.522785] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-32 wc-=
>status 5
[  243.522795] ib_srpt:srpt_zerolength_write: ib_srpt 10.0.2.15-26: queued =
zerolength write
[  243.522806] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-32
[  243.522848] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-30 wc-=
>status 5
[  243.522879] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-26 wc-=
>status 5
[  243.522905] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-30
[  243.522910] ib_srpt:srpt_zerolength_write_done: ib_srpt 10.0.2.15-28 wc-=
>status 5
[  243.522921] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-26
[  243.522934] ib_srpt:srpt_release_channel_work: ib_srpt 10.0.2.15-28
