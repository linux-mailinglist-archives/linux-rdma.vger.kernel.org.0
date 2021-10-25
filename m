Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF0439EFF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhJYTML (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhJYTMK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 15:12:10 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35956C061745
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 12:09:48 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id b4so12125162uaq.9
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9aBpFiXUbLE14Hje/QSNEuf2uHRMfgV6rKFa+Ssn4E=;
        b=ZO1K1TilM0AuhaxxV2iiy8/F88Kkzqcyc6o1tngHjP1nHGuZxYFeOLCCt/7ieu63vc
         5ED+MjX32WTGFih55NDaf5ob+RqxKNNP44E4IzczXZ523CYaxfEiuYpmeEfUztAKX46B
         +5WtdBFyqX8mXpitw7YiCRAuSw3DjsJyXeR6wj7+Gnstcvcc8StJslYxfvarL8I75t4D
         /a/zNrfSMqaiDs1DqPRI3buRCScrAPiUH4tMVUAa6emO+N44ds/CasqGy/o6fApTMHtZ
         7GhzfcVIS6R5LZ0+9yjFi6cLnscNpR87myhs9jONTTbp5fIfO5RNV0Muk7p2d1U5flJ+
         QUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9aBpFiXUbLE14Hje/QSNEuf2uHRMfgV6rKFa+Ssn4E=;
        b=cTq64GLxxnjo2ZFWoCu1/MKBei+FUrEmu629EBFenn1SGQvxOD5OyKtpGMTV72mahB
         Uy+OI0kBhoLD18jUwD/6w4R1YPUu5z1vlrwfRTewt8AZ60MEUP6LFAtFpLF8czp55iDe
         Sn3r3//CDDlC2UiWIYe9GJ6dP3yhpUJMeGpWYJm7NdXOK71b1G2wDX0KP3VHhaPVG+/R
         s1ZU9FLdaTHpqb7V7Z1R3u0nprB4K2b69tpIHzDsdJ1fKoFlDBtxPbi9+wCL6aT/1J4i
         tbKV8Qu0qK8Bw1LDbu1Wsh0lYW4P54Ib+YmQ2VeArs1MEtKdxsAhkYgZ1TN1zG0JNDDR
         n5Bg==
X-Gm-Message-State: AOAM532rje3ssAPxsPPcVp65hnq+gDulCHoTf6sOGYN3b7cnd+Q5AXnE
        eogTilC1gARCrGx01qBKWjdL0O+Usr2V6Vn8/86rZY6c
X-Google-Smtp-Source: ABdhPJwSmErXsEa0t7UjIpACQNGOuiHDUin4znd8RV16A/7RdPc+OlkKlGOacceJsQR7Uz+wbZjSDgCqY1aEwjbuPtw=
X-Received: by 2002:a05:6102:3712:: with SMTP id s18mr16668674vst.43.1635188987364;
 Mon, 25 Oct 2021 12:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211022191824.18307-1-rpearsonhpe@gmail.com> <20211022191824.18307-2-rpearsonhpe@gmail.com>
 <20211025175540.GA433125@nvidia.com>
In-Reply-To: <20211025175540.GA433125@nvidia.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Mon, 25 Oct 2021 14:09:36 -0500
Message-ID: <CAFc_bgYLp9dF+60w4pe9Pph2N20N+bx_ChsVsMPy+ynkWC3bxw@mail.gmail.com>
Subject: Re: [PATCH for-next v3 01/10] RDMA/rxe: Make rxe_alloc() take pool lock
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here (not related to the mcast issue) I am guilty of hiding my plans.
A little later I was going to move creating the metadata (RB tree and
index table) into the lock and then later after converting to xarrays
replace the lock with the xa_lock which you have to have anyway
because it's part of xa_alloc().
As you point out it is the index/key tree change that is visible to
everyone. The races here are in trying to get the index or change the
RB tree. Perhaps I should merge this change with the later one where I
get rid of add/drop_index(). Or, rearrange things and convert to
xarrays and then worry about races.
