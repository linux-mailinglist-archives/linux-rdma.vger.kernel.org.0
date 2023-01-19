Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52521674088
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 19:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjASSF7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 13:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjASSF5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 13:05:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779ED20044
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 10:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdzmjsqrlI+Yv0HOO+BbCBzXkycJUkZKJKcUcnfBNH7MAEzmZ3bx/4rWNLBUsrnvmkmVO5+04Mu3Lv06UEN5m79QQ3KOpeeUtjXkjx5VpQlHnpJXDrzKW3AWijYFTZnzTjpoP5T6wMfR25p30KFTj6LXXY3ctxeu1qK5fST6iIO45PyiqOgIzqwANhAIraJacTRf0+ULimTh5/T4f+bKJS9rY1fRdyVccNmpkL2I+RYiw6fKcqY5eHirE6k6wUiqTahr4JpDHMwMgZJ6JyDb5m4PJ4V5+6n8NEqXsrIcbotkP3iCjgCyX+4WUIysgFMRB8ztU2jJ+MutV/JT/t2bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1QdT0aB1vmDAMT7c1lraXMXKnQDhNskXLuwSvoRTu0=;
 b=c/bynKEcHFuW3gTYWy3dVIEn39hgGaSD+1R32KPC0e1W4RxOBWDdbit12BNGYkXdJha5YcPXN/OJF1f7TGdP+k4Uw9ObHRQd1Pj9dLPr1lGH5fYagKkPptLRSosvvaEw7JghiTS6k3uRcERXBeaHFtPx5UAk2aFoQu3OcyvUdpYx0o3rwFzCb3GqcbD8iXyP3HVM4mdLwz+xk1sja08jDAnBd/PbS4JPbIJDbir9g/WY3OFevKaHjvSC6R46Kkep7IH15h1KmD9bcOzFFub2wkh9xZ9RVwBUHlQmvQOTsd4eM6o9PZbo4bLSlAjWnprtCHHp1F5TeR7QSJgrkwqNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1QdT0aB1vmDAMT7c1lraXMXKnQDhNskXLuwSvoRTu0=;
 b=YebpzEn3vVv/BKiyQNnYBN1VpWc0uV7Zt2VilhZvDFrzF2izMhfl4GBo0jUKHuCQIIJL4wGkHM9d1kO4GcQlEkgSiQQNG006BTJZityen/VP53oxOY6ErM1gQmdB28ulb123m6FB7HtNhicx06eUaE88AUDy+9pQa70XT3zUxijMFn4O3nN97kX0dAV/Ctu0acYPasb+7bV5mzBlgUAyBnO/cXvU59pgg7EKigq7e4hKnrI5dZnM08fwxr//zQh6eqkWJSHeWts8+JLp5vy3HRGCzblJAOnCAwojifWxRuCz6O4WLcg8Ix2T04F41MeYehse20eEHyQSyaJq3J83Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 18:05:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 18:05:53 +0000
Date:   Thu, 19 Jan 2023 14:05:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        leonro@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer
 invalidate race
Message-ID: <Y8mGgZqh90M6OfE8@nvidia.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
 <Y8VwHYPYlV459T1j@nvidia.com>
 <a4027240-b711-bd11-1f42-c16d53104f6e@cornelisnetworks.com>
 <Y8fpNLbRuT3UMhJK@nvidia.com>
 <90652c2d-a874-fb24-3356-55c9b7003feb@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90652c2d-a874-fb24-3356-55c9b7003feb@cornelisnetworks.com>
X-ClientProxiedBy: BLAPR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:208:32f::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b7c6a3-3f46-4a86-367a-08dafa47ce3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIvfNCl48o4jH/UBl2Ca+ojwDhDocATIrMV1piqVr0PFtng4ZXfl2wftsxcw/bSS5TYC9s2sA/NweAhpU+1qzpAec/K0eW829FvN3pIZ+SXSkOEfql4V9Z+zLkav2ASpLmgbZ9MhZc/rHPgHgmQo49KiB2I+P5JdNjBW/ylG+ylbEIk6gGfwaN0QDjB8XykTK2ncp0+G9YzOxFuyPj5wze+bT+V505vhoEk3sFAcGnatM5A1W+pUmLi91lcSE5+h3yzXnAzNJgs8X6Uog7dwNBLIR94ZoxZn3SZ3XMxhCUXO6et8d1OY8Y7Ru4EkjsNn5vGxXrDDqbp283yoUKQpBZBQD4SUzy0WaW5b3obE9FXOfEKjtLiyYJRsr1AzyvIARo7fXed7RlxsXeEb6wqStHw9EmgYOhCvOSb5yMXNX+qUWm8G4IrzKYgFj0K+HoSoOjI5feLnU36SScxAg2HFDVOKIiWayUzkwCk9u9OzmUg85tR5GgEw3FWBNSAUwVbD2OT+55XJ3rsQV+1z0SdIrctFNQDAFBQk62UOSQCE1IS3XYFrdSs4l7jeHaNagj5EKOCSvDmNuPSgBjIsBjUGcDEvp3R1dlya3qhMCqB1jhhNnFibiumFB8KFuxWLtvIc6IwoItMGOf25GNE7jk/KVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(6506007)(6486002)(66899015)(478600001)(53546011)(186003)(6512007)(26005)(316002)(66476007)(8676002)(66946007)(6916009)(66556008)(4326008)(86362001)(83380400001)(36756003)(41300700001)(38100700002)(5660300002)(2616005)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iF6Xr4rLSSDlEx5T0xNJqnpHnsuHAKVWmqLSydj7+a1CPiC3f0VvQ4VYkzXF?=
 =?us-ascii?Q?6eYx/QOpwlfLh/DgS35PHnsN0zliwxlH9TgL1ZbLdcZP8hMtB3xChSUP7N8q?=
 =?us-ascii?Q?YVRKxNbnKJBa6QDGvZWkLk3dyU8NzO5WLQRp+43cR/C2cdBhb+Tjq22MftYb?=
 =?us-ascii?Q?2JbME8jolajObSNIcopg1ObaKYU+VTUQ4kt9FQ6jOCRIzkbOHg/G2j+j89uV?=
 =?us-ascii?Q?qgoruO/L7Z/E5GgBi9FMat1FaTS3r/L7pcA8f1kAIpbl8j1aYEbeNzNpIYN1?=
 =?us-ascii?Q?t/OjuECHGc4ZGOv8g+WihpHAyxlrllLFgv5Xumw7v7uVpPurMZLeo6WNfBuH?=
 =?us-ascii?Q?Ut9Ov8UJSv1XDqPSrN9l/SMPcQFKEUaeEMzXWSM+LrnWUicutaWl35g3wlxJ?=
 =?us-ascii?Q?2LjsNrhuouTogrsXGeMnSoXT1RJgOLMbUyejP+FyiI1TFGWSm4GemeETH5ek?=
 =?us-ascii?Q?agH6PlYOyt9GFddX80skT5m7QytrGnX7SUco3o7dfbx6HADV5EyARzd2rU9o?=
 =?us-ascii?Q?F//3LA/hlsfJNQcDUfl27GT6NyJascEPDP7DQUeJ89CXbxNrkasYFfDMBTbJ?=
 =?us-ascii?Q?LxMO5k9by3qiRZyWhBEKNERJyGyzE0Xf8kp+sk5bQeaJoSDwEUbPhbiD/Sdd?=
 =?us-ascii?Q?FXbQwD+lVnHcNxNuS0ci4SDJ50MJr27F+jAS84fwK6WdJBgx/JLJBI7hrgrS?=
 =?us-ascii?Q?4TzE8MqWIJcvqWy1dnIHuP9MeY90oINjyiP3NgDsh1xK7aFa8qnPFWGv7/Cs?=
 =?us-ascii?Q?zqT37t96RQZqeR/q2nsUES9t/CRo6EdZsW1/H++zpCtTQ043iQWVwXt5eBo8?=
 =?us-ascii?Q?X2ctfx/KA4iMxzU4P343dto6B+hVXFv8fgiul5OZX4bSRnR+wc8/kDycPzuf?=
 =?us-ascii?Q?nXSNO1W65JEVo2mQS2fFslWuLC28kaAQFHZFZbDF6t5wp0D0Cm7Ls4i/928p?=
 =?us-ascii?Q?EIjg78IyjcT4CrTbENwjuzIjIJEqbjTWWMWuCaLWgMQaWVZ8TdXCkQmXPyIO?=
 =?us-ascii?Q?rZqJR5iGqfMJg7eKGnoxlu0ia3N1pkW6F4QrSNOdzr2EgYr2kfNykaRnBpSf?=
 =?us-ascii?Q?xb8gJY5n3+MkWgtOogkVwVSvxxQd7JGjwcghtD3fL8j1rHPqDj42dnTS32h+?=
 =?us-ascii?Q?4E6ROiizDVtYOLLOGDE5TTW1Lu9M92B7ajyY2AccEdrTC42cpOpUNzjoMqNW?=
 =?us-ascii?Q?BgYhVoqZjIL1p3txwCGzl2wTQUx8smEKlStotAVOBpTIeUjRwkLazZMj2Hxh?=
 =?us-ascii?Q?bFzmMDTecm9pchHUePONd8LxoaEyoOcjkCkXUxOQlg+a2aM0hzBAZZ2Szo5i?=
 =?us-ascii?Q?Bl8TD9cWq7P5QXsnTnrjZZRI3V/2eU3nCH/NmiXu4Cx7zW8A6LcRoBVcRRJn?=
 =?us-ascii?Q?lxd9ZuxDruH2NU07PVFIub9MkaM065g4o0dhXICZgNdb8kY8lLBPsz6D7Pvq?=
 =?us-ascii?Q?A9cx6dMlvkj55Eg8hhBhiehhHD2xBOQfXTe2hcWLAxTkx/hKxMv8W6dKJ5rG?=
 =?us-ascii?Q?6HiB6GwRlF8jvBLzUL/61VFMCXGKCYN7nLWOxHTcq81/co5oSwCdomi5ysxX?=
 =?us-ascii?Q?AUKd8msmQS66gs+XUmzmzusV7OKsWWkKh+ZOJE6K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b7c6a3-3f46-4a86-367a-08dafa47ce3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 18:05:53.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXH0VdLq4VjXEMpvf7kS6Lb2OkHHoQ9n5r4DkSWXQ8ZyZvmzrLAW21cseCmqnxnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 19, 2023 at 10:00:39AM -0600, Dean Luick wrote:
> On 1/18/2023 6:42 AM, Jason Gunthorpe wrote:
> > On Tue, Jan 17, 2023 at 01:19:14PM -0600, Dean Luick wrote:
> >> On 1/16/2023 9:41 AM, Jason Gunthorpe wrote:
> >>> On Mon, Jan 09, 2023 at 12:31:31PM -0500, Dennis Dalessandro wrote:
> >>>
> >>>> +    if (fd->use_mn) {
> >>>> +            ret = mmu_interval_notifier_insert(
> >>>> +                    &tidbuf->notifier, current->mm,
> >>>> +                    tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
> >>>> +                    &tid_cover_ops);
> >>>
> >>> This is still not the right way to use these notifiers, you should be
> >>> removing the calls to mmu_notifier_register()
> >>
> >> I am confused by your comment.  This is the user expected receive
> >> code.  There are no calls to mmu_notifier_register() here.  You
> >> removed those calls when you added the FIXME.  The Send DMA side
> >> still has calls to mmu_notifier_register().  This series is all
> >> about user expected receive.
> >
> > Then something else seems wrong because you shouldn't be removing the
> > notifiers in the same function you add them
> 
> The add-then-remove is intentional.  The purpose is to make sure
> there are no invalidates while we pin pages and set up the
> "permanent" notifiers that cover exact ranges based on sequential
> pages and how the DMA hardware is programmed.  Once the programmed
> hardware range notifiers are in place, the covering range serves no
> purpose and can be removed.

Uh, that doesn't sound very good, it is very expensive to create these
notifiers, they were not intended to be overly narrowed like this -
you are better to have a wider range and deal with the rare false hit
than to take the cost of register/unregister on every activity??

Also I'm not entirely sure this can be race free, having two notifiers
responsible for the same memory at the same time sounds like Danger
Danger sort of situation..

Jason
