Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630616CF2DD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjC2TRH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC2TRH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B7CD
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D2161E05
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 19:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB0C433EF;
        Wed, 29 Mar 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680117425;
        bh=CJSEPRZysOv72nhDYPP3nqUg5+8nw5Kd7Arqzgm8N+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWnY2uJ9rBcSjbiXHRaa4Y8gnAg/8e8GxMeMPsPElEjoM8oeF3G5Jb1askQtsy/gS
         vHujrdm3ZOkmSc515K8uChJj0PaRSI4XVaa72OSmw+LHTry+VEehRAwXYfCKJDiU0u
         fZRKHzrc8c0kcndihP9+xUYtde94xmySHdyetppwzQjrtuTtPICikv6YQo+1yu6D/C
         8hGmsZFSYPokoJsoVJ+dYa2VMNojPVrqVa0f1qCgQ81axmx6h5imHdZh2tcmdQpPBJ
         YMOQ8alkaRv9oHnrTnMDjkst3vuaddxHRfXQLLU5xsCqaU2RpWMcRGemL5z9RpRx0w
         X78B3TGstzozg==
Date:   Wed, 29 Mar 2023 22:17:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Rewrite rxe_task.c
Message-ID: <20230329191701.GG831478@unreal>
References: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
 <8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain>
 <ea0968af-4c12-dbc3-6b5d-67def5e039d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0968af-4c12-dbc3-6b5d-67def5e039d0@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

What is wrong with test_bit(TASKLET_STATE_SCHED, &task->tasklet.state)?

Thanks

> 
> Thanks,
> 
> Bob
