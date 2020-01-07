Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71105132EA3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 19:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgAGSml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 13:42:41 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43131 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgAGSml (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 13:42:41 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so285729qvo.10
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IDWEKh05D6znSbobiI/RW6knXEH+AYJTSjGaIMiPEnA=;
        b=CSzT2P8anTguIcAUFS8dwKN4WP3MYdcoSy62VkC32w3w/K6RChoet9SmhP4RNSLEKm
         weYlFUMUK/MFiAlaBMmorXaY+gXu34whURNFDSYdSeG6OmlW1z9iIlv4SMwmf02bgTZW
         XI44rA1iZww42CGoVV7lCnnUr38jRhNGkf2CHWqSzc9wNeP9KR0vCVPICzgt65haeu0q
         49CRT9LakM1QPoDQX62YbyR3EH0mW2t1zZ8h3bWkGe9yGSAm0i4H8PTEqYg+Exjm4xtq
         MkqrMnLGvbhO5B/Pu3aR00Ao0tf2rmNUtcJ/XKjR4UGqwKrMIfrM6coTPoI7q98CO4mG
         SL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IDWEKh05D6znSbobiI/RW6knXEH+AYJTSjGaIMiPEnA=;
        b=CfzKVztM/oussWsCKp7pq15dLVMEiWNcFi+z7yWfxu6ZjTVaWomLdJZAAQGOhUt//L
         jBcqLG5koxMz5mrPDYP8w9xOKeSUro9A0GaPEW8/PUqHCr/rXyZvFfSSP4k23vIEAdTp
         Db99d0jeXgMsMGvpgXWM/K2z/91jAm4TLaohVqXXpwwWIJu5W0WLTD+ZrVItnQziHSmS
         9wCUeWwu9jUraJIFowv2TBDzyq5wKTQwCVLMImxLIZoe7Qb+51HungDsjt9SM7XjWJ99
         siGcqDkxTdkiyFzE709LFxbEWIL+gjrWmmqbsdAEeMOg1ebPhQloMyOsdEZtiYwVcgoS
         Wu4w==
X-Gm-Message-State: APjAAAXjDTMW+LsLrHMkH6zGV/WwkAf6t8qeRDc3iPcyOvbDwBiFyVjv
        79r3YmzyntvvdtHc/cE4F9tFSg==
X-Google-Smtp-Source: APXvYqyV1s+WSE3xN04uZ0peEgvzLWFfSG8kHN3qCJhac0vYyv3BEgYM9V/L8gxueapNbuwuewiXow==
X-Received: by 2002:a0c:c18f:: with SMTP id n15mr750687qvh.35.1578422559714;
        Tue, 07 Jan 2020 10:42:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d9sm273288qth.34.2020.01.07.10.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:42:39 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iotoM-00028k-NK; Tue, 07 Jan 2020 14:42:38 -0400
Date:   Tue, 7 Jan 2020 14:42:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RDMA/uverbs] RDMA/uverbs: Protect list_empty() by lock
Message-ID: <20200107184238.GA7928@ziepe.ca>
References: <20200106122711.217198-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106122711.217198-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 06, 2020 at 01:27:11PM +0100, Håkon Bugge wrote:
> In ib_uverbs_event_read(), events are waited for, then pulled off the
> kernel's event queue, and finally returned to user space.
> 
> There is an explicit check to see if the device is gone, and if so and
> the there are no events pending, an -EIO is returned.
> 
> However, said test does not check for queue empty whilst holding the
> lock, so there is a race where the existing code perceives the queue
> to be empty, when it in fact isn't. Fixed by acquiring the lock ahead
> of the list_empty() test.
> 
> Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are active user space applications")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 970d8e31dd65..7165e51790ed 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -245,12 +245,14 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
>  					     !uverbs_file->device->ib_dev)))
>  			return -ERESTARTSYS;
>  
> +		spin_lock_irq(&ev_queue->lock);
> +
>  		/* If device was disassociated and no event exists set an error */
>  		if (list_empty(&ev_queue->event_list) &&
> -		    !uverbs_file->device->ib_dev)
> +		    !uverbs_file->device->ib_dev) {
> +			spin_unlock_irq(&ev_queue->lock);
>  			return -EIO;

I noticed this too last month. While this patch is an improvement, I
had written this one which also fixes the wrong use of devce->ib_dev
without a READ_ONCE or locking. It is just winding its way through
testing right now.

What do you think?

From 37ddee0ea682eaf47e6167a090ae0a4e943f7f68 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Tue, 26 Nov 2019 20:58:04 -0400
Subject: [PATCH] RDMA/core: Fix locking in ib_uverbs_event_read

This should not be using ib_dev to test for disassociation, during
disassociation is_closed is set under lock and the waitq is triggered.

Instead check is_closed and be sure to re-obtain the lock to test the
value after the wait_event returns.

Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are active user space applications")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs_main.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 953a8c3fae64bd..2b7dc94b6a7a69 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -215,7 +215,6 @@ void ib_uverbs_release_file(struct kref *ref)
 }
 
 static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
-				    struct ib_uverbs_file *uverbs_file,
 				    struct file *filp, char __user *buf,
 				    size_t count, loff_t *pos,
 				    size_t eventsz)
@@ -233,19 +232,16 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 
 		if (wait_event_interruptible(ev_queue->poll_wait,
 					     (!list_empty(&ev_queue->event_list) ||
-			/* The barriers built into wait_event_interruptible()
-			 * and wake_up() guarentee this will see the null set
-			 * without using RCU
-			 */
-					     !uverbs_file->device->ib_dev)))
+					      ev_queue->is_closed)))
 			return -ERESTARTSYS;
 
+		spin_lock_irq(&ev_queue->lock);
+
 		/* If device was disassociated and no event exists set an error */
-		if (list_empty(&ev_queue->event_list) &&
-		    !uverbs_file->device->ib_dev)
+		if (list_empty(&ev_queue->event_list) && ev_queue->is_closed) {
+			spin_unlock_irq(&ev_queue->lock);
 			return -EIO;
-
-		spin_lock_irq(&ev_queue->lock);
+		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
@@ -280,8 +276,7 @@ static ssize_t ib_uverbs_async_event_read(struct file *filp, char __user *buf,
 {
 	struct ib_uverbs_async_event_file *file = filp->private_data;
 
-	return ib_uverbs_event_read(&file->ev_queue, file->uverbs_file, filp,
-				    buf, count, pos,
+	return ib_uverbs_event_read(&file->ev_queue, filp, buf, count, pos,
 				    sizeof(struct ib_uverbs_async_event_desc));
 }
 
@@ -291,9 +286,8 @@ static ssize_t ib_uverbs_comp_event_read(struct file *filp, char __user *buf,
 	struct ib_uverbs_completion_event_file *comp_ev_file =
 		filp->private_data;
 
-	return ib_uverbs_event_read(&comp_ev_file->ev_queue,
-				    comp_ev_file->uobj.ufile, filp,
-				    buf, count, pos,
+	return ib_uverbs_event_read(&comp_ev_file->ev_queue, filp, buf, count,
+				    pos,
 				    sizeof(struct ib_uverbs_comp_event_desc));
 }
 
-- 
2.24.1

