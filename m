Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365F52694C8
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgINS0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgINS0n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 14:26:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0CC061788
        for <linux-rdma@vger.kernel.org>; Mon, 14 Sep 2020 11:26:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u6so1145768iow.9
        for <linux-rdma@vger.kernel.org>; Mon, 14 Sep 2020 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HCftYW5pkNNqFQk9r9loDTSyMQ5L8NtwKcKDZwlxYLk=;
        b=Fa5o0Q/NOmIT0fIIffUmuT0dvQOCBc1RB4q9emr1qNNhZMql35hB4OkYAn2bYFavFS
         CywAzLGuqK9YAMEjSNre3qyCeQ+6Jk1QIZA41YHRRY9O8VxfJUMBPAdc1vbrnC0fYG9m
         SCmHGma1QaWnMdJNDaiYdCa0DXU6IxEfoO0xcM1PP2QvAnc5tDFuGUiz28vjCKj9zGqg
         jtLWyl8VwfVv1N9qc5fDo5pCB7oPlwJNvZ8/X+6j+s3jUCQV+MHwCi0IKPa1fvE2lYow
         2t0SgKCL6OfVU6prgN9xRhMhZVfOtsWH3AfxMEFCxBC6N94WesFzNV8IfHRwmj/aYYyH
         KilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HCftYW5pkNNqFQk9r9loDTSyMQ5L8NtwKcKDZwlxYLk=;
        b=paDLc+/02yg86BNmqKmIgDGw23AnspGoXsGRvQuvZsvhvjVk45vIadkoTNMXikMiId
         Cg2zZuRnHMPpPTVv/Co8R1St6gVtXgF/r+lS2esGi3lGlcv2d4qeIefBNYWpXioidMJN
         XMHcz1m31DqSkq613rMUO7aGHmKA/lCiMA98mtDcXPcpdIgYH0RGO+qIPjMWUfHlOTC2
         ET9sFu+ueE4t0DPUKFI3YcyzLBG8Q3suDHToDmXWF1j4INfdpheBQpeZvndqO6l9ZuxX
         FINjuHkG3uJgM8qRUAjTliHHMj4nBcq7H0TWdoKu3OSAmfkHtqy0QTyZoWQB7zolHpyd
         Uv0A==
X-Gm-Message-State: AOAM5303AQZI/LhK/lmCbA+hsu29CWx0PM3yG5pOhcURdtbtudMHxDnW
        RLVPqWXC878ANjOZILxD2Yy0Nw==
X-Google-Smtp-Source: ABdhPJzIilL3gBVAJ5MQUxNPv8GKPVyy0BOPwQZk/S/cWkmAPR/JC6FAO7ucFPPPEd5q3angoojnbw==
X-Received: by 2002:a02:ccae:: with SMTP id t14mr6562045jap.63.1600108001940;
        Mon, 14 Sep 2020 11:26:41 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id w22sm6295847iob.32.2020.09.14.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:26:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kHtBX-006E31-IR; Mon, 14 Sep 2020 15:26:39 -0300
Date:   Mon, 14 Sep 2020 15:26:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
Message-ID: <20200914182639.GG1221970@ziepe.ca>
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
 <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
 <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
 <20200824133019.GH1152540@nvidia.com>
 <2a2ff3a5-f58e-8246-fd09-87029b562347@acm.org>
 <20200908182232.GP9166@nvidia.com>
 <e8a240aa-9e9b-3dca-062f-9130b787f29b@acm.org>
 <6c86453d-d7ae-a36b-d827-7812999abc96@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c86453d-d7ae-a36b-d827-7812999abc96@acm.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 11, 2020 at 03:00:30PM -0700, Bart Van Assche wrote:
> On 2020-09-08 19:01, Bart Van Assche wrote:
> > The above patch didn't compile, but the patch below does and makes the hang
> > disappear. So feel free to add the following to the patch below:
> > 
> > Tested-by: Bart Van Assche <bvanassche@acm.org>
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index c36b4d2b61e0..23ee65a9185f 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1285,6 +1285,8 @@ static void disable_device(struct ib_device *device)
> >  		remove_client_context(device, cid);
> >  	}
> > 
> > +	ib_cq_pool_destroy(device);
> > +
> >  	/* Pairs with refcount_set in enable_device */
> >  	ib_device_put(device);
> >  	wait_for_completion(&device->unreg_completion);
> > @@ -1328,6 +1330,8 @@ static int enable_device_and_get(struct ib_device *device)
> >  			goto out;
> >  	}
> > 
> > +	ib_cq_pool_init(device);
> > +
> >  	down_read(&clients_rwsem);
> >  	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> >  		ret = add_client_context(device, client);
> > @@ -1400,7 +1404,6 @@ int ib_register_device(struct ib_device *device, const char *name)
> >  		goto dev_cleanup;
> >  	}
> > 
> > -	ib_cq_pool_init(device);
> >  	ret = enable_device_and_get(device);
> >  	dev_set_uevent_suppress(&device->dev, false);
> >  	/* Mark for userspace that device is ready */
> > @@ -1455,7 +1458,6 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
> >  		goto out;
> > 
> >  	disable_device(ib_dev);
> > -	ib_cq_pool_destroy(ib_dev);
> > 
> >  	/* Expedite removing unregistered pointers from the hash table */
> >  	free_netdevs(ib_dev);
> 
> Hi Jason,
> 
> Please let me know how you want to proceed with this patch.

Applied to for-rc

Thanks,
Jason
