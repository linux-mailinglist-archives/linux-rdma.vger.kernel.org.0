Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14931656F3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 06:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgBTFaN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 00:30:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46026 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTFaM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 00:30:12 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so3258661ioi.12
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 21:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iG+WDbPU1mgLPUM7UePIq1PIjTADia+CvzdE4QYtm30=;
        b=NThdbNyk5ZXvX/0zd+rhZEpg1BQIqBt7ELDN2BuxwT9OWaCxz+aowPkJZac+zzDV1r
         aV2Rs7sdqqb5KkGtWtXmf/Ouv8GcBZIcHqINGrrqEZ42E9kzVr1cLs0cktioIwx/GFnH
         ikAZIN+tdKG5XPpHugC1eFA8ytdTBA0ygveig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iG+WDbPU1mgLPUM7UePIq1PIjTADia+CvzdE4QYtm30=;
        b=t5THmmJn15Gv88PkPkCAWLNHLqBJ1RhtxigcTsfFiSeILkD4wGe4NnqBYyilrrDp3o
         0xPj+h24ax8Fw3a1rxBcDzmIs4NDLiQWqp4koMrxU5r3omkJNnXeDfU4YuR2F3Nz4e4K
         Je80TVKHBu/6kR0esvaZIIrr5/AaaPujfv0OzsvvsrxorHScve/pPf6ZMfinxkfRD25Y
         sOLm6/VHhuA2YfL7SAWdX8L+01dX2NhouCPOe95NzT9llTyUaji3WsGqX75RZvfyV9po
         4iwSMzhzp3OguE3h7XPd3wlwh/AMApPGELFQMwer/KLXCF5Ti462/ibgyaOHLeXZaxna
         Mnxw==
X-Gm-Message-State: APjAAAWWUEwDsedtwEJnNNw1uddmzmf735XKuaD88ilFc9apU6Zl6U+g
        HJzoH0nJvwK6R5YpWWpq5qPuqbRrdqYQsMyXr4lUr6gQUyU=
X-Google-Smtp-Source: APXvYqxMvx5nwEU/jcvxo3rpqOLSj9oBYMT0cbZcKoBVQtiTcehTlEZAXkum7SxK4Cd3nawv2b9eoTCoLHb673gfLcQ=
X-Received: by 2002:a6b:7113:: with SMTP id q19mr22812363iog.87.1582176611758;
 Wed, 19 Feb 2020 21:30:11 -0800 (PST)
MIME-Version: 1.0
References: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 20 Feb 2020 10:59:36 +0530
Message-ID: <CANjDDBiL+XFmRaKXaS6+ghD=C6Vuxtv2k+rZFWQYxwgK4Evu1Q@mail.gmail.com>
Subject: Re: [PATCH V3 for-next 0/8] Refactor control path of bnxt_re driver
To:     linux-rdma <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 15, 2020 at 10:41 PM Devesh Sharma
<devesh.sharma@broadcom.com> wrote:
>
> This is the first series out of few more forthcoming series to refactor
> Broadcom's RoCE driver. This series contains patches to refactor control
> path. Since this is first series, there may be few code section which may
> look redundant or overkill but those will be taken care in future patch
> series.
>
> These patches apply clean on tip of for-next branch.
> Each patch in this series is tested against user and kernel functionality.
>
> v2->v3
>   -- Rebased the series on tip of for-nxt, linux-5.6-rc1
>
> v1->v2
> patch 0001
>   -- removed unwind logic when qp destroy fails.
>   -- removed atomic dec out of mutex lock
> patch 0003
>   -- saved memset by using default initializer for hwq_attr and sginfo
> patch 0004
>   -- saved memset by using default initializer for rattr.
> patch 0008
>   -- a new patch to remove dev_err/dbg/warn/info from driver.
>
> Devesh Sharma (8):
>   RDMA/bnxt_re: Refactor queue pair creation code
>   RDMA/bnxt_re: Replace chip context structure with pointer
>   RDMA/bnxt_re: Refactor hardware queue memory allocation
>   RDMA/bnxt_re: Refactor net ring allocation function
>   RDMA/bnxt_re: Refactor command queue management code
>   RDMA/bnxt_re: Refactor notification queue management code
>   RDMA/bnxt_re: Refactor doorbell management functions
>   RDMA/bnxt_re: use ibdev based message printing functions
>
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  24 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 900 ++++++++++++++++++-----------
>  drivers/infiniband/hw/bnxt_re/main.c       | 264 +++++----
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 416 ++++++-------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  94 +--
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 467 +++++++++------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  85 +--
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  | 470 +++++++++------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  | 145 ++++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  48 +-
>  10 files changed, 1737 insertions(+), 1176 deletions(-)
>
> --
> 1.8.3.1
Hi Jason,

Could you pull this series, this was rebase since you had faced
merge-conflict after 5.6-rc1 merge. Let me know if yet another respin
is required.
>
