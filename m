Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F052246E999
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhLIOJw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 09:09:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28295 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhLIOJv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 09:09:51 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J8wmp6XCBzbjQG;
        Thu,  9 Dec 2021 22:06:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 22:06:16 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 22:06:16 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Fix RNR retransmission issue for HIP08
To:     <jgg@nvidia.com>, <leon@kernel.org>
References: <20211209125241.4252-1-liangwenpeng@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <cfeba997-ec7a-10c9-d5af-34e8fb0457b9@huawei.com>
Date:   Thu, 9 Dec 2021 22:06:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211209125241.4252-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/12/9 20:52, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Due to the discrete nature of the HIP08 timer unit, a requester might
> finish the timeout period sooner, in elapsed real time, than its responder
> does, even when both sides share the identical RNR timeout length included
> in the RNR Nak packet and the responder indeed starts the timing prior to
> the requester. Furthermore, if a 'providential' resend packet arrived
> before the responder's timeout period expired, the responder is certainly
> entitled to drop the packet silently in the light of IB protocol.
> 
> To address this problem, our team made good use of certain hardware facts:
> 1) The timing resolution regards the transmission arrangements is 1
> microsecond, e.g. if cq_period field is set to 3, it would be interpreted
> as 3 microsecond by hardware;
> 2) A QPC field shall inform the hardware how many timing unit (ticks)
> constitutes a full microsecond, which, by default, is 1000;
> 3) It takes 14ns for the processor to handle a packet in the buffer, so the
> RNR timeout length of 10ns would ensure our processing mechanism is
> disabled during the entire timeout period and the packet won't be dropped
> silently;
> 
> To achieve (3), we permanently set the QPC field mentioned in (2) to zero
> which nominally indicates every time tick is equivalent to a microsecond
> in wall-clock time; now, a RNR timeout period at face value of 10 would
> only last 10 ticks, which is 10ns in wall-clock time.
> 
> It's worth noting that we adapt the driver by magnifying certain
> configuration parameters(cq_period, eq_period and ack_timeout)by 1000 given
> the user assumes the configuring timing unit to be microseconds.
> 
> Also, this particular improvisation is only deployed on HIP08 since other
> hardware has already solved this issue.
> 
> Fixes: cfc85f3e4b7f ("RDMA/hns: Add profile support for hip08 driver")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  8 +++
>  2 files changed, 65 insertions(+), 7 deletions(-)
> 

Sorry, please ignore this patch, it should be submitted to the for-rc branch.

Thanks
Wenpeng
