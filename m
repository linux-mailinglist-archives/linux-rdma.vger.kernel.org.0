Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA66DBF62
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 11:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDIJxn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIJxm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 05:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0930D3
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 02:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEA76023E
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 09:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE874C433D2;
        Sun,  9 Apr 2023 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681034020;
        bh=OgJYYNVpO1n8Q2f8UX46FKGPeRuRGlMkpNfulALRvSw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qmVAgDblFqKiab+8M/sqdFy9wAT+A9fPvdpIYjd24gIu1VN4siXwfTqu5pitHy6Az
         SbO7kpCDiGdX/OMSnbmmTEDcePmG6r1d2zXpG4Yut7QmJnVI3eNz3+JfCAsVkMrupv
         VdTjSHlhCGL3qn7zGgBlnDgN3DP46hI6fJvUGsh21+qv3r7Ct+2c15qDQRmDBwaN+i
         C16SAv3ZL7rxzHI9O/iJZkHFjIfu5gQPJYj2L/lSu14aZ6jsdmVn6CvcWaUKi1hZYh
         cJGb/K4OA9AbkuTWh7xlS7YfYrg3kozu5okVCqkkUM8WD3oGHxV/ufHOI4yHx/BVeX
         2Nnb/S/kkzNiw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Cc:     chuck.lever@oracle.com, linux-rdma@vger.kernel.org
In-Reply-To: <20230330072351.481200-1-markzhang@nvidia.com>
References: <20230330072351.481200-1-markzhang@nvidia.com>
Subject: Re: [PATCH RESEND rdma-next] RDMA/cm: Trace icm_send_rej event before
 the cm state is reset
Message-Id: <168103401625.162977.1501890149492834119.b4-ty@kernel.org>
Date:   Sun, 09 Apr 2023 12:53:36 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 30 Mar 2023 10:23:51 +0300, Mark Zhang wrote:
> Trace icm_send_rej event before the cm state is reset to idle, so that
> correct cm state will be logged. For example when an incoming request is
> rejected, the old trace log was:
>     icm_send_rej: local_id=961102742 remote_id=3829151631 state=IDLE reason=REJ_CONSUMER_DEFINED
> With this patch:
>     icm_send_rej: local_id=312971016 remote_id=3778819983 state=MRA_REQ_SENT reason=REJ_CONSUMER_DEFINED
> 
> [...]

Applied, thanks!

[1/1] RDMA/cm: Trace icm_send_rej event before the cm state is reset
      https://git.kernel.org/rdma/rdma/c/bd9de1badac7e4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
