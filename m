Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0474781D35
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHTJqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjHTJqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 05:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3894685
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 02:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6B160B6A
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 09:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E7AC433C7;
        Sun, 20 Aug 2023 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692524786;
        bh=NAsOaI85bt2GHW91P5Mj6H+neD+x9awt5PXHZbXIYn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTWKKHnm/yFL20adnQ+Rnlg3ND5eYwBjYQt8n03oy4P1fbbbIs616inGgM6OVSuDm
         FKOHgv/vEj3bx/fh8YbnL82SBsFf03Cqve68RN7VhWSVLfLMggXLkvff+01B8CajCJ
         WucLpntO4sxuX9wJYpeXnRg+MViLC09NCMegVfLewmqGz1eCUwP3PFhxZEkU0Tq6h3
         SOXdH0SXbRBT6vgHjEnodnYst5RKC43iZ23sLPSx/FQu4kl3NHHzdLEtyYhfnuiyFp
         a/BPRbAbNFAacjGbTPM4o53ALRYtgYfEtvxr1Q8eLYVDR7uPNJ0lFkUy0xQp9OZvFi
         rAA7N8T2df34w==
Date:   Sun, 20 Aug 2023 12:46:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        saravanan.vajravel@broadcom.com
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: isert patch leaving resources behind
Message-ID: <20230820094622.GD1562474@unreal>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
 <20230813082931.GD7707@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813082931.GD7707@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 13, 2023 at 11:29:31AM +0300, Leon Romanovsky wrote:
> On Thu, Aug 10, 2023 at 10:44:00AM -0400, Dennis Dalessandro wrote:
> > Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> > causing problems on OPA when we try to unload the driver after doing iSCI
> > testing. Reverting this commit causes the problem to go away. Any ideas?
> 
> 
> Saravanan, can you please post kernel logs as you wrote "When a bunch of iSER target
> is cleared, this issue can lead to use-after-free memory issue as isert conn is twice
> released" in the reverted commit?

So what is the resolution here?

Thanks
