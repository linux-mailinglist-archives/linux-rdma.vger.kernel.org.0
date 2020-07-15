Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771CC22092A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgGOJs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbgGOJs6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 05:48:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2279AC061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 02:48:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so1753312wru.6
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z0v1ACtO8DiejCTAVZjthlb+HkcGa5ZhH0jlWivcu3s=;
        b=Kem3fYZYCKjImSjrSYKXbcW5M0zHc0f3+uYB9z0PZf4SZr9z/30QsEK6QB4p1gCRFx
         0Tu2WhsFQnE7MQ3xwisNLw34S/8HvtsdcM34EaU50WGr9Ba0FFRPwbtIV/UyZjIKx3+a
         T9O2+In9S2v3EU2dRXmFiZTZedVceEF6gwHcZEQI7SWfYF9BkH7N38I24txBeJ48OjrS
         hZOvXL4ZM5u1V2ktzLGenwxv/jC3UcSFS7yn+kOQ1SoX5Sn4lNqbZPTXiSARYL/i22su
         jW35/I492TEL3LamYfZz2KJnFVJzpJo1CSj981Is/V9GY0br5eZafivawfD3Y/QrP/nf
         UPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0v1ACtO8DiejCTAVZjthlb+HkcGa5ZhH0jlWivcu3s=;
        b=s13ouTirRqUo6wy1yusOxEPhHSaVP/iaQOSFAnv5zCVeT39p/uaP5kbg9KUmnBfXdw
         gb6VG15VR6xdjm5Y072k3Xj+kh4AVA62tvdW9HpdTNOyEY4u0D+7rNnNfF5WjhnyZyca
         0yfJpTABY2HgAimsJTkNBEZ7VVQTTAer3tsb0PY5P8+vXrNgf2tswPqgm+mYQZdrYB5r
         sAEymMvIxMwRmHaWeUy4qbisCrwqZhEIAQJgwqEPLAOdDIjmWsxEOOCmUeRsZdsR7NZq
         qSrhm1STm9NmV56yn6OoBAuvE86VrpZRgqR5YAVYT7/J0jPmY5Z/BJdkR3HqGtHrnlKU
         wRzA==
X-Gm-Message-State: AOAM53008M+qjJHEUvSjM2CiUiGhJX0UKP5VZcDkHj5hlTYWvwyNzK6O
        ahunZLihaly8heC4zVum/VE=
X-Google-Smtp-Source: ABdhPJwzrdq5uPigaWFB7wVZL6zKfr6oAPaw0FV2rv0+NID7iHJRPfVPY777c+Sexs3naPllBYm9vg==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr10290271wru.321.1594806536913;
        Wed, 15 Jul 2020 02:48:56 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r1sm2628240wrw.24.2020.07.15.02.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:48:55 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:48:53 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next v1 0/4] RDMA/rxe: Cleanups and improvements
Message-ID: <20200715094853.GA118152@kheib-workstation>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
 <20200714081433.GA13271@kheib-workstation>
 <20200714195606.GE25301@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714195606.GE25301@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 04:56:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2020 at 11:14:33AM +0300, Kamal Heib wrote:
> > On Sun, Jul 05, 2020 at 01:43:09PM +0300, Kamal Heib wrote:
> > > These series include few cleanup patches to the rxe driver.
> > > 
> > > V1:
> > > - patch #4: Fix commit message.
> > > 
> > > Kamal Heib (4):
> > >   RDMA/rxe: Drop pointless checks in rxe_init_ports
> > >   RDMA/rxe: Return void from rxe_init_port_param()
> > >   RDMA/rxe: Return void from rxe_mem_init_dma()
> > >   RDMA/rxe: Remove rxe_link_layer()
> > > 
> > >  drivers/infiniband/sw/rxe/rxe.c       |  7 +------
> > >  drivers/infiniband/sw/rxe/rxe_loc.h   |  5 ++---
> > >  drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
> > >  drivers/infiniband/sw/rxe/rxe_net.c   |  5 -----
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c | 24 ++++--------------------
> > >  5 files changed, 9 insertions(+), 38 deletions(-)
> > > 
> > >
> > 
> > Hi Jason,
> > 
> > Could you please tell me if there is something blocking this patch set from
> > getting merged?
> 
> Just hasn't reached the bottom of the patchworks yet, follow along
> here:
> 
> https://patchwork.kernel.org/project/linux-rdma/list/
> 
> Mostly stuff goes bottom up except for trivial, rc and resend of
> things I already reviewed..
> 
> So for instance you could answer Zhu here:
> 
> https://patchwork.kernel.org/patch/11585485/#23417655
> 
> To clear out that patch..
> 
> Jason

Thanks for your reply.

Sorry, I've missed Zhu's question, I'll reply soon.

Thanks,
Kamal
