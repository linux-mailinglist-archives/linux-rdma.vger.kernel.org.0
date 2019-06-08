Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7539D49
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfFHLdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 07:33:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32893 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFHLdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 07:33:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so4501576qtr.0
        for <linux-rdma@vger.kernel.org>; Sat, 08 Jun 2019 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lXGspEHCJbsk8rcUX58kNgJSDj9yX2lNCrXRKPLPfY=;
        b=cQto6lY11nB7CtyFVsb4EWl/wSLEbWjYy53473tDxhVa+M8kUBtzMhsyB4GzDkwDxV
         q+kMV3+bqlucZoGG+l3NUydWUmA01Kdk2/AmaOWjogGX9cZ5VHeo4NXfNrqxa9973eio
         jEWacea/Hw5cMfA8v2U6v7fZH/FxhaA8zRa/sqGqp9oG8OkETGNmhyB3dR63HPNpwJq3
         bTef+d3XCAUCKnqZ2kfsu5R+6/Una6mdshi9VfoOWhgkoKLdvmGi1Faluq9FD8FSmrwe
         Lml1z8nOCaJ2hrr3JC/PpvYRD94dpvVxrBx2HEhfbkPIJl6PJI/3BtMNPyc9TsLDPXIT
         qE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lXGspEHCJbsk8rcUX58kNgJSDj9yX2lNCrXRKPLPfY=;
        b=iXBt0ee9VybxBJ5Ku0yfYPdJtWGGFHnAhP6yysmlubLr3k7hLdbd1A1GfEex8cKP4k
         OCkCh9LfTHiQmG5+Slg/o390g8nd3gK2iFYYk8CWRIWUmqeyFyt4wydIsc6WlzoKSHjr
         fxg4ZuLPuTYF7uL1d3X6S0+/RPhmTQlqVGVqAxTid1Y28YoyjNiTruxUqqcZQhLUfokd
         KwH7VLslYmra+fiGiAycLA3nmenMuR7Z0YrzMJhXE5vJ3ckOYNsqcQNqK5Asmal5XRQX
         hguKH674QXlzQ+IH7eAHq8ijEAIAjD4vfdIOjy57L8gYAuvSz+tcVTGEuANmLINw7UlI
         Qe3Q==
X-Gm-Message-State: APjAAAX6vT2cBjkZ6kJGwxDggvdcrFnrufuIHd1xtUKVuxrPF2fWq5gC
        tDXaf7gUScCOd1svRbKV0EpY+w==
X-Google-Smtp-Source: APXvYqxyYPohAHdX/cPPDfW1JlnojtSPLPS5vSeQSfnXomKNh388kBmPHyLX8ufWHVYbMbkJEo8bCw==
X-Received: by 2002:a0c:c164:: with SMTP id i33mr30155410qvh.37.1559993587190;
        Sat, 08 Jun 2019 04:33:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i55sm3386912qtc.21.2019.06.08.04.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Jun 2019 04:33:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZZar-0003rc-2C; Sat, 08 Jun 2019 08:33:05 -0300
Date:   Sat, 8 Jun 2019 08:33:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
Message-ID: <20190608113305.GA12419@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
 <20190608084948.GA32185@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608084948.GA32185@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 01:49:48AM -0700, Christoph Hellwig wrote:
> I still think sruct hmm should die.  We already have a structure used
> for additional information for drivers having crazly tight integration
> into the VM, and it is called struct mmu_notifier_mm.  We really need
> to reuse that intead of duplicating it badly.

Probably. But at least in ODP we needed something very similar to
'struct hmm' to make our mmu notifier implementation work.

The mmu notifier api really lends itself to having a per-mm structure
in the driver to hold the 'struct mmu_notifier'..

I think I see other drivers are doing things like assuming that there
is only one mm in their world (despite being FD based, so this is not
really guarenteed)

So, my first attempt would be an api something like:

   priv = mmu_notififer_attach_mm(ops, current->mm, sizeof(my_priv))
   mmu_notifier_detach_mm(priv);

 ops->invalidate_start(struct mmu_notififer *mn):
   struct p *priv = mmu_notifier_priv(mn);

Such that
 - There is only one priv per mm
 - All the srcu stuff is handled inside mmu notifier
 - It is reference counted, so ops can be attached multiple times to
   the same mm

Then odp's per_mm, and struct hmm (if we keep it at all) is simply a
'priv' in the above.

I was thinking of looking at this stuff next, once this series is
done.

Jason
