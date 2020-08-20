Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225F224B901
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHTLhf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgHTLhV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 07:37:21 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D0C061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 04:37:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so695523qvo.13
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3eBdXPUqbQZesfS0qm2B+p2TJGppTRVpf8/j38F3/s=;
        b=QmM3e1QH8bNuwch0ixZqrTPxV9fyobV3RFzTSRAekaUIFOP20UuQdyBtZSkzVopxE0
         7gOlxwkUAfXB5IR/DShuwvd5iHj2ged+gdoa6ZvH2KshzUeIkJyqqhvc4HkGearcuRwx
         n660g+oRlcp5kU55wMHWbVbA4cgWEOSNjCFfe/GoinD5P/j4zP+TneEQvk1oisrt6hGl
         YnihYd+Q9E53TQZuHC9VJYfhzaBALX+dw73kYCAmm/PSk+9LCuFkPW7MZKbaQHUuLuAb
         eALGENeXVMBtQyP8BPp/OaMvMA52dASTOT5mznNgWb1EWuhR6Qe9KomBdinWIIvksKKN
         mm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3eBdXPUqbQZesfS0qm2B+p2TJGppTRVpf8/j38F3/s=;
        b=O0DwvTOZ4Q10q5qQHgEuAjoekJa3Vqoq0WruxsQWpxF1JVff1Miz10ZvJRuumKupVi
         MZLMtMPm0I3WzSNqPuNkIMIB3rtALB7HgnDOxHtemDhvtVhrw1KCBVT81FaFGYHVUADh
         blY6Vx0uuqIMD3WWSjy4xC77u0dlnrPZTRVOvEYfR+y7y7+jeLgjH4zKtRUsIYXljNtX
         TNbVCIv7UH3RGmer3l0m0604BN2i5got4/tUkv3Dtco95ojC2dRLjX21ZCY5bDCSpgbe
         QrCh6spdZP3SmvLqdeqHiXM/ffGwP44N21fHjZL5Z3X0WE33JsB9UI0E9ZfRBaLSDmeY
         RZcQ==
X-Gm-Message-State: AOAM531gOeN/R8kJvqJ2KoeosVifAKs+Py930KobFwLmBDgiHg3WE4N2
        1i/stqqXsDSIUjLpn07iU9eFhkn2xQeGHA==
X-Google-Smtp-Source: ABdhPJxZz5Rw/PfpXCOLR/B1tpokKg0mRbIg+bmZ2qQJsmLf6VXTsiwlrCavOdwxx8cRNnzUPFVfAA==
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr2384703qvp.191.1597923439174;
        Thu, 20 Aug 2020 04:37:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o15sm1978666qkk.95.2020.08.20.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 04:37:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k8isf-009t68-AB; Thu, 20 Aug 2020 08:37:17 -0300
Date:   Thu, 20 Aug 2020 08:37:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200820113717.GA24045@ziepe.ca>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
 <20200818163157.GY24045@ziepe.ca>
 <20200818211545.GA936143@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818211545.GA936143@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 19, 2020 at 12:15:45AM +0300, Kamal Heib wrote:
> On Tue, Aug 18, 2020 at 01:31:57PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> > > To avoid the following kernel panic when calling kmem_cache_create()
> > > with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> > > context of device initialization.
> > 
> > I think you've hit on a bigger bug than just this oops.
> > 
> > rxe_net_add() should never be called before rxe_module_init(), that
> > surely subtly breaks all kinds of things.
> > 
> > Maybe it is time to remove these module parameters?
> >
> Yes, I agree, this can be done in for-next.
> 
> But at least can we take this patch to for-rc (stable) to fix this issue
> in stable releases?

If you want to fix something in stable then block the module options
from working as actual module options - eg before rxe_module_init()
runs.

Jason
