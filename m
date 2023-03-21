Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBE6C343D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 15:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCUOak (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 10:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCUOaj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 10:30:39 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67771BDC
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 07:30:15 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o44so7059983qvo.4
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679409015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbU99SWtOFsTcPeL8h9gSXMwUmqlwx4vYY7Hby5PQfg=;
        b=gQbjKJMSKLPe+9D/31qCeTI/CRO3h8cGup+U7hGSfXWSbjvfUwcdKLX93ZFVhpOCS+
         wLPzHg0mziOZGtCH4rq6nXi2pDA/niALXq/jVVz4GJTwb7VVgnuEFkX518zvGaE64Z80
         7TmXvxq1USQ6XfQnn6Aw+CvdBTl1qvBNI6MVWRl5BkbZziAHU/z+P81mpLcgHJGLo/8G
         Cpit0VGfqkAdcwrHNvTfpust6/P52WLc3Pt8RzZIaSu6q1RAUSdoFjNuZBOsrTgTDAMy
         fo3hDZQWVOk1Y5dOIP+4lJ5tPwTmfVjzp6UzhVKkuU1PkH5xDgWf1zhDdm9W4yME0BiW
         liwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbU99SWtOFsTcPeL8h9gSXMwUmqlwx4vYY7Hby5PQfg=;
        b=OpL+JVSCdVvjPe7sZYlbRLxYInnDTE8OZU60z/OXiGm3mpazwUb0nG2irudlpjTdjQ
         9ay/G7O36vIEuHYEzmQl2mLsfyPssqMHDiL41XgrOsVpfT4a1AnE22oRkbo4a++ZxnUV
         bFJ02RaJbmuVb2FrOYc2KatBG1u824FHCMPTw26JclXlKZL5xMXh+XdJ63ZTuVI1/j6n
         W1DLcTWoIlrRDnIZ+4R2nkvyiVqWdxLrS5nMWu1Cz1hbHAdnCm7sIbGzAgvvDVQQhW5t
         50hzs5uW7oDd0wkuMaejeXqznjRv0MPiLYDzrSiPjg3qc1RyqK17rLRB3TzvlEOqkGwX
         FWRg==
X-Gm-Message-State: AO0yUKU2XqDiBOvXdV0npP/RNiroRQhn/Fglno5PdZtMEwSluI1YmL/I
        D2FSWchqyfF6z1ZdIhyXobZNu3kkjHtBMDs2wZc=
X-Google-Smtp-Source: AK7set9cL8Km5qdwzfYjcdy6BxIyopyfUaHchPm9FGrSIl7Yaxe3ELUpmRkpucsJd6JwkoX/idGrew==
X-Received: by 2002:ad4:5d44:0:b0:5c8:403a:22f8 with SMTP id jk4-20020ad45d44000000b005c8403a22f8mr228349qvb.5.1679409014790;
        Tue, 21 Mar 2023 07:30:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s189-20020a372cc6000000b007429961e15csm9532642qkh.118.2023.03.21.07.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:30:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ped09-000VOL-7J;
        Tue, 21 Mar 2023 11:30:13 -0300
Date:   Tue, 21 Mar 2023 11:30:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <ZBm/deQgMYfdPt/u@ziepe.ca>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315102210.GT36557@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 15, 2023 at 12:22:10PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 15, 2023 at 09:58:06AM +0800, Cheng Xu wrote:
> > 
> > 
> > On 3/14/23 10:10 PM, Leon Romanovsky wrote:
> > > On Tue, Mar 14, 2023 at 07:50:19PM +0800, Cheng Xu wrote:
> > >>
> > >>
> > <...>
> > >>
> > >> Our doorbell space is aligned to 4096, this works fine when PAGE_SIZE is
> > >> also 4096, and the doorbell space starts from the mapped page. When
> > >> PAGE_SIZE is not 4096, the doorbell space may starts from the middle of
> > >> the mapped page.
> > >>
> > >> For example, our SQ doorbell starts from the offset 4096 in PCIe bar 0.
> > >> When we map the first SQ doorbell to userspace when PAGE_SIZE is 64K,
> > >> the doorbell space starts from the offset 4096 in mmap returned address.
> > >>
> > >> So the userspace needs to know the doorbell space offset in mmaped page.
> > > 
> > > And can't you preserve same alignment in the kernel for doorbells for every page size?
> > > Just always start from 0.
> > > 
> > 
> > I've considered this option before, but unfortunately can't, at least for CQ DB.
> > The size of our PCIe bar 0 is 512K, and offset [484K, 508K] are CQ doorbells.
> > CQ doorbell space is located in offset [36K, 60K] when PAGE_SIZE = 64K, and can't
> > start from offset 0 in this case.
> > 
> > Another reason is that we want to organize SQ doorbell space in unit of 4096.
> > In current implementation, each ucontext will be assigned a SQ doorbell space
> > for both normal doorbell and direct wqe usage. Unit of 4096, compared with
> > larger unit, more ucontexts can be assigned exclusive doorbell space for direct
> > wqe.
> 
> I have a feeling that there is an existing API for it already.
> Let's give a chance for Jason to chime in.

This sounds similar to how mlx5 chops up its doorbell space

But I don't understand your device security model.

In mlx5 it is not allowed to share doorbells between unrelated
processes. Doorbells have built in security and a doorbell can only
trigger QP/CQ's that are explicitly linked to that doorbell.

Thus mlx5 is careful to only mmap doorbells that are linked to the
QPs. On 64K page size userspace receives alot of doorbells per mmap,
all linked to the same security context.

Improperly sharing MMIO pages can result in various security problems
if a hostile userspace can write arbitary things to MMIO space.

Here you seem to be talking about overmapping stuff. What is the
security argument that it is safe to leak to userspace parts of the
device MMIO BAR beyond that strictly cotnained to the single doorbell?

This has to be clearly explained in the commit message and a comment.

Jason
