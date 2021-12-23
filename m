Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533D147E5F5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLWPqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 10:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhLWPqP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 10:46:15 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E5C061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 07:46:15 -0800 (PST)
Message-ID: <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640274372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+aU3UVrFLYsaIuANTovm40FVEO0s61u7G9hKWlh74E=;
        b=cOGEGfljGYF06JCyr4Lfvi9d51IOY1LkpEkTpkwoTB7pK5ToDTKZshpC5JAyNaDJJhw7nA
        tHKoWvAO8IEywWVDFC9iV+0or5dkIlXTzMtyNe7mQ5AvPmQk69OZwD4BEoK4COU+qi0rtw
        MZRGqesoxgti5E94M1F1ACN0EoY0Sj8=
Date:   Thu, 23 Dec 2021 23:46:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20211221024858.25938-11-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/12/21 10:48, Cheng Xu 写道:
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>   include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 include/uapi/rdma/erdma-abi.h
> 
> diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> new file mode 100644
> index 000000000000..6bcba10c1e41
> --- /dev/null
> +++ b/include/uapi/rdma/erdma-abi.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
> +/*
> + * Copyright (c) 2020-2021, Alibaba Group.
> + */
> +
> +#ifndef __ERDMA_USER_H__
> +#define __ERDMA_USER_H__
> +
> +#include <linux/types.h>
> +
> +#define ERDMA_ABI_VERSION       1

ERDMA_ABI_VERSION should be 2？

Zhu Yanjun
> +
> +struct erdma_ureq_create_cq {
> +	u64 db_record_va;
> +	u64 qbuf_va;
> +	u32 qbuf_len;
> +	u32 rsvd0;
> +};
> +
> +struct erdma_uresp_create_cq {
> +	u32 cq_id;
> +	u32 num_cqe;
> +};
> +
> +struct erdma_ureq_create_qp {
> +	u64 db_record_va;
> +	u64 qbuf_va;
> +	u32 qbuf_len;
> +	u32 rsvd0;
> +};
> +
> +struct erdma_uresp_create_qp {
> +	u32 qp_id;
> +	u32 num_sqe;
> +	u32 num_rqe;
> +	u32 rq_offset;
> +};
> +
> +struct erdma_uresp_alloc_ctx {
> +	u32 dev_id;
> +	u32 pad;
> +	u32 sdb_type;
> +	u32 sdb_offset;
> +	u64 sdb;
> +	u64 rdb;
> +	u64 cdb;
> +};
> +
> +#endif

