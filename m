Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A60109485
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 21:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKYUIJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 15:08:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32878 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYUIJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 15:08:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id y39so18683800qty.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xnKRBuGpbapwl5qx4tOnjv58lsXYoNDPMkQeB9na7sM=;
        b=jEJAc6l8Og8mswOwJIYjQxjxJ8ELKtVuERyuOyp+51Hx6FPf2NKZvtwH/GvpgKbVOC
         +N87m/b+mPLoXYS6rnSZTbpf8oxCiczMY4ZaNXXwNLnFzv2A7+InNSZiRfqnDFv8hAAv
         ap9uldbLa0UtqYc/DBhQxCnfWU4nuaABIOOTrlWHAeHwbUniN/jraoB7QKjSya8f1tXI
         NFX6ELEvSrfxn+HnUbl05N8TUb2ecx8eS359c/GQHooL/3BR9ZzZWJ7gQjoDZdgOXkOP
         Gb1zSw6c8Ro+Qf4nLFaBZYTSNJnmNGq+gXpDfUNJtSMXBKbJ3KOPLA5f0jeczPR30UGW
         Fagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xnKRBuGpbapwl5qx4tOnjv58lsXYoNDPMkQeB9na7sM=;
        b=nh9s/NQ9+oo+h8l0jLfUFP9cpD/p3IVZVHLrOh37xS1Idonk9sNQwJccERCGX657r9
         ky6UM2VV+k2rVm6QHVY7YBlUtHAkwNoJEz9xFjPr99RgY3NCNISdgHYyaMxYDCcRMK6V
         4YMK3qJXaf/gK7TTel2/uSJ+ffyWi9wjiKaOz3RDhwpYPPpzTbpWZVslftd0B2VAua+y
         4XfoT+I55RtD+qyQZDXzMFhcoMyseTMfA7Xb8Fhr0QEYM8TZhwLb058o+1TeouIW3Gxr
         +ae6H9eCJvwtiiJcyCOODFl1mYMXV9O3UY3ryaHMCtGKtsV1zkvG7iryzLy5PzgsxNMc
         3R+w==
X-Gm-Message-State: APjAAAU0QREmCKeMCoCb4/m1bzbL/3lA93CmBtdHbYkEn/Yau/qu/Pdr
        2mOerDF6o5VnQnD1JPf5G9e5dw==
X-Google-Smtp-Source: APXvYqwkk9bKxhaeHcT9UzPJEELRlFai1GTqvW4eF5PcDqejFR2WYQ2+lPLeCVqcK65jUSmNTQxm0w==
X-Received: by 2002:ac8:721a:: with SMTP id a26mr30548586qtp.208.1574712488391;
        Mon, 25 Nov 2019 12:08:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id e10sm4565381qte.51.2019.11.25.12.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 12:08:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iZKeV-0005SQ-Ay; Mon, 25 Nov 2019 16:08:07 -0400
Date:   Mon, 25 Nov 2019 16:08:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     linux-rdma@vger.kernel.org, allenbh@pensando.io
Subject: Re: [PATCH] rdma-core: Recognize IBV_DEVICE_LOCAL_DMA_LKEY in
 ibv_devinfo
Message-ID: <20191125200807.GF11270@ziepe.ca>
References: <20191125152237.19084-1-aboyer@pensando.io>
 <20191125175603.GB11270@ziepe.ca>
 <77FA0F51-7A7D-42E3-AC2A-BF65550A4396@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77FA0F51-7A7D-42E3-AC2A-BF65550A4396@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 02:32:31PM -0500, Andrew Boyer wrote:
> 
> > On Nov 25, 2019, at 12:56 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Mon, Nov 25, 2019 at 07:22:37AM -0800, Andrew Boyer wrote:
> >> This bit is defined in the kernel but not displayed by ibv_devinfo.
> >> 
> >> Signed-off-by: Andrew Boyer <aboyer@pensando.io>
> >> libibverbs/examples/devinfo.c | 3 +++
> >> libibverbs/verbs.h            | 1 +
> >> 2 files changed, 4 insertions(+)
> >> 
> >> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> >> index bf53eac2..e3210f6e 100644
> >> +++ b/libibverbs/examples/devinfo.c
> >> @@ -220,6 +220,7 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
> >> 				   IBV_DEVICE_RC_RNR_NAK_GEN |
> >> 				   IBV_DEVICE_SRQ_RESIZE |
> >> 				   IBV_DEVICE_N_NOTIFY_CQ |
> >> +				   IBV_DEVICE_LOCAL_DMA_LKEY |
> >> 				   IBV_DEVICE_MEM_WINDOW |
> >> 				   IBV_DEVICE_UD_IP_CSUM |
> >> 				   IBV_DEVICE_XRC |
> >> @@ -260,6 +261,8 @@ static void print_device_cap_flags(uint32_t dev_cap_flags)
> >> 		printf("\t\t\t\t\tSRQ_RESIZE\n");
> >> 	if (dev_cap_flags & IBV_DEVICE_N_NOTIFY_CQ)
> >> 		printf("\t\t\t\t\tN_NOTIFY_CQ\n");
> >> +	if (dev_cap_flags & IBV_DEVICE_LOCAL_DMA_LKEY)
> >> +		printf("\t\t\t\t\tLOCAL_DMA_LKEY\n");
> >> 	if (dev_cap_flags & IBV_DEVICE_MEM_WINDOW)
> >> 		printf("\t\t\t\t\tMEM_WINDOW\n");
> >> 	if (dev_cap_flags & IBV_DEVICE_UD_IP_CSUM)
> >> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> >> index 7b8d4310..81e5812c 100644
> >> +++ b/libibverbs/verbs.h
> >> @@ -112,6 +112,7 @@ enum ibv_device_cap_flags {
> >> 	IBV_DEVICE_RC_RNR_NAK_GEN	= 1 << 12,
> >> 	IBV_DEVICE_SRQ_RESIZE		= 1 << 13,
> >> 	IBV_DEVICE_N_NOTIFY_CQ		= 1 << 14,
> >> +	IBV_DEVICE_LOCAL_DMA_LKEY	= 1 << 15,
> >> 	IBV_DEVICE_MEM_WINDOW           = 1 << 17,
> >> 	IBV_DEVICE_UD_IP_CSUM		= 1 << 18,
> >> 	IBV_DEVICE_XRC			= 1 << 20,
> > 
> > This flag really only has meaning for the kernel, it should come out
> > of the uapi at all.
> > 
> > It is a mistake that kernel internal bits have been mixed in with
> > userspace bits.
> > 
> > Jason
> 
> Isn’t there value in having the userspace tools tell the user about
> a device’s in-kernel capabilities?

Sure, but that is more a rdmatool thing, not uverbs

Jason
