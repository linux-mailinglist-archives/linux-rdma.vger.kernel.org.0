Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890987BA8A6
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJESHx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjJESHe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 14:07:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF4E8;
        Thu,  5 Oct 2023 11:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8QnJgzmy0oRUZ5DQENcmcGzu0MTYL6Jd3Zz4ocaXe8mC+MJXpQUruyTRFYxlifPljDjL2bfTnxqxklt+5t3D5SNgWiC645+V0zljvIT9zgE2oJxh+rIxG4TZhXjQageJwhuAX46WLhdrPgPe1rZBqC+UqK5LSwqzI6DXHStdEtopJruShijYBJ5GH9+JppNsTc976KWeKI0IdKx7jRxXKOrPN4y38Ad/59xYflN4v2lIIGQ7JV54lO0iX/u4OhKm3xfF7h13CABlqroK/itkPkyJ17lWjufJ3JYf2nxLRVQTeukL7ePsrcQH7ppBPIWpCKlpJTmbrZ5r280DpL3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1M0kblItSEnUUsR+n0ms28X5Lm8J/lTo2+RXHdMdIw=;
 b=nVWpjxg6/6I6M7+6eFsD3EgQYQl0/YuEbdNvOZPXEi8JMsTc+TQBK62RboDOiRAvy2vM8lb44dwSc0JN7Cz50MVNXA2oml0FRlX/k+9RoQRAQkqVYb34bNX/zxLHZxU1hIN5L8F/5S4r8OFCQnb29B5LBbK5ul+oo8mjb0diUpnYLH1OJjbHSljXfW7+TplNbrfHPtqzX+KTSoXXMDR/MknyuJNsRTpx/mABaTN6JZO66kCjrAXKFmZqh45naWOeA8GCsW92cYHuVkaDgNwRAD9MfAhUjZMIjJMaVJ67zLsf+66+LS98fZEqiHcLtWouvQi47IAqv5kaI0KSqc00cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1M0kblItSEnUUsR+n0ms28X5Lm8J/lTo2+RXHdMdIw=;
 b=S4dkBh76RRwG+zFb9ZqK4iFYq+tAz3H64P0a1NPAqP7ibNltxt+6JNMqoIu/tQt3oxQDFTK3i3f0syNaOumF2DFBWVJ7E11q36dkrPLSzEfM3qRAR/lXiDMZ6o3dm9ZuxyQ2Ez6WIlliKriQtJkrGpeKbLkp5MhEAsbbSRN5HBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 5 Oct
 2023 18:07:28 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:07:28 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, sd@queasysnail.net,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com,
        phaddad@nvidia.com, ehakim@nvidia.com, raeds@nvidia.com,
        atenart@kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net v7 0/4] Add update_pn flag
Date:   Thu,  5 Oct 2023 21:06:32 +0300
Message-Id: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0041.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::30) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: cbff4942-3bbe-4442-f989-08dbc5cdef88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nre42TTQaSTtMeWDRek+dhlBFwIzppHBrcfqju3IGOnaHBVZUZ2m3uhCuO/CBl5tGrB97nF2viUiQX5h5BztrmsV4Mp1EsgpMpZ8S7reNu2LPQkCJxVAL/zDCvdzjVImvd/0vg2z/VE0RDy6S7Id22zY2kKRi8VSfbSLCsHGDb6kqm3kQ4/VRcLiMmgu/4Z1zE3h5oXVVgcSe3OddX7xzKZ7/vzPVuueBmrXoCfpba2bsExa00nWhvYxWM/OJN3RS5q6ligaKuoSmEN1hKaFXQPPxt4eo4TaebVLE8d+zP8EnfHewnO0jqMN2d/oNxcmrAUTuC9NzNyHvT7BlqRVQR3qZ+dPpJG2VR8cyMv10o+eFR9bx+4PiG8VMHy3tUeHhXCrKLPtwBHiI8U7fvIbhaKjdZ/fpGfszYyMzGC9Omeid59d5yuUAhLQaX1FJRXiwOwSBzFzzTt7H/b8Cbf3EiruZMI76DPgyW00UATnnCe3mKKqpsyPpfMftXunBU9wNPsqmmhqUV7F01Y5v1eLKTdZFx3WtltZC+vnAkIfKt6fQLPwV+PscOYmcA4SP5Pdjja0Jf6ZGPlrNhjra7UOzIffZ5rMH/uMxhdsL6LbowM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(966005)(52116002)(6506007)(6666004)(478600001)(6486002)(83380400001)(26005)(1076003)(7416002)(2906002)(4744005)(2616005)(15650500001)(316002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5ZEDsH0nOxLOylW/2WN7L5lpTzYF9Li0XIPtotCl1uan9FJa4XPWhRgRMSg?=
 =?us-ascii?Q?pPVKoh8Nsde4ez8BJzs3I9ckOjbnATT2Om8jqKmCy4V2iNWfklhJ1YD1ucQK?=
 =?us-ascii?Q?22gHlC2eW/D1UPbbghioGQQLDlWfbkjA/UsCQL1Fns1E2AqkUW8a4TgmSSqA?=
 =?us-ascii?Q?G+PENyJzitWxxb7t7xPV+cJnuV63RozynBJ/QbshpWcztCZ68y+VoQaPDKCG?=
 =?us-ascii?Q?DFLdLpzpvv+6xdKy09dEtL0qGU+7J4zEM645yrHjZCw8w4ommJJVjXs5bK5/?=
 =?us-ascii?Q?3AZCQ8Jl/dm6UL6h5bCGJabC8GmjzE8u+lzwkmR2ZML9MJv/tqDn7FA1Ottr?=
 =?us-ascii?Q?CGKp7Vl4Axuls3vrqKbVtDekapkNpcI7GVo5LlJrw5mErKchjq6B/qtkpJGO?=
 =?us-ascii?Q?yJDPteuV7nxl8vrD7adC8jos4950AtZsXVxuKjlct9Q2RTH/FXidD+6B36hh?=
 =?us-ascii?Q?czep55Cuw7EUWZJpqO9b9xzoKlEAc+XyvhPpm6lW6YPD+E3wWXty/hkSuZxB?=
 =?us-ascii?Q?g+lBWmk1exJ2wRc61yLXSvnZhGZ5nmsbif+dbGcgl/+KghD5fVppudfYAHHx?=
 =?us-ascii?Q?lveM9mxx34ncY9D9EvJRfmPBmT/Of0+eSSb2WO2ZAR3VmgwHYIfoAvdxg5xw?=
 =?us-ascii?Q?hqVxNA0qNIVU6CLORPz+UT6LUic9sJ9piOsFXADgWbBI1vEejfgs71CekER6?=
 =?us-ascii?Q?mDKxNyIDYV0EbfQW2LoZCNsLmIig9Qxj6K0+kKokbRdRnwE/uJbMejeH0jn3?=
 =?us-ascii?Q?37QDnVVXsTg7bNzErWSkhaQSggmFocq+/5nC5FES/VJrLxEs343CZpW2q/Fv?=
 =?us-ascii?Q?FCd0cobDaEj+i7Z1zxnBxUedOe5HgNT4asDCbwPVpAjDh4SA9uszeme9H0jC?=
 =?us-ascii?Q?PphJNTsMkClIp1rLD5DsMmALzV2lNRgbaw7oMUCxrvuSM3wrRlI/TWK6sigH?=
 =?us-ascii?Q?wJsYysYASSHWVCfqwPwvJHNm3rV2Db9dnKcSDIDJbGppOG/127y7AcEhZhKa?=
 =?us-ascii?Q?GoCsHncPQdUHasFX+L8C48KGOtLf+8dBmhtVsIhPrUE4k7oov5VOEONH9p31?=
 =?us-ascii?Q?Tki62jZQL1P5FIbTqYoafyzXspOm3PqRiYgBRvJYVz49i8zMrbkZPICDPK4/?=
 =?us-ascii?Q?sDNo4Bb0uryJ8xVAH+2iQKonVJ9ezdvV2snOiW7hiQeyCbudC/QXbcmM6cXx?=
 =?us-ascii?Q?BBpQHfXpM66EK18c9+1OrxE81M3EGSSCDwO8fiW8OhKfPTWOUS1GLxvv22kB?=
 =?us-ascii?Q?Pyz0nwUIDQxP4SQO7reGyRpUIrCpg4VijRJBkT5Yv08Y7NUPqxufE0fa5REB?=
 =?us-ascii?Q?VQtPEiva6eToPzwm7ZfCw2Wy61L3SSXB2HKu3ixDwyaHGgZaEe0rD4CG/x30?=
 =?us-ascii?Q?voFj+JpjxujbeyYlzkcqU1zU6/fO+Byx6tKpfqm6axOucJLVoZ/iDHcYGzpN?=
 =?us-ascii?Q?/JxwG+YA9LMaW4nxrGXdWoAeKNNIubyTxFhQIREN0NqgvBLZnqrEiZlyydp9?=
 =?us-ascii?Q?mlIcCU0cd1WlqyBwbz0ODkBbf5fkJIN53Bq68dR13oicQr2QfdNEsSFSPtF0?=
 =?us-ascii?Q?ODvljpIZ/xYtFQcaOqQLEQtNvXxbGU9et6Pya72nuhHO+x5VxlOfA/nS0UTI?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbff4942-3bbe-4442-f989-08dbc5cdef88
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:07:28.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsFXg346RI2MN5OPY//xPkO2uHlv3stU0cXsLAFFofle3+C8ocexch+lIKI/50hNIXX+0eZ+Qhq4LwJKfn5jPuFtaZYIyMMItlMSu8tLPOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Patches extracted from
https://lore.kernel.org/all/20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com/
Update_pn flag will let the offloaded MACsec implementations to know when
the PN is updated.

Radu P.

Radu Pirea (NXP OSS) (4):
  net: macsec: indicate next pn update when offloading
  octeontx2-pf: mcs: update PN only when update_pn is true
  net: phy: mscc: macsec: reject PN update requests
  net/mlx5e: macsec: use update_pn flag instead of PN comparation

 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c   | 13 +++++++++----
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c   |  4 ++--
 drivers/net/macsec.c                                |  2 ++
 drivers/net/phy/mscc/mscc_macsec.c                  |  6 ++++++
 include/net/macsec.h                                |  1 +
 5 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.34.1

