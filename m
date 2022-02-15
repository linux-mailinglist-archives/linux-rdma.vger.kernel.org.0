Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6C4B766D
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiBOUl5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 15:41:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiBOUlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 15:41:55 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3905EC0849
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:41:45 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id x5so4642qtw.10
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sh6scdKJCWH5iEB0aZd0l6CPApvuDAEgo5CITndzg1k=;
        b=eFO3uBM4FBQ+dmZ//mVQU5mJa6z6Ba0XShx9NRGzzWWvGsQPtJ3vJwO0dQD6jaLtFi
         wTLKiEWXR+YtBS+sck6uMRkcm1N9r05eTLXElbaT3daqUa6bOY+bl2bGxZLjhSFes8ZT
         6Q/9/f/HI/FlqLG33VaWCG/8AL8bnuNKKzDBB85Em2YUCcm/wPYINd28A5Paj/kqMjNK
         gI9fLof8bpnqa+zI2qsCqHhuwfHdx2MQKOkiaqUYRzp8uoQZl89kxhMjTPulKaa+TLjw
         6xmWRDizyF3v/E8MYXA1MjVPFgFiOUFOELb2qrRHQ0ilCc9yzcDvRYQPY7Qp5K4zRjOk
         +CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sh6scdKJCWH5iEB0aZd0l6CPApvuDAEgo5CITndzg1k=;
        b=bSNBnu2BZdH8YWHRFpCgcRkYvEGDQDexnjOkIIv4ek9fJkiA/0KYhmlm0KOM7C9+jo
         T/3ttF0QUJZG/YXEVKQjUiSqxPmTDhbxPxUHtwJFWmxo1F5ycKOZq+zTRg5v640Zoqak
         Tld6H/0WYFfznC5tSEJVPWKnVkbsFbSNVolvQCyeuMQ1eXkuguf7OzHjP4xBQi42NpQx
         asOTAotzVLyQU1J1CmiMJAsi67knKdckC0FdkErWW2eNfinUt+8oy4BZyBlDivmJNmYg
         A4mnaT9GU9fsw7MYo6vcjQJLN42WOV76/kw30/252ndZJQU6fq7ptmohiWDsTIfv933R
         kXeQ==
X-Gm-Message-State: AOAM533gNDWG705PTX2HNdyBd6Wl4Pr4XYIUCIJYJFrhCMJLePjCzP/G
        bdLFSgvjG7wYtd8DJ29hnbA8pTXGgj36eQ==
X-Google-Smtp-Source: ABdhPJwdm+sHDkwNmAyH9Xn5fwbNogGhj2uNhdQRaN+SlwgAH0GNgaLegS1PFCqv2e8eB992j9ELaA==
X-Received: by 2002:ac8:5f4a:: with SMTP id y10mr771044qta.378.1644957704358;
        Tue, 15 Feb 2022 12:41:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c14sm20446035qtc.31.2022.02.15.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:41:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nK4dq-004ePo-Sp; Tue, 15 Feb 2022 16:41:42 -0400
Date:   Tue, 15 Feb 2022 16:41:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+831661966588c802aae9@syzkaller.appspotmail.com
Subject: Re: [PATCH 3/3] ib_srp: Fix a deadlock
Message-ID: <20220215204142.GA1037534@ziepe.ca>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-4-bvanassche@acm.org>
 <Ygv2OkMeJYrTwdbi@unreal>
 <a281d1be-857e-be6a-0440-648bed837d4e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a281d1be-857e-be6a-0440-648bed837d4e@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 12:37:43PM -0800, Bart Van Assche wrote:
> On 2/15/22 10:51, Leon Romanovsky wrote:
> > On Tue, Feb 15, 2022 at 10:26:50AM -0800, Bart Van Assche wrote:
> > > diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> > > index 2db7429b42e1..8e1561a6d325 100644
> > > +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> > > @@ -4044,12 +4044,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
> > >   		mutex_lock(&host->target_mutex);
> > >   		list_for_each_entry(target, &host->target_list, list)
> > >   			srp_queue_remove_work(target);
> > > +		list_for_each_entry(target, &host->target_list, list)
> > > +			flush_work(&target->tl_err_work);
> > 
> > Sorry for my silly question, but why do you do flush and not cancel
> > here? You anyway remove SRP device, so the result of flush is not
> > really important, am I right?
> 
> That's a great question. It probably doesn't matter much whether
> flush_work() or cancel_work_sync() is called in this context since
> srp_queue_remove_work() indirectly cancels tl_err_work. See also the
> following code in srp_remove_target():
>  	cancel_work_sync(&target->tl_err_work);

If it is already canceled then why call flush?

Jason
