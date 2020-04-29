Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC41BE4FE
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 19:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2RSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgD2RSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 13:18:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE35C03C1AE
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 10:18:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so2498223qts.9
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIRyEJq6A4uPsjQUVds8C6PhV05GC07IiHWYIwTUTkQ=;
        b=FgzmRv1Kuvo2vn1vCYW4YPwtJm3hs8WnRuGrtdY/aIO51wTMOl161yndlFfVefRL3x
         YtAU73SQEjdRJrBhpfZETMBEgXIRWk7gGS9+UVq66TyCF5WB8HSQiK02C2gLSCHLnc4u
         OBAcaZ3IfTFk1TmDIbj3Qb8xVwAwG1RxpGCx7FAuM7SH7z3nLKXegQXG70Q5ytKYVddn
         PZ1GpZtmOQykXikov3gkBPAkvOPlf8TzypltlCEudSOm5Iq3GJVfKWn+7Eb5+yVxxgjd
         ivQg0Yy/zRqrjrXbEjCgLKQNLJNebHHxSYVctGxlZc0iBKxV0UbzLfRiXlqoS6VcQB7F
         SlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIRyEJq6A4uPsjQUVds8C6PhV05GC07IiHWYIwTUTkQ=;
        b=pUk+94Zr2g2fzQiFjuwohoy/DG05fNOMYoEm7exsa5+7Nc8Az4D4JG69Qhp6Ps6POX
         p4eqIUl7g9RRhtWdELNCq8SpE+aJXqbhosH+SYRlnf7a6aKEXFXlU9hXHcfZU00RNkpV
         9EDGCbhjbKPwYBJezC7yPgl05Bi8v/X+CTrIegdg6RAoO6wZdJUtcRD/E7MzIo6snEpe
         324oMxwJCMLg75NjTzKr2OaqmfV2t1WMs7gYlQdmGVn/hTcMYtDgiT3x+2ejVNF/PESP
         5Oz98/H8hKW6YZjCMtlfgxUXju0Dy14W7leH0znLFeSq3CG2YbtVN2M1cX/4Qn3LHHNk
         H87g==
X-Gm-Message-State: AGi0PuZR01bzUgdusA7K2tEJi89+fBUCyZfIFkvhebTH/wJu8IvOhiXL
        9qkkcG7BV/5/+/IurkSaPYL82OtdmwIDGA==
X-Google-Smtp-Source: APiQypJUaXgz0vdsOO647OEZziodcK8+yrvNAucF2ipuBxcxfQvECD+2sGhZsyW4SBfAcB7qimxedQ==
X-Received: by 2002:aed:2666:: with SMTP id z93mr34114456qtc.203.1588180726423;
        Wed, 29 Apr 2020 10:18:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p80sm16014726qke.96.2020.04.29.10.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 10:18:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTqM9-0000O3-IX; Wed, 29 Apr 2020 14:18:45 -0300
Date:   Wed, 29 Apr 2020 14:18:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v13 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS
 modules
Message-ID: <20200429171845.GF26002@ziepe.ca>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-26-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427141020.655-26-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 04:10:20PM +0200, Danil Kipnis wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Danil and I will maintain RNBD/RTRS modules.
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26f281d9f32a..b22672f6d22d 100644
> +++ b/MAINTAINERS
> @@ -14459,6 +14459,13 @@ F:	arch/riscv/
>  N:	riscv
>  K:	riscv
>  
> +RNBD BLOCK DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +F:	drivers/block/rnbd/
> +
>  ROCCAT DRIVERS
>  M:	Stefan Achatz <erazor_de@users.sourceforge.net>
>  S:	Maintained
> @@ -14587,6 +14594,13 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
>  F:	drivers/net/wireless/realtek/rtl8xxxu/
>  
> +RTRS TRANSPORT DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +F:	drivers/infiniband/ulp/rtrs/

Make sure you follow the sorting rules here too, I catually don't know
what they are :\

Jason
