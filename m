Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4BF3736
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 19:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKGS2x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 13:28:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35013 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGS2w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 13:28:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id r22so3458551qtt.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Nov 2019 10:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNPboToYQsDrYFLa5mvtOLquidRCxYvkeaPflRLfzTM=;
        b=RDeJKs/oSHpmmF84mIBcAGbcWc0Yn9bcvez8xIYnJvWWsODmo+P29A9HLAMrxRKDYR
         jzyN2EUN2e747WTyepY+O8V7BREa1hAVHJ0Tcv6nlxXnZMxxnAwTuVjeV9zwBYNfRjEg
         GoctGKIivaa4+g68GNitWH0COvaO2MiEmN7Wj68GV+k/i49jUlypqtpQvzyR47mc/U3h
         vBWEcJRVHNVFxMSws3pezeeBqJOFdus8YyS7NNPOOx9ziETaB5665e+be1YPvWWGiQCb
         dMi/dXHB42STJik3K09YsVhrEzQsWd13vi8Tq2Sqb5CdLYoWNySvs/MuYMQ+Jatp9vGa
         GCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNPboToYQsDrYFLa5mvtOLquidRCxYvkeaPflRLfzTM=;
        b=FYXTQ2JeGc53fpEUr7eZ1wOFLEXUAoPX28yw8Tq+zqZ85DqSIV200tAIeVILjz1MjC
         GEFUF7mr2dNLQddeUp6lAe0D4gRyvJB3X58UeWEvomP2g7M3v+EW0MGVCJlmFdxkLzjT
         B7ap95m6fF5oq4EHCkvOOXUze76ZCmkv5wE0IPCaj9k2pNMWrwQ6j7UYLb8aM+Q4gkqz
         LDgAjSyQzx8e335C6A3MoNLpjeDZ/tn0zow5O+MranWEjXND4YUAqVZg9RpecFbTn8sf
         RGrMw43Ky0Kup+AyLXbgzZKhNiey+XHNbvUe0bSMQRTW1qqWoUzW9SMutOXthPnUeUyF
         MU4w==
X-Gm-Message-State: APjAAAW5FLxgi06Upv28d7xaOwDrjaw2luxSN6fkoZ0RTmLXMNt4vcp3
        hIjSMxmVJ2Ms5pUb5mxa7AH/GA==
X-Google-Smtp-Source: APXvYqzPfA65QKpOwrFcrHIr1/vyL1Ow3toq3AVNa3J+WHRbJxBf6/kalFE+OQQghCyDpnW9FPclXQ==
X-Received: by 2002:ac8:2dfd:: with SMTP id q58mr3753686qta.283.1573151331744;
        Thu, 07 Nov 2019 10:28:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v54sm1578625qtc.77.2019.11.07.10.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 10:28:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSmWY-0007kC-FT; Thu, 07 Nov 2019 14:28:50 -0400
Date:   Thu, 7 Nov 2019 14:28:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
Message-ID: <20191107182850.GB6730@ziepe.ca>
References: <1572255945-20297-1-git-send-email-liuyixian@huawei.com>
 <1572255945-20297-2-git-send-email-liuyixian@huawei.com>
 <20191106204013.GA26459@ziepe.ca>
 <e2e0f478-a057-c297-7e1e-d9b09eee2986@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e0f478-a057-c297-7e1e-d9b09eee2986@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 08:48:25PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2019/11/7 4:40, Jason Gunthorpe wrote:
> > On Mon, Oct 28, 2019 at 05:45:44PM +0800, Yixian Liu wrote:
> >> @@ -1998,6 +2000,17 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
> >>  		}
> >>  	}
> >>  
> >> +	snprintf(workq_name, HNS_ROCE_WORKQ_NAME_LEN - 1,
> >> +		 "hns_roce_%d_flush_wq", device_id);
> >> +	device_id++;
> >> +
> >> +	hr_dev->flush_workq = alloc_workqueue(workq_name, WQ_HIGHPRI, 0);
> >> +	if (!hr_dev->flush_workq) {
> > 
> > Why is this so time critical?
> 
> Hi Jason,
> 
> I am not quite sure whether you concerned with the flag "WQ_HIGHPRI" or
> why WQ is created in hns_roce_v2_init.

Yes, why do you need a dedicated HIGHPRI work queue.

> If it is WQ_HIGHPRI, yes, it is much better to implement flush operation
> ASAP to help generating flushed cqe as ULP may poll cqe urgently. If you
> concerned allocation stage, as flush operation is support for hip08 only,
> there is no other place proper than here I think.

Why? This is only something that happens in error cases.

> > Why don't you do this from hns_roce_irq_work_handle() ?
> 
> As described in the cover letter, here we used CMWQ (concurrency management workqueue)
> to make sure that flush operation can be implemented ASAP. Current irq workqueue is
> a singlethread workqueue, which may delay the flush too long when the system is heavy.
> 
> Do you mean we can change irq workqueue to CMWQ to put flush work into it?

As far as I could tell the only thing the triggered the work to run
was some variable which was only set in another work queue 'hns_roce_irq_work_handle()'
 
> >> +}
> >> +
> >> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> >> +{
> >> +	struct hns_roce_flush_work *flush_work;
> >> +
> >> +	flush_work = kzalloc(sizeof(struct hns_roce_flush_work), GFP_ATOMIC);
> >> +	if (!flush_work)
> >> +		return;
> > 
> > Don't do things that can fail here
> 
> Do you mean that as "GFP_ATOMIC" is used, the if branch can be deleted?

No, don't do allocations at all if you can't allow them to fail.

Jason
