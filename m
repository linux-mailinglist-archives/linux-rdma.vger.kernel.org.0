Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8801BF566
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfIZPBN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:01:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34594 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIZPBN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:01:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id y35so1746906pgl.1;
        Thu, 26 Sep 2019 08:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V6OEDSg3Eh3+cw9Wul3ZcjAozpdG82PaFBx486g+mfI=;
        b=Zk2AGYfZzA9wIIcaKbkFIZmYPGLMycZHwl3ee4WPQfg/I6UWJW11fxcAXFRD3vIQ3K
         JggD5cAiRkNARCDexJQPf3LTmFCPXp1hjnyjScfRqMZ5gETdKCvkH6eyBGBBnAnNJeH8
         zy2WNu1g8iEbtn3aeM3iwzuULUFR/rYJRUC5lBxcCKyaSA7DpSzTTr3dQOCT1bOyor1Z
         0Xvd8Lj+q+PwZSNcx0RVQtqTmSLfFU2/U1wmHb8jNTsEM2y/idolD2hjQhUdCBHyFSlM
         V1clcmv+3X+5mZRCitrw569e9ZfOxlKSL/pXYlozIdjXqBVSlhxEWBGeKpUkQqyvwRBd
         IK/Q==
X-Gm-Message-State: APjAAAVPWvi3NxoKmZ44Fagb1DPqLc3kqmv9Vpan+n8sc68nSfrWKe15
        8BuvXQvreXuYVTSOLRcyKZY=
X-Google-Smtp-Source: APXvYqyCKN9e4LROHfH5S/SbBSnZweni4d/qbumk7xMjpF9CmZlAsmvtvGxv+1PHVmXmjwBfptijsA==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr4052819pjb.1.1569510072170;
        Thu, 26 Sep 2019 08:01:12 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id bb15sm2184066pjb.2.2019.09.26.08.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:01:11 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Roman Penyaev <r.peniaev@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
 <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
 <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
 <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
 <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org>
Date:   Thu, 26 Sep 2019 08:01:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/19 2:55 AM, Roman Penyaev wrote:
> As I remember correctly I could not reuse the whole machinery with those
> restarts from block core because shared tags are shared only between
> hardware queues, i.e. different hardware queues share different tags sets.
> IBTRS has many hardware queues (independent RDMA connections) but only one
> tags set, which is equally shared between block devices.  What I dreamed
> about is something like BLK_MQ_F_TAG_GLOBALLY_SHARED support in block
> layer.

A patch series that adds support for sharing tag sets across hardware 
queues is pending. See also "[PATCH V3 0/8] blk-mq & scsi: fix reply 
queue selection and improve host wide tagset" 
(https://lore.kernel.org/linux-block/20180227100750.32299-1-ming.lei@redhat.com/). 
Would that patch series allow to remove the queue management code from 
ibnbd?

Thanks,

Bart.
