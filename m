Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2647B319F6C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBLNFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231845AbhBLNEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 08:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613134963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgT2l5Gg/0MlSCIuaxmswGdsvsMJlD6iZHpEEi3D13E=;
        b=XKzNesYPNNALHE6s5YXmu8UfVWTVvfx1VUoWB2AvKlQ3gze2/DS1k9/QwhtmIDro2kGoYl
        Edt62xi6t/c/U6T6Wetc85O8cdr3K5FxNExxWwPe6nRDwXCLP6J6gpYrSGOMvVxvp0cifp
        RJY853wUHMWep7cLZLRc0Hzp+gAQJiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-9UCnkKlVMY210GelVQXRUg-1; Fri, 12 Feb 2021 08:02:39 -0500
X-MC-Unique: 9UCnkKlVMY210GelVQXRUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1341107ACE4;
        Fri, 12 Feb 2021 13:02:38 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 712AD1A86C;
        Fri, 12 Feb 2021 13:02:38 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Bernard Metzler" <BMT@zurich.ibm.com>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: directing soft iWARP traffic through a secure tunnel
Date:   Fri, 12 Feb 2021 08:02:37 -0500
Message-ID: <73A7370E-1709-43C8-929D-AFD1478CFA12@redhat.com>
In-Reply-To: <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
References: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12 Feb 2021, at 7:37, Bernard Metzler wrote:

> -----"Chuck Lever" <chuck.lever@oracle.com> wrote: -----
>
>> To: "linux-rdma" <linux-rdma@vger.kernel.org>
>> From: "Chuck Lever" <chuck.lever@oracle.com>
>> Date: 02/11/2021 08:38PM
>> Cc: "Benjamin Coddington" <bcodding@redhat.com>
>> Subject: [EXTERNAL] directing soft iWARP traffic through a secure
>> tunnel
>>
>> Hi-
>>
>> This might sound crazy, but bear with me.
>>
>> The NFS community is starting to hold virtual interoperability
>> testing
>> events to replace our in-person events that are not feasible due to
>> pandemic-related travel restrictions. I'm told other communities have
>> started doing the same.
>>
>> The virtual event is being held on a private network that is set up
>> using OpenVPN across a large geographical area. I attach my test
>> systems to the VPN to access test systems run by others at other
>> companies.
>>
>> We'd like to continue to include NFS/RDMA testing at these events.
>> This means either RoCEv2 or iWARP, since obviously we can't create
>> an ad hoc wide-area InfiniBand infrastructure.
>>
>> Because the VPN is operating over long distances, we've decided to
>> start with iWARP. However, we are stumbling when it comes to
>> directing
>> the siw driver's traffic onto the tun0 device:
>>
>> [root@oracle-100 ~]# rdma link add siw0 type siw netdev tun0
>> error: Invalid argument
>> [root@oracle-100 ~]#
>>
>> Has anyone else tried to do this, and what was the approach? Or does
>> siw not yet have this capability?
>>
>
> Hi Chuck
>
> right. Attaching siw is currently restricted to some physical
> device types. This now appears a useless limitation, since
> it prevents its usage in the given setup, where it would
> be just useful...
> Relaxing that limitation is a rather simple code change in siw
> - but that would not help you asap?
>
> In any case I'd be happy to help with a fix, but participants
> would have to rebuild the siw module...probably no option?

We can rebuild it and test it for you.

Ben

