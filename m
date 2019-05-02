Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDECA11C24
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 17:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBPFy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 11:05:54 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41854 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBPFy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 May 2019 11:05:54 -0400
Received: by mail-yw1-f67.google.com with SMTP id o65so28877ywd.8
        for <linux-rdma@vger.kernel.org>; Thu, 02 May 2019 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tK7VWO/8zHsLCTty7EjdeKzrTs/ds+R4tFdQiPhlxog=;
        b=kVYrWOu1lIDap8r1SI/7HenVKYmULQK1q5x98uzb1qpscpy8L27I9ONv5vy41js5uE
         SWL1lN6s5S1cK2VphCACboFNylVoaitRnyIHbt8lbcqa15X9wutQM5CvBhSUriPvF54/
         eMRRN9hPrqRuvpFmCFase7iIVGwkUY0lFnpMIstYbA506cxONfKz5t4FUsT7MtQ2L4IO
         TkGHfLw/7tr5bT99fwB7iWS+OPO9Hlpn/iUg2QWwYpV7LSLBwnXVEFFzWqCwONzau2Dh
         WzvOfu5wf0lluLdHhS+WPpda3pKm04gGDfgpgIAMcotttIj2zSd7zmmxInAridutmkqB
         J1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tK7VWO/8zHsLCTty7EjdeKzrTs/ds+R4tFdQiPhlxog=;
        b=NtmdV5+48YgZYfPJCGYDm9C39d9xoztqTK6Ggsa0lbHXNMLRFIIwuQebnIipQfpGnF
         IyD9AxjulaoV5VZ07tpFy5QC0X/MXvs7c8KpzOEFVJFxw36eO/icH7taxRWcZcVoZKvt
         tQqc8VkM5Pnn6vWQ57a0hEvDz8czRopzQguAON4tJGoa6pjVS9MhrYfFKQFM7+aZ6bpU
         mCyWnaZ42wHywxdh22p5nTiRImbM6aOa7PVRB+i00DI1GNtshI1ufw/R1Jt1y87h6CHY
         A8+r9xlb+lsreOd8zP7j+XY4mZsWWIXyhscxBEQ1PZ9szkudgpypaftQy6/HbwfvRKm6
         VjuQ==
X-Gm-Message-State: APjAAAUqRnUcQlo5s05QzRMJ9QMO65kKM4GiDD0YY8m0D6Iol+rKUMqN
        vnj0fjgnuT/YQ5zxG1Vt1HTuPFTXVlE=
X-Google-Smtp-Source: APXvYqzyM96G/Fche8XpNpVH5+WveDg+JX9M9MrWDJIgn7X6F9OyScLynXOAgiRKgOYwei0k2CRmNg==
X-Received: by 2002:a25:ba4d:: with SMTP id z13mr3508226ybj.355.1556809553762;
        Thu, 02 May 2019 08:05:53 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id v144sm2242574ywv.15.2019.05.02.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:05:52 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hMDHT-0005fV-9J; Thu, 02 May 2019 12:05:51 -0300
Date:   Thu, 2 May 2019 12:05:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Introduce ratelimited ibdev printk
 functions
Message-ID: <20190502150551.GD18518@ziepe.ca>
References: <1556807923-20403-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556807923-20403-1-git-send-email-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 02, 2019 at 05:38:43PM +0300, Gal Pressman wrote:
> Add ratelimited helpers to the ibdev_* printk functions.
> Implementation inspired by counterpart dev_*_ratelimited functions.
> 
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> This is a followup patch to the addition of ibdev printk helpers to the
> subsystem.
> 
> From quick grep of infiniband drivers, some of the drivers will need this
> variation when starting to use ibdev printk functions. In addition, I plan to
> use them in EFA as well.
> ---
>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

I think we should wait till we get conversions patches that need
this..

Jason
