Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0384F1B6C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379048AbiDDVUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379032AbiDDQVE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 12:21:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770CB2AD1
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 09:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHWrJcG3nIUEIY92UPmaLWC6S2p4exL4EjSnDVLoDDq0QrDJz5EBViMz9pt33ARla9ffz7mTV4ZIXTFm/UsDZK78ZZY+jwodmg5J43jc/akZAxDQNL2c6rURgFKdgIJt5ZTgDcc2JlaNdj7ir+bt4bG+bZBzXXEeoRrOlgij6vNYGBeGHeoqN3Ka8USukTiSKI6EJBZKQWINfRTldp9UG62+ijTbXdJ98K0taElLcjyGqmwB4bAJGNEKRg2fBJYReVjbO2PvbFj9KV9HxxeK9iA83NkmACamZOvMXOvnMBAZpcYLbl9cVqgqHhhFEJgzVV89K7PXwnJEfaMaQ6ljHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhggkaVRRQblldZ37zWNfmG+0d/vMUdOf4DxvSPR6fk=;
 b=GGJkwoLQK4Bk/I1lFSnCe0crzBZLu6/rHpndB94v0NhWWKekrfR9ihpGtd/LrUG5L+pIAA0NPv0S9Y5zr/lhMJ0C0OnFr2APhbSmdNdBK7RbHpL5o+DxTrOKY2WM+8h65rZnC/OVYeun9O9BsQpEIz3e5PFqAoTb7Flb6L571uy5XUS+stdPOzquRGbjd8i/JgKPsJfsc9eg4g52QZn8Ad2irvrA7hB3NMoSBTfddbbUnxg816zeCEesgRJbGzXMtinNLYE3HxscG6b5fNuei55ZLJhwo3LJ6Kxv3SgS6DfE4zf7lbg1TYzLklaXrzYdAGBlJJGHhTbHxUrSj1aSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhggkaVRRQblldZ37zWNfmG+0d/vMUdOf4DxvSPR6fk=;
 b=U3mPOOQFii7QbzS6OUob8XbQkHxL7iAnC5Cv95Cjr0VRb6AnaiT0+gX+ivZc+I8jZ+0TtGZ9a16K9GDgL+oKOoiomO8VibhVzJIMseUtCTAcL2dKL+DAfkZKIjfaArMXFPMerdyqMcVYdkEG1WtP74XYUCfzEzHip48DdzV7TZbYNw0OhFA0VFnR1kywL63U3tz6NkG43mMgcv0VEsX7F9+EZM9X6bCyQFd8kns5RxB6pYsmjwJMfwxKM91OB09Sv50n4ZbmCTZtfoGrcbC/Hh8xL1QBkrQofbQKSUfZ8I7GGGOl8b3uDbnpRRLlIdXAPp4uVa2vVmYr18RdWcH9fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2508.namprd12.prod.outlook.com (2603:10b6:907:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:19:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:19:05 +0000
Date:   Mon, 4 Apr 2022 13:19:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v4 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Message-ID: <20220404161904.GA2974294@nvidia.com>
References: <20220331032419.313904-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331032419.313904-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:208:237::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9734a9e4-cfca-45e4-4e5d-08da1656d6db
X-MS-TrafficTypeDiagnostic: MW2PR12MB2508:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2508C36D2FC66B28DF2BF462C2E59@MW2PR12MB2508.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUO7KLF7wMR6JOpymSLdPcvYn1hkYkl2XIWYSVOsBiKp6grH9IoN7SamtAlAEpaal3sVUc1hsthKPJ7Cq60vPABKRtK8ADTesUryfMuKe2z9Pd88zgSAu1GHca51CwwGaTZPzLSPSONcT9EKLRWq0O6m0e3ourFDESb8LQsZ1BYdG2TPGQLb1nZCS6/itF3c5vXKZLd70oFAeKu+roFXurRRTO2ndPbz8coUYtQaYcZC9jbjWMvvqDmOeV8I8o0N2lpOxkUzQIiYbTwH/MNhbIJw1pCEsvHGvkjp6CTP6clPQz5mMt2plgO3y4k0Wnq2/jQVWY54RjqWrTJsaPkqUMA0O1+vn2uZylqLHBTOBvff9PbWIrD8Kfzn3GoyZ4HmD6CmxuwhrGHsJr5AVwECuJDbg4kYXXQhy3BcMDu/hBOlTvRJvO4pNpUP6oC7EpRM6dBFCRYrkfYGxAQWu2z6IkqFjnwTCrKQDW93isg1IODdXCHYUZCpKbI9beFw7nlUKNasm9kX+3tmpLgI0KgYNcp9ad6A2TVG6CrKn4/RU/K3AuzNv0osbjH8agq59GVKq7VCojbjG4IxrULwFuJAhMAEsyDOVJDFW1jS4MwMSOb34/M5kDssvsJev8VLULQheESMlXX4hiY3mEBJ3suv9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(8676002)(66476007)(66946007)(83380400001)(6916009)(6486002)(508600001)(6506007)(86362001)(6512007)(316002)(2616005)(26005)(4744005)(186003)(36756003)(1076003)(2906002)(33656002)(8936002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAQDBgnaaj9PQ3XuyhsmUez1Ssz53p4FevbcTDwWW4LIdnoqdHlGvcvKeQT3?=
 =?us-ascii?Q?G4w7QKteiVPRzfXY/kgD8gG3DT3mNBi4wLkTdSek4kfhcRyTOg9KRt1fZbm1?=
 =?us-ascii?Q?qt3Y+pOleX7W1r5hG18DAd9qdiNNiYshHqNalQf7jZ6VyAuZM6HJKwoeoHU4?=
 =?us-ascii?Q?jD2Rm8PhRWCwDxjpNP71vxsPAMhKDuDAkB+WQkOUCyEiH6QlNjVgvvKiPK71?=
 =?us-ascii?Q?LxBrGIcmLuAtFR8OG1XxhXg1wjuWdCnErEd1cEi7Z1aoMW1qJRjil1zrM1GL?=
 =?us-ascii?Q?C61oPXge6cqklmloj1zrjb8T6weYO7Y60z+HzAjoU2kqPCo1C+ujA6GAiwI2?=
 =?us-ascii?Q?8eRnlPvd8ugcP95Qsr6d4qkCHe5L6p4w4SMzci1B2Bn5CVEgnv2JyKQgOKZa?=
 =?us-ascii?Q?qFehY3y0JilWRM44odv4Tu892dtW2zqsiE+JMnZCIIVuGZNI58+XV0CNLVM+?=
 =?us-ascii?Q?mcEVNlnRxNDr09QuHcdammlm/DixUcRr58KznqAT2oATYA+yUI1NqDwEo0uI?=
 =?us-ascii?Q?5LKx50DNd1W+owjAzhDGdV8WUt03ShDFrtXKXAJojBlJ6i8VM/LyurwmdChJ?=
 =?us-ascii?Q?dZou/4JRAdx+f5nYq5Q7yHO0JUBNW0HtCRoZE2YnMDFzRqoYFR+jK+WX4s3K?=
 =?us-ascii?Q?nGi8vDc0CRCiqbj3ozBrhMNKVN8IQmfYm4Zt4xW1DPbCgq128BXYYHh++JRZ?=
 =?us-ascii?Q?kE14oqpwohjx7vqIGfPuDGxw8lDpuSJHSsYhShPy1cL1WfYCU3s4fMi1R2zr?=
 =?us-ascii?Q?NdNmYN5E9hq+npBN2HfDusbeg21D+QEXsp+zfyO28Fnaah6LlJoiZYs4USS0?=
 =?us-ascii?Q?GtdzOi8+NOxhKNW3vYLKKFwquebu4N8seACAbvp30Z/JhWnZ+PVHmGjuk9xh?=
 =?us-ascii?Q?qfDn143R2Sa1Lv7xLHowNfuIBzsigltWJnC8HI8Q2sktDnPqFCZI1sMNI3A8?=
 =?us-ascii?Q?dGOne+uPlk4N0/nSLvcQt3JrA1NSkU4XHX5GfrI0Lxarg4ypEI4UF3dS7Y+D?=
 =?us-ascii?Q?mCIliInt3FKyXL/vYzzGnTy7jNYmE/+NdSfW/pD9LYAXckNO9yBSLiMlNmIK?=
 =?us-ascii?Q?TTmfUEtcKW/n0Ys+4/jnQbPU/uzwK4RkfwOV+wJPzvKrvaTlpw3xJ+7PRjLW?=
 =?us-ascii?Q?gbnmoxjJbt2hLNLcKCxnO8FkjzbopO5BnHbqRlApVmYlRqqINoM5khZqW7qM?=
 =?us-ascii?Q?a5V+igEkdqbwyiTHB6KIn7zdoE6tLq6KwTSxo9Pxo0ivLVlbIAkybq1g3Llr?=
 =?us-ascii?Q?dZlDJGyRhsrNnf0t8zXapeQIOm7ZAl2lU/esOtE/nrFVyLIxKs1KI/CkNS4l?=
 =?us-ascii?Q?ObdtseKojEFZ5yRRd/Wpdyj9RaGCZ0fhcF/88XqmtESubYkzLtmBIRPT6o3F?=
 =?us-ascii?Q?kO7LG++V15UqOKawMCEObGVY1AQ3JCRIVcWMP8XgbUmrmul6F61e+0QGFaA0?=
 =?us-ascii?Q?WMEvHD+1Ho/yof/HhkdGuzJ4MTBku6ywv+CZJzT6ZiWxNulwzzGnLv3AUQV6?=
 =?us-ascii?Q?zOKO6uyRyFQaFmOy5NeWmnWVd/1ptebRC3BSGgQBYC3yb354SVyFX6ks2SAJ?=
 =?us-ascii?Q?Zy+bj6SBqJWnt7YGkp6JpnB0DVnsOx8rctYJ9/6DSdmHICDAjSh5ml8E18/b?=
 =?us-ascii?Q?zq6g/JlUL0h5eEsaVuXIzNochyM/i7PDvz5+gYewtlfqLi2zQKbT6q7NzqoL?=
 =?us-ascii?Q?2KRmAQJbM7LGu/u94qRr5rzgC5yZPnj6hStt9aAQQOjdWVI/mYcbLbM32O2p?=
 =?us-ascii?Q?EiwGo+bZIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9734a9e4-cfca-45e4-4e5d-08da1656d6db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:19:05.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mBdWrLRXfNT0wNUTTeJup6p7eiHIIOx8S7gOnU3gOYq26E/IMkE0wvPTTVj+hVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 31, 2022 at 11:24:18AM +0800, Xiao Yang wrote:
> This enum is used by ibv_query_device_ex(3) so it should be defined
> in include/uapi/rdma/ib_user_verbs.h.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/rdma/ib_verbs.h           | 18 +++++++++++-------
>  include/uapi/rdma/ib_user_verbs.h |  7 +++++++
>  2 files changed, 18 insertions(+), 7 deletions(-)

Both patches applied to for-next, thanks

Jason
