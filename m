Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26DB6119B6
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ1R5N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJ1R5K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:57:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44DF1EA57E;
        Fri, 28 Oct 2022 10:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO8vuqaU33e9ReAWz5eBj/ElTXiohVzigttyWgmezRdCS+DJiEPBshdEvVBFqZaPwd7nngmyUSzlDSLuxxUOa3sttsPma/CeEvWhTaGicB5nm9QyLcJlcJw9kYxCDmLpuXkkS/fP1b3Tu2bOdV2NaVknSFYxcWCoyvw8oELcmj3sPUAwXA5Gn5sSKqlIoMApgZPJEoY1whPLzzpF6PQjKocSB+jeMVloGDqU/u+GWvXNnhXhV/UWSP3Ej6b/Y07QmFVzGnvrbYw3LUkPrLopy4A+enCk5iLXrA6OWd3To3liwUitdJKxYOQEZSZqLfXPmUM7wIux1YbvmEYCnvUbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7R83CljAk9zJZCcVVcpCxGg+MFBn7vCSlojh/PCI0M=;
 b=YTdcKizdaP4vTZ1wZHBHws3ltwkz7YsNHofgohx/egKKFlkgb/0DQrES71+1g9w7g6sqi82fjrrWsk0SGSQ3wixjQs7Y55bw/qaGakXFaiGWsLYqtAJua10fP4nesANzUqWUvP1yxgqbgMUzfxlggAFwgQBw+XJQ171+1Xv0rKkuZ3+wuk0DForIgSfnHArDsi7kuot+xinGq/pqN67mmogZMErighP3tZ6uw1XRiA3YqeVRsVpJBTMQD/NUcn6cLITFt0Od71takvhuXAfvOoB7SMFBaKv+HhIQSFT3PbpTP/HeZVf/8ZflAtX8u3xxh9YkkjZbsl6Wt5qiN0Z3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7R83CljAk9zJZCcVVcpCxGg+MFBn7vCSlojh/PCI0M=;
 b=eIjdDA8g4x3b4bn2Felql5+HSHh+bSKFXIcFO0UwYj5xOtR9tclnPHrcawp7yh/WXdpIBNzMXd3+BBE9uOD8lr267k3l2LDPBPKEpij4NqV1Ikx1Cuc3E8nrnhdmyKOpsQqxLqHikXPu3z442HHUnka/4q00QpTj+6+GCndvAa7jz/Yn+8nIRZghrscG0qxY2p856f2j7+9v/HHCrkALf2ggOeG9WeLRX55a5jCzxrrFwGFHh3u2t22gR/KdDbJWH4DqTwtHDwCbboFryVxXeQA9LQZNMRz9QnuDtCUtjdyBLEbGD5fS8cAqe5w/7Zbe+Zs1noTOSeYehPYVBT1iUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 17:57:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:57:06 +0000
Date:   Fri, 28 Oct 2022 14:57:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Message-ID: <Y1wX8n9R7dkLo0KU@nvidia.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BLAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:335::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: fff326d9-3e59-425a-346d-08dab90dd3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sThj+4jK0IKt9+k4Qg1o+5EALJRZfeisJpp51q6/E2Wg3mvgLZ+fkwO/D1Fi/6+Rymsf2SmNxHNnRNOIIb0b83rYRaaAEUFPpA92G6GNA40G1m7R/pqRCc2GDZAqnd2kVQZPjzoB/A1AOqe7wjtNM4fz1HTMYOqM6zkaGw5rv52yNcwb5MDq0W2p79QlmFUNRH85QU5XKy3DEhZcw3vrFhWMjxm3jMJHjiboSLpi2YL8j0xaO5j+kOHnhLQ7fiQMJ5xN135UFEsa2zMAA5ZtzCeArBdPpYHLR8ijMo96O1LMdsfz7cBsmEMZO6RJmgK+WbM7nqIRTK1V5IbEcQ+8SUig9R7+7sX44TBTyRrb86IyXUq5S8eJ9KQiFUwdiAkfZ+X5qiG8eDu9+qXNj/RQSsr5eNcXiOE1IQp7QuIrQb+Q1Dkvc3klkLwofRdf4lUFvUmrtBMqF/Vb0mC7cfT1IyceDC7/DaWlexW+23st0hTPR1P58Egz8VJlQkFtiXDWzi0U5x1WaKHGuT9XZhpVQ5PEopaBoGqowD5+dP4F476aF9F+3IV6diBSBHcTYHxLY5SR33lLlTpZCN4+ktCxXmX11MxcQq2SxwRGQl5gcMtq/4gd5qQUAXfojPdVMWXjlUqnHNdiucmJS8Ss2bhYb6teAJQl6MQEjJCbxvIfR9MY4uqEdjjWjAawqnatRlAcTyg6YZMAonp4SrZrIocjzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(2616005)(2906002)(478600001)(186003)(8676002)(4326008)(86362001)(6506007)(558084003)(8936002)(66946007)(316002)(6512007)(66476007)(36756003)(6916009)(54906003)(66556008)(5660300002)(26005)(7416002)(41300700001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANJ9uGJvDtHfhP0wdp93t2LykVUXI6DtEWK2Jaz40vwqtJ8qaILsT02PX28z?=
 =?us-ascii?Q?M4mkwpzVtgo7oyBxErP+iALFtaBqY7zE2iDTm3gDsg7emGu+E4RO/L4pager?=
 =?us-ascii?Q?kEtHT+py25n+XvO7Su8OlAmkXEYJy9F56kR3+rRPUY/5ENhrAQyurPc66LUb?=
 =?us-ascii?Q?XAgr1vuqJfFjBIt++C0ieGXxloOKqixchf60hSeC4w9FuKF0ehCOUy/09rxo?=
 =?us-ascii?Q?VybT/voRM4NW7Fn8PitPP2+vjS8RyNN4qCvnakXMQ0W6uPQGYYWhSdfjvmFI?=
 =?us-ascii?Q?PmoNbfMsN0+zI5X6lgqKU+AhH1fmZPOmJzvT9TKnHZfNjGh/ySCYsdH+ALgu?=
 =?us-ascii?Q?uitfY1nmoeE4AhhO9LH7e2kIrilytIqWSZgsCFvXH5cq+QaYW477PxA0FBF0?=
 =?us-ascii?Q?pajsRgnGPAvTE+MIxOPK888OdSGioB/AmaRTZ15+In7QKHijf5HDGsj3NdET?=
 =?us-ascii?Q?89s+yT+nP2o/9Cr28u53sEOiJZEClJqdXd65zZpXkKhXUhoWdaHIHhXQsi4T?=
 =?us-ascii?Q?hBP+YeKuPKsg/mgGUT6PSr27SghleVU9JadMXDGUuikwsXFlrc794Sw7mRF6?=
 =?us-ascii?Q?GdD5XybpDKlUUOl6hIpJthaX57D0OwnOpt+6PCd03GXaYUrQGoewQ5OiFZRH?=
 =?us-ascii?Q?6PAeNHnyTfm8/use1Ysd8I0mHZ6pML71Eg+KJFE+e+zET/sJDRmT+lYHAo4L?=
 =?us-ascii?Q?FZJJxz0C5WnAtIxmEO5jrv/I8ytuG/wj/VMfl2X7OMsMc6G19jx/ntb46iNa?=
 =?us-ascii?Q?nrKF4SLTzTiSHfCWHRJXyH+SpmEveaC18p6XF6fy0QaZ2tUq6yVDgjNfUD+N?=
 =?us-ascii?Q?hC0sECdFSN4yv5hyP70QHWmVmTxjacENwWiCzy+ybvortUBu2ZSwjmH8StIq?=
 =?us-ascii?Q?w9+QmQVVxz/stlGRcgg+UtzeYNfJ5VMuJMBKD+zBAd1aJhkOVi+n4IagQyCu?=
 =?us-ascii?Q?lX8sGxbdv5CrFCvQERITzpx2fzltLiXuZkqogP0pZ6k5J6EOAYztnlDz1bbW?=
 =?us-ascii?Q?LXUQvVSh5YBS1jeyhoWhEFtveqi/9f3DueWxvw05tAxayyY7xY33a6tqfX4/?=
 =?us-ascii?Q?COsAHaLHJIc18u30BXxoHtnHFFV5+yvDA3Lq5jwqimbJXJYO68DlryjXkig3?=
 =?us-ascii?Q?TUrpt3Df5InLwJHV87l+SCYZLs1wg6mJnY28MKZMxOHWCGL4CPpSpeGfWW+9?=
 =?us-ascii?Q?miA25d+3BJUJSCzJDz80+9Rh7D7Xs2i4FRRztfjHhmsq682VqmqvF2V0Kpfr?=
 =?us-ascii?Q?9De17Hy4FuWqwrwx4Q1HV1u9235PvtpaL5MFXw/0rnwwxRZOkva5Gw5QYAp+?=
 =?us-ascii?Q?9yayUDDdnBG/4aEBogdrrEeWQhYTCmUn8WLDEVJ5OQ9l0XFzbLnULxwEXhAl?=
 =?us-ascii?Q?prqmohxmax6PGlXreq06DGc1jLO5+Og3X8jSZD2zWX54zlxhMzhxDPiODn8h?=
 =?us-ascii?Q?Abrsl4gNOhK3BY59Drs5q31hZ7kw5B9SA0peB0hepVimrJnj3jNkU9fvHwmt?=
 =?us-ascii?Q?+G3oajZURXs+7RbnuTUyoEVh7DafKhGAeDZzRQHlrwaViyjY5GrcgXJG3K10?=
 =?us-ascii?Q?yF9B03CtD2nwPWnohDE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff326d9-3e59-425a-346d-08dab90dd3ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:57:06.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJxf+vRWb3vJeKq0mjmCZXY/tUahn39FnteCFsZqM3Ep4Eg26k9XmERumHhkQq+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 01:53:26PM +0800, Li Zhijian wrote:
> Hey folks,
> 
> Firstly i want to say thank you to all you guys, especially Bob, who in the
> past 1+ month, gave me a lots of idea and inspiration.

I would like it if someone familiar with rxe could reviewed-by the
protocol parts.

Jason
