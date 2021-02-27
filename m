Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5447326C73
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Feb 2021 10:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhB0JJ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Feb 2021 04:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhB0JGW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Feb 2021 04:06:22 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13BC06174A
        for <linux-rdma@vger.kernel.org>; Sat, 27 Feb 2021 01:05:41 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o3so12468173oic.8
        for <linux-rdma@vger.kernel.org>; Sat, 27 Feb 2021 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmiipWTH25dRNlMeq7Ng6CIYkX+I1tlQg88wzAt+4gE=;
        b=jyn8CsEcVe5jR0A6HkxIaRb8MuP/CG5Cocbs7QS0Xlj5vWz/ezH/EGFsA8+PHBNttv
         Ak4eJ5HX6qaCR2NC5HGNTeIehC82mFXMAtZA8sZPB4JL9IAPfKmxGIhjmHLBpW8yyLEH
         EB8uB5G+c9RopMefFCjXGuAKAN9k2XJGOszMBnurEVtyhvUcz2nEnh2vJqrtNHzTvfXx
         JtCEN4Ldkbu4MeTnjtSuIteGKZdjAeI70LyQejva5d0SecpJD1TgVBtvqxN57GCyvlFj
         aLXZdE2BAxL0vNzGwZspNB0bhGUCr47VO6KIdWakSOiLjAV1eP7toeDelswfy1LCrLSQ
         f1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmiipWTH25dRNlMeq7Ng6CIYkX+I1tlQg88wzAt+4gE=;
        b=HbvqwFEYRLIa7HIwAhD+T0VoyxRjb8Nr09zBuooqaCt1cekDKVW7WbpIsdvQhKXluC
         6LYD40gBNwYK1cr4ABZC+Z98JAwzK4hAQnWk89kmgzdV8kh/U9nWI/Yl7/ExvWcKFlHe
         yqXhQnwR3j/VHVIp8P7xYUQbzsq5D3Pze7fsv6biaduiJA7f8lDamCyWk4UJBS1pz5ER
         OyRGLBPMxmUO5pUPt86bBOHnEudyIl23mWg/ltNYl9xTX0z9bYg65GSRsHFTC2NMevqp
         0SIEa41ngVTA+tZdIybOb8yIIljO2LvjYPFPEbX2BSSAkEU4O/BAgkcNNIpn6rdEQniW
         9gHw==
X-Gm-Message-State: AOAM532CMv2bZrnn2CeQ60vo3lDzaoXjnpFl9OMsJo0SwnU2nQKlhqZA
        NhEe0amTUK5WUvT1NIrjXTw/5Szfg/vAZM4pHU0=
X-Google-Smtp-Source: ABdhPJyezdEDPZaEnB+DjSZ2BqjCrJcBZUo0QBd24RpJxYFeJV+t9S0vSaUuViXgLmE006mvYIfgpzAbrdtrOqkJeLw=
X-Received: by 2002:aca:dcc6:: with SMTP id t189mr4648879oig.163.1614416741158;
 Sat, 27 Feb 2021 01:05:41 -0800 (PST)
MIME-Version: 1.0
References: <1688338252.14107275.1614354083739.JavaMail.zimbra@redhat.com> <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
In-Reply-To: <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 27 Feb 2021 17:05:30 +0800
Message-ID: <CAD=hENfyNMc-wQL5JAX+T3GGaj75mMy8JTpuUrpuqOPY0Gcgfw@mail.gmail.com>
Subject: Re: modprobe rdma_rxe failed when ipv6 disabled
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 26, 2021 at 11:50 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> I found this failure after ipv6 disabled, is that expected?
>
> # modprobe rdma_rxe
> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
>
> # dmesg
> [  596.783484] rdma_rxe: failed to create udp socket. err = -97
> [  596.789144] rdma_rxe: Failed to create IPv6 UDP tunnel

ipv6 in RXE is based on config_ipv6. If config_ipv6 is disabled. rxe
will not implement ipv6 features.
How do you disable ipv6 in your hosts?

Zhu Yanjun

>
> # uname -r
> 5.11.0
>
>
>
> Best Regards,
>   Yi Zhang
>
>
