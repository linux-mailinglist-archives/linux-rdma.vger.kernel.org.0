Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB25E5F1B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIVJ4m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIVJ4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 05:56:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9E8D62FF
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 02:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8A6FB83582
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 09:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D918C433D6;
        Thu, 22 Sep 2022 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663840513;
        bh=F9ZtrFWAcdzEwyw/6fZ+B6zq5MQwC4V2FwKBWk8MQOM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SYNUptsTKEfeU1WPd9o1Q7rlCVdmRDAw4mSMij9XR08yBrrje0fNBkDWCC9VwP8GZ
         rygAQIAeEhxcgKSgEiS2U21wirBtKGUUU94MPqhxq+HCfoGubOTqpN+CKiftTf5pU/
         t3obIJAU8qzv3Gcp5On91vntNIkcjarfp6wh0xLk66Yp5jCNFYxLP51jBjhztaYhcd
         muekaB2c+MFKj/KxuhPu+aRLzudLDR9X6VpnrQ9uh3m6QKxb9BjEFjf78Gf5lq5r5C
         ljCIio7MK/1zqO7ofzYn+fKAwli0TlevAsQq32bEu7pwDWxsWSlqKCFsAjd41uywVu
         6wVBv5fTcc9zw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Mikhael Goikhman <migo@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <7d80d8844f1abb3a54170b7259f0a02be38080a6.1663747327.git.leonro@nvidia.com>
References: <7d80d8844f1abb3a54170b7259f0a02be38080a6.1663747327.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/srp: Support more than 255 rdma ports
Message-Id: <166384050993.1028734.5651184793986540799.b4-ty@kernel.org>
Date:   Thu, 22 Sep 2022 12:55:09 +0300
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

On Wed, 21 Sep 2022 11:03:07 +0300, Leon Romanovsky wrote:
> From: Mikhael Goikhman <migo@nvidia.com>
> 
> Currently ib_srp module does not support devices with more than 256
> ports. Switch from u8 to u32 to fix the problem.
> 
> 

Applied, thanks!

[1/1] RDMA/srp: Support more than 255 rdma ports
      https://git.kernel.org/rdma/rdma/c/b05398aff9ad9d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
