Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384D6CF9F8
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 06:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjC3EGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC3EGH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 00:06:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F95FF2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 21:06:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r11so17680236wrr.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 21:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680149164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSSt+hVX+54bBi9GuQtKDC85ao+EDjbzwFnipmkh1g4=;
        b=NCERyin3qcssnlhxOxZnQBH8NhgsXCC09X9kTylf0+h3oWPzU6XeUbmKlJArXT5TWY
         BYaogbTGvRO6AiZUXQ51aJ8VONZFglnv9pr/chqbCz4O7pUgyHZb5RmCCFpPm+eqL5un
         nJT1Hsrtk7l6RaUTa/xgshn9E9RSxefrLI/Xbzl/ctybuL3jrpO5Cq8AC21EbKQ1gsAc
         DwnYWHqoi0UCPysBczroGidAQJnK9i1ZmR75ElICOVRPGzbIu0V3wXXFSpditPawu6YX
         WCht32JmD5cGzLsR1LlAHosVmSZRXCCZHIVwMKV0h4OOYU74TPR5jRl6G2XXTE49t+TA
         5YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680149164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSSt+hVX+54bBi9GuQtKDC85ao+EDjbzwFnipmkh1g4=;
        b=EFEjZ9X5Aw4A8ujXVmEZR6KcnG3PoNbBo/NeNzLtmjPexK6YT0DRnTQzJsS68nG98Z
         UpJvc1J/5MNeuJwb4fHcxIo5KEOskjVS8LNV/C0hPlMBl//dkjTR6U5erYsF9KNWuusR
         tzigHHqaOCOgMZMrwa5gHCxlwAowGxgEesj67ynp+8QvB1tbJJetaf25jf96vWoDg2yP
         YN34j7AmNp7vJXI+Z2EMuInB+AiD2vNbkkczlyFTfwWQtVAZvHuCUtyMolVnni21iIEA
         17E8R7fBUtlnhJ5mttIMnJdRz9UeGVj5XoZvIqHvfYjlxZ2inF+7oHmK4Lm+4ecJqfPq
         WWLg==
X-Gm-Message-State: AAQBX9fnj7NuJ0acwVgiGAchI7hjoPAqTxrssu/kR+Srdt70IUnytbnB
        f1xzhgaKOh2Kz1OUIQw9roQ=
X-Google-Smtp-Source: AKy350aTQeWc/K3oIqvmWEmDyGWYmdYxhBE3E7Ed0OcHR83e6PYCHJHG+jV+i2FdXCuny6mtjlg+VQ==
X-Received: by 2002:adf:e110:0:b0:2d4:897:ddc0 with SMTP id t16-20020adfe110000000b002d40897ddc0mr16075225wrz.26.1680149164232;
        Wed, 29 Mar 2023 21:06:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d6b0d000000b002daf0b52598sm18475886wrw.18.2023.03.29.21.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:06:03 -0700 (PDT)
Date:   Thu, 30 Mar 2023 07:06:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Rewrite rxe_task.c
Message-ID: <da41ac58-d058-46a7-9762-b645bfb7e45b@kili.mountain>
References: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
 <8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain>
 <ea0968af-4c12-dbc3-6b5d-67def5e039d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0968af-4c12-dbc3-6b5d-67def5e039d0@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 02:09:17PM -0500, Bob Pearson wrote:
> On 3/29/23 01:48, Dan Carpenter wrote:
> > On Wed, Mar 29, 2023 at 09:27:26AM +0300, Dan Carpenter wrote:
> >> Hello Bob Pearson,
> >>
> >> The patch d94671632572: "RDMA/rxe: Rewrite rxe_task.c" from Mar 4,
> >> 2023, leads to the following Smatch static checker warning:
> >>
> >> 	drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
> >> 	warn: bitwise AND condition is false here
> >>
> >> drivers/infiniband/sw/rxe/rxe_task.c
> >>     20 static bool __reserve_if_idle(struct rxe_task *task)
> >>     21 {
> >>     22         WARN_ON(rxe_read(task->qp) <= 0);
> >>     23 
> >> --> 24         if (task->tasklet.state & TASKLET_STATE_SCHED)
> >>                                          ^^^^^^^^^^^^^^^^^^^
> >> This is zero.  Should the check be == TASKLET_STATE_SCHED?
> >>
> > 
> > The next function as well.
> > 
> > drivers/infiniband/sw/rxe/rxe_task.c:49 __is_done() warn: bitwise AND condition is false here
> > 
> > regards,
> > dan carpenter
> > 
> 
> Good catch. I was trying to open code the test in tasklet_schedule which was
> test_and_set_bit(TASKLET_STATE_SCHED, &t->state). I should have typed
> 
> 	if (task->tasklet.state & (1 << TASKLET_STATE_BIT)) or similar.

Thanks.  I'm sorry, I didn't look at this carefully. I just looked at
the next lines which are talking about a different state.  (My bug
reports are the much lazier option than my patches because it's faster
to be lazy).

Also I'm supposed to have a different check for shifter vs mask bugs
which should have warned about this.  I'll look into that.

regards,
dan carpenter

