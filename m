Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7476DB0229
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfIKQyS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 12:54:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37846 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfIKQyS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Sep 2019 12:54:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so14714230oib.4
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2019 09:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKhathfiPuOjPFL51F2PCjfSbT+jNYYwCEKs6TZJ+8s=;
        b=jO99p9yV/MA+eASPkT439ttbtf4KNUwBkW54rzvgAKGZ+TllSjpkdc8Gez7SmGl6PO
         bxgiEazh9KunW0v626toM6M8pYHHKXCuiVGfKWSYB/PUj35WVO6hg+VcrUrq3nc+HFMG
         dikZxQq1tP3QfPKDJ/A+P09M9XFRikgVWfBUVAs0GpYsF/CTcBDEoCskLBcUUozEEl8d
         8bCO89HtmG4xsGF+L3UMq+/wLg5dqqq5FWFFG/PszQBrOtvDi3wcAoVkdD4m3pKFNB1l
         0NvGNzNEieHGufJWBlV632tHKsGvs2MCoG/6AX2hOutrp89pP6ZxDR0KNV5WYFWZl4cu
         xiEA==
X-Gm-Message-State: APjAAAVlFfP06G4gjX4g0JKZPkmdMaIrTQNnLdyevYXcpR3s/BJx8+MH
        2jLE6IKdH5y9f4J1Rykccau9eaMh
X-Google-Smtp-Source: APXvYqwjZnIzkUWyWtqVuw+fzvU+Y9TMqWwLmBF+emumgKKV+eHl8a0+drbDwenCRRy+02A/zBD2+A==
X-Received: by 2002:a54:418a:: with SMTP id 10mr2137078oiy.88.1568220856951;
        Wed, 11 Sep 2019 09:54:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 34sm9003215ots.47.2019.09.11.09.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:54:16 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: Support up to 16MB data transfer in a single
 command
To:     Sergey Gorenko <sergeygo@mellanox.com>
Cc:     maxg@mellanox.com, linux-rdma@vger.kernel.org
References: <20190911125340.19017-1-sergeygo@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e5e9db43-a2cc-13a9-d470-60efbd3ea985@grimberg.me>
Date:   Wed, 11 Sep 2019 09:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911125340.19017-1-sergeygo@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Maximum supported IO size is 8MB for the iSER driver. The
> current value is limited by the ISCSI_ISER_MAX_SG_TABLESIZE
> macro. But the driver is able to handle 16MB IOs without any
> significant changes. Increasing this limit can be useful for
> the storage arrays which are fine tuned for IOs larger than
> 8 MB.
> 
> This commit allows to configure maximum IO size up to 16MB
> using the max_sectors module parameter.
> 
> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
> index 39bf213444cb..fe478c576846 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -103,8 +103,8 @@
>   /* Default support is 512KB I/O size */
>   #define ISER_DEF_MAX_SECTORS		1024
>   #define ISCSI_ISER_DEF_SG_TABLESIZE	((ISER_DEF_MAX_SECTORS * 512) >> SHIFT_4K)
> -/* Maximum support is 8MB I/O size */
> -#define ISCSI_ISER_MAX_SG_TABLESIZE	((16384 * 512) >> SHIFT_4K)
> +/* Maximum support is 16MB I/O size */
> +#define ISCSI_ISER_MAX_SG_TABLESIZE	((32768 * 512) >> SHIFT_4K)

Maybe while we're at it, we can change 512 to SECTOR_SIZE.

Other than that, looks good,

Acked-by: Sagi Grimberg <sagi@grimberg.me>
