Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EC274743
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVRJ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 13:09:59 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54594 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIVRJ7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 13:09:59 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a2fe30000>; Wed, 23 Sep 2020 01:09:55 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 17:09:55 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 17:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDkbNsHcMipAgIfSHWsBAUMFebalosT5CQubPDaE3Fg+w9o8VixIT3XBbL4Zi/ioJv9h91Ucg+hxB/HfX6Pkvu1tWoQd9mx1qgT8cuLUaBz0XvjVnpOdpqrcbG2xOUI9JL6iroNZ8CSwG/cRG3bY1+PMhxaJItiB5JzCIZVnSe9I4VcdSKj1QwbgB5JlS+rc0PEagaBgvvCr+aJdXO7AJjn/4nHF8m6sVrruO6LIbvlm3nX1GXhtN3LDXquH3iNP5OOX/TedgjRp+X5IlkolLajfBJ+Afvfv+RUbHBdj7WI0tsbvc3EoU9ZcbecIZ7cbextDHo6c9AGlh+hyiuRbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj7M/NO4GBDFFC89lk2MYGYySIlkifVCZQzXVEwNde4=;
 b=Bf4+xfyYhKuBW5M8eR8GlWVTl9hSYsrmuhNebep48HIVFTPtpp8PkAbHXebYy5uKwINOF4UHw6lA8dJksJvSK3Pds6DJ38hnxXL3ZcLA0Zs9Oio43iALSjOG10L9MtF2+mn7l4MzSxm0qr8rTvetyRr7z5rMcfMJi/ZtTx6ROTyNlVUdBmz7iDlV3HQ2b/Qr8IdK7LHfp8OuxTv/fQP5hZbkilK+QDnjQitmPoYFRFm0RsTeXoX0ML6lkqEohZLMoZZv8J+HKWx2Kphl5lNOMFCmdvEoZnybOhJ1I0H70Afav77hMfZw+3gjcM3hY0hZSgkAutdjrqqCEak36npjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Tue, 22 Sep 2020 17:09:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 17:09:52 +0000
Date:   Tue, 22 Sep 2020 14:09:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Aloni <dan@kernelim.com>
CC:     Leon Romanovsky <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: RDMA/addr: NULL dereference in process_one_req
Message-ID: <20200922170951.GE3699@nvidia.com>
References: <20200922151348.GA4103095@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200922151348.GA4103095@gmail.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 17:09:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKlnb-003Cbz-9L; Tue, 22 Sep 2020 14:09:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d433ea48-687f-4e27-9e96-08d85f1a51fe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15453C6E32F1D7FB8FF9A16BC23B0@DM5PR12MB1545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+Nvj0kkEe/VI9Sc4X//Up/PigJfI4BHbvijVwlboJa06zLrgfjqS41DRBYwg11HHb+zHobuuZh/AhA38SHtpNCxn1yNYGTAT4A31V4+8il04XZ0hYXRZH1hEFHya9Zk98AzhfYlhHVR9IcUxJZyOaKq+sBmkEQSg61w66+N+6Dl5GfYoglRvwLkkS/Hp/C7tkto6hQoWVDZPM2NxTSJybz5riXmclmwXyprAvTp4HKlfdiLXOIqHrj/mTXlyuWobHmO+Ar0zofa9ieKwc5RtEjYgwSIs3O9S0YeZh9fexU8NWI4XE1uCwrVDPmv+lfTwN3rax4sJCj3kUPwfg6x1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(8676002)(9786002)(1076003)(86362001)(6916009)(9746002)(66946007)(66556008)(66476007)(5660300002)(186003)(316002)(33656002)(8936002)(2906002)(53546011)(36756003)(426003)(4326008)(2616005)(83380400001)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IE+gFDhRgGXhtainWCn9EXxekvKRzN7Bnvl1xsg9ZMCoHr1uLqhz1Pa18n5TlMHfOcTxg8YHDMeKEa+X67olH+476BqA6ERfP9tBhMX5v3SpmsucOSqPx2jR5KEMJKIjxMYiNS5mDtK/Iqy3BQZYCjsmVfuytOIqBvyBIwg6pVp6PxdsTPdx/wovhwGlIHlODBxxB+6SSvdrVGAQExdP6Tl1mGKFpTVuBYc5/xc2ao5eY/6UAwc7U4PruOCb5k7R+KloccuMvwl/Cp/FOFfXQcRJOTDMU1IE4uL4Pjm57syXnYpAi0lWDWKWrGYANx824MMB1tJdmJFcVLk4uph+Vg3NV+hG1uLnT55od13M5Fo0TouUTLO6IENBKx0KqXw7O5p54wYT8K5SK3+t6EmxusWW/JAR8gX+FnoKB8IhVSKbO9Cm4Z2dY2uvt5lX2IuP42u6NqUEAzB6bLhLyZxybbPUMI8YavsiBgciNAptXC3qe9JUM4f7LXLOhE2uw1joqD77aYnZJaSmKkIeo+oxBo5ZUJk8PEmJulwV21KPBUTr5xiVjPpumgC5T+nF/LpROo/WLyHOhVAgnnL+kwubc5pdigyYpruLHEmdx02YrKWg3/rzqUZbNjvMtKJqLzNizOzhVok5wiKFCJDcZayvMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d433ea48-687f-4e27-9e96-08d85f1a51fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 17:09:52.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvcHh8VVSysN8x1J5LZiYjP5OmNk3r2Tx9xOxbcR7a4U8EeLe5QXiiCEpeCM9le4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600794595; bh=Yj7M/NO4GBDFFC89lk2MYGYySIlkifVCZQzXVEwNde4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=QAkTT8wKZuqPXeLbyYkGh8TDXS1qkxW64PmHjnpWWhSSaTSo7Ohfm7novK9Jvhnqe
         phTCT6fA7rEowE6xFnkfyS4tnEw7jvbhZnOIHMU97JNerbrJbAEDfdjlYoJda725JI
         UHFjk1pAV7T1h0YnqVqblGF2Vza/dUCMrMq702eRwpmOb5US1KwhrFcLYUIwCV3Q+P
         o687wHlih0fwefXpOW8LmczWSAT6Zelm7rkSb10IAUpura5EPHAnzrZhAFUu++g9AR
         f/gunATWIPR8a9DQiFiHQ94WPXyHgWD2t9U2kGMySN5C1iRqNj4p8FiYnE+PxWOIrh
         WvlVCUSn/ay8Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 06:13:48PM +0300, Dan Aloni wrote:
> The Oops below [1], is quite rare, and occurs after awhile when kernel
> code repeatedly tries to resolve addresses. According to my analysis the
> work item is executed twice, and in the second time a NULL value of
> `req->callback` triggers this Oops.

Hum I think the race is rdma_addr_cancel(), process_one_req() and 
netevent_callback() running concurrently

It is very narrow but it looks like netevent_callback() could cause
the work to become running such that rdma_addr_cancel() has already
done the list_del_init() which causes the cancel_delayed_work() to be
skipped, and the work re-run before rdma_addr_cancel() hits its
cancel_work_sync()

Please try this:

From fac94acc7a6fb4d78ddd06c51674110937442d15 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Tue, 22 Sep 2020 13:54:17 -0300
Subject: [PATCH] RDMA/addr: Fix race with
 netevent_callback()/rdma_addr_cancel()

This three thread race can result in the work being run once the callback
becomes NULL:

       CPU1                 CPU2                   CPU3
 netevent_callback()
                     process_one_req()       rdma_addr_cancel()
                      [..]
     spin_lock_bh()
  	set_timeout()
     spin_unlock_bh()

						spin_lock_bh()
						list_del_init(&req->list);
						spin_unlock_bh()

		     req->callback = NULL
		     spin_lock_bh()
		       if (!list_empty(&req->list))
                         // Skipped!
		         // cancel_delayed_work(&req->work);
		     spin_unlock_bh()

		    process_one_req() // again
		     req->callback() // BOOM
						cancel_delayed_work_sync()

The solution is to always cancel the work once it is completed so any
inbetween set_timeout() does not result in it running again.

Fixes: 44e75052bc2a ("RDMA/rdma_cm: Make rdma_addr_cancel into a fence")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/addr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 3a98439bba832b..0abce004a9591e 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -647,13 +647,12 @@ static void process_one_req(struct work_struct *_work)
 	req->callback = NULL;
 
 	spin_lock_bh(&lock);
+	/*
+	 * Although the work will normally have been canceled by the workqueue,
+	 * it can still be requeued as long as it is on the req_list.
+	 */
+	cancel_delayed_work(&req->work);
 	if (!list_empty(&req->list)) {
-		/*
-		 * Although the work will normally have been canceled by the
-		 * workqueue, it can still be requeued as long as it is on the
-		 * req_list.
-		 */
-		cancel_delayed_work(&req->work);
 		list_del_init(&req->list);
 		kfree(req);
 	}
-- 
2.28.0

