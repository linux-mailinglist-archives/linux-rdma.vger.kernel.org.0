Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF6BE7D3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 23:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfIYVpY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 17:45:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37567 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfIYVpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 17:45:24 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so917118iob.4
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YnAd2hbbiFfZjlnLspPAcJzKkr4SBt0pt5/+PtSi2k=;
        b=M4/nOM1IUWTN3v5+IXgTZCwwgI2FVgKFld63loo0EKcCSofpeNYK1R2h2Io/6iZ2Ix
         LlW5PakuA8a1J6/ECVvC79/O3rFr3/0RVRVXuSwJd6sQMBHXYm6nMLnIq175gL0+UY3+
         PtX9CqQkwNl3gCL+Sh9uSJBXrYA6mA7GSdyQgMUa0kcnueWbsrLftlzlrDbXp2kxJude
         I4Gf7smuxxaRN71Y+xJ655Z2EGE1hZQfpieWF08qbKzAvNYutwAUlbNbRkX9OPMKBMFp
         gyfVrDXbEUlIjs2qYquV0z6H/Jqvtou+diAHQq/F8V0CsUS126nXE/UpqbGzdjhs8Tmp
         dzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YnAd2hbbiFfZjlnLspPAcJzKkr4SBt0pt5/+PtSi2k=;
        b=nM/dO4F56oNAl72GC45vTUR8QrU/AT52g5HWXRDc43gMcvGqYsp6Zz3L6yuU8PBKny
         oc17bi7K+nbfUGEo6Yl9JqYWUg3wdHua2ifXAgwySQjbn5jD3VXxBjQRYjpYqHFI5Lo9
         myVdaj4uHxMQb4gz9QXbsO/D1p42K1hlUXwPKPYdumd68YAIok/EjyV5Lvs+V3AwS1Cj
         GnaTSvwdU/vMBKDWJ1/9H0kmVzsnX/ZWfZpRbZh3hJNnV2IuFuyGima/CtIKAAw7eXTa
         csx7cUr70/dMbuX9+0Tl9u/i64sdS0n4wi7Q1IWNwLG4SblR5hG3yWpaQpFdI34WrC0j
         ryzw==
X-Gm-Message-State: APjAAAUIelg6w0bwApiShxqnpMeWzfXTo+LVDOpnGUVCeo1PVGogymhs
        YAo8pCvbznaoQbxAnqOvm5Qq9T+1V9NvCsIsFg5y
X-Google-Smtp-Source: APXvYqw0ccNZEIROG3IIPrGUzl41LerraXkXkCrPR3thgpwx37Mo5BDqkV9OSQLDDVYNCL1+UIEgoxwJN2dLstSC5Dc=
X-Received: by 2002:a92:1508:: with SMTP id v8mr1872894ilk.116.1569447923241;
 Wed, 25 Sep 2019 14:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-4-jinpuwang@gmail.com>
 <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
In-Reply-To: <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 23:45:12 +0200
Message-ID: <CAHg0HuzsMK1Rg4mpFv2GwOnmsicR843qDMX+LKWDDn4-kV-eew@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] ibtrs: private headers with IBTRS protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 12:50 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#define P1 )
> > +#define P2 ))
> > +#define P3 )))
> > +#define P4 ))))
> > +#define P(N) P ## N
> > +
> > +#define CAT(a, ...) PRIMITIVE_CAT(a, __VA_ARGS__)
> > +#define PRIMITIVE_CAT(a, ...) a ## __VA_ARGS__
> > +
> > +#define LIST(...)                                            \
> > +     __VA_ARGS__,                                            \
> > +     ({ unknown_type(); NULL; })                             \
> > +     CAT(P, COUNT_ARGS(__VA_ARGS__))                         \
> > +
> > +#define EMPTY()
> > +#define DEFER(id) id EMPTY()
> > +
> > +#define _CASE(obj, type, member)                             \
> > +     __builtin_choose_expr(                                  \
> > +     __builtin_types_compatible_p(                           \
> > +             typeof(obj), type),                             \
> > +             ((type)obj)->member
> > +#define CASE(o, t, m) DEFER(_CASE)(o, t, m)
> > +
> > +/*
> > + * Below we define retrieving of sessname from common IBTRS types.
> > + * Client or server related types have to be defined by special
> > + * TYPES_TO_SESSNAME macro.
> > + */
> > +
> > +void unknown_type(void);
> > +
> > +#ifndef TYPES_TO_SESSNAME
> > +#define TYPES_TO_SESSNAME(...) ({ unknown_type(); NULL; })
> > +#endif
> > +
> > +#define ibtrs_prefix(obj)                                    \
> > +     _CASE(obj, struct ibtrs_con *,  sess->sessname),        \
> > +     _CASE(obj, struct ibtrs_sess *, sessname),              \
> > +     TYPES_TO_SESSNAME(obj)                                  \
> > +     ))
>
> No preprocessor voodoo please. Please remove all of the above and modify
> the logging statements such that these pass the proper name string as
> first argument to logging macros.

Hi Bart,

do you think it would make sense we first submit a new patchset for
IBTRS (with the changes you suggested plus closed security problem)
and later submit a separate one for IBNBD only?

Thank you,
Danil
