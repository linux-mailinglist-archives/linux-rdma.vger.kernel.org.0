Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652D624FF48
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHXNr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXNr0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 09:47:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C983C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 06:47:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k20so2606059qtq.11
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HfhOit7Arhz08SPWc31ipRgGWd+Q7zSE0khhdlNkM2E=;
        b=gDHfHBTcHWKHDB5d4MDRJ617IJQZH9dPo4n8BWiWsIa7G7i89qbyCmE3azx0JNePEz
         Angi67Y7MEmjx74Bi8ORIx6riOgA72ISfT11VkR2Ep+k2Cm/TeKev5HRpQXWiKixbEql
         w9PXaKI8wEa7nq6CBfmVqP+5EeDyodXuvpBB6xTnYTpH62WIp1BsOWUcIdtaJCWrBW8U
         U/0Mu77dt8BHytOyfLEdiEUgSOh2MYhbdMTGQmScl8eXQvKyArrj25eLy4TozTxsMfVg
         Y9aI/0HNwxJT3riQ9FwLBtLlAUVfzSIWZZbMG9srRu9Caz7hglnbPj2Zmki3GBBYRhC9
         cK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfhOit7Arhz08SPWc31ipRgGWd+Q7zSE0khhdlNkM2E=;
        b=fto6lANS4sYohVzO3PVMZ2BDtzX2viVSDkdy/uyDuITy1DrdljcyD5OPfvgkmkxwB4
         7NN+s8m3s4m0xKHg/Mqao381q+XlVPT7pgbX4swe6/rapVT9CDmqrFI84NHmo3Zx8SwZ
         +0bZUYvwKthPjb+6r54yKuouWAFUxcpg//wFezJid9FHMfZsjYyVUN0VJEnp7ChsUqaC
         Qgz76QYCk41LkqZwcTxUQo9SA4D9+agrxhdfrFN91gzbCX6YCr25ENjecPbk7CM7Fc8S
         7J6Wnvsfd9fc7NyY7cnpBia/GqjTq35JxAhT6VN2sxNuvr7lv7myOtdjXayYwykNP9Kg
         fAHg==
X-Gm-Message-State: AOAM533uwm83qDkvqAl7/PBAf3HrR7Z6DGK+zI4booBgazOjTJlj4BGU
        4KNJulJwXaDqa4f1DznS+ITNow==
X-Google-Smtp-Source: ABdhPJwNG8xw2vVNxzjOVd5b5Mavl1loiZMHFDqXRNr1KPznAZQc0Uf/hdqZyC/UKYa5+UoqDyXUfA==
X-Received: by 2002:ac8:777a:: with SMTP id h26mr4674273qtu.141.1598276845412;
        Mon, 24 Aug 2020 06:47:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w28sm2431790qkw.87.2020.08.24.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 06:47:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kACol-00DFil-EQ; Mon, 24 Aug 2020 10:47:23 -0300
Date:   Mon, 24 Aug 2020 10:47:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200824134723.GD24045@ziepe.ca>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
 <20200818163157.GY24045@ziepe.ca>
 <20200818211545.GA936143@kheib-workstation>
 <20200820113717.GA24045@ziepe.ca>
 <20200823194558.GA36665@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823194558.GA36665@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 23, 2020 at 10:45:58PM +0300, Kamal Heib wrote:
> On Thu, Aug 20, 2020 at 08:37:17AM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 19, 2020 at 12:15:45AM +0300, Kamal Heib wrote:
> > > On Tue, Aug 18, 2020 at 01:31:57PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> > > > > To avoid the following kernel panic when calling kmem_cache_create()
> > > > > with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> > > > > context of device initialization.
> > > > 
> > > > I think you've hit on a bigger bug than just this oops.
> > > > 
> > > > rxe_net_add() should never be called before rxe_module_init(), that
> > > > surely subtly breaks all kinds of things.
> > > > 
> > > > Maybe it is time to remove these module parameters?
> > > >
> > > Yes, I agree, this can be done in for-next.
> > > 
> > > But at least can we take this patch to for-rc (stable) to fix this issue
> > > in stable releases?
> > 
> > If you want to fix something in stable then block the module options
> > from working as actual module options - eg before rxe_module_init()
> > runs.
> > 
> > Jason
> 
> Something like the following patch?

Yes, something more like that

Jason
