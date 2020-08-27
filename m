Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7522546B0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0OVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgH0OVf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 10:21:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81993C06123C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 06:56:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e5so1953550qvr.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OmmniPiR7hJw6l1FNdVCVHv3dSf2vy5AirjkFr8TcMA=;
        b=L0LQPdjKtwYVLjj8Cw3O0GKfn7wuvz7LBf7jW8NZZWHMZDzwq5kkVhy6ui6bl32AF8
         XjVI88XPfRHD8WSIsKQ3vwQaCWCZhwzYQDlM1wNQetidVbcKs8oiyheg+Cj1lpe5ocFs
         kXLkj4Z515yuVZqLDWGXA4j3vQSZ+D/IxRZ2vBZLwJA5QST4fAQ2wfYbpuG8glDNP1fh
         88SBDRVR5N31YS1jgY+YFY7H3y4UdijTTLGihCnDr5KhuUDi9+l/54BP1wsyY7Rm7X13
         Ha3jr4YPdGYFj7AGq3VWcAkfDtPjcI8ANuGWVHhZPeYephPLHk8o3p7233v/k3/f+do5
         rRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OmmniPiR7hJw6l1FNdVCVHv3dSf2vy5AirjkFr8TcMA=;
        b=INHUoLkZqmU1kQXSxceJHKCCBQAIOa+Xp53TLfyxtITt5qKKc1+y2153x8HdeLWusr
         pCnXp7+swK4w8cegCrbYq4sTY7ZoBmxw08v6edubtpfzu5uQrhP1/+MPz/MwiCkY/iHj
         G8HzlXtDc/dtHpD0X7K3wbvU+1CFsSL/2Lu9+UrTyJQHoAEnS3KpfddB8wnmdbiDK/9E
         /A498w1Iul0XGoWf94hEkc0rymMCwJa/XXOgHcxCalY4zFxJ0C5NlGwJ9YQwEer+pigX
         HgfHH1AhebS4/lkPO/PJOqBsx9lUrZnwbv6koAs5FgFdqjF1DUue2RiTfJ12tLvyD8j0
         QgrA==
X-Gm-Message-State: AOAM530FGSI5yBvSZNBHE3czsr0u84Um3ej2oIBkbJktSE5UXHF5+6P1
        XFy14l6T/LNefH4PZqrryoZC6w==
X-Google-Smtp-Source: ABdhPJypjoLMGbms/fUBoy3t7SP/FaeXn2rcGDuoWg9ep8wUgNp1GWLndL5MNLc9fNOqS1eAvoJ5YA==
X-Received: by 2002:a05:6214:1590:: with SMTP id m16mr19020482qvw.48.1598536559759;
        Thu, 27 Aug 2020 06:55:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g184sm1875040qkd.51.2020.08.27.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:55:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBINi-00GvCm-Hr; Thu, 27 Aug 2020 10:55:58 -0300
Date:   Thu, 27 Aug 2020 10:55:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
Message-ID: <20200827135558.GT24045@ziepe.ca>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
 <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
 <20200820135338.GA114615@kheib-workstation>
 <20200827075356.GA394866@kheib-workstation>
 <4be87aa7-bc3c-d8f1-05e2-9276125cacc2@amazon.com>
 <20200827120139.GL24045@ziepe.ca>
 <ACEC991F-E03B-49F5-95D0-42C78CC2B78E@oracle.com>
 <0f1aa022-3271-bec3-146d-eb3daa518447@amazon.com>
 <20200827130158.GS24045@ziepe.ca>
 <0b734c22-0064-b674-f987-4eb94aae8545@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b734c22-0064-b674-f987-4eb94aae8545@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 04:10:27PM +0300, Gal Pressman wrote:
> On 27/08/2020 16:01, Jason Gunthorpe wrote:
> > On Thu, Aug 27, 2020 at 03:58:23PM +0300, Gal Pressman wrote:
> >> On 27/08/2020 15:20, Håkon Bugge wrote:
> >>>> On 27 Aug 2020, at 14:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>> On Thu, Aug 27, 2020 at 11:20:16AM +0300, Gal Pressman wrote:
> >>>>> On 27/08/2020 10:53, Kamal Heib wrote:
> >>>>>> On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
> >>>>>>> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
> >>>>>>>> On 20/08/2020 15:53, Kamal Heib wrote:
> >>>>>>>>> Now that the query_pkey() isn't mandatory by the RDMA core, this
> >>>>>>>>> callback can be removed from the usnic provider.
> >>>>>>>>
> >>>>>>>> Not directly related to this patch, but pyverbs has a test which verifies that
> >>>>>>>> max_pkeys > 0, maybe this check should be removed.
> >>>>>>>
> >>>>>>> Or changed to work only for node_type == e.IBV_NODE_CA?
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Kamal
> >>>>>>
> >>>>>> BTW, do the efa care about pkey?
> >>>>>
> >>>>> Depends.. We only support the default pkey so it doesn't do much in terms of
> >>>>> functionality, but we still need to support it as part of the QP state machine
> >>>>> for modify QP.
> >>>>
> >>>> Does the pkey appear on the wire, or is it just some cruft for API sake?
> >>>
> >>> On the wire. Included in the BTH (Base Transfer Header).
> >>
> >> He was probably asking specifically about EFA.
> >> I can't share any details about the wire protocol, does it matter?
> > 
> > If it isn't actually used for anything then the driver shouldn't
> > expose PKEY at all, if you do use it then leave it.
> 
> How would that work? How can you not expose pkeys and still have ibv_ud_pingpong
> work?
> You mean remove query_pkey, but still support IBV_QP_PKEY_INDEX in modify_qp?

iWarp doesn't use PKEY at all, so you'd have to follow their
model. Some of the userspace that assumes IB would probably need
fixing (eg ud pingpong does not support iwarp)

Jason
