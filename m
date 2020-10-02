Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC04A28149F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgJBOEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOEs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 10:04:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596CC0613D0
        for <linux-rdma@vger.kernel.org>; Fri,  2 Oct 2020 07:04:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id w12so1405097qki.6
        for <linux-rdma@vger.kernel.org>; Fri, 02 Oct 2020 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ehy5X+nZleLgAcUP+KLwxxHE0pMPIvVXOhm19fzHRIM=;
        b=nQ/dsxQr5UuyyOxWTshRh8F3V+aFBycf/RtVEoRePf9p/5tgc/57GPHMk5m3G0V4RK
         jfAIZr26zdV12WjjvvAhsYUDzHKTBcS0hdQMyDfhTDa8TkO4dEveqU+h5Eu5j6QKlv96
         r26UmHvwG0rg5NwKw8wOiP/1jvyIIo9u6/RYnBqB5+qNqY0vqUcj95gYVwNeCg3VVJz7
         qjNlVQvXWr9ZrphRjh7rYuyt+lY/rKSdMzbLu3ux9gOUKIaq6Sgjsap6Vqr9NSrRJhr1
         soY7Y5f+esg/4DiR0jQOn/NkN09NiqfKc3er7VBYnHM0VPZEMiLOqF+dL/Mk07DJ7lFh
         cziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehy5X+nZleLgAcUP+KLwxxHE0pMPIvVXOhm19fzHRIM=;
        b=WcJt1lUhP8rJXaO99NCx1XTo9YK0GfLUPDgqPFFhuD2zJkkE++SwYJXtj6klINcn5Z
         roBx/hcRD5JG5ag/fFskSUSSbhAtrfm9VR72PcRVTMUxPaxNeZPEgOjxZkvrBQY3sybt
         Q4X7HGsaSUMtOTSY8wKFyJsvESof+FsMHTwBmVO1n0r3gyN58AiYpexc5RYsPf6phFpC
         0DBIONn/4XAhZfw1nuxT1spFPhjKZFDCKbCIrJDalg1i6d/bwwIZ/AmQAA2sO6t1v8Ri
         iYXByg1cyHr5GDTxgWf1QuESvN623L9pDB1lbkiXg1fRMMCAXqKqe5w60BcuAETfGdY5
         HcBw==
X-Gm-Message-State: AOAM531gmpxaqAaordfDVeTD7wuT1U4pD/rfXxiRb/LWtFp35fNiiMBt
        FxL2PIhR3O15I/Kp8S/VoH8/Msjg0FALrdI6
X-Google-Smtp-Source: ABdhPJzknQcrcN+5hNneaWoJiJ/7wox/Pbl4wS9GlzvHx0osyDOZfz+f3FJN10wVNg1UjgxOh4pmYA==
X-Received: by 2002:a05:620a:4e7:: with SMTP id b7mr2282757qkh.415.1601647487403;
        Fri, 02 Oct 2020 07:04:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f2sm1101685qkk.80.2020.10.02.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:04:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kOLfx-005fAj-Ph; Fri, 02 Oct 2020 11:04:45 -0300
Date:   Fri, 2 Oct 2020 11:04:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201002140445.GJ9916@ziepe.ca>
References: <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 06:32:28PM +0800, Ka-Cheong Poon wrote:
> After the aforementioned check on a namespace, what can the client
> do?  It still needs to use the existing ib_register_client() to
> register with RDMA subsystem.  And after registration, it will get
> notifications for all add/remove upcalls on devices not related
> to the namespace it is interested in.  The client can work around
> this if there is a supported way to find out the namespace of a
> device, hence the original proposal of having rdma_dev_to_netns().

Yes, the client would have to check the netns and abort client
registration.

Arguably many of our current clients are wrong in this area since they
only work on init_net anyhow.

It would make sense to introduce a rdma_dev_to_netns() and use it to
block clients on ULPs that use the CM outside init_net.

> that namespace to use it.  If there are a large number of namespaces,
> there won't be enough devices to assign to all of them (e.g. the
> hardware I have access to only supports up to 24 VFs).  The shared
> mode can be used in this case.  Could you please explain what needs
> to be done to support a large number of namespaces in exclusive
> mode?

Modern HW supports many more than 24 VFs, this is the expected
interface

> BTW, if exclusive mode is the future, it may make sense to have
> something like rdma_[un]register_net_client().

I don't think we need this

> > > A new connection comes in and the event handler is called for an
> > > RDMA_CM_EVENT_CONNECT_REQUEST event.  There is no obvious namespace info regarding
> > > the event.  It seems that the only way to find out the namespace info is to
> > > use the context of struct rdma_cm_id.
> > 
> > The rdma_cm_id has only a single namespace, the ULP knows what it is
> > because it created it. A listening ID can't spawn new IDs in different
> > namespaces.
> 
> The problem is that the handler is not given the listener's
> rdma_cm_id when it is called.  It is only given the new rdma_cm_id.

The new cm_id starts with the same ->context as the listener, the ULP should
use this to pass any data, such as the namespace.

> > It seems like a ULP error to drive cm_id lifetime entirely from the
> > per-net stuff.
>
> It is not an ULP error.  While there are many reasons to delete
> a listener, it is not necessary for the listener to die unless the
> namespace is going away.

It certainly currently is.

I'm skeptical ULPs should be doing per-ns stuff like that. A ns aware
ULP should fundamentally be linked to some FD and the ns to use should
derived from the process that FD is linked to. Keeping per-ns stuff
seems wrong.

Jason
