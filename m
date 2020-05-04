Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9261C3D33
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgEDOg1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:36:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728219AbgEDOgZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588602984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12KTn1u1BPBiSOP+XB5+zWFyoy4dG+tBUXAbQoUDDB0=;
        b=AhnS6tCn2QT91IwUo1NTqraJRQmgwTvmS13GdGuPAR2K5jXxkDLCiX5i1wzLxThWbwFrEc
        GzylCkO3QEmMhWW3Z0hpYbK2vZnJJOGx1vsAm8dCFZF4tL1ih20WgNMcJcTECpwFyd6aod
        Ocz3aIKfaXZ/+s44Bh6SyvuzJTl6gV4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-6igEm3MMOkuvbviv2hDx3g-1; Mon, 04 May 2020 10:36:22 -0400
X-MC-Unique: 6igEm3MMOkuvbviv2hDx3g-1
Received: by mail-il1-f200.google.com with SMTP id z5so13971446ilz.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12KTn1u1BPBiSOP+XB5+zWFyoy4dG+tBUXAbQoUDDB0=;
        b=SgBpYo+QAPOJJzmI5qOtHTxcww7sCIKbOpoO+GurpxL+lQ//jr+In0r17oALXqkkFv
         zY0EesxoQlBSAUhDBbRUBr0lWYj4/3pMl5M3pIW3p9JYg1sM1Wx+g10/Kny/Qwecoe1s
         xx0I/+KkM9CCNV12hKjVoYy0FRWspy5//iRASgYUQcYDtKlDb6FFwTyifU/pMK50FOVW
         aMYdw+GFMOte7BPyeJ1Wiq5Ixb3nTSGYIJy8r1cQ2X8JyW+PZ5qS3ybdvPuXxN/ovljO
         wl0nyJCEEdFl0Czwcyd+gTkIGgIWwVPI+Ntvx0a7pS25Qk+R3zBTQM0dMnu9NPEt1dsv
         tBAw==
X-Gm-Message-State: AGi0PuabGi8OdFZ9pkcuHONZL5rQv3CDQUEmH4ln/LRgtNoER1V/S9jp
        vTGxwLED86q3Iz9AE6j2aGPs8kaWHmkNGf6PisW6rcJV+TAAVghJmnHM09b6Ti+MT7CSd+TyTmX
        c3dtrPebkHydxsLiocqdTk7BH0IdF0CBpqraT3A==
X-Received: by 2002:a92:cd44:: with SMTP id v4mr16859999ilq.192.1588602981967;
        Mon, 04 May 2020 07:36:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypI5XV75TuxwAST4nK4KlQkBMPb5NCoCUzF1L3AJqCr9DAFJ5jJxnday5JG+fb+zGKLnh0bOVJjQe9ReHA2N5ts=
X-Received: by 2002:a92:cd44:: with SMTP id v4mr16859965ilq.192.1588602981673;
 Mon, 04 May 2020 07:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200430185033.11476-1-maorg@mellanox.com>
In-Reply-To: <20200430185033.11476-1-maorg@mellanox.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Mon, 4 May 2020 10:36:11 -0400
Message-ID: <CAKfmpSdchyUZT5S7k07tDzwraiePsgRBvGe=SaaHvvm83bbBhg@mail.gmail.com>
Subject: Re: [PATCH V7 mlx5-next 00/16] Add support to get xmit slave
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>, jgg@mellanox.com,
        Doug Ledford <dledford@redhat.com>, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, kuba@kernel.org,
        jiri@mellanox.com, dsahern@kernel.org, leonro@mellanox.com,
        saeedm@mellanox.com, linux-rdma@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, alexr@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 30, 2020 at 2:50 PM Maor Gottlieb <maorg@mellanox.com> wrote:
>
> Hi Dave,
>
> This series is a combination of netdev and RDMA, so in order to avoid
> conflicts, we would like to ask you to route this series through
> mlx5-next shared branch. It is based on v5.7-rc2 tag.
>
> ---------------------------------------------------------------------
>
> The following series adds support to get the LAG master xmit slave by
> introducing new .ndo - ndo_get_xmit_slave. Every LAG module can
> implement it and it first implemented in the bond driver.
> This is follow-up to the RFC discussion [1].
>
> The main motivation for doing this is for drivers that offload part
> of the LAG functionality. For example, Mellanox Connect-X hardware
> implements RoCE LAG which selects the TX affinity when the resources
> are created and port is remapped when it goes down.
>
> The first part of this patchset introduces the new .ndo and add the
> support to the bonding module.
>
> The second part adds support to get the RoCE LAG xmit slave by building
> skb of the RoCE packet based on the AH attributes and call to the new
> .ndo.
>
> The third part change the mlx5 driver driver to set the QP's affinity
> port according to the slave which found by the .ndo.

At a glance, I'm not sure why all the "get the xmit slave" functions
are being passed an skb. None of them should be manipulating the skb,
that should all be done in the respective xmit functions after the
slave has been returned.

--
Jarod Wilson
jarod@redhat.com

