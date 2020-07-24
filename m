Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84122C748
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXOEI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXOEH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 10:04:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78EC0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:04:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so5273720pje.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AumJku5mcZ/Rq/5BxLKNESx5aO3qoxwojN7ONDDAbDY=;
        b=TFEVryem3XPKwqBbyepWH433FI+5aCRAhpLBGqHqCpIadXaYX7NIT86SQ3qeRr2JMQ
         rrEn6nDAjkZMr3yaIFuMRuYjCNKbkaOBLzfvK5pGeBaLKRc2Ru5RqEsw3qkz2A9eWkGs
         UaTIcxTraDDBfIWoHjlZ1/aWcvqwZgQkfKlFRQQlBzol9rgRuDNOlRnCXBi2dugciCE0
         JoKRSlkL+dwmCsC3+jKxjEk92doAD3Js//+y2awzL4MMB3zYd9YX0a7qd1tsK3keY55s
         O3r3cvp8ddd7rJa4pDAlWPdQELIroQjDK6XKMdb9/L/2g8RO8kvS2cdkT5g54rSN0E/V
         kdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AumJku5mcZ/Rq/5BxLKNESx5aO3qoxwojN7ONDDAbDY=;
        b=J/9PgixbFJp9y+yM/XirQDIJdCDJsRW9ykck5ahWGX+XoG1FCniCfOmQL7UrjpHAlq
         L4zUoXowHP/yvflNYZNc8nDdraqekLqTIUfZ82m7n8+cukDwIPHSFl3iJVc5oMtXPoKq
         KqXgLKL7hinyBUhvkX6/pMZqjc/6tiTyoJKIPFqkDeIPM3RfG7GVAbMkDcw7qNOh97dS
         Ss/ogEI+D7KRPPNtexKIO8c2qUdUkpVWSuzsiAiixEdIAc36VGd+/V/MOLDSCfLQB0C4
         CwvRfpSnj3p1cx7cKDmtEW2ng0xRQ/wL/nK1ea/5+HNt96xPqRGFjfl87zgdsNZNc6I9
         KUCg==
X-Gm-Message-State: AOAM530NQKx6q0Qm0zMmHI1OKooU7PAcTZRYd0rWiaJ+jm2Rp9SobiwY
        /bwy0sAhKY2BgVO53scv/CqSwQ==
X-Google-Smtp-Source: ABdhPJwQpBfn2RcJFoF86XoagpskOIpTEAlcXpQEqf55M8K2znE44A3T73GzI52vu7iptTEN1D004Q==
X-Received: by 2002:a17:902:e901:: with SMTP id k1mr8705116pld.130.1595599446089;
        Fri, 24 Jul 2020 07:04:06 -0700 (PDT)
Received: from [10.86.108.142] ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id g18sm6470227pfi.141.2020.07.24.07.04.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:04:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [External] [PATCH] RDMA/rxe: fix retry forever when rnr_retry >=
 7
From:   =?utf-8?B?5p2o5biG?= <yangfan.fan@bytedance.com>
In-Reply-To: <CAD=hENdG_0hdcRQk+sH6HyuOROM-U9_n2QahipgmOdESQDso3g@mail.gmail.com>
Date:   Fri, 24 Jul 2020 22:04:01 +0800
Cc:     Zhu Yanjun <yanjunz@mellanox.com>, linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <827596D2-8EB2-4660-9118-70289FCD09AA@bytedance.com>
References: <D1A472F9-6618-41A2-9CA8-B5231BD03D63@bytedance.com>
 <CAD=hENdG_0hdcRQk+sH6HyuOROM-U9_n2QahipgmOdESQDso3g@mail.gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>=20
> Please read the following from IB specification
>=20

Oh I see, I missed that part.  Thanks for your explanation.


> An exception to
> the following is if the RNR NAK retry counter is set to 7. This value =
indicates
> infinite retry and the counter is not decremented.

I wonder what if the user set RNR retry larger than 7?  Say the user set =
the RNR
retry attribute to 10, is he expecting a 10-time retry or an infinite =
retry?  In
the current implementation, any larger-than-7 retry count causes =
infinite retry.
Is this an expected behavior?

Regards,
Fan=
