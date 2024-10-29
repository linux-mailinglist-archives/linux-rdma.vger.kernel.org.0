Return-Path: <linux-rdma+bounces-5601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388E9B4F5E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C17B21BAB
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2FA1CC885;
	Tue, 29 Oct 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Zvu7y8Ku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621819AA5A
	for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219548; cv=none; b=nI3Ft5D2jLGRABQ0bIC761pk7BKUM6vq/6t39NDRCfLMOinBl0CM6rGzi57ogFMCDBYTStfmIF/WSLMtYwkwm+1zZqsaDRn3+6J4BbSzL3Linwl6sXEKWrlM37xYmTeGJVz4iTG+ch0LkS/2VCFQhanGlnFwFedr9eDykWDj6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219548; c=relaxed/simple;
	bh=kFGL+if3/xwjjMNeXcV0G9jxEMBEzcmboI/K66wzIbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyXORoPLTUC5GallJssve/KQbi/9DYvNFbJZOa0fDJ5vHy8YKdjpm7MJfzvVzS26zLel7kH5k0vzC6t83Ma/XUd/9WiBcb/7yM3vSFfXtChMcPKnc+koiyLOqQdlYkz8MOpg5bL8F8wn3ILUGQmzZt73gf9RZRKgwDWD37IvBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Zvu7y8Ku; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e617c3e9bso313970b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730219545; x=1730824345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp2bPRmIZGXK74UCf6LU4Vct82RL32V7HDLFUkfsc1Q=;
        b=Zvu7y8KuuysMtauu1v5K5v+nrP+IwgkkIbiBgYMenjS1HxfXon4Y8i77wVchWHoJAM
         XC/gFqEmlRblqANjnbm5gyGx1kxU2PdR7xsSS9kZ9Vy17zV8LDLSI9FpxT4U+tXeWenp
         aq8CwqaW5I3bu/x3biVrX5BVI2+J9XMcD30w4hmNro92a2LLed9cABZFVMomfKrXCaOG
         nuLlSL5+DOH3ublRYLOrOSvr+gRXILS2xVehbSpsPItSRQ9qKUmUj1qBLeb2QrlPsjap
         49Yu1cPeuovuRjgMFEtrb/vzIq9R1xIWGD/wWs0rI3uZCsgqOJ4DLjqMiQ9B7WYcx4Q5
         94wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730219545; x=1730824345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp2bPRmIZGXK74UCf6LU4Vct82RL32V7HDLFUkfsc1Q=;
        b=SvdVwgWxzFKRh8dPO4XisI3Di1kOPPO0eAJdlUEpMIU+N20oIXN1ePDY8ymKORA1aO
         66G/Lro5j+/luw/DKGF4riafNAo4G/XWygMuQbYjijYAcpYHuFtdkq8Mx8SN1iBEmqcU
         8vvJWBfid2ez9jOcUEucH9Zt251l2cIcY0eqf56O7PXOg3t85I4Yw8YNS1zHEiNY9vK1
         PekwyME8Ydr6SHiSMSMH5lB4efnsSeldWp8bxc4+WxNgitfiIb3cocs+ntC7r2eEPtdk
         KEXbJyf4MOxlc1KoeCYKNjq8715CUuSypwUx2Fe4AINtebl6gGP2cF2FYMhttIi1Xp9s
         dYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgPdLjD0zw1YTwWq+iq2DrGF3HndDwPQRa9hMKY+gWbHwvXp87neQ00Y8NPYZAd698e2coDSxnpVep@vger.kernel.org
X-Gm-Message-State: AOJu0YwumCh4KXibIz2VxP9dJOLwef50nWLlyfgDQYPDkj3hDGWrgctV
	pb3YFS+hEV4tsM7BTvmbpFuZfka35AN0oYVUpb9UzVpdT4+lx1RaQ1hdtbr8my31fyk0P0AtkpK
	lR8jJvnvEhN6xAeUewZJW6Uj7i0X+gL9qF7nFYw==
X-Google-Smtp-Source: AGHT+IHKCbM1cYCtX219ubq/3oNT4yYLJDHESaG5BrVKKjk8PLnkRjcgUVnhxZo4ARKjwaqQViSzLtyJEGHHEaclMFc=
X-Received: by 2002:a05:6a00:2da4:b0:71e:6895:fe9e with SMTP id
 d2e1a72fcca58-72063059e84mr7299787b3a.6.1730219544956; Tue, 29 Oct 2024
 09:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027040700.1616307-1-csander@purestorage.com> <CY8PR12MB7195E405C3EC9F43619231CCDC4B2@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7195E405C3EC9F43619231CCDC4B2@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 29 Oct 2024 09:32:13 -0700
Message-ID: <CADUfDZq_hsHDxi0uyxUY-PLJQm9CNYnnxjqWUXsx0ssuh6ee-A@mail.gmail.com>
Subject: Re: [PATCH] mlx5: only schedule EQ comp tasklet if necessary
To: Parav Pandit <parav@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:08=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
> Hi
>
> > From: Caleb Sander Mateos <csander@purestorage.com>
> > Sent: Sunday, October 27, 2024 9:37 AM
> >
> > Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet=
 to call
> > mlx5_cq_tasklet_cb() if it processes any completions. For CQs whose
> > completions don't need to be processed in tasklet context, this overhea=
d is
> > unnecessary. Atomic operations are needed to schedule, lock, and clear =
the
> > tasklet. And when mlx5_cq_tasklet_cb() runs, it acquires a spin lock to=
 access
> > the list of CQs enqueued for processing.
> >
> > Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
> > overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs=
 to
> > be processed in tasklet context, so it can schedule the tasklet. CQs th=
at need
> > tasklet processing have their interrupt comp handler set to
> > mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that d=
on't
> > need tasklet processing won't schedule the tasklet. To avoid scheduling=
 the
> > tasklet multiple times during the same interrupt, only schedule the tas=
klet in
> > mlx5_add_cq_to_tasklet() if the tasklet work queue was empty before the
> > new CQ was pushed to it.
> >
> > Note that the mlx4 driver works the same way: it schedules the tasklet =
in
> > mlx4_add_cq_to_tasklet() and only if the work queue was empty before.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
> > drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> > index 4caa1b6f40ba..25f3b26db729 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> > @@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
> > static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
> >                                  struct mlx5_eqe *eqe)
> >  {
> >       unsigned long flags;
> >       struct mlx5_eq_tasklet *tasklet_ctx =3D cq->tasklet_ctx.priv;
> > +     bool schedule_tasklet =3D false;
> >
> >       spin_lock_irqsave(&tasklet_ctx->lock, flags);
> >       /* When migrating CQs between EQs will be implemented, please not=
e
> >        * that you need to sync this point. It is possible that
> >        * while migrating a CQ, completions on the old EQs could
> >        * still arrive.
> >        */
> >       if (list_empty_careful(&cq->tasklet_ctx.list)) {
> >               mlx5_cq_hold(cq);
> > +             schedule_tasklet =3D list_empty(&tasklet_ctx->list);
> >               list_add_tail(&cq->tasklet_ctx.list, &tasklet_ctx->list);
> >       }
> >       spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
> > +
> > +     if (schedule_tasklet)
> > +             tasklet_schedule(&tasklet_ctx->task);
> >  }
> >
> >  /* Callers must verify outbox status in case of err */  int mlx5_creat=
e_cq(struct
> > mlx5_core_dev *dev, struct mlx5_core_cq *cq,
> >                  u32 *in, int inlen, u32 *out, int outlen) diff --git
> > a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > index 68cb86b37e56..66fc17d9c949 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > @@ -112,17 +112,17 @@ static int mlx5_eq_comp_int(struct notifier_block
> > *nb,
> >       struct mlx5_eq_comp *eq_comp =3D
> >               container_of(nb, struct mlx5_eq_comp, irq_nb);
> >       struct mlx5_eq *eq =3D &eq_comp->core;
> >       struct mlx5_eqe *eqe;
> >       int num_eqes =3D 0;
> > -     u32 cqn =3D -1;
> >
> >       eqe =3D next_eqe_sw(eq);
> >       if (!eqe)
> >               goto out;
> >
> >       do {
> > +             u32 cqn;
> >               struct mlx5_core_cq *cq;
> >
> A small nit, cqn should be declared after cq to follow the netdev coding =
guidelines of [1].

Sure, will fix. Thanks for the reference.

>
> >               /* Make sure we read EQ entry contents after we've
> >                * checked the ownership bit.
> >                */
> > @@ -145,13 +145,10 @@ static int mlx5_eq_comp_int(struct notifier_block
> > *nb,
> >       } while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe =3D
> > next_eqe_sw(eq)));
> >
> >  out:
> >       eq_update_ci(eq, 1);
> >
> > -     if (cqn !=3D -1)
> > -             tasklet_schedule(&eq_comp->tasklet_ctx.task);
> > -
> Current code processes many EQEs and performs the check for tasklet_sched=
ule only once in the cqn check.
> While this change, on every EQE, the additional check will be done.
> This will marginally make the interrupt handler slow.
> Returning a bool from comp() wont be good either, and we cannot inline th=
ings here due to function pointer.
>
> The cost of scheduling null tasklet is higher than this if (schedule_task=
let) check.
> In other series internally, I am working to reduce the cost of comp() its=
elf unrelated to this change.
> so it ok to have the additional check introduced here.

Right, there's definitely a tradeoff here.
From what I could tell, there is only one CQ type that processes
completions in tasklet context (user Infiniband CQs, running
mlx5_ib_cq_comp()). All others handle their completions in interrupt
context. Ideally the CQ types that don't need it would not pay the
cost of the tasklet schedule and execution. There are several atomic
operations involved in the tasklet path which are fairly expensive. In
our TCP-heavy workload, we see 4% of the CPU time spent on the
tasklet_trylock() in tasklet_action_common.constprop.0, with a smaller
amount spent on the atomic operations in tasklet_schedule(),
tasklet_clear_sched(), and acquiring the spinlock in
mlx5_cq_tasklet_cb().
I agree the additional branch per EQE should be cheaper than
scheduling the unused tasklet, but the cost would be paid by
Infiniband workloads while non-Infiniband workloads see the benefit.
How about instead scheduling the tasklet in mlx5_eq_comp_int() if any
of the CQs have a tasklet completion handler? That should get the best
of both worlds: skipping the tasklet schedule for CQs that don't need
it while ensuring the tasklet is only scheduled once per interrupt.
Something like this:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 68cb86b37e56..f0ba3725b8e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -112,9 +112,9 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
        struct mlx5_eq_comp *eq_comp =3D
                container_of(nb, struct mlx5_eq_comp, irq_nb);
        struct mlx5_eq *eq =3D &eq_comp->core;
+       bool schedule_tasklet =3D false;
        struct mlx5_eqe *eqe;
        int num_eqes =3D 0;
-       u32 cqn =3D -1;

        eqe =3D next_eqe_sw(eq);
        if (!eqe)
@@ -122,6 +122,7 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,

        do {
                struct mlx5_core_cq *cq;
+               u32 cqn;

                /* Make sure we read EQ entry contents after we've
                 * checked the ownership bit.
@@ -134,6 +135,7 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
                if (likely(cq)) {
                        ++cq->arm_sn;
                        cq->comp(cq, eqe);
+                       schedule_tasklet |=3D !!cq->tasklet_ctx.comp;
                        mlx5_cq_put(cq);
                } else {
                        dev_dbg_ratelimited(eq->dev->device,
@@ -147,7 +149,7 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 out:
        eq_update_ci(eq, 1);

-       if (cqn !=3D -1)
+       if (schedule_tasklet)
                tasklet_schedule(&eq_comp->tasklet_ctx.task);

        return 0;

Thanks,
Caleb

