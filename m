Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2C2C2B71
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbgKXPga (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 10:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgKXPg3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 10:36:29 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B0AC0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 07:36:29 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so16373040qtp.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xNaOFZNkwIGLApccOCjDLA4YSGm/yJphGbkVVvGvuwc=;
        b=nYM1s/aEC7ketvEn+DvgsffZmebE/9oCDHo8TAGmuqttbt0zqBFo/IAPVBEEWomCau
         kgUCw9Qh4S/lXIJLB+kNynMmrrr8JM6GVVBXhQfje2Q8HwwTqbxkOho4UhpjeQtUEsR2
         nEoOJarSDCmbsIfP0uQbDPIlfu8wjZENG+By6Sbeg5IV9Wh+hQAsUr96TueJ7Y6Vg8bD
         Bmc0oh+hY1urBPTxmCFqXLHc0g/0OWaFRTu9TVRFqfnyzITLi48P8pBMAw7OiaVigW44
         nX9u7sUbVbtQf1tcl3uwbaoAFYfatjfTncwYBS5RlTu1vq0Psw6m5XRAGbuS8sQe3qwK
         xXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNaOFZNkwIGLApccOCjDLA4YSGm/yJphGbkVVvGvuwc=;
        b=awBo/ZMKRzdtd8hw07gaIiyBNmaljm5CZGzqSxIF77k+/bUHT1v5tl7eqv+AxuCjrq
         IF4fbuLvMvXAtQ72GXKKxRp1LBtEcB6CteP7NSBSfT0wpIHjbyTNfT4ETCCf/aT1reDB
         b5JGbxFe2NV7UBOj7HXj4EALq0uMFZ65h3NS0/hCiUbhxZMadsN7yumFSIZj52sU9yct
         y5LJ5+VuaKsqFbdLHZ+dojBY+zBsp2SMkFktv44kK9v4GyzGV5VJ49nZsEfGFL80OyXG
         pa3qGF0UbdEsAtcfDjTLNHgOMZz/BjVJMLMACnbXXlIOVRz3o5uDMjjXEDPnTgESHVDK
         5kaQ==
X-Gm-Message-State: AOAM531PAIoBUT3o5eVuZFCTmAWHM5llIsoaYAq6nwJMR3pslCQ6Q/Tb
        lVgM3+6/TRBgZNU6LL4SYncCHQ==
X-Google-Smtp-Source: ABdhPJw9HZW4/QIXyw3Wu2qQDbZWFOnMRP1dRTF4t43+gQon0h6DcDtwNVHgJibn/lihniJm8HNCAw==
X-Received: by 2002:ac8:714e:: with SMTP id h14mr4890325qtp.301.1606232188461;
        Tue, 24 Nov 2020 07:36:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q20sm12653025qtn.80.2020.11.24.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:36:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khaMk-000oqd-MW; Tue, 24 Nov 2020 11:36:26 -0400
Date:   Tue, 24 Nov 2020 11:36:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
Message-ID: <20201124153626.GG5487@ziepe.ca>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
 <1606153984-104583-4-git-send-email-jianxin.xiong@intel.com>
 <20201123180504.GA244516@ziepe.ca>
 <20201124151658.GT401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124151658.GT401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 04:16:58PM +0100, Daniel Vetter wrote:

> Compute is the worst, because opencl is widely considered a mistake (maybe
> opencl 3 is better, but nvidia is stuck on 1.2). The actually used stuff is
> cuda (nvidia-only), rocm (amd-only) and now with intel also playing we
> have xe (intel-only).

> It's pretty glorious :-/

I enjoyed how the Intel version of CUDA is called "OneAPI" not "Third
API" ;)

Hopefuly xe compute won't leave a lot of half finished abandoned
kernel code like Xeon Phi did :(

> Also I think we discussed this already, but for actual p2p the intel
> patches aren't in upstream yet. We have some internally, but with very
> broken locking (in the process of getting fixed up, but it's taking time).

Someone needs to say this test works on a real system with an
unpatched upstream driver.

I thought AMD had the needed parts merged?

Jason
