Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC555A489
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiFXW7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 18:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXW7N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 18:59:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6349792A5;
        Fri, 24 Jun 2022 15:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYsdD4mzQGtGsMoZXkiMhDUanjxQAvPD2bTO+5cXP/aCimcJfKpuyuRKHbiE6nbaHcdwD2qh9Aj5Q7Kwl2qP/3gx2SgSKP2Oa2toze9lXugsF2znxT8nW4Cd/KkwexM3g+Oa/VzkujklN3Go6IaCIKIhVB6TrZQ6JdNjf2cTWjdzsjDtp1XVHSDMHSQ16RS+0snIX468wQr2N0B1JFF4PCAXADCIC1kunclQxcwWNQaFKNCBy4sFgKZMAS0OUrWhNxGBs889oJIP9dZDG/VwZrKFM1V0/MTnM0Fwet3iEz2dMrZstv4n2vFD+2N3BNosLb1LhnA0Rav6B7j4jELQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze4NblWwzkFFzW1H0IVU93a/hKoUmYAzFkBKqc3g0KI=;
 b=LWmxcLmbDqzA4YFkk6uGW4y0JJiH4EppkUeCiokTTxe3yRAmFTFiNmWa8cDbbz2NSGmrNIipAKd0UAnJYRlPylt9IQ6zuEZBDb9VoZ2xgQxjcMfxJIWg6H5ra6g8xUUnt7eqClSRp9G/fms6+pMv7n8+uOk9Ah0Dn2sh2fT0Q+n+9qty2HQ11TezaYlYFNWXqUN7SBaVxl0jszyZidU08b2exSamUpiLhwTdTzhWkbq1+5gH2zpYP1mq2VtWy7RS1hxx2CqAppp4GtfxzMVrwMJLnwkEmL4bYV1RVcceZN9sARfwnxgLj53EWhC8rQSElubF4oFYWWoHhK1P2Rk2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze4NblWwzkFFzW1H0IVU93a/hKoUmYAzFkBKqc3g0KI=;
 b=dQmJ9Fmeqj+Iq+Vasp3IcENMQxZM3hWJ64Igfz6YLJd1bbMvYZLIHbDBzE0ejgLXIthEUfYSK8q4Duj49A70qbgExiPIDF6+1GOTfsOm4q4zrpsfGxvq72UoGvI2xheWquikCjhVP849RL5XfBE82kmnAqFERf88ejgeyZzeb9dy36+MTbBuNtc991KcDnq9PKfpaCVxQ0MtbkNzio6u/tepcZaegEd1BwPZCk225zJxKsldiY+bdnBwZw9SxLOnuBwIp3IFSTcscUhJbGQLBSl2UNbkX07iotNFdfKEw2VHDC3ejyxqwJzQa9//aOPWzojlSab+/4POOIJwCgjobg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 22:59:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 22:59:09 +0000
Date:   Fri, 24 Jun 2022 19:59:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Message-ID: <20220624225908.GA303931@nvidia.com>
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624040253.1420844-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9688374b-3909-40c9-ee8f-08da563525fb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbsSyaiRAL62wwRPJw2LPMJROPbWJYI/KhBBjz/SIYXBQjTy4qKqe2uK2XVC8MdGLa/09YQw+aC2uzWDN8Rg/q2dcVQH4BV26BQ5c2FMXT7pz8oDbIOYjLTZG2Tlw5J8pd0hmnLPhEamGYBmewJkzjxhFVhyjimCFhA1Gd7v0jx1Adt4ML/4BeI41N18yygpH3POB++fKXEsbJejfqA3f3ngbt65bdwhu4xPqrdEiHN/e1BUd18XRXnGUVuYOSc7NZdN9X09+F8zsIqnX/06ypJTg19dtZHXimbA+DjhzMhzExLxMERsHUzrG5nAa2g717mcnbrcIwX8XtAK66R7WQsDcNr7r7eSYOCiOSG0YqKvSpG0rgsdmTG52Urv8JqkXYY7n+/GBaJ7PtAL8hnIbKa3JahTB9DVP3byOGzFuFg9Dzt7nnRJ1QKzlCHkMnVtwyVhGe2Xw719CdmlHiKxlmcKcHv+4xptjLG+SqdeZvD8ueefeFS3ZBqreUfvk4ZSc03o4GM4E3WNprDf5jtsnV2N0Ok4VPTHGy3W3vhy7kK5mAMA+Rme7sTnZBYBjhH1DlAToVFjEDvEgp3C4IVhg459Dp2igriZLdlrldcXAykt2aIVYHdIhhby0DXhl83++uD5ys89stAvfl9wJstmmUIQfsdcHReKz1Ky53EVbQx1001b5UtvsYpG7jEh7cVdjWeWfgyMsj4GHN+9hAp24XiVS9ltZyKeD47BISXuJmLftpFsDGxXqwf/Noncm52VwEzWG6jkxyDVEYy+dQi9iEHYg9hKJoHypdJqBiRYPFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(478600001)(33656002)(83380400001)(6486002)(186003)(2906002)(5660300002)(36756003)(66946007)(4326008)(86362001)(316002)(41300700001)(54906003)(8676002)(66556008)(6916009)(2616005)(1076003)(8936002)(66476007)(6506007)(6512007)(38100700002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyjcI6SXca/pyfRQCll8En1ytDHCROWrQ1Njt0OIIvDiF13nIfs9tEyOAbEg?=
 =?us-ascii?Q?aW/dULXlA5s6/NOVkDujsQ9PDCyiH5PnOdUpyF9KsDFVKgcihFhIXFG1Ji57?=
 =?us-ascii?Q?4TnaKLPJIZrvWqabxd8dnhgN724WzxNcIGyHeiANhpX8fxOYeJVXtdL3sAc4?=
 =?us-ascii?Q?fss/20xOwp3GWRoeCMVOrx1pNxF3Ul3TNHoMmxpPvoCZ2cT+zMxUbYdGSvd0?=
 =?us-ascii?Q?tU8i5IWI8ozPgyg+H39vexPTFhNiRa6AaPVKexVPszL2CoWeDHIl0RIjCib2?=
 =?us-ascii?Q?R2JHE20cdczPNS/FOOwFMeflRZgNyU9ccHiewH9bQyK9tM9i97nW/cMXavOV?=
 =?us-ascii?Q?IJEPj2XjsISz56IUss+kZrApFzqcS953OKF6aQfDa3Sh35TEoI9VVagrJg2K?=
 =?us-ascii?Q?yAVnTrJ7Xpt55yTPa2L6Xy7t8xPHmhHBT0AQ1cEN3WhGewJ+dWM2E1/jt7uH?=
 =?us-ascii?Q?hM/9W9nzbcS6ry/xKaLalK1NYSBQvr2tuoQ9nR/1Dh5CnLee/9qHdwMsVPe0?=
 =?us-ascii?Q?vAaATet9ItPzHUGipUZd3dx51XWGdnEjvRmk2UpdukDYghMqcCaYTX0+Ym5V?=
 =?us-ascii?Q?l+McBILDm+THdAA9/q0S2TUIMJ7C9oHFV0j2gnBd5fg+K85/jUm1arJK2EIq?=
 =?us-ascii?Q?ScyQxXRkVhwOwbr4zvc4h6k/n9+n9jKJx6HDL1kafgcsZYPFDqxuFfRMwyFm?=
 =?us-ascii?Q?3M8EihzRbzNhUEZTaMsYxxlhc4YspJswbohCLR55NcR5PEDNRuaedaxI9z0O?=
 =?us-ascii?Q?o4sTB8SWutXGlUDqj6ssDcveano/AkLk9maCNNQgG0wiQ7Oz2vsFCje5a7TE?=
 =?us-ascii?Q?QljRIPmkrDcdaggwW1I6ZOCSBXK+DHbaUWCz1StZ6h41y48EKmrDjwhdcneJ?=
 =?us-ascii?Q?Ex/gMjzTUDIaB/0NcSMgaXZSFl8C0cd3C0QYnpDsFeIB2dRZfh0Wu2QtHLh/?=
 =?us-ascii?Q?7nu0TBBR2auLw0KrD9sHE+x6XZ+rLzfGZjhqfdmKDyFd2bHLfzfnE5pYYBDd?=
 =?us-ascii?Q?i7+g4WcabNculBxWFTJlWKgcW7v5Gh01I4mcn+F7Ab6B3/T8sLJf515og9J3?=
 =?us-ascii?Q?idVwofQ2dYOyjO/mpx95RLzkAauz4Bwit310tvZJIa5xu/CudhrWLq9zY9B2?=
 =?us-ascii?Q?QvqwR+2KQb+UwfGv1eHRy0jhG62kJ2adOMu1mpubrwN+eL3ulLrHSrjSOcDF?=
 =?us-ascii?Q?qLyC5XYco0ffdBszZYr6Wa8P3ohRlJLD2xAEajqjbbF7a3t4aT3YkwFVitTW?=
 =?us-ascii?Q?X4tOzFtW6uEHkldzTPUDwM87aJl5BYz1DaRZhee2bOtCoSayQ0KEmc9GnrGC?=
 =?us-ascii?Q?KEnhHyRlvQP7wjuY465xLkWDC6xzWve0f4nKgghonc19+A1TBaUHkbvAxHen?=
 =?us-ascii?Q?LX7lEVxk6j3TBW7x24RSPHktv29tPtwwANdrqvtHd1jbCPBBjzQYerRUuig0?=
 =?us-ascii?Q?SzuWjd5DLajZpQxQ4EgFT8VSg3h9jc54TWZ2b8ud75A6QKwAzr/PYGjbmS3q?=
 =?us-ascii?Q?FUE8JIHPQIPwDZ/MJ8CJG//0Sryn70CtM+Lv4G6HQiga3H95iJ5Ft0zx4HJa?=
 =?us-ascii?Q?osa0JFptLC198pTkAQ5thtssfSsIHWNbq3tB1kUN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9688374b-3909-40c9-ee8f-08da563525fb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 22:59:09.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yas1/MPyplJM7Jb1v8zr5aOKYcCXEdvF4rdnNGY76wHhiQsYW7bnh52Y62K0ppM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 24, 2022 at 12:02:53PM +0800, Li Zhijian wrote:
> srp_exit_cmd_priv() will try to access srp_device by Scsi_Host like below:
> 
>  Scsi_Host                srp_target_port     srp_host         srp_device
> +------------------+ +-- +--------------+  +>+----------+   +->+---------+
> |                  | |   |              |  | |          |   |  |         |
> |                  | |   |  *srp_host   +--+ | *srp_dev +---+  | *dev    |
> +-+hostdata--------+-+   |              |    |          |      |         |
> | | srp_target_port|     |              |    |          |      |         |
> | |                |     |              |    |          |      |         |
> | |                |     |              |    |          |      |         |
> +-+----------------+---- +--------------+    +----------+      +---------+
> 
> But sometims Scsi_Host still keeps the reference to srp_host that is
> possible released already. This could be happend if i frequently abort
> (Ctrl-c) the blktests during it was running and then cause below error:
> 
> [  952.299153] Freed by task 17289:
> [  952.299156]  kasan_save_stack+0x1e/0x40
> [  952.299160]  kasan_set_track+0x21/0x30
> [  952.299164]  kasan_set_free_info+0x20/0x30
> [  952.299169]  __kasan_slab_free+0x108/0x170
> [  952.299173]  kfree+0x9a/0x320
> [  952.299177]  srp_remove_one+0x114/0x180 [ib_srp]
> [  952.299189]  remove_client_context+0x8f/0xd0 [ib_core]
> [  952.299269]  disable_device+0xee/0x1e0 [ib_core]
> [  952.299348]  __ib_unregister_device+0x59/0xf0 [ib_core]
> [  952.299429]  ib_unregister_device_and_put+0x3b/0x50 [ib_core]
> [  952.299509]  nldev_dellink+0x126/0x1b0 [ib_core]
> [  952.299592]  rdma_nl_rcv_msg+0x1cc/0x310 [ib_core]
> [  952.299673]  rdma_nl_rcv+0x172/0x200 [ib_core]
> [  952.299760]  netlink_unicast+0x36b/0x4a0
> [  952.299770]  netlink_sendmsg+0x3a9/0x6d0
> [  952.299774]  sock_sendmsg+0x91/0xa0
> [  952.299783]  __sys_sendto+0x16f/0x210
> [  952.299788]  __x64_sys_sendto+0x6f/0x80
> [  952.299792]  do_syscall_64+0x3b/0x90
> [  952.299795]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

I don't even understand how get_device() prevents this call chain??

It looks to me like the problem is srp_remove_one() is not waiting for
or canceling some outstanding work.

Jason
