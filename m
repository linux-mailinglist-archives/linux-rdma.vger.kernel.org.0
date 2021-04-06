Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAC354F61
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhDFJFD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 05:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhDFJFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 05:05:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12247C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 02:04:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o19so15624945edc.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUgMW5th05dSCUvLlZ8NiEhwtnEiTxyz0x0dwJX6XiM=;
        b=RxGP9o+Rc3zPyH9fJrjDbw7QBwtiCxt3ISQ45diRCn7DzdbOWeG5WsixH0UdB9iq3g
         ENrlT8g2wmAETNV4rKtYIs7JQkcZvAI3+Du4ak2xSdNLK8u4fUGdIAx+EmD6P9lyPu6t
         XkUpXRDk0XpP/WW+oP0O0e6HLobnOpvY9H3Yfu6BqR4w9dp1qzJja9VwRnDx8Eh7O+Z+
         Q4tvOfF54NaWtCsGO77yI5sJ2Jx8WbzR6TdruNajAPztvSsgZr553zLGy3k9X3tmT1/r
         1Q/4AAZ+/SYVu65rrShB/+M7jgwBQLWs0oXO9o6R2zNGHHafh2HPcySiSkMviThU7VT2
         Un1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUgMW5th05dSCUvLlZ8NiEhwtnEiTxyz0x0dwJX6XiM=;
        b=Dll8GOtZdGGznOkIAT2BMVIhr5xnDWHq1q5SuKOtfNHtjix35dh8GW6503rcwhQOw+
         uuSSQ/X0D+hhzrwRA2AzW7YMknOBnSOZH7iUtEx8IyAer0GsC4UB9KubVbgrXm0y4ohj
         Zh7zuN7ZFr7z2/KvRcAG9F75reHo3yfAYMUmexE/xc8ZWk+CLH+DPBsNVVfvf2ZO8E74
         Pw5C2kL26vlfLMuf1LzE3NLGxWWva6OAQEx2NcOe8LNPXU9sf5mX9pNvjlSQRamqkQwS
         6lMlMTb562r6ZQnQn5GNUzJ78EkJ9OjRVcz2ovSvJO0asjwRl7w4R0T/Gyygfekf04jg
         hCEg==
X-Gm-Message-State: AOAM531PJE/AyDqNt0+zzvIktBdHMf1WfitngUjciFHXukvrFneUb3ca
        FOuiwwvvV83yZM/fpHuAzu4UNvBGajznA7Y6L3Hp8fprc5BN8A==
X-Google-Smtp-Source: ABdhPJyzDfTMhrRP4mnN4Pja6bRadmF/Z2eiluh9234NwhGF6JCQyx6cTOoV/kBUoYT/RM0N7w7+/omkm0dPKxC1p/8=
X-Received: by 2002:a05:6402:42d3:: with SMTP id i19mr36553214edc.220.1617699894858;
 Tue, 06 Apr 2021 02:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210401190413.GA1652301@nvidia.com>
In-Reply-To: <20210401190413.GA1652301@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 11:04:19 +0200
Message-ID: <CAJX1Ytb=XYKGeYuEN-2tPv9hx3G+=wnGWMzPk893J__JJFyhGQ@mail.gmail.com>
Subject: Re: [PATCH for-next 00/22] Misc update for rtrs
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 1, 2021 at 9:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 04:32:46PM +0100, Gioh Kim wrote:
> > Hi Jason, hi Doug,
> >
> > Please consider to include following changes to the next merge window.
> >
> > It contains a few bugfix and cleanup:
> > - Change maintainer
> > - Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
> > - Add some fault-injection points and document update
> > - New policy for path finding: min-latency and document update
> > - Code refactoring to remove unused code and better error message
>
> >   RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt
> >     session files
>
> This one is for RC, and you need to add Ffixes lines when you fix
> things, I put it there.

Got it. Thank you.

>
> >   MAINTAINERS: Change maintainer for rtrs module
>
> >   RDMA/rtrs: Enable the fault-injection
> >   RDMA/rtrs-clt: Inject a fault at request processing
> >   RDMA/rtrs-srv: Inject a fault at heart-beat sending
> >   docs: fault-injection: Add fault-injection manual of RTRS
>
> These should be a series
Ok, I will split it and send another patch set.


>
> >   RDMA/rtrs-clt: Remove redundant code from rtrs_clt_read_req
> >   RDMA/rtrs: Kill the put label in
> >     rtrs_srv_create_once_sysfs_root_folders
> >   RDMA/rtrs: Remove sessname and sess_kobj from rtrs_attrs
> >   RDMA/rtrs: Cleanup the code in rtrs_srv_rdma_cm_handler
> >   RDMA/rtrs: New function converting rtrs_addr to string
> >   RDMA/rtrs-srv: Report temporary sessname for error message
> >   RDMA/rtrs: cleanup unused variable
> >   RDMA/rtrs-clt: Cap max_io_size
>
> I applied these trivial patches to for-next. Please pay attention to commit
> messages, these are becoming hard to understand.

Got it. Thank you.

>
> >   RDMA/rtrs-srv: More debugging info when fail to send reply
> >   RDMA/rtrs-clt: Print more info when an error happens
> >   RDMA/rtrs-clt: Simplify error message
>
> This is a reasonble series about improving debugging

Ok, I will send a separate patch set.

>
> >   RDMA/rtrs-clt: Add a minimum latency multipath policy
> >   RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
> >   Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
>
> This is a series

This also will be sent as a separate set.

In summary, I will send 3 patch-sets: fault-injection, improbe
debugging, min-latency policy.
Thank you.
