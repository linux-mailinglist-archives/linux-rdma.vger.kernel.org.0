Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3CE8FE5
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJ2TZr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:25:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37325 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2TZq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 15:25:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id q130so3661173wme.2;
        Tue, 29 Oct 2019 12:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kH7mElj+BQXQvPg6FPLFWLw/rRcVOGhkVoyAwzGknUo=;
        b=GylhHGwof9Bk31mMVztZyLIqzRmXdc5aGeuVza/BLz+rtnPqrV5VLG1NAP8Vd61+YR
         dT3JFW177W1yQGylsJznwH8cQXS2x64HMi6EkR8wt88vYr66eBBIqYVUkiX82zGgVm4C
         muWwI7TDnaQWnSUTlcLDp1lKdTRcfqfpkdr1H83EY+D4OD1JGTTclhniX6Nl+4ifjksL
         +ag6hXsM+CO7SWhgpx2UYA3ZWYWL4+NLD3LCfWIeUFTCNkgbiN/7CxljjisLtNbl55u4
         adK4BAmvBmQN+5mXQ8MiNCsDzTgHgDR93rt0H45J6nPBA8fVyXeRDjFfrrudnqO8oPW5
         WS3A==
X-Gm-Message-State: APjAAAXKe3XqoStg13Kt2s79qWKHePevzcMSSS9N6LkJUDv+95WFszak
        XYx4N6W2bsUklMZMoELJgxnn4/yi
X-Google-Smtp-Source: APXvYqxNvYyVfduQ6BB2C5Rqx1CbqDS+kPSYMtMwGTTJHIlH+qS9vd+AZD1To4NizYmYie5lHkiH/Q==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr5797592wmh.96.1572377144480;
        Tue, 29 Oct 2019 12:25:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q12sm9952665wrw.91.2019.10.29.12.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 12:25:43 -0700 (PDT)
Subject: Re: [PATCH v2] iser: explicitly set shost max_segment_size if non
 virtual boundary devices
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607012914.2328-1-sagi@grimberg.me>
 <20191029192057.GA11679@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5c5fe89e-e56b-946b-7221-5fc1660cadec@grimberg.me>
Date:   Tue, 29 Oct 2019 12:25:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029192057.GA11679@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> if the rdma device supports sg gaps, we don't need to set a virtual
>> boundary but we then need to explicitly set the max_segment_size, otherwise
>> scsi takes BLK_MAX_SEGMENT_SIZE and sets it using dma_set_max_seg_size()
>> and this affects all the rdma device consumers.
>>
>> Fix it by setting shost max_segment_size according to the device
>> capability if SG_GAPS are not supported.
>>
>> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Changes from v1:
>> - set max_segment_size only for non virtual boundary devices
>>
>>   drivers/infiniband/ulp/iser/iscsi_iser.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Sagi, are you respinning this or ??

I can take the change-log message and paste it in the code,
but is that something we want? Usually people look in the
change-log history...
