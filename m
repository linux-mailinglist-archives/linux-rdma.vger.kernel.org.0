Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701B666B041
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 11:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAOKJL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 05:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAOKJI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 05:09:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF635B0
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 02:09:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A08AB80B37
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 10:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D412DC433EF;
        Sun, 15 Jan 2023 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673777344;
        bh=axmTjciQZG/WvROLseX6uCqYQQXr7xzDWAFzVPx+3kc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Za4+FBKwZAZbs/iyzVpngy6NOsHJPesMnEzmK6yEKpkUmqMSDYVbnidEJLANK3bOv
         KNhQASt7+XrcARyLneDhz/3OfJ3qFtH8UB8xZagOEHLVBByZupTf9+m3eqEonTEk+e
         ftKLaIJ7Itygn0AYeKSd9+e6TSnZZ5ggQMnAw0tCu+g9DjgBqan612nhGIUSPD3PFv
         i+QFxxwc8yqp6U645rkHVMi2+SPG+P6SY3X8Gd/OsWSh5Xfsc06c2NUHWhtYtoZO0l
         z3culoZZ9mpyY8uvIuDzBqZhMhuUWJvoTqVkdGFJzuFAIi5TWiv3Kp1A2+HjK3CkhL
         dhfjuR+75JSOw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C167354736291=2E2132367=2E10894218740150168180=2Est?=
 =?utf-8?q?git=40awfm-02=2Ecornelisnetworks=2Ecom=3E?=
References: =?utf-8?q?=3C167354736291=2E2132367=2E10894218740150168180=2Estg?=
 =?utf-8?q?it=40awfm-02=2Ecornelisnetworks=2Ecom=3E?=
Subject: Re: [PATCH for-rc v2] IB/hfi1: Restore allocated resources on failed copyout
Message-Id: <167377733978.34713.1416425249818204927.b4-ty@kernel.org>
Date:   Sun, 15 Jan 2023 12:08:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 12 Jan 2023 13:16:02 -0500, Dennis Dalessandro wrote:
> Fix a resource leak if an error occurs.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: Restore allocated resources on failed copyout
      https://git.kernel.org/rdma/rdma/c/1d58ae793452b2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
