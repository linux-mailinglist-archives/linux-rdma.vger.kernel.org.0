Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C65AD2B1
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiIEMfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiIEMfX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D6642CA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F196126B
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 12:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270A8C433C1;
        Mon,  5 Sep 2022 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662380931;
        bh=G8TkRNX0Ouu/tTiuEZc011Ce8lMOfC4EPF4r0v1DAbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjZHUyqI7eFkJbxfHR9437nuxyu2RftxsPhw3E9NpXJsTNDvrpGwZg/PEKKQGEASm
         bSl8n9yMxUViSYqCZ8sCpxL6Cb/ofp+t3fghYrs17XOOdtnVXKyjVKprd0jCF6PY6t
         zu3rAo2dqwY78LbzFfyB7pZpptyYXrOWUmFMtDfHyDtXmJetIyuBeJOV0yn07B48I6
         L/H3rAYeTqf7MWkZOur23LWnpzxpp62vUzQxQWHZW89mG3JSz78gYPBG4zdB4cJcIB
         b5XlNMb4H/aOAtmgl0yKkhDqCumt5qUk0RIB02Ht/p9KCrWhjqPjpOtpMBf6lL9YSY
         teYgtG1tNzC3g==
Date:   Mon, 5 Sep 2022 15:28:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] misc changes for rtrs
Message-ID: <YxXrf1WKVwlDYgzm@unreal>
References: <20220902101922.26273-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902101922.26273-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 02, 2022 at 06:19:19PM +0800, Guoqing Jiang wrote:
> Hi,
> 
> Pls review the three patches.
> 
> Thanks,
> Guoqing
> 
> Guoqing Jiang (3):
>   RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
>   RDMA/rtrs-clt: Break the loop once one path is connected
>   RDMA/rtrs-clt: Kill xchg_paths
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 +++++-------------
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
>  2 files changed, 8 insertions(+), 17 deletions(-)

The third patch still generates warnings.

➜  kernel git:(wip/leon-for-next) mkt ci
^[[A^[[A^[[Ad9b137e23d31 (HEAD -> build) RDMA/rtrs-clt: Kill xchg_paths
WARNING: line length of 81 exceeds 80 columns
#43: FILE: drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:
+		if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, &clt_path, next))

drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21: warning: incorrect type in initializer (different address spaces)
drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21:    expected struct rtrs_clt_path [noderef] __rcu *__new
drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21:    got struct rtrs_clt_path *[assigned] next


> 
> -- 
> 2.31.1
> 
