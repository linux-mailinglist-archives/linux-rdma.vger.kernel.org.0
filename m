Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECE367A1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFEWws (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:52:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40162 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFEWws (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:52:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so236200oie.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEpbREuF+NVWAJ9HoKbtvakT1fpzmGlWsOPh+JmQBrk=;
        b=V8dqPxadpiYssdoXyEh5KF5T5HcmjZO4nAMc5hBAKPIXwVShTM8r4DPtrCWtxP+CCM
         RwS6IeAb5L1nCobST8c3TKiPFmWAkLO+lJROYmut5KM07P64LzwBSjA8Gwb2TTBjeEqc
         qe9385NtopJxFndIq7kb2b6QsZRpeZsKGaEnAQIUL983XW7Zr3JRJGWy7Bt9FStuNOjK
         7gdaQHXbE+Jalew5OSvEkcBihbMnCZVTu/B2fHASSuNkmHN3jyz3bs0+7Is/iKsWnfp1
         /GrppBFh56i3ySQ3Qo5qCbzlfX6wIAUzDBrJPx5gBN6XhAASaoA/moRTD4yTlKLMAsdU
         ROeQ==
X-Gm-Message-State: APjAAAUBevID2lswzg+uYmrT1IVX8Fz/2xDVC2TCbO6FplnD10RjVcmC
        Ah840txfpS7uj5kO8oUslAU=
X-Google-Smtp-Source: APXvYqzht83GnUxCoTRM+KF/26sO8MzbvjJX9eYzaLNCR321tU7Xh+NoZWEj+uNZ4DfQ8VkiCeuw2w==
X-Received: by 2002:aca:cfd0:: with SMTP id f199mr5577514oig.50.1559775167495;
        Wed, 05 Jun 2019 15:52:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x204sm43826oig.9.2019.06.05.15.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:52:46 -0700 (PDT)
Subject: Re: [PATCH 18/20] RDMA/mlx5: Improve PI handover performance
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-19-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b3055107-a91a-a62b-a642-82d14fe3209b@grimberg.me>
Date:   Wed, 5 Jun 2019 15:52:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-19-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> In some loads, there is performace

typo

  degradation when using KLM mkey
> instead of MTT mkey. This is because KLM descriptor access is via
> indirection that might require more HW resources and cycles.
> Using KLM descriptor is not nessecery

typo

  when there are no gaps at the
> data/metadata sg lists. As an optimization, use MTT mkey whenever it
> is possible. For that matter, allocate internal MTT mkey and choose the
> effective pi_mr for in transaction according to the required mapping
> scheme.

You just doubled the number of resources (mrs+page_vectors) allocated
for a performance optimization (25% in large writes). I'm asking myself
if that is that acceptable? We tend to allocate a lot of those (not to
mention the target side).

I'm not sure what is the correct answer here, I'm just wandering if this
is what we want to do. We have seen people bound by the max_mrs
limitation before, and this is making it worse (at least for the pi case).

Anyways, just wanted to raise the concern. You guys are probably a lot
more familiar than I am on the usage patterns of this and if this is
a real problem or not...

> +int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
> +			 int data_sg_nents, unsigned int *data_sg_offset,
> +			 struct scatterlist *meta_sg, int meta_sg_nents,
> +			 unsigned int *meta_sg_offset)
> +{
> +	struct mlx5_ib_mr *mr = to_mmr(ibmr);
> +	struct mlx5_ib_mr *pi_mr = mr->mtt_mr;
> +	int n;
> +
> +	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
> +
> +	/*
> +	 * As a performance optimization, if possible, there is no need to map
> +	 * the sg lists to KLM descriptors. First try to map the sg lists to MTT
> +	 * descriptors and fallback to KLM only in case of a failure.
> +	 * It's more efficient for the HW to work with MTT descriptors
> +	 * (especially in high load).
> +	 * Use KLM (indirect access) only if it's mandatory.
> +	 */
> +	n = mlx5_ib_map_mtt_mr_sg_pi(ibmr, data_sg, data_sg_nents,
> +				     data_sg_offset, meta_sg, meta_sg_nents,
> +				     meta_sg_offset);
> +	if (n == data_sg_nents + meta_sg_nents)
> +		goto out;
> +
> +	pi_mr = mr->klm_mr;
> +	n = mlx5_ib_map_klm_mr_sg_pi(ibmr, data_sg, data_sg_nents,
> +				     data_sg_offset, meta_sg, meta_sg_nents,
> +				     meta_sg_offset);

Does this have any impact when all your I/O is gappy?

IIRC it was fairly easy to simulate that by running small block size
sequential I/O with an I/O scheduler (to a real device).

Would be interesting to measure the impact of the fallback?

Although I don't have any better suggestion other than signal
the application that you always want I/O without gaps (which poses
a different limitation)...
