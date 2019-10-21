Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8160FDF313
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfJUQ0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 12:26:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36685 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfJUQ0S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 12:26:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so8746846pfr.3
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 09:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=770v9ht12vy3NdORZAJ6njsIlsObZJSKA5aEPY38vfs=;
        b=NF4QjhQGt09axYaX6M4Q2UoTzKdDwLBWaLBQ5G6Z89PuoaI3dNz7sEO7qz/b32/4iB
         RQUysBtkz3Je9j0iMbOIKfe3dgXlVkRa3vre+1muBtFSvekRD001P3Evfy+A7dsCTjZk
         0Iu69/ejFyrbxRPUNO52x2A4RL635At1lJMAoqqb5Io5TsrlnjfLVFD/PnE93B/YaS38
         v3wvJcg4XcTCmOV0Jp8CsRJLG3nfiM+hIdyNB4blvE3vJHs7dDr/jNr6XiV/RHHbFuOz
         bHdsGUpl3tj2LaFZNCgQaxdVuezP8ys3WCtOrq4Q0hDOlQMpfhbDETHqClaNxVEcCDjy
         8TNw==
X-Gm-Message-State: APjAAAW6jeAIdyZJEkqWjBTJnfMOsxGgATGtu6Z3jEiYOTs+x/QIvZ1T
        H53X2OGey5Z56wtdUBUiqHQ=
X-Google-Smtp-Source: APXvYqzuYfzPm6N+/GWaoYN+KoWdgYRGNDYPdipVvkK8V4S5TCZfz4CxZftCbaj8R8jIAKkltE0JXg==
X-Received: by 2002:a62:e90d:: with SMTP id j13mr24441991pfh.237.1571675177395;
        Mon, 21 Oct 2019 09:26:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w10sm13651081pjq.3.2019.10.21.09.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 09:26:16 -0700 (PDT)
Subject: Re: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org> <20191021141039.GC25178@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <61d89948-de40-5e6b-f368-353476292093@acm.org>
Date:   Mon, 21 Oct 2019 09:26:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021141039.GC25178@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/19 7:10 AM, Jason Gunthorpe wrote:
> On Sun, Oct 20, 2019 at 07:10:28PM -0700, Bart Van Assche wrote:
>> The effect of the dma_set_max_seg_size() call in setup_dma_device() is
>> as follows:
>> - If device->dev.dma_parms is NULL, that call has no effect at all.
>> - If device->dev.dma_parms is not NULL, since that pointer points at
>>    the DMA parameters of the parent device, modify the DMA limits of the
>>    parent device.
>>
>> Both actions are wrong. Instead of changing the DMA parameters of the
>> parent device, use the DMA parameters of the parent device if these
>> parameters are available.
>>
>> Compile-tested only.
>>
>> Cc: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Adit Ranadive <aditr@vmware.com>
>> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
>> Cc: Gal Pressman <galpress@amazon.com>
>> Cc: Selvin Xavier <selvin.xavier@broadcom.com>
>> Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>   drivers/infiniband/core/device.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 536310fb6510..b33d684a2a99 100644
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1199,9 +1199,18 @@ static void setup_dma_device(struct ib_device *device)
>>   		WARN_ON_ONCE(!parent);
>>   		device->dma_device = parent;
>>   	}
>> -	/* Setup default max segment size for all IB devices */
>> -	dma_set_max_seg_size(device->dma_device, SZ_2G);
>>   
>> +	if (!device->dev.dma_parms) {
>> +		if (parent) {
>> +			/*
>> +			 * The caller did not provide DMA parameters. Use the
>> +			 * DMA parameters of the parent device.
>> +			 */
>> +			device->dev.dma_parms = parent->dma_parms;
>> +		} else {
>> +			WARN_ON_ONCE(true);
>> +		}
>> +	}
>>   }
> 
> We really do want to, by default, increase the max_seg_size above 64k
> though, so this approach doesn't seem right either.

How about replacing this patch by the patch below and by moving this patch to
the end of this series?

Thanks,

Bart.


Subject: [PATCH] RDMA/core: Set DMA parameters correctly

The dma_set_max_seg_size() call in setup_dma_device() does not have any
effect since device->dev.dma_parms is NULL. Fix this by initializing
device->dev.dma_parms first.

Cc: Michael J. Ruhl <michael.j.ruhl@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Adit Ranadive <aditr@vmware.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Gal Pressman <galpress@amazon.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>
Fixes: d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/infiniband/core/device.c | 16 ++++++++++++++--
  1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a667636f74bf..a523d844ad9d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1199,9 +1199,21 @@ static void setup_dma_device(struct ib_device *device)
  		WARN_ON_ONCE(!parent);
  		device->dma_device = parent;
  	}
-	/* Setup default max segment size for all IB devices */
-	dma_set_max_seg_size(device->dma_device, SZ_2G);

+	if (!device->dev.dma_parms) {
+		if (parent) {
+			/*
+			 * The caller did not provide DMA parameters, so
+			 * 'parent' probably represents a PCI device. The PCI
+			 * core sets the maximum segment size to 64
+			 * KB. Increase this parameter to 2G.
+			 */
+			device->dev.dma_parms = parent->dma_parms;
+			dma_set_max_seg_size(device->dma_device, SZ_2G);
+		} else {
+			WARN_ON_ONCE(true);
+		}
+	}
  }

  /*
