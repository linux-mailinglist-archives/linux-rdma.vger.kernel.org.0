Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B82ADE35
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 19:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJSY7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 13:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKJSY7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Nov 2020 13:24:59 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137EC0613CF
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 10:24:58 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id h15so12383841qkl.13
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=V/6gfszAYVYz7DGAlmCLhZrUPfPuR0ZaUx8/0Zh3mv4=;
        b=he1Nj7Bde/eHrsEsgHLWcPTNc6NIvkGB1gbHnK6donuOIoXYgDFeFCCZc7cZl2NspT
         fJujzdISyoLw4UHNAhFIl+IYi5tgekNyDak6IbUChGGnS9H15tclPF4ROyEYs0CY2OjK
         taiutvzPBDXbm9iq5sWzpjpie1r86dvWSPoWBVx/Ilw8pdrTbiaCm4QQPthezXmYM0T4
         Kt7h2EAYJm67p4FuWWnzbZ35z3TZJmjRDJiq4ZuaJdesDybQ3zDt8GTSsSBNP3c4FpIp
         1H8iBxDN3ODteGfxKs/ZWPGnxen67sJRjP+jZThnthZDUCZxUQIHPTDdYGBidkOFVZ1Q
         mprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=V/6gfszAYVYz7DGAlmCLhZrUPfPuR0ZaUx8/0Zh3mv4=;
        b=fWiA8gRqjncLiDsCaotnkgepHSNGLyi+q57Fs19oyPirTx0dlXfDEe3zRBoFHJMZp1
         ODIKjnIbb4cdLYjmuVN6rGxdlphjaLpqfPykQgG3SWQfaDLj/kEFZ30mHihMjm8hpPp7
         8WGrHToTVse9qj5jdPJ6tssmcogekfvrif5meBNtAEGj4ZG/FJhAhL1cmTFaPOMWzg20
         Si2FhQCerEmipUY/kUd2cPMWGjILz65GpOtcJTCEkqV7adF90nwSA4Aksw14kYlxjh3T
         i/NMDhWLI7q+rwioG/NgZ02Uv7dUnYczXy6r3eTTBuyRCTPVpZGahPvpkZMuRaMwT5N1
         zC+A==
X-Gm-Message-State: AOAM531b7oLqei7XecpILo4nzYM/5jj30q8laezEDBiXXl0HobqdEC3r
        TgKVcWjBzBU8mXhR6mqOenOM/dZML2TTmAK/
X-Google-Smtp-Source: ABdhPJzz19HhPyWzqZngbcv2nAA59FArSMcikgJl6CZRIkRevopZW3P8DDqYW09sg4++17koU4C15g==
X-Received: by 2002:a05:620a:100e:: with SMTP id z14mr19843501qkj.278.1605032697680;
        Tue, 10 Nov 2020 10:24:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p73sm1402540qka.79.2020.11.10.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:24:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kcYK8-002lRF-8F; Tue, 10 Nov 2020 14:24:56 -0400
Date:   Tue, 10 Nov 2020 14:24:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: UCX annual conference
Message-ID: <20201110182456.GO244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

UCX is going to have their virtual conference a bit earlier this year,
there is a couple of GPU and RDMA topics related to HPC networking on
the agenda, particularly in day 1 that may be interesting to a broader
audience.

The details are here:

 https://github.com/openucx/ucx/wiki/UCF-Virtual-Workshop-2020

Attendance is free.

UCX is a popular higher level communication library that is designed
to provide functionality suitable for implementing popular HPC
frameworks like MPI/SHMEM/GAS.

Jason
