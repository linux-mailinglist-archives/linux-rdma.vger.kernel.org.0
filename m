Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CC1797D9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgCDS17 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:27:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36608 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgCDS17 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 13:27:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so2135390qto.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 10:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6284/+o4WmhRyX/T6Efu7f/wEiL5h9oXcdek5YCPMl0=;
        b=ZEDoJ0AxZRxKND2ZzOi6Q65C/cHyDa/Fd6mMJzIgN5aluss8TGyYD0JlBups8DESMQ
         y1koDsk24eHi27dVklM6z3J+t56V82lLAoOs7wqP87AiSEXXkgg2wGUEmbJ5wFi2zlxa
         iuo8oJ9FJ1iX1Syl3XC9qTrJteSja3Nn4NboxjxzltDjaNM41s0mofINkSNgg2dIb6gL
         fEfRxbKyfvKXX9Py0SPAKO3EMC3/gMFIpEH0OrC104Yq8i6aDDiUg/Pwoy8uHazSFfdV
         wSG4xd3x6MkIqR4/x4NA7c889RMT2ahBPgJK4Y1Nti8Ya686nZgXQxcMYFSuzn47xmLs
         nqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6284/+o4WmhRyX/T6Efu7f/wEiL5h9oXcdek5YCPMl0=;
        b=tsT8+WL0yLisUOUN1VXRwn5rUr4vUaYsUUJJ3Es5N4TksPyoiyMWOKAYF0Ud6mldbH
         KNjZDCeg6t+k81iPXcE/x16yl86bAugNDbMFKTeV6wj+Hsct8bLbM+1+lifDPiPznb2S
         6l9ZxXm7K8dLvKTFSFuPEoqlm45TVa2lra0WoMjBgbMsH/MUK/h0DPbv2byTpByRB4AG
         5xHzACklRDrI8GBOD911e9P4z55qm3VIAAIDLKC8jGyXv4CU7HjY4MT++IhMTC6VMOnO
         HjSSqluoOsL5DCRJJfXTE97GlQJocZ1oQTjqLqlFWVU+d3/IGEK3KaRKNbnNZ74gkVBv
         VPOg==
X-Gm-Message-State: ANhLgQ0e+cplIhvqa9IxsGxBRY8sW5RtMfuXM6YhmHLEPi7xuOlHZubT
        9R2L7k0Z+n2Thys8yNC51k6inw==
X-Google-Smtp-Source: ADFU+vvEkMluDNtLHvb9wYibY0YTfmMFpvTnVCT10Y9vc5W/pf6esvo4cSwgKkO7QmQavPGJiAzECw==
X-Received: by 2002:aed:308a:: with SMTP id 10mr3738127qtf.221.1583346476833;
        Wed, 04 Mar 2020 10:27:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n8sm14500789qkn.49.2020.03.04.10.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:27:56 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9YkN-0001xY-QW; Wed, 04 Mar 2020 14:27:55 -0400
Date:   Wed, 4 Mar 2020 14:27:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [Patch for-rc v2] RDMA/siw: Fix failure handling during device
 creation
Message-ID: <20200304182755.GA7428@ziepe.ca>
References: <20200302155814.9896-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302155814.9896-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 04:58:14PM +0100, Bernard Metzler wrote:
> A failing call to ib_device_set_netdev() during device creation
> caused system crash due to xa_destroy of uninitialized xarray
> hit by device deallocation. Fixed by moving xarray initialization
> before potential device deallocation.
> 
> Fixes: bdcf26bf9b3a (rdma/siw: network and RDMA core interface)
> Reported-by: syzbot+2e80962bedd9559fe0b3@syzkaller.appspotmail.com
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> v1 -> v2:
> - Fix here only potential system crash during failing device
>   creation, but not missing correct error propagation.
> 
>  drivers/infiniband/sw/siw/siw_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-rc

Thanks,
Jason
