Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA38538C1B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfFGOAs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 10:00:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45794 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfFGOAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 10:00:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so1240309pfm.12;
        Fri, 07 Jun 2019 07:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPPgCpRmEJOLYe8kNS7nWVxDs4IWDbfZkl6QFdE16GI=;
        b=KECS81+5IcowhqeEY1R5h/76agUNapD4hfkWzvY7jn4LNincdvEvnZdA7kuol+KdBC
         vPFNLULE6T33MJ5krQXm0NhaORuKNIkV8lprA6cEC6ngbq42ct05PAhS9wQQp4s9BtrW
         WUcrGPYLRa/DznCDer4I3xZZEzU4XzDWHNHm917tPXuSTYaeHENAErm3Qey2tPLJIvzM
         s5pSHEtR78piIKRkKj7UscYuRGsV8vKR4M/0ISpcgSXcBiAmGcWPia78uR7j8G03fRBG
         4jDy+lUNMSADH4afCRvThdMJWYxAs8bKkZMcsk0WabKsGeBmzjuHFKtAnpybec9APHKO
         2+dA==
X-Gm-Message-State: APjAAAW+OaMRBDSj/8T5CUcPDhmEj8OXkLwBpvOw9REBfgvY/1mrg/IN
        77nLmYqqUZaRg05ur1zi8iCTKTsc
X-Google-Smtp-Source: APXvYqyrNZHiuKHiLU9Qt6KuxpTVlAAlN334TtseYuuHmQNDqwVRCVe8PQ/rMRirhB94O0S/WQJjhg==
X-Received: by 2002:aa7:8248:: with SMTP id e8mr19108120pfn.155.1559916048110;
        Fri, 07 Jun 2019 07:00:48 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id y7sm2932798pge.89.2019.06.07.07.00.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:00:47 -0700 (PDT)
Subject: Re: [PATCH v2] iser: explicitly set shost max_segment_size if non
 virtual boundary devices
To:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
References: <20190607012914.2328-1-sagi@grimberg.me>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a82f76b0-8474-9f11-832b-920c096faa83@acm.org>
Date:   Fri, 7 Jun 2019 07:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607012914.2328-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 6:29 PM, Sagi Grimberg wrote:
> if the rdma device supports sg gaps, we don't need to set a virtual
> boundary but we then need to explicitly set the max_segment_size, otherwise
> scsi takes BLK_MAX_SEGMENT_SIZE and sets it using dma_set_max_seg_size()
> and this affects all the rdma device consumers.
> 
> Fix it by setting shost max_segment_size according to the device
> capability if SG_GAPS are not supported.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - set max_segment_size only for non virtual boundary devices
> 
>   drivers/infiniband/ulp/iser/iscsi_iser.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index 841b66397a57..a3a4b956bbb9 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -653,7 +653,9 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
>   						   SHOST_DIX_GUARD_CRC);
>   		}
>   
> -		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
> +		if (ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
> +			shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
> +		else
>   			shost->virt_boundary_mask = ~MASK_4K;
>   
>   		if (iscsi_host_add(shost, ib_dev->dev.parent)) {

This is incomprehensible without a big comment that explains why 
max_segment_size is only set if the IB_DEVICE_SG_GAPS_REG feature is 
available.

Bart.


