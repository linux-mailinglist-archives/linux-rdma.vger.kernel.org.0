Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF5244D28
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Aug 2020 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHNQyM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Aug 2020 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHNQyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Aug 2020 12:54:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F323C061384
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 09:54:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f19so2902044qtp.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n7vuOI2gvI49p7Knz6FsmTjaz68/k6d7QHRrqp4avsg=;
        b=YJVGQCHLAsQ0LcrBTyP2PbSvOPWU7S/0w2kSNY0N47MErq0LXCS+NFsXQgl7gHwb53
         5w3B3apk9lo5/8frsqxRM3njJXv/IhXny0N+j2Ytpm/uIApy/puo0cscPX8/w4zvmwVe
         P+sYUVwAeeTjofUfqzXoxyCPCdtNEAfzt32J837O8eCAL5POmK+1xDtbejXpfc27fvMT
         YwHRzR/09Al2DieypfD0HlwTPc73F9GQpz9MabhFYqPEFPFCYYaWUvWqvOGpflef3TcW
         Lhkuij3W000YDkRTcKRnPKWJyQUcvWpjbFTY9uCRn0mlCQEZESWbIYO+k+fNNfKWGFrC
         t1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n7vuOI2gvI49p7Knz6FsmTjaz68/k6d7QHRrqp4avsg=;
        b=pTwccqNB53rdZ+oFVHqX+C6sLPc8LaPZ035ezjnl3GB30u/9PNwExnfFXAxOp/pytF
         1S/75YYPXGGIP0veDd7vs4MYcmHS09qcoLSvIyJqPwSFw5XhUfKQyvi5CXWjVAKMft6h
         E1q21V/kEry+XXzL/nkdQtS7wg5NrgupDi0mavD/dSBDbE3JWadQrsqRlw7P9Hx1a3cc
         9e1Zm0/xgZkd6GVxS4UmW48pCEx9f66+ZvRkq2MSGiyi9zFx/TjDHoBw0jFDWXflVVgc
         TS5Dh1uqgTCEhVnAy/t12evdMnjtRFeAsUTcX09gzNT5RASBzcunb75HyD2JA1i28hnS
         mHRg==
X-Gm-Message-State: AOAM530YhU7vZNIC00hXsDWC7KIzzWgF8Md2LhzshrP21sv/dBQ4lf6c
        iyjNdzFZtUHOpfL/0WGLcVdyXQ==
X-Google-Smtp-Source: ABdhPJy+0G/WaLa8SVXq0pePj6uwFcq1vF/ooSxRZDW0lw+XQiG7jrPGD4+Wwy7cfZNKCkE6vDDFLw==
X-Received: by 2002:aed:2352:: with SMTP id i18mr2955197qtc.167.1597424050788;
        Fri, 14 Aug 2020 09:54:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i75sm9411556qke.70.2020.08.14.09.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:54:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k6cy0-006kpq-Tn; Fri, 14 Aug 2020 13:54:08 -0300
Date:   Fri, 14 Aug 2020 13:54:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-rc] RDMA/usnic: Fix reported max_pkeys attribute
Message-ID: <20200814165408.GU24045@ziepe.ca>
References: <20200805210051.800859-1-kamalheib1@gmail.com>
 <20200805221742.GS24045@ziepe.ca>
 <20200810201918.GA443976@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810201918.GA443976@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 10, 2020 at 11:19:18PM +0300, Kamal Heib wrote:
> On Wed, Aug 05, 2020 at 07:17:42PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 06, 2020 at 12:00:51AM +0300, Kamal Heib wrote:
> > > Make sure to report the right max_pkeys attribute value to indicate the
> > > maximum number of partitions supported by the usnic device.
> > 
> > Why does usnic support pkeys? This needs more explanation
> > 
> > Jason
> 
> Looks like the usnic provider is acting like the RoCE providers by returning
> the default pkey when calling the query_pkey() callback, Do you think that
> this needs to removed like what was done for iWarp providers?
> 
> int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
>                                 u16 *pkey)
> {
>         if (index > 0)
>                 return -EINVAL;
> 
>         *pkey = 0xffff;
>         return 0;
> }

You'd have to check the libfabric provider to see if it cares or not

Jason
