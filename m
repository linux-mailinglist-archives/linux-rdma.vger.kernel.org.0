Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2720466FEE
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfGLNWw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 09:22:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfGLNWw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 09:22:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so7972450qtn.13;
        Fri, 12 Jul 2019 06:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bE2d2cXyqgLyrO8VmhXW/kKIw4VfQcn7GpyB/RWoC8w=;
        b=NGDHTHEmJRMboR2QtK5kYUsDef2jh4okd3TfEaf5av5rxTE2SHr5mcsAjL/dEg1HY8
         FzatakkgNFs8XOad7xYOy8Xl6CNV1f4fniAkVVzeNXSd/9M8Zd3N7lpx2WbtE/fWLucB
         MV4r3G9N5tZncxeN7kBr87ffT1wrN1iUbyTQ29EpkHe83HsDiJJwBFSlNz5f1QD4oKfW
         GalNzEX1Gsr0wDbyn+dcYYh7+yQhQrpdvdZ3mHh17moRVG0nYPDJlgBqZJNQ5/4WEsLh
         kkK89p8h6nWHmftPtxrtGTgUInFrt55OumzcqMjAPKnkGHxkack2VOalBh7m++YTTYS+
         XsCw==
X-Gm-Message-State: APjAAAU8WKBW28ehdW/2OTqEZVSuNc6vEkoEUwnVrZ9Mxw3EAHvc24KT
        WOTw6y19XmEZG1qXJizigzWHrAZgVOc78pJIDKY=
X-Google-Smtp-Source: APXvYqyzTHki3UBu9mLY67hzCMpVjSvF8Z9ye3UK/cdcvDq3NdMyliDIylHyQBvW4LN/O15Ve6eLBlrIpPXP1Z1fezw=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr6408317qtf.204.1562937771266;
 Fri, 12 Jul 2019 06:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190712085212.3901785-1-arnd@arndb.de> <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <20190712120328.GB27512@ziepe.ca> <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
In-Reply-To: <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 15:22:35 +0200
Message-ID: <CAK8P3a3ZqY_qLSN1gw12EvzLS49RAnmG4nT9=N+Qj9XngQd0CA@mail.gmail.com>
Subject: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 3:05 PM Bernard Metzler <BMT@zurich.ibm.com> wrote:

>
> We share CQ (completion queue) notification flags between application
> (which may be user land) and producer (kernel QP's (queue pairs)).
> Those flags can be written by both application and QP's. The application
> writes those flags to let the driver know if it shall inform about new
> work completions. It can write those flags at any time.
> Only a kernel producer reads those flags to decide if
> the CQ notification handler shall be kicked, if a new CQ element gets
> added to the CQ. When kicking the completion handler, the driver resets the
> notification flag, which must get re-armed by the application.
>
> We use READ_ONCE() and WRITE_ONCE(), since the flags are potentially
> shared (mmap'd) between user and kernel land.
>
> siw_req_notify_cq() is being called only by kernel consumers to change
> (write) the CQ notification state. We use smp_store_mb() to make sure
> the new value becomes visible to all kernel producers (QP's) asap.
>
>
> From cfb861a09dcfb24a98ba0f1e26bdaa1529d1b006 Mon Sep 17 00:00:00 2001
> From: Bernard Metzler <bmt@zurich.ibm.com>
> Date: Fri, 12 Jul 2019 13:19:27 +0200
> Subject: [PATCH] Make shared CQ notification flags 32bit to respect 32bit
>  architectures
>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

This fixes the build for me, thanks!

Tested-by: Arnd Bergmann <arnd@arndb.de>
