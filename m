Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258717D552F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbjJXPRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjJXPRE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:17:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7623D7A;
        Tue, 24 Oct 2023 08:16:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0BAC433BB;
        Tue, 24 Oct 2023 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160598;
        bh=O1ZQCaqr3Y1gpsxkAzqO3ZiSI5a5sR0bznxgzARpojM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CjnFzzFaAwyXeG6ral0ZKqu5lkYMzvX0J9a2PcXdRWZYsOYCfsPindrt34PP+RY3r
         81AWQ0mWDZI3IEJ2BfLeEcIxCvc1lOPt+0Qy5ISeODiYV//yeL+4cZPNJQsD+bxcLY
         UkMe04C0isuVLemO/DVmCC3oAAeOU37v6oltFq+2DPFLzuc1HnhcveGbmWziglOyLe
         5VqPADI+QZtoeryfKv8KarmHB7k/WNA+Kd2ml3Zj0nacSJqBxThePVJ6lmgvLzG9bk
         uooaZatXH0ckPWsQKYy0fnfUNssV7Is/fQxDRdPUdvGPYtrNvPHhDuQoIhO6sgg788
         a4ogzvivw36+A==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20231024003815.89742-1-yang.lee@linux.alibaba.com>
References: <20231024003815.89742-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/core: Remove NULL check before dev_{put, hold}
Message-Id: <169816059429.2308077.13679053435060636033.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 18:16:34 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 24 Oct 2023 08:38:15 +0800, Yang Li wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/infiniband/core/nldev.c:375:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Remove NULL check before dev_{put, hold}
      https://git.kernel.org/rdma/rdma/c/7a1c2abf9a2be7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
