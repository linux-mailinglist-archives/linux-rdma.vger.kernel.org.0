Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C82B0E71
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKLTql (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKLTql (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 14:46:41 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD6C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 11:46:40 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id r7so6572935qkf.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 11:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYZBjkTktEmk1b8pVEPsfmtTc2BuhOCt5DRuwj3b2MM=;
        b=i/P5supkiiGXmWLhdkmN47CVWtM07QjaeqURyjlvnGUUpuRtOVv9M2O19LNjeK1ZQY
         MhLEqe/RU6lAi+Ix+QFBBKYmi0bad0LtpmbQesE253igdd+oRFn72ZjUX4lD03frjqhW
         Blz3ie6nA+7EU7IDGdWp7D0xbZ6h9d6vlxXGZm4Co0o3N4vy0fb8/XYSmh8327s/oLkJ
         37j6G6ey+pg+XwkxtbZ6OKavuZzXIt40ByioQMRpDjNdM0a3HkxAb9LfYdHMrNUY/RsQ
         imPDMZsllg8MgI+7a/gpkR9RmTHpQBtco/EwLVCJ6zkxXEGDVuYdNi4UbjeYjeAZUJ+g
         MBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYZBjkTktEmk1b8pVEPsfmtTc2BuhOCt5DRuwj3b2MM=;
        b=ecPPMpBtNCbueoAGWxcxvS6IKN+jn4FmdJxs5JXjNbEzev+P7KSen1lOZLE0mgtQ5I
         a32XR9T8qJtYR4XIQrGeBvJ/Ghc0C8W4PDo9pq9jhjpz150Uhu0YYDotZ2NwDTS/N1Wj
         cxQs6xEo6XoqwYd8Fm3va5/iDsOuLWeXBLNILPyTwy89YNKlyAuYvpy4XeR1T30mAtl0
         Sf61cy4tA7Pm+HiTMsak8Y3ZRFpNsJhN8t405mb5v50eEdjsQzJA9Y/1VDL7lOvChhgd
         jYeKAiW3Rx5rR77u6jUa4QhFjv1rAdkLEso8atOoV97/h7+Vb2vSqNvPQOnSEGgzdY3Z
         4HkQ==
X-Gm-Message-State: AOAM533TM2Hi/0QIAQNBsCoUYYXRWo1sHhgrt5EUb9qlksfOg5w4luVW
        F4lM8BAvBBtHdCjeLT7TneMVssJMVNl+o6Ta
X-Google-Smtp-Source: ABdhPJyNGTPGpb4c25dhLeNsWatITfRfggejxYjSg8kj4elhboEqK+2BJEL0VqjHjlYvldJHZzZNfA==
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr1478646qkl.27.1605210400115;
        Thu, 12 Nov 2020 11:46:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f61sm5256040qtb.75.2020.11.12.11.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:46:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdIYI-0048Jr-LR; Thu, 12 Nov 2020 15:46:38 -0400
Date:   Thu, 12 Nov 2020 15:46:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ryan Stone <rysto32@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Race condition between cm_migrate() and cm_remove_one()
Message-ID: <20201112194638.GU244516@ziepe.ca>
References: <CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 05:08:59PM -0500, Ryan Stone wrote:

> If anybody could give input on my analysis and the proposed solution
> I'd really appreciate it.

Yikes, this whole thing is just wrong..

1) We can't migrate QP's across devices. So av and alt_av must be in the
   same cm_dev, we never check this when forming the AV and alt AV's
   during LAP. Wee

2) cm_remove_one needs to remove all the cm_dev's because it is going
   to kfree them. Using altr_send_port_not_ready is foolish because
   what we really want is to NULL the port pointer (we are freeing
   that too)

3) Touching the AV after cm_remove_one(), eg for
   rdma_destroy_ah_attr() is wrong. The AV is part of the cm_dev and
   has to be cleaned up before the cm_remove_one can return.

4) The flush_workqueue() in cm_remove_one is wishful thinking, there
   are many places still using the mad_agent that are not on that
   workqueue.

   A proper 'av_lock' rwsem going to be needed here

   Which is another example of why every time I see some idiodic
   'is_closed' flag it is just a sign of wrong, wrong, wrong.

Fixing it requires a full audit of all the places using the AV :\

Jason
