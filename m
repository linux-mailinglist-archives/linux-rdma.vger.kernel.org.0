Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425352F11F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbiETQxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351903AbiETQxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 12:53:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B0A149162
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 09:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csUR24X38ZdT92cledu0OC5tN7JBsZ5luyyYzO2j9jvQo5QcjEJrQ6Sjq4y35+XJ5H4frJ++8EINZngD74cO+C5yHoGozaDfgwJ89SR+D8yzLwRmRQocqCjDPYLyU5EQZxQzgrPkR9mKXE1R4kYTWoCJIEaxJ5kPOjkJO8c+jba6kQ+uiVndzVNmOwSdW9TZJjnDAMnHeE2VIM4Jv/6vnzX46Ywbba4XpQASMBfH54SlbLJjLtv6xK0XGXnrpUImJ3imwh+LW1ZwZANe2d1AnNMMSqWmdgRcqxJQIiAESALk1cjsGfttLtKKspSEj5IjjVdlsE7IpuXUcJY+Nqrbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JW37GYg40/N+3fR/qcasa4bG3J7iRKLN8fW95jgUfY=;
 b=EuyKCZdmdpfGXbou7pqVvALKfJmYG3BptMuG7ffCSg5zWb5wyW0jpwwaxKsH/gkV5PVXxBoBp+Z4QshGv7empJx57Yh0UsFWlYRsbyV5yTU0bZILchvx8YwV9f7cfIWLPaNz3nXchk8XEw/uqbZCsLoQ/A0O0lYz9dcoDbQSSBaUTTH3aVgvt96k9vy1nOpBYLzxsP4qneq2N4cHpZUaEA18Vk5kY0UqwkYmZdStwVzWNDY1zIjcrwn8WSZJcvgy2CxgARB0nEK56RMSGXpDAYnvhsXSPS9PtVESeAXwE87oSBur28zzIarG4XPk2b29arCD1vcqVfbfbMk36Pz25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JW37GYg40/N+3fR/qcasa4bG3J7iRKLN8fW95jgUfY=;
 b=cJGsj+6aMQ5TtfVoNNabEiK1lKGIxk/b6lAb87tqnsPEwRYH9LtXeareL1GAX56zkqPNKDP/9eBSMBkhsL4cgyJK1mN99TRpHQDwAY9885tG+8463ii43Whl77bSTjHatbpik0AbxRoCxyVMXUeGRhXrELhTv7W6iCt87C1O2RZ3JMbS+Bd0CBCxorZXNg7XSDZlWve/9VhVetbo2ktwX6uYsJrIeWo2VEZf+WT6yh/IO1JtzX0YpF7tmJTDhc2C4PGwRTqCkHo6dPH3S3xwdhHJtBobcOkSFaCOtrYTTQ8MjgIMR5v+d5yJyzpuFHfWsR27CbtywqCnLMBcPvnZ9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Fri, 20 May
 2022 16:53:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 16:53:19 +0000
Date:   Fri, 20 May 2022 13:53:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Add a netevent notifier to
 cma
Message-ID: <20220520165318.GA2313538@nvidia.com>
References: <cover.1652935014.git.leonro@nvidia.com>
 <c9febb1bbd678058a2b98933305ce8e3bca47dfb.1652935014.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9febb1bbd678058a2b98933305ce8e3bca47dfb.1652935014.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:208:32d::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f28192-ab36-4280-b8b9-08da3a813e12
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00052C9D42C2475C66F3F5D2C2D39@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9OPpysQHkomYRbgs5ZSiychQH9zFvwymFfwJ2xntuR1vLgpLovrIms/acrJyfHR9ytG/kkXnJq1d71VfNsb7DVwBOu+Qf+UAsdUgQAE0YbYcK0SWIk+XPbCn6qnma7COZW/fotGj4kMIx/w7YjSt1WnB2cYa4/ictY9on0+wQ2RC5O9bRuCvJwrjtp4EuQ1spDVba1yOFxNOLn787LEkcazVux4xe5LuTV7sfS1qsvPgSvDH7N1V+1uzuAZsgZjO0o9g7PpAlwj49D21nTbP6nh03swLFpWE3/2+YoGf+Ll4sQjDC7jT8s/rFEKp2m7NeTcYuEDvRMovA6jijhjGRrseDgdcbfmr+5uOmzWAyioY0dqvHKC8OVPGRSEc7dkdM2yfKhYVAFbBz3AYGHaPRgN14al/LdF/ERM7jg1Ga1wOQowxDUVWU1QnAAsUcyBrvJWhivhs0YUg1bsrhix3rQqsHxi+G90H2GDmFVb8xR2eSJbrwDB3QWhvQR1tb6vjI0I4mkWjgE/9mCHYh5xg5h7hIBYg2LRMRl/2Zo+y2XsQ8gGoNAPthbli4csioU8dYqcZmUh2XgqutL7TVwJJrFMcKA1a1yW4LsNOj8XEUVC8OTQiYxlWou/dPPINOpq6aJgFDF29Oat//ngn9XD+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(2906002)(8676002)(2616005)(186003)(508600001)(83380400001)(6486002)(5660300002)(8936002)(36756003)(6916009)(316002)(4326008)(6512007)(54906003)(26005)(6506007)(86362001)(66476007)(66556008)(66946007)(1076003)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URr+qHexSwavQk574Yov8Aq1yg1B7rYnklGEUJaIcOW5hxX8brp7u+zQntFY?=
 =?us-ascii?Q?/fYKSRpF5RhDkmJGeravHvGm3rkNm4l0GX0Bi2MIIpJV/hoFhklZELLoezo+?=
 =?us-ascii?Q?cIPhG2EXJUzV66lfH0OkI6XHkhl4Wgcibu88Uukv+HLiGrot0Rc10BEQYV5M?=
 =?us-ascii?Q?vPPAvexXRDqtwv+V1ID9xLkxXHog5ymwK69EulSL4pEPawp/X56M7i4/YcIV?=
 =?us-ascii?Q?4+oZNOI0JQFm/er5Ztum3PXTffxI1En0Wkd3fiFt73qBMMz/HWWf2ptqqXzC?=
 =?us-ascii?Q?5DwEZ5ed66fImcztJ6GT/3bt0fO8v4Ax5coKBggBNJeHYCINwQj2hq5kNAjK?=
 =?us-ascii?Q?jKQIQf/rZ/kZzeQw36Dfg8gWQd+0jccDl8CHkNINisYyRBZJYFDw+s6IWH56?=
 =?us-ascii?Q?qbSzKlLXe57lsGgpZFhfgY7QZqEWLZL9u0rwFGRhqA40XBGpnwvoaFAqg8+M?=
 =?us-ascii?Q?6RYOTWN7LdZaAp0/lVNoIvIoETyMuUQ94eWckictSXjSqsgvoS3a45diK4Xc?=
 =?us-ascii?Q?lCPAaZPS6OeJcSLEvMFEhWlCtlNnCzzC5wC3wzv2vhaQEe8BuIzmkO88inYk?=
 =?us-ascii?Q?RiuKbrmPhA8z8G4r/s8VqXS6aZDb+5+K+FR9f3u4NKfAZfk6AMXwU2EokEk3?=
 =?us-ascii?Q?MoCXyjDKsVy7A76zASAzuT3gmvqggu5Bh9/37KTyAkcSbkJU02/SOjJ6QEtL?=
 =?us-ascii?Q?KgseXl51jFOYP3wpni0yM/0CKhXs19zYo6smuA5GfWkzV/z4fexVC7Xa9D6J?=
 =?us-ascii?Q?Gfhg8Al8VSkuxbUfW3TOnevuCgEqI39q6SievyazSZrDXdS7NZhFAPIn6v0x?=
 =?us-ascii?Q?UaUqXP1VnBfADRsSt0qCAEI1SYK84L5beHxPewYHcsgQCEQsySdxoYzECrX2?=
 =?us-ascii?Q?qVboqnU+I0/oO9dZ1Lp2+uvpQ6J9g1v+EHQfxXtIe8Fl4rEwRK1+Mh4uqmki?=
 =?us-ascii?Q?u6WJJgjhyX4ImH0bQYZEM+PLbk5Z3XkYjolle5FH/n5Lp/BarjdZWtS/REZ8?=
 =?us-ascii?Q?pOi1ERVFUoG0LXMIS0fa4px+Tl1t81rCKSvqPP/wDpETUidtis5WzmPNQrMU?=
 =?us-ascii?Q?YRko5pzFfwqHab9uW9s1jBHk0JqjXu0zvPmz1fheaUR2sWmC8mw17Au/rDpz?=
 =?us-ascii?Q?YbcyNB1nCNUdrY0CGAaWHeY9mSML7jJhzpiAA6CHFOO8hhDDkIShwSOgCup2?=
 =?us-ascii?Q?1kUqmBWPXxxcma4TqpcYJFFJjrbAFbHW+BlZloGmD8RFmwmQR0vrG1QoyQQY?=
 =?us-ascii?Q?9eSB/z+8qNdUjj3p72NgBkHXkTUOgfQZpryfcLcnS6Hgp7pUE9ZhSRamZ+Jh?=
 =?us-ascii?Q?wQl/D4jFcPlMrlmLSuTvE0SRXK0mGEatwtVNdPd+Ywpj4fy8OUgu36+NkjiP?=
 =?us-ascii?Q?AW2a/xx4cdMHEnlp3hJwqgzqZgTFwrzE3Skr1xvwY/HU5EK2YyVQ53diXP3y?=
 =?us-ascii?Q?v3PbwlTW5gc+9EZC8VvdEuzVr25+Rvi1YU1q6EOTkDrVo9ouyTpQ6CXR4hoa?=
 =?us-ascii?Q?KQILGRa+S0oKJk1igcaGpVbcfo2eaFRrTUHs9D6BmJxhtmsbkhZFPZFUGtWU?=
 =?us-ascii?Q?EE49/xFhgSUAFEKz0Ge0hrr71weW4PAzuzLshXUUSvJI2QXj56O7t1J6vhIb?=
 =?us-ascii?Q?IKgaewZIyn1WfGa7lL8CPyGrFExLamzkv+x8JMj6dTd2OcyFyfC8Cpd2XMoq?=
 =?us-ascii?Q?YmElPhN3N1WteEbnXm/FmndlZyG/1yKxJ1sPlSEoDs07xOc/OZX1cb58jG6E?=
 =?us-ascii?Q?1F0at7ezvw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f28192-ab36-4280-b8b9-08da3a813e12
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 16:53:19.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SGGlewDysB15xbAQoL/tqFQ2qJ2oA4aQQbzfuSyC6/PIAr9Fkzhd4PqKrNwg2kY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 19, 2022 at 07:41:23AM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Add a netevent callback for cma, mainly to catch NETEVENT_NEIGH_UPDATE.
> 
> Previously, when a system with failover MAC mechanism change its MAC address
> during a CM connection attempt, the RDMA-CM would take a lot of time till
> it disconnects and timesout due to the incorrect MAC address.
> 
> Now when we get a NETEVENT_NEIGH_UPDATE we check if it is due to a failover
> MAC change and if so, we instantly destroy the CM and notify the user in order
> to spare the unnecessary waiting for the timeout.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cma.c | 83 +++++++++++++++++++++++++++++++++++
>  include/rdma/rdma_cm.h        |  6 +++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 08bc3ea19716..644f5f1e1f46 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -21,6 +21,7 @@
>  
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
> +#include <net/netevent.h>
>  #include <net/tcp.h>
>  #include <net/ipv6.h>
>  #include <net/ip_fib.h>
> @@ -5049,10 +5050,89 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
>  	return ret;
>  }
>  
> +static void cma_netevent_work_handler(struct work_struct *_work)
> +{
> +	struct cma_netevent_work *network =
> +		container_of(_work, struct cma_netevent_work, work);

This is just

	struct rdma_id_private *id_priv =
		container_of(_work, struct rdma_id_private, id.net_work);

> +struct cma_netevent_work {
> +	struct work_struct work;
> +	struct rdma_id_private *id_priv;
> +};

And this isn't needed.

Jason
