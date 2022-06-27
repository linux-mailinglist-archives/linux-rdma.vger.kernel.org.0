Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC21D55D6EA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiF0XFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 19:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiF0XFg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 19:05:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B522515
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656371133; x=1687907133;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dmFliImHdRKCKynMYx9jVUmJVIL5T362T6tEKsadegE=;
  b=n7aZzqLA8KTzSwSS30B7dLDXdFpnbjJw0OpPBt9Z/dO1zkNrX9deucth
   q9Q28kMRsBuoedluVpwbnpqFcpXJb7w/DwusLJp2+kuSwpHgwBOLAUXQR
   bY1zJVCPJiXBVD7z617HAt78yTBIkDY2bP7CK60i5LFRdG0oBNPS/z4pD
   qMpdUCwxLw7aYpXNuyW9ZRxc3A20Z1ESnYKrK28wncA5NDL/z1+oMQtQd
   J/zgVV3lSA0uo/vfLc5I+zWNTap2iwFpDUOhGvwj89z7n8DHbM991JX70
   /V+3rKPwLISQmQc4qN6f3fefFpD6FYItYVEfIl/CV0CYRwCDZAaS/WVZe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367895783"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367895783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 16:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="622723891"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2022 16:05:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 16:05:32 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 16:05:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 16:05:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 16:05:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFa+eTf9s0FErQPDiTZO5k+YKK+nYkmp8bmevQyHm42XKHsrIhLQMTbBh3UCr14jAQGr10+KvpkB9MuG1J1s4N+zWNdb3K5baARFkN4JK1cpXyiwFerAu7sqXuz8Wwz+Eyc9Gi3nwsZXAd0WZ4oURtACf+QH0s0zwC2H/A00W7nILNygsHhaWaXk49Pa8wqTvrKl7IBrhoJwdsw/hYyt1B3Cp0FfxEeguHvGKVbYvfdZl+ep61wckSWEJcWkftEKQu0EPr2rj0Z4L9d9Pq6Wnqtltdk+FL+AORNixBKXrIb3e4Kd2dDByuofcHO1YC+Mui3YMM1uCqh09vXkx73P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrUKlHAp5EaVX1dCiMiE6vdubQUMhAg88IdicSXfu7Q=;
 b=J6r2vDdmsw8IoWY7l/rP6e49m0+vpSGoncYPRgt39aHyfyiyTdtw7uhpd+sJ0o+4v/rWmw73VcVhhAL45qc5FPNCMmRFQAJ/Q5ilPRQVEEZPogsmHU8BCYylc3hPSDFjFvF6IBB4ZgbPHD7a7Mweagx65ttkEyBX7uleNIQQyRwq5V3Q3ntZQZ3yIgZq8v4jsHs6/aOMLpvPa7UQsWAIJ/Z+XYCuh9t4ImfdtdSvVEYugGBGS+1O8ndJ08Y6cO+5vmCZQkq7+M/R3CljcHP5/wHdW1TCExcg0JH+0F9Qpt+IlXohfAK87rZxyhVH6BzasJE+lYvDKuSXt+kZw9KDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 23:05:27 +0000
Received: from CY5PR11MB6534.namprd11.prod.outlook.com
 ([fe80::ac13:1aeb:a46f:708c]) by CY5PR11MB6534.namprd11.prod.outlook.com
 ([fe80::ac13:1aeb:a46f:708c%6]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 23:05:27 +0000
From:   "Tung, Chien Tin" <chien.tin.tung@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Thread-Topic: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Thread-Index: AdiKb2G3VsMZKUupSkG0ABXCvyvyGw==
Date:   Mon, 27 Jun 2022 23:05:27 +0000
Message-ID: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6786f00-3359-4fe7-acce-08da58918673
x-ms-traffictypediagnostic: SA2PR11MB4987:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UFVIKpJ/NCxD42An0HPg7e719IM6DghPyHWToAwMG6FAehlwAdHqKjuLCEbO0ZAv7Xfu+NnBNB0XBA6wQvdUbc2w7Xu5381EzLvIKT7vmhzpRvIDPyezp5HXWePryAIsCmvu6AxoDvllE4eLXcb5ZNlECVxL10Up0Hl0qD7ntYA279gEHCLBZG21M1j7izgtO3nk2oniSN1K8mlK3NK+/STA+aYYWDXUSgegRv/Q+D2B/MeoJ8v7zJhYWQEnP7st4OclSuMUMn0W+GeqBQk/xwiod4sPx58DqpVrqQ5xGbegEoyDM74VHOJLalXf2l0hmw7AdIIpV0bY+S41sH/Di9aFNfuoYgiScEUM6jjPdUdD6jrGLTidC40vhP2jOt6pFUyTxzxrLniJ9dYPbiaskrOmOJIdyVleFmgRWXeKzcXSn1z69PqKWWjBL+pWtrp0ZDbuaxLHgKnbygnRGeR1vrWe0CMQ0ky/uEfEuJqfhm13XMabGYLhVBCMkx5t4oaGR0PG17jZH7Q3LwuZ8forGmEBOmJmaCsuPLIso+oE6YOYXPpT/TzdVDzS+LaE7Z7m9bKUoAuA4bY6/mzP+72m0fPY9QlgMR+xvnm0/dA5yXYHfDcUe1CED3GedbmIkObcOTragNwVDIkiAgrUtSOsE2AsyEqyT2Y/+n6eT0tef13XAqAtBwgcx/knkEsA2vz8sVfESOyvA3QvdDUJ7f/NEN7H80Z7KT+ZS1H1PbCVKjxgw8tNX9t8ti7OQ0JVM7lSwRcsUZ2Bow0zVAv54Y71sLv6Jhxqlnh/EX1YRGUAHLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6534.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(136003)(346002)(396003)(122000001)(38100700002)(55016003)(6916009)(186003)(33656002)(8936002)(30864003)(316002)(83380400001)(5660300002)(76116006)(71200400001)(478600001)(82960400001)(9686003)(66946007)(66446008)(86362001)(26005)(66556008)(64756008)(8676002)(38070700005)(52536014)(66476007)(41300700001)(2906002)(7696005)(6506007)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nd5dTTOc7qLVSK8PXix2l0J16i+8Fn2PoaHDeaUakeXQ2qIDEaheyXFL//3N?=
 =?us-ascii?Q?kAs93BAZO4SC0VjYGOR8QZPt8dT0iYhXnIYF96wld9gyazWntjK6Rg2bw4FZ?=
 =?us-ascii?Q?pSomKzwOKjN/fZTcr4jiBWMd7HgmO9qfG7Crdf0/iF57WRYOViNWLQlj5FWT?=
 =?us-ascii?Q?u6WcMYZCo5HG9h9pD8sKuDbctf3uWsodc1MQnyv+UUKg+M7X1Z9B+wdtLKiX?=
 =?us-ascii?Q?HW+gP02++sX6i54ba/Ucbo4/hjRxgnOyu6IJnqzY/4ZRQ1Q5qRcuYXZ/zuAH?=
 =?us-ascii?Q?FkDU0ZVkvScBmje25jeYnmgGbuqDf1EVGFNNIXb8MWRCMEPr5R5a+fjvs4qq?=
 =?us-ascii?Q?0+ATij5oDpBfToooSrJhbqSNt25MCLywIiLHpjZ6ggEYiEJ2CevIiYWafTDR?=
 =?us-ascii?Q?/wBIDjaNUXsT1angME0oLLmePhbwfYJAtbQjPcv5IomopBFrpWNjjTJDK8ld?=
 =?us-ascii?Q?MPPz5VGoogoaP28fNyT9OzodwRK5yHGYqLUBMTx5AgpWNKA44ksGLL4Tx6ZM?=
 =?us-ascii?Q?TX2wMBk2GM4tW5E6Pwb+6Oc51ZSWlxqTvNUVZ431l47rSrgyaz79GoXeo5pq?=
 =?us-ascii?Q?CjD6k3cqJTOvTFMt3NCk8+Y7+7ooW0g7TrSGr9wd5v1VZVxj15n2ZQWXg8It?=
 =?us-ascii?Q?ay8dO1sXDyqwxd6ewYJKu3rdGjWUnejiOQSUO27Y2W0bUWryRfB6ozD4Ck94?=
 =?us-ascii?Q?jLOG7BHo5ExY+h/8IlAJxA5WYthlvU70+B9Z2SAyoCPWERicgsYN42v8gm7W?=
 =?us-ascii?Q?4JTIEP0lmWPjWycMIvkfCU0Bg9KG6utnqg4xvZ970wCW0z0f5f8DKn6/+gDf?=
 =?us-ascii?Q?gmrL89lqM8C1sGdqyf4h8ftSc1wDEcRZxFLPtv2xn4RjyrwwKbE6Ira99Iad?=
 =?us-ascii?Q?I55vnHnDqniJouvVcW3la7b37rbNUCQu4GpozuPNwCdoWWe4/z6W+PAwnzLJ?=
 =?us-ascii?Q?kM4mL+loK/4uWVoIkeQBtXPQUR4qI0xYgz49soJfv2kp/ozI1Etnel3iPthM?=
 =?us-ascii?Q?db1yKntIUDsDsuoWRJTfDSld8XLv/8ysHPH7Iq4pvSw6eOS5uhuhmblSSKil?=
 =?us-ascii?Q?lTOYXcxiocs0DU3CL/CWj1dhnjUHooK5rYetG9DNcOVtnTd0ub3UlKGYb/MN?=
 =?us-ascii?Q?BBZOD+X9DFvipmx5mQfkZhVSm9JEXCCNp2lyD/k3PqmxmHyV4+mmE9eYhtR+?=
 =?us-ascii?Q?rnWSbO0X+bvuk51jgc9lEm2bl8aimpSSxmBrO9GRdhdZt2AHoYKlbW3A5M6u?=
 =?us-ascii?Q?G2SvogCTWFamxKY+d3lZSL6INJFU4P77f6kNyaTIqXj4afW0QR5uBaQpLeAu?=
 =?us-ascii?Q?rS9atJwGZZ1JZZ0irlDjLZKGMtxQbxhur1dlU8ZflBfrfHOnyuuakzVcFF60?=
 =?us-ascii?Q?s6IY87+Rqn9/NH1KevmSlubHYRiENT4Kf6KI6nK3fkvv7Z86L/Ho4TVLeZwq?=
 =?us-ascii?Q?lu5+f1qPkA6mBnqVRlocD5c/23HbKGvN2Jh8MepLCWV9ycXGS5LgOyI6IkvY?=
 =?us-ascii?Q?B56tf4gflddQVc3QbynU9HkgjkS7oahXfZpchUWvLULcGd0mg1EwrNJvHXkr?=
 =?us-ascii?Q?rwf4s127YGPNla7JRLtyk1l3oGxXxJh9SDXqR01R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6534.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6786f00-3359-4fe7-acce-08da58918673
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 23:05:27.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKThoh/ZWV9ikZVSMuHWgy+3XUU7S6yTpyyPZEd+2dKskUZ8BD6oVs3GlvT6f1gR7ZGoU6NlLi4YMlvH+VjfSdmmF8h/ejyQqT3UEQr8kD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A customer is getting an error creating QPs during scale up testing on Mell=
anox adapter.
I am able to reproduce the issue locally using a test program calling into =
ibv_create_qp in a loop.
The problem does not appear to be related to rdma-core as with different ml=
x5* drivers, I can either create 260,000+ QPs or 130,000+ QPs.

Logs with command buffers and error messages are at the end of this email.
All tests are performed using the same server, 64G memory, RHEL 8.5, same u=
limit setting and selinux disabled.
ConnectX-4 has firmware-version: 12.28.2006 (MT_2180110032), in infiniband =
mode and  max_qp:  262144.

Test 1 SW config - RHEL 8.5, MLNX_OFED_LINUX-5.5-1.0.3.2:,  max qp created =
- 261935
Test 2 SW config - same as test 1 with MOFED except rdma-core library is up=
stream c590cbd51632, max qp created - 261935 (same as test 1)
Test 3 SW config - MOFED uninstalled, 5.18.5 kernel installed, rdma-core li=
brary is upstream c590cbd51632, max qp created 130863

Can someone help me understand why Test 3 is half of the number?  Also, is =
it possible to hit the max_qp number of 262144?
Not to muddle the issue too much, I have observed similar behavior with Con=
nectX-6 (130763 and 261875 QPs) but don't have logs with those runs.

Thanks,

Chien

I've interlaced "rdma resource" prints in the dmesg log  by pausing test pr=
ogram in gdb with breakpoint set to ibv_create_qp.

<Test 1 log>
[rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261933 cm_id 0 mr 0 ctx 1 srq 0

[  920.711591] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[  920.711597] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[  920.711601] cmd[0]: 000: 05000002 00000000 00000000 00000000
[  920.711604] cmd[0]: 010: 00000000 00000000 00001800 00000018
[  920.711606] cmd[0]: 020: 00384800 00000015 0003ff5d 04000000
[  920.711608] cmd[0]: 030: 00000000 00000000 00000000 00000000
[  920.711609] cmd[0]: 040: 00000000 00000000 00000000 00000000
[  920.711611] cmd[0]: 050: 00000000 00000000 00000000 00000000
[  920.711613] cmd[0]: 060: 00000000 00000000 00000000 00000000
[  920.711614] cmd[0]: 070: 00000000 00000000 00000000 00000000
[  920.711616] cmd[0]: 080: 00000000 00000000 00000000 00000000
[  920.711617] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[  920.711619] cmd[0]: 0a0: 00000000 00000000 00000300 00000000
[  920.711621] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe7c0
[  920.711622] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[  920.711624] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[  920.711625] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[  920.711627] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[  920.711629] cmd[0]: 100: 00000001 00000000 00000000 00000000
[  920.711630] cmd[0]: 110: 00000006 180c0000 00000005 44200000

[  920.711634] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[  920.712125] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[  920.712129] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[  920.712131] cmd[0]: 000: 00000000 00000000 00040121 00000000

[  920.712133] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump

[rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261934 cm_id 0 mr 0 ctx 1 srq 0

[  938.006403] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[  938.006408] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[  938.006411] cmd[0]: 000: 05000002 00000000 00000000 00000000
[  938.006414] cmd[0]: 010: 00000000 00000000 00001800 00000018
[  938.006416] cmd[0]: 020: 00384800 00000015 0003ff5e 00000000
[  938.006418] cmd[0]: 030: 00000000 00000000 00000000 00000000
[  938.006419] cmd[0]: 040: 00000000 00000000 00000000 00000000
[  938.006421] cmd[0]: 050: 00000000 00000000 00000000 00000000
[  938.006422] cmd[0]: 060: 00000000 00000000 00000000 00000000
[  938.006424] cmd[0]: 070: 00000000 00000000 00000000 00000000
[  938.006425] cmd[0]: 080: 00000000 00000000 00000000 00000000
[  938.006427] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[  938.006429] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[  938.006431] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe800
[  938.006433] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[  938.006434] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[  938.006436] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[  938.006438] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[  938.006439] cmd[0]: 100: 00000000 00000000 00000000 00000000
[  938.006441] cmd[0]: 110: 00000003 5ed0e000 00000003 5ed0f000
[  938.006443] cmd[0]: 120: 00000006 1820a000 00000002 f1f87000
[  938.006444] cmd[0]: 130: 00000002 f1fcf000 00000006 1805f000
[  938.006446] cmd[0]: 140: 00000003 8efe1000 00000006 1805d000
[  938.006448] cmd[0]: 150: 00000004 956b5000 00000000 00000000

[  938.006451] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[  938.006859] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[  938.006864] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[  938.006866] cmd[0]: 000: 00000000 00000000 00040122 00000000

[  938.006869] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump

[rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0

[  952.880460] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[  952.880465] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[  952.880468] cmd[0]: 000: 05000002 00000000 00000000 00000000
[  952.880471] cmd[0]: 010: 00000000 00000000 00001800 00000018
[  952.880473] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
[  952.880475] cmd[0]: 030: 00000000 00000000 00000000 00000000
[  952.880476] cmd[0]: 040: 00000000 00000000 00000000 00000000
[  952.880478] cmd[0]: 050: 00000000 00000000 00000000 00000000
[  952.880480] cmd[0]: 060: 00000000 00000000 00000000 00000000
[  952.880481] cmd[0]: 070: 00000000 00000000 00000000 00000000
[  952.880483] cmd[0]: 080: 00000000 00000000 00000000 00000000
[  952.880485] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[  952.880486] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[  952.880488] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe840
[  952.880490] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[  952.880491] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[  952.880493] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[  952.880494] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[  952.880496] cmd[0]: 100: 00000000 00000000 00000000 00000000
[  952.880498] cmd[0]: 110: 00000001 d3ae6000 00000002 f1ef7000
[  952.880499] cmd[0]: 120: 00000003 ae09f000 00000001 28268000
[  952.880501] cmd[0]: 130: 00000003 ae007000 00000001 b4cf4000
[  952.880503] cmd[0]: 140: 00000006 180fc000 00000002 2a9e6000
[  952.880504] cmd[0]: 150: 00000002 f1ed0000 00000002 88295000

[  952.880508] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[  952.881353] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[  952.881358] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[  952.881360] cmd[0]: 000: 05000000 0065b500 00000000 00000000

[  952.881363] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump
[  952.881401] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 4323): CREAT=
E_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome (0x65b50=
0)
[  952.881408] infiniband mlx5_0: create_qp:3192:(pid 4323): Create QP type=
 2 failed

[rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0

[  969.559023] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[  969.559027] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[  969.559031] cmd[0]: 000: 05000002 00000000 00000000 00000000
[  969.559034] cmd[0]: 010: 00000000 00000000 00001800 00000018
[  969.559036] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
[  969.559037] cmd[0]: 030: 00000000 00000000 00000000 00000000
[  969.559039] cmd[0]: 040: 00000000 00000000 00000000 00000000
[  969.559041] cmd[0]: 050: 00000000 00000000 00000000 00000000
[  969.559042] cmd[0]: 060: 00000000 00000000 00000000 00000000
[  969.559044] cmd[0]: 070: 00000000 00000000 00000000 00000000
[  969.559045] cmd[0]: 080: 00000000 00000000 00000000 00000000
[  969.559047] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[  969.559049] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[  969.559051] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe840
[  969.559052] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[  969.559054] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[  969.559055] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[  969.559057] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[  969.559058] cmd[0]: 100: 00000000 00000000 00000000 00000000
[  969.559060] cmd[0]: 110: 00000001 d3ae6000 00000002 f1ef7000
[  969.559062] cmd[0]: 120: 00000003 ae09f000 00000001 28268000
[  969.559063] cmd[0]: 130: 00000003 ae007000 00000001 b4cf4000
[  969.559065] cmd[0]: 140: 00000006 180fc000 00000002 2a9e6000
[  969.559067] cmd[0]: 150: 00000002 f1ed0000 00000001 e54e4000

[  969.559070] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[  969.559508] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[  969.559513] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[  969.559517] cmd[0]: 000: 05000000 0065b500 00000000 00000000

[  969.559520] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump
[  969.559553] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 4323): CREAT=
E_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome (0x65b50=
0)
[  969.559562] infiniband mlx5_0: create_qp:3192:(pid 4323): Create QP type=
 2 failed


<Test 2 log>
[rdma resource]0: mlx5_0: pd 3 cq 27 qp 261934 cm_id 0 mr 0 ctx 1 srq 0

[ 3543.619746] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[ 3543.619753] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[ 3543.619757] cmd[0]: 000: 05000002 00000000 00000000 00000000
[ 3543.619759] cmd[0]: 010: 00000000 00000000 00001800 00000018
[ 3543.619762] cmd[0]: 020: 00384800 00000015 0003ff5e 00000000
[ 3543.619763] cmd[0]: 030: 00000000 00000000 00000000 00000000
[ 3543.619765] cmd[0]: 040: 00000000 00000000 00000000 00000000
[ 3543.619796] cmd[0]: 050: 00000000 00000000 00000000 00000000
[ 3543.619798] cmd[0]: 060: 00000000 00000000 00000000 00000000
[ 3543.619798] cmd[0]: 070: 00000000 00000000 00000000 00000000
[ 3543.619799] cmd[0]: 080: 00000000 00000000 00000000 00000000
[ 3543.619800] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[ 3543.619800] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[ 3543.619801] cmd[0]: 0b0: 00000011 0000010d 00000005 22861800
[ 3543.619801] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[ 3543.619802] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[ 3543.619803] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[ 3543.619803] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[ 3543.619804] cmd[0]: 100: 00000000 00000000 00000000 00000000
[ 3543.619804] cmd[0]: 110: 00000004 32f72000 00000005 22a11000
[ 3543.619805] cmd[0]: 120: 00000005 229f6000 00000005 22a38000
[ 3543.619806] cmd[0]: 130: 00000001 7244a000 00000002 466aa000
[ 3543.619806] cmd[0]: 140: 00000005 22a19000 00000002 8c046000
[ 3543.619807] cmd[0]: 150: 00000005 8ac7b000 00000002 2c14a000

[ 3543.619809] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[ 3543.620284] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[ 3543.620291] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[ 3543.620295] cmd[0]: 000: 00000000 00000000 00040122 00000000

[ 3543.620299] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump

[rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0

[ 3560.087852] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[ 3560.087857] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[ 3560.087860] cmd[0]: 000: 05000002 00000000 00000000 00000000
[ 3560.087863] cmd[0]: 010: 00000000 00000000 00001800 00000018
[ 3560.087865] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
[ 3560.087867] cmd[0]: 030: 00000000 00000000 00000000 00000000
[ 3560.087869] cmd[0]: 040: 00000000 00000000 00000000 00000000
[ 3560.087886] cmd[0]: 050: 00000000 00000000 00000000 00000000
[ 3560.087887] cmd[0]: 060: 00000000 00000000 00000000 00000000
[ 3560.087887] cmd[0]: 070: 00000000 00000000 00000000 00000000
[ 3560.087888] cmd[0]: 080: 00000000 00000000 00000000 00000000
[ 3560.087888] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[ 3560.087889] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[ 3560.087890] cmd[0]: 0b0: 00000011 0000010d 00000005 22861840
[ 3560.087890] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[ 3560.087891] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[ 3560.087891] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[ 3560.087892] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[ 3560.087892] cmd[0]: 100: 00000000 00000000 00000000 00000000
[ 3560.087893] cmd[0]: 110: 00000005 229e7000 00000004 65ddb000
[ 3560.087894] cmd[0]: 120: 00000005 22a01000 00000005 22a0f000
[ 3560.087894] cmd[0]: 130: 00000005 8ac73000 00000003 a6d42000
[ 3560.087895] cmd[0]: 140: 00000004 05f58000 00000005 22a10000
[ 3560.087896] cmd[0]: 150: 00000005 22a4c000 00000001 fc0da000

[ 3560.087897] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[ 3560.088787] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[ 3560.088793] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[ 3560.088797] cmd[0]: 000: 05000000 0065b500 00000000 00000000

[ 3560.088801] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump
[ 3560.088827] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 9217): CREAT=
E_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome (0x65b50=
0)
[ 3560.088837] infiniband mlx5_0: create_qp:3192:(pid 9217): Create QP type=
 2 failed

[rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0

[ 3577.184180] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915): cmd[0]:=
 start dump
[ 3577.184185] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915): cmd[0]:=
 dump command data CREATE_QP(0x500) INPUT
[ 3577.184189] cmd[0]: 000: 05000002 00000000 00000000 00000000
[ 3577.184191] cmd[0]: 010: 00000000 00000000 00001800 00000018
[ 3577.184194] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
[ 3577.184195] cmd[0]: 030: 00000000 00000000 00000000 00000000
[ 3577.184197] cmd[0]: 040: 00000000 00000000 00000000 00000000
[ 3577.184199] cmd[0]: 050: 00000000 00000000 00000000 00000000
[ 3577.184200] cmd[0]: 060: 00000000 00000000 00000000 00000000
[ 3577.184202] cmd[0]: 070: 00000000 00000000 00000000 00000000
[ 3577.184204] cmd[0]: 080: 00000000 00000000 00000000 00000000
[ 3577.184205] cmd[0]: 090: 00000000 0000010d 00000000 00000000
[ 3577.184207] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[ 3577.184209] cmd[0]: 0b0: 00000011 0000010d 00000005 22861840
[ 3577.184210] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[ 3577.184212] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[ 3577.184214] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[ 3577.184215] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[ 3577.184217] cmd[0]: 100: 00000000 00000000 00000000 00000000
[ 3577.184219] cmd[0]: 110: 00000005 229e7000 00000004 65ddb000
[ 3577.184221] cmd[0]: 120: 00000005 22a01000 00000005 22a0f000
[ 3577.184222] cmd[0]: 130: 00000005 8ac73000 00000003 a6d42000
[ 3577.184224] cmd[0]: 140: 00000004 05f58000 00000005 22a10000
[ 3577.184226] cmd[0]: 150: 00000005 22a4c000 00000000 00000000

[ 3577.184229] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915): cmd[0]:=
 end dump
[ 3577.184619] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]: st=
art dump
[ 3577.184627] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]: du=
mp command data CREATE_QP(0x500) OUTPUT
[ 3577.184630] cmd[0]: 000: 05000000 0065b500 00000000 00000000

[ 3577.184635] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]: en=
d dump
[ 3577.184665] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 9217): CREAT=
E_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome (0x65b50=
0)
[ 3577.184675] infiniband mlx5_0: create_qp:3192:(pid 9217): Create QP type=
 2 failed



<Test 3 log>
[rdma resource]0: mlx5_0: pd 5 cq 5 qp 130861 cm_id 0 mr 0 ctx 1 srq 2

[354817.776532] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730): cmd[=
0]: start dump
[354817.776560] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730): cmd[=
0]: dump command data CREATE_QP(0x500) INPUT
[354817.776583] cmd[0]: 000: 05000002 00000000 00000000 00000000
[354817.776597] cmd[0]: 010: 00000000 00000000 00001800 00000018
[354817.776611] cmd[0]: 020: 00384800 00000017 0001ff49 03000000
[354817.776623] cmd[0]: 030: 00000000 00000000 00000000 00000000
[354817.776955] cmd[0]: 040: 00000000 00000000 00000000 00000000
[354817.777188] cmd[0]: 050: 00000000 00000000 00000000 00000000
[354817.777446] cmd[0]: 060: 00000000 00000000 00000000 00000000
[354817.777701] cmd[0]: 070: 00000000 00000000 00000000 00000000
[354817.777953] cmd[0]: 080: 00000000 00000000 00000000 00000000
[354817.778150] cmd[0]: 090: 00000000 00000115 00000000 00000000
[354817.778371] cmd[0]: 0a0: 00000000 00000000 00000800 00000000
[354817.778590] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35ac0
[354817.778824] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[354817.779006] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[354817.779179] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[354817.779377] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[354817.779571] cmd[0]: 100: 00000000 00000000 00000000 00000000
[354817.779766] cmd[0]: 110: 0000000a 67fb0000 0000000a 67e80000

[354817.780058] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730): cmd[=
0]: end dump
[354817.780623] mlx5_core 0000:02:00.0: dump_command:852:(pid 0): cmd[0]: s=
tart dump
[354817.781147] mlx5_core 0000:02:00.0: dump_command:859:(pid 0): cmd[0]: d=
ump command data CREATE_QP(0x500) OUTPUT
[354817.781478] cmd[0]: 000: 00000000 00000000 00023be6 00000000

[354817.781893] mlx5_core 0000:02:00.0: dump_command:895:(pid 0): cmd[0]: e=
nd dump

[rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130862 cm_id 0 mr 0 ctx 1 srq 2

[354834.277537] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730): cmd[=
0]: start dump
[354834.277755] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730): cmd[=
0]: dump command data CREATE_QP(0x500) INPUT
[354834.277930] cmd[0]: 000: 05000002 00000000 00000000 00000000
[354834.278108] cmd[0]: 010: 00000000 00000000 00001800 00000018
[354834.278288] cmd[0]: 020: 00384800 00000017 0001ff4a 03000000
[354834.278499] cmd[0]: 030: 00000000 00000000 00000000 00000000
[354834.278710] cmd[0]: 040: 00000000 00000000 00000000 00000000
[354834.278930] cmd[0]: 050: 00000000 00000000 00000000 00000000
[354834.279102] cmd[0]: 060: 00000000 00000000 00000000 00000000
[354834.279274] cmd[0]: 070: 00000000 00000000 00000000 00000000
[354834.279454] cmd[0]: 080: 00000000 00000000 00000000 00000000
[354834.279685] cmd[0]: 090: 00000000 00000115 00000000 00000000
[354834.279886] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
[354834.280056] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b00
[354834.280226] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[354834.280419] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[354834.280612] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[354834.280819] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[354834.280974] cmd[0]: 100: 00000000 00000000 00000000 00000000
[354834.281124] cmd[0]: 110: 0000000a 67f98000 0000000a 5f658000

[354834.281421] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730): cmd[=
0]: end dump
[354834.282011] mlx5_core 0000:02:00.0: dump_command:852:(pid 0): cmd[0]: s=
tart dump
[354834.282327] mlx5_core 0000:02:00.0: dump_command:859:(pid 0): cmd[0]: d=
ump command data CREATE_QP(0x500) OUTPUT
[354834.282674] cmd[0]: 000: 00000000 00000000 00023be7 00000000

[354834.283275] mlx5_core 0000:02:00.0: dump_command:895:(pid 0): cmd[0]: e=
nd dump

[rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130863 cm_id 0 mr 0 ctx 1 srq 2

[354857.088810] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730): cmd[=
0]: start dump
[354857.089037] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730): cmd[=
0]: dump command data CREATE_QP(0x500) INPUT
[354857.089216] cmd[0]: 000: 05000002 00000000 00000000 00000000
[354857.089392] cmd[0]: 010: 00000000 00000000 00001800 00000018
[354857.089605] cmd[0]: 020: 00384800 00000018 0001ff4b 03000000
[354857.089817] cmd[0]: 030: 00000000 00000000 00000000 00000000
[354857.090043] cmd[0]: 040: 00000000 00000000 00000000 00000000
[354857.090221] cmd[0]: 050: 00000000 00000000 00000000 00000000
[354857.090395] cmd[0]: 060: 00000000 00000000 00000000 00000000
[354857.090576] cmd[0]: 070: 00000000 00000000 00000000 00000000
[354857.090809] cmd[0]: 080: 00000000 00000000 00000000 00000000
[354857.091029] cmd[0]: 090: 00000000 00000115 00000000 00000000
[354857.091206] cmd[0]: 0a0: 00000000 00000000 00000600 00000000
[354857.091382] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b40
[354857.091584] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[354857.091782] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[354857.091993] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[354857.092155] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[354857.092310] cmd[0]: 100: 00000000 00000000 00000000 00000000
[354857.092469] cmd[0]: 110: 0000000a 5f658000 0000000a 5f788000

[354857.092829] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730): cmd[=
0]: end dump
[354857.093900] mlx5_core 0000:02:00.0: dump_command:852:(pid 0): cmd[0]: s=
tart dump
[354857.094313] mlx5_core 0000:02:00.0: dump_command:859:(pid 0): cmd[0]: d=
ump command data CREATE_QP(0x500) OUTPUT
[354857.094515] cmd[0]: 000: 05000000 0065b500 00000000 00000000

[354857.094871] mlx5_core 0000:02:00.0: dump_command:895:(pid 0): cmd[0]: e=
nd dump
[354857.095093] mlx5_core 0000:02:00.0: cmd_status_print:808:(pid 110379): =
CREATE_QP(0x500) op_mod(0x0) uid(2) failed, status bad resource(0x5), syndr=
ome (0x65b500), err(-22)
[354857.095923] infiniband mlx5_0: create_qp:3035:(pid 110379): Create QP t=
ype 2 failed

[rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130863 cm_id 0 mr 0 ctx 1 srq 2

[354893.848503] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730): cmd[=
0]: start dump
[354893.848747] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730): cmd[=
0]: dump command data CREATE_QP(0x500) INPUT
[354893.848949] cmd[0]: 000: 05000002 00000000 00000000 00000000
[354893.849151] cmd[0]: 010: 00000000 00000000 00001800 00000018
[354893.849351] cmd[0]: 020: 00384800 00000018 0001ff4b 03000000
[354893.849562] cmd[0]: 030: 00000000 00000000 00000000 00000000
[354893.849815] cmd[0]: 040: 00000000 00000000 00000000 00000000
[354893.850059] cmd[0]: 050: 00000000 00000000 00000000 00000000
[354893.850258] cmd[0]: 060: 00000000 00000000 00000000 00000000
[354893.850459] cmd[0]: 070: 00000000 00000000 00000000 00000000
[354893.850668] cmd[0]: 080: 00000000 00000000 00000000 00000000
[354893.850939] cmd[0]: 090: 00000000 00000115 00000000 00000000
[354893.851151] cmd[0]: 0a0: 00000000 00000000 00000600 00000000
[354893.851340] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b40
[354893.851526] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
[354893.851740] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
[354893.851948] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
[354893.852165] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
[354893.852339] cmd[0]: 100: 00000000 00000000 00000000 00000000
[354893.852505] cmd[0]: 110: 0000000a 5f658000 0000000a 5f788000

[354893.852893] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730): cmd[=
0]: end dump
[354893.853565] mlx5_core 0000:02:00.0: dump_command:852:(pid 0): cmd[0]: s=
tart dump
[354893.854324] mlx5_core 0000:02:00.0: dump_command:859:(pid 0): cmd[0]: d=
ump command data CREATE_QP(0x500) OUTPUT
[354893.854683] cmd[0]: 000: 05000000 0065b500 00000000 00000000

[354893.855182] mlx5_core 0000:02:00.0: dump_command:895:(pid 0): cmd[0]: e=
nd dump
[354893.855474] mlx5_core 0000:02:00.0: cmd_status_print:808:(pid 110379): =
CREATE_QP(0x500) op_mod(0x0) uid(2) failed, status bad resource(0x5), syndr=
ome (0x65b500), err(-22)
[354893.856328] infiniband mlx5_0: create_qp:3035:(pid 110379): Create QP t=
ype 2 failed

