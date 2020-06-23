Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983702067B5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbgFWWwY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 18:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgFWWwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 18:52:20 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1245C061755
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 15:30:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e13so87839qkg.5
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=eaPZgevT2CpnMUUM+GmJp3ep826/Vu8USLaTW1XXGMw=;
        b=QWQq5RDGTnwX3WnqevkbBWkazZh8odQfl932pZ3UbY0dCGQegngCVgx95WkZVr6BnO
         65ZIHrqmao0uN6GenF/4y4CW/OcmRkJXPzNKvRDmcXb7ZC7erhMA93XdDlwZ6l3vBF1f
         GxHnbtJycGks7s5BOlmqFZKUgWd+grPqJxni7VbGgMA8zUApStYLutkeT0rlrIBOHI08
         3Cql55Igvie4tl+36H8VyJCyQqgV0RR76/eI9IGW+so79IAWGhwE2UWaR81yETHij9Y+
         SmTPqigtUan78yqLcCU63BGCxEuDALLbhJ89gWLbCtwqVG4DBdoucn263Wyo8rE2fDql
         8TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=eaPZgevT2CpnMUUM+GmJp3ep826/Vu8USLaTW1XXGMw=;
        b=sDEptMViVUh6vGJDVklhnblY9FutQwesmsgWX5u/CqLUjMSvdE9dQIIi7QUnP0LR2b
         NWXfMd+HeBXka5wco36Y43joZYaF71Hd+wwLSycg7fWf2figRKqe51GKQtx1nZoo18zp
         nIFexdxQ61SAOQ/thq/GQ0XWN6mCiPN9LgCV/CwxTW+/GQX+8ITCxaccTwl7s6dx2DCo
         zvQIXDaJknAcIY5XuB3mZgroqAiSUS2+U+uyy3u9t1tAu5b/3HPjFGaFU0EElRqtiwtl
         gaUwkjptLOeToP9rEYaX2zxXJg2MqpLiH3L/gqqhkVx/6XA9QaGAaZgTb+sRqSZtGEJf
         d7FQ==
X-Gm-Message-State: AOAM531h5ul8wPO7vmLS0+3XJn90b4ImRsM4iVrzEd8XXB1Hhf/F2KiB
        IdV+DHu3sfX0cRR0xWnXnQzN5w==
X-Google-Smtp-Source: ABdhPJwk15aS1BWBT2iEbMasfTOJdZ8L9kYNLCwIeSkqEjFH3YWtkSFhBbq1XdpbSIFrixrWCXSxpg==
X-Received: by 2002:a37:5ac1:: with SMTP id o184mr6623255qkb.498.1592951401983;
        Tue, 23 Jun 2020 15:30:01 -0700 (PDT)
Received: from ?IPv6:2600:1000:b118:1dc0:18a:ef24:8000:54d8? ([2600:1000:b118:1dc0:18a:ef24:8000:54d8])
        by smtp.gmail.com with ESMTPSA id 207sm1764428qki.134.2020.06.23.15.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 15:30:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
Date:   Tue, 23 Jun 2020 18:29:58 -0400
Message-Id: <CBC5DC63-241C-4291-8686-21CF758AC91B@lca.pw>
References: <CAKMK7uH90-k12KMHE0pWN6G_aCTr=YNhQsqoaAJC5FHygnf96g@mail.gmail.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-xfs@vger.kernel.org
In-Reply-To: <CAKMK7uH90-k12KMHE0pWN6G_aCTr=YNhQsqoaAJC5FHygnf96g@mail.gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
X-Mailer: iPhone Mail (17F80)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 23, 2020, at 6:13 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>=20
> Ok I tested this. I can't use your script to repro because
> - I don't have a setup with xfs, and the splat points at an issue in xfs
> - reproducing lockdep splats in shrinker callbacks is always a bit tricky

What=E2=80=99s xfs setup are you talking about? This is simple xfs rootfs an=
d then trigger swapping. Nothing tricky here as it hit on multiple machines w=
ithin a few seconds on linux-next.

> Summary: Everything is working as expected, there's no change in the
> lockdep annotations.
> I really think the problem is that either your testcase doesn't hit
> the issue reliably enough, or that you're not actually testing the
> same kernels and there's some other changes (xfs most likely, but
> really it could be anywhere) which is causing this regression. I'm
> rather convinced now after this test that it's not my stuff.

Well, the memory pressure workloads have been running for years on daily lin=
ux-next builds and never saw this one happened once. Also, the reverting is O=
NLY to revert your patch on the top of linux-next will stop the splat, so th=
ere is no not testing the same kernel at all.=
