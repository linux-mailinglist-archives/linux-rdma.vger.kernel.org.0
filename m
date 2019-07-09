Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48263DE9
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGIWjK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 18:39:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40374 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIWjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 18:39:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so64368pfp.7
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2019 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lStp7wKHf6Ask7O0Oc+ibRyWBiXzjLJTev2OPu1R8k=;
        b=TxK8nEyP+BHCYENCDLzIjf/lr/5HGTOL959SnV2yVYjPi6FK3vVxaRDjiCQKxcqdtG
         0qp7kBgnZ8I7VPmnloKcuPkRmLmfG1xRq3WbpCoM7PpWBpb/S8WfUj+S+AM/qoEUykZj
         PX9TC/sfh3jzPxeLGV7+a3YTZhW4U8iCW7406gtL5tfgz4nU2mzVWq3Lwwjb+mF2XE5m
         h6aKQmPc2+p6DCUXSb54VrZ8LhqZmnRvy2ikPfWioeDllOvDDjwUKNitNLuZVEkIC6/6
         iZntav9Q2GIQHts9q0F07ApQzggmhk82DiQqdT46IzcZcn/qlCrkPficVdKN901fvAep
         yjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lStp7wKHf6Ask7O0Oc+ibRyWBiXzjLJTev2OPu1R8k=;
        b=AUxkQyCLyMVAfQyU61Ew93/+CLm56ik8TXfxYU1GHfwkE26DwXAZRZQms9xw55VA1g
         8/fEBTQ4n1HNMtr7ILhyfSP/SThoR7meY8TdEYJp1drnO6LHSX6+FELQyOJwoaUZ6HRF
         oEGRIM++wrZOOdYnUsktskhF6f15Tt0fOe0ObYuLIlEN3qyKDfoXAnOC2u6mjux3whdy
         irIHtjcSUHrGdunfNWsnQ89iALO98I+yCRn4j2kXv1t2aTROj4rNKMUllG07HYjclu1y
         lZBvQ70A8+i9+2XZlVcFlAS0KovVaLYEptqPP6YOtmzZe6bmRECb31zO01In8Q1UlPVc
         OvhA==
X-Gm-Message-State: APjAAAVtcW4ZhuOjabanDHc9XwJbsiKfG0G9zgDHDX9wq1JatIzf26Qm
        kiV50nDhJyUsIEw4UF2XQ5Y9FtqOE784SQEgEoPpBQ==
X-Google-Smtp-Source: APXvYqzbJ54HGVlXDIVraK2vlpHUMYu/or795QKC6xwteu9BT7bhsM1V6gPio+zzSpd8UHn3zJpAot9ufQCtPpl+tsY=
X-Received: by 2002:a63:52:: with SMTP id 79mr32862431pga.381.1562711948639;
 Tue, 09 Jul 2019 15:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190709221312.7089-1-natechancellor@gmail.com>
In-Reply-To: <20190709221312.7089-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jul 2019 15:38:57 -0700
Message-ID: <CAKwvOdkXwD6Wvyt5tYWJP7f3YePqUe1_TvST2RMNb_tSEc3cEQ@mail.gmail.com>
Subject: Re: [PATCH] IB/rdmavt: Remove err declaration in if statement in rvt_create_cq
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 9, 2019 at 3:13 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used

Oh, !$*@, this is a tricky one.  While the if scoped `err` declared on
L250 is initialized when used at L260, the function scoped `err`
declared on L211 is not initialized when it is used on L310 when
control flow enters the if on L249 then the goto on L255 or L261.  So
this is a bug due to the if scoped `err` "shadowing" the function
scoped `err`.

Maybe not important enough to send a v2, but I feel like the commit
message should say something along the lines of `fix a potential use
of uninitialized memory due to shadowing`.  Either way, this fixes a
real bug, so thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (err)
>                     ^~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:260:3: note: remove the 'if' if its
> condition is always false
>                 if (err)
>                 ^~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:253:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (!cq->ip) {
>                     ^~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:253:3: note: remove the 'if' if its
> condition is always false
>                 if (!cq->ip) {
>                 ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:211:9: note: initialize the variable
> 'err' to silence this warning
>         int err;
>                ^
>                 = 0
> 2 warnings generated.
>
> There are two err declarations in this function: at the top and within
> an if statement; clang warns because the assignments to err in the if
> statement are local to the if statement so err will be used
> uninitialized if this error handling is used. Remove the if statement's
> err declaration so that everything works properly.
>
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/594
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/cq.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
> index fac87b13329d..a85571a4cf57 100644
> --- a/drivers/infiniband/sw/rdmavt/cq.c
> +++ b/drivers/infiniband/sw/rdmavt/cq.c
> @@ -247,8 +247,6 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>          * See rvt_mmap() for details.
>          */
>         if (udata && udata->outlen >= sizeof(__u64)) {
> -               int err;
> -

-- 
Thanks,
~Nick Desaulniers
