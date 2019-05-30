Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1086630367
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfE3Umj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 16:42:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54183 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Umj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 16:42:39 -0400
Received: by mail-it1-f195.google.com with SMTP id m141so12229230ita.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImBouEYry+7UAZSORxN+rLIAbSvkF0nL8qUtkmKKmeM=;
        b=szTj76FV9OtiziaQGzucyWQyLableBrGueEFL+nPTchmeJc4Ej74R+9pI+LGcX9E7y
         PRoIT2t7C9Dnmc4JuMvZVY6y5q384TWREfRmJd83YP+V3FPHIQx7tAUOZWYgOtbL0VeT
         cY0eTZHGX1RvlHXeHKCynmCcPA8W4qaEra4ZIUOlKF93GyG2UZ4m4juloQESGlK/iz8t
         ea3TsAir8av/we05YS2n5pgfL/3PVhjimdCWI5Y0LBSE6sSLd7kCWpks4AjApLwBITS5
         x/7CcYoS/hanOGNRMnDikMptLWl90XEM4Ul7cIhBfHv77zRcmJz953SXrUcGjkYZxiQ2
         53DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImBouEYry+7UAZSORxN+rLIAbSvkF0nL8qUtkmKKmeM=;
        b=ehvfP9oz9XtlmpHyuoRrM+U7fosSVIuQMRMvLNlEabvxDB3wZc+IOELCfJk54TPgUD
         rGCeTohcJVk7EbiH96RSDWYf8Io/mCrOMLnTt2P3hTpnRG+NJj+y8lwGwRCE8uKq5zrr
         8Ph/J53z6Y4G981/1oZOQBpYwMmczpH5HNeZICdyErFzZLWizEygKdhVU743UmJbr7ix
         8COycbfZniLXt2dkTXfIldapPjZ0VKvRZm5TtBG8iozMIJa5SQ2zXK12uekLE0eZFPFI
         9al9UjEN3PRL9n+J8BpjxAZY+LIo2RD5y9jYLRjrydAHPvFNIXgTVNQuMZAY4t3yCQaX
         gXGA==
X-Gm-Message-State: APjAAAWVCDov4i2F6zBe7hnqXYQQnY9+zQhAucVG0pAWmo+bpZibN9Q2
        CkaLWFyGafCfSIpsbEqUsYGGYBrDQZvry5v2qUi79A==
X-Google-Smtp-Source: APXvYqyu6BhjzuYiaC9ExwHlELPDSa6J57oAKlBTWp9VJcNI/M27UbBHWR+U2cuw+ctEEeZSITjF0iJb8X7sikNwu0s=
X-Received: by 2002:a02:ccb8:: with SMTP id t24mr3999237jap.9.1559248958154;
 Thu, 30 May 2019 13:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190526114156.6827-1-bmt@zurich.ibm.com> <OF83D2F2C7.9DE43FAF-ON00258409.0055DE83-00258409.00579C96@notes.na.collabserv.com>
 <20190530130316.GF6251@mtr-leonro.mtl.com> <d3c2d95b-21e8-4ca7-f65e-68f3f44bdbc7@intel.com>
In-Reply-To: <d3c2d95b-21e8-4ca7-f65e-68f3f44bdbc7@intel.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Thu, 30 May 2019 15:42:27 -0500
Message-ID: <CADmRdJcy8FQqLZvk9JLa5U0ZUFes0sfoLnw3Jpu+zp3PVD1qJQ@mail.gmail.com>
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 8:53 AM Dennis Dalessandro
<dennis.dalessandro@intel.com> wrote:
>
> On 5/30/2019 9:03 AM, Leon Romanovsky wrote:
> > On Wed, May 29, 2019 at 03:56:57PM +0000, Bernard Metzler wrote:
> >> -----linux-rdma-owner@vger.kernel.org wrote: -----
> >>
> >>> To: linux-rdma@vger.kernel.org
> >>> From: "Bernard Metzler"
> >>> Sent by: linux-rdma-owner@vger.kernel.org
> >>> Date: 05/26/2019 01:42PM
> >>> Cc: "Bernard Metzler" <bmt@zurich.ibm.com>
> >>> Subject: [EXTERNAL] [PATCH for-next v1 00/12] SIW: Software iWarp
> >>> RDMA (siw) driver
> >>>
> >>> This patch set contributes the SoftiWarp driver rebased for
> >>> Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
> >>> protocol over kernel TCP sockets. The driver integrates with
> >>> the linux-rdma framework.
> >>>
> >>> With this new driver version, the following things where
> >>> changed, compared to the v8 RFC of siw:
> >>>
> >>> o Rebased to 5.2-rc1
> >>>
> >>> o All IDR code got removed.
> >>>
> >>> o Both MR and QP deallocation verbs now synchronously
> >>>   free the resources referenced by the RDMA mid-layer.
> >>>
> >>> o IPv6 support was added.
> >>>
> >>> o For compatibility with Chelsio iWarp hardware, the RX
> >>>   path was slightly reworked. It now allows packet intersection
> >>>   between tagged and untagged RDMAP operations. While not
> >>>   a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
> >>>   may intersect an ongoing outbound (large) tagged message, such
> >>>   as an multisegment RDMA Read Response with sending an untagged
> >>>   message, such as an RDMA Send frame. This behavior was only
> >>>   detected in an NVMeF setup, where siw was used at target side,
> >>>   and RDMA hardware at client side (during file write). siw now
> >>>   implements two input paths for tagged and untagged messages each,
> >>>   and allows the intersected placement of both messages.
> >>>
> >>> o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
> >>>
> >>> Many thanks for reviewing and testing the driver, especially to
> >>> Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
> >>> significantly improve the siw driver over the last year. It is
> >>> very much appreciated.
> >>>
> >>> Many thanks!
> >>> Bernard.
> >>>
> >>> Bernard Metzler (12):
> >>>   iWarp wire packet format
> >>>   SIW main include file
> >>>   SIW network and RDMA core interface
> >>>   SIW connection management
> >>>   SIW application interface
> >>>   SIW application buffer management
> >>>   SIW queue pair methods
> >>>   SIW transmit path
> >>>   SIW receive path
> >>>   SIW completion queue methods
> >>>   SIW debugging
> >>>   SIW addition to kernel build environment
> >>>
> >>> MAINTAINERS                              |    7 +
> >>> drivers/infiniband/Kconfig               |    1 +
> >>> drivers/infiniband/sw/Makefile           |    1 +
> >>> drivers/infiniband/sw/siw/Kconfig        |   17 +
> >>> drivers/infiniband/sw/siw/Makefile       |   12 +
> >>> drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
> >>> drivers/infiniband/sw/siw/siw.h          |  720 ++++++++
> >>> drivers/infiniband/sw/siw/siw_cm.c       | 2109
> >>> ++++++++++++++++++++++
> >>> drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
> >>> drivers/infiniband/sw/siw/siw_cq.c       |  109 ++
> >>> drivers/infiniband/sw/siw/siw_debug.c    |  102 ++
> >>> drivers/infiniband/sw/siw/siw_debug.h    |   35 +
> >>> drivers/infiniband/sw/siw/siw_main.c     |  701 +++++++
> >>> drivers/infiniband/sw/siw/siw_mem.c      |  462 +++++
> >>> drivers/infiniband/sw/siw/siw_mem.h      |   74 +
> >>> drivers/infiniband/sw/siw/siw_qp.c       | 1345 ++++++++++++++
> >>> drivers/infiniband/sw/siw/siw_qp_rx.c    | 1537 ++++++++++++++++
> >>> drivers/infiniband/sw/siw/siw_qp_tx.c    | 1276 +++++++++++++
> >>> drivers/infiniband/sw/siw/siw_verbs.c    | 1778 ++++++++++++++++++
> >>> drivers/infiniband/sw/siw/siw_verbs.h    |  102 ++
> >>> include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
> >>> include/uapi/rdma/siw-abi.h              |  186 ++
> >>> 22 files changed, 11088 insertions(+)
> >>> create mode 100644 drivers/infiniband/sw/siw/Kconfig
> >>> create mode 100644 drivers/infiniband/sw/siw/Makefile
> >>> create mode 100644 drivers/infiniband/sw/siw/iwarp.h
> >>> create mode 100644 drivers/infiniband/sw/siw/siw.h
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_main.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
> >>> create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
> >>> create mode 100644 include/uapi/rdma/siw-abi.h
> >>>
> >>> --
> >>> 2.17.2
> >>>
> >>>
> >>
> >> Hi Jason, Leon, Steve, @all,
> >>
> >> What's next for getting siw merged? Please help me to
> >> keep the ball rolling. I am currently running out of
> >> issues I shall fix (which is not a bad feeling though ;)).
> >> I see lots of other demanding stuff is going on
> >> these days...
> >
> > Generally speaking, I think that it is ready to be merged.
> >
> > If Jason/Doug doesn't merge this merge before next week,
> > I'll take an extra look and add my ROBs next week, but it is
> > definitely not a blocker for acceptance.
> >
>
> Agree. I think this looks pretty good.
>
> -Denny

Ditto.

Steve.
