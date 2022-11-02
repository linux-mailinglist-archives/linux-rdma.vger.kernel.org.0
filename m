Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1196161708D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 23:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKBWTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiKBWTE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 18:19:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6CAE42;
        Wed,  2 Nov 2022 15:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA46861C9A;
        Wed,  2 Nov 2022 22:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD76FC433D6;
        Wed,  2 Nov 2022 22:19:01 +0000 (UTC)
Date:   Wed, 2 Nov 2022 18:19:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Leonid Ravich <lravich@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leonid Ravich <leonid.ravich@toganetworks.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <20221102181900.5bc9812f@rorschach.local.home>
In-Reply-To: <Y2LMjYNAE5LwtcOp@leonid-Inspiron-3421>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
        <20221102074457.08f538a8@rorschach.local.home>
        <Y2JqX3vC1mG/JDex@ziepe.ca>
        <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
        <Y2J4/NQMhRORqnZ0@ziepe.ca>
        <20221102101719.6cbcca6b@rorschach.local.home>
        <Y2J9lAqBvjjPUmJf@ziepe.ca>
        <20221102115947.000897fa@rorschach.local.home>
        <Y2LMjYNAE5LwtcOp@leonid-Inspiron-3421>
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

On Wed, 2 Nov 2022 22:01:17 +0200
Leonid Ravich <lravich@gmail.com> wrote:

> disagree, without CONFIG_PREEMPTION (which is the default case in some
> destros) we will not get any warning, because there will not be
> preamption disable.

I test all for my code (NON_PREEMPT, VOLUNTEER_PREEMPT, PREEMPT) and
with and without lockdep enabled.

This would be a bug if you called kmalloc(X, GFP_KERNEL) in *any* non
preempt section.

> 
> second issue I see and maybe it is only me, is that the assuption of
> atomicity in trace is not a common knowledge for trace users.     

Well, I suppose we could add more documentation. Would that help? Where
would you see it? In the sample code?

I advise not even grabbing locks in trace events, because in most cases
lockdep will not catch any issues with them (it will be hidden unless
the trace event is enabled).

-- Steve
