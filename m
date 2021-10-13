Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C368B42C8C9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJMSiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 14:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhJMSiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 14:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634150165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtTjvZoybaHgq8qFKTcrnsgPksKO58vSEK+1x14wmrI=;
        b=SxyhBFTGBL3yDXiQJ8iqpPIKWFmjaRenh6xi67gfIxVVNs31guIj+Q4onSVBYYo8gWnKSk
        bO6lKh2sTP8u3xHIN1ITUkq8sVmoF3D/IFo6FUepWGXzdvha6pUPc7Yo71tKqEgfzda6fX
        qD1LKGg87TwDK6Y6rgde9j0t/zCmKkI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-OdPXh_X0MUmFqsS7HmAPXQ-1; Wed, 13 Oct 2021 14:36:01 -0400
X-MC-Unique: OdPXh_X0MUmFqsS7HmAPXQ-1
Received: by mail-ed1-f70.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so3057596edb.8
        for <linux-rdma@vger.kernel.org>; Wed, 13 Oct 2021 11:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtTjvZoybaHgq8qFKTcrnsgPksKO58vSEK+1x14wmrI=;
        b=bMbX67CW7mSFFM2DN14z40BrMvELpy5v5xQUArF2kwmG1ftQMhBfXk1xXJi25feEEn
         izjsvqZVZDvVtfG0Fjx/I61OPwLqOLnqTOEKP03ng1ojySu2a4ao6GMiH45ppCTNl980
         4RbZ0Oqi4sCzcL4yjMJrSzAr9htZiWTLCuNH7CsxthiUvVyfIesDAKQ8WUWSofUoi0xe
         by7G2p4sBsLPb0N+VsZxY7ueHf4m13pRVdmcQLUO8bSwR7uho2OfppUx02XHha636F56
         FrofJNlWQRM5niaCMnX2awq5v+MhjY99Bf0HX6/wbYzI+RH9EdIh0iDzgP0TLjmEouaO
         LEkQ==
X-Gm-Message-State: AOAM531y02OwIMXEYWV9fil/Ouqk+GiNewtVw24XsgpiIwOtAhbgwqaa
        97t+wmJYDfX6F1zabED/aua4uE2Xw6Q/ipa3EJdYyxQCqPR9Mhaxri4OzaeBxsjHCDcEQ8iQb6G
        Tz/DQA/7aNRm+xQ/pq8Rfrm+0Cn+dkha+YV+LfQ==
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr1038526eju.258.1634150160101;
        Wed, 13 Oct 2021 11:36:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnDhKMa3t7i6NIZhd7vYEneTinsYFJIBJ4KxH12GcspVBkjCrcz5UhxDiSbFTjVaxKOXlTdQ1AVgH4onlbA60=
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr1038501eju.258.1634150159819;
 Wed, 13 Oct 2021 11:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
 <20211013155926.GC6260@fieldses.org> <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
In-Reply-To: <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 13 Oct 2021 14:35:23 -0400
Message-ID: <CALF+zOmXc+bidhaOMtUE_SOh+brGPuoScPU3E6KYc6tV52EMXg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Deprecate dprintk in svcrdma
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 12:50 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 13, 2021, at 11:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Oct 13, 2021 at 10:46:49AM -0400, Chuck Lever wrote:
> >> This patch series moves forward with the removal of dprintk in
> >> SUNRPC in favor of tracepoints. This is the last step for the
> >> svcrdma component.
> >
> > Makes sense to me.
> >
> > I would like some (very short) documentation, somewhere.  Partly just
> > for my sake!  I'm not sure exactly what to recommend to bug reporters.
> >
> > I guess
> >
> >       trace-cmd record -e 'sunrpc:*'
> >       trace-cmd report
> >
> > would be a rough substitute for "rpcdebug -m rpc -s all"?
>
> It would, but tracepoints can be enabled one event
> at a time. If you're looking for a direct replacement
> for a specific rpcdebug invocation, it might be better
> to examine the current sunrpc debug facilities and
> provide specific command lines to mimic those.
>
> "rpcdebug -vh" gives us:
>
> rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc cache all
> nfs        vfs dircache lookupcache pagecache proc xdr file root callback client mount fscache pnfs pnfs_ld state all
> nfsd       sock fh export svc proc fileop auth repcache xdr lockd all
> nlm        svc client clntlock svclock monitor clntsubs svcsubs hostcache xdr all
>
>
> If tracepoints are named carefully, we can provide
> specific command lines to enable them as groups. So,
> for instance, I was thinking rpcdebug might display:
>
>         trace-cmd list | grep svcrdma
>
> to list tracepoints related to server side RDMA, or:
>
>         trace-cmd list | grep svcsock
>
> to show tracepoints related to server side sockets.
> Then:
>
>         trace-cmd record -e sunrpc:svcsock\*
>
> enables just the socket-related trace events, which
> coincidentally happens to line up with:
>
>         rpcdebug -m rpc -s svcsock
>
>
> > Do we have a couple examples of issues that could be diagnosed with
> > tracepoints?
>
> Anything you can do with dprintk you can do with trace
> points. Plus because tracepoints are lower overhead, they
> can be enabled and used in production environments,
> unlike dprintk.
>
> Also, tracepoints can trigger specific user space actions
> when they fire. You could for example set up a tracepoint
> in the RPC client that fires when a retransmit timeout
> occurs, and it could trigger a script to start tcpdump.
>
>
> > In the past I don't feel like I've ended up using dprintks
> > all that much; somehow they're not usually where I need them.  But maybe
> > that's just me.  And maybe as we put more thought into where tracepoints
> > should be, they'll get more useful.
>
> > Documentation/filesystems/nfs/, or the linux-nfs wiki, could be easy
> > places to put it.  Though *something* in the man pages would be nice.
> > At a minimum, a warning in rpcdebug(8) that we're gradually phasing out
> > dprintks.
>
> As I understood the conversation last week, SteveD and
> DaveW volunteered to be responsible for changes to
> rpcdebug?
>

Well I don't remember it exactly like that, but it's probably close.

I made a suggestion for the last kernel patch that deprecates any
rpcdebug facility, to leave one dfprintk in, stating there is no
information in the kernel anymore for this facility, so not to expect
this rpcdebug flag to produce any meaningful debug output, and
possibly redirect to ftrace facilities.  I brought that idea up
because of my fscache patches which totally removed the last dfprintk
in NFS fscache, and I wasn't sure what the deprecation procedure
was.  As I recall you didn't like that idea as it was never done before
with other rpcdebug flag deprecations, and it was shot down.

I suppose we could put the same type of userspace patch to rpcdebug
that looks for kernel versions and prints a message if someone tries
to use a deprecated flag?  Would that be better?


> So far we haven't had much documentation for dprintk. That
> means we are starting more or less from scratch for
> explaining observability in the NFS stacks. Free rein, and
> all that.
>
> --
> Chuck Lever
>
>
>

