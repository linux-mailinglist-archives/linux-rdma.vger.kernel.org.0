Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1242B17FD84
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCJN2A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 09:28:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729198AbgCJMxg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54ACBA17AA621E384E78;
        Tue, 10 Mar 2020 20:53:30 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 10 Mar 2020
 20:53:22 +0800
Subject: Re: [PATCH v3 for-next 0/5] RDMA/hns: Refactor wqe related codes
From:   Weihang Li <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
Message-ID: <9221956f-cbbb-213d-9031-2ca7e9b9f7d4@huawei.com>
Date:   Tue, 10 Mar 2020 20:53:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Sorry, I didn't notice that the first three patches of this series had
been applied to you for-next branch, so I sent this new version. Need
I resend the last two patches in a new series?

Thanks
Weihang

On 2020/3/10 19:22, Weihang Li wrote:
> Process of wqe is hard to understand and maintain in hns, this series
> refactor wqe related code, especially in hns_roce_v2_post_send().
> 
> Previous discussion could be found at:
> - v2: https://patchwork.kernel.org/cover/11422963/
> - v1: https://patchwork.kernel.org/cover/11415395/
> 
> Changes since v2:
> - Remove a redundant assignment of "NULL" in patch 4/5.
> 
> Changes since v1:
> - Fix comments from Leon about the inplementation of to_hr_opcode() in
>   patch 3/5.
> - Patch 4/5 couldn't be applied. Just do a rebase.
> 
> Xi Wang (5):
>   RDMA/hns: Rename wqe buffer related functions
>   RDMA/hns: Optimize wqe buffer filling process for post send
>   RDMA/hns: Optimize the wr opcode conversion from ib to hns
>   RDMA/hns: Optimize base address table config flow for qp buffer
>   RDMA/hns: Optimize wqe buffer set flow for post send
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  16 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   9 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 588 ++++++++++++++--------------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  48 +--
>  5 files changed, 319 insertions(+), 352 deletions(-)
> 

