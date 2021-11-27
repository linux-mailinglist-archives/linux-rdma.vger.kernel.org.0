Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB15045FEDF
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Nov 2021 14:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351300AbhK0Npi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Nov 2021 08:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhK0Nni (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Nov 2021 08:43:38 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34398C06173E
        for <linux-rdma@vger.kernel.org>; Sat, 27 Nov 2021 05:40:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 14so14894443ioe.2
        for <linux-rdma@vger.kernel.org>; Sat, 27 Nov 2021 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=pAk1TP9fOrGOonsoRH4nSjoD6pOV/b1FqN+da3AqBqk=;
        b=ibLv/XaSsqfTW3f6aFIXN5xZVzYz7AzhRaoLoOGsHFBdOR+hl4qi0iccdhYG9v5Hbr
         c1nQUTCGts8iw9I0f7agQWlwHKPL91qRigHRrfl6znNOCGxhDHzznio8RlRvwYJEYkey
         jjsT/dTVpzIqA8wKnFAydvFBdugnwT85vJpO/9Yx4rF8VLAzo0Y+lh+dFozqxawnu+xd
         1F2iSn8dzH8wKrZzERy405GS8Pui5XivUb2WhE5FJqU5bftUfW0L+qUTW6LJ1bslTr1S
         i/as6FZmyUQzFu0AF5+xwiXW3k55Cl5vuPpweqg/CAMq9bjOAsi7NkzC6A4HoBjZQeRv
         Taxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=pAk1TP9fOrGOonsoRH4nSjoD6pOV/b1FqN+da3AqBqk=;
        b=3cIfQkcU/k00+RMP2C6CFEKObVwTotyRlkeN6I5+2IiJSa8Rlmtk2p2FqnlmWDfrmg
         LHy/mU4kET+TiOPgWtlnprrXRTyEShcXf/iDtZItId606SFUSslz5IzkJmwb9upoT25W
         jvNXPoFxTg9EIA6QMuFPFYVFHc6GXZOW+58zI4ovcQRY7fHvlVaOn1xhmyV4xCxztUCl
         meTs5nUW8LJWvYHsmFQHBbp5i2qOKvI8SvbAUx8YEMngkwo6did0kQDCsHafauBk/Oxl
         4ZIHnySyBqO8bJ682O4YL4KXgniJjSKxubfDMX7+3mWy1TZbkGBAs2FdPwOfUzmveO8b
         kdiw==
X-Gm-Message-State: AOAM5324/mj1Fe7a4R5nzA2e8d2Po+7Iq1p5XHgFnbDlVy6n6SsT/GMH
        SytfphP42WtUm4bknTL22lCPUw==
X-Google-Smtp-Source: ABdhPJxj8LyRJoYC/2UaHln5kGew89xFSBNPBZbid2TJqWausDUKj9kqSjMQm4MWMo7uQeoIsO4o1w==
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr47351019iow.56.1638020423493;
        Sat, 27 Nov 2021 05:40:23 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s9sm5090151iow.48.2021.11.27.05.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 05:40:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, linux-rdma@vger.kernel.org,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
Subject: Re: cleanup I/O context handling
Message-Id: <163802042046.623756.9169975969414207413.b4-ty@kernel.dk>
Date:   Sat, 27 Nov 2021 06:40:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 26 Nov 2021 12:58:03 +0100, Christoph Hellwig wrote:
> this series does a little spring cleaning of the I/O context handling/
> 
> Subject:
>  block/bfq-iosched.c                   |   41 ++++++------
>  block/blk-ioc.c                       |  115 +++++++++++++++++++++++++---------
>  block/blk-mq-sched.c                  |   35 ----------
>  block/blk-mq-sched.h                  |    3
>  block/blk-mq.c                        |   14 ----
>  block/blk.h                           |    8 --
>  drivers/infiniband/hw/qib/qib_verbs.c |    4 -
>  include/linux/iocontext.h             |   40 +++--------
>  kernel/fork.c                         |   26 -------
>  9 files changed, 128 insertions(+), 158 deletions(-)
> 
> [...]

Applied, thanks!

[01/14] RDMA/qib: rename copy_io to qib_copy_io
        commit: aa6c81e0dbe5ed782cc4cdb9274eaf1e14c07983
[02/14] fork: move copy_io to block/blk-ioc.c
        commit: 8a8d3786e0ea1793eca69d1e071141bff16d55d7
[03/14] bfq: simplify bfq_bic_lookup
        commit: 91d84d8eef716bfba98263493945897beff5e26a
[04/14] bfq: use bfq_bic_lookup in bfq_limit_depth
        commit: 4d6d46def2117d08edf72b080e768da8e3d36fe8
[05/14] Revert "block: Provide blk_mq_sched_get_icq()"
        commit: b2b522fb21b1a3dd10a1419884562114ab653bec
[06/14] block: mark put_io_context_active static
        commit: 6b939dcfa41384d18478ec34083ed64b3c485876
[07/14] block: move blk_mq_sched_assign_ioc to blk-ioc.c
        commit: 0afb8931998dad3d4ed125684e2dc74fca7b1714
[08/14] block: move the remaining elv.icq handling to the I/O scheduler
        commit: f390716138b4c5c32b883a047f9a1f38ef5b8c0f
[09/14] block: remove get_io_context_active
        commit: b9e117800715bad4920bc8ab8b286ffdedb22979
[10/14] block: factor out a alloc_io_context helper
        commit: a3335d4269a799c85395cb1a0712dd54b54f6497
[11/14] block: use alloc_io_context in __copy_io
        commit: 6767435a95a26560c2460e43aa26d00fb5b50e71
[12/14] block: return the io_context from create_task_io_context
        commit: af04d9b6c9037c4ff4312a8e1e58fd96a05c3ca5
[13/14] block: simplify ioc_create_icq
        commit: 22e0aa975c1fc52e05d9e9aa637e4833370eefb6
[14/14] block: simplify ioc_lookup_icq
        commit: c3ad7dd4999b6f4603dcdbbea0b7860c9c02bd86

Best regards,
-- 
Jens Axboe


