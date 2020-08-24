Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A739F25013D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgHXPea (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXPe0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 11:34:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114EDC061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 08:34:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r15so9123507wrp.13
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+D2AMGWHVkCdLKv++7Xm4DUDl4qyqb/DDwk3cJvAbM8=;
        b=GlFce9pHQZssqisppcWmoWpF/nZ7xwW9dTfLqYX8qR0/KMeVoI1HmfFAnzAa/SvJY2
         IPEWJfDPCzT0PMsk9FKEW3hxSRzfl77RTV5RS4geDtlOStwW9NHqqYKo4E9bdqzPCOeu
         4gsKHJQB06HutywyHWHqPDJxLt31mZmlg9VSpCGdmM9yQRN9rmG01sOFu6sILlDbo9sx
         Bsx2wAFGvgooNdCZwW56P3VK7UHYBZ1j30BOmWmiscbm6bvGi+ce3xT5Bc1visFGepRX
         Tp8sRdHLcesg6fMDtqIAr8YIJvDdASU7n3eSsuBJuL4d1zmQV5Ol7Q6wZc8aLVmfztLF
         8y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+D2AMGWHVkCdLKv++7Xm4DUDl4qyqb/DDwk3cJvAbM8=;
        b=K4rUG4iIpUSfe9LF9lap+vDiufs9fhU1WSOe3fB+dzNWGkNdgSDunZn31wBdns1jvB
         NXR4wvB0Q1E3AhETD+jc81v6tjBlGljHlZj2VQOYduCCNxg5vNkO+e2UtqZ7AZgqZNY6
         myjKda1jbLz1vgZYmQzPI6igR9h3yeM4m4N1PZIDmQ4UoGy+N50NF91HAAvBVdtXp+qM
         VxTniaodfSo9nE9iJAOyhtOCv4WYqV9/kpCOtRgBcSSCdhDlM9KiQLbV2vPIHHN/keOp
         I3rR5QSVnm/wK35lMrOZX4MCFDPPxV1YkbaUUTwAC0Nov/LDH9O5ZwH/UZm90nAR9v2l
         pGog==
X-Gm-Message-State: AOAM530PW1Zbp5bBkY/QTCPXWC3uSQsMdp2oOEVxe003zBFsMgi1dETk
        gqERPZvN3AslLdkxiLIiBMI=
X-Google-Smtp-Source: ABdhPJzacTHzbBBWcztt2TY8jnew/3CNa6SNmM5RGlSYjt6YhYmOP7ZmB1A3d+KJdM5flW+SP0GBMA==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr6412187wrn.83.1598283264741;
        Mon, 24 Aug 2020 08:34:24 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id r11sm24486903wrw.78.2020.08.24.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:34:24 -0700 (PDT)
Date:   Mon, 24 Aug 2020 18:34:21 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200824153421.GA150111@kheib-workstation>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
 <20200818163157.GY24045@ziepe.ca>
 <20200818211545.GA936143@kheib-workstation>
 <20200820113717.GA24045@ziepe.ca>
 <20200823194558.GA36665@kheib-workstation>
 <20200824134723.GD24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824134723.GD24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 10:47:23AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 23, 2020 at 10:45:58PM +0300, Kamal Heib wrote:
> > On Thu, Aug 20, 2020 at 08:37:17AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 19, 2020 at 12:15:45AM +0300, Kamal Heib wrote:
> > > > On Tue, Aug 18, 2020 at 01:31:57PM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> > > > > > To avoid the following kernel panic when calling kmem_cache_create()
> > > > > > with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> > > > > > context of device initialization.
> > > > > 
> > > > > I think you've hit on a bigger bug than just this oops.
> > > > > 
> > > > > rxe_net_add() should never be called before rxe_module_init(), that
> > > > > surely subtly breaks all kinds of things.
> > > > > 
> > > > > Maybe it is time to remove these module parameters?
> > > > >
> > > > Yes, I agree, this can be done in for-next.
> > > > 
> > > > But at least can we take this patch to for-rc (stable) to fix this issue
> > > > in stable releases?
> > > 
> > > If you want to fix something in stable then block the module options
> > > from working as actual module options - eg before rxe_module_init()
> > > runs.
> > > 
> > > Jason
> > 
> > Something like the following patch?
> 
> Yes, something more like that
> 
> Jason

OK, Thanks!

I'll send v3 soon.

Thanks,
Kamal
