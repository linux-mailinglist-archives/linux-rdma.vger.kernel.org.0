Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE34E8FEA
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJ2T0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:26:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37202 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2T0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 15:26:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so14936881wrv.4;
        Tue, 29 Oct 2019 12:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yoc+omBnnUd4soMfJ6bNGvQbXonbqRDHsfZI3u2IJAc=;
        b=APA/s/TMPc8zbn9zATpX7Xa5Vh0qeCrm5PRmluJ3o+tzVbC4U6dFGCiEdfAYXT89Hy
         WtzovOMemz7cIe1fucjQaqy88A5tYzN+bsUWtNU7vTQ3JOmn+Oy4NVxghukmFSkqUqrK
         2++08PrW/XRiOHerRQbFXtZXfTb8rUX09aijFDzMR4F4Z51P1/13WedK8ObZ6nMKpnxk
         K5ssQ7S31o4mGwFWB+9xcByl10hqHNLKcl9ornzbjU76aYmeLp5yEhnCSBOpLEThJPVE
         v6p/rNuT65/V0/RUWBmnrLTD0plgX6cq4Qg/GIZxnODbg2YktcGQPnrwap7y3r5umUio
         TBwQ==
X-Gm-Message-State: APjAAAVV2v7HsGAOwHosAAuw6tLCXIeSAdJWOI3SXFs6OOcKnH/D2FY7
        U/CifovX+JJtAMJHtIV0KbE=
X-Google-Smtp-Source: APXvYqxKqnLZSCi2lnailseMnErYAlUO6kO1QIMaogQRU+5F9spCuKxRzMU6XIlfMB781vXvqpU+Ug==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr17151879wru.174.1572377177749;
        Tue, 29 Oct 2019 12:26:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id f143sm4753881wme.40.2019.10.29.12.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 12:26:17 -0700 (PDT)
Subject: Re: [PATCH v2] iser: explicitly set shost max_segment_size if non
 virtual boundary devices
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607012914.2328-1-sagi@grimberg.me>
 <20191029192057.GA11679@ziepe.ca>
 <5c5fe89e-e56b-946b-7221-5fc1660cadec@grimberg.me>
Message-ID: <c20152a8-064f-6e92-bf5e-bebedf3ca6ee@grimberg.me>
Date:   Tue, 29 Oct 2019 12:26:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5c5fe89e-e56b-946b-7221-5fc1660cadec@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> if the rdma device supports sg gaps, we don't need to set a virtual
>>> boundary but we then need to explicitly set the max_segment_size, 
>>> otherwise
>>> scsi takes BLK_MAX_SEGMENT_SIZE and sets it using dma_set_max_seg_size()
>>> and this affects all the rdma device consumers.
>>>
>>> Fix it by setting shost max_segment_size according to the device
>>> capability if SG_GAPS are not supported.
>>>
>>> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>> Changes from v1:
>>> - set max_segment_size only for non virtual boundary devices
>>>
>>>   drivers/infiniband/ulp/iser/iscsi_iser.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Sagi, are you respinning this or ??
> 
> I can take the change-log message and paste it in the code,
> but is that something we want? Usually people look in the
> change-log history...

I actually thought it was already in...
