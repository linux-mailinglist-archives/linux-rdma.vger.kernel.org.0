Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C831824EF8D
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Aug 2020 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgHWTqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Aug 2020 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHWTqE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Aug 2020 15:46:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE42FC061573
        for <linux-rdma@vger.kernel.org>; Sun, 23 Aug 2020 12:46:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so6430986wmi.2
        for <linux-rdma@vger.kernel.org>; Sun, 23 Aug 2020 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vL87g1XGOmL7vLHYcXTZcUzLCzV2/7QByJxsnm+DM5k=;
        b=LlHqBfAFJ132chDl7aOWUsqiGty/iyRmwH42p3AH0jj5TojgZzgK/lA0FmPkpB25/b
         EmMpTCQCrJIP0I69eHGc3K/JcL2teDbQiAb+acyD03E/j4LsRws4bkF55eaYiFjco8Zj
         8M9eOM6VvfvT0aGdrthucISdWTkVsSoxQBz6PYgUYQC2lKc4rbo9Qyy+kqXbfB6T8Vdj
         jPG/PSkjBDYpZyPkqtC8Ea2k+c2VT7VQGyRY4c/YYeyaNLZz95qGc8e7/ViE0q379s/S
         Pbi2Wh3xuGqKyBD99N298lQZIhPvDX26mWH2amOSgmg5wm8oLViywe/8S6AQ072keKBG
         rjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vL87g1XGOmL7vLHYcXTZcUzLCzV2/7QByJxsnm+DM5k=;
        b=QTZCpICzcze82IaJ+2eKAJWczhw2ZfyGeGgCa9vDF52SMJ9vxh6Z1i2aSbNWmoraHR
         58xi0C433BAoXDKmSGyXxIm9D0gSVIVbEnAtMwFgofMf0eihxhLBUprVWK7sgNJ3VHtN
         +leL75hhK22x81UcIXn6YZ67D3+wreHkfMS6YoLQIxUpZ4SX6nIiCLn0DvvdTRflCPTx
         1iQWKb8D8CJ7p3GOCqka5dxVjQEvqmfvnXF8kMrnlf2NEEZy73H8pXzT3t3g4N/RJ/oL
         oLjPclzTCokmJANn5BuRTtogGhtQuorVq3Syd2E7F5t8geQEB6Ejp9HTzvTCzSzsSz0y
         RR+Q==
X-Gm-Message-State: AOAM532R3q1CxxY+o97ssfVtPjzHRYVI1dS2EnNAYhMGMGtnp9Ew8Yta
        BOG/mWLx1eVrAqB5f6JOSe3j2eYiWsY=
X-Google-Smtp-Source: ABdhPJyvuiXvOnEK22PvejzRnF7P8wEaGcAOxwLR+Yo8SDY0lxCMb2P6hHaluFKjBnUjRzQv1Hu/8w==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr2448047wmk.176.1598211962364;
        Sun, 23 Aug 2020 12:46:02 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id l1sm20714823wrb.12.2020.08.23.12.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 12:46:01 -0700 (PDT)
Date:   Sun, 23 Aug 2020 22:45:58 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200823194558.GA36665@kheib-workstation>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
 <20200818163157.GY24045@ziepe.ca>
 <20200818211545.GA936143@kheib-workstation>
 <20200820113717.GA24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820113717.GA24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 08:37:17AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 19, 2020 at 12:15:45AM +0300, Kamal Heib wrote:
> > On Tue, Aug 18, 2020 at 01:31:57PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> > > > To avoid the following kernel panic when calling kmem_cache_create()
> > > > with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> > > > context of device initialization.
> > > 
> > > I think you've hit on a bigger bug than just this oops.
> > > 
> > > rxe_net_add() should never be called before rxe_module_init(), that
> > > surely subtly breaks all kinds of things.
> > > 
> > > Maybe it is time to remove these module parameters?
> > >
> > Yes, I agree, this can be done in for-next.
> > 
> > But at least can we take this patch to for-rc (stable) to fix this issue
> > in stable releases?
> 
> If you want to fix something in stable then block the module options
> from working as actual module options - eg before rxe_module_init()
> runs.
> 
> Jason

Something like the following patch?

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 907203afbd99..872ebc57ac06 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -40,6 +40,8 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");

+bool rxe_is_loaded = false;
+
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
@@ -315,6 +317,7 @@ static int __init rxe_module_init(void)
                return err;

        rdma_link_register(&rxe_link_ops);
+       rxe_is_loaded = true;
        pr_info("loaded\n");
        return 0;
 }
@@ -326,6 +329,7 @@ static void __exit rxe_module_exit(void)
        rxe_net_exit();
        rxe_cache_exit();

+       rxe_is_loaded = false;
        pr_info("unloaded\n");
 }

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fb07eed9e402..d9b71b5e2fba 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -67,6 +67,8 @@

 #define RXE_ROCE_V2_SPORT              (0xc000)

+extern bool rxe_is_loaded;
+
 static inline u32 rxe_crc32(struct rxe_dev *rxe,
                            u32 crc, void *next, size_t len)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
index ccda5f5a3bc0..12c7ca0764d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
@@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
        struct net_device *ndev;
        struct rxe_dev *exists;

+       if (!rxe_is_loaded) {
+               pr_err("Please make sure to load the rdma_rxe module first\n");
+               return -EINVAL;
+       }
+
        len = sanitize_arg(val, intf, sizeof(intf));
        if (!len) {
                pr_err("add: invalid interface name\n");

Thanks,
Kamal
