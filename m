Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221720FE76
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 23:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgF3VF4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF3VF4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jun 2020 17:05:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39903C061755;
        Tue, 30 Jun 2020 14:05:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so3522805pjb.2;
        Tue, 30 Jun 2020 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7YJzM68xF5+T7oFwixHoGmxrMD80y0Idtu8GDH5eoGs=;
        b=Ll1q8Q6NPvtJ9gux80N+4epUWpVp2kVuyAmSUrOnAccbgOaadBM1J1JxWdB8LnXk3L
         xBDAb/6LnxpFIoTJ3Xmmxx/gIIKMZV/REgqy7Aljk1jeGpL8i9h95WanWPhLo/Dya49b
         xxei+axxgXCcBJ11NXuf3fcgD0t/sEWCowtnvD+x6sPJJjAh0FwFvN7gGocoUaeE+bgv
         TL8SM8OdEs/5Q20aVXsWF6IPCoi2kZa4UhBrGu/qKhTxTxqZvc7tFpzV9F1l5RuRcpoR
         0AI7iw/EzbjU53mPOjAVYnTLxIWdd846zHX9vK1Wl2Z8bLB5daSfY8hdOmClHP7G5zj7
         LU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YJzM68xF5+T7oFwixHoGmxrMD80y0Idtu8GDH5eoGs=;
        b=dwBVzjy3ymMaco+OSIDpLbN4mDTGHxNjOrsYL6k1TLnQTsEM3GbulNIeUojgZWg2nZ
         CZi6pLnsi9XjOaCrqxklWYZ0NIpdJmEswwqUrAUzaMFquJJHolAnkz7fqghhVI2uiK1k
         6y3aUf35Xq93lFslqXeXf38K8OeyN1E+k9rnKVgmrTUTEcMJDgf3NIOuQHch5bFlzoWT
         GowX6+eCmqm9YTecwwRO9YihO7oEaWPz+aBTyk07UgyaS+8iO8+UMug5Nu9DAVHIkk2+
         34bJCoVERbG+Uc0Zbm/aPp3UYSKv3pKDkDK9N1KPW/aTCRG4PJUNJqinsEG007Kn5P2F
         zYEA==
X-Gm-Message-State: AOAM533B+9eCJQ1YtJ0yFQ9V7VpsOvvECjVVs96ZbVgQFSRd17KYlKLF
        1TSC+fazyTFn4JR0tXqOrcM=
X-Google-Smtp-Source: ABdhPJxeLJp0yfbLRrAt4jASBtFaw2qen6+OCgR/gSCl/omhdWgXqt/uF6uRIbULcUTrjMLFU8/qnQ==
X-Received: by 2002:a17:90a:d709:: with SMTP id y9mr24500675pju.30.1593551155767;
        Tue, 30 Jun 2020 14:05:55 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id w1sm3615703pfq.53.2020.06.30.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:05:55 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:05:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] IB/hfi1: Add explicit cast OPA_MTU_8192 to 'enum ib_mtu'
Message-ID: <20200630210553.GB3710423@ubuntu-s3-xlarge-x86>
References: <20200623005224.492239-1-natechancellor@gmail.com>
 <5f98c547-1bac-bb05-1c75-cefb8616964a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f98c547-1bac-bb05-1c75-cefb8616964a@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 02:22:08PM -0400, Dennis Dalessandro wrote:
> On 6/22/2020 8:52 PM, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > drivers/infiniband/hw/hfi1/qp.c:198:9: warning: implicit conversion from
> > enumeration type 'enum opa_mtu' to different enumeration type 'enum
> > ib_mtu' [-Wenum-conversion]
> >                  mtu = OPA_MTU_8192;
> >                      ~ ^~~~~~~~~~~~
> > 1 warning generated.
> > 
> > enum opa_mtu extends enum ib_mtu. There are typically two ways to deal
> > with this:
> > 
> > * Remove the expected types and just use 'int' for all parameters and
> >    types.
> > 
> > * Explicitly cast the enums between each other.
> > 
> > This driver chooses to do the later so do the same thing here.
> > 
> > Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1062
> > Link: https://lore.kernel.org/linux-rdma/20200527040350.GA3118979@ubuntu-s3-xlarge-x86/
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> 

Thanks! Who should pick up this patch? This warning is in mainline now,
it would be nice if this could go via an -rc branch but if it is too
late for that, I understand.

Cheers,
Nathan
