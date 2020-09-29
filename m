Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5103027D5B9
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgI2SYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 14:24:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46567 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgI2SYx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 14:24:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id b124so5373732pfg.13;
        Tue, 29 Sep 2020 11:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cv+VtdAufAAEWbfdy6MfzzVxHEHSITCss8O60CesZRI=;
        b=O+hwRRZpmuer0Q6VQPfOuW6CEk1eiJoplBPWiTQpGHFX3ouyT+GWyotWfN1GJ8MnR9
         CMAvUx+p5T0FhpGxiF/QU7XuR6szMlN+RpPi9JtNdywnisREk5PrqXSUvPMEqUtjIFBa
         eKvNu24vrc4XFThAJYPiQMAFqMsLitaO+uPiJoIbTtJ6glqQQuilxpF22/x0Vjpzx5t+
         rSukMrDQPVYSei0QKVZLB5XH8o/rfwiJqnn5ezfIv3aZso20rPOlbo2APQZ5D8jTX4xE
         t+wRt0U0Xz6lELXZsTc9y0Gvev51dVpgYNXAI92veSM7HrocpivEKXuXTSRUcOo/Otwo
         FDSg==
X-Gm-Message-State: AOAM530wHuq7EaKPFBuFTr0BhtJ0sqa/lTkX+gtchWU52rCN9pn+KTmb
        kOlBgY6wRnc9CpfvtCIQgYVmZUQUowk=
X-Google-Smtp-Source: ABdhPJwR+inYO61Gp1C9kisMtoi7s9azwzq1iyNQo/GL2lBe5OlQ8O+681Hel3isFB/Jj9f1DrfKRQ==
X-Received: by 2002:a17:902:9041:b029:d0:cc02:8540 with SMTP id w1-20020a1709029041b02900d0cc028540mr5533911plz.41.1601403891897;
        Tue, 29 Sep 2020 11:24:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce? ([2601:647:4802:9070:8ff9:9348:1454:22ce])
        by smtp.gmail.com with ESMTPSA id m5sm5229070pjn.19.2020.09.29.11.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 11:24:51 -0700 (PDT)
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
To:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de>
 <20200929103549.GE3094@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
Date:   Tue, 29 Sep 2020 11:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929103549.GE3094@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> The RDMA vector affinity code is not backed up by any driver and always
>>> returns NULL to every ib_get_vector_affinity() call.
>>>
>>> This means that blk_mq_rdma_map_queues() always takes fallback path.
>>>
>>> Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>
>> So you guys totally broken the nvme queue assignment without even
>> telling anyone?  Great job!
> 
> Who is "you guys" and it wasn't silent either? I'm sure that Sagi knows the craft.
> https://lore.kernel.org/linux-rdma/20181224221606.GA25780@ziepe.ca/
> 
> commit 759ace7832802eaefbca821b2b43a44ab896b449
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Thu Nov 1 13:08:07 2018 -0700
> 
>      i40iw: remove support for ib_get_vector_affinity
> 
> ....
> 
> commit 9afc97c29b032af9a4112c2f4a02d5313b4dc71f
> Author: Sagi Grimberg <sagi@grimberg.me>
> Date:   Thu Nov 1 09:13:12 2018 -0700
> 
>      mlx5: remove support for ib_get_vector_affinity
> 
> Thanks

Yes, basically usage of managed affinity caused people to report
regressions not being able to change irq affinity from procfs.

Back then I started a discussion with Thomas to make managed
affinity to still allow userspace to modify this, but this
was dropped at some point. So currently rdma cannot do
automatic irq affinitization out of the box.
