Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D73784453
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjHVOc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjHVOc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543BE6C
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C464B62D4D
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 14:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75166C433C7;
        Tue, 22 Aug 2023 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714718;
        bh=38rh0bzbUMpqqq/8VXffc5zw1S4gYIb1L+JyGXdqbBc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JNJmfTQhdvwhvahVqJYJFQQ/UCS0kC5mSygfpoSi/COnY2dnAVdit+mCm/ibEDIwH
         xEnToDDu5LFW0NbCQraWtUiGkM0eetV/btD/3oZ/APxDluI/5qbZuGt0mHx4hJf/x4
         0csDyoDtV6WfkinqHHw7ETgP+KO2vh13ewYQIZLjekS7puoa3owU6fa5tKUFTKaOpl
         V311QD46PxgDTMbAL5OS1QfWDc/XOSUKxDv6PAQ3PUXggyYL1dm1TPRDJs1HV228rq
         dfsobDb6eYF7sdlIOrjv+dHIaCojlJLaGdI3BlH1dtYnfjIDj2o8lfY/25GSRSL3UT
         YDwnbAVI348vw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Douglas Miller <doug.miller@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
References: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
Subject: Re: [PATCH for-next 0/2] Series short description
Message-Id: <169271471400.43535.1833309467078306989.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:31:54 +0300
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


On Tue, 22 Aug 2023 10:07:47 -0400, Dennis Dalessandro wrote:
> Much scaled down version of Brendan's previous patches. This doesn't touch uAPI
> just refactors some code.
> 
> Small fixup from Doug.
> 
> Would have sent a couple weeks ago but had been dealing with the isert
> regression. Reverting that give us a clean bill of health. If too late
> for 6.6 can wait another cycle even.
> 
> [...]

Applied, thanks!

[1/2] RDMA/hfi1: Move user SDMA system memory pinning code to its own file
      https://git.kernel.org/rdma/rdma/c/d2c02346345337
[2/2] IB/hfi1: Reduce printing of errors during driver shut down
      https://git.kernel.org/rdma/rdma/c/f5acc36b0714b7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
