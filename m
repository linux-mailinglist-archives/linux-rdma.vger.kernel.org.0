Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681D9100A6F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKRRjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 12:39:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41656 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRjH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 12:39:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id a21so14336859edj.8
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wwy7y1a6q/DuAvJKNf/i3hevC3KWqafGydm34BlW9lE=;
        b=iPNrBghv59Zs8dDX8Xz9bhEBRWgibTBZWXihskroBECqP/sEwdJ6WgRmPmFVDKT0S8
         y2jkd991PONOD9wU8fUMCdZMwJhIHvI/cmQQJT37eN2UgMCfSVjbL5EVkcz1rbcAfxz8
         qfkZGYgdcJ7wv673TYNQfofZYRDGP4zoZadY6Eg5XwxOTMvhvPVqGzYe716AwaNYwWtR
         3j1Q03SmWJ+MhxHwi7MYaosE2D1v6GLGODfgD9GAPI4LmJJyJT5lqU6rFY7sVjvDIq1+
         4OR4wAWEaWw7Tfmx2FblvHroNIxCEHmxj0HtlgmdouzWKMbv1EpWrhwNXoVHe5vs+xQ1
         3DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wwy7y1a6q/DuAvJKNf/i3hevC3KWqafGydm34BlW9lE=;
        b=B/K2Cv/1t31YG3hJKagVyxFN3ZUsgBKhX0qSvP4wxJQLL68v2At15583DAXR43bVRT
         RsvLli5SYCwtuOoka5g0qihaYE9PkomAp4tHcjp/nxZnZpCJCdNJwy7oRmi7oPQ3D12q
         oXmr28NYiMoQysQc8+Ly+n41zaN2X3OrAuwngEy2J0zNke/x99w9GlpGhZdcEbhM43d7
         umZQH70PpcUn+dRkwRmWmjqRriVd/RzzwPrUWTWLCzGECvdlndixu/nh0IADANgJAYKD
         eWLbQG081teRVaaRb3bb5VdiRZL0M3apNlycbHYsHbijctQiHYUSrvVBz9uJXjanSynj
         3TpQ==
X-Gm-Message-State: APjAAAXvdidxBlFAShwW8gu3UTvlV5QL/bg8aVYu9GnAPhmO9PatuTyL
        xOG0vlkrMSRx0Pb2Ujc9GYLJ39PW2tKvTnIHpZVBXQ==
X-Google-Smtp-Source: APXvYqxhqeJRdUmC8N6VoZ8p/rHkoYIm1VNdzTaP9BU/3q7mXDVI7F4KpAAS8GbGgAVSgvqFOqMqz+pAp1Tx2gzpvwI=
X-Received: by 2002:a17:906:7c4e:: with SMTP id g14mr27917513ejp.150.1574098743309;
 Mon, 18 Nov 2019 09:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20191115201225.92888-1-lrizzo@google.com> <20191116.131058.1856199123293908506.davem@davemloft.net>
 <59ebfae8-ac93-75a1-7a60-2bb3820a9a79@mellanox.com> <20191117.102949.1712366954266607838.davem@davemloft.net>
In-Reply-To: <20191117.102949.1712366954266607838.davem@davemloft.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 18 Nov 2019 09:38:52 -0800
Message-ID: <CAMOZA0LWNaK+bwDvUchRdB3enz=Dw4jUDCAY-6e0ty=iT6pytw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx4_en: fix mlx4 ethtool -N insertion
To:     David Miller <davem@davemloft.net>
Cc:     tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 17, 2019 at 10:29 AM David Miller <davem@davemloft.net> wrote:
>
> From: Tariq Toukan <tariqt@mellanox.com>
> Date: Sun, 17 Nov 2019 14:46:50 +0000
>
> >
> >
> > On 11/16/2019 11:10 PM, David Miller wrote:
> >> From: Luigi Rizzo <lrizzo@google.com>
> >> Date: Fri, 15 Nov 2019 12:12:25 -0800
> >>
> >>> ethtool expects ETHTOOL_GRXCLSRLALL to set ethtool_rxnfc->data with the
> >>> total number of entries in the rx classifier table.  Surprisingly, mlx4
> >>> is missing this part (in principle ethtool could still move forward and
> >>> try the insert).
> >>>
> >>> Tested: compiled and run command:
> >>>     phh13:~# ethtool -N eth1 flow-type udp4  queue 4
> >>>     Added rule with ID 255
> >>>
> >>> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> >>> Change-Id: I18a72f08dfcfb6b9f6aa80fbc12d58553e1fda76
> >>
> >> Luigi, _always_ CC: the appropriate maintainer when making changes to the
> >> kernel, as per the top-level MAINTAINERS file.
> >>
> >> Tariq et al., please review.
> >>
> >
> > Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
>
> Applied and queued up for -stable, with Change-Id: removed.


Thank you all, apologies for mistakes.

cheers
luigi
