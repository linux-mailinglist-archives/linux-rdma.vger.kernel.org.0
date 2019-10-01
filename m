Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEA2C36DF
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfJAOR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:17:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37683 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388898AbfJAOR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:17:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so21798740qtr.4
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Ldo0nmTyeRWspPnApnkpUKyeyo+CE9KETJSCDyDGw0=;
        b=Mc80ClD832NXOp7WMLU9e9Lx04bKtICp5FvyhmzE78S4yCkwLb+VEaVbOdJ01DRFpd
         HkJDdci6x+fKSShDM87lfMdrh7Cp/YimdLXOfLVEEWGniDY3Xq9BJlWznrRf6Nht0Eo8
         eq5l6STDA/J7Dsin1G3KNnS8UMiMkEm62DeplV9Yn257++tM7PLdd87mYGIPXux79lXB
         JP445i5tiPz5WOffGb12JWTDa19rxD2xsl9QHuL3VeB8/p/r3I/t4SkTgMnZlDCflM3e
         DILLk3XVKBck8qnX0IxhIVM4YgG2k2bSgph30GxbnHQqrI+DFhnNNOXZkEnGpJH0btvU
         Ai8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Ldo0nmTyeRWspPnApnkpUKyeyo+CE9KETJSCDyDGw0=;
        b=hhsCb2xGt1lUgSc5ju0bXzXTaNsmjCRIF854UyRb6TYrYPNPfo/jakpCTB4QsBZjgc
         PwvbQ/iJRSxIHk+Dhrn7UrRvkGKbcJSZ2FQLpK2oIGBANEcGroI7qacfFcb0qGgukNHd
         +6cfFlmC1/DyFBoW1aONBoqDptBMCtZv97l0srJ8TfGfmx624THrSZM0f5m0+tgPoD5f
         nYPZsry7MFuodrJ0F+ObzgXJI1x7c9NuFrqkQ79DewTwjn9dajSqzMa2hWQxCXjVemYi
         ODQzGVIgmfp22J0L6dtpX1fR1tDJSgG4rFWkc4BCB8sLbYKpbhY7nXAoFb1g9RMHguQq
         zlbg==
X-Gm-Message-State: APjAAAWacplOIzIA4SdhdQ30z9xgFgXsJTvMAuD1x3uvLefdNQ4+jMca
        siVOpiw0qa34QI2SArOs9iZCm6We07w=
X-Google-Smtp-Source: APXvYqzED9ekQKH70Sjv/cYZrnJGE2gxlYNucXF3M8ZSxydEtRv00gmQm5LKpgHsZiRe3Go+LSPWBA==
X-Received: by 2002:a05:6214:281:: with SMTP id l1mr24900082qvv.224.1569939448482;
        Tue, 01 Oct 2019 07:17:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h2sm9433648qtd.14.2019.10.01.07.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:17:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFIxz-0007Ot-Az; Tue, 01 Oct 2019 11:17:27 -0300
Date:   Tue, 1 Oct 2019 11:17:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] RDMA/vmw_pvrdma: Free SRQ only once
Message-ID: <20191001141727.GB28346@ziepe.ca>
References: <1568848066-12449-1-git-send-email-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568848066-12449-1-git-send-email-aditr@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 18, 2019 at 11:08:00PM +0000, Adit Ranadive wrote:
> An extra kfree cleanup was missed since these are now deallocated
> by core.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 68e326dea1db ("RDMA: Handle SRQ allocations by IB/core")
> Signed-off-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-rc, thanks

Jason
