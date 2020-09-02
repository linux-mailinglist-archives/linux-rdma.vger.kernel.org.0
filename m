Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74025A50F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 07:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIBFdZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 01:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBFdY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 01:33:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05AAC061244
        for <linux-rdma@vger.kernel.org>; Tue,  1 Sep 2020 22:33:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so3805828wrr.4
        for <linux-rdma@vger.kernel.org>; Tue, 01 Sep 2020 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkY1jNWSSSeIw1HAKpdMIgEupd8wVOkph4iVZolXkQc=;
        b=WXl79ckC6fculkqTa3dBSfapSM2Awz7utBbu7S6/Ihm6C4Z9qDSmKLM0zQVgAYHHXZ
         sEe4rnD0Rz1hCYK9zvAUD0NmRfy9PkbUMn21AwScyL1JDjRrKWdcWSeSlCaUzqB+aoBp
         HC2abTNhGr2/QBdJe7f8nSxmtydDqfEOVgMbBzMnhI6e52FZVRvs0RgRgQlcXPuX81zd
         n11zy4Ol/4aUjRHJMluRZg20f0i4XkSJjThLCZytIMETHaT4fkAnYbu+hH8AEkaFTBeT
         YmpxPatA2zR5xRD+79KY+k+5xgjHt+5FxOCDWh8ACfhZigUl47Spbd5KuTeF1Mf7rdEY
         mbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkY1jNWSSSeIw1HAKpdMIgEupd8wVOkph4iVZolXkQc=;
        b=P/dg6XEK6Neo30O0fkBo2polRmulIv6QwVb2NlMhaVPpPfFdf6hllkflpviLlNQa2Y
         ep7e7DnLWnL6peLkl2BwFeS1ZmrReKFE7cNJBP6jYkXKo03zXxJglDRoIPIRjVkiT88F
         sepLdXuAdS/9r4z2IF10Kp9NBSClUfRYKOG0+KZeYrNC7x9O5pdfSVnPEjrQE/e3JUD6
         Z5HOePW4Y/sLxvRTGK2IK2oUIdXSg/ALO2BDAQ/9LgUrWdWXGe0g62pmMD7ERLqHGj0n
         HS/SN7ANBnyKU/stcM/fDj+L99ZHTSb5+tKwvQ7K6FslsAizLGdJmY8Dcj/WG/SmpgII
         cMvQ==
X-Gm-Message-State: AOAM530Yl2DWfwQGb17KDFMa+ccYkDdtEbN8092foMqsVPNR5ibooBAf
        LubHSZB6ptWV/fcaeCxLH8lYGJXetGA=
X-Google-Smtp-Source: ABdhPJxwns+uDm57QnT5bXglEqRICtp5nHobWy80FRmOokeL0p9z11aRL8AAlVHrAqhKsM72sEfvMQ==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr5525014wrj.92.1599024802314;
        Tue, 01 Sep 2020 22:33:22 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id b8sm5109522wrx.76.2020.09.01.22.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 22:33:21 -0700 (PDT)
Date:   Wed, 2 Sep 2020 08:33:18 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200902053318.GA177054@kheib-workstation>
References: <20200825151725.254046-1-kamalheib1@gmail.com>
 <20200827121822.GA4014126@nvidia.com>
 <20200827142955.GA406793@kheib-workstation>
 <20200827145450.GK1152540@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827145450.GK1152540@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 11:54:50AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 27, 2020 at 05:29:55PM +0300, Kamal Heib wrote:
> > > Can you send a PR to rdma-core to delete rxe_cfg as well? In
> > > preperation to remove the module parameters
> > >
> > 
> > Someone already did that :-)
> > 
> > commit 0d2ff0e1502ebc63346bc9ffd37deb3c4fd0dbc9
> > Author: Jason Gunthorpe <jgg@ziepe.ca>
> > Date:   Tue Jan 28 15:53:07 2020 -0400
> > 
> >     rxe: Remove rxe_cfg
> > 
> >     This is obsoleted by iproute2's 'rdma link add' command.
> > 
> >     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Oh! Lets drop the kernel side of this in Jan 2021 then?
> 
> Jason

Works for me.

Thanks,
Kamal
