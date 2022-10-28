Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AE6117BE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJ1QmL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJ1QmK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:42:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122891D73DE
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABa+8rwt3MGBVJv6bcF4lkAh0SVyBJmkbdhIRF5ZZM8t0dEzRofPv1ujRcWEYxdHHgiJ5ob0v8tpP8Dx6KqbqIcd5UHEtOMAzcDRrl3z6M4HA32bKlm17KwwSui4TVQUbBmJx+VI485kwNGsqGwqpaY6fOD+3Qbg2y295ZzyZ8j9MrjHf9rcqCA93G5GQxlUty4Lvt62qJXWsnFAjuqgPMAqF87XY3PkSKMCLS900fljTF9yL44esnN9QFPUM6q5/vWZSUYCfpEtwg0turgqs+eQjVLR9UQM/wwVFO7r5s5iRMYAGo+UEgspU3AxeTsL28OiUldgdJq8L+U63IYxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46GTh60WQhk0tyKnW2onqIRtpXyIZz256lwYbcDyIDw=;
 b=JWpeR2dCPBbDdqDMgDK/h3WmTlBYkYzbDQQw1Q20uERxytMxUc43tXu+IqunvH09+YpdQOH+9VDvU4VY6k/N6oQVLX3vpx23k+EaPTkPNwp0Ti+/dSLukd1uAFkKvyGWJsdFL2gsZ7RqZM3zNvzA//F3Hia3XJnjo7Jcv9ZziYMixVnfL+oI2rYQnKXWv8E6OjO96L0JBle5GQeCQnTj5WQE2dhH5hZfRKCw/QYH7stp39oulG2N7YCquNb96XjTQPCetT4IMDlK4P4CgCe4rkf+nnUWnlsJm3FHfTaVslQ4q8zE5C1t21A0yflp6NZA+vpvBxI6vxrg1ynoVX+kPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46GTh60WQhk0tyKnW2onqIRtpXyIZz256lwYbcDyIDw=;
 b=T3zgpb5fd316JA/GppnqM6x8WA+UPlsngCbvUwD8kEjtdyMUZxAvOs0wzzEFdq74byUaNN21wmkI2ciB0Rlu/hJLYysdgjCm+p1d2NytNbkq1Cs6jtnl6yvcfJfK9WrQWNqdavSyVNUYL+NJiyLHxOaatNRRcc72bUvfdv66S/vu3lq7D0O4IqRDVbjfzU94dSgN8qTnyQ6X1/4GiiIRT3/D0jcoOg1iJ+NVhEubCWgEmv1qiLWrp3JG5h5jm1EZpFOABbvYKxTbGL4CCp7asiin4fr22xmK2xt8oHqViOHM0swxDMXYLclIIkLRkZ2VUHBJP8d1Jz7XGC2p1u+Xfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 16:42:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:42:04 +0000
Date:   Fri, 28 Oct 2022 13:42:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-rc 2/5] RDMA/hns: Fix the problem of sge nums
Message-ID: <Y1wGWydgMduaZTOE@nvidia.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
 <20221026095054.2384620-3-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026095054.2384620-3-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e66c2d9-0869-4d48-3170-08dab9035807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRX340313VXBmom9SA9l47iyVjElES+b2oa8kTduh/trLEpiG+h5F4E2iDuf1EgnP42XFsgutwPgSy8WCNlk7bB6Cn/kHWFC7uKqTz2Xq2XCQ2jyCFSnm52wTpLyzZyTPk8mXsWvAodQUrWc6weUrxBiTDFjCaBCXOnTvMG5tYZRvGzg9C48evZbJ3Qw9dR+8N5uh4plGroIO+VExoSe5z1DEc/1CCBRTI2rp4oqU1v+S8f43ezRwg8iGlJiiL0R9oEfqX4XzsqeRE8YdUIesv1cDtHZHtKVjmqEXRlHAUAnb8MIzg+b61FjtvpzPIAIPSDAjq8mm5l+NlmOWS5HibpuqehdqF8Lc7FQ322ZDPg0B+QeNG7pZcpbzzXxsj7sxanOrKMqcG3dk1Of5CGIBkMEdeWP89kLrymLVPo9Z4NTetqq/pLWNHrCZe7ZAAmHuRU4NkeIYl5PKvwvn8gZmcaMmC1OLd1bc31nXn0Z42nEkO6TZ8JopPjbBeYJO0YpRsqqwxAIvRhyvygFYLYM/q5kxz77u4HRiPW/VHERnszLuI9TJ0XGpy+mgmrCpWz3pKhFD0fC7CaNzc68Cqwu8xlTuaVIQcsKE4eUAvWk99xUzrnJZBwyfysziWFBF0WuUWuf/PGT2SPT8ltFUoirgEI3x9zjTiKugqRJqjCrSKXVS9T4TUQ4SSCj0596OgX2POOKp7/y+HD26eWh4PpChA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(86362001)(38100700002)(5660300002)(2906002)(66946007)(66556008)(66476007)(8676002)(4326008)(8936002)(41300700001)(6506007)(26005)(186003)(2616005)(6512007)(6916009)(316002)(6486002)(478600001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FUK25BEjG1yGgNYXVn2GnMt8Z3HR1/oS4ebCtuAph0AHOIevEjmNqbAFFoVL?=
 =?us-ascii?Q?Vh1Je2kImSiL0b1dS9aKKcDoc9t8ELFbvZdcaq9ZA1IakeNqtgMntDWGHG9b?=
 =?us-ascii?Q?n+DPoAgQP4rfTSRb8TH5b2DdYnZzCm1R+9DrtD3EgW4t0dp1qpaKgKP8zGr7?=
 =?us-ascii?Q?XYyWoBp37d9r92ynN/AzcNbMM4lKD5u4f642ZFoE9jq5xt7iyvpnbs6hkPDk?=
 =?us-ascii?Q?VgGinSXVv0d9RF65TI8FQ7EUnxaGZv83PHAWCv+hwE7xosLp2fZDtsCCEedG?=
 =?us-ascii?Q?TYnQEnoNFSvP63XbCAsKpGBw+3SuWjMOGPwdk2MBsqcIFEzKsr55QROTdNWF?=
 =?us-ascii?Q?5lM4XHuM3B61Btcr++TYrIg3Y40Mld9IDjzbNJu3gaPwkPbZRaKlGylqXJ9y?=
 =?us-ascii?Q?0FsXlJzB7JI2T/7RXGMiEyJTwDzGOedGsTbV57TzQA/pxcdOJr/myMMZWEJi?=
 =?us-ascii?Q?/yaWKfDpeX5pU9zdmyMJl6QcN8QTC0wVjVdM4fY6dZHpQtZ/trCqzRFi7FZ8?=
 =?us-ascii?Q?bt7V9ZiEcXrvumorpDMWqvfvt4/LA8kIiiyhFOCwSy99oXUp/yQPVyByYBFm?=
 =?us-ascii?Q?++Fmj345tkpTZuWh6dNPjed/nI4XQe385fe54C+YCC6wJQ7n5OV6bMN1XbGO?=
 =?us-ascii?Q?p/RQnYWjfpZdJNS9yPG0coIuDfGbDlp6nAegR/c1AvK7QZNlhrfmmTvNLYq2?=
 =?us-ascii?Q?lisR5QwFxDiTJnQkUhTmm+DKEloS9tXjnQlhl0MQ/XPZ6K5qxpzro2QXUyjM?=
 =?us-ascii?Q?hfw/0F2kUqjg6VwkafLYkE7mIt2pcJl0PkVNZmM6x3Fw4v+isZQqNB0uugGd?=
 =?us-ascii?Q?NYy/yYiQ8V5PggoUABeqqyC+CwLnmUQFu2c5Mv5BlJ1+TGuYyBsyGHGM10z+?=
 =?us-ascii?Q?mxYdFHIkc793gs8bl9ZZPzfAGIqX121NbIXFUKKT4RIvZuWaNjKXntMvXz00?=
 =?us-ascii?Q?Dlu3ALTh2Ei3wrgIJulmxKO2n9KWCMiHPNxg4DpHHhYxAH8Wk64zu/6+05G+?=
 =?us-ascii?Q?wWpGGv6SzeIqmOyjNJL2KVffBiidT/I/aGoTkI6k4hAm5ZkU87/m+84MZyqC?=
 =?us-ascii?Q?BFugTm4g9cqhCoX/YZy/L1eZhHm0o5tZVSDM3JrQSdcJiB2RnkGjUHmJHm0+?=
 =?us-ascii?Q?N2rZyXGMMvrfPOjC0dkB85bVfDyvGHmPKzWBydbagoADtlWToPYfqTD2GuGo?=
 =?us-ascii?Q?IhwIJDwBEb7D/QJ91/sHv3zyJ5sHbHjq0kFCWMy1Fl8xchQlh6eFzt73nymu?=
 =?us-ascii?Q?YvHU/S74ilOLKjdYANhaGxhnUgowmnVE9wcTtvfdjsDYRdsyTRz8CMOqcuEP?=
 =?us-ascii?Q?iMf3lwW6OvDSTIPV6xW56OtHOPdOMRoZg0BpG8Q+N8IXVieoz3hFscPGPEdh?=
 =?us-ascii?Q?JtPkl+4VozmVFgXacY0na+DLvth+tYoKVx4nPKsgNxc6NLi86b4Gm1n/NnXg?=
 =?us-ascii?Q?y0kOkyfC5OQg2yqetSahi9TAxmiF2Tilc807SmrCR+rXG2kdkCU+BiFxlTSz?=
 =?us-ascii?Q?id8veKTNfpEMqj6F86ISJ0WEgPevLpunXJujGUsbMVOE36WRCyLZVgGjmGvP?=
 =?us-ascii?Q?NF7gwGHimT0r86zBuE0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e66c2d9-0869-4d48-3170-08dab9035807
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:42:04.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt8f2NMMfQK6ZvNAmvGRN7JEjH32etaVzHJbIV8EA+4iwTwC7pqmavHcNiqU9KdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 26, 2022 at 05:50:51PM +0800, Haoyue Xu wrote:
> From: Luoyouming <luoyouming@huawei.com>
> 
> Currently, the driver only uses max_send_sge to initialize sge num
> when creating_qp. So, in the sq inline scenario, the driver may not
> has enough sge to send data. For example, if max_send_sge is 16 and
> max_inline_data is 1024, the driver needs 1024/16=64 sge to send data.
> Therefore, the calculation method of sge num is modified to take the
> maximum value of max_send_sge and max_inline_data/16 to solve this
> problem.
> 
> Fixes: 05201e01be93 ("RDMA/hns: Refactor process of setting extended sge")
> Fixes: 30b707886aeb ("RDMA/hns: Support inline data in extented sge space for RC")
> 
> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  12 +--
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +++-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 108 +++++++++++++++++---
>  include/uapi/rdma/hns-abi.h                 |  17 +++
>  5 files changed, 128 insertions(+), 30 deletions(-)
 
There should be no space after the fixes line, please check all
patches

Also this entire series seems unsuitable to go into for-rc

You need to justify the impact of each rc patch in the commit message,
and nearly evey rc patch should have a fixes tag. 

Make the first two patches are OK for -rc, but they should have better
commit messages.

Jason
