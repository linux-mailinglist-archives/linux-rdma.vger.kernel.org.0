Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DA258002
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHaR7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHaR7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 13:59:35 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37B2C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 10:59:34 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b13so2903895qvl.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6SMzVvZLO53VHn+aP1+g6cXkP5Lp9oqzq139vxxvzdE=;
        b=bf6qwZ2SxNanzzyOYcAMGsyhhe0N38j0qD3v4Afg//R2s5pdkD3K4G+vbc8afSZgg2
         9wtNw7t3ioaW95rZ0KRxcSGi9XFT+yEIoYjQMl1o54GwUyuht/ZMDhosW4EQzSjcIiUj
         yAGGcg5MgR0krV9/lwCjjFCLXd4lrBYMAIv/SkRvUMMbDIZbcT75FvcQRvuxj/2mFqxP
         pThHrgR1go5jbU1/Za7vFIAZPw3haqj9TZi5Li8Y+eoLB8GwfsWTbrYHnlqZDUKoJDVa
         f5CK1pJ4d6MZgqZqgd/Iz5aptD6BAPxB9Ji6swBfgdODhRgskEzD7LcWcjsibB2xmH7K
         oaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SMzVvZLO53VHn+aP1+g6cXkP5Lp9oqzq139vxxvzdE=;
        b=Fz3DHW5krUnyZT7oLZvRV+Q+vMem5D5JrrfE0812vs/cZTo+BcnnkFV6nnplOemSHc
         X1b43D7tevgj182y7+45F0H3W/pyLeuKOrywbUa89zMOT9JZ5yfz7e46PUMaKPP2sr57
         wrdi8LeH1t3PXKac7oE4majVhDB3+VnltSEkjR+cTrfdrxOKfXhXmMvWLscaOGLt40jZ
         0NRC+wR39q7GgYyJws0sVOaLstXIBgdSMdQse6KCs/oU+ogVT0KuA3N9dLox754NoyAv
         Dfw+FyWSUJC9A6DAeJYHwKopV7PojqBYk8sSW6rJxbUWehyWgplRNxAk3ukv4cIsZsmf
         hZ5Q==
X-Gm-Message-State: AOAM5326k9av2trFAome24CHA3f35H1/v5EvL6SQ75arDvC54Of09DBo
        F7RzI4fV0laCvS2HxI4Nyj/yC5S2ajJtxQ==
X-Google-Smtp-Source: ABdhPJxgJUVaED3hCkr4aKE/cox+yqscHEz+1dG6WFGY7HL0O+kCk/5leCgSxTXWBYxJqtMrBbEOrw==
X-Received: by 2002:a05:6214:d43:: with SMTP id 3mr2223939qvr.47.1598896773334;
        Mon, 31 Aug 2020 10:59:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s5sm10342396qke.120.2020.08.31.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:59:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kCo5b-0032Xa-Um; Mon, 31 Aug 2020 14:59:31 -0300
Date:   Mon, 31 Aug 2020 14:59:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     doug@easyco.com
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200831175931.GC24045@ziepe.ca>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
 <CAFx4rwRQ7z+sATpKuYNwTWqnepcWQeinxFjsZEEDAQobeSVACQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFx4rwRQ7z+sATpKuYNwTWqnepcWQeinxFjsZEEDAQobeSVACQ@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 10:02:15AM -0700, Doug Dumitru wrote:
> On Mon, Aug 31, 2020 at 9:48 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > >> Currently we allocate rx buffers in a single contiguous buffers
> > >> for headers (iser and iscsi) and data trailer. This means
> > >> that most likely the data starting offset is aligned to 76
> > >> bytes (size of both headers).
> > >>
> > >> This worked fine for years, but at some point this broke.
> > >> To fix this, we should avoid passing unaligned buffers for
> > >> I/O.
> > >
> > > That is a bit vauge - what suddenly broke it?
> >
> > Somewhere around the multipage bvec work that Ming did. The issue was
> > that brd assumed a 512 aligned page vector. IIRC the discussion settled
> > that the block layer expects a 512B aligned buffer(s).
> 
> I will second that block layers expect "at least" 512B aligned
> buffers.  Many of them get less efficient when bvecs are not full, 4K
> aligned, pages.

Can we put all this info in the commit message please?

Thanks,
Jason
