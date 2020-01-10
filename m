Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27A313715C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgAJPeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:34:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34332 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgAJPeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:34:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so1924623edw.1
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ie5aVHRs3fMg3l5fEJ6yUFTPMWafXXtxtwYKnx7eFk0=;
        b=XfyG7FtK98khhd/EFD1f2/vOjJ1eehnC+AbNUXVxynz6llFzBio3KfSmMGlMzrILwy
         wsWjnmW/HW2sq4Yfq+k/CCvSQFN047uuohfyD6hI5HkHh/5g5EEKazGHj7xTrhbFI+lO
         iFcWWmuLyFaeQ65v+PK5QR9QcQfQZpqWGwNFteK8hwWmT64NuetZJ3F3DZnBt3FhuxN1
         0OfQjLMRLgLIjxlBbkUe7llB8iLpVhRlmyftcbM1lh/4zQW34F/bjzhV7nBSxYN9yVZh
         ywmltxtoGtWYJmHPXaEB7tcFEUyP2Sz1uPmd/0ANMvPFoo4XRN640Dw90SNuNymQDLZo
         ntKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ie5aVHRs3fMg3l5fEJ6yUFTPMWafXXtxtwYKnx7eFk0=;
        b=D3QEaxjToyTlMCZn37eeWSgTkU3wybPrtFFuahOn2BQl8N3/GawKQGetxFKyoPErPp
         a0cmDBkuZyCg0+wmaEwPj2cd2HYUKNa8F3jtEKdGCzineSVGmk6ipaTGgqiw1gX6NjgT
         teRxhklH0H46LgR7/o0kHPZdsRo4zwwApEHOvmzezzfGMrd4gwOwwM4GbIm2HyxKOndH
         4TNuS+lfxSMThaPTz1QoEoKpGgZvpCqsu9hA6l87AABvlcdCrddNeYvm1l3dezv74n0v
         0qrM6TaXPEeICvYUMNcz1WtScLTI/yGiJf34nU3h3kwm9LP/PZOPgfusmTQ+efj0unkd
         YKlw==
X-Gm-Message-State: APjAAAVd3oDAfL2QumiVy5fEZwI6hz1l490vIWmDhDPTrw47yhCcjRMh
        zgP7VSk5RSdwBZNZ4l2FY0ZIRlk7D0Y=
X-Google-Smtp-Source: APXvYqyJ+Sdgmr9ij1y2kEPGCCI89n656QcmUT/LKgLQnmTKTlpyO7aZSOscgFv4sC4fkpJxv8BxbA==
X-Received: by 2002:a05:6402:1771:: with SMTP id da17mr4264311edb.68.1578670449966;
        Fri, 10 Jan 2020 07:34:09 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:b9cb:c00f:83d:e3ff? ([2001:1438:4010:2540:b9cb:c00f:83d:e3ff])
        by smtp.gmail.com with ESMTPSA id ck28sm55835edb.45.2020.01.10.07.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:34:09 -0800 (PST)
Subject: Re: [RFC PATCH] RDMA/core: avoid potential memory leak in
 add_one_compat_dev
To:     jgq516@gmail.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org
References: <20200110153250.11898-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <0c67a2ec-9291-85c1-ba37-2b90849df314@cloud.ionos.com>
Date:   Fri, 10 Jan 2020 16:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110153250.11898-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Forget to cc list, sorry.

On 1/10/20 4:32 PM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> In add_one_compat_dev, if failure happens after cdev is allocated,
> so we need to free the memory accordingly.
>
> Fixes: 4e0f7b9070726 ("RDMA/core: Implement compat device/sysfs tree in net namespace")
> Cc: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
> Hi,
>
> When reading the code, it looks no place to free cdev under those err condition.
> And I guess remove_one_compat_dev needs to free cdev as well, something like:
>
> @@ -937,6 +937,8 @@ static void remove_one_compat_dev(struct ib_device *device, u32 id)
>                  ib_free_port_attrs(cdev);
>                  device_del(&cdev->dev);
>                  put_device(&cdev->dev);
> +               kfree(cdev);
> +               cdev = NULL;
>          }
>   }
>
> But since I am not know well about the code, so this is RFC.
>
> Thanks,
> Guoqing
>
>   drivers/infiniband/core/device.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 84dd74fe13b8..dca8d9da4a75 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -918,6 +918,7 @@ static int add_one_compat_dev(struct ib_device *device,
>   	device_del(&cdev->dev);
>   add_err:
>   	put_device(&cdev->dev);
> +	kfree(cdev);
>   cdev_err:
>   	xa_release(&device->compat_devs, rnet->id);
>   done:

