Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF41E884
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEOGtX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 02:49:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37467 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOGtX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 02:49:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so2601310edw.4;
        Tue, 14 May 2019 23:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48yngF/FDRHAZXmLQeAd7al+O7G8keCIP9i3ThoJUc0=;
        b=LGUa1zFkrH3jKWKDUjMTeEjsC/TlXPx0BnRMqmbcD1UUhz9G00wMfivuh7kOnTIE32
         9IKhX6YbzKkr8lwSyL25gAgB3i2WvwSOFDNtWBTQtUgqyYbCDoTeBOyvr4aP7ZUxg+uv
         +N64zR5wJyxxJGy3Ef3Kq6VmLBcrdtj31YTPt+obg7TNlUBSgqrMp4ggo1UGBLoRuDCm
         U5Jx+iQ0OlIFJb/kwVvvhpd7E2ZrLB4SmToQlNuw9fCtHXxjsvdseubOvWLdgBGeEabg
         MQ8++JSL8UR8KkjRQnG9EDfWgmJptg2BZJYvMaGSEHzE3KF9fBkYCoaQ0mNjo9o9BBJL
         Om2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48yngF/FDRHAZXmLQeAd7al+O7G8keCIP9i3ThoJUc0=;
        b=rwWoSXvkAv5KOefExdZkWbUZ1SqdUaM4XpeiE8yZUURoksyKepqPamHROANPb99w7D
         I0LTuvntGHdzn5HiR+PJgy/opiXGtwv4AzzRjPvz8x2XkdAiWt1AYa9er0RaFOwdXTEm
         gXo0nNjZJ3L3B3e3bO70wsgVwND909Qku6A3L5Z/WFH7D0eFCJwpP245KAUBTMCW4EfD
         5WbVKMeOhsQsP79oCvksT+sTlNU7N7Gj453CVClQUGIwotucsFG6XHoc/GgiVjqrqMtH
         gMvZqh5L6HQNtkqw2/dEFz/6Is3kN09rBzpAJxyPYRqsqR3DIn7yBm4dbRAnTYJbdxRR
         CGgQ==
X-Gm-Message-State: APjAAAX6kNxpbvIECEjTUR8Ls0k3IMmIXrFT7lx+gCxONBcgLw08mSiN
        ymjwG0XRArI2WaNv/1sFFco=
X-Google-Smtp-Source: APXvYqyzQg3zls+zCwHTtJdq53njIRbmjK8QuPiTOncJ6GxqCxscmIWrCjf63NXtTCy/hmAcnSov1w==
X-Received: by 2002:a17:906:6b18:: with SMTP id q24mr31582277ejr.225.1557902961514;
        Tue, 14 May 2019 23:49:21 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id k18sm470133eda.92.2019.05.14.23.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 23:49:20 -0700 (PDT)
Date:   Tue, 14 May 2019 23:49:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "kbuild@01.org" <kbuild@01.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Message-ID: <20190515064918.GA4807@archlinux-i9>
References: <20190514194510.GA15465@archlinux-i9>
 <20190515003202.GA14522@ziepe.ca>
 <20190515050331.GC5225@mtr-leonro.mtl.com>
 <CAK8P3a0aH9Ezur3r7TDVMPreVKMip2HMEWhUsC_pKhOq7mE+3A@mail.gmail.com>
 <20190515064043.GA944@archlinux-i9>
 <CAK8P3a1r3QD=pwZqG+SfDkVr_V3P7ueRT8SLss9z+M6OEQst4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1r3QD=pwZqG+SfDkVr_V3P7ueRT8SLss9z+M6OEQst4A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 08:42:13AM +0200, Arnd Bergmann wrote:
> On Wed, May 15, 2019 at 8:40 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, May 15, 2019 at 08:31:49AM +0200, Arnd Bergmann wrote:
> > > On Wed, May 15, 2019 at 7:04 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> > > > On Tue, May 14, 2019 at 09:32:02PM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > I checked the RDMA mailing list and trees and I haven't seen this
> > > > > > reported/fixed yet (forgive me if it has) but when building for arm32
> > > > > > with multi_v7_defconfig and the following configs (distilled from
> > > > > > allyesconfig):
> > > > > >
> > > > > > CONFIG_INFINIBAND=y
> > > > > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> > > > > > CONFIG_INFINIBAND_USER_ACCESS=y
> > > > > > CONFIG_MLX5_CORE=y
> > > > > > CONFIG_MLX5_INFINIBAND=y
> > > > > >
> > > > > > The following link time errors occur:
> > > > > >
> > > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
> > > > > > main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
> > > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
> > > > > > cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
> > > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
> > > > > > cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'
> > > > >
> > > > > Fengguang, I'm surprised that 0-day didn't report this earlier..
> > > >
> > > > I got many successful emails after I pushed this patch to 0-day testing.
> > >
> > > The long division warnings can compiler specific, and depend on certain
> > > optimization options, as compilers can optimize out certain divisions and
> > > replace them with multiplications and/or shifts, or prove that they can be
> > > replaced with a 32-bit division. If this is a case that gcc manages to
> > > optimize but clang does not, it might be worth looking into whether an
> > > optimization can be added to clang, in addition to improving the source.
> >
> > While I did run initially run into this with clang, the errors above are
> > with gcc (mainly to show this was going to be a universal problem and
> > not just something with clang).
> 
> Which gcc version did you use here? Anything particularly old or particularly
> new? I think 0-day is on a fairly recent gcc-8, but not the latest gcc-9
> release.

8.2.0 it seems (I've been meaning to build from the 9.x branch though
since it appears that Arch's arm-linux-gnueabi-gcc isn't going to get
updated since it's in the AUR).
