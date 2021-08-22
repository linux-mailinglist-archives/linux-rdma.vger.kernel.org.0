Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0183F422A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 00:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhHVWcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 18:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhHVWcM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Aug 2021 18:32:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE46C061575
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 15:31:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c19so1518621qte.7
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jknhhatu+ClTZ3AhFRUou0UJJsz++z+Or8pfjtihPEA=;
        b=fIK/UZK3d8gwf6UaP4hmp1Sy2g/FqP7jbNQFwit2ocdzmLW9gki5mV2o+s3lWsbWxC
         eRtFY/GD/AW0LNq7gTEtdlzv7Lj1gzVSEwgqzvsVcjGkmwPJ4yHTwdQ7NlvKiQjItmHS
         124hIqL2q/heqwxPnwc/HpwVFp9Zm/FwNAAXy6X3NbQP/qmIJ20rAZ9Lf7QzvBkq5AKP
         67wHqDd5B9y1UgFBMtC7pHSnc2+uqEdZrh858ZQ3Tzw4/DOrKNmjDAL2I6CpDAyq/sm0
         sLUIAZeMD1KmzafIQ9ctdAb3Bkic9YpdtCKMYw569m4ck9os9zF4V/tps0k9W8rUUH2p
         4kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jknhhatu+ClTZ3AhFRUou0UJJsz++z+Or8pfjtihPEA=;
        b=FMq1rqFGYAB6zrBb1OorC1eabBEM9R2m4ILWc620mVOWSg1px+j4wDvafTKtPncFjK
         hUL7w9bNqSo+4Q6edxMRqa6MYdhBTNV99xEA/KBUpbi/LoS3IIhHlSZac2APrjTLIEeh
         WvfEfxqDKBnYF9lnB60GCT734nen+3tYIE7xnf6HgoeqlHCJFCXLxDnsEbGla6YnqkzJ
         AkVpp9wOqo+ABp0uA5G4KRAZY31m1Cg5ZdpiNC52bvIg45B7Sjcp3cfmGqvLtLxib4kf
         NKoQ+8+wqcC69+likANvCj3ze2aH1BxWtZrOz/a42zdJ9cL0W7fVsKmtnWIa09Zt5nBs
         335g==
X-Gm-Message-State: AOAM532MVdULfgZ5d9PMewMz2C9ZnA7uCc/wd9SoF6gfKZIlK8+loA/6
        Ir5nRhMzxswbvUGOsLKVwnSMqkvOnACRlA==
X-Google-Smtp-Source: ABdhPJyjJDH6c+7ZIvo0q0HBYtMB5RDfYgWlv5mfo6XdM0RMEIzatlwvBroS/yiLCrSBL1VNA21FHw==
X-Received: by 2002:ac8:6054:: with SMTP id k20mr26557500qtm.237.1629671489673;
        Sun, 22 Aug 2021 15:31:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bl26sm6943270qkb.34.2021.08.22.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:31:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mHw00-0035Th-C5; Sun, 22 Aug 2021 19:31:28 -0300
Date:   Sun, 22 Aug 2021 19:31:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Creating new RDMA driver for habanalabs
Message-ID: <20210822223128.GZ543798@ziepe.ca>
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 22, 2021 at 12:40:26PM +0300, Oded Gabbay wrote:
> Hi Jason,
> 
> I think that about a year ago we talked about the custom RDMA code of
> habanalabs. I tried to upstream it and you, rightfully, rejected that.
> 
> Now that I have enough b/w to do this work, I want to start writing a
> proper RDMA driver for the habanalabs Gaudi device, which I will be
> able to upstream to the infiniband subsystem.
> 
> I don't know if you remember but the Gaudi h/w is somewhat limited in
> its RDMA capabilities. We are not selling a stand-alone NIC :) We just
> use RDMA (or more precisely, ROCEv2) to connect between Gaudi devices.
> 
> I'm sure I will have more specific questions down the line, but I had
> hoped you could point me to a basic/not-too-complex existing driver
> that I can use as a modern template. I'm also aware that I will need
> to write matching code in rdma-core.
> 
> Also, I would like to add we will use the auxiliary bus feature to
> connect between this driver, the main (compute) driver and the
> Ethernet driver (which we are going to publish soon I hope).

It sounds fine, as Leon mentions EFA is a good starting point for
something simple but non-spec compliant

If I recall properly you'll want to have some special singular PD for
the HW and some specialty QPs?

Jason
