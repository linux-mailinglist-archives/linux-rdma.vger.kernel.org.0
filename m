Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D305C5F9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 01:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGAXqn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 19:46:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40442 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGAXqm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jul 2019 19:46:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so14980336ljh.7
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jul 2019 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRqDKrW3IPavUWp1F9Nqj698h13KeKAId+GIMKLYSdY=;
        b=FJQreLHAlWPp1grBA6lKU8XTQ2pihXY0G90YVw1q+EUg63+ET8xHn74vw4qLIQJEKj
         TySXsT0QRjj7tsvwPN4d83lOYVZKAe3QzeaexJgxxivYXmuv+QjxEm8p2KBKcxJXy1AX
         EYmX57+gt7YhdKgr7upMJ3vgM+IwmjaCMOgXo6LLypui2xXt1Ssd7MADXGvwz6Sr8ohY
         tJhNhS62DvMfKVwSHhpiBq5pKJhC07T+o1g+ebda5QcL7qGe/wvOGWu/P11Ixh8TuJLR
         Ov4aeyXAW206/Qu2Y9T3PCrL2KydRQ3Jn2QiVsLXEFDYuHc9m3y3JL0OWcWdegWiMQ6Q
         CBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRqDKrW3IPavUWp1F9Nqj698h13KeKAId+GIMKLYSdY=;
        b=gjLQeq1mpikwjRGKNV0FbKRYLPrErTt+w5+uGz4ZETgauhAC2vXnpLR9ot0pasFyL9
         m8upLhLShbDVb3SWRgtoxYG/Rw59qkl02ePXZw87b9hPaNv4FLdE7kxuq5WMCt413Gd4
         mWEyOliI8fLyniJovDE+E/iQeTjD6VbIjern04kOT/E1r4N6xksi4xvwl5QK5pgr7ACk
         kB5uqq/qSaDmNzz6wTDFvyDUsU1bE76CfnlSv4gMlg0tLRc2hZXKC+lNkD+y6Ia+2NiN
         IQeVzZiRo/Yl2nP9WKH9FARVxU4P3kVYimX42pnU2XP7S7OBdvyBbOZ8F+t7oXwT1sK4
         ZN3Q==
X-Gm-Message-State: APjAAAWPJFIPy0wq+BVLeWlmiE3o9EasApoa1SyGbGZeAIpkhr/cPM59
        QUIqVS+zf8R+DXC1cJpR2Hmdu9NPMdBzJ3jbBobCaA==
X-Google-Smtp-Source: APXvYqzFrIplv3BW0HA02fmm2tSKYl4pdMS2Y/sZwRN4bqZbW/iIteW1OVWe4r7jHlJnHl0Wuf3s3QzsuUl3RhQK7y4=
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr15867633ljq.128.1562024800727;
 Mon, 01 Jul 2019 16:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190628223516.9368-1-saeedm@mellanox.com>
In-Reply-To: <20190628223516.9368-1-saeedm@mellanox.com>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Mon, 1 Jul 2019 16:46:29 -0700
Message-ID: <CALzJLG-LEPqr3kDTYRKq8V-URsdTS2F87mV_qO9HaCX6CY7VZQ@mail.gmail.com>
Subject: Re: [PATCH mlx5-next 00/18] Mellanox, mlx5 E-Switch and low level updates
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 3:35 PM Saeed Mahameed <saeedm@mellanox.com> wrote:
>
> Hi All,
>
> This series includes some low level updates mainly in the E-Switch
> netdev and rdma vport representors areas.
>
> From Parav and Huy:
>  1) Added hardware bits and structures definitions for sub-functions
>  2) Small code cleanup and improvement for PF pci driver.
>
> From Bodong:
>  3) Use the correct name semantics of vport index and vport number
>  4) Cleanup the rep and netdev reference when unloading IB rep.
>  5) Bluefield (ECPF) updates and refactoring for better E-Switch
>     management on ECPF embedded CPU NIC:
>     5.1) Consolidate querying eswitch number of VFs
>     5.2) Register event handler at the correct E-Switch init stage
>     5.3) Setup PF's inline mode and vlan pop when the ECPF is the
>          E-Swtich manager ( the host PF is basically a VF ).
>     5.4) Handle Vport UC address changes in switchdev mode.
>
> From Shay:
>  6) Add support for MCQI and MCQS hardware registers.
>
> In case of no objections these patches will be applied to mlx5-next and
> will be sent later as pull request to both rdma-next and net-next trees.

Applied to mlx5-next,

Thanks!
