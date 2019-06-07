Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FCF38C27
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfFGOC6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 10:02:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46220 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfFGOC6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 10:02:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so1215213pgr.13;
        Fri, 07 Jun 2019 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68ICi0Q7U0ttYWfN++mrNZhk/b+PX3pnjnB9aataB/A=;
        b=E/SuZbOmURSZg1UrOstXwSCITcpxwhnij+TjkLJ17FQSjAy4rVOadjIhEj78x/+8CU
         0lmWcDhwsMTM0V9Z+kEPHXyET3eVmt7Jl9ShxqwNzG4D1RknSAmWxI/gFCtA3wWgv98z
         VtvkPjJ6akhI6qg9B5abrfy5HYvMhtVVO299g4EWn9/JFjVXQvuRQ6t0bfHMgZcYaWt8
         FGP+YjxtNaHNAgz9hn18ZT4e8giSIA/a6kRitKgo1TaNop4Xu/oybM8Bcns5jSaXKnsu
         28Y7zE4Czw/3xyWmSANMafmNJzVVFiAX15JUYkcGX9CWHKxQaD3GpmUXMHvDwk8t3Ne6
         Fzqw==
X-Gm-Message-State: APjAAAXqCVquapcu9719cSwWW3DOtIVlhFVKafcJFCjDtPhpDrZuCMoU
        lLTqh6i5AQ5xbncaOcmTlt8=
X-Google-Smtp-Source: APXvYqwpMNr2WuD0b5sWV1d6WkBoJq5LV51y0DHD4l+25+q8Xm1ZPPRZvXfP5j1dzMAZrBqKLkBRQw==
X-Received: by 2002:aa7:9834:: with SMTP id q20mr16121656pfl.196.1559916174777;
        Fri, 07 Jun 2019 07:02:54 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id j64sm5641691pfb.126.2019.06.07.07.02.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:02:54 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: explicitly set shost max_segment_size
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20190606000209.26086-1-sagi@grimberg.me>
 <20190606063600.GB27033@lst.de>
 <ae65c220-193c-e526-57da-17b50820b015@grimberg.me>
 <20190606070403.GA27627@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c8f69f05-a0b6-b9b5-98c6-95cb8c910659@acm.org>
Date:   Fri, 7 Jun 2019 07:02:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606070403.GA27627@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 12:04 AM, Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 11:47:23PM -0700, Sagi Grimberg wrote:
>> Not sure I understand.
>>
>> max_segment_size and virt_boundary_mask are related how?
> 
> virt_boundary_devices has hardware segment size of a single page (device
> page as identified by the boundary, not necessarily linux PAGE_SIZE).
> So we don't need a max_segment_size in the Linux size, as any amount of
> hardware segments fitting the virt boundary can be merged into a 'Linux
> segment'.  Because of the accouting for the merges is hard and was
> partially broken anyway we've now dropped the accounting and force the
> max_segment_size to be unlimited in the block layer if a device sets
> the virt_boundary_mask.
Hi Christoph,

What if that accounting would ever be implemented in the block layer? 
Would that mean that v2 of this patch becomes incorrect and has to be 
changed back into v1 of this patch? Is v1 incorrect today?

Thank you,

Bart.
