Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2E5BE551
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiITMLU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 08:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiITMLT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 08:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469B66A7D;
        Tue, 20 Sep 2022 05:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CD561E51;
        Tue, 20 Sep 2022 12:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E5C433C1;
        Tue, 20 Sep 2022 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663675877;
        bh=jrxJEEjsToQxBRhXTlVo2g/gA/1JhFAV1VSOHZsNC5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQFSqEEd0vVeNH9i4MEgpkb4v2Qfl5l5g0bduZioWnNZshm40/Lqh0iAlXHovgNkj
         omHPVbKEzlwiW704e2D11AomYn/70JfxjXQEDbRmOI//+GBjYZGgpfid9oRY7gWykP
         92osqCEmzPlZ/fdT2Kt1soPsYq+sqLZJCC3c6ONDjDI3xezkAXBOzV81Z1fK70VlBH
         stTAUTuBj4mwySNo5/dgCPUo29mDeL6Tl19AjQz6YIVxUZ1xVIvcLD2Iiga4QN4kYz
         4Qx3bo3uqo1tvohHnvp7ReJ9Zt5KXAQCXk3OnYmK/DWg+3OFjBmjKAJg90XAd9lK+x
         3mLdjKe5ITlEQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Hangyu Hua <hbh25y@gmail.com>, gustavoars@kernel.org, jgg@ziepe.ca,
        bvanassche@acm.org
Cc:     target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] infiniband: ulp: srpt: Use flex array destination for memcpy()
Date:   Tue, 20 Sep 2022 15:11:12 +0300
Message-Id: <166367586716.282710.5174043716059240470.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909022943.8896-1-hbh25y@gmail.com>
References: <20220909022943.8896-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 9 Sep 2022 10:29:43 +0800, Hangyu Hua wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what looked
> like a fixed-size object.
> 
> Notice that srp_rsp[] is a pointer to a structure that contains
> flexible-array member data[]:
> 
> [...]

Applied, thanks!

[1/1] infiniband: ulp: srpt: Use flex array destination for memcpy()
      https://git.kernel.org/rdma/rdma/c/4b46a6079d2f8a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
