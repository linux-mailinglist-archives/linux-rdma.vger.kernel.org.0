Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33302EFBF8
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfKELDt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 06:03:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfKELDt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 06:03:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AB4F97BAC478849B697A;
        Tue,  5 Nov 2019 19:03:47 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 19:03:38 +0800
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Cleanups for hip08
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
Message-ID: <f79578fc-d530-7229-4def-d04f48c66203@hisilicon.com>
Date:   Tue, 5 Nov 2019 19:03:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Sorry, I forgot to remove "{topost}" in title, please ignore this series.

Weihang

On 2019/11/5 18:39, Weihang Li wrote:
> These series just make cleanups without changing code logic.
> 
> [patch 1/9 ~ 3/9] remove unused variables and structures.
> [patch 4/9 ~ 5/9] modify field and function names.
> [patch 6/9 ~ 7/9] remove dead codes to simplify functions.
> [patch 8/9] replaces non-standard return value with linux error codes.
> [patch 9/9] does some fixes on printings.
> 
> Lang Cheng (3):
>   {topost} RDMA/hns: Remove unnecessary structure hns_roce_sqp
>   {topost} RDMA/hns: Simplify doorbell initialization code
>   {topost} RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the code
> 
> Wenpeng Liang (1):
>   {topost} RDMA/hns: Modify appropriate printings
> 
> Yixian Liu (4):
>   {topost} RDMA/hns: Delete unnecessary variable max_post
>   {topost} RDMA/hns: Delete unnecessary uar from hns_roce_cq
>   {topost} RDMA/hns: Modify fields of struct hns_roce_srq
>   {topost} RDMA/hns: Fix non-standard error codes
> 
> Yixing Liu (1):
>   {topost} RDMA/hns: Replace not intuitive function/macro names
> 
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_cmd.h    | 14 +++----
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 51 +++++++++++-----------
>  drivers/infiniband/hw/hns/hns_roce_device.h | 22 +++-------
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 12 +++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 37 ++++++----------
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 65 +++++++++++++++--------------
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 18 ++++----
>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 58 ++++++++++++-------------
>  11 files changed, 132 insertions(+), 155 deletions(-)
> 

