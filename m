Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3B7B740E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjJCWUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjJCWUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 18:20:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F20A7;
        Tue,  3 Oct 2023 15:20:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E06C433C7;
        Tue,  3 Oct 2023 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696371632;
        bh=6y7yOpF3hjHEJEXpBlwtl2/qKv3st7gL0H1Sn9YwJ/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d6fGfUSB/RevS+9tgve/tqb2SRL6fKIqm9H46Id+jA16c1ZtbNLoHfdiot7Z0avH/
         8fUhvxnJo9+tf3WaebkNXxXEfpht3HnVSic6aTWuur491PgIL31+OLJdyU3ykW7D25
         QG0AZVIJTOuVUsFj0PCtRcmq3EO72FAVL8cMIr8vXfqhdJ/vmpUuhKIgaF3SdZKc9w
         iAin2Uu9qIiWO96cCFoi+PtxnDy3fIRhVeZ7rt0yG5SVB8cXupZYwAs9jl2ZxlWTAe
         Y0aWqfNE5mpfVLQgRfClFz338e3TALHiZPEYDmLN13cCTjwcr8+b1YXISEAA4xWs3c
         /H7ulb9LfNwyw==
Date:   Tue, 3 Oct 2023 15:20:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Yury Norov <ynorov@nvidia.com>
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Message-ID: <20231003152030.6615437c@kernel.org>
In-Reply-To: <ZRwbKRnnKY/tDqCF@yury-ThinkPad>
References: <20230925020528.777578-1-yury.norov@gmail.com>
        <20230925020528.777578-2-yury.norov@gmail.com>
        <2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
        <ZRwbKRnnKY/tDqCF@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 3 Oct 2023 06:46:17 -0700 Yury Norov wrote:
> Can you elaborate on the conflicts you see? For me it applies cleanly
> on current master, and with some 3-way merging on latest -next...

We're half way thru the release cycle the conflicts can still come in.

There's no dependency for the first patch. The most normal way to
handle this would be to send patch 1 to the networking tree and send
the rest in the subsequent merge window.
