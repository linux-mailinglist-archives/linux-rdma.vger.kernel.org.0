Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901AD2547C6
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgH0OyY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgH0NLt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 09:11:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97DCC061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 06:02:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so4414014qth.5
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=78rf7AgA30q6Y54D6yAfg2L/fW+SQqq3MiYZR2F/3/c=;
        b=Je/sywxoScHevZF/mIVvxhpSkZqsRGrAlvFiknREaSsV5SapTrrhWV43lr+GmEYr79
         P3F4PhUjvpmxpSgOoOtRDu89bIuhfBbphOHF4VRJpjG4rFCxLClKplswhfK0E1fka9aR
         27PDQbeyE7600IiCf7YJPq73k1s4EsrA2qeDaWIJYsYSKFGw/bkINHv8TpVioApFIO9g
         5Z7sNG5cfCs5dCZMKUezPaxsJxwLmKuUp2/7ST3gQSJsx8CUDa2H9vhVG8gHmXTcAc8x
         wNFIKTM4u2g7MjAI4lByvEmXU8qAiDKuccbLJBYKy265hzRHc7P9oA2+i1ORXgwiE3/+
         QrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=78rf7AgA30q6Y54D6yAfg2L/fW+SQqq3MiYZR2F/3/c=;
        b=YhGoybbt1JvW3+ff0F/TftLOmv3YL1ATZWY/koE3xqQ0TN4L800A7peOlGb9PSKF7N
         3OE7z2tKqHoYc+d1x6g4mUPsKudbKIrSvQFd3RT3rP03Bc+Gy/SzJL8t9CkI2MCrVZwJ
         vb52QXUdeAVjlPi2eKsjyzZ49M1jzGLEcF3YEiON2gUxASPPBXBa8iC2fQtbiS1kBidQ
         hGacs5UfgZevxYYG8s2fozI5YkT/YDvW0qIYgGa/LLiLNLP8/2UILyP/ySFdf8ZlWhbM
         rzz1kZOU148/BA85I2tlWicTW72M5TuMWC/KYsLkruUiJFp/X5UNTPGn+D8yCAsCx7DD
         U3hQ==
X-Gm-Message-State: AOAM53075cuPnQQWeeyQUhFvhPyGM+sfS2NNJHPwTdCPziNcrqO97gZd
        mvoxHh1RYtq/ArYqruOxhUMPdg==
X-Google-Smtp-Source: ABdhPJw5f6jRg3nvl659wdmrgyTg6EKf4Nbw8DFzOl0qrdoC4BNQB6y6qgCk0FsNa1TM5q/ym/or0g==
X-Received: by 2002:ac8:104:: with SMTP id e4mr18674326qtg.47.1598533320024;
        Thu, 27 Aug 2020 06:02:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a67sm1715447qkd.40.2020.08.27.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:01:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBHXS-00GuHF-Qq; Thu, 27 Aug 2020 10:01:58 -0300
Date:   Thu, 27 Aug 2020 10:01:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
Message-ID: <20200827130158.GS24045@ziepe.ca>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
 <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
 <20200820135338.GA114615@kheib-workstation>
 <20200827075356.GA394866@kheib-workstation>
 <4be87aa7-bc3c-d8f1-05e2-9276125cacc2@amazon.com>
 <20200827120139.GL24045@ziepe.ca>
 <ACEC991F-E03B-49F5-95D0-42C78CC2B78E@oracle.com>
 <0f1aa022-3271-bec3-146d-eb3daa518447@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f1aa022-3271-bec3-146d-eb3daa518447@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 03:58:23PM +0300, Gal Pressman wrote:
> On 27/08/2020 15:20, Håkon Bugge wrote:
> >> On 27 Aug 2020, at 14:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >> On Thu, Aug 27, 2020 at 11:20:16AM +0300, Gal Pressman wrote:
> >>> On 27/08/2020 10:53, Kamal Heib wrote:
> >>>> On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
> >>>>> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
> >>>>>> On 20/08/2020 15:53, Kamal Heib wrote:
> >>>>>>> Now that the query_pkey() isn't mandatory by the RDMA core, this
> >>>>>>> callback can be removed from the usnic provider.
> >>>>>>
> >>>>>> Not directly related to this patch, but pyverbs has a test which verifies that
> >>>>>> max_pkeys > 0, maybe this check should be removed.
> >>>>>
> >>>>> Or changed to work only for node_type == e.IBV_NODE_CA?
> >>>>>
> >>>>> Thanks,
> >>>>> Kamal
> >>>>
> >>>> BTW, do the efa care about pkey?
> >>>
> >>> Depends.. We only support the default pkey so it doesn't do much in terms of
> >>> functionality, but we still need to support it as part of the QP state machine
> >>> for modify QP.
> >>
> >> Does the pkey appear on the wire, or is it just some cruft for API sake?
> > 
> > On the wire. Included in the BTH (Base Transfer Header).
> 
> He was probably asking specifically about EFA.
> I can't share any details about the wire protocol, does it matter?

If it isn't actually used for anything then the driver shouldn't
expose PKEY at all, if you do use it then leave it.

Jason
