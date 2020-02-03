Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9ACA150DC3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 17:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgBCQqp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 11:46:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45123 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgBCQ2Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 11:28:16 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so17342998ioi.12
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdjGHtQzlWP+DTAXmAqFhz+srwWJT76fHmGH1ifovrs=;
        b=LUKyl0aA/JacciQNqwmUB9QfHZHm7K2iufiNgo+XjgTFexj89eCipCPrbh2bdufNgD
         KyUiUc4WKCfVEGwbkMrPbzwETlPFzqFREp805QD3fnbozmXkgc9Mv+I5nzgdTl5vAAaK
         VIc6q6kQFcG/ikYmSPEuL1aVcn1zgccYt91CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdjGHtQzlWP+DTAXmAqFhz+srwWJT76fHmGH1ifovrs=;
        b=bZI3yxF4Qpuj5DnxfZVNHbQ+ugYV9qa+v9k+IAxigzGPMPyRYz5U2JEJmXi37Gip1B
         lhemhF72DNedKlzg4zUgmx/Zg5dlh6E+cIwyLTOQd2h4bsjVzHtyGJOYArG/n7SrnUvL
         +KDPC4i2LE0CCpdKQi2QeJDPdo9CZn1Pf7MzORRkfJSzRYAFbVFRvAfxwi74UNVViLh0
         GWjWb1C6oInhtf8QgngjTwWeSts9k/o2Ic+hO7esoGKChUgnTPS9DearTFMjfuCzS/m2
         GfFhi7xFk5/y2ECZWL2fzNgVaZji3Tsqe/poBm0Jt44HDPVgnq4Zh4vXrk0xlMwM5P+y
         Va9A==
X-Gm-Message-State: APjAAAUIfLZ8cyjGW5+xx7qnzP06FqvbWfGswm4G5LSW6lbc0focMNKB
        q+K0bBTCWNCl3R/N+s8Id8UgsjcSoIJMs/QiVDEJCw==
X-Google-Smtp-Source: APXvYqzAxz2hlpZXt7FF1Ejq1Dh01nnX8+cUIQJXgu4r0HCWBtmgTj2b5M3+CZC2E2IQ5SFIjNloDL6TSne6KVWyEqA=
X-Received: by 2002:a6b:6604:: with SMTP id a4mr20236175ioc.300.1580747296102;
 Mon, 03 Feb 2020 08:28:16 -0800 (PST)
MIME-Version: 1.0
References: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com> <20200203160849.GA14732@ziepe.ca>
In-Reply-To: <20200203160849.GA14732@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 21:57:39 +0530
Message-ID: <CANjDDBiA53__MuzqXiAh70YAa_JvWQcm6Sdo0dFsoAs1EgVbjQ@mail.gmail.com>
Subject: Re: [PATCH v4] libibverbs: display gid type in ibv_devinfo
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 9:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Feb 03, 2020 at 10:56:55AM -0500, Devesh Sharma wrote:
> > It becomes difficult to make out from the output of ibv_devinfo
> > if a particular gid index is RoCE v2 or not.
> >
> > Adding a string to the output of ibv_devinfo -v to display the
> > gid type at the end of gid.
> >
> > The output would look something like below:
> > $ ibv_devinfo -v -d bnxt_re2
> > hca_id: bnxt_re2
> >  transport:             InfiniBand (0)
> >  fw_ver:                216.0.220.0
> >  node_guid:             b226:28ff:fed3:b0f0
> >  sys_image_guid:        b226:28ff:fed3:b0f0
> >   .
> >   .
> >   .
> >   .
> >        phys_state:      LINK_UP (5)
> >        GID[  0]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> >        GID[  1]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> >        GID[  2]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> >        GID[  3]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
>
> I think you should display the RoCEv2 GID in IPv6 notation, since it
> isn't really a GID anyhmore. The IPv6 notation should automatically
> show the IPv4 dotted quad

There are many format specifiers, which one are you indicating? are
those supported in printf()?
>
> Jason
