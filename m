Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2851B6E52B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2019 13:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGSLqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jul 2019 07:46:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41185 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSLqz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jul 2019 07:46:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so30510923qtj.8
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jul 2019 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0jjdFiNkuhqvchRHcGPsH0wilH8Gr779DZhO2v0yAM=;
        b=RdYYPjgFXt84MxWQpA/qfrN+EJDTa9rrTndOvR8uYUggRYxMr3CgbZNKnOglA/J+sG
         PRI+/muDSuH0SL3OZGleJlUtKDyKEnTMSACsDVbbvGR1FBVjgj+2R9tekjfptsxZ9+pc
         PrTVg62NYBKMAPNqOaw1He6jAuYgfLWPbmT26/d1W8ZKkqcBa+CYOMHuPiPFq3crJTF4
         VtvsJE0GNwJoGy4DlcoidUoyLodIJQwP+9W+Qjeftqk/UjyPlzj1YqAucsDEYojah+tO
         ihVu7VmMnKu7VKMY2O+oBfSnmprqqvs/0fdmLqivNLE12yC+LM8EaeR1ZrPK1YRbMNXJ
         eDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0jjdFiNkuhqvchRHcGPsH0wilH8Gr779DZhO2v0yAM=;
        b=App+qTYJyK4/E6A18GBsYik6gEvSkbV/JMiRoyUhT1Gg2LbLhqtINRAKx1xhn+aFhn
         C0TCU3DSHMTT2/XHkuaxzEH6nKWbWO26S4/gqd9aESnlfP/8/2eZamWFu0s64lEuBBkY
         qjyNt8scISfto3i9ptSjp4PicAdftwI1SelULpNRJxuwht6kPBYSP4zfDTkgKM2RaGk9
         9vqed7wCJMRU0/5pFOokEDTcxupYMN+jttB8NZHMlOXE/z7ij3S3XmbnYKscitEQG4WA
         hAajOwW3M7N7M75ifUJu6IWvcFu5ku3B1cd7OyUGpMRIGDESDxUPQWGiS4uUYoDkVce/
         vRfg==
X-Gm-Message-State: APjAAAUk+jQG9QCwrAcGT3j1K6B1iu3qCh7VMuBiMKLXdkNUdhe5BWaD
        PR59GY2+YWggeDrrw1YskKhxEw==
X-Google-Smtp-Source: APXvYqw+DoelgWqF+sf2FJBzeu5MZkcOMSmEGnTRlWydQmmWOISapKniAPR3tnLoiwu8g9V+lVI7IA==
X-Received: by 2002:ac8:f91:: with SMTP id b17mr36341307qtk.352.1563536814571;
        Fri, 19 Jul 2019 04:46:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y42sm20591453qtc.66.2019.07.19.04.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 04:46:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hoRLh-00049m-Ax; Fri, 19 Jul 2019 08:46:53 -0300
Date:   Fri, 19 Jul 2019 08:46:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190719114653.GA15816@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
 <20190717203112.GA7307@lap1>
 <20190717204505.GD32320@bombadil.infradead.org>
 <20190717213636.GA2797@lap1>
 <20190718121747.GB1667@ziepe.ca>
 <20190718204551.GA5043@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718204551.GA5043@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 18, 2019 at 11:45:52PM +0300, Yuval Shaia wrote:
> On Thu, Jul 18, 2019 at 09:17:47AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 18, 2019 at 12:36:37AM +0300, Yuval Shaia wrote:
> > > On Wed, Jul 17, 2019 at 01:45:05PM -0700, Matthew Wilcox wrote:
> > > > On Wed, Jul 17, 2019 at 11:31:12PM +0300, Yuval Shaia wrote:
> > > > > On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> > > > > > Like I said, drivers that require the creating ucontext as part of the
> > > > > > PD and MR cannot support sharing.
> > > > > 
> > > > > Even if we can make sure the process that creates the MR stays alive until
> > > > > all reference to this MR completes?
> > > > 
> > > > The kernel can't rely on userspace to do that.
> > > 
> > > ok, how about this: we know that for MR to be shared the memory behinds it
> > > should also be shared.
> > > 
> > > In this case, i know it sounds horrifying but do we care that the process
> > > that originally created this MR exits? i.e. how about just before the
> > > process leaves this world we will find some other ucontext to hold these
> > > memory mappings that driver holds?
> > > Or how about moving this mapping from ucontext pointed by ib_mr directly to
> > > ib_mr?
> > 
> > What are you worrying about? My point is we don't need to *anything*
> > if the driver objects for PD and MR don't rely on the ucontext. This
> > appears to be the normal case.
> 
> but we saw that mlx4 (and i think also 5) do use the ucontext, i think to
> undo umem_get stuff.

It is unnecessary, remove it.

> > MRs already work fine if they outlive the creating process.
> 
> You mean if we leave the creating process alive?

No, let it die, it is fine

Jason
