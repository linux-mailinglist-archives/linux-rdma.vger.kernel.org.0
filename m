Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87F617D13
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 13:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKCMvF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 08:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKCMvE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 08:51:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9311114A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 05:51:02 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N33XH3Qrkz15Lwh;
        Thu,  3 Nov 2022 20:50:55 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:51:00 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:50:59 +0800
Subject: Re: [PATCH v2 for-rc 3/5] RDMA/hns: Remove enable rq inline in kernel
 and add compatibility handling
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
 <20221026095054.2384620-4-xuhaoyue1@hisilicon.com>
 <Y1wF68CgChG+hM87@nvidia.com>
 <9b50dae1-e448-047b-8a54-489ff120f00c@hisilicon.com>
 <Y1+6j7KwbG9ls/25@nvidia.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <48f9bc6f-9bfa-7664-69a2-20401c282150@hisilicon.com>
Date:   Thu, 3 Nov 2022 20:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1+6j7KwbG9ls/25@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

You are right. This enum has gone wrong here. I will fix in the V3.

On 2022/10/31 20:07:43, Jason Gunthorpe wrote:
> On Mon, Oct 31, 2022 at 04:23:14PM +0800, xuhaoyue (A) wrote:
> 
>> This bit is used to prevent compatibility issues in the old
>> kernel. It is not for compatibility with userspace.  It should be a
>> bugfix. I will separate this into a new bugfix patch.  I will change
>> the name to __HNS_ROCE_CAP_FLAG_RQ_INLINE in V3.
> 
> There is no such thing as "compatability issues in the old kernel"
> 
> If it is used then name it sensibly, if it isn't then delete it.
> 
> Jason
> .
> 
