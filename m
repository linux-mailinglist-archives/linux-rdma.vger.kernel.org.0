Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712C450FC18
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiDZLpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Apr 2022 07:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiDZLpm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Apr 2022 07:45:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88933B3EC
        for <linux-rdma@vger.kernel.org>; Tue, 26 Apr 2022 04:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O124yp6MKJA8kEwI1JqnJwJyiG8q8rJtm+wYi28wHZt7uOJ5+Pyp1w7B+64XsML5DA6DhtttUQk9BcotWCCYY1KyakEUOD70kC2ZWvaplwQQ8hf2j5GKikuAgWkQ4e7efEKjpXYuBafbe9iRZrTsMoSbzSZBYzazoLV90U3GGprfuJjR8ad+Yhds9TGBT3C3nHlD5+LDHpLhCtMziIrE3QGtmuSE86LhZgmcJ3I/An5ZnN9Cl6oQKpr2BNFH8vgwIUYYQ8UTYSyR3nQQvv2hnRtRoLRI8GW2lfMxhOJJmoCIaZ1DNmOSQnGGSb2kws0z2DoitU54NYIWqADsorG0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdUEnhL6S97t1XTRfHYJ4rAX61GNhDCt47Pwy1Jk00U=;
 b=Y9n0EiPpykThDjfC33+B9F0ca2FnxO+P39CowjPsjlI8mlizPt04mmcwmf/EgPhpH+WpAvb4hAinYIg5nHygjjY7Qwc81/gwF2q6x56RwpHydyAVAilO7iXCG4AY6jbZKJb3XGQwBbz7nMNY8ILjacUgYLCg5StKAAZHeoBpP/Lj6O483ZhEuCPzOuOG5yrKCNYXZRIqqV4cOgRThveVHgK7HnHlx0liTHaCgoiXU/ro2gBwOwWIkmBRY6zEj4mWYrCT1/2+myJ32ZhUAbo25FzBCCLeEqtD7Pofp0jX0X6w4edBuLurrHPMmqR7P9dvQl1Jk5SuvSd1z5BPxlD0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdUEnhL6S97t1XTRfHYJ4rAX61GNhDCt47Pwy1Jk00U=;
 b=VsHSgeboquQWo7KUkZ5rv9rkoR6q0XVV+T6KIAxe2vN3kL9EdAshGzMLQU5Uq/XzwBKRK4EDQ+JUZOE3aPCxazYbOaGhKDEdBBXMd5C/QLe6y7uuT+2qXhUtsImtERTxIc5bM1QCoqtCrgh+6LPOyjsIu1TOaQCje3VjWjFHvPR1aqhwRb+K/wpBKe2XQJEM+/fscRgqbYp03ZSQBZYQYdyDzXKsnJVKtEn1UJUpmdMUe5rlyEt+3yFTbD7KhwXZ4R0/J49zY0QgLyHDJor2oqvI702I7Zcez8nxvdFbMfWCe/9KsEXdCXfjR1XxYE39vu/Hc+EiVRURMNIqlwY5Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 11:42:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:42:32 +0000
Date:   Tue, 26 Apr 2022 08:42:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: bug report for rdma_rxe
Message-ID: <20220426114231.GI2125828@nvidia.com>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
 <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
 <20220425225831.GG2125828@nvidia.com>
 <2f84097e-b31c-52b4-80b3-9e275a3b83bc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f84097e-b31c-52b4-80b3-9e275a3b83bc@gmail.com>
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4a0ddc-ea96-47db-2c68-08da2779d9a3
X-MS-TrafficTypeDiagnostic: MN2PR12MB2975:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29752CD94A5288E064FBDF51C2FB9@MN2PR12MB2975.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qw86I9HybPW/O3B3PMaC/vYDpqlv27sP2kanVZE5Duck/mvwHBHeRdxwOS2mHvEmYBQyGvjzOZNtDi+dzod5/DE8ymuriLeCOYuc4wF6waqREAjyzCVD5kIvZWps7zaU9sMdVAhB3FN0x9fyAuT0/Vy3WtaqkPoc9kW5KrwfVk2zXnnlvHleUnnSxfG09aOAXd4bPd8mofoAddsxdHmrNzcvLuCFGNgt9J8Abyp0aFucTlKUwxAaTt8zhymt9LqkrMZmMOZcOHx1TKf1x0VCF1CaOhn0rRyJ8wlhAcKLTOSfebSnNIyfZXJEdqE6lM2ZniBdkBbJ/QrV+Xx+gLqCnnA0kGIHGAGe+rQmUEzwAZwPGfY+fO7pyhPq+Hlk9QeRSE+Qn08j0u2OFYvgY58/YNbfqzuyR/h2zPSeC2lPE2FmNb1a8OuvRM32b36jU7oS1vvZguuuVcGJb7yFdqVhqtXHvPTqVOSu3cJ1kTExRRZajyWZeDvyuW4D2LXrf2fZvRuKAt4jhz2Xnt0bNkNZjCpsiUyWQ29xN0mBK7/D+XVwsSbyqM5cfyTcqD9icdJWwAt6bEnVPwTMifTntlMXT3iSs4fALY74ohLMHgf49/JesLWvOVTUjLtsMiVSranbntF28weacg+MgkJYPjvqcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(5660300002)(8936002)(36756003)(83380400001)(26005)(8676002)(4326008)(33656002)(66476007)(53546011)(2906002)(186003)(1076003)(86362001)(508600001)(2616005)(38100700002)(6486002)(316002)(66556008)(66946007)(6512007)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dmk8LnOopUf7jujN0BlrLwh822WsBSVF4jVcIelyvWbPZKeo7MOeF1rkDqpG?=
 =?us-ascii?Q?WUAHNT4pJOckTlInxv08C9zEWhiflP2MET/qAwHgND3SR34fN1A8E9RJLG1N?=
 =?us-ascii?Q?oVu46l/dpVbqFPtecu1x49yZdS55FPXgjzgDV5MUpsTRBD0b3S5T9UQztNtI?=
 =?us-ascii?Q?VjyUwbsd+ceqb1pt2mPaFbTDXF0kO2fViRd7gtJcJ0iH9jNbcN+6UqaT+gpf?=
 =?us-ascii?Q?QUFGZbHOFATMl7OraVbA5SNEsYu4uqQ7Pika+uRIk+tbsV3LnvPN+rNbatPf?=
 =?us-ascii?Q?Ib/Og+PsOUb3wq2EIizZKf5zAhPTZLg8M0Gryj9wMrXOUi62emsb8Xiv4W9j?=
 =?us-ascii?Q?5XOBb+DOyg3wUtzJ0wBjwHc5I/qfdIZHLE+I0pr/wIeDgZLsBGVmvqZlbVwf?=
 =?us-ascii?Q?VVojkBdv4UQTZpeONvjIxLVRJeDufmikJrwLTZtpwLwhByCYp92SQy2alP1o?=
 =?us-ascii?Q?wyOixleh8MikypuBO/Irk6yv9IqfC2Xr5UzQqmRezr+GF+5+HS14m8zYqv84?=
 =?us-ascii?Q?l+h2N0ji7SSgnHX4jIvU405LeflAGnokhvA0kzP3BJ50hTFruKUcG5I9RrUt?=
 =?us-ascii?Q?2yjUrQcZHYk2n6R65V6EMlb9iY68+Otl6idcPmL7r4NPXQGBnBA/aAe+xAuY?=
 =?us-ascii?Q?60eu5EBr7wM2U+0Rf2bbvCq6p6oMT18MuManXYoPy/piRLgzffwiblygFs7s?=
 =?us-ascii?Q?NtY5e4RS0wWQG42IUpBWJvtXQw9YLaUyg20Z5yrdjKj+5oO38buIWBGam1Dn?=
 =?us-ascii?Q?flXYE83fPNhlBPnLIauYwvhITJsRxJ6/K1o+YSqrBc9p0/PmA5P//XQMHr31?=
 =?us-ascii?Q?+LMUo0CYoWjkfWWJzniQvjy3huiJbb1LmaejlzzBUZ0/5OY/vbm0LzoGjlZ2?=
 =?us-ascii?Q?VA+ECycau/QcSiuorMioSWpGocebs4llqIh4OWwY40lqSk3RDVLrViNMF+Qj?=
 =?us-ascii?Q?JZMqhVULUCIWdQpqOT7J3NemutOYBp6Cg6FGgzfaZmA9deXK4zNCXw8Af2Gf?=
 =?us-ascii?Q?QQMU18LbBvwZDbleDPCwq8GOTuxg3wA2ePpQK80hgZvE97zRPcqeKOz6/YG4?=
 =?us-ascii?Q?L1tvFQVOF1cpt0aYN1W84e9fmvxxVEiEtLSBlLp1iuB5ut2732htqPEjHCmI?=
 =?us-ascii?Q?+Gkd6c1Zvyu35NHOcMMS6W7vF/YMHs+FV6+4xvLuv5Y/iPP+3Xd43gYLMIj/?=
 =?us-ascii?Q?38U5kSHTLZPz/3VCMyYDmDNZLrWxIPLG19TH/wq1y2qSQPtDPa5RCXBsc+0j?=
 =?us-ascii?Q?fvilPAy5grpsvqh+ASv76Ze3QCtODa/8wnYBoEbTxg4Q9MHkRhA4Fseld1or?=
 =?us-ascii?Q?7AcCapz4mZ++vjaPsClJA7yZhyHFO/ch5KzvHDKZF97oN6p8oUy7S5wGWKjh?=
 =?us-ascii?Q?2MuDsrkJBBwxbRHWKFAGZIPD3QNdJmhY9ROvAyoG4X3ZtBt0YewomOC9EhuW?=
 =?us-ascii?Q?wl29G1Booc/BrazgBPpNJ+kC+DnRSfF9n3XNUiwaSRVEqWMpd1VqieEn8xw/?=
 =?us-ascii?Q?vSUYZ0etpXxWIE9e1FOpg185xg9/Bk+tovoCWCH9ca5mVP8fV7zfS2c3CHbJ?=
 =?us-ascii?Q?9jI9UDPvfE8nvGO71f2GN/mSgytl2p0tVk63gyTKg7fqUOnnzUnhmqBQ3Nxr?=
 =?us-ascii?Q?HDe6zG6/P9PurFhEC9h7TPr6M7I3EP1jq7AlvdPPyfi2C3QMWWJe8jwK7D3t?=
 =?us-ascii?Q?zCR+340XFciQP1zgslLr5iyfSDVnvOnRJFJz9KV78baR49AJlKnmGWifa1zv?=
 =?us-ascii?Q?+NxJNWVLTw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4a0ddc-ea96-47db-2c68-08da2779d9a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:42:32.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGrsin2GtnZUZJRmaNAb0qKz+KyGHMU/x8lH+nqYuADmcpieRa/8koi/xMr1dpao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2975
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 25, 2022 at 08:40:30PM -0500, Bob Pearson wrote:
> On 4/25/22 17:58, Jason Gunthorpe wrote:

> Imagine a very long RDMA read operation that times out several times before finally
> getting all the data returned to the requester. Now imagine it is followed by some
> small RDMA ops to a different node that use fast reg MRs and are executed by the
> other node after receiving a small control message. E.g.
> 
> 	node1					node2					node3
> 
> 1:	Send: RDMA_READ(mr1 to node2)
> 						RDMA_READ_REPLY(mr1@node1, 1of2)
> 	ib_map_mr_sg(mr2a local)
> 	Send: IB_WR_REG_MR(mr2a local)
> 	Send: Control msg (mr2a to node3)
> 											Send: RDMA_WRITE(mr2a@node1)
> 	Send: IB_WR_LOCAL_INV(mr2a local)
> 	ib_update_fast_reg_key(mr2a->mr2b)
> 	ib_map_mr_sg(mr2b local)
> 	Send: Control msg (mr2b to node3)
> 											Send: RDMA_WRITE(mr2b@node1)
> 	Timeout: replay from 1 (w/o local ops)
> 	Send: RDMA_READ(mr1 to node2)
> 						RDMA_READ_REPLY(mr1@node1, 2of2)
> 	Send: Control msg (mr2a to node3)
> 											Send: RDMA_WRITE(mr2a@node1)
> 											FAILS because mr2a has been
> 											replaced by mr2b.
> On the other hand if we replay the REG_MR local command that won't work either
> because we didn't know to rerun the ib_map_mr_sg() call.

How did you get two destination nodes into an RC send queue? We have
SRQ not SSQ.

In any event, the above is a buggy ULP. The IB_WR_LOCAL_INV cannot be
posted until the CQ for Send with mr2a is received. (or possibly a
strong fence is used)

It follows the general rule that the ULP cannot alter the data memory
under a WQE until it sees the CQE for that WQE to know the NIC has
completed finished with the memory.

Jason
