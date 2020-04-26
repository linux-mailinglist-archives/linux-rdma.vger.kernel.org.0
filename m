Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0771B8CF1
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZGhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 02:37:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbgDZGhb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 02:37:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE4B4BE40D3ABAD4A499;
        Sun, 26 Apr 2020 14:37:28 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 14:37:20 +0800
Subject: Re: [PATCH v2 for-next 0/5] RDMA/hns: Refactor process of buffer
 allocation and calculation
From:   Weihang Li <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1587647570-46972-1-git-send-email-liweihang@huawei.com>
Message-ID: <231b758b-e165-8a1b-6bd1-102ff309fc74@huawei.com>
Date:   Sun, 26 Apr 2020 14:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587647570-46972-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/4/23 21:13, Weihang Li wrote:
> Patch #1 and #2 aim to use MTR interfaces for PBL buffer instead of MTT,
> and after this, MTT can be removed completely. Patch #3 and #5 refactor
> buffer size calculation process for WQE and SRQ. #4 can be considered as a
> preparation for #5, which just moves code of SRQ together to a more
> suitable place.
> 
> This series looks huge, but most of the modification is to replace and
> remove old interfaces, and patch #4 also contribute a lot. Actually, the
> original logic is not changed so much.
> 
> Changes since v1:
> - Remove meaningless judgment of count in some inline functions in #3.
> - Add more information into commit messages of #3 and #5.
> 
> Xi Wang (4):
>   RDMA/hns: Optimize PBL buffer allocation process
>   RDMA/hns: Remove unused MTT functions
>   RDMA/hns: Optimize WQE buffer size calculating process
>   RDMA/hns: Optimize SRQ buffer size calculating process
> 
> Yixian Liu (1):
>   RDMA/hns: Move SRQ code to the reasonable place
> 
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   43 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |  110 +--
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  105 ---
>  drivers/infiniband/hw/hns/hns_roce_hem.h    |    6 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   45 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  941 ++++++++++----------
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   70 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 1250 +++------------------------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  313 +++----
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |   16 +-
>  10 files changed, 768 insertions(+), 2131 deletions(-)
> 

Hi all,

This series has a conflict when rebasing to the newest for-next, please
ignore it and I will resend a new version.

Thanks
Weihang

