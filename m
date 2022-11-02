Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5516164F7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiKBOVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKBOV3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 10:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A02A266;
        Wed,  2 Nov 2022 07:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07EDD619D2;
        Wed,  2 Nov 2022 14:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E27BC433D7;
        Wed,  2 Nov 2022 14:20:56 +0000 (UTC)
Date:   Wed, 2 Nov 2022 10:20:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Leonid Ravich <leonid.ravich@toganetworks.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Leon Ravich <lravich@gmail.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <20221102102054.30f5adfc@rorschach.local.home>
In-Reply-To: <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
        <20221102074457.08f538a8@rorschach.local.home>
        <Y2JqX3vC1mG/JDex@ziepe.ca>
        <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
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

On Wed, 2 Nov 2022 14:02:49 +0000
Leonid Ravich <leonid.ravich@toganetworks.com> wrote:

> >I'm guessing some driver's query_pkey op, but AFAIK we don't have any
> >explicit pre-emption reenablements in the code - unless it is sneaky..  
> trace infra uses preempt_disable_notrace/preempt_enable_notrace  to disable/enable preemtion but  my kernel compiled without CONFIG_PREEMPTION so this functions are only barriers - looks like the idea behind was to avoid involuntary preemtion  but in our case it is a voluntary (there is a wait_for_completion in the query_pkey  rabbit hole).
> 
> so no scheduler here to warn about illegal migration. 

Well, you should be testing under different configs ;-)

It would have given you the reason for the real bug.

-- Steve
