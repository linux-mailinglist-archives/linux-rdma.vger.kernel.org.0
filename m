Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9439CDDC
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jun 2021 09:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhFFHQH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Jun 2021 03:16:07 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42503 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhFFHQH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Jun 2021 03:16:07 -0400
Received: by mail-wr1-f41.google.com with SMTP id c5so13707307wrq.9
        for <linux-rdma@vger.kernel.org>; Sun, 06 Jun 2021 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lPkZRVYxNiQhA3yFF3zhR11oorDZrMXbCZvlm3eV7SI=;
        b=Qy3LzGx8McZErPr/WLkMP+1yyZqF2B6fkSN46Y85vujn06cjfygcwxEA0UKerNzEHA
         IxUAGacyKwRatQqPJBodA+ntw/ae6rw6O9lNxnmpSP6qKi3Pa1ia1rooEkkexqpmLSsj
         +clsf5wfXwwLbfEZFP3dOL6S3pTfRpNyRGRQxdOVLaJa1sy9Y5cUaAmqv4FjT54uLvSq
         lNefI7WZABHCVkx/r5S29Hx1FeO7IHXVNOvDxivc3x5kpk/e/gelndtTxIylZbuz1jHY
         0kq7NEmSEStKv/gzh4oGY+xBRavHtDpHfQ6KPjgNWj+hW1fKuPHVCgcef8Og8FeYzJ94
         9j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPkZRVYxNiQhA3yFF3zhR11oorDZrMXbCZvlm3eV7SI=;
        b=o5dfJ3dKq4K6huAhQQai9eSG0fv7UBjQ9ZUJ7Y6RnOecfiZVig1MUOrBs22bOfK0Nh
         KorxZruqZQjWm9eqgojFdhJsglNQVZqY6oFWFnFUJ6U9glC3L1cN7g9KZymvsAPNslum
         HlbmKmnJ/ZFW92flg2AsjWWkM86FwX6WtuDPX/F3bnkYXXH8A4YU0Vnno3eyuinvb4zw
         QpzqvRXn3qgVJ9tdD3nWu9iImI0BNi4Ijjjoj0ggTnw2TGuBexbXAssCExq0GJDb7Lxw
         5G4bACnzzq6M/6hwO+3gaEGHgRp6AOzqoOj4hZACu9doSbXWN1Izqo2KNP1ongWLYGYq
         N3kw==
X-Gm-Message-State: AOAM5339Z4ur7roFUAQZXSM5zPqdyTVoELUU2WcsgOcnWBTBbyQcb1uU
        CrLNYdE07HDCVxyIFTIUSzk=
X-Google-Smtp-Source: ABdhPJwpOcEj+kWfBevoVnXgom9ysQkbLVp3WAOAjR1QwnMP8dcXYgryHyWHER1kF62XhnpPJKRPew==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr11202714wrv.319.1622963597592;
        Sun, 06 Jun 2021 00:13:17 -0700 (PDT)
Received: from kheib-workstation ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id f14sm11492521wry.40.2021.06.06.00.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 00:13:17 -0700 (PDT)
Date:   Sun, 6 Jun 2021 10:13:14 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Fix failure during driver load
Message-ID: <YLx1ijRFem8hnk2c@kheib-workstation>
References: <20210603090112.36341-1-kamalheib1@gmail.com>
 <20210603195145.GA322047@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603195145.GA322047@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 04:51:45PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 03, 2021 at 12:01:12PM +0300, Kamal Heib wrote:
> > To avoid the following failure when trying to load the rdma_rxe module
> > while IPv6 is disabled, add a check for EAFNOSUPPORT to ignore the
> > failure, also delete the needless debug print from rxe_setup_udp_tunnel().
> > 
> > $ modprobe rdma_rxe
> > modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> > 
> > Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > --
> >  drivers/infiniband/sw/rxe/rxe_net.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> I tidied the pr_warn english and put this to for-next
> 
> It has been broken for so long, and in such a small way, I can't see
> this as a -rc fix.
> 
> Thanks,
> Jason

Thanks a lot Jason.

Could you please add the reported-by tag to this patch? - I've missed
it, Sorry :-(.

Reported-by: Yi Zhang <yi.zhang@redhat.com>

Thanks,
Kamal
