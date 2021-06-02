Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B14398A1D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 14:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFBM5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 08:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229579AbhFBM5s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 08:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622638565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68bJSY1FBTPQ80K65CfylStjee9ZQzAVnTo+uSvrYlo=;
        b=h7DqS3kVyNpH5t6f77rMUjoeFNG7qvhKz/pYQmsO6bd5JIVxEdnztfNc6DaDOL+kwd5abM
        ip2MdK+FMluuAncD7GZotTQ1FkqBPP3R7xSe+R02jYzyyijoyvSfIKBByjM7jlkGIY0LZf
        i+PgvkQifb2tqf2PjqohFCuVVJV8ZI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-lTgot2TwMiKPJRVZALBcxw-1; Wed, 02 Jun 2021 08:56:04 -0400
X-MC-Unique: lTgot2TwMiKPJRVZALBcxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F813501E0;
        Wed,  2 Jun 2021 12:56:03 +0000 (UTC)
Received: from work-vm (ovpn-113-195.ams2.redhat.com [10.36.113.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B22760BD9;
        Wed,  2 Jun 2021 12:56:01 +0000 (UTC)
Date:   Wed, 2 Jun 2021 13:55:58 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, lizhijian@fujitsu.com
Subject: Re: rdma_get_cm_event error behaviour defined?
Message-ID: <YLd/3ojhnU0LVIw1@work-vm>
References: <YKJAKy1oNcTd7sRn@work-vm>
 <YLYXBD9jupPOslnR@unreal>
 <YLYasCUuuNMpag2M@work-vm>
 <YLd6o7p6+29Sjdtq@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLd6o7p6+29Sjdtq@unreal>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

* Leon Romanovsky (leon@kernel.org) wrote:
> On Tue, Jun 01, 2021 at 12:32:00PM +0100, Dr. David Alan Gilbert wrote:
> > * Leon Romanovsky (leon@kernel.org) wrote:
> > > On Mon, May 17, 2021 at 11:06:35AM +0100, Dr. David Alan Gilbert wrote:
> > > > Hi,
> > > >   Is 'rdma_get_cm_event's behaviour in initialising **event
> > > > defined in the error case?
> > > >   We don't see anything in the manual page, my reading of the
> > > > code is it's not set/changed in the case of failure - but is
> > > > that defined?
> > > >   It would be good if the manpage could explicitly state it.
> > > 
> > > AFAIK, the general practice do not rely on any output argument if
> > > function returns an error and I'm not sure that the man update is
> > > needed.
> > 
> > The case we had was whether we needed to clean up or not in the error
> > case; the original code in qemu was:
> > 
> >     2496     ret = rdma_get_cm_event(rdma->channel, &cm_event);
> >     2497     if (ret) {
> >     2498         perror("rdma_get_cm_event after rdma_connect");
> >     2499         ERROR(errp, "connecting to destination!");
> >     2500         rdma_ack_cm_event(cm_event);
> >     2501         goto err_rdma_source_connect;
> >     2502     }
> > 
> > and Li spotted that rdma_ack_cm_event  would seg in the case
> > rdma_get_cm_event failed.
> 
> man page says that you should rdma_ack_cm_event() on success only.
> 
>    14 All events which are allocated by rdma_get_cm_event must be released,
>    15 there should be a one-to-one correspondence between successful gets
>    16 and acks.  This call frees the event structure and any memory that it
>    17 references.

Hmm ok; it did fool at least 2 of us; and I ended up going to the code
to check.

> > 
> > While I agree on not relying on an output; without a definition you're
> > stuck between not knowing if you're leaking an event that should
> > have been cleaned up.
> 
> You are not supposed to have rdma_ack_cm_event() in your snippet.

Right, that's what we figured out the hard way.

Dave

> Thanks
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

