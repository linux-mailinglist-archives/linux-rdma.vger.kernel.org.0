Return-Path: <linux-rdma+bounces-3579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC891DC25
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B21F226BC
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34E12BEBB;
	Mon,  1 Jul 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4IKEhGt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4012A14C;
	Mon,  1 Jul 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828834; cv=none; b=dspV6TGi+eCc4LS3oNLdPxVw7wcSFGDx2qNOGCbIyvw4EVr9e8R2t7tIOMe4XIqsj+3tlc7vlKvvbo/3bbkq25UZhVpA7o5jwtMW2nFwuo+mrubAPhc9z7UuSkrqA6TiynwNMKbC6HBSKwcDYYjtgl0bBi1b/4huvTprClFcZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828834; c=relaxed/simple;
	bh=/4HP0n2mAWazVVIFLF3VqL8/tANDYE5SDpiJxPxV428=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ1N5Sj9LNQjWHYCcbOiMwtrvoQS2zJFXFQeVIJRLKb1lTt0qP8Whi2JoOMDdpYorXbwxRlF9mRVge9te1tZa0gtZWKU/Iz08b3s4xxlxlYRHL1kAqrRTqqHCxgFz6MXMMAjQ3OoCAvZdkPC7iIkIiS/2odg/GX87fIh87nXaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4IKEhGt; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48f5d1c2341so1591042137.0;
        Mon, 01 Jul 2024 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719828832; x=1720433632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rUpe4bwtWRK7YCgWAPHoYZNa3aezWeETuJ6UvHYuu6k=;
        b=Y4IKEhGtRbN/Bt8rQ0JcWh+WWa3FwjxiQadcSULgz3gx2Z51jJqY0KrUV/h2otRJh1
         ArueGxuSmKus7zFuvPgtaT5K+Z5OSCgP0hQzU16xxz8yj493b4DN9GjeurZCLBK+PvqC
         lRKCoeWufrUxhEK6J7l6PWapdpO5UY8RIh/WBlRyii8qT/HbIoUbab/66AhTWQFjMYeJ
         J2yI9ptDABO3/dFXoDAbWo4e3LjU+Mi38Q8NuX5OXmV+ZFVy0GCJrqcG4e1jnXnSAU97
         gDidBF3otkH2CZPT2c+oPCT3gnH1vYOyFiNBhupDAtNyTC+5rwzMVUPsGcG247+u3Mj8
         AK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828832; x=1720433632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUpe4bwtWRK7YCgWAPHoYZNa3aezWeETuJ6UvHYuu6k=;
        b=l0+MpnOvtrdZ4Yyejgc0elaeN7V3t3jo7BMCuUkeG+cCYwXaeBObHr+4z9OYNP9eue
         Iu3x+MrxdrbZkdhZDIBh+Qe0ouA6TmE986o2+m+AnRBNgrSp4Ec3uPDdinZ7urKEJHYe
         FzVcY+0qIrA9BnN54VGGncm7+TKb/TTy38Hy+r13Dhhuh7nyj9DQxzFiIUzopVv2EJJk
         0HCsi5uSKGntQUahQFf9UhsDMNEbI/xs/Cr9bP/vfLwE1mUQAsWIgZaB0EMfVleJFxfv
         W9rYcGXg6bzZId1Ekfl6af/WChaxglc1rI9EGKcxwBjTGS8FiWkuXrrTtULYliPvFvtt
         7vEA==
X-Forwarded-Encrypted: i=1; AJvYcCW32VafNaC5Ghz/2LoMGwHV1BssZ/f2/NwqyePA2LGATpqCy36Vr3k0hXszOnv0G5Ez+A9BRnrpQzlNYnqjOZZB1KzpR1CRkko2GSTSoW1y4STu4cHVZP1LvJFTuDTe0KdneX9Pr6nP5lISZG7bArNhykFpBP9PrA8dW/wqCDK+tA==
X-Gm-Message-State: AOJu0Yzjmk13xrzpYkn3G6QEmz3T46wifMkeiUgaGXvXUnSJIjkMYC08
	n32bN2xpJDgfrLULfmO4ewk1zUvtuT3ZiM/PZSf5CHiTL8NgJH9EELgfkYjxJ3Aoy0pu47nxo6N
	51NvIb9Zus57j4FZ3b6Yti6k2bT4=
X-Google-Smtp-Source: AGHT+IHEeQzocq9o8QY1mErTF54UcSbkxPrkindMgg4PeP0hAT6SghZMAJoR6/Jn/fHhn+rELCoqAdjciVsJ7Ynyhmc=
X-Received: by 2002:a05:6102:5120:b0:48f:9584:bdc0 with SMTP id
 ada2fe7eead31-48f9ea0ed23mr6215073137.11.1719828831656; Mon, 01 Jul 2024
 03:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
 <20240621050525.3720069-14-allen.lkml@gmail.com> <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
In-Reply-To: <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 1 Jul 2024 03:13:40 -0700
Message-ID: <CAOMdWSKKyqaJB2Psgcy9piUv3LTDBHhbo_g404fSmqQrVSyr7Q@mail.gmail.com>
Subject: Re: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half
 workqueue mechanism
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, Guo-Fu Tseng <cooldavid@cooldavid.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, jes@trained-monkey.org, 
	kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	marcin.s.wojtas@gmail.com, mlindner@marvell.com, stephen@networkplumber.org, 
	nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, 
	lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> > replaces all occurrences of tasklet usage with the appropriate workqueue
> > APIs throughout the jme driver. This transition ensures compatibility
> > with the latest design and enhances performance.
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
> >  drivers/net/ethernet/jme.c | 72 +++++++++++++++++++-------------------
> >  drivers/net/ethernet/jme.h |  8 ++---
> >  2 files changed, 40 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> > index b06e24562973..b1a92b851b3b 100644
> > --- a/drivers/net/ethernet/jme.c
> > +++ b/drivers/net/ethernet/jme.c
> > @@ -1141,7 +1141,7 @@ jme_dynamic_pcc(struct jme_adapter *jme)
> >
> >       if (unlikely(dpi->attempt != dpi->cur && dpi->cnt > 5)) {
> >               if (dpi->attempt < dpi->cur)
> > -                     tasklet_schedule(&jme->rxclean_task);
> > +                     queue_work(system_bh_wq, &jme->rxclean_bh_work);
> >               jme_set_rx_pcc(jme, dpi->attempt);
> >               dpi->cur = dpi->attempt;
> >               dpi->cnt = 0;
> > @@ -1182,9 +1182,9 @@ jme_shutdown_nic(struct jme_adapter *jme)
> >  }
> >
> >  static void
> > -jme_pcc_tasklet(struct tasklet_struct *t)
> > +jme_pcc_bh_work(struct work_struct *work)
> >  {
> > -     struct jme_adapter *jme = from_tasklet(jme, t, pcc_task);
> > +     struct jme_adapter *jme = from_work(jme, work, pcc_bh_work);
> >       struct net_device *netdev = jme->dev;
> >
> >       if (unlikely(test_bit(JME_FLAG_SHUTDOWN, &jme->flags))) {
> > @@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct *work)
> >               jme_stop_shutdown_timer(jme);
> >
> >       jme_stop_pcc_timer(jme);
> > -     tasklet_disable(&jme->txclean_task);
> > -     tasklet_disable(&jme->rxclean_task);
> > -     tasklet_disable(&jme->rxempty_task);
> > +     disable_work_sync(&jme->txclean_bh_work);
> > +     disable_work_sync(&jme->rxclean_bh_work);
> > +     disable_work_sync(&jme->rxempty_bh_work);
> >
> >       if (netif_carrier_ok(netdev)) {
> >               jme_disable_rx_engine(jme);
> > @@ -1304,7 +1304,7 @@ static void jme_link_change_work(struct work_struct *work)
> >               rc = jme_setup_rx_resources(jme);
> >               if (rc) {
> >                       pr_err("Allocating resources for RX error, Device STOPPED!\n");
> > -                     goto out_enable_tasklet;
> > +                     goto out_enable_bh_work;
> >               }
> >
> >               rc = jme_setup_tx_resources(jme);
> > @@ -1326,22 +1326,22 @@ static void jme_link_change_work(struct work_struct *work)
> >               jme_start_shutdown_timer(jme);
> >       }
> >
> > -     goto out_enable_tasklet;
> > +     goto out_enable_bh_work;
> >
> >  err_out_free_rx_resources:
> >       jme_free_rx_resources(jme);
> > -out_enable_tasklet:
> > -     tasklet_enable(&jme->txclean_task);
> > -     tasklet_enable(&jme->rxclean_task);
> > -     tasklet_enable(&jme->rxempty_task);
> > +out_enable_bh_work:
> > +     enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> > +     enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> > +     enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
>
> This will unconditionally schedule the rxempty_bh_work and is AFAICS a
> different behavior WRT prior this patch.
>
> In turn the rxempty_bh_work() will emit (almost unconditionally) the
> 'RX Queue Full!' message, so the change should be visibile to the user.
>
> I think you should queue the work only if it was queued at cancel time.
> You likely need additional status to do that.
>

 Thank you for taking the time out to review. Now that it's been a week, I was
preparing to send out version 3. Before I do that, I want to make sure if this
the below approach is acceptable.

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..b3fc2e5c379f 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1141,7 +1141,7 @@ jme_dynamic_pcc(struct jme_adapter *jme)

        if (unlikely(dpi->attempt != dpi->cur && dpi->cnt > 5)) {
                if (dpi->attempt < dpi->cur)
-                       tasklet_schedule(&jme->rxclean_task);
+                       queue_work(system_bh_wq, &jme->rxclean_bh_work);
                jme_set_rx_pcc(jme, dpi->attempt);
                dpi->cur = dpi->attempt;
                dpi->cnt = 0;
@@ -1182,9 +1182,9 @@ jme_shutdown_nic(struct jme_adapter *jme)
 }

 static void
-jme_pcc_tasklet(struct tasklet_struct *t)
+jme_pcc_bh_work(struct work_struct *work)
 {
-       struct jme_adapter *jme = from_tasklet(jme, t, pcc_task);
+       struct jme_adapter *jme = from_work(jme, work, pcc_bh_work);
        struct net_device *netdev = jme->dev;

        if (unlikely(test_bit(JME_FLAG_SHUTDOWN, &jme->flags))) {
@@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct *work)
                jme_stop_shutdown_timer(jme);

        jme_stop_pcc_timer(jme);
-       tasklet_disable(&jme->txclean_task);
-       tasklet_disable(&jme->rxclean_task);
-       tasklet_disable(&jme->rxempty_task);
+       disable_work_sync(&jme->txclean_bh_work);
+       disable_work_sync(&jme->rxclean_bh_work);
+       disable_work_sync(&jme->rxempty_bh_work);

        if (netif_carrier_ok(netdev)) {
                jme_disable_rx_engine(jme);
@@ -1304,7 +1304,7 @@ static void jme_link_change_work(struct work_struct *work)
                rc = jme_setup_rx_resources(jme);
                if (rc) {
                        pr_err("Allocating resources for RX error,
Device STOPPED!\n");
-                       goto out_enable_tasklet;
+                       goto out_enable_bh_work;
                }

                rc = jme_setup_tx_resources(jme);
@@ -1326,22 +1326,23 @@ static void jme_link_change_work(struct
work_struct *work)
                jme_start_shutdown_timer(jme);
        }

-       goto out_enable_tasklet;
+       goto out_enable_bh_work;

 err_out_free_rx_resources:
        jme_free_rx_resources(jme);
-out_enable_tasklet:
-       tasklet_enable(&jme->txclean_task);
-       tasklet_enable(&jme->rxclean_task);
-       tasklet_enable(&jme->rxempty_task);
+out_enable_bh_work:
+       enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+       enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+       if (jme->rxempty_bh_work_queued)
+               enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
 out:
        atomic_inc(&jme->link_changing);
 }

 static void
-jme_rx_clean_tasklet(struct tasklet_struct *t)
+jme_rx_clean_bh_work(struct work_struct *work)
 {
-       struct jme_adapter *jme = from_tasklet(jme, t, rxclean_task);
+       struct jme_adapter *jme = from_work(jme, work, rxclean_bh_work);
        struct dynpcc_info *dpi = &(jme->dpi);

        jme_process_receive(jme, jme->rx_ring_size);
@@ -1374,9 +1375,9 @@ jme_poll(JME_NAPI_HOLDER(holder), JME_NAPI_WEIGHT(budget))
 }

 static void
-jme_rx_empty_tasklet(struct tasklet_struct *t)
+jme_rx_empty_bh_work(struct work_struct *work)
 {
-       struct jme_adapter *jme = from_tasklet(jme, t, rxempty_task);
+       struct jme_adapter *jme = from_work(jme, work, rxempty_bh_work);

        if (unlikely(atomic_read(&jme->link_changing) != 1))
                return;
@@ -1386,7 +1387,7 @@ jme_rx_empty_tasklet(struct tasklet_struct *t)

        netif_info(jme, rx_status, jme->dev, "RX Queue Full!\n");

-       jme_rx_clean_tasklet(&jme->rxclean_task);
+       jme_rx_clean_bh_work(&jme->rxclean_bh_work);

        while (atomic_read(&jme->rx_empty) > 0) {
                atomic_dec(&jme->rx_empty);
@@ -1410,9 +1411,9 @@ jme_wake_queue_if_stopped(struct jme_adapter *jme)

 }

-static void jme_tx_clean_tasklet(struct tasklet_struct *t)
+static void jme_tx_clean_bh_work(struct work_struct *work)
 {
-       struct jme_adapter *jme = from_tasklet(jme, t, txclean_task);
+       struct jme_adapter *jme = from_work(jme, work, txclean_bh_work);
        struct jme_ring *txring = &(jme->txring[0]);
        struct txdesc *txdesc = txring->desc;
        struct jme_buffer_info *txbi = txring->bufinf, *ctxbi, *ttxbi;
@@ -1510,12 +1511,12 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)

        if (intrstat & INTR_TMINTR) {
                jwrite32(jme, JME_IEVE, INTR_TMINTR);
-               tasklet_schedule(&jme->pcc_task);
+               queue_work(system_bh_wq, &jme->pcc_bh_work);
        }

        if (intrstat & (INTR_PCCTXTO | INTR_PCCTX)) {
                jwrite32(jme, JME_IEVE, INTR_PCCTXTO | INTR_PCCTX | INTR_TX0);
-               tasklet_schedule(&jme->txclean_task);
+               queue_work(system_bh_wq, &jme->txclean_bh_work);
        }

        if ((intrstat & (INTR_PCCRX0TO | INTR_PCCRX0 | INTR_RX0EMP))) {
@@ -1538,9 +1539,9 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
        } else {
                if (intrstat & INTR_RX0EMP) {
                        atomic_inc(&jme->rx_empty);
-                       tasklet_hi_schedule(&jme->rxempty_task);
+                       queue_work(system_bh_highpri_wq, &jme->rxempty_bh_work);
                } else if (intrstat & (INTR_PCCRX0TO | INTR_PCCRX0)) {
-                       tasklet_hi_schedule(&jme->rxclean_task);
+                       queue_work(system_bh_highpri_wq, &jme->rxclean_bh_work);
                }
        }

@@ -1826,9 +1827,9 @@ jme_open(struct net_device *netdev)
        jme_clear_pm_disable_wol(jme);
        JME_NAPI_ENABLE(jme);

-       tasklet_setup(&jme->txclean_task, jme_tx_clean_tasklet);
-       tasklet_setup(&jme->rxclean_task, jme_rx_clean_tasklet);
-       tasklet_setup(&jme->rxempty_task, jme_rx_empty_tasklet);
+       INIT_WORK(&jme->txclean_bh_work, jme_tx_clean_bh_work);
+       INIT_WORK(&jme->rxclean_bh_work, jme_rx_clean_bh_work);
+       INIT_WORK(&jme->rxempty_bh_work, jme_rx_empty_bh_work);

        rc = jme_request_irq(jme);
        if (rc)
@@ -1914,9 +1915,10 @@ jme_close(struct net_device *netdev)
        JME_NAPI_DISABLE(jme);

        cancel_work_sync(&jme->linkch_task);
-       tasklet_kill(&jme->txclean_task);
-       tasklet_kill(&jme->rxclean_task);
-       tasklet_kill(&jme->rxempty_task);
+       cancel_work_sync(&jme->txclean_bh_work);
+       cancel_work_sync(&jme->rxclean_bh_work);
+       jme->rxempty_bh_work_queued = false;
+       cancel_work_sync(&jme->rxempty_bh_work);

        jme_disable_rx_engine(jme);
        jme_disable_tx_engine(jme);
@@ -3020,7 +3022,7 @@ jme_init_one(struct pci_dev *pdev,
        atomic_set(&jme->tx_cleaning, 1);
        atomic_set(&jme->rx_empty, 1);

-       tasklet_setup(&jme->pcc_task, jme_pcc_tasklet);
+       INIT_WORK(&jme->pcc_bh_work, jme_pcc_bh_work);
        INIT_WORK(&jme->linkch_task, jme_link_change_work);
        jme->dpi.cur = PCC_P1;

@@ -3180,9 +3182,9 @@ jme_suspend(struct device *dev)
        netif_stop_queue(netdev);
        jme_stop_irq(jme);

-       tasklet_disable(&jme->txclean_task);
-       tasklet_disable(&jme->rxclean_task);
-       tasklet_disable(&jme->rxempty_task);
+       disable_work_sync(&jme->txclean_bh_work);
+       disable_work_sync(&jme->rxclean_bh_work);
+       disable_work_sync(&jme->rxempty_bh_work);

        if (netif_carrier_ok(netdev)) {
                if (test_bit(JME_FLAG_POLL, &jme->flags))
@@ -3198,9 +3200,10 @@ jme_suspend(struct device *dev)
                jme->phylink = 0;
        }

-       tasklet_enable(&jme->txclean_task);
-       tasklet_enable(&jme->rxclean_task);
-       tasklet_enable(&jme->rxempty_task);
+       enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
+       enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
+       jme->rxempty_bh_work_queued = true;
+       enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);

        jme_powersave_phy(jme);

diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index 860494ff3714..44aaf7625dc3 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -406,11 +406,12 @@ struct jme_adapter {
        spinlock_t              phy_lock;
        spinlock_t              macaddr_lock;
        spinlock_t              rxmcs_lock;
-       struct tasklet_struct   rxempty_task;
-       struct tasklet_struct   rxclean_task;
-       struct tasklet_struct   txclean_task;
+       struct work_struct      rxempty_bh_work;
+       struct work_struct      rxclean_bh_work;
+       struct work_struct      txclean_bh_work;
+       bool                    rxempty_bh_work_queued;
        struct work_struct      linkch_task;
-       struct tasklet_struct   pcc_task;
+       struct work_struct      pcc_bh_work;
        unsigned long           flags;
        u32                     reg_txcs;
        u32                     reg_txpfc;



  Do we need a flag for rxclean and txclean too?

Thanks,
Allen

> Thanks,
>
> Paolo
>


-- 
       - Allen

