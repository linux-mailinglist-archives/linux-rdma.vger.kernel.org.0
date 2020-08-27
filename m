Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66392544BD
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgH0MCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgH0MBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:01:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE74C06121B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:01:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so240521qtv.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AAD2KMUCZHspGbNY1OKaqeudmE1L9m0E5cmaxQemlhk=;
        b=aOPdC3LXNbjr/tpDl5VNy+/tn4T/oH3zITIINAtV8Fh3BhtikNw4v/rvufisPv5Rwc
         y3gMXMawItLuGFTKDzPbGTtY0OC+PVNwF+y4cU/wAoVELkpVqViiDid15YixNoFcpKOT
         ugaCvFn3WSUxyCBrCSgMIZ0VRvEHLLGBjEszKEIFGdfHFotjTey1l9IzvGKu+IyJAutl
         Ix6eoyGJhDh6nDu58QdceqaiZIOHqvw1wkP2y0GPBQMITfjeQVU86ZQyl8nTD0T3zQ4+
         3VHQpLv+DYYJYlV/M8/HtjsD1Ei6LbzRbUxRtkB8EGmEamsmSvjaD3GkPLsPCAhZUoTT
         bvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AAD2KMUCZHspGbNY1OKaqeudmE1L9m0E5cmaxQemlhk=;
        b=Phcx0KBNZUz86gyybz+QAWwAnekPNRbWXzHCN0aqWyYlh7Z2yBxjLiA8Zst+oCH3M6
         HNABj71+7xRI9Z9qEYDY45Bg2vEq+4ZYkd5ONRXgGismhTBRUNjLny1jVE+sDqGAJqvu
         kAJbY5XyhX0XfTN0i2e7hc+bqC/23Le74YZFm9oWhEyo7AkfdwYqYZRSktWzZWo0RpBf
         fR3jyj1T9HMSDUNyuLc861pVS6bxBw8EaiQvgXg8rl1CLcoZxxThNt9D5DaWczeXIe/e
         T2bTsq/uYmftyCtZzDpLgYDSMA/lr12vsQv4+55I3f2MVPL9setHSMfgCppLmiGEwqxc
         3pLA==
X-Gm-Message-State: AOAM530Nz+uosf62UOTF3GyekkwPqM8toCn4Yrw2Bz7fKw6s4locFsz7
        TTFvzDmZaHYTKOdEVo0y28kl1w==
X-Google-Smtp-Source: ABdhPJy84sUvzgS2Da95Ol6YeWPDIA+CsDjpelIHJdzse2C8zd2aqPEL4uKKK6IbsqN7m3k2JYAgsA==
X-Received: by 2002:ac8:3902:: with SMTP id s2mr9426280qtb.258.1598529701042;
        Thu, 27 Aug 2020 05:01:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x28sm1552356qki.55.2020.08.27.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:01:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBGb5-00GmDe-HN; Thu, 27 Aug 2020 09:01:39 -0300
Date:   Thu, 27 Aug 2020 09:01:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
Message-ID: <20200827120139.GL24045@ziepe.ca>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
 <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
 <20200820135338.GA114615@kheib-workstation>
 <20200827075356.GA394866@kheib-workstation>
 <4be87aa7-bc3c-d8f1-05e2-9276125cacc2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be87aa7-bc3c-d8f1-05e2-9276125cacc2@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 11:20:16AM +0300, Gal Pressman wrote:
> On 27/08/2020 10:53, Kamal Heib wrote:
> > On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
> >> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
> >>> On 20/08/2020 15:53, Kamal Heib wrote:
> >>>> Now that the query_pkey() isn't mandatory by the RDMA core, this
> >>>> callback can be removed from the usnic provider.
> >>>
> >>> Not directly related to this patch, but pyverbs has a test which verifies that
> >>> max_pkeys > 0, maybe this check should be removed.
> >>
> >> Or changed to work only for node_type == e.IBV_NODE_CA?
> >>
> >> Thanks,
> >> Kamal
> > 
> > BTW, do the efa care about pkey?
> 
> Depends.. We only support the default pkey so it doesn't do much in terms of
> functionality, but we still need to support it as part of the QP state machine
> for modify QP.

Does the pkey appear on the wire, or is it just some cruft for API sake?

Jason
