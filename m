Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985B366E444
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjAQQ7u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 11:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjAQQ7s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 11:59:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9370A39BA3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwwl2C6bH1pbOn+jYUopAWW01VVxi3Q0TBjT81V5e1G1zyPqWQvWdf2kZKglUin2StxCDcMox9DvrXid/rtGQGfJZuReSr2q0Nkj8PJHN3JyrxHRuWd+9ob7fYjiFtwHdNkVg/2RqKx00Dw/ivzyJm1cjsiZx5NmRaTZDS3X8PekPm85llH8AMgwPu4zFbNax+GfUZILAb5wRUAIl3PcnZdcNOPy7KRqSJThhYbg8kfcxLNtNJvK3Mw/ySpvOgRe0KqsyQnGxPEUPmBsZlSC9Gbu+xyL9bmE8aq6tPFt+LTCb7jc1R5zmS7/trcAtPgMw/bwNxvYKHBmWKjqZkRSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGd7jzpEQdBCDGQJp8fLXsNcnxe0mC7SiWu1rWi7R8o=;
 b=BYV09iSa+sd+R7wUPLGyMCgl93O/UuN8zIE4Tvn8kAmVa/Qpgrgs0KB72wtIxPRfO5jjqlh2oW3MYWv/HL5cTNURkibbCYjplQK0UF1FCHDFxU6IM1O/W3W6cipAqnZFm6gSszwfaLo/1jTZWv9IwAg13ZTuG7wq+IMXxGRD+2qSD7e3cnPxgHHyljfnyh8Vo13colaOyrpiqsQiU4vU2gnkz/QNe8fkTUBuwdiYRKjuOANIZIjLOSrKYODyBmPJyX6849UKLFa8Q3e1XZwpZKAfurmLQHvNEgeqaXPJ/8MX1bTzHiSV4NFvBhgsNE0FgwlYpQRjHN51YfnQrHJRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGd7jzpEQdBCDGQJp8fLXsNcnxe0mC7SiWu1rWi7R8o=;
 b=fnNZwZRwaqzhPdW8sKaDhKrLCPteUVh6vm40PjSo15bCvvn2aeS5rWLrJB2r1WUiaMrXLRt2b1qj17n4SgFOyGBrISfVxmtW2f52yapua4jR9+5iU9q5GgauIDM7gokNImfCRIyFRYwlvLoGt/h98Y8yBG7SOr0BkU1hnFknJrtIuDcoAYWMKjXAfClLo0zVBRzDi48R5e/CLiMvvkt930R4BKnAC+P6qIWOaln97dyK+Ru+fW9gbNMalywWp79JyvaEbAwSe7i9HgzMiKjG6Qe8s824DsGHbswfImWiOGxGI3iIxnWSTau++P+i0gTlUWqgKaypAvkVbHcl4YsP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 16:59:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 16:59:45 +0000
Date:   Tue, 17 Jan 2023 12:59:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8bUAIsqMXvHIJNb@nvidia.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-5-rpearsonhpe@gmail.com>
 <Y8a6mILrIxIwq4/m@nvidia.com>
 <9a701083-2268-dea5-fe4b-cd2de59fb647@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a701083-2268-dea5-fe4b-cd2de59fb647@gmail.com>
X-ClientProxiedBy: MN2PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:208:23d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e238c9-bc75-48cb-3dad-08daf8ac3c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyLGPCv4VZbssra2RWQRCjahVfP1+Jp96+sbfYErcfX58YlWxmoOTQGxcSTHCFvbAG7Xqs47suczfYyBegKvGA3Z4Quicjjk4FBtofxrC+qi78HwJEWN8F4Dpx3ZzqggbKgkSDK9tQUEzH+WX0Js9OQsSiMOEwtAdGIUJN+8BdZVMuceLhYMD51MrcCR00rMhLR7x1AstsnyqkSxZ5WsbfzsFpmjCK8ZHOfRK24AnkzMMMNcoexWumeXZ9nJ7zp493PcxW4/6UG4OHMPaSrcO/34VpA+d2sue2JKdN3OF8iMCnrlALYh0Vk7EobrbJea3l8IaqXyuCVBmTf0nL3qCbC/zZSrCxEPowMRVZFdNE+pTMME07WFxeO9ij7rXpe007BhbsPqwsrx17+Ny+jtjtEgRNG46JxQUqpMoSTO9hC2WQQ+xl9IEMPQ3TlMNo2ZZX5x0DHOL+uQisN6oWAlZrFcloevO5/E5wzxDldby2lPT0DohrS/4Va6kxEoxHfx4P+6P9+GnnGjBPHFsAuAsgrDyn4TFScq4SkG3dr4Wh5bjlDCASTrkf+kmPHULE8xNlymkmNSIi1fO6kkgwKJhSbKozPTQ8WVjjxnQ4cj9ZWK+AHd8LeE+z01WfN8KGbgAnTuD4E1FKtYRKSAJSZyww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(36756003)(86362001)(6486002)(66556008)(316002)(66946007)(4326008)(66476007)(6916009)(26005)(186003)(8676002)(478600001)(2616005)(83380400001)(6512007)(6506007)(8936002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6EKvV8E0nrjuwMbIrnX+OrElZdi1Tc64rav6505+hkaAS9911vHaQaL4dDd9?=
 =?us-ascii?Q?kwDjzySGwz1GtfLAYAt2yHOWZiGiVw+bM7DAX8xNqMt6itCWwQR2BnaySXyf?=
 =?us-ascii?Q?o+Cm5qdXzVAUkQARvjXDd5uyYFIjDgnqJRkly9YT50ZmRmVfUqTyTdouxzHt?=
 =?us-ascii?Q?MA9nyFetX/9aCSitfOca5/ck6eCyJ5gfSwJ/6ZYB8UhP/6uBiQUGuu0Z+O0J?=
 =?us-ascii?Q?LGSH/EaYUEKTf/HBfDv4TKhGtBc4NvIp+eIcVkIE/6VvP1xHL6WVPddFd/zE?=
 =?us-ascii?Q?d89+2tfloYiACjyrFizCeDu4iVfwB4jY6rgs/iMwbnrRrnw5+Gcqm/dEE/V0?=
 =?us-ascii?Q?ZqEKr4Mg6Ysr8gYQ3mopsz8pBlyux2EXd8HjpjQa/t8sW4+OyKE0Gn1lk/zJ?=
 =?us-ascii?Q?6g2US2Pv255HddSDZ/smdHyuJSDERViiLvacZiCydcpc+b5tmvruxsHYxIcp?=
 =?us-ascii?Q?FIiybWrgxus2oY4skP0dKEgdnFGocoH4+GvC1vVz4ah00P/RncMPsR+iFcym?=
 =?us-ascii?Q?JQBt/2DKy3qVZp28/+3meZat6jjRn/ozKWS64ZnFkkA9ZJMWdDGBa6UBUX6K?=
 =?us-ascii?Q?e8S5eVxyOxZrws74NXSJzNa8Mff55LF7uvrSGkzVSZgZ9dPQgyoxe7erp+Zn?=
 =?us-ascii?Q?ugRnua6TK1vGst7LmOkIK5PfnZivpSNRiB2KB9NbK1GuTfeJE4+cfzfrMidX?=
 =?us-ascii?Q?SEYAmiPnvpto6Je8Z1d38OHeiFc1gISl8nmySNNX4bVmrSFdcG6oPOn+ljd4?=
 =?us-ascii?Q?q582Au7LyolEmK7j2hLsHLbPR3xR1rar90N4TMLWRkkr2hpvABYchFfteq8R?=
 =?us-ascii?Q?OfoiR454dmAoka0TLNvKz1fw6OkDkAopcXpcxAytocFMO/cgsGNU5nMF1RY8?=
 =?us-ascii?Q?17FTFGfeKpf8Bxts2bKVlng7RAm+ki4+oIwugbwddNzl/ZAUfFnyOcS9btmo?=
 =?us-ascii?Q?nosuibMqDAaDOsUxrDwxgIAfnHB2bBm66gTJ02ijz5jvf4QTG6pYWDWXvrDJ?=
 =?us-ascii?Q?YD5DRxl69Tp+DZ2hNdtvP1QKbX7FI/RfYwl9hdX/VfulRHye9OU3crBC9lCt?=
 =?us-ascii?Q?rFTvrt05cOZpwGBcYl+hUx4eesW+h95KLjFyiwSpBG3kY55Gm6KYRHgfY9yv?=
 =?us-ascii?Q?GbOZOvsINPtNXsIY0TR3tSuKIQD0vz+pI5tS2d8lB48aoiOSqfqxVvhg3Dqt?=
 =?us-ascii?Q?fVBkPif+0n91V5mmbVbT47NkdvmxU+99NG0SNvQmvfw3SpgdGsnBpfMvUY9q?=
 =?us-ascii?Q?lDcybC/msWBVXVF7X/XKjDVX4sN6p8E+WxLUBQVAPKQKyP5BhfCtA059gBIK?=
 =?us-ascii?Q?C7jcugoISbUylz9GNaiOsLk8fl9ebuZ2nJY2A6ZbM40ACE3gBIEwsVFaOI7L?=
 =?us-ascii?Q?lNUDmpQWqDX/qNvYU6ivIrm1qPJUzTwfKah/Mvm/BiXKIbxLLKMbcb5uh1Zq?=
 =?us-ascii?Q?bAQLPx+302jR92gOPuO9KLUX2MK9ESLgnGnZ4HJOcroZtbJ7iO5CPwSW/c1L?=
 =?us-ascii?Q?GyXH5jtB+AprNbGcY1QcYcDoyqbVUk39w88Ci4hLgGKz9KLKzyx2xVK+E55F?=
 =?us-ascii?Q?GVpqmOKUIdpwe9SkMlSpfMR6EWdqw60NpU+8Zfx0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e238c9-bc75-48cb-3dad-08daf8ac3c41
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:59:45.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEewTeuyk2enPRWlzXnc5o1uxFiwzP0r1/xEYqVudMNNKYqBkMqdF5KkS3xREaOI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 10:57:31AM -0600, Bob Pearson wrote:

> >> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> >> -	/* check vaddr is 8 bytes aligned. */
> >> -	if (!dst || (uintptr_t)dst & 7)
> >> -		return RESPST_ERR_MISALIGNED_ATOMIC;
> >> +	if (res->replay)
> >> +		return RESPST_ACKNOWLEDGE;
> >>  
> >> -	/* Do atomic write after all prior operations have completed */
> >> -	smp_store_release(dst, src);
> >> +	mr = qp->resp.mr;
> >> +	value = *(u64 *)payload_addr(pkt);
> >> +	iova = qp->resp.va + qp->resp.offset;
> >>  
> >> -	/* decrease resp.resid to zero */
> >> -	qp->resp.resid -= sizeof(payload);
> >> +#if defined CONFIG_64BIT
> > 
> > Shouldn't need a #ifdef here
> 
> This avoids a new special error (i.e. NOT_64_bit) and makes it clear we
> won't call the code in mr.

? That doesn't seem right
 
> I really don't understand why Fujitsu did it all this way instead of just
> using a spinlock for 32 bit architectures as a fallback. But if I want to
> keep to the spirit of their implementation this is fairly clear I think.

IIRC the IBA definition is that this is supposed to be coherent with
the host CPU, the spinlock version is for the non-atomic atomics which
only has to be coherent with the "hca"

So a spinlock will not provide coherency with userspace that may be
touching this same atomic memory.

Jason
