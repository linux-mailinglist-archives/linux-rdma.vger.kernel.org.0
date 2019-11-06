Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68548F1C76
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfKFR0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 12:26:55 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45908 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfKFR0z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 12:26:55 -0500
Received: by mail-qv1-f67.google.com with SMTP id g12so1749455qvy.12
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 09:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1GBX1d/duL8sRvYSR5e7E0484c/WNKc0ZRscUH8jCzY=;
        b=cq/eK7yGrdg7/vdvwU51CJ/7HoAqBhXRJnwQgaZbM6Qhg/OUo/hLjmJ5iJSy2irn+H
         MXFOlAPnRMvzQTvTRvgoNFc1n/j1Z8h8A49rDihLTQ7jaG0SS+PbsXh8lCflTLAhXg96
         vjH2pf/3WwsDvuv1zCnIFsrrnPi7+m8EmfHflMo+sFZymwwwqwtmzHJHCmtaqQQCY3uA
         23WNPuAvxMH6I0Jti9vLIWqEsnBLkbJavQB8tAerckZyIgKqSaZdUdxnk3T5akfDn04B
         8K7NcgZrO7CqA9yxTQTO5I/W59jHWaizI3ErpM4cLBLh6Pw93bBQ3ExikEZzuvO/l1IB
         kYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1GBX1d/duL8sRvYSR5e7E0484c/WNKc0ZRscUH8jCzY=;
        b=P24rHjdMkkCUOU4mbrudrF+KpQsfySwR/AFlGRx4c3Z8pWjpugo4vCrJHUEj2tHMrb
         cBT+/vZCNAtXXYkhiYPWPUz0+o3kcsfiFQ/vp4SjIq9CaVImSPO/p811j2+a7XXOR4fs
         WSRQwrwQxpaHV0o1k/7m0rGWjTOIjfP0WI8guZvT2px6ky/34hx+WcDXmAQJAEipHUF4
         sGbX/nCkdY3TElXRN6wz6hRrDgJzlu861q5GkkNg5TCMZ5SB5a4UNKoJqOMZ83iklQ1B
         FLWSX4opUkwLw8/GJdTE8LC7Rt/Fo6PK4D+EKdtAcfhwlfc0fgkPfHEoBu+mMoHOW2iR
         YrYQ==
X-Gm-Message-State: APjAAAXs4n1oy3O35ZzV4TeMWk/tqpXdcubfjMhV8X2bJyQOc+qMosx3
        ITplkfc3Cffi0pQd0orp7J/Rxw==
X-Google-Smtp-Source: APXvYqxzMoFxhiexhfozKw46NPhFQbKlMnEL8bhtYhxSQAjCwmDHM9T29zOS0214ygYchzqm55/b6A==
X-Received: by 2002:a0c:b620:: with SMTP id f32mr3347234qve.186.1573061214378;
        Wed, 06 Nov 2019 09:26:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x133sm12044284qka.44.2019.11.06.09.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 09:26:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSP53-0003Mf-Ci; Wed, 06 Nov 2019 13:26:53 -0400
Date:   Wed, 6 Nov 2019 13:26:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/4] Few more rc fixes
Message-ID: <20191106172653.GA12905@ziepe.ca>
References: <20191025161717.106825.14421.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025161717.106825.14421.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 03:58:17PM -0400, Dennis Dalessandro wrote:
> Here we have 4 more bug fixing patches. These are all marked stable as well so
> it would be good to get these in to 5.4 if possible.
> 
> The allow for speeds patch is not a "feature" it is a bug that causes problems
> if the host comes up in gen4. Is very small. The other 3 from Kaike fix TID RDMA
> bugs. A few more lines of code here but all relegated to TID RDMA.
> 
> 
> James Erwin (1):
>       IB/hfi1: Allow for all speeds higher than gen3

With v2 of this one

 
> Kaike Wan (3):
>       IB/hfi1: Ensure r_tid_ack is valid before building TID RDMA ACK packet
>       IB/hfi1: Calculate flow weight based on QP MTU for TID RDMA
>       IB/hfi1: TID RDMA WRITE should not return IB_WC_RNR_RETRY_EXC_ERR

Applied to for-rc, thanks

Jason
