Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB54E864
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUM5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 08:57:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41507 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFUM5w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 08:57:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so4298106qkk.8
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iIzvKi0Su/nt5uAHmnsT/NIZbCkI4/tmyRA7z4PoVnk=;
        b=R7O+n6yGe7b4pwnoflXN2w/ow2LLVjFkt851Al8I+iIj2u+Umz1rqjmEtoVl44ESJc
         /K7elOqjvXC9ZN9d3kCa5bDVrqYpcYZ8gMQzhTWRgFpGZC5IYskaOcwqF60Aw1/t2F1y
         WKn0xIe7bFoU3AJvfv+5qOnCbtC8kZLUvifSQj4DkjX9QzmwLE+4xaq9UJADotdzO+fc
         ATIe2fJn3QH1Ofx+XQwZW/wok2OkH0o18L5UD4gnPDa/lzMxiQmxYkicXaB8NFsO8oYS
         41CUJe3ZiirGZHmwcvs9U2s3FROH4EVYUoDlvHj8OQSYcBk+p1EECKScbAcHDdlAgMBJ
         e6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iIzvKi0Su/nt5uAHmnsT/NIZbCkI4/tmyRA7z4PoVnk=;
        b=TkexZOVk7SsvvANBntajcoki1U0k4bD8BviOCjzMdRXY2grEeTiRwuimEqfQ0VmFcm
         /L4MUf/FXez3C8KCU1auyenNmrYHuRoNBO4bK+WIRJ5g969il0eiumRLV033HbMwveEZ
         4x64T/0s8VaCF27d0pw2oy1cQIzehcVvOLaUciRIJTtUjbI/lj7OCMWh/vSUuJ6yVmht
         TQ5uojdGtdS9U3K8tVTIFbwo4m43pxT78Ytt7f7eiQiYbUWUmjWMIKYA54/LPqSHDQic
         f86H9NJyBOy5VsgoqIqmeHM2LNqxeqNWmkE7CoQr9LYnaAILqhWs1qeXNEVxE3a67M09
         W6Xg==
X-Gm-Message-State: APjAAAXezoCIPuUy/QnUtvLOjO9FgVQqN7CmqI2bct/QRboVniMnALhk
        e0POMFgm4SBU2fSFtZtOm+kWoQ==
X-Google-Smtp-Source: APXvYqy3+M8FT9dU+3cDovn5GB8maGyqvfisai9C57loTdVWvmrWeen4vINlupbpSDp58peCtKiyFA==
X-Received: by 2002:a37:6650:: with SMTP id a77mr5519339qkc.452.1561121871708;
        Fri, 21 Jun 2019 05:57:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p31sm1701956qtk.55.2019.06.21.05.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 05:57:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heJ70-0007uY-NU; Fri, 21 Jun 2019 09:57:50 -0300
Date:   Fri, 21 Jun 2019 09:57:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Lijun Ou <oulijun@huawei.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing module
Message-ID: <20190621125750.GJ19891@ziepe.ca>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
 <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
 <20190620193457.GG19891@ziepe.ca>
 <9862d4db3e930bc12c059f8b04e1eb24c493519b.camel@redhat.com>
 <20190620200533.GH19891@ziepe.ca>
 <54fedcfc1ffc92a5446c2f720c7dd57776333ef1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fedcfc1ffc92a5446c2f720c7dd57776333ef1.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 04:30:03PM -0400, Doug Ledford wrote:
> On Thu, 2019-06-20 at 17:05 -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2019 at 03:48:23PM -0400, Doug Ledford wrote:
> > 
> > > It's an msleep() waiting for a hardware command to
> > > complete.  Waiting
> > > synchronously for a command that has the purpose of stopping the
> > > card's
> > > operation does not sound like an incorrect locking or concurrency
> > > model
> > > to me.  It sounds sane, albeit annoying.
> > 
> > If it was the only sleep loop you might have a point, but it isn't,
> > every other patch series lately seems to be adding more sleep
> > loops. This sleep loop is already wrapping another sleep loop under
> > __hns_roce_cmq_send() - which, for some reason, doesn't have an
> > interrupt driven completion path.
> > 
> > Nor is there any explanation why we need a sleep loop on top of a
> > sleep loop, or why the command is allowed to fail or why retrying the
> > failed command is even a good idea, or why it can't be properly
> > interrupt driven!
> > 
> > I'm frankly sick of it, maybe you should review HNS patches for a
> > while..
> 
> Are you sure this hasn't changed over time and you didn't realize it? 
> I'm not seeing all the sleeps you are talking about. 

It is because I wasn't applying those patches :)

> In fact, if I grep for "sleep" in hw/hns/ I only find 9 instances: 5
> in hns_roce_hw_v1 and 4 in hns_roce_hw_v2, so really only 5 at most

Most of our drivers have 0 sleep loops (excluding the hfi/qib
uglyness), so 9 is aleady absurd for a 2010 era driver.

Jason
