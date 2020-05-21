Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0667F1DCF3C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEUOLH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 10:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgEUOLG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 10:11:06 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E7C061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 07:11:06 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a23so5577828qto.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmWfwhgc14N4r1GC/TTcy67eaUSdpcHcY5rqC/FkdEw=;
        b=KgJO9DH3NMCgC1a1WjSpxKQZwonUPMjnKZV+3gvHFrymwb5sidjrQ9xW0qGKPVD+xJ
         NtO2NQEttoZVtdUwttiwvA8diQzl3/2CQLGuNlfRtA45dcU8GDImWYsBFKUDofcsubcV
         ZOqw9pqkcHxO9Oa/f2aBmLuEU22PvCIspgHxtYcCQwXnAd29kXE64bQSOunjuAhSLsuW
         U/tJY6jjMDwY3frtoeYwJ2WwqrZ4wJNs5lrIMvgh6mNjXNhBCvuc0I23HKakuCoNNPQF
         YxJOoMF3FNwAL6qGVjKozgV2o6XhfK7YEj4sGjJ2UFWkiTOsV1svGGI3RQpdJ52EcTdh
         PFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmWfwhgc14N4r1GC/TTcy67eaUSdpcHcY5rqC/FkdEw=;
        b=lyzON2OR/mXLLqzWoJGwWNCk3K5NfH5Kkajyab/YCIEIyl527RAFknOPIujTzMC+6K
         Ua+8UrENXivqnMDqtbe5LPphOSobfIN8NluADkdghjTSf+urw7XFDokHXj5REBzKNzR3
         zryPtl0IKVblpFVAQfFVWpZSjdmjcvT2/+d0dSfbT/GLISm4Qog0lnjH5T+TMGu5UVTb
         0f3NaplkgTAzKkcdeEh4YdyUJCEuQLTdDBWX1ujt0zjyJ0pHOSTQNIHCQbIAIsXxaQIG
         Xy3uSeXeVHVWHbJ6qpPziiMnHpUUKU9DQAzEGjvq9cU9Arpt6y8LMlcPtYrz/bHUUId3
         L+Tw==
X-Gm-Message-State: AOAM531J6Y3hyTVB4Z0WVz+iRf1PK5xhY2VSoDwooykg00l46p/s50fc
        FRngrHqBir4ytDAqNNP6cHlPvg==
X-Google-Smtp-Source: ABdhPJzNj/eeNxn7mh7rR3YfzG4SWy/X0KkLISbAMCZZhQ8etbwpWwLl2uoQhjPUukeCpL7AibKSvQ==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr10693052qtu.76.1590070265656;
        Thu, 21 May 2020 07:11:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r25sm3396056qtc.16.2020.05.21.07.11.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 07:11:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbluZ-0006fz-Ty; Thu, 21 May 2020 11:11:03 -0300
Date:   Thu, 21 May 2020 11:11:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Fix setting of wrong bit in
 get/set_feature commands
Message-ID: <20200521141103.GB17583@ziepe.ca>
References: <20200512152204.93091-1-galpress@amazon.com>
 <20200512152204.93091-2-galpress@amazon.com>
 <20200520000428.GA6797@ziepe.ca>
 <1a80d736-3fde-0aca-f04a-d416742bf3ff@amazon.com>
 <20200521135731.GA17583@ziepe.ca>
 <4a6835db-0cc9-e94b-c86f-a8fafef0cf46@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6835db-0cc9-e94b-c86f-a8fafef0cf46@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 21, 2020 at 05:06:28PM +0300, Gal Pressman wrote:
> On 21/05/2020 16:57, Jason Gunthorpe wrote:
> > On Wed, May 20, 2020 at 11:03:00AM +0300, Gal Pressman wrote:
> >> On 20/05/2020 3:04, Jason Gunthorpe wrote:
> >>> On Tue, May 12, 2020 at 06:22:03PM +0300, Gal Pressman wrote:
> >>>> When using a control buffer the ctrl_data bit should be set in order to
> >>>> indicate the control buffer address is valid, not ctrl_data_indirect
> >>>> which is used when the control buffer itself is indirect.
> >>>>
> >>>> Reviewed-by: Firas JahJah <firasj@amazon.com>
> >>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>>>  drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> No fixes line??
> >>
> >> The reason I didn't add a fixes line (and sent it to for-next) is that it turns
> >> out this is the first set feature command to use a control buffer so nothing was
> >> broken, but this is necessary for patch #2 to work.
> > 
> > It should probably still have a fixes line in case someone decided to
> > backport the 2nd patch. But applied without
> 
> Hmm, you're right.
> If it isn't too late:
> Fixes: e9c6c5373088 ("RDMA/efa: Add common command handlers")

Okay done

Jason
