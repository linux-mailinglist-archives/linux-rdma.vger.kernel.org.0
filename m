Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9871538CE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 20:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBETMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 14:12:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37133 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBETMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 14:12:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so2457601qtk.4
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cHhpk8NxV7d9pWKZlCF5nt9V3XPrMbQR877f6pYAsUA=;
        b=pQF+jp4GGDjiysmwhQ+Xkq0b89TwGzXKgzgxCQw6lKOdhwudhgPb4nGl7JFIz7Fjv9
         5n1NUkDdfLuxSGhaEF10mVCm+XfSoDSp7XCNTJSJ7iGJMWavq4ueZEpvKDNb0TbuEGvc
         8nCDN+mHPBhCBjMnUZev5/EQc39CgdgEao6kr6J75jpFpvcnENUPMxtsssa6LbMxZxCw
         W+SkudsVJQ79Wihm+iNQQ7xy1dMt5iL7vc2QtLthDb/8YAZlAAvFvA5n/oJwtjoKPWb3
         rh8z47PUB1sR+c3hN11CPgQVd0JkGrRMhIyXoYp37Grc0h+bNsl4Pc3s8r6LktTf45Xo
         GKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHhpk8NxV7d9pWKZlCF5nt9V3XPrMbQR877f6pYAsUA=;
        b=jXlpxPtorldbRwZ0xd1qcdrmobtsNwCAW+RrKfEmqA5iZQTz1tGMicewXPN85l1O8H
         splRLSAw9jVhUBsdX6rvuiEbTOCcVy47JBehPdKc+MWGCy/UTeRsYMJD6PjB3MPIJC/U
         vj7jIPMkfahHbQj4M5FHfwxlyJeEveJHdIUOb5WeBVKP/uWZaRs3oh8sOvlS/7XZszcT
         V0w9/9x1nHjaPqm982c+9Y5WBZrGVoBOrY5GZaPi0lYqF0P/BbGSrBsQfNMpKBvWEC70
         h7oiTMxUSuNtfgc+axo44WOJfTiFiMhg6PDPJE03sJ/PJGo4MF1WobTASDzpHayHDdCJ
         Gh0w==
X-Gm-Message-State: APjAAAUjG8NC2lRZQqdB71+LKOT/8l/UhbGziwTrl2ZzI2SLP7V88eqd
        JiZBkU1ZPjjrr403l7FrVnKuPA==
X-Google-Smtp-Source: APXvYqwwkjuClHP/H3N912iMON9KM/kGpEONJBJM6R0lHU16ZT2buHb0aH2OSYhoxOYRu28GNgZyZA==
X-Received: by 2002:ac8:78c:: with SMTP id l12mr34844777qth.187.1580929948837;
        Wed, 05 Feb 2020 11:12:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n4sm353611qti.55.2020.02.05.11.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 11:12:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izQ67-0004YH-OU; Wed, 05 Feb 2020 15:12:27 -0400
Date:   Wed, 5 Feb 2020 15:12:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Goldman, Adam" <adam.goldman@intel.com>
Cc:     linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200205191227.GE28298@ziepe.ca>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
> From: "Goldman, Adam" <adam.goldman@intel.com>
> 
> PSM2 will not run with recent rdma-core releases. Several tools and
> libraries like PSM2, require the hfi1 name to be present.
> 
> Recent rdma-core releases added a new feature to rename kernel devices,
> but the default configuration will not work with hfi1 fabrics.
> 
> Related opa-psm2 github issue:
>   https://github.com/intel/opa-psm2/issues/43
> 
> Fixes: 5b4099d47be3 ("kernel-boot: Perform device rename to make stable names")
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Goldman, Adam <adam.goldman@intel.com>
>  kernel-boot/rdma-persistent-naming.rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel-boot/rdma-persistent-naming.rules b/kernel-boot/rdma-persistent-naming.rules
> index 9b61e16..95d6851 100644
> +++ b/kernel-boot/rdma-persistent-naming.rules
> @@ -25,4 +25,4 @@
>  #   Device type = RoCE
>  #   mlx5_0 -> rocex525400c0fe123455
>  #
> -ACTION=="add", SUBSYSTEM=="infiniband", PROGRAM="rdma_rename %k NAME_FALLBACK"
> +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"

We are moving to the new names by default slowly, when wrong
assumptions are found in other packages they need to be updated and
their fixes pushed out.

At some point the major distros will default this to On. People using
leading edge distros can turn it off with the global switch Leon
mentioned.

This is the same process netdev went through when they introduced
persistent names.

If I recall, hfi was one of the reason this work was done. HFI has
problems generating consistent names for its multi-function devices in
various cases and I NAK'd the kernel hack to try and 'fix' that.

Jason
