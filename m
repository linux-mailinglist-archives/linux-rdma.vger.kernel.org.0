Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B632239CC0
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHBWW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Aug 2020 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBWW2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Aug 2020 18:22:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54954C06174A
        for <linux-rdma@vger.kernel.org>; Sun,  2 Aug 2020 15:22:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so33637549qkk.7
        for <linux-rdma@vger.kernel.org>; Sun, 02 Aug 2020 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5EnCNuAsZu/5GSHSkCJnQHkqSHw04mgkG5bd0dw21A=;
        b=B5Srbuxy71fxtFxfecWMtxMpPoV9c8pwCDJR+OJcCRFSMETyzxoHIqEA+j1JRdSN2q
         11bjtvb/Vh4SQTSr8P7Ha3fA/FgeQZaziEsYh1PiplvKCc5yIlOOjQfGRzvWXlH6K17J
         cOd0gbt7YRXrKQKJZfvMYGXHAjdUbDcIjrAPUB/XK11u88HkoPf1ECOBVvg0vwrOGHDD
         ovd29v/okdIs8rw8NlCTmlwSzAY0ZnZ6HYDmPer8MJLmczGv2rIj3398zDI3kD3li4b1
         V1J5xzWlgHCuWZSirvVWjgHy4dKU9YSMd6RazPgWb/i/GdQoEODwAUAD1SI4KZ8R5Vgp
         ydrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5EnCNuAsZu/5GSHSkCJnQHkqSHw04mgkG5bd0dw21A=;
        b=Dp9qSi3W8SIDdx3rDsf6bgCEHsNLmGu7e7xEPALJemL9cK/d5YCza2tP90LCQxzxlz
         OjVsgTRSwd+/YUpOAYx6KMGSAbLLAh0tuzRqSXwGWTsTelY3KhVh2Smd9pil+qK4KTfo
         AA2kEKwzkcTE7Tefp/TTliACx6WIpqGUGccNLm5oPvdjRwOIsoBhBmqfXgBFQaLF1/kt
         Pe86Fz1/U6cklA4Gjah1f+rZiwnwdVqQbVZw4XVCE1DL3ryjel30sWIDnlDsGVneVf8H
         aLj4j8fuOoSq8eps9y8zVl9nj5StMkRlNU/t+QImFGXIFpJ/hjT1vASm06I3g/5u8+nK
         JDZg==
X-Gm-Message-State: AOAM533qgHYZgSPAAF9QOOSPup5B28caf3/rQduTt27mDVTgYX+8SuS9
        /SeoggtlsIY2ryQkLSYnE0mx8w==
X-Google-Smtp-Source: ABdhPJwJOTXoO+G0ejSTeukp3EiH3KmI6wo9FiLGNbWWm4DhpMV4kjjYdTHOHbf4XcJDV/E2eA64pg==
X-Received: by 2002:a05:620a:110d:: with SMTP id o13mr14049206qkk.60.1596406947387;
        Sun, 02 Aug 2020 15:22:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d46sm20955491qtk.37.2020.08.02.15.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 15:22:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k2MN8-002pv6-2z; Sun, 02 Aug 2020 19:22:26 -0300
Date:   Sun, 2 Aug 2020 19:22:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in netdevice_event_work_handler
Message-ID: <20200802222226.GO24045@ziepe.ca>
References: <0000000000005b9fca05aa0af1b9@google.com>
 <20200731211122.GA1728751@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731211122.GA1728751@thinkpad>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 31, 2020 at 02:11:22PM -0700, Rustam Kovhaev wrote:

> IB roce driver receives NETDEV_UNREGISTER event, calls dev_hold() and
> schedules work item to execute, and before wq gets a chance to complete
> it, we return to ip_tunnel.c:274 and call free_netdev(), and then later
> we get UAF when scheduled function references already freed net_device
> 
> i added verbose logging to ip_tunnel.c to see pcpu_refcnt:
> +       pr_info("about to free_netdev(dev) dev->pcpu_refcnt %d", netdev_refcnt_read(dev));
> 
> and got the following:
> [  410.220127][ T2944] ip_tunnel: about to free_netdev(dev) dev->pcpu_refcnt 8

I think there is a missing call to netdev_wait_allrefs() in the
rollback_registered_many().

The normal success flow has this wait after delivering
NETDEV_UNREGISTER, the error unwind for register_netdevice should as
well.

If the netdevice can progress to free while a dev_hold is active I
think it means dev_hold is functionally useless.

Jason
