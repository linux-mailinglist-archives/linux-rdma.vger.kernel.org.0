Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA50D71888A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 19:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEaRgd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaRgc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 13:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD39B3;
        Wed, 31 May 2023 10:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED4361A73;
        Wed, 31 May 2023 17:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D784C433EF;
        Wed, 31 May 2023 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685554590;
        bh=E8/YrOVgNR27N0LkHElCkB5l3t4vUakB9HVli2Uhyk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dK17t+nJ0crlmubD6XgSS92BjlxVMZTu1MaTCNz6EyMwY6zLP3WQY6xoeEQChYAMC
         TMMbCEbGLJ86ZGXeJJFpegziok+jD1IQxQGsY1jR05yzKsYLp6xaMyoFyUyv/AFjP2
         rilSLr8D4odkK/IQBoVtKLOvev5q6N87+tP6hSCueozbKF5yN+KRH/H5acFghGnb41
         F+WvRsSYYSITV5EzLnqV1OIR0aCQhc5wJEAVtyqsa/4K61T1i7bRY0n7QZ/t5V1LGZ
         nBnq5HztyV3M9RG8CPr5Sly87e5RLxrPsPmyDcCOQcBK3zlaUfduvrIrgANnQEzRE0
         k/3whNwouFsWg==
Date:   Wed, 31 May 2023 10:36:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 0/8] sched/topology: add for_each_numa_cpu() macro
Message-ID: <20230531103628.7191e129@kernel.org>
In-Reply-To: <ZHd/KgGN3tCe308V@yury-ThinkPad>
References: <20230430171809.124686-1-yury.norov@gmail.com>
        <ZHdrMiVSrPdM3xGn@yury-ThinkPad>
        <20230531100125.39d73e1d@kernel.org>
        <ZHd/KgGN3tCe308V@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 31 May 2023 10:08:58 -0700 Yury Norov wrote:
> On Wed, May 31, 2023 at 10:01:25AM -0700, Jakub Kicinski wrote:
> > On Wed, 31 May 2023 08:43:46 -0700 Yury Norov wrote:  
> > > Now that the series reviewed, can you consider taking it in sched
> > > tree?  
> > 
> > Do you mean someone else or did you mean the net-next tree?  
> 
> Sorry, net-next.

I'm a bit of a coward. I don't trust my ability to judge this code,
and it seems Linus has opinions about it :( The mlx5 patch looks like 
a small refactoring which can wait until 6.6. I don't feel like net-next
is the best path downstream for this series :(
