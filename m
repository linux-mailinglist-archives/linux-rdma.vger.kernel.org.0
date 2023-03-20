Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F16C12DC
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCTNOR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCTNOQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 09:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603C5FC3
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679318007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FK5YRtcj8f29ji2gMvRnwxgO/cFkT+p2w1C0G7sHzvw=;
        b=jVIJQxsGuXZtrtxKbWBBwmkPGQ1OUsSBfZazRIX66Yjj+r7+KrVNEUhOg2+r4p62PzTq3w
        Y/tjjfEk7hD0rMzOhU983jk6IW/wjT27gmIfTwEH+byAjyHW7vmOKJ7NOdQERWoBbofvGz
        k+gvluOGThzsYMH4EJkPSu0HBV0LSns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-6bzMeTsoPr-VAAuYUOpr5g-1; Mon, 20 Mar 2023 09:13:24 -0400
X-MC-Unique: 6bzMeTsoPr-VAAuYUOpr5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A8BD855312;
        Mon, 20 Mar 2023 13:13:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCD9E2027061;
        Mon, 20 Mar 2023 13:13:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <SA0PR15MB3919CF7A2996702BEB68E3F799809@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <SA0PR15MB3919CF7A2996702BEB68E3F799809@SA0PR15MB3919.namprd15.prod.outlook.com> <SA0PR15MB3919A01D3E69110345ED0EC799809@SA0PR15MB3919.namprd15.prod.outlook.com> <20230316152618.711970-1-dhowells@redhat.com> <20230316152618.711970-9-dhowells@redhat.com> <1716675.1679310535@warthog.procyon.org.uk>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     dhowells@redhat.com, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1833342.1679318002.1@warthog.procyon.org.uk>
Date:   Mon, 20 Mar 2023 13:13:22 +0000
Message-ID: <1833343.1679318002@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

> > > Back in the days, I introduced that zcopy path for efficiency
> > > reasons - getting both better throughput and less CPU load.
> > > I looked at both WRITE and READ performance. Using
> > > do_tcp_sendpages() is currently limited to processing work
> > > which is not registered with local completion generation.
> > > Replying to a remote READ request is a typical case. Did
> > > you check with READ?
> > 
> > Ah - you're talking about ksmbd there?  I haven't tested the patch with
> > that.
> 
> Did you test with both kernel ULPs and user level applications?

Kernel "ULPs"?

As far as cifs goes, I've tested the fs with large dd commands for the moment,
but that's all.  This post was more to find out how attached people were to
->sendpage() and to see if anyone had any preferences on a couple of things
mentioned in the cover note.  This isn't aimed at the next merge window.

David

