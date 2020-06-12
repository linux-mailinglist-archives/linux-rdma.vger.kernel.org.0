Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD821F7DD5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLTzO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTzO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jun 2020 15:55:14 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729EC03E96F
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 12:55:13 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fc4so4938653qvb.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uwVsAt2dWZu5t2sDgnUvdVUOdJFPKU/FWwGEFwAABik=;
        b=ETkg+84QWle8MBpwumhWnjS0BjzzO8tFB0f2tSoLh/PpCNuuuRGaJJsSxd8ZdRQmuh
         eNsPAcYc4y+snFxkV1wrAzXbYDPxWwqSr+5P3sfsPsq3uUSxJL81ER+tqpx2Am/1EG+Z
         71JKginTFFOwvuAl1MxrR5xZs+VaiVdp0BOSkluXj7ILiDD17+RUHN71ADcctEwitRXL
         LUgZ272rzs0nA/akbBg2A/Q0w0JO2C8jp3IU0r6fCXdA+1Z1/FugYLIGpOEXpMIR1bAB
         yzhMxhHFjRm1UQqzzNypOyyqzQ3wU/jmU89JDmWXCtTlLliy9Zb2KEZazp9XrNj/lkjz
         6Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uwVsAt2dWZu5t2sDgnUvdVUOdJFPKU/FWwGEFwAABik=;
        b=V+kEa0LKylU8DSHsYV2Ll3V4q4XUsZ4KHDllvKCEhEtTSfxgAguoiNbUaUJcS0MR6I
         fpl70DrIuWIvUAyvrEOg8jOyox7RaBWrBleCXyGc+i1+1YzknztFNSyK+BGDAgTPnIci
         cahx9LkbtpH3iRG0I1a5TJEOgjWUYkjVsvWR45fNN0ECVfzLZscVvIbJGz+VeCGeIJ0D
         aian7UjeNBT4NZlIgxbml7qenL4ZxCCBi/y2y5LK1khOJ0Hcf+VgWoX5DfZ0CMwM3WS4
         +sRs3HcsTHie80Ep/m2JSC/bYpePdFSKs5xoVVvQfNE8zaUJ1vpS+Q7/dwKbEGDqmPDA
         96PA==
X-Gm-Message-State: AOAM532thzkPQTNLYR7cXtC5gK+PdXdlf22dSTR2R56oBgntYW/1UaVM
        b9OzDC7pWtGDkzvgAyhhrJcGyw==
X-Google-Smtp-Source: ABdhPJw4lUo1NBOu4psy33D2MNKG+VuRLhwPDFDk6WG6VrvYHYVvULl+Vvt9RUfifQnQL/LPFZSrmw==
X-Received: by 2002:ad4:556e:: with SMTP id w14mr14116851qvy.137.1591991712633;
        Fri, 12 Jun 2020 12:55:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z20sm5265753qtn.93.2020.06.12.12.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:55:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jjplf-006mA2-OJ; Fri, 12 Jun 2020 16:55:11 -0300
Date:   Fri, 12 Jun 2020 16:55:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process
 completions in due time
Message-ID: <20200612195511.GA6578@ziepe.ca>
References: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 12, 2020 at 12:41:16PM -0700, Gerd Rausch wrote:
> This issue appears to only exist in Linux versions
> 2.6.26 through 4.14 inclusively:
> 
> With the introduction of commit
> f56bcd8013566 ("IPoIB: Use separate CQ for UD send completions")
> 
> work completions are only processed once there are
> more than 17 outstanding TX work requests.
> 
> Unfortunately, that also delays the processing of the
> completion handler and holds on to references
> held by the "skb" since "dev_kfree_skb_any"
> won't be called for a very long time.
> 
> E.g. we've observed "nf_conntrack_cleanup_net_list" spin
>      around for hours until "net->ct.count" goes down to zero
>      on a sufficiently idle interface.
> 
> This fix arms the TX CQ after those "poll_tx" loops,
> in order for "ipoib_send_comp_handler" to do its thing:
> 
> While it's obvious that processing completions one-by-one
> is more costly than doing so in bulk,
> holding on to "skb" resources for a potentially unlimited
> amount of time appears to be a less favorable trade-off.
> 
> This issue appears to no longer exist in Linux-4.15
> and younger, because the following commit does
> call "ib_req_notify_cq" on "send_cq":
> 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")

I'm not really clear what you want to happen to this patch - are you
proposing a stable patch that is not just a backport? Why can't you
backport the fix above instead?

You'll need to follow everything in

Documentation/process/stable-kernel-rules.rst

Or the stable maintainers won't even look at this.

Jasom
