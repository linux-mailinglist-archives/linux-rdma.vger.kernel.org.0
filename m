Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CED641D35
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Dec 2022 14:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLDNXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Dec 2022 08:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDNXh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Dec 2022 08:23:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C7F08;
        Sun,  4 Dec 2022 05:23:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4334B807E5;
        Sun,  4 Dec 2022 13:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD00C433D6;
        Sun,  4 Dec 2022 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670160214;
        bh=MgTQ8q6E94moHiSPp3pcN9AG9weUpTT6tPXfNB3DjXg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s/YG8gsFRni1Nh1LCZkoIKTtY8hvwB2nORPEAx9GViiDkghnOKCKc8RC/doRodMtT
         /66K3f2d+Pk144Cvv133R5yemIgStXC+rS8V2A8b3lprEAW6h0MGt32aeCGPNnsPDm
         cF441iXVZFEN49kOR8/0vANSIqw6ITUKstzEJtN1D3S/Jb3mhBv7gRNmilAfHor1h7
         YoPTdGR4doS3QjiGmHJnmDEXoPtC9spDMSRF/p54TZOmcFwcEyPcSjVw5FQ3XMNK9u
         0MX6rPwv/+nVo7GPxoNnuSKFZkumcDzAclZ6Yu+GLRYvH6QlWbIueLqHP6dfb9OZj7
         GIVkGlTaWLVrA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20221202211940.29111-1-rdunlap@infradead.org>
References: <20221202211940.29111-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] infiniband: disable IB HW for UML
Message-Id: <167016020363.36226.13998271236937647073.b4-ty@kernel.org>
Date:   Sun, 04 Dec 2022 15:23:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2 Dec 2022 13:19:40 -0800, Randy Dunlap wrote:
> Disable all of drivers/infiniband/hw/ for UML builds until someone
> needs it and provides patches to support it.
> 
> This prevents build errors in hw/qib/qib_wc_x86_64.c.
> 
> 

Applied, thanks!

[1/1] infiniband: disable IB HW for UML
      https://git.kernel.org/rdma/rdma/c/323a74fc20f53c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
