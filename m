Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFD18BD06
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 17:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCSQtE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 12:49:04 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38716 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgCSQtE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 12:49:04 -0400
Received: by mail-ed1-f45.google.com with SMTP id h5so3543250edn.5
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdzFHOmYospsL/7Qp0KUB/LlvyPOMe1//9ss/cmtGhc=;
        b=IJTvFH2tBpSqKTEjLikAskiHRhVKllpCAdMG2f+5N6OQTmx+fkQGCLHFu0EjHI+A0L
         5lYStjygwYoViSo0Nze0IJkBVNI1NLJSO2TPpycqvzp6SqLBYkYNIMBJufpJVIr+pxSk
         KPPXmV4OwrTIPP19YOdCArd9aa8DuE038q6fGMHNS6afw3pNF0ltizwSAkH9KvnBCTK5
         aMJB2iXSyjdeaq18FfSf1S7vBQapivIQ3Yi33qcP32/Nm0tm/C4JdSkhfhwx7Q8d0Q7b
         //EZEKbrebUId9KLk6n9ZwlPzrHn00Z22Bnm4SCJyJJOJadFuv8RwV6JVJSgDYQmS+Sn
         fZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdzFHOmYospsL/7Qp0KUB/LlvyPOMe1//9ss/cmtGhc=;
        b=fwVELxEuibKyOzgavJkDAoe+hLoGKXAwi9kohDDMN2XC+rBD7VfvNQJ8q3NPIDLJZr
         mpZgcCBUWJr+Q3Wc6Utw/oZK7qmPkFdkQVM1NSbuY4EMUaJ8nS3pvXbNCWtBIBq1c9+R
         ZmlPgk7WGEQKd3Zb4x51KzpiRm/SVB/XNLCDz4s7jbjbbyJ0JJ6On2fStoi1Jw3gnYbB
         t/5X92lbjpZQ3Yzl1ZAv33GWVQBxq13muwNkr/RfJoYCjbQ5qhKdzmY6PIRlxJSwaY4U
         Btf7kc/aAV6mhqI3aTtGqug5tKMCPAPOTS5cgviDB00S0DLOVUKSConTRZMB4uQyMbSe
         1ECA==
X-Gm-Message-State: ANhLgQ2BgEKf1VbiUEtAm59+0Htp+glQ95gAHLj/lXsw9ESRDUyQJdjH
        26hToxG1G0XqahuDB6U/S1SGDR1HZ6a2iDJ3cAiisC1x
X-Google-Smtp-Source: ADFU+vujy51bYA6wL1kw8cW0p6EvREin9Sa44fRQjRaFIxJ1SjrJWskIACoaUwcrVE1eWSggyK8laqYRZ2CPhgD1sKk=
X-Received: by 2002:aa7:cb0b:: with SMTP id s11mr3680398edt.165.1584636540830;
 Thu, 19 Mar 2020 09:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOc41xGSL3bYs5s9AO-3hfEwLjOy4PEdpbN8xBYMpk5j4cLQSQ@mail.gmail.com>
 <20200319135218.GJ20941@ziepe.ca>
In-Reply-To: <20200319135218.GJ20941@ziepe.ca>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Thu, 19 Mar 2020 09:48:48 -0700
Message-ID: <CAOc41xFeKKcyD2iE4Tpax+GJF+VO5aN_cN5yfjnGnzLVnWNqZw@mail.gmail.com>
Subject: Re: UDP with IB verbs lib
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

That's pretty clear. Thank you.

Dimitris

On Thu, Mar 19, 2020 at 6:52 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Mar 18, 2020 at 04:07:37PM -0700, Dimitris Dimitropoulos wrote:
> > Hi,
> >
> > I'm looking at UDP using the IB verbs library. If I send UDP packets
> > that are intercepted by the IB verbs layer, what happens with the
> > completion notifications ?
>
> Each recv that requests a completion gets a completion.
>
> > For example, say I create a list of 10 ibv_recv_wr objects and each
> > has num_sge = 30, with each SGE having a 4K size. And I setup for
> > reception with ibv_post_recv(). If I transmit 30 UDP packets each 4K
> > in size will I receive one CQ event ? Or 30 ?
>
> One per ibv_recv_wr requesting completion
>
> > Will the UDP packets be written in consecutive SGEs of the first
> > ibv_recv_wr object ? Or will they be written in consecutive
> > ibv_recv_wr objects (in their first SGE) ?
>
> Only the first. Each recv handles a single incoming packet.
>
> DPDK has a hyper-optimized version of processing IP/UDP packets via
> mlx5dv
>
> Jason
