Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B91E8666
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 20:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE2SOc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SOc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 14:14:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBAC03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:14:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so3113119qkh.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UOkQIJM/899Plh6dS+fa/iIOtU6dmymm2a3fYTTRujE=;
        b=DeIhMuyaQA76fpBebTeQvjwlYF4Da1hwGhFDHJ8lNW+1xe9mqTLJYRgESBUqzWRWXr
         WNAUypmiwNuibLkGLPfM1R6BOnD+8DkLEzm1BCiFya5Pi6S2qnoIWHlNY7AUQk9CEmPl
         3qPGuFwjkzupowRp2kM9H8ZzeON0PkQ1cfpfhgGIHLHZEyWTvsrSlS1Brw3FBOmPOsQ6
         PFqy3bw1RG78NX468TWSkjsLB5gLZ2fV8Ci502Pzdg06H9EqX2USn3cqN8q757ywWLvn
         HrG59ybFbOiahXn3ZSqII9Pdcxk1/vKvO0SlUOBSRtYc/2s88ho2R/ppEUH3/4DoOpo3
         lJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UOkQIJM/899Plh6dS+fa/iIOtU6dmymm2a3fYTTRujE=;
        b=Ve6AaQHcq+EjP0O1Dip5IQwzIWWeD9RFaohCCA1lcb6o+2RVU5n9MtEOrarOQlsCfH
         IGzNH8o5Vh7F40z8A57ab3EyHbP8inTO4+UPu3YGobGeffwZQOoQGfj0Uvybz/1sI2NT
         DqqCFwKbiHddQjEHCkKvBzyC5HRQcH2N81fUYNNa9p7plTH1B6wT279HHNp8KVxs3Qki
         5Hl7jlsjui87ZZT/HGqfhr8ow8oMQzmyt5c/9zhAh+9TnKaAvEvnxmwvTdutWn1Bk9K3
         c3YH6cYD2XdAOiNzd5/NhNoemdiIeV7EDpyWbC+q3Wy1zG37irB4ouV5o+LNLef8JfBH
         jXuA==
X-Gm-Message-State: AOAM533pqOSwuI1/iT2MsOU46/CWf+UBEKFbBqE+hOw5zC5hcNsXwSTY
        pNUe8lGOOCi0rpEEKtjlcw6PIQBrjAE=
X-Google-Smtp-Source: ABdhPJzrFj6GnQjOW1P3zXNmceRSqm5qtMayuETY7jsyQGsPJpDLvZkV39kdcTQqBIoykDR7u71msQ==
X-Received: by 2002:a37:b107:: with SMTP id a7mr8513614qkf.133.1590776071551;
        Fri, 29 May 2020 11:14:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i14sm7516439qkl.105.2020.05.29.11.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:14:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejWY-0008BN-8u; Fri, 29 May 2020 15:14:30 -0300
Date:   Fri, 29 May 2020 15:14:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Four SRP initiator and target patches
Message-ID: <20200529181430.GA31413@ziepe.ca>
References: <20200525172212.14413-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525172212.14413-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 10:22:08AM -0700, Bart Van Assche wrote:
> Hi Jason,
> 
> Please consider these four patches for kernel v5.8 or v5.9 (not sure if it is
> still possible to include these in v5.8).
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v1:
> - Changed %d into %u in the SRP patch as requested by Leon.
> - Simplified patch "RDMA/srpt: Increase max_send_sge".
> 
> Bart Van Assche (4):
>   RDMA/srp: Make the channel count configurable per target
>   RDMA/srpt: Make debug output more detailed
>   RDMA/srpt: Reduce max_recv_sge to 1
>   RDMA/srpt: Increase max_send_sge

Applied to for-next with the revise commit message

Thanks,
Jason
