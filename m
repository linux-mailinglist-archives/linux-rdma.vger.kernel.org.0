Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B071163FF
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Dec 2019 23:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLHWki (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Dec 2019 17:40:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11277 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfLHWki (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Dec 2019 17:40:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ded7bd10000>; Sun, 08 Dec 2019 14:40:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 08 Dec 2019 14:40:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 08 Dec 2019 14:40:37 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Dec
 2019 22:40:36 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Dec 2019
 22:40:32 +0000
Subject: Re: [PATCH rdma-next v1 05/48] RDMA/cm: Request For Communication
 (REQ) message definitions
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Sean Hefty" <sean.hefty@intel.com>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-6-leon@kernel.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <fc0c78cc-4e3a-672a-fa6d-1b695f3b74cf@nvidia.com>
Date:   Sun, 8 Dec 2019 14:40:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191121181313.129430-6-leon@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575844818; bh=+Wqg4iABmAj/hKnyZ5zQeMkM153A3+DsLMNemShg6wk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NKqgWoVC5ji7BVZoMjbd0cASigbRH0//Dsd3WlqFggje+UQBGB9V+VTm4d1QohlFl
         9pnGFcEmRw5obV7W2usvYtqtvyhnv27njyFSV6QKSnHa/l/JiStJvO61NMad7sGmLE
         +UkjN12lX4CW53Z8+FgWDitElFnd0X5qXWFtU7yz86+57HaLQuAqZnQqz4tJ8Lfqlt
         eFG1zgSjdjwVgq7G+auqH9l8KHG6s3Dx32f+aXGrD/jT3iMdIHp2fSQhXzwkanzbAn
         Sg1XmY9O+T5leobpPN97w+QaWp1NDgM0ry+8Fn2gj2DafuWO/qCrWvM6yjPTMmgN8B
         wxO7/Z+PK2evw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/21/19 10:12 AM, Leon Romanovsky wrote:
...> diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
> index b476e0e27ec9..956256b2fc5d 100644
> --- a/include/rdma/ib_cm.h
> +++ b/include/rdma/ib_cm.h
> @@ -65,7 +65,6 @@ enum ib_cm_event_type {
>  };
>  
>  enum ib_cm_data_size {
> -	IB_CM_REQ_PRIVATE_DATA_SIZE	 = 92,
>  	IB_CM_MRA_PRIVATE_DATA_SIZE	 = 222,
>  	IB_CM_REJ_PRIVATE_DATA_SIZE	 = 148,
>  	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
> diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
> new file mode 100644
> index 000000000000..885b7b7fdb86
> --- /dev/null
> +++ b/include/rdma/ibta_vol1_c12.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (c) 2019, Mellanox Technologies inc. All rights reserved.
> + *
> + * This file is IBTA volume 1, chapter 12 declarations:
> + * * CHAPTER 12: C OMMUNICATION MANAGEMENT
> + */
> +#ifndef _IBTA_VOL1_C12_H_
> +#define _IBTA_VOL1_C12_H_
> +
> +#include <rdma/iba.h>
> +
> +#define CM_FIELD_BLOC(field_struct, byte_offset, bits_offset, width)           \
> +	IBA_FIELD_BLOC(field_struct,                                           \
> +		       (byte_offset + sizeof(struct ib_mad_hdr)), bits_offset, \
> +		       width)
> +#define CM_FIELD8_LOC(field_struct, byte_offset, width)                        \
> +	IBA_FIELD8_LOC(field_struct,                                           \
> +		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
> +#define CM_FIELD16_LOC(field_struct, byte_offset, width)                       \
> +	IBA_FIELD16_LOC(field_struct,                                          \
> +			(byte_offset + sizeof(struct ib_mad_hdr)), width)
> +#define CM_FIELD32_LOC(field_struct, byte_offset, width)                       \
> +	IBA_FIELD32_LOC(field_struct,                                          \
> +			(byte_offset + sizeof(struct ib_mad_hdr)), width)
> +#define CM_FIELD_MLOC(field_struct, byte_offset, width)                        \
> +	IBA_FIELD_MLOC(field_struct,                                           \
> +		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
> +
> +/* Table 106 REQ Message Contents */
> +#define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
> +#define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8, 64)


Is CM_FIELD64_LOC ever defined? I don't see it defined anywhere in the series.

thanks,
-- 
John Hubbard
NVIDIA
