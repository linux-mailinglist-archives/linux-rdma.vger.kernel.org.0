Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16C02584F9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 03:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgIABBD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 21:01:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgIABBD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Aug 2020 21:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598922062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DNe3w68cLRNU0MQeydjwA41xKkN+wuwi6HB2a4Q2zNc=;
        b=MXqZJIDGGSY0c7NsLre0nrXuFSTG8+OsfUOdh8UQVcxdc3hbuSd7SdDU3mH/xd58CxultU
        ZdXCyCmk9sEpJ5aAHB4L0+V6JymxLt39L8/3O6XTIDLZUXvACNUY0aisf7tV3k+dLTUmzr
        +6sgjgh4S0E+mkOV6MWxLLzCsEWMgBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-0Zaq56s3P9q891HiajrgVA-1; Mon, 31 Aug 2020 21:00:59 -0400
X-MC-Unique: 0Zaq56s3P9q891HiajrgVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C902F1888A0D;
        Tue,  1 Sep 2020 01:00:57 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9442E7EB69;
        Tue,  1 Sep 2020 01:00:51 +0000 (UTC)
Date:   Tue, 1 Sep 2020 09:00:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200901010046.GA289251@T590>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 09:48:12AM -0700, Sagi Grimberg wrote:
> 
> > > Currently we allocate rx buffers in a single contiguous buffers
> > > for headers (iser and iscsi) and data trailer. This means
> > > that most likely the data starting offset is aligned to 76
> > > bytes (size of both headers).
> > > 
> > > This worked fine for years, but at some point this broke.
> > > To fix this, we should avoid passing unaligned buffers for
> > > I/O.
> > 
> > That is a bit vauge - what suddenly broke it?
> 
> Somewhere around the multipage bvec work that Ming did. The issue was
> that brd assumed a 512 aligned page vector. IIRC the discussion settled
> that the block layer expects a 512B aligned buffer(s).

I don't think the limit is from multipage bvec, and the limit is
actually from driver since block layer just sets up the vectors which
is passed to driver, see the following discussion:

https://lore.kernel.org/linux-block/20191204230225.GA26189@ming.t460p/

So what is the exact setting for reproducing the issue? Some underlying
driver does require aligned buffer, such as loop/dio, brd, or when kasan
is involved for buffer allocated via kmalloc().


Thanks, 
Ming

