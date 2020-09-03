Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27925C250
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgICOQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:16:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11104 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgICOQU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 10:16:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50f72e0000>; Thu, 03 Sep 2020 07:01:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 07:02:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 07:02:05 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 14:02:05 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 14:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pli8BiPyPxpcvAD015HORB58N/DSKaNEiTeQ/eJq/6Q6R5zRkx/1az7v1e3iRV61M+4xSGgdZksjayyGxf1bftDvnJLCqXGV2SRx2crU1MrAI41vFNs89DOKUGDPshJ73PzsXMk4UECgcZA8zeslnXxPGcbqZiQsqdyi2Us6FQzUo7ycdajmUVXCDNuHsKrDTN4ETCuXHsCrWN9IcCWirvL3f9Cf1wvg9HpXV4sBXHjsvkSYT1rH318DM2+HuZlCl1ShgMwuSpZ4fOjmOE7Cqa/D8/kQeETjmrRwPXY+YNJUs9KLdVG82u73O1fZv0/edMt0uzvX+RtVkszivyCkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRHB+jezM5jzz/cNkKyPde3ziUDNNYdtZK+wuU9/sjo=;
 b=hBeTT5uvuhoI5Lc1yJthADua0Io3I6RC4KXJTV1XiphgGLyn8/XjCLvb/ltO61b0+QHGrj5cxAN2clbS8tI+yNxMJDv310BZ5Ge4vj9dbGvzny3tkm+AxiO5w9t4vASSgS09AA7oxDcU2PMUKCAz7ed0NGZ+tXzOQv8mUCD6Zbipo6BKwe+k/mBH0eo+djnugcwskF0oOS59h+C/sKmzzEHl84CnFtNv1k6UQatETafJpNygqKP2erP3SctB4BF89V3i3f4PVLsXbogqNcZ35GoEiN8UrHlFFz+AtnHy4RBSAtViBMvFczM0OVNe2v9gXVi3yYd7f9mPcQWoN90RwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 14:02:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 14:02:04 +0000
Date:   Thu, 3 Sep 2020 11:02:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 07/13] RDMA/core: Allow drivers to disable
 restrack DB
Message-ID: <20200903140202.GA1552016@nvidia.com>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-8-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830101436.108487-8-leon@kernel.org>
X-ClientProxiedBy: MN2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:208:239::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:208:239::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 14:02:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDpoQ-006Vm9-Ra; Thu, 03 Sep 2020 11:02:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ffd58cb-39af-4bca-f26a-08d85011efc7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548C1712AE3C2C676699485C22C0@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xN5faZnIRV7gO03I3ARBb61zU/DdJSERWo+WjZe5LESA0FCfgCvAtzRAOcvDTukZWxiuYyvoutd28fJtFeUBe/p2ugQ/05gR/bC9sLmiLrxODXdS0EPZ5ubYFRJcKnndlxbt6+FqRHn6BVtugDdG8QJu0tOpW7h24AuGKcjvA7baMxUSvi8r2pPphpwT/0yBQX81CW9+a4zstxRSOrewMDNAjrw8lEcuyMblDeuiEz7Mou+eRG3n3p8wr9UPbdM9rmKPVgJN28f9HSiG9zAr2B9SKkbgqiL2qzuhD/mjMI0Q4jOUb6uOjotpFAw5wtcojOCiAXbs6miQEENUbY+R/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(316002)(33656002)(54906003)(478600001)(9746002)(9786002)(66556008)(8936002)(6916009)(66476007)(426003)(36756003)(4326008)(8676002)(26005)(2616005)(2906002)(186003)(66946007)(1076003)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hjHORHalgiY/AV6B/UemJZlDctWZa4kddgzJLy2CgY0hQ8nhBD6ngFDfOsGkQsZl1kXJBdTyJyjPizjIFWQUoVZlGj0dhAHl536fMxk1uFOdJIeXTRZQaGzKNRcO8oXg7gZMCURWNuhyvFR/Y9kBoMXkGRQijukrFQsCC70xjfHEXQsr0Lj1+tLq3cUO83az0F7+kqhZiepBcAH4NpnxH6RMlcAu+8tfIHLpmZRu0DjblfJakRrih1sRqGHhNREWTgYiHXz2giRXP7e8CQlRTzdWktuqo/ZzvXuGLF3B6dar6SYAuMtKQIm1TtAdIGuqgGh/80NxdsKE8iENRieFOqUx64NFofONfYxwFf7093abRVS3tpXhSXj2PEPjShR5JQ6rW6AMp1a1kGqMBjDKA1gnrYUz5DwhIp+X18tvGHmlPkNYIBK7L8ZYbtwZ+zotekaCWut5wqgoKK6aYuWodR8buzSj6vYQt6SUFDyZtEX6f19EvBUQKfRdj1AlQj6IO8fZJ7O8kszLps8gYUpwvwkLnso1xb+3Ktwnf/J6BgSu88C3VJn18EBI39FCuzmOBwU49FpGX4Qeo8AcVgqJrzwiCZw0THUgSrUc0jLBggAKIrNiiO5qjHh0tzgPqNxflsCyIE6X6Vf12JXNZF8gig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd58cb-39af-4bca-f26a-08d85011efc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 14:02:04.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FilLwSRTMHDbw5pEUc2nuQ67yw3R1rX5XpIwezV3TTqS+0vbwDOzGu4QhYkgSbVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599141678; bh=tRHB+jezM5jzz/cNkKyPde3ziUDNNYdtZK+wuU9/sjo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=XTyCVhtE3Bis/PLCa8sVQqNQhA/BPTJDBvhJLq2oMAh6lhVNxjHXBLk0M1OB7BvKu
         kRbwWhNsSYfYq0iebUzEIz/VBEvwyvHTcOwaWqx7xnj3qGX6/QWummVrFoaexZrLsU
         ZW4c4jeK75LpqM0IgT87o8XjKoXJjEUIJ8CZmpXYEN+l6G8Fa3oS6aeRpR3PinkOiE
         9iBs0TMImzpIlPmPdWGqKhFYl90ubtjdLxhRrmYTMy2k7tTmF7jSy2ATPygTwJzSZT
         wSxoQDvz7hi5zPS4D2iyJrDCwdLXGC/B+dASdQMPB38eM4b2P7/9ppz1ot2dB9vbf+
         pMjagM89+rrdg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 01:14:30PM +0300, Leon Romanovsky wrote:
> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> index 10bfed0fcd32..d52f7ad6641f 100644
> +++ b/include/rdma/restrack.h
> @@ -68,6 +68,14 @@ struct rdma_restrack_entry {
>  	 * As an example for that, see mlx5 QPs with type MLX5_IB_QPT_HW_GSI
>  	 */
>  	bool			valid;
> +	/**
> +	 * @no_track: don't add this entry to restrack DB
> +	 *
> +	 * This field is used to mark an entry that doesn't need to be added to
> +	 * internal restrack DB and presented later to the users at the nldev
> +	 * query stage.
> +	 */
> +	u8			no_track : 1;
>  	/*
>  	 * @kref: Protect destroy of the resource
>  	 */

The valid may as well be changed to a bitfield too


> +/**
> + * rdma_restrack_no_track() - don't add resource to the DB
> + * @res: resource entry
> + *
> + * Every user of thie API should be cross examined.
> + * Probaby you don't need to use this function.
> + */
> +static inline void rdma_restrack_no_track(struct rdma_restrack_entry *res)
> +{
> +	res->no_track = true;
> +}
> +static inline bool rdma_restrack_is_tracked(struct rdma_restrack_entry *res)
> +{
> +	return !res->no_track;
> +}

Are these wrappers really necessary?

Jason
