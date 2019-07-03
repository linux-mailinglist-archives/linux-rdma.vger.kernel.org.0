Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86255EB24
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGCSGn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 14:06:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45673 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfGCSGn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 14:06:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so4773636qtr.12
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ToftDpk3YrcSbBZhtnBxGsKO2ZP07D/2OfTgI0i0uPI=;
        b=W3wPhHmpTQ43DiEhpXLLpfWad0m3QcjtIlsFSFaMhtWLP5fQYEzH4zXlqA/lvP/mAj
         rsx0I37l8Lgk5EimoRQmZrZDEu6ptuT3udBUftMKrCY7eX9ZzdzG8vt5MPnflGX8vpOE
         hS3RF6p05vccc9yKrZoIAghr9p6qcGrvQQL2tGWoRzkV+q/A1bbvv+vKhi/wZKl4xjsc
         GINvnUu3PRMf9i8ZRlgmDwS9hz8Y26HrGV+qoRXI1NeVO0NvhRZAhiAkpX9gXpNzsCyX
         D9o3hUYM9CqVMVLLN7DAd+0vumokHTUU90t+S7T/WgnheaqjjgFJRzBn9zGSuAWHc3ba
         9szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ToftDpk3YrcSbBZhtnBxGsKO2ZP07D/2OfTgI0i0uPI=;
        b=GaKGqnMrvgYof3vD2RXnJP+HB+94EIqDrshonPm3++dwHPnyDEBW+K+z8IPLJZwWfY
         0jpyN/O4f4mYXfVuRsR6GMXu6K9dKoCLP7mQK9cRPIE14LKP9lAdZqjToJ1pOgq6zax+
         0GaN+Ao8EbWC6VKHR8KzAbhCy2io+BETOpTiR0fK7v5LaS8UHUP5SyoWN4/BOy25vdIc
         3mbMLN80f8rfakWh/1DF3u8oUg6RCqnPnH4P71Mi70Z7N8JHIK3AN5WIFWxJMTG8B6eh
         dAN6ZlUSGgu6sEziE9AwxGGOVLUZtp1qZdvV2mIfkd7VYewLCHtEV/t6VI+ePzaL1dW2
         h61A==
X-Gm-Message-State: APjAAAUScNPDp9pJ0ofAPTFnIcOeLGAO3uERSiuU66HHupEK46pPMrjV
        zieA2hNqokNxwJ+QEX4Vz4V02Q==
X-Google-Smtp-Source: APXvYqxfAdl/rS1zkdiwnCoG6FZnVkmECzM4PdHMcOUfOstYGpg6luDIqyyrZyV+wr1IBsMgo3nk7A==
X-Received: by 2002:ac8:70cf:: with SMTP id g15mr30724496qtp.254.1562177202306;
        Wed, 03 Jul 2019 11:06:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g13sm1183325qkm.17.2019.07.03.11.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:06:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijeT-0006sw-IA; Wed, 03 Jul 2019 15:06:41 -0300
Date:   Wed, 3 Jul 2019 15:06:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 01/43] docs: infiniband: convert docs to ReST and rename
 to *.rst
Message-ID: <20190703180641.GA26394@ziepe.ca>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
 <4d843d0361e245861f7051e2c736a18dfaae7601.1561723980.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d843d0361e245861f7051e2c736a18dfaae7601.1561723980.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 09:19:57AM -0300, Mauro Carvalho Chehab wrote:
> The InfiniBand docs are plain text with no markups.
> So, all we needed to do were to add the title markups and
> some markup sequences in order to properly parse tables,
> lists and literal blocks.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../{core_locking.txt => core_locking.rst}    |  64 ++++++-----
>  Documentation/infiniband/index.rst            |  23 ++++
>  .../infiniband/{ipoib.txt => ipoib.rst}       |  24 ++--
>  .../infiniband/{opa_vnic.txt => opa_vnic.rst} | 108 +++++++++---------
>  .../infiniband/{sysfs.txt => sysfs.rst}       |   4 +-
>  .../{tag_matching.txt => tag_matching.rst}    |   5 +
>  .../infiniband/{user_mad.txt => user_mad.rst} |  33 ++++--
>  .../{user_verbs.txt => user_verbs.rst}        |  12 +-
>  drivers/infiniband/core/user_mad.c            |   2 +-
>  drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
>  10 files changed, 174 insertions(+), 103 deletions(-)
>  rename Documentation/infiniband/{core_locking.txt => core_locking.rst} (78%)
>  create mode 100644 Documentation/infiniband/index.rst
>  rename Documentation/infiniband/{ipoib.txt => ipoib.rst} (90%)
>  rename Documentation/infiniband/{opa_vnic.txt => opa_vnic.rst} (63%)
>  rename Documentation/infiniband/{sysfs.txt => sysfs.rst} (69%)
>  rename Documentation/infiniband/{tag_matching.txt => tag_matching.rst} (98%)
>  rename Documentation/infiniband/{user_mad.txt => user_mad.rst} (90%)
>  rename Documentation/infiniband/{user_verbs.txt => user_verbs.rst} (93%)

I'm not sure anymore if I sent a note or not, but this patch was
already applied to the rdma.git:

commit 97162a1ee8a1735fc7a7159fe08de966d88354ce
Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date:   Sat Jun 8 23:27:03 2019 -0300

    docs: infiniband: convert docs to ReST and rename to *.rst
    
    The InfiniBand docs are plain text with no markups.  So, all we needed to
    do were to add the title markups and some markup sequences in order to
    properly parse tables, lists and literal blocks.
    
    At its new index.rst, let's add a :orphan: while this is not linked to the
    main index.rst file, in order to avoid build warnings.
    
    Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Jason
