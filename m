Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF286B8B39
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 07:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCNGbZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCNGbY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 02:31:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253677CB2;
        Mon, 13 Mar 2023 23:31:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so26555531edb.6;
        Mon, 13 Mar 2023 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678775479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xTq4lvuz2qZbB1vK9E4pEBW7e9DGFhtNeu5TEdnEqQ=;
        b=XIS9JUx1FrSTES5pG/kvT44ZW9ZxjnDVEyyqo+34tIXKOzgbiTvNRQLHh7wfaIeSzA
         PpwSnjBH29B2qfJySEkqeVtKFCKJ7xDHIg1L9fLIlKFtg9Yu5KW9sqli0v1MBwL5wd7o
         1nohODjLJA1aj3RNcRWpbXyjDElG+TXPx0Qp21luqGoofq52SHGMxoGn7Pqja12fteeu
         lZbf1YiGDcokLV+XuTYLaYq3Y+ykrOTl6jbmkxLinrWjCru70U2bF/hFZWJChcw8Lcvb
         ffrkX9sliFobbA8yUpL8rcRq7quqVzKJWN9DnRV/QL3mkF30uOhxq0Eo228IdlIjB7Z1
         xt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678775479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xTq4lvuz2qZbB1vK9E4pEBW7e9DGFhtNeu5TEdnEqQ=;
        b=2IRoLhDb6fPFoKXXrh6vNS6IkZuiLp2pmVyZN85NzQx6dfrHzXQ/AUAaowwgMkC/Vi
         b/ltDDnRIaxLji1rQ+QA0VeBAleOfHOaI+B6ha399CGyD92gVqFyRDLZOMsuYDUBG9qJ
         X+ZPfn1W3koM1duCdj9vMaLG6d8hLPpWCyqlV6UtTyiUD+IdpLs6qoNQTOmKksxvoKSH
         /iJ2VbeX7PD5DbQHmWxWPKSeKDWRB5/szociVIwXoiU1lmm6EQGsid+hVcJxuU2J7RbI
         OzrU439KPHjtkKX5rFt9i+oCz5d6bpY9jjmdk16h2/L0uofMYQnDrvi5LTNQlCb9iT2e
         X7Gg==
X-Gm-Message-State: AO0yUKUn/t6ojv18b8VhYLCV8UdxTu/4+qrLulrCQj4WgAlJY+FRpwHm
        7Yu8NQ3TztsNIydfNXGj8G3T9wiAPU1/wRAfCV1KArUQ
X-Google-Smtp-Source: AK7set/N4ilUGmqoufvnzBOuxfgxugOX75gCS8AENM5VKSz+FKKM8xhhrZ0EwJVf/kg0U7D2HmGm8Ikfr2BiMLy7lBE=
X-Received: by 2002:a17:906:fca9:b0:8d7:edbc:a7b6 with SMTP id
 qw9-20020a170906fca900b008d7edbca7b6mr699978ejb.2.1678775479433; Mon, 13 Mar
 2023 23:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230201150815.409582-8-urezki@gmail.com>
 <ZAnjnRC1wY3RIFhM@pc636> <ZAnpdKV/VvvX0TZz@pc636>
In-Reply-To: <ZAnpdKV/VvvX0TZz@pc636>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 14 Mar 2023 14:31:07 +0800
Message-ID: <CAD=hENe41q+pg0NJPhCKCSK8OJkypE5KQcthNgYZaCeurqC0pw@mail.gmail.com>
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to kfree_rcu_mightsleep()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 9, 2023 at 10:13=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> > On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote=
:
> > > The kfree_rcu()'s single argument name is deprecated therefore
> > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > underline that it is for sleepable contexts.
> > >
> > > Please check the RXE driver in a way that a single argument can
> > > be used. Briefly looking at it and rcu_head should be embed to
> > > free an obj over RCU-core. The context might be atomic.
> > >
> > > Cc: Bob Pearson <rpearsonhpe@gmail.com>
> > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > Could you please add you reviwed-by or Acked-by tags so we can bring
> > our series with renaming for the next merge window?
> >
> > Thanks!
> >
> __rxe_cleanup() can be called in two contexts, sleepable and not.
> Therefore usage of a single argument of the kvfree_rcu() is not correct
> here.
>
> Could you please fix and check your driver? If my above statement
> is not correct, please provide Acked-by or Reviwed-by tags to the
> path that is in question.
>
> Otherwise please add an rcu_head in your data to free objects over
> kvfree_rcu() using double argument API.
>
> Could you please support?
>
> --
> Uladzislau Rezki
