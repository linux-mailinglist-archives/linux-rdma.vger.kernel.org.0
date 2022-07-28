Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A00584492
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiG1RCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiG1RCe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 13:02:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC453D32
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 10:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQDsiIfWwivVYDKgbSIYRLGc5ErEpiQL6otAb/jxrp0+nFWgqlRqK/Y9dDhV9mGwF6fv9etKZCFXDtY6ktFzS7GeM855SqTRLXO5tofIOZpgNkrm+Bz4GryGPlubilLeNjVI2KM4d9kHQ5rD5ALxiFIdrAiNRnHSSscS1hcTabVOAa9g3ADPsFzbwGuoQlG054sN7OFYIibteXpRoAi41hVndbD43s4GjQTr4dbC9IGtAyXt79wg3BoL7ajG+mgaXQAwnD2sLoLh8j4MIYjORN0lIupgASakYb+kUyqiuauXYdyfWBQMOsb8p5P7bTKA+DiCCRaMHKH4UtSjN5KSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMjZh5je61XYguwmwQ6z9ItO+t25b0WS9IK1ncQCuMc=;
 b=Ztd9Ad103AF/zOy4ESUIf1Got4Vt0cz5cRJFKD7Y9bHhJ0ELda7bJQ9Vk/0RHpgvDt1QllJryLfVd81AAouDGvgDmYUSaJdUz8aSG71LEbFfJyXqBLCmN20ZOuYd2iFayD50gdupOIrqf7F5lyy9ex5NrHzAQFTBlPpiOscTRdd8R5LyKaMPknc7QDM2Lb7AcE/fYoJUtwzqgNJ91YZyceyE6eUkTv4hZ9F1MXoUjWWU6LAdnGEP4VORvE0kxMkHcbvNTw+Znw/hzVskLnpwCowF3msOESOwCst46VEdNYgcaKs9r5hCWmGRg5fLIo1+we/BH54f9wnfn9OnnlgmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMjZh5je61XYguwmwQ6z9ItO+t25b0WS9IK1ncQCuMc=;
 b=kI55SoUv1fzgghElPzYm+8noIZ5Y2IAwaSj+8FABT4R9WgtR01qw4Qs7hJmpCBogHZsEnLt91RxWp71E1gyFAG0Xl9aAkBSh1ac3uu60hhU8TGX8YOc6n3cT9wv5FsLGFxjvBWvkzZiQwZbpSeclmVsFQhh5e6CbjMjmSr+OD7z6jm38dubsBZMrIIUo5qICXiS21HBDlVHbAk0hSwXt03A6Q1TeQyQ0tLipH7kdqU68iv9J9vp6qw+2q0E5H5lcIPK8EjS5pgBq5tCSqndt/ZPwuiC5F1EmX6xqPqOxSsBzRRxsjYNaXBUcFOpzjF9DzeCYgaRkhSrfbi3Fr+KFRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 17:02:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:02:31 +0000
Date:   Thu, 28 Jul 2022 13:08:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, haris.iqbal@ionos.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Cleanup rxe_init_packet()
Message-ID: <YuK0a67aTpMWJgeE@nvidia.com>
References: <20220727163651.6967-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727163651.6967-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5758f39-a058-4b10-8645-08da70baf5c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOcM0F4SMcRqhJXkuajxz1LdNEZ3V5+t8OH8xInCs62+O6cOYrOIBk9ILOKI/rCR8kILD41nM2zNFNkKD4Ns3ZsY0Q27QLCw4Lh3pC86POggjLLQuj0BRuGNk3x/NtFpKon3wixVj6TgDD12j4Yi+hC6BTVlNSPADUgsZMcT5ZJ5KBnxII7/kNrHGsjvxmsWsaPGhj1OVU/AGFqZKtp7UYG6ql8yR1YNiAWQZw963gEv9k2Go6qXpQaEMn8ZAosexc3gcXd+hqHwlULMHH2MxTUaFEW/D16g1CS61YoZMpd0atXxDlj28TVw8ckVhv4pvVNb0EYXcIRFyfLxCF7b2gcXPAr3H2XeZmgKdNgjARt6BIAfHVm4npBzm1paGaxPwEPkahIKqxOtCPOnYndbrJt7z/Du29WdBZYTqm5fyxqmLgeohQbGmhqppIuUaQvfCv+ve/z40LvEZkwPznepcoJBMpbY3KZH+xn+YAZhHwd7562FbvYX/SBT73gm2JLKBC2RG0B/4ue6M/f5LT0M0NKiPYQi5lVUkiIyZL19XTeVUsWCCqaemVwdqQbkBQSE8LxrCNt4yYRQyCyIitB++AFlM/MsaInEal2vFBqYKOUuUUcov+tvqhs1UXRlq0o4aSnAJwIxXzjrf6zgbOCT5GUksWE5fM/6lcip+0bHFKcNw4kC4os5tPDaiwTaZDQeJdWfQREaEE8dO2Y5kcx019Jy/dK07tQXO7MiA5zmNyD5NZ2ueYKeH149gynU5GaP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66476007)(8936002)(8676002)(186003)(83380400001)(6916009)(66556008)(316002)(66946007)(5660300002)(4326008)(36756003)(2616005)(6512007)(41300700001)(6666004)(6506007)(2906002)(4744005)(38100700002)(6486002)(86362001)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sYw4hArrI1Fc3AEIZm859uoSvYxpeyJPFgBDNuaHkD7HadlgxfiZUEIgYmUa?=
 =?us-ascii?Q?L7VQcti7n8sqCAMbXcxq7+bs+REFlFr6WySiNnHXR3XB6m1K5X2G1BY2dcOj?=
 =?us-ascii?Q?3HFRCduDfQ4e+NSX52Jg3JuifryDPd0KkE1erJjOdd+pbqhQc8zQo3Vf5CsW?=
 =?us-ascii?Q?zntqlKGY/sOzUUTjEIUdOkZr8mZcNs7VpL1XPbU5Yj8Uf+7iWDXgcHGuIbow?=
 =?us-ascii?Q?oz+w19J8IQLJvDBPAfe231X10GaF0mVFcjp7sM+vZlPLz2xutkdHuWeFOtPP?=
 =?us-ascii?Q?RmbU5NnwMid2WcxqA7bZ51XNy5VwYxQZKjT1w7fkCZjvvch9/zzOuqgyNFqM?=
 =?us-ascii?Q?dgISweJ/o6LHn0nLXGKfVmsLG4ounOzfCVmmRwoZq2PFZ6obQCRAThAO0hT7?=
 =?us-ascii?Q?2D0f+XJ0UNI3Ig0ep6EfKANZ974PDJu6rEAAEyVQOeB3QzZpdSBEgUzqlikD?=
 =?us-ascii?Q?KxKMo+Ga4W7fYY6aY9ZQhMSDBII3BrfvFvfkZ167x2rTP1vwy9CF4yElL8do?=
 =?us-ascii?Q?I2uiwU4aGGUlpShCeGk2NYojlFbC+wzcdNdgKjAQaHf9S6PCa8ePK0E0fyQG?=
 =?us-ascii?Q?/JGjihLoRB3zazcHTrjHHJGT4VKjSsL32c7a+EL6pH0jZrSKMEFav/nzFlk4?=
 =?us-ascii?Q?q212paqj/SKoF4wBdjejWdjuGMMSze1KA6OJCidEwHhT/Lvv3xRbF+Mr85Ly?=
 =?us-ascii?Q?ojRNp6RRrvknauVeGFqcgr/Jdj7srtl3tsZDD0zs1WC/YbfH29tsrhQd5pL3?=
 =?us-ascii?Q?aDFGXkAd8jUIIL/sTPYqYaRiiadZctBl50QEnF5Kp+7yuKfvp70Xbo3k6R5a?=
 =?us-ascii?Q?W6UPyhprOu6L9cArFVmIXbiIkRMGm10xET5pcQ4/yokZGZ0vilh3LVhkhyVU?=
 =?us-ascii?Q?no5yX7MReiJUE9MKMh0NYyp0AUCq0g+WjUQJAvK4KZQe2LUUmxj1zqptgd0+?=
 =?us-ascii?Q?PRF2GSZMl7S96wdLtUxLBOAqSJgCu6DkfRpVXb2sPWv70Hh+foWfpsQd0DUS?=
 =?us-ascii?Q?U0EwCZypkhV43CKxBKFQAHi5LgF8m98ILJY34IacjqBF0wzVs4TnpLdG1KcO?=
 =?us-ascii?Q?7AE/fyqLnwtVOEtWrnSv3v2olgb5Zlb8EarDxVRjyjw3eFZdK0zDA8UdwYip?=
 =?us-ascii?Q?2d3bglCEyddaw07wIDqsf7RqpZhQB+m+cR6m7m9792txVBTpC1hLOUhZkUCJ?=
 =?us-ascii?Q?mz4HW+m3qZJjE+AxZrgAHhv7YICToou+fViH9ndD18nMx+nzKql9nDiiqH4R?=
 =?us-ascii?Q?RsDFY2XgrTKlaYMuc6N+rzMPapVT7iYEgGdy9VQKZZiR3dSQSL3PTSfa9EOJ?=
 =?us-ascii?Q?VUTkYbJZOZFB96uSNLkFyE++z/fHEHP1d+1bsblWLDyBUu25X+ZSh2u27oCm?=
 =?us-ascii?Q?iE/1v+sX95uX0zlrcil5NMf6pOd59bOvdlRHr/M6M2uFHmVn1eI3b6XIv528?=
 =?us-ascii?Q?biBpjhpzVcdeNNAfBgLUz5pxNRg3iz39z2++JAc+zVrZ8tVwDdJ7J3aoo8Sb?=
 =?us-ascii?Q?WAPEpVDqty7hCZbN9J6himkSR61eAbxdSRh0JiRRA6MBeWHH3pN+6b+hqd/U?=
 =?us-ascii?Q?RNCwLsMFY0MO7uXdYOtsk8iB6V14TPFwHILkSY+y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5758f39-a058-4b10-8645-08da70baf5c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:02:31.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PupFuiFI7hKrpOum3iubGL9DZpa/SyHyJqbvUGPOqq+pXbJZXZG09f+gg5HdjtKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 27, 2022 at 11:36:52AM -0500, Bob Pearson wrote:
>  	unsigned int hdr_len;
>  	struct sk_buff *skb = NULL;
> -	struct net_device *ndev;
> -	const struct ib_gid_attr *attr;
> +	struct net_device *ndev = rxe->ndev;
>  	const int port_num = 1;
> -
> -	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
> -	if (IS_ERR(attr))
> -		return NULL;

An ib_device can have many netdevs associated with the gid indexes, eg
from VLANs or LAG. The core code creates these things

I think it is nonsense for rxe to work like this, and perhaps it
doesn't work at all, but until rxe blocks creation of these other gid
indexes I'm not sure it makes sense to delete this code..

Jason
