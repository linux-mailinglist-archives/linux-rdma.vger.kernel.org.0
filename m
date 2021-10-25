Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5043A578
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhJYVKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 17:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhJYVKF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 17:10:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BFC061220
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 14:07:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l203so7421486pfd.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQztyN+OyqV2EYalpv3OnHEA+p7UGY3ffgQzpyFstrQ=;
        b=jPJwfXXczwHre/rQIPjK/VoVvO0IuwfH8WIMj2xxEOvALb2VPbYxNoqprq0OQR5nPC
         o5DyFtXCsBA94PwIkmXaD6fOOn6uzE1vuL8iTIZvpeFHN0NIs19av/f8DymXuOBARNDi
         6wKlBs2WwIj2FcUduika3D+VnZO1ueK9qaM2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQztyN+OyqV2EYalpv3OnHEA+p7UGY3ffgQzpyFstrQ=;
        b=5eyHq6VdYgKsZmj4XvdHgQWmdlzoLs9pGwMO2H4XeI5BaFATzchPEYnuevv/dFF3NE
         Emv1IOoMYJNMCjfU6GX/mklFjYAYRSeXD9xtpYESMhOzaAOuwrX9piLuuM54k8rwOoiY
         nsVh2Ym9bhjYnR7U8yE/b2p3zxGdtpaXCKINaNKRyyD+Rbk2e3lTLCdatK+IJ1IXUnzC
         Y3f0q5HxOCCJKlhWPJ2ZscoK5sdGztKKC1JJZHu+tNkV8gd2SlOrecJ4pEzgfX2HO48G
         +3YzdHlWOPSei9lFjidaadN2hboKNkGM9DQShY33gJuk53VK0LFcylRCl3PEtd/jhJ9b
         1t4Q==
X-Gm-Message-State: AOAM531uTzQilztW92+fz9j7f/n6B70Kwgikefs6sODJxSJOsZo4F5fa
        mE3viSgzm5YvDQiEo8tQlIvGxQ==
X-Google-Smtp-Source: ABdhPJz7CAVtw2oosUMB+o1UYU5LoroOh/r74Itpx8yjnMxuz2AoHAAIFbT9kzmQ6NZ1Nt3CdMAZTQ==
X-Received: by 2002:a05:6a00:bc1:b0:47b:f093:eb4e with SMTP id x1-20020a056a000bc100b0047bf093eb4emr8462611pfu.55.1635196062554;
        Mon, 25 Oct 2021 14:07:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj5sm8917184pjb.45.2021.10.25.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:07:42 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:07:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 01/12] fs/exec: make __set_task_comm always set a nul
 ternimated string
Message-ID: <202110251407.6FD1411ECB@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-2-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:04AM +0000, Yafang Shao wrote:
> Make sure the string set to task comm is always nul ternimated.

typo nit: "terminated"

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
