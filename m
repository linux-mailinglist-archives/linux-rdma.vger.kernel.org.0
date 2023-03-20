Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C86C1075
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 12:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTLNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 07:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCTLNG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 07:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6AB77B
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679310538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4iGs6axuSMcApN12bE7HKRzofXrpyZRMZG6wEvG48w=;
        b=XNhf/QlipM2WDSCR96bYfKe3uU7nQDWPnjffUtC9rTCBvulaPUVGI9Ngz5O7x4her/igBA
        vvKQByDkF/xstzPWVAwUXgBZ/H9ZY3WwAudYnfpgaN1UatJQk84ifqvvsgjArz2p1FkzJn
        QTO+mplhw86pmFMntUmPGgdgmi/wCOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-rnVODdt8OryZvj5_SiinMw-1; Mon, 20 Mar 2023 07:08:57 -0400
X-MC-Unique: rnVODdt8OryZvj5_SiinMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 117A0185A7A2;
        Mon, 20 Mar 2023 11:08:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 827A61121315;
        Mon, 20 Mar 2023 11:08:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <SA0PR15MB3919A01D3E69110345ED0EC799809@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <SA0PR15MB3919A01D3E69110345ED0EC799809@SA0PR15MB3919.namprd15.prod.outlook.com> <20230316152618.711970-1-dhowells@redhat.com> <20230316152618.711970-9-dhowells@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     dhowells@redhat.com, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1716674.1679310535.1@warthog.procyon.org.uk>
Date:   Mon, 20 Mar 2023 11:08:55 +0000
Message-ID: <1716675.1679310535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bernard Metzler <BMT@zurich.ibm.com> wrote:

> >  /*
> > - * 0copy TCP transmit interface: Use do_tcp_sendpages.
> > + * 0copy TCP transmit interface: Use MSG_SPLICE_PAGES.
> >   *
> >   * Using sendpage to push page by page appears to be less efficient
> >   * than using sendmsg, even if data are copied.
> 
> That is an interesting observation. Is efficiency to be read as
> CPU load, or throughput on the wire, or both?

Um.  The observation in the comment is one you made, not me according to git
blame.  I merely changed "do_tcp_sendpages" to "MSG_SPLICE_PAGES" in the first
line of the comment.

> Back in the days, I introduced that zcopy path for efficiency
> reasons - getting both better throughput and less CPU load.
> I looked at both WRITE and READ performance. Using
> do_tcp_sendpages() is currently limited to processing work
> which is not registered with local completion generation.
> Replying to a remote READ request is a typical case. Did
> you check with READ?

Ah - you're talking about ksmbd there?  I haven't tested the patch with that.

> > -		rv = do_tcp_sendpages(sk, page[i], offset, bytes, flags);
> > +		rv = tcp_sendmsg_locked(sk, &msg, size);
> 
> Would that tcp_sendmsg_locked() with a msg flagged
> MSG_SPLICE_PAGES still have zero copy semantics?

Yes - though I am considering making it conditional on whether the pages in
the iterator belong to the slab allocator (in which case they get copied) or
not.

David

