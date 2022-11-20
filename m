Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECC631463
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Nov 2022 14:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKTNgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Nov 2022 08:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKTNgX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Nov 2022 08:36:23 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B157D9
        for <linux-rdma@vger.kernel.org>; Sun, 20 Nov 2022 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668951377; i=@fujitsu.com;
        bh=GRMH4IKOXldl4P5CmjwNPTm7e49GQ9/5qHNzsf6SVtQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=rqLGTO9t0flT4xqiCkPMw8zkCTjEq0OovCcB5nD5ZjHztXDbaIAtmYXOeLvSF83wN
         V7GjsLIWn0iI5KESqqz74iclSyfvwffKN3KLRVPcVVWHywWRVaQU1FMwE+5TOTUKyk
         6oBIIeb0WCvrGxx/Systk75kb6wZ312HrvyeosT6aa2wVofPdN0K+uUyAdy3Rk66ZQ
         uAdkwxMxAlJu10OYYiUxVF5XM4BlJwtTA5pXKtrOZa+nvAfl+8fc+GXidu5JNLGpEI
         IImz8tphhxtn+cAcD+oifl5D2kSHJ0E85aY2xU0X8Nw6sQ9cdv2PXezGKI1NkDG4Le
         Pt0lz1jFQKSAQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRWlGSWpSXmKPExsViZ8ORqBugW5V
  scLjbxmL/0+csFlf+7WG0eHaol8Wi4S2XA4tHy5G3rB6L97xk8uhtfsfm8XmTXABLFGtmXlJ+
  RQJrxu/LbAW/GCv27XnE3sB4irGLkYtDSGALo8T8DV3sEM5yJolrj5rYIJxtjBI3b/9h6mLk5
  OAVsJP48eQGK4jNIqAq0X9iJStEXFDi5MwnLCC2qECSxNUNd4HiHBzCAg4SHXc4QMIiAioSJ0
  6cYQcJMwtkS3T89gEJCwkkSCz5cAqsk03AUWLerI1sIDangJbE/4ctYNOZBSwkFr85yA5hy0t
  sfzuHGcSWEFCUaFvyjx3CrpCYNauNCcJWk7h6bhPzBEahWUiOm4Vk1CwkoxYwMq9iNC1OLSpL
  LdI11ksqykzPKMlNzMzRS6zSTdRLLdUtTy0u0TXSSywv1kstLtYrrsxNzknRy0st2cQIjI+UY
  lXlHYxflv7RO8QoycGkJMq7t708WYgvKT+lMiOxOCO+qDQntfgQowwHh5IEb51WVbKQYFFqem
  pFWmYOMFZh0hIcPEoivHPVgdK8xQWJucWZ6RCpU4yKUuK8YtpACQGQREZpHlwbLD1cYpSVEuZ
  lZGBgEOIpSC3KzSxBlX/FKM7BqCTMG6YDNIUnM68EbvoroMVMQItznMtAFpckIqSkGpg8Em0i
  rJse/eZT8K6O677zgDmlvV1bWuOH3BkRD+GiZ4mix8tvMH2Yw/65W/GN/sSwdWlz3y19JPF1k
  enTt5tnPrq1bdvs156tuQy/cmS3m8jVLXy04v7L5V9ubj6WtDPIeGurXeOaf+GbNG8d3b9rwf
  4fXFs0o1VO7/d4HxO8VTcuOkf53Pspiupb+HkKcmc959m/jfVlQalV+WQ7h93+1qY+ol0G1Xm
  Xbp7wW1IgfsBHyUvL0sSn9OS2Bq9zJx93PtglIVnO9eD2+s/PPRzLQsoNxP/GLPkaGH15R6qj
  9oe1wrZZU7e8ZspwuvdvBqtWt5ZTjon7nccne5c+/hVkbusfLZdyXO3R9qIVvY+UWIozEg21m
  IuKEwG+soNtigMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-13.tower-548.messagelabs.com!1668951376!101966!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5225 invoked from network); 20 Nov 2022 13:36:16 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-13.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Nov 2022 13:36:16 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id A9B9F106F07;
        Sun, 20 Nov 2022 13:36:16 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 9DB091035F6;
        Sun, 20 Nov 2022 13:36:16 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 20 Nov 2022 13:36:13 +0000
Message-ID: <02a3f112-48e8-adb6-b4d8-46d146761b4a@fujitsu.com>
Date:   Sun, 20 Nov 2022 21:36:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Remove struct rxe_phys_buf
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <ira.weiny@intel.com>, <linyunsheng@huawei.com>,
        <lizhijian@fujitsu.com>, <linux-rdma@vger.kernel.org>
References: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
 <Y3gvZr6/NCii9Avy@nvidia.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Y3gvZr6/NCii9Avy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/11/19 9:20, Jason Gunthorpe wrote:
> This almost certainly doesn't work, but here is a general sketch how
> all of this really should look:

Hi Jason,

Thank you very much for the sketch. I will try to understand it.

Best Regards,
Xiao Yang
