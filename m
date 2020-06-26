Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A272F20B431
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2020 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFZPK6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Jun 2020 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgFZPK6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Jun 2020 11:10:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77CC03E97A
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2020 08:10:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i14so9713034ejr.9
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2020 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JtRyGt6tiuqtwS1yKOlAkCyE7jiftgXfal15sd+NZdk=;
        b=fpxsguBU3JER73RU9qOPNpFE2E2jEx1fk2c9+73s4rDH2TAlUCBSI3cTmdvV9GnNe9
         IlQAHwtLYEN9UJE4ukGlACk7K+CSBKOVBq6taeWa2FKfHlMBRaNttWyz/HHeMreB7J3+
         OdR1QGL7LYABeAivxYYb+8dj8bApe1g2IgTYySdh7SQZIwZ6G+1eHJGaeKDv3Q7z9kHK
         8xUNgZtoQ8GTEQcEoqida/heTNf2Iku4SUSSDBWUjgZ9CnVpTDidL7R3GZShau5UHQFt
         V5B/IJQvFZjP3PVeDThT0ZLLXCDRQq3/kVcZcONjJ2EzHgl38QrdqSGWztmMcqR6RfAc
         NhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtRyGt6tiuqtwS1yKOlAkCyE7jiftgXfal15sd+NZdk=;
        b=qKl0whZEQadxPmiT8cw7FA9E/bXTXMbVGguGGQwQFmtjo1wEbEhl0BP9ip+KMOb9ml
         uXXMXnSpCPTkK7F1v3HqvEQWkrPWfpdoGFOOzk+phB+BHvoYkTjZ4eEP1niuYdLr6Id5
         ftG1rby6Px04vMQhtPXz3fKcdQiV/2eu73w4cMIz/vvnxtVSYdWHO+V25JFvy398uFmd
         fR5qxoq4viIIr0YjLAow/JLos7FTG6oHBIx0o3wiw5FeTZ+Usv/Z3+eP2IWODL9VUipF
         1s60Ao9QpgXkkMS7rIyFuCiDJI/WvlsAZEqSHkiXGm9qxhzNAHSlCAoD2con50v8aIPO
         vbKQ==
X-Gm-Message-State: AOAM533JntHoxmtTQvMQgE6s0WYTPspTKibYSYxW8Blwb1f49IpLKhrR
        sJd9WyvMp2UzuDmhGSH/9d2g7A==
X-Google-Smtp-Source: ABdhPJzMuNuTrIAqicq/H7KVkcSv7BRHCGUNaCzEKApDBeNuY7YWlK/xalMxHcPVhN9SOma6pEM/QA==
X-Received: by 2002:a17:906:4a87:: with SMTP id x7mr2530833eju.44.1593184256489;
        Fri, 26 Jun 2020 08:10:56 -0700 (PDT)
Received: from gmail.com ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id m23sm2760801ejc.38.2020.06.26.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:10:55 -0700 (PDT)
Date:   Fri, 26 Jun 2020 18:10:52 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdma: fix EP destruction logic
Message-ID: <20200626151052.6cckaquyu7k3nd6b@gmail.com>
References: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
 <20200626071034.34805-1-dan@kernelim.com>
 <FEB41A86-87EB-44BD-BEC4-6EAB3723B426@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FEB41A86-87EB-44BD-BEC4-6EAB3723B426@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 26, 2020 at 08:56:41AM -0400, Chuck Lever wrote:
> > On Jun 26, 2020, at 3:10 AM, Dan Aloni <dan@kernelim.com> wrote:
[..]
> > - Add a mutex in `rpcrdma_ep_destroy` to guard against concurrent calls
> >  to `rpcrdma_xprt_disconnect` coming from either `rpcrdma_xprt_connect`
> >  or `xprt_rdma_close`.
> 
> NAK. The RPC client provides appropriate exclusion, please let's not
> add more serialization that can introduce further deadlocks.

It appeared to me that this exclusion does not works well. As for my
considerations, if I am not mistaken from analyzing crashes I've
seen:

   -> xprt_autoclose (running on xprtiod)
     -> xprt->ops->close
       -> xprt_rdma_close
         -> rpcrdma_xprt_disconnect

and:

    -> xprt_rdma_connect_worker (running on xprtiod)
      -> rpcrdma_xprt_connect
	-> rpcrdma_xprt_disconnect

I understand the rationale or at least the aim that `close` and
`connect` ops should not be concurrent on the same `xprt`, however:

* `xprt_force_disconnect`, is called from various places, queues
  a call to `xprt_autoclose` to the background on `xprtiod` workqueue item,
  conditioned that `!XPRT_LOCKED` which is the case for connect that went
  to the background.
* `xprt_rdma_connect` also sends `xprt_rdma_connect_worker` as an `xprtiod`
  workqueue item, unconditionally.

So we have two work items that can run in parallel, and I don't see
clear gating on this from the code.

Maybe there's a simpler fix for this. Perhaps a
`cancel_delayed_work_sync(&r_xprt->rx_connect_worker);` is appropriate
in `xprt_rdma_close`?

-- 
Dan Aloni
