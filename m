Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846D738BDB
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfFGNma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 09:42:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46446 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfFGNma (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 09:42:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so2223774qtn.13
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnW/twM6MkT3sK1ZhrwgxUqvD0LPiRdOubIMmtxqWdI=;
        b=fOBioA9m9PbWefjn1DmJWxfFXCC2dztfbWTo9BaFpc1JJx99fsn9by4LkHonqKcFmM
         d/2SspLVs5CoByQJzhZGvsoKTPp5pbaAMXH/Y3xnQgNd85ur/14fqcJt/zQPtZRGnhan
         hRpZi3W37HzqC4a9zJzl2YUJbc3HDrINupGkFqNcTc57YBA+twb6v9h7pN4lWFUIZh/5
         fXWs4cmg6a6Z4mz+q5dP4OTA32NAxXoy6nmukwYHw4QH3BhKt9SZ5xtA10sXK/+ww6j6
         Rpga877RogkeluQhFKwv8FEazUzN2dRczANS+ORbtBYTcceCE2B/jT2rHsQls1Rwme7b
         Lo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnW/twM6MkT3sK1ZhrwgxUqvD0LPiRdOubIMmtxqWdI=;
        b=YE2ITbtgPoMcQmYlTL33wAVsk4Q70HCusA6vq1tMQDHqdMO8ZghF5ZDteq/jHgwMkn
         ubDRaLtRsM/UqF5blki5p5jKmK0bCkV6iIFI6B/eIgGNESvohaRU6XHLtDD87xJHC18w
         /A5/w/lf00P4fum1a4QliQ3g8xFJitHHfixa0shCvpEtPFe3maWagP5vV5SnDqZCz3rc
         mz1u1mo9k9g5oBpe+x7wA9BJL2vFwLI4amQ09oBIpf2SX0WnRyde+ZbqECJFc13qiez/
         F6aMg6RqSeczea74Du8XHAR1SzdqeVCutJA9iUU5GujsIUIkxmOGlHx4WbAFN3DEXoAi
         OczA==
X-Gm-Message-State: APjAAAWKGPLyrgLedY2YSnHf7kw4KihCK82EjQ1vv2e1iA6zLochnvpJ
        WxRdPQ3AqRBKxXlz51HEX5ToVg==
X-Google-Smtp-Source: APXvYqwsAceJbR30iBQCPsJ2106L5t6QxNp2dZRUeMJkrJIRo66xTGleQFJNlMPYL+7b91XqCDSsBw==
X-Received: by 2002:ac8:3811:: with SMTP id q17mr17943650qtb.315.1559914949560;
        Fri, 07 Jun 2019 06:42:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m66sm1104947qkb.12.2019.06.07.06.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:42:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZF8W-0008Kq-EF; Fri, 07 Jun 2019 10:42:28 -0300
Date:   Fri, 7 Jun 2019 10:42:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
Message-ID: <20190607134228.GG14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
 <9c72d18d-2924-cb90-ea44-7cd4b10b5bc2@nvidia.com>
 <20190607123432.GB14802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607123432.GB14802@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 09:34:32AM -0300, Jason Gunthorpe wrote:

> CH also pointed out a more elegant solution, which is to get the write
> side of the mmap_sem during hmm_mirror_unregister - no notifier
> callback can be running in this case. Then we delete the kref, srcu
> and so forth.

Oops, it turns out this is only the case for invalidate_start/end, not
release, so this doesn't help with the SRCU unless we also change
exit_mmap to call release with the mmap sem held.

So I think we have to stick with this for now.

Jason
