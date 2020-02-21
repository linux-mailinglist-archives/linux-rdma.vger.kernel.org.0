Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED15166DCB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 04:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBUDgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 22:36:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbgBUDgw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 22:36:52 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 467D3FC3D1ABA48FD21B;
        Fri, 21 Feb 2020 11:36:50 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 11:36:44 +0800
Subject: Re: [PATCH v3 for-next 0/7] RDMA/hns: Refactor qp related code
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1582167367-50380-1-git-send-email-liweihang@huawei.com>
Message-ID: <78d6ad71-363c-2d49-209c-77672d9c7e63@huawei.com>
Date:   Fri, 21 Feb 2020 11:36:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1582167367-50380-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/2/20 10:56, Weihang Li wrote:
> This series refactor qp related code, including creating, destroying qp and
> so on to make the processs easier to understand and maintain.
> 
> Previous disscussion can be found at:
> https://patchwork.kernel.org/cover/11372841/
> https://patchwork.kernel.org/cover/11341265/
> 
> Changes since v2:
> - Change some macros into static inline functions as Jason suggested.
> - Unify all prints into format of "Failed to xxx".
> - Rebase against Jason's for-next branch.
> 
> Changes since v1:
> - Reduce the number of prints as Leon suggested.
> - Fix a wrong function name in description of patch 4/7.
> 
> Xi Wang (7):
>   RDMA/hns: Optimize qp destroy flow
>   RDMA/hns: Optimize qp context create and destroy flow
>   RDMA/hns: Optimize qp number assign flow
>   RDMA/hns: Optimize qp buffer allocation flow
>   RDMA/hns: Optimize qp param setup flow
>   RDMA/hns: Optimize kernel qp wrid allocation flow
>   RDMA/hns: Optimize qp doorbell allocation flow
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |   6 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  19 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  43 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 808 ++++++++++++++++------------
>  4 files changed, 465 insertions(+), 411 deletions(-)
> 

Sorry, I missed a comment from Jason in v2, please ignore this series.
I will send a new version soon.

Weihang

