Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2288C397262
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFALdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 07:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232569AbhFALdr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 07:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622547126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVF2rRkOLBbHlaUSVonRAvpKUBOr6lcj+10wWtliGX4=;
        b=R6J+TxmMhtn8I/5jwGrqJkbklnXeVPxLnsFHNCQU/2o5ziQexdZ+SdUo94KUrwxOTdqPD/
        +Ar/7oabZkzDAYbx163iCt/8sYCI907ChzJNONt7s01zYf4CPKUrr232xi7sSiB9NzrqIO
        cLo54uVUj2Eo516+YF+wUCk+IvvS0H0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-IK1B7x6qNcqde7-P1PFf3A-1; Tue, 01 Jun 2021 07:32:04 -0400
X-MC-Unique: IK1B7x6qNcqde7-P1PFf3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5FB10060EB;
        Tue,  1 Jun 2021 11:32:03 +0000 (UTC)
Received: from work-vm (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF07D6A047;
        Tue,  1 Jun 2021 11:32:02 +0000 (UTC)
Date:   Tue, 1 Jun 2021 12:32:00 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, lizhijian@fujitsu.com
Subject: Re: rdma_get_cm_event error behaviour defined?
Message-ID: <YLYasCUuuNMpag2M@work-vm>
References: <YKJAKy1oNcTd7sRn@work-vm>
 <YLYXBD9jupPOslnR@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLYXBD9jupPOslnR@unreal>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

* Leon Romanovsky (leon@kernel.org) wrote:
> On Mon, May 17, 2021 at 11:06:35AM +0100, Dr. David Alan Gilbert wrote:
> > Hi,
> >   Is 'rdma_get_cm_event's behaviour in initialising **event
> > defined in the error case?
> >   We don't see anything in the manual page, my reading of the
> > code is it's not set/changed in the case of failure - but is
> > that defined?
> >   It would be good if the manpage could explicitly state it.
> 
> AFAIK, the general practice do not rely on any output argument if
> function returns an error and I'm not sure that the man update is
> needed.

The case we had was whether we needed to clean up or not in the error
case; the original code in qemu was:

    2496     ret = rdma_get_cm_event(rdma->channel, &cm_event);
    2497     if (ret) {
    2498         perror("rdma_get_cm_event after rdma_connect");
    2499         ERROR(errp, "connecting to destination!");
    2500         rdma_ack_cm_event(cm_event);
    2501         goto err_rdma_source_connect;
    2502     }

and Li spotted that rdma_ack_cm_event  would seg in the case
rdma_get_cm_event failed.

While I agree on not relying on an output; without a definition you're
stuck between not knowing if you're leaking an event that should
have been cleaned up.

Dave

> Thanks
> 
> > 
> > Dave
> > -- 
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

