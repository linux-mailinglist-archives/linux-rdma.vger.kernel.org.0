Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE686161F9
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 12:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKBLp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 07:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKBLpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 07:45:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED82871A;
        Wed,  2 Nov 2022 04:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7764EB821DF;
        Wed,  2 Nov 2022 11:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37ECC433D6;
        Wed,  2 Nov 2022 11:44:58 +0000 (UTC)
Date:   Wed, 2 Nov 2022 07:44:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Leonid Ravich <leonid.ravich@toganetworks.com>
Cc:     "linux-trace-kernel@vger.kernel.org" 
        <IMCEAMAILTO-linux-trace-kernel+40vger+2Ekernel+2Eorg@eurprd02.prod.outlook.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <20221102074457.08f538a8@rorschach.local.home>
In-Reply-To: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2 Nov 2022 10:49:26 +0000
Leonid Ravich <leonid.ravich@toganetworks.com> wrote:

> after investigation  looks like there is a broken assumption of rb_end_commit and rb_start_commit are on same CPU (no migration) during trace 
> looking in ib_mad trace  in include/trace/events/ib_mad.h there is a call to create_mad_addr_info during  TP assign which sleeps (at least under mlx5 ib driver)

Wait, WHAT?

> 
> so the scenario looks :
> 
> rb_start_commit - buffer 0xffffa0984777e400  CPU 1 pid 1368
> switch from 1368 to 1605
> thread 1368 () is migrating from 1 to 0
> rb_end_commit - buffer 0xffffa09847c14a00  CPU 0 pid 1368

That's a MAJOR bug with the use case of tracepoints!

> 
> before starting throwing some patch into the the air  I would like to align with you the approach we should take here. 
> 
> my suggestion here : 
> - ftrace infra should verify no migration happen  (end and start happens on same CPU)  in case not we will  throw warning for the issue  .

The scheduler should have. On entering the ring buffer code
ring_buffer_lock_reserver() it disables preemption and does not
re-enable it until ring_buffer_unlock_commit().

The only way to migrate is if you re-enable preemption. WHICH IS A BUG!

> - ftrace users will be responsible to avoid migration during TP assign (RDMA in my case)

Yes, it is responsible to do that. Just like it's up to users of
spin_locks to not enable preemption and migrate while holding one.
Entering the ring buffer code is the same as holding a spin_lock except
that the ring buffer code allows for reentrancy.

> 
> please let me know what do you think 

I think that whatever enabled preemption in the ib_mad trace event
needs to be fixed.

-- Steve
