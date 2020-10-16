Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6462F290BDD
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406696AbgJPSyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406163AbgJPSyv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 14:54:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4978C061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 11:54:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l16so3775968ilj.9
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rp7pKHCADa9vI0edzuVLzpqK8L1eM8aUviiDfrZXEvg=;
        b=gmuxSgpwvE7pZWkr54K/LkW9numO49ovNGH82Z6UJP9Dqm8LepOZVxFTA0FTa+2RfI
         XgNYp/GUI/Vc7HlaP1wBuZ6K2TbMOLlLeGcGAS9oQQCft4iPefqySu7q8SKsBwURZNmq
         PaeHVhYPha6sHo6ubA8juNQn+0fxXkeTaCC9jaekv3bp3zLcROftjk65Z8rES0Xmir2I
         26DcGc3uMFoBfCuQDOu1vA1bsMeJqdEc6iQwnlvY4L8TG+yFH9mHlB7mWe1D1UL2VPm7
         j40SMc+HrRVYXMqqd0wBL7sl51XCuZzc+k/rcW8x9ymVK/09fgzk7wwwGNvRc7oOuM+0
         Hapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rp7pKHCADa9vI0edzuVLzpqK8L1eM8aUviiDfrZXEvg=;
        b=iz7y2nukxkbRNx7RTcvQkPIizT3CREO8CWymoTo6GUrL2D049YpyxIR/GUlCsJiNo9
         cRuAp0Nlg3AubkZkub2QQbM1jree71a9TwdrHtk+F07mj0pwVXl8dYj6hFCULlX3V7Hn
         fWn5JNqsLJbLXw5o7Mlvh8VCcQ/AR15l/qeEWLlOeGdkw11lbVGuXViI+4yl71KS8nY7
         9wXH39XT7vky5FXWndXbneXpd24rHApS6a9NB90FujVI9N8ntwgkcQjjtEs/9J76r2GF
         HGdcnpeqRmiwY8yEm3th6HBiO+j7Yk7UpjsJyGEUkiHwOisQdub1waOBI6aD6V83V9L7
         UH4g==
X-Gm-Message-State: AOAM531/RwCLcwRRacLmIpKrWVFIBPkh0sloRwXm2FD7ZTCL8xW1Ao4B
        7HBioW0X2ZfSM7gNHm5yzBxELXRC9UCNmw==
X-Google-Smtp-Source: ABdhPJxMkLIrtrPwmKp+VR2o1pbdwtIYtcWujUeM8nbkrpIYn54MMNAFifqn+UyEw77R33epboUyHA==
X-Received: by 2002:a05:6e02:13d1:: with SMTP id v17mr3884497ilj.257.1602874485926;
        Fri, 16 Oct 2020 11:54:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c2sm2826401iot.52.2020.10.16.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:54:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTUsF-000yjo-Vc; Fri, 16 Oct 2020 15:54:43 -0300
Date:   Fri, 16 Oct 2020 15:54:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Chuck Lever <chucklever@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201016185443.GA37159@ziepe.ca>
References: <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
 <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
 <20201009153406.GA5177@ziepe.ca>
 <4e630f85-c684-1e56-bb68-22c37872c728@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e630f85-c684-1e56-bb68-22c37872c728@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 04:20:40PM +0800, Ka-Cheong Poon wrote:
> On 10/9/20 11:34 PM, Jason Gunthorpe wrote:
> 
> > Yes, because namespaces are fundamentally supposed to be anchored in
> > the processes inside the namespace.
> > 
> > Having the kernel jump in and start opening holes as soon as a
> > namespace is created is just wrong.
> > 
> > At a bare minimum the listener should not exist until something in the
> > namespace is willing to work with RDS.
> 
> 
> As I mentioned in a previous email, starting is not the problem.  It
> is the problem of deleting a namespace.

Starting and ending are symmetric. When the last thing inside the
namespace stops needing RDS then RDS should close down the cm_id's.

Jason
