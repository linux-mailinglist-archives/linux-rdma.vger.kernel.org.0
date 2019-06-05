Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EB367AD
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFEW7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:59:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34007 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEW7Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:59:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id u64so271753oib.1
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUcQwFkfdJ83+GDhEx4FBDYrAI3vhInCQQZ2ZCJDEEI=;
        b=LKHiaG5fyO5qD/7ZYN1DYjZIi6DjCQm/wd6rXWOPwmJ7H9IDBEARg1J3OtaQFOi1vi
         d24rSgeMVDFKTYQQ7fm23c3ABGrqtirIWjMqX1Lw+J1rQUUJyT1cb2BB65miMX+tqX+Z
         dTdG+I3Hn59bBaQo9Dzi083F/oJRFK0InVuua3cqAzDyRKci1xrs8bUSdZBM9XH2yM4F
         N2nfNcI1ziaDz/ZFFVfzF9MjFUsY6LSnYjHA3kq4HNDcQeKE36WmmlgeQHNKiS4422gF
         JbMjLi9iaE9FkoThzgJanIo5XCOdO1KOoftYnbFrUwdfEMqqa75YN+2JFbnOYfZRqLxZ
         0V8w==
X-Gm-Message-State: APjAAAVvOgiLCz0eRwAM+EWQRqePv9JFSNW/q5mWmLRxoxQ4LU34IIOS
        bjL2NN2iDuokYgevCQsAEg0=
X-Google-Smtp-Source: APXvYqzGGQwGzYSqrTYOvE82mnyT71yy/+s/PLVHnqQaNgJReNOSePvXrPGemwrQp5Nq6ZP8AAJCKA==
X-Received: by 2002:aca:d746:: with SMTP id o67mr10196755oig.157.1559775564342;
        Wed, 05 Jun 2019 15:59:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b127sm47688oih.43.2019.06.05.15.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:59:23 -0700 (PDT)
Subject: Re: [PATCH 19/20] RDMA/mlx5: Use PA mapping for PI handover
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-20-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad2fde22-0701-e244-aad7-0b51ec3f2cf8@grimberg.me>
Date:   Wed, 5 Jun 2019 15:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-20-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/30/19 6:25 AM, Max Gurtovoy wrote:
> If possibe, avoid doing a UMR operation to register data and protection
> buffers (via MTT/KLM mkeys). Instead, use the local DMA key and map the
> SG lists using PA access. This is safe, since the internal key for data
> and protection never exposed to the remote server (only signature key
> might be exposed). If PA mappings are not possible, perform mapping
> using MTT/KLM descriptors.
> 
> The setup of the tested benchmark (using iSER ULP):
>   - 2 servers with 24 cores (1 initiator and 1 target)
>   - ConnectX-4/ConnectX-5 adapters
>   - 24 target sessions with 1 LUN each
>   - ramdisk backstore
>   - PI active
> 
> Performance results running fio (24 jobs, 128 iodepth) using
> write_generate=1 and read_verify=1 (w/w.o patch):
> 
> bs      IOPS(read)        IOPS(write)
> ----    ----------        ----------
> 512   1266.4K/1262.4K    1720.1K/1732.1K
> 4k    793139/570902      1129.6K/773982
> 32k   72660/72086        97229/96164
> 
> Using write_generate=0 and read_verify=0 (w/w.o patch):
> bs      IOPS(read)        IOPS(write)
> ----    ----------        ----------
> 512   1590.2K/1600.1K    1828.2K/1830.3K
> 4k    1078.1K/937272     1142.1K/815304
> 32k   77012/77369        98125/97435
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>   drivers/infiniband/hw/mlx5/mr.c      | 63 ++++++++++++++++++++++++++--
>   drivers/infiniband/hw/mlx5/qp.c      | 80 ++++++++++++++++++++++++------------
>   3 files changed, 114 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 6039a1fc80a1..97c8534c5802 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -609,6 +609,7 @@ struct mlx5_ib_mr {
>   	struct mlx5_ib_mr      *pi_mr;
>   	struct mlx5_ib_mr      *klm_mr;
>   	struct mlx5_ib_mr      *mtt_mr;
> +	u64			data_iova;
>   	u64			pi_iova;
>   
>   	atomic_t		num_leaf_free;
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 74cec8af158a..9025b477d065 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -2001,6 +2001,40 @@ int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
>   	return ret;
>   }
>   
> +static int
> +mlx5_ib_map_pa_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
> +			int data_sg_nents, unsigned int *data_sg_offset,
> +			struct scatterlist *meta_sg, int meta_sg_nents,
> +			unsigned int *meta_sg_offset)
> +{
> +	struct mlx5_ib_mr *mr = to_mmr(ibmr);
> +	unsigned int sg_offset = 0;
> +	int n = 0;
> +
> +	mr->meta_length = 0;
> +	if (data_sg_nents == 1) {
> +		n++;
> +		mr->ndescs = 1;
> +		if (data_sg_offset)
> +			sg_offset = *data_sg_offset;
> +		mr->data_length = sg_dma_len(data_sg) - sg_offset;
> +		mr->data_iova = sg_dma_address(data_sg) + sg_offset;
> +		if (meta_sg_nents == 1) {
> +			n++;
> +			mr->meta_ndescs = 1;
> +			if (meta_sg_offset)
> +				sg_offset = *meta_sg_offset;
> +			else
> +				sg_offset = 0;
> +			mr->meta_length = sg_dma_len(meta_sg) - sg_offset;
> +			mr->pi_iova = sg_dma_address(meta_sg) + sg_offset;
> +		}
> +		ibmr->length = mr->data_length + mr->meta_length;

If I'm reading this correctly, this is assuming that if data_sg_nents is
1 then meta_sg_nents is either 1 or 0.

Is that really always the case?

What if my I/O was merged and my data pages happen to coalesce (because
they are contiguous) but my meta buffers did not?
