Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114412E7F75
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Dec 2020 11:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLaKjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Dec 2020 05:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgLaKjf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Dec 2020 05:39:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A8B22262;
        Thu, 31 Dec 2020 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609411134;
        bh=zeHU8xO0LCbwmg1u5yCJ/EvtTmven+9eWLEIXjfbK80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTdNu0XNK2wdy+gGoW4DKwaEK8IjxH1t7XtMMYn6H6gP4li+Nrmd7cUWaMud0Ck+R
         fpJv175aHyeZhzilutKxkX1tp9VQpxwrKd8/4I4Y3wnAoLf2b/svc46cJyUAc6QYve
         fuc/Rguut9WfITAS0gjg+qy4BIB9q3VrMtvaYClKjUCuJlVTJSIvE/spe9tVDvVIEu
         YKx8wpNTgwUaTA8cWyzZEUKfhTDSahEODfSu+PlCawU1CduWWHnj6pT7lqr/N06kth
         dn+fORvA0eRA/cwUZ74IElfZjB96rTcXvOECNc/a2EODCdqU+EwJR5v2yUGlGTTZRr
         vibpj1ZWGXzUQ==
Date:   Thu, 31 Dec 2020 12:38:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: Is it ok to use debugfs to dump some ucontext-level
 driver-defined info?
Message-ID: <20201231103850.GE6438@unreal>
References: <d681bc1cad0e4726806aeb46f240d07d@huawei.com>
 <20201231075907.GD6438@unreal>
 <f7eb8350a0474532870c5ad2ab940c5a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7eb8350a0474532870c5ad2ab940c5a@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 31, 2020 at 09:36:27AM +0000, liweihang wrote:
> On 2020/12/31 15:59, Leon Romanovsky wrote:
> > On Tue, Dec 29, 2020 at 01:31:39PM +0000, liweihang wrote:
> >> Hi all,
> >>
> >> We want to dump some hns driver-defined information that belongs to a
> >> process to keep track of current memory usage. For example, there is
> >> a ucontext-level(process-level) memory pool to store WQE which is
> >> shared by a lot of QPs, we want to record and query which QPs are using
> >> this pool and how much space each QP is using.
> >>
> >> rdmatool don't have a ucontext-level resource tracking currently, is it
> >> ok to achieve that through debugfs?
> >>
> >> This may looks like:
> >>
> >> $ echo 1 > <dbgfs_dir>/hns_roce/hns_0/<pid>/qp
> >> QPN        Total(kB)  SQ(kB)     SGE(kB)    RQ(kB)
> >> 110        6400       256        2048       4096
> >> 118        6400       256        2048       0
> >>
> >> Or should it be achieved in rdmatool?
> >
> > I think so, because PID != ucontext. Why can't it be presented as QP
> > attribute? Can you please send "rdmatool" example?
> >
> > Thanks
>
> Hi Leon,
>
> Thanks for your response. If we can achieve it in rdmatool, it may
> looks like:
>
> 1) We want to get some information of a ucontext (assuming that each
> ucontext has an ID), for example, the size of a memory pool that belongs
> to a ucontext as I mentioned above:
>
> $ rdma res show ucontext
> uctx_id	1 pid 20 qp_buf_sz 6400 sq_buf_sz 256 sge_buf_sz 2048 rq_buf_sz 4096
> uctx_id	2 pid 20 qp_buf_sz 4800 sq_buf_sz 128 sge_buf_sz 2048 rq_buf_sz 2048

I have no problems to add "rdma res show ucontext" command, we just need
to find what should be printed.

>
> 2) We want to know which ucontext a QP belongs to:
>
> $ rdma res show qp
> link hns_0/1 lqpn 1 type GSI ... uctx_id 1
> link hns_0/1 lqpn 2 type RC ... uctx_id 1
>
> So the question is, we don't have a ucontext-level restrack currently, and
> there in no 'id' for each ucontext.

We have IDs for every ucontext, it is called "ctxn" and because QP is
not connected directly to ucontext, but through PDs, it is visible
when you check PDs.

[leonro@vm ~]$ ibv_rc_pingpong &
[leonro@vm ~]$ rdma res show
0: ibp0s9: pd 4 cq 4 qp 4 cm_id 0 mr 1 ctx 1
[leonro@vm ~]$ rdma res show qp type RC
link ibp0s9/1 lqpn 50 rqpn 0 type RC state INIT rq-psn 16777215 sq-psn 0 path-mig-state MIGRATED pdn 3 pid 479 comm ibv_rc_pingpong
[leonro@vm ~]$ rdma res show pd pdn 3
ifindex 0 ifname ibp0s9 pdn 3 users 2 ctxn 0 pid 479 comm ibv_rc_pingpong
                                      ^^^^^^

Thanks

>
> Thanks
> Weihang
>
