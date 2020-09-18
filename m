Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3977E27094D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIRXys (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:54:48 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21899 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgIRXyr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 19:54:47 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6548c40000>; Sat, 19 Sep 2020 07:54:44 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:54:41 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyb64Z/tkVg4RJd6/psj7e+R7E5XN/k6A7WK+ld51EAC8QmYW3cdu4xK/wtjiYXQVV69gjGC9dtqv7YSDHT+OnBH0slHfyQ5rAGCYTcq3m0TOyg0skdV1fGlqLHkEiMaeZoFU4q48zdCWLsCGfma4kH6vThga1HTOdO0W4ymW7bzGmqAh94npb3FQFYwLUCmG+g+ogYVMTlrmR911DIZGPKj5iZQM6hwAEx5MnuEc/E82IYRY2slJXWpoiDZhZlbI3mbTY6EJubAQ1RAk4XqsCjiiTiXd7A0y5z2+dUOQgaTz5TP4f+QNqEiNfA+9kZ4wMP2kKZkRUVPB3MW5M10Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a5VQKnp3qPuWTJCMvAZyi+wcjGq0yiCKiPIAtLfzjk=;
 b=nY3KVQ//4thNaTj3wXd1ZEFgiPs6EOhzZ7cBg1wp6CxWWHLWZGBvki9KMFOsVB6zs6Uz0KhvtKmDap7sTMox8aE/jbS0PcVu2Up2WktJzzASIjiF8h9eUZir+c1qcM/n7jyzqWvgTRDMU1LV7QUyr+kNC8tJuxpDXirjNSn/b2BH7H1qKNEcNYUMheTdj44zDfGu1yTgA9I8HPTzJrdLK9aqzWXQN79DiZWmPISWqA9EUxIdW9cgUTMP3CTBg5ChJOE/yIqsrirP88xnumvPy1TZyqsIV4V3RSvO/Opl3XRw6on93HN9UnbYepXMOUVcxDbh7wZ3rfavSssWmUZ49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 23:54:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:54:38 +0000
Date:   Fri, 18 Sep 2020 20:54:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Hillf Danton <hdanton@sina.com>, <linux-rdma@vger.kernel.org>
CC:     Sean Hefty <sean.hefty@intel.com>,
        <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] RDMA/ucma: Rework ucma_migrate_id() to avoid races with
 destroy
Message-ID: <20200918235436.GA453065@nvidia.com>
References: <0-v1-05c5a4090305+3a872-ucma_syz_migrate_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-05c5a4090305+3a872-ucma_syz_migrate_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:208:e8::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:208:e8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 23:54:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJQD6-001ts8-H2; Fri, 18 Sep 2020 20:54:36 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 754d42ad-c005-4d75-4c4b-08d85c2e339c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35949571820264AA0D870D77C23F0@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 514VJkB3vPZF+SC6Ie5Wa921dgde3Vk5JuFqwNWlRcdvn8eAyXFApHuMJM5E6uYXi9wZ5i0/uUomnCh3mDJxyZ6ce9ZtR9WDeTv4FPpIbVgi0h7v9iNN/CeaOO7BAUoHXV8LD+cBRgqiNyZrTuRcTUS41QTm/fhVsq2rq7ylUEk2XhGLX+e2CrIIxTmNO0BRmabvr4CYelLrtxC9UqzE6CIFquj/i9WQANzKQ7JKECrDrjMsyWB5W8GME3IziR4BRHHm/7uKJS58sz7nJHKIZGaUAt780Q/M1XryTs+h+2SiY+z3v4gDTl1O/QLBe9aTVHVE9yuK97jOKaMy5FlUQM9mWVRrC+Dx7iDQLuE/Z4TEQ2jBrpRSO9vs9GqXPyWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(9746002)(9786002)(478600001)(83380400001)(33656002)(26005)(186003)(2906002)(5660300002)(36756003)(86362001)(2616005)(316002)(426003)(4326008)(8676002)(66556008)(66476007)(66946007)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W0cra1z9TJF8RgZUKi+WlEQJTkCAcIyDfEWIgXmpsiG+lOrJOUFyAFqmTgEK4PerrfborCzlAmxelqB5vsP5uD4bqMVPXqRwBGQcRBgHELMuOaYOcVq9t7tXsL59JpNut6hZUtJ7cyM4RMObP/L2LSYE2eOVp+vW5n5oBvOvaYdr/E3R5F4sRjguwHAdgF+ig0DBN+f+r8Kc5X0pUY13h6pRo8HnyDxExdsfHVArMrkBj7sFz1nmuUhtmn7HW8z22J9uVO/ip1cFfoh9ftRJnO70s/V19hIMVlWz70tB54kmD+OEE0LMEo4gHPbjtjILA/FBkKyUAElmaglvJOP/f2jMNn+EU7OgPnkkn9aAtGlZQ46t4W3zF05UbHHlR8ixdXx2/qt+eBgflyvLvgdW2Y0mSFdc1Lz6U9t96ecM/pceWMUOxQBsb/1tk3XP8XbD2rJ4/duZJKGBnRV2ZyeP2EYL6QOkAKrnNfA10vH0iGRXS2ErdOv0qkZ24Q2XM1G/XeMS8wvuyl3VX/P8+aoL88gMUFxfLBjsNiL4DnEnjs7GGMFZOrEwShkv/pzJfp1sAmwl0fAaRmhrA/OWU7gjWuh+SOr5h4fg5sYppXAHsXCmUPZZzgdmbuSLjZ/hjxzBWuua1SdzV6WT47aGvr6cdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 754d42ad-c005-4d75-4c4b-08d85c2e339c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:54:37.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW8vS9dhWbP1Dd6ZIxYCu1n3z0Y0GXroNzVzAqh4cdQMeODmPjfTNpi/k1ki/4ur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600473284; bh=+a5VQKnp3qPuWTJCMvAZyi+wcjGq0yiCKiPIAtLfzjk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=LQruXlDFkY39XLIvGsfsx5n5tojftEm5yii/3y8xw+PpRVpmWhtD7WQHRXne3+3DN
         1fOPs+r8fmW6VZy2IK/yFPqQnU6xoxU+z+ie+JQ/sW95dZBrIuz49V2ZaGj3+SAgAB
         ng45pYWEEhoH/nmgsJcBFmv33wApEPe0C3cjst4bHlw5m37EYLHIOGzNjcvwQdfquO
         fOnnswSRpq5H+YZ6o1jr63tqeGYRllwujmnEnaWRQkp28NF+BIIIMJ0Vb4ix3vZZVE
         otxd4Tspq4jUeo7XiM653ue6m+9NNATTazpFnYyPoaHYKMfHbK5PZzlhAHCfVRTRCb
         kSHVxb3Vh6D8g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 08:59:56AM -0300, Jason Gunthorpe wrote:
> ucma_destroy_id() assumes that all things accessing the ctx will do so via
> the xarray. This assumption violated only in the case the FD is being
> closed, then the ctx is reached via the ctx_list. Normally this is OK
> since ucma_destroy_id() cannot run concurrenty with release(), however
> with ucma_migrate_id() is involved this can violated as the close of the
> 2nd FD can run concurrently with destroy on the first:
> 
>                 CPU0                      CPU1
>         ucma_destroy_id(fda)
>                                   ucma_migrate_id(fda -> fdb)
>                                        ucma_get_ctx()
>         xa_lock()
>          _ucma_find_context()
>          xa_erase()
>         xa_unlock()
>                                        xa_lock()
>                                         ctx->file = new_file
>                                         list_move()
>                                        xa_unlock()
>                                       ucma_put_ctx()
> 
>                                    ucma_close(fdb)
>                                       _destroy_id()
>                                       kfree(ctx)
> 
>         _destroy_id()
>           wait_for_completion()
>           // boom, ctx was freed
> 
> The ctx->file must be modified under the handler and xa_lock, and prior to
> modification the ID must be rechecked that it is still reachable from
> cur_file, ie there is no parallel destroy or migrate.
> 
> To make this work remove the double locking and streamline the control
> flow. The double locking was obsoleted by the handler lock now directly
> preventing new uevents from being created, and the ctx_list cannot be read
> while holding fgets on both files. Removing the double locking also
> removes the need to check for the same file.
> 
> Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
> Reported-and-tested-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/ucma.c | 79 +++++++++++++---------------------
>  1 file changed, 29 insertions(+), 50 deletions(-)

Applied to for-next

Jason
