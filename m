Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92321B93A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGJPRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGJPRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 11:17:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA28C08C5CE
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 08:17:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so5536744qkn.11
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GN1jOvvTxOMY7PexnsNMFmhaYfQAnavV6gzUxca3hIE=;
        b=NjiQykNyCgspGidJMkHq2hhGb153bzkxxXbPARlWjWICiOhvkoefma/bojwNkLVyQQ
         8fugKUIbzMCbJZGmO3w3DVAy4RRCF5MxDxKwexw0s056WBIvbO0mTNICPNX/3P9vsi4c
         xrEXjoHJaeMvtaL2k/UXIS2gXdbZqWAnVIK4Om0rAzLMh1x+5+K2A1zrV5YekvYr0RIO
         8Pk2wzLX1NigCTxgQnzskvSOWjdqHAmebTdtDlKgLGdlMo/I8PmtpUzuJSD8YzvZewRC
         DhOQFMkka8pZv5/NDXOcxt8j/Tw4eV3HbUIy7o/Dy1i7uF8feohK/jVXJFfEe9b+Aywx
         cEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GN1jOvvTxOMY7PexnsNMFmhaYfQAnavV6gzUxca3hIE=;
        b=d+VXPxbTJafl4qUiVZwq9QAxpyuwPLWgnFJFLEGvfPASmcmtOEUDEfZGSwFi1eH3wM
         1Ddfkj/CpbnmdQDWQ/jZQlo1OPcZYC+tZrsipSAAO4dzE9yEC061c7f/ANkSevYH8LwK
         iz4XIBBD6CrQFIs2y4fRvYPmik5M6uslDd+ff2/hJV9kBHFDqO5WRbZsbhkfhjM00jup
         bqNKdkj7ytWyAMkz826X6J21FRt+1oxAmWqXzRdxGtCruZlyrsQb+8npDUBNLDI2HoAw
         RqeuoJjh2rYESCgaKllKjvHWL6FaHkOESMFIYnyRrSrt97qIBnKh2UcfD5wnZaBj21F0
         x64g==
X-Gm-Message-State: AOAM533dSfwDHNDpsLpnP1as83UQ7RcmiwYdGhwgnBVB+i3dULMcf5VW
        0JKMKIVUTgNC8N5ipKB+dpqDFhfEu6t6UQ==
X-Google-Smtp-Source: ABdhPJxAi71W4YQWDm+K6KU928BqJBoP7DgVBD+28r34B0NZGjOxAtSuRaGzZLo2cBqAEfXoqU4e8g==
X-Received: by 2002:a37:7747:: with SMTP id s68mr69667959qkc.42.1594394258988;
        Fri, 10 Jul 2020 08:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t65sm7850655qkf.119.2020.07.10.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 08:17:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jtumP-008LSC-KI; Fri, 10 Jul 2020 12:17:37 -0300
Date:   Fri, 10 Jul 2020 12:17:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, aron.silverton@oracle.com
Subject: Re: [PATCH RFC 0/3] IB CM tracepoints
Message-ID: <20200710151737.GZ25301@ziepe.ca>
References: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 10, 2020 at 10:06:01AM -0400, Chuck Lever wrote:
> Hi-
> 
> This is a Request For Comments.
> 
> Oracle has an interest in a common observability infrastructure in
> the RDMA core and ULPs. One alternative for this infrastructure is
> to introduce static tracepoints that can also be used as hooks for
> eBPF scripts, replacing infrastructure that is based on printk.

Don't we already have tracepoints in CM, why is adding more RFC?

Jason
