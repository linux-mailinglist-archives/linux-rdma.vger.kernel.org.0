Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965B94DAE3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 22:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFTUFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 16:05:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46365 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfFTUFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 16:05:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so4449629qtn.13
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=knCs9srDHt7l15akpgSnFLDDh60Wu5Uq6lytiVry/kg=;
        b=FjrjVRCuWgSFlTWzWHh+Oh0WUfGrrjaCybgwT/qXv1zz7bKkBeoUFcEuUShjHXnIwN
         etWZrJt+Py0yUSi24MJUTzhM0e5EkKfHw9ILtvL8CUdhMVTg3ggozLh2GN2SsfyVo7Ju
         DitWp1p/AFu6DibaFauSOUYdKWYD6T57qx4zbw5U0VSDAdjKb64pHB1EDo8phLgEcpdl
         PHQhy3/lfAoPy0ek8T9cXil7ABU3eLgw+4WEwrIfAbtLqzEDUxjr+rKJDO5QO3LlfO9q
         LbXwrnD245hkVUzP57WPXEEVbGGAKUonTJBSHr/trNq+ul3o4XFPi2cZE7agEAnZXUyF
         DX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=knCs9srDHt7l15akpgSnFLDDh60Wu5Uq6lytiVry/kg=;
        b=s8B3xwmrGz7ga3pFW4cWrDYySNbOpA12fNv8iJfxSluT0DSxtIqncD8OpcL4jVJMFN
         aphgf+8ktUPwsZQHxG9aIvqtyTxFgPDLDuNPRZAbtdQT818KAY5dwJsU7ytSRMg+R4mi
         7a2ddoxanDwSNxxhP7/WxcJnjuJHdu8YUM4opZseNHR2mAHrAbHkW5u94qN4dQsKnlQy
         PNWq0Dc0n6+mwtoTuWt4Avjz7AeLWqnir7khQ6RW8FooSb+cVLW3Y+dMT+KtI7xGn3DI
         mB9aiQPNyqVgWQ2QGfgPOmDAecwMUSPS3nE6obGjtFBkNfjObbenKqO3wGDADMJ8Vs/Q
         3wnA==
X-Gm-Message-State: APjAAAUkjL4ClFp4wunZPN8KeiII8FfJiJx3j8agxIt4f61mWTXsH6pn
        d9h9yFZepZ7SbI5JcE/Slwontg==
X-Google-Smtp-Source: APXvYqx/uGWpc+vF4gIW3Ni9B6M6McfOfopK4pc1tf2Fg1z9/G6tYvLgzoXxt9dzvyfv7Btb98vmYQ==
X-Received: by 2002:ac8:3078:: with SMTP id g53mr110808407qte.126.1561061134842;
        Thu, 20 Jun 2019 13:05:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z18sm382917qka.12.2019.06.20.13.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 13:05:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he3JN-0006wP-SN; Thu, 20 Jun 2019 17:05:33 -0300
Date:   Thu, 20 Jun 2019 17:05:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Lijun Ou <oulijun@huawei.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing module
Message-ID: <20190620200533.GH19891@ziepe.ca>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
 <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
 <20190620193457.GG19891@ziepe.ca>
 <9862d4db3e930bc12c059f8b04e1eb24c493519b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9862d4db3e930bc12c059f8b04e1eb24c493519b.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 03:48:23PM -0400, Doug Ledford wrote:

> It's an msleep() waiting for a hardware command to complete.  Waiting
> synchronously for a command that has the purpose of stopping the card's
> operation does not sound like an incorrect locking or concurrency model
> to me.  It sounds sane, albeit annoying.

If it was the only sleep loop you might have a point, but it isn't,
every other patch series lately seems to be adding more sleep
loops. This sleep loop is already wrapping another sleep loop under
__hns_roce_cmq_send() - which, for some reason, doesn't have an
interrupt driven completion path.

Nor is there any explanation why we need a sleep loop on top of a
sleep loop, or why the command is allowed to fail or why retrying the
failed command is even a good idea, or why it can't be properly
interrupt driven!

I'm frankly sick of it, maybe you should review HNS patches for a
while..

Jason
