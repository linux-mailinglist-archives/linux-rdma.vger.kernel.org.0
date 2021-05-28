Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2090394945
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhE1XzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:55:16 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:25824
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1XzQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:55:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5HWF7bu4l8D5sDwjeben0W5woKe1tPDH4C99uzScBagQ84Prl1zZpY8Z0zK50dQ8+bf4WSBIuhmzAZdhgwCMSKZ2OMCaR9BORvcoMyge8J3qQfv9fy2Ky2aWWAzeMhXJG4JcwZ1GL6YtobQUEt15eZPbY3JsMEeve6B3wsyeIuYfFFveMU7o/LNoelLH1lz+BHpN5ZyqtH77jyFe/BxSSy+mH41SlnDUkUK8lBSQv59MwY5TE7DIMEb+7u2OYq86tEd0TzH8VvGPn0NlU99dIoA5NAYXrRnXSz7pcvUbeKZNcPUnCyONAyzhzseD6UVAOjvICeU0n8lurK0Dsq9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LFIs1oE2hVmxIR1uyGqwSOlcmYy+naljNCMF1NJcAs=;
 b=NWxsCRpXH4XeVDYA+cTasizgVAbdXFYdpFWwGZocB+Z3uW/xoG98Hor/AX+4rtR3fNfoeEtZ0N6nMrQU//lCMBtIuJb6KHt63uPa3AMcpFDQ7uz9ruLGQgK5gDdzxUoq8jKtf7uBIPtdVZcFqNiWFey38AraXfbghzPtrwa2pObNVQOiYg+9vgtNuhy+mTAk8Gie2bXarZ/aSA0k7p2N1K36qZI+ID2e3IYHZIPpr14+dK4Zi3dV2Qpp0otstMClTfDJar2n6GRTRtdYVE3DnffP90tLXu8rRs88NMy8BEx/Q0MB9YetObMYc7LdinDWRfuTtX51IAwsvSQzzn5WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LFIs1oE2hVmxIR1uyGqwSOlcmYy+naljNCMF1NJcAs=;
 b=iv8CRuahHPBE1+s7mFte6hj5rD8BfCxlzlhSKo7ivCP7ElCBdUWvrBH5K29BYvBNmGCWmJRxQrgmI3GaSrZMyuX8eiClW+HUbREcM1BIwGY+hPRTaAMI50gBZS7uMZEG9R4R+tPk3RV9gWk6yC6cY0fIxFrtgcdoKPKqxNa2ufyN5Ao44YaG/P8wPK9R6VhgInnFTPwhIiq9KUP2a68M4TPkK1Tio/XCub1y/0bPF4Q2l58yJ7iuaOjvZ0RURUxMbr/DgVFYez5L46Nunzt5Yrc5gjb5gKIfWVz8AdMOnNhsvVSbuR2cDTBngT5CJ6T5yjTGvECt1UlmTtgRZGOvSw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 23:53:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:53:38 +0000
Date:   Fri, 28 May 2021 20:53:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com
Subject: Re: [PATCHv3 for-next 00/20] RTRS update for 5.14
Message-ID: <20210528235337.GA3876732@nvidia.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0184.namprd13.prod.outlook.com (2603:10b6:208:2be::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Fri, 28 May 2021 23:53:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmmIL-00GGWZ-3t; Fri, 28 May 2021 20:53:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16d0f28-5905-46df-77a9-08d92233d02b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5286DE295C1E1A148B548616C2229@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMDA0Xg8Gh85NWWRdMN0/9/EjSGPiPQfMMzoV94KMtcCgfXzK7db62GNLF2aptmAm2oUFII3SEyaEF/bb1igZbRrquE9vAkwyXuWZjFrlO8KaT3mljK6Yc1CaaAC9ULQ4EtqDWtQd71fAf5MO7pu/RQ0+tLjKDWFihXd5IVVyMMe7em85pCh/jL5HsU6885SoO+XA7/9Ntg46GhsTLZ8lSIt0AgHbB0K7TtbmxdM8qymje2bZFCYtHLdCN+bnSgl56L/0ptb8G7vmcD5ZZ6qmwmNrCE8pHElknBMgjKo1PqzO1GrSMwIdlb0VyG9/Gu1I8PYGhOMldUIitUYO6jB/BPNrKtOhqYWz82fUzRrvDdIrDfwfN+ZdH2zoKdrpy7PQVQ+ejbSysrKnKylHiiLJwoSBqISf8z+yAAabApQhiKsxDbpkwicZJEIvurR9U/GoRXKVmhWtMPdGjzw+y/C2Kz6Ro+M6Fc3vvsDWzs2mA9pWKd3vSWq/xo7IvHAnY4Kbsvy89E4hYRt8h8j5gY4yW8tPWSTOzDMIvTHIPIv/qRZIMAabnxNaTdjqj28V6LKVD7J3E2vF2WDRxEDmu+2C9iHyMd8ye2Jx0q+z2ajy8clSr5CbfEQB5ty3i6Kcvw5XlQTjoPjmFntx+EjJ9KrJPfhormC/MOE8RjuUnDK4826VPM9iib7E17YS2EHAqR24W4rICEe6MN8Xm0dthYAfXM3vMLN9wfRAF9iqs+vL2cQoBwtCkZpGIACpHRQzAWT7fk2cQW2vaSOaroJoAMa3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(478600001)(426003)(186003)(9786002)(1076003)(316002)(33656002)(9746002)(26005)(36756003)(966005)(4326008)(2906002)(6916009)(8676002)(38100700002)(66946007)(8936002)(15650500001)(66476007)(66556008)(86362001)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tsz7oXJjhOFrlUUpJGwoFop5h9nksqY0egXKFCuhTQtaWCaZMhS7mxShPTGB?=
 =?us-ascii?Q?piv5kpYHJloWd26r4aClL59JDpUrdDmn6g7xrDycu8pIS35KHJTruVyQLq8i?=
 =?us-ascii?Q?n3wyOHkaAcUHm36giVcMuSns7gg86P/1lYZubUzG0gbUTzOTQ3yyrUVEJuJ+?=
 =?us-ascii?Q?neKPwR2qcpCeqkHHnBxNwaaBA4/OKcSsXJjqJNBspknuEVRJBtSlXZYG1Zeu?=
 =?us-ascii?Q?9iTlrIWVZFCHQNjlyi0S6axVBNVLak06gBzZ6iIZbUPBA324aTqyIkYxXqLO?=
 =?us-ascii?Q?XHj1f6NNlTVKMQbBvyGb7J6j0Y9x6SunPi7cSE5NTX5zNzWsu7a4s9k14c8W?=
 =?us-ascii?Q?T7lTFiKKPW0RHvYuXkvc80OyHFeY9vYT7yM/dnxUd2mGT6vyK4JyDMWgQ8GR?=
 =?us-ascii?Q?HJ7gwDhzWz4L3ip0YBTGf+OrbEY9hd5G4OqaAhnzBnj1zVJmMMvHEeNCdMJy?=
 =?us-ascii?Q?KzFWdmSdXreffB6Xg5x36W2OVlvbUNZNpVP+YaDAZbq/7JdPATdIfSqJKAvz?=
 =?us-ascii?Q?NST+QEq4RbOkDnkIVFusz12nOyXt2/y3udk2mD1AvSGu+OOQyjxo5Z6oGUf6?=
 =?us-ascii?Q?MwtmJv/baVUJFu0HfhPAwYeMDU92PrGbynL+Iq1pav8OWoRQY0bb7FabtOgh?=
 =?us-ascii?Q?maPI9MKzvEhjpqx8XQI+VSN8D9cyVvTsqVkdr12S/u2ci3dqgYSWVSl4lW2n?=
 =?us-ascii?Q?FxLWJWAcuKzgv6u7QhIL2ZpAdy+ekjZkc4d2clfBSqHDRtQkBHIvWy+rgMZC?=
 =?us-ascii?Q?N4PSWyWu9U61igix9mKe5vMZNZevCDoEi9GXHxc+vm2RW9p5awrujnl5zYIy?=
 =?us-ascii?Q?2nYmO7Oni4lU1jQxL27VeFk2UDtI+cwL/KNz0IrzVPxG+OcI4ijPlQ80Jlhc?=
 =?us-ascii?Q?/Hbxhg+WFb1GemmLEUPgFvXlodXAIbcX7Lzultrzh3ix1L480tSnL3DQCwkC?=
 =?us-ascii?Q?Enw18Qe6tmnyDYuHwWgZ09jwDcrXlbOsqbN0sjZc5q8KDFY3w7KMZU8W002V?=
 =?us-ascii?Q?+MzAkZdMQmyFgjDJn48leKrqLF8/dQNRiYZBLNopIGuS2d3BduJIHq789Vjm?=
 =?us-ascii?Q?C88OyUSTYNfiWhJG0Bjut0CBryN9TS6g+tCzo9Kmw8mZuSsW3k7nMaRJ66vJ?=
 =?us-ascii?Q?xg2yE8IFWTuR8nN1T0s1HHeH4JVRf/gm735eSJ6i+lcqTmvK63dUfltelbpU?=
 =?us-ascii?Q?LVZ/7auopJGVCsQBY0NM3K7Kh9fccqJDu6XYVWFTVaXj2h+qfNjQmQ5dXO/D?=
 =?us-ascii?Q?D5D5+Ks4O4TzvcL3FdB/vc1eQGZNl6w2LCdhJTnJKU2JH1hkmjA4CRbMJ+9W?=
 =?us-ascii?Q?JgTgCKyqLG1UygG30WZ0e6M3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16d0f28-5905-46df-77a9-08d92233d02b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:53:38.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuwbiMF9V1LYujBv8MY3NMoGUrUZY47zK8Sz70TH4EUqf+XVNVgE6qs57vDbo8Os
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 01:29:58PM +0200, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> It contains:
> - Patch 01 ~ 10: Typical code refactoring patches
> - Patch 11: Requested by Jason
> https://www.spinics.net/lists/linux-rdma/msg102009.html
> - Patch 12 RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight, we
>   split the sysfs_emit conversion to a seperate patch 13.
> - Patch 14 ~ 20: Bug fixes
> 
> V3->V2:
> - ratelimit error message for first_con check. (Jason)
> - split the sysfs_emit conversion to a new patch 13.
> 
> V2->V1:
> - drop one patch "RDMA/rtrs-clt: No need to check queue_depth when
> receiving" as requested by Leon
> - (void) casting will be removed by next patch set
> as requested by Leon.
> https://www.spinics.net/lists/linux-rdma/msg102200.html
> 
> 
> Dima Stepanov (1):
>   RDMA/rtrs: Use strscpy instead of strlcpy
> 
> Gioh Kim (7):
>   RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
>   RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
>   RDMA/rtrs: Define MIN_CHUNK_SIZE
>   RDMA/rtrs: Do not reset hb_missed_max after re-connection
>   RDMA/rtrs-srv: Duplicated session name is not allowed
>   RDMA/rtrs-srv: Fix memory leak of unfreed rtrs_srv_stats object
>   RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and
>     stats->pcpu_stats
> 
> Guoqing Jiang (6):
>   RDMA/rtrs-srv: Kill reject_w_econnreset label
>   RDMA/rtrs-srv: Clean up the code in __rtrs_srv_change_state
>   RDMA/rtrs-clt: Kill rtrs_clt_{start,stop}_hb
>   RDMA/rtrs-clt: Kill rtrs_clt_disconnect_from_sysfs
>   RDMA/rtrs-srv: Kill __rtrs_srv_change_state
>   RDMA/rtrs-clt: Remove redundant 'break'
> 
> Jack Wang (2):
>   RDMA/rtrs-srv: convert scnprintf to sysfs_emit
>   RDMA/rtrs-srv: Fix memory leak when having multiple sessions
> 
> Md Haris Iqbal (4):
>   RDMA/rtrs-srv: Add error messages for cases when failing RDMA
>     connection
>   RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
>     stats
>   RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight
>   RDMA/rtrs-clt: Check if the queue_depth has changed during a

Applied to for-next, thanks

Jason
