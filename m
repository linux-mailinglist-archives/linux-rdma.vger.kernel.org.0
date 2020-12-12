Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B202D8399
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Dec 2020 01:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390332AbgLLAq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 19:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgLLAqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 19:46:46 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C55C0613D3
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 16:46:06 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so15906796lfh.2
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p8BkEtCdcNBP/TpCqa88TfNrEdwTBnXM61elkmQDlU=;
        b=vPmJzs+nnMzMYiLeSl4C70AwwAUmtSXcRtz7EHFhXOG3+HSYoFdEGzQYdbnIfuLhe1
         cpLA6/bKDco/ZW56K0yojauLy12p9RMJ4MYQUMAZkQKn1JGQikvuaZfR0PCAwR/VHwqu
         l8KSlmgfW9XQH81QbMWcZWDg6fTfP5u9gInsHFToPISthtmCvix2Zi4MyAVk8WOEDUbJ
         6rVaVkrA8lMaHHNzl8tzPLP3FKzwRwCbx4UWePv66IKRrK3BWVszh2/HuHa0/BXzK05/
         +RmxfJa60vjGUHEMlcdmB6LQFBStfB7tIZX79j1mfET935nYYecl+y81TGJ83zzfgTnD
         hTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p8BkEtCdcNBP/TpCqa88TfNrEdwTBnXM61elkmQDlU=;
        b=SnNj13nTXXV4X1glrxEqH6tDQxtKLPbpHTs/hm+En0qptuTAhFKxLTcniCaBVjCNSK
         xXzaGe+pNX88kkJS9C8XMolywJFz+edtlrzl24HbqJ6veFLdu0zxIL3dVe6jSZPc28C4
         qraX08imwsgRKrN3Dmxym6ou9xBoKAcRM5yUzrpTVK9QsjBqOUYe3wsysj1amB+oYNSx
         nlxl/2YXG7mZCOh0AlgGNIibbgvIB6FTlJeKFvAgq/ynmduvUN4FCdNXsG5KPuRTuJx4
         45c5ftNPNkFLFSyqYxeY3Q/f5zT5YoDfjoMkxS314xeSJ+O2LYi0EjVv9oEa+q+8+XIR
         N5aw==
X-Gm-Message-State: AOAM533ItDF2yCT/Nt2cSVBHXVDg9FXcUakoUzPHofwy4a38uTbZuoQF
        9jqjxsON5qN3SanB8HLN9E8wOh4avj7a3c5z+xG3vA==
X-Google-Smtp-Source: ABdhPJw+G3KfJG3M7IoDnPiDCepv2YgkNV/jArpapqMifWmjCRwgJbTiMDpguzIYWZxJHM0zdf1udksfd+uvUSH+FdI=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr2692550ljo.368.1607733964618;
 Fri, 11 Dec 2020 16:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20201210192536.118432146@linutronix.de> <20201210194044.065003856@linutronix.de>
In-Reply-To: <20201210194044.065003856@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Dec 2020 01:45:53 +0100
Message-ID: <CACRpkdbKZzaTq+Am6q38Ya5wuUjiMbLE5g2i8bb_mJEWTkXgCg@mail.gmail.com>
Subject: Re: [patch 15/30] pinctrl: nomadik: Use irq_has_action()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 10, 2020 at 8:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> Let the core code do the fiddling with irq_desc.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose you will funnel this directly to Torvalds, else tell me and
I'll apply it to my tree.

Yours,
Linus Walleij
