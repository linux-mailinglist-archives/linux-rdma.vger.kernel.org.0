Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984F5CC1F1
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbfJDRpT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:45:19 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34121 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfJDRpT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:45:19 -0400
Received: by mail-qt1-f180.google.com with SMTP id 3so9706159qta.1
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bi0XR3hupm8FaWsiionOtqXr2yCT1RATJYfj2jN7Nko=;
        b=aD6KFFs6/n0WLfple7V8WOE5Wn8rrv+FMdylWq2mm0aAyC8nDUHgeMNxYOvFQpPDHE
         EbC8IsDUCdrmV7vWoxKmhQpGS/8czZbFy59AVPIEeqEyYkXoLFvGTkdsvDw4noRhceu7
         cuvQJIke4a2mmXF2MVv0/53BkYBEirAH/R6RqJxS0c+06M6IHXTcr/28HdpFnzQsA/Yc
         yEnAKlUc/heMZY9R6Br1zY9lNHZvfV37Q+suHlj7ql1pLrTAUa27zqw+EBt7uV2GbcC7
         m4R/GvDj9KGcLmIEea1kW5EDLlgb4uyV11CGwAzVicslYxkATIF57uJagDlwU2e2Yoci
         kcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bi0XR3hupm8FaWsiionOtqXr2yCT1RATJYfj2jN7Nko=;
        b=sWKMM6Ui6hCj9zof7KKX8or4fdWQc/DJFA05SJpnoD6P4+rvP/Bq6PRxn5lekRAjKc
         US1ZvYt7WwUbYWsZuZhpIdX3YtYPPfNGEUCrXSZaMWjuyVgF4KU0XQOLAxVeA6MWrROv
         jGMebpFHTTk5sSFRN5yGzxgyadfX+5BAiiSpG6obSAhG0Uw3aJGXcAewQZeKOKfmZX/2
         JEoVt9CDsY5ESNlyG1q/NCf+b7+KmCgEwsak/wxR25PYZOSn8gbuJyDCbBHrdaDiMXjN
         +gVp5+MBgTqbOcLH6RHs/5ot2npzofkg3nYS/ZdqwMuBR0lGWEymI138TAMF0Kx9xr/D
         gcYw==
X-Gm-Message-State: APjAAAVQXI6USFYuOjh0Rn1rMCOBkxDC5J1Y1T2FpS6kEj7bzryFxOrw
        KeZWOQ6Fhf1WNGFUL8A4FtTUQg==
X-Google-Smtp-Source: APXvYqyPAWyb3vaf4qK5ug4xP+qdVBPW0ywm32J6kQwwYKPon44JN0O7N/RjTxu6idcF4CccyzhWjA==
X-Received: by 2002:ac8:1302:: with SMTP id e2mr16882073qtj.326.1570211116678;
        Fri, 04 Oct 2019 10:45:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s16sm2817091qkg.40.2019.10.04.10.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:45:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRdj-0005rL-Np; Fri, 04 Oct 2019 14:45:15 -0300
Date:   Fri, 4 Oct 2019 14:45:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191004174515.GE13988@ziepe.ca>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191004002609.GB1492@ziepe.ca>
 <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 06:15:11AM -0700, Michel Lespinasse wrote:
> Hi Jason,
> 
> On Thu, Oct 3, 2019 at 5:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > Hurm, this is not entirely accurate. Most users do actually want
> > overlapping and multiple ranges. I just studied this extensively:
> 
> (Just curious, are you the person we discussed this with after the
> Maple Tree talk at LPC 2019 ?)

Possibly!
 
> I think we have two separate API problems there:
> - overlapping vs non-overlapping intervals (the interval tree API
> supports overlapping intervals, but some users are confused about
> this)

I think we just have a bunch of confused drivers, ie the two drm
drivers sure look confused to me.

> - closed vs half-open interval definitions

I'm not sure why this is a big problem..

We may actually just have bugs in handling the '-1' as it is supposed
to be written as start + (size-1) so that start + size == ULONG_MAX+1
works properly.

> > hfi1/mmu_rb definitely needs overlapping as it is dealing with
> > userspace VA ranges under control of userspace. As do the other
> > infiniband users.
> 
> Do you have a handle on what usnic is doing with its intervals ?
> usnic_uiom_insert_interval() has some complicated logic to avoid
> having overlapping intervals, which is very confusing to me.

I don't know why it is so complicated, but I can say that it is
storing userspace VA's in that tree.

I have some feeling this driver is trying to use the IOMMU to create a
mirror of the userspace VA

Userspace can request the HW be able to access any set of overlapping
regions and so the driver must intersect all the ranges and compute a
list of VA pages to IOMMU map. Just guessing.

Jason
