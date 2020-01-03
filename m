Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553D012FA56
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgACQ3C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 11:29:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43337 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgACQ3C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 11:29:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so23634087pga.10;
        Fri, 03 Jan 2020 08:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JqvZcEu8W8qbxYaL1d0CeIMIcPYQQjtkLM1EHupMOTw=;
        b=pkSMVe+mOkmpGhX/5kjiHQCYoIk/6az+FjYDZtOYadvUvtpHzVGtOnNxgbPYz/rca2
         4r4yF8MioIZq+Vn6wbhEtaMaQHREnsB4fl44dzHYm5jSqOK5WuqkD4JpIeZ/VP7g/coJ
         5ME5FZdoVZRbx3FjMHS/itg61FhgVmtlqP6yRiqU/KvAN1ERO1F+D0vMaVS3m7RkAQOm
         Xkxgx86t4l13EIUNPx3UotxtrT7BaxkwJQxC47FvqH/Ym86Ros+Q4e8TtOwcmeZHQeeB
         Hip9TuB8IoF13OWorloMA5+OjKyJuRPc/FOlKRbsLcb4dDD+biaxVjMSOxU7PiYljQMx
         I30g==
X-Gm-Message-State: APjAAAWrkOjTkKLEVdWzIkmC9cSdmBcYBAnOAGTjiYItUnT4tPjnWoUH
        0juIk5HyXlvijlWP+FYYNgw=
X-Google-Smtp-Source: APXvYqznV4MvK/lkK8CWTfG4BOxMM8tNc6vMJpxLLLOwaxirSgdxE3YG2JCSDNMjUGy+c2DE88WWEg==
X-Received: by 2002:a63:1a08:: with SMTP id a8mr73067236pga.425.1578068941359;
        Fri, 03 Jan 2020 08:29:01 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k10sm15027522pjs.13.2020.01.03.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:29:00 -0800 (PST)
Subject: Re: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and
 the corresponding RNBD (former IBNBD) rdma network block device
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20191220155109.8959-1-jinpuwang@gmail.com>
 <20200102181859.GC9282@ziepe.ca>
 <CAMGffE=h24jmi0RnYks_rur71qrXCxJnPB5+cCACR50hKF6QRA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d5be42e2-94d4-ad13-43ac-fcc1bb108ad0@acm.org>
Date:   Fri, 3 Jan 2020 08:28:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMGffE=h24jmi0RnYks_rur71qrXCxJnPB5+cCACR50hKF6QRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/3/20 4:39 AM, Jinpu Wang wrote:
> Performance results for the v5.5-rc1 kernel are here:
>    link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v5-v5.5-rc1
> 
> Some workloads RNBD are faster, some workloads NVMeoF are faster.

Thank you for having shared these graphs.

Do the graphs in RNBD-SinglePath.pdf show that NVMeOF achieves similar 
or higher IOPS, higher bandwidth and lower latency than RNBD for 
workloads with a block size of 4 KB and also for mixed workloads with 
less than 20 disks, whether or not invalidation is enabled for RNBD?

Is it already clear why NVMeOF performance drops if the number of disks 
is above 25? Is that perhaps caused by contention on the block layer tag 
allocator because multiple NVMe namespaces share a tag set? Can that 
contention be avoided by increasing the NVMeOF queue depth further?

Thanks,

Bart.


