Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC55167D546
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjAZTUH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 14:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAZTUE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 14:20:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350E20686
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 11:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C10A0617D1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 19:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67711C433EF;
        Thu, 26 Jan 2023 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674760803;
        bh=X9S9B/wu1UrYS6bUX5vJI8NQ8jJrEMlOTh3D0H2pkDY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mURshzbUayrC8flyGDKNs1Hyuyjr+4Fip6SPpHf2Cy3Z5sA1pY0F9ggMM3uqSXO3a
         lu+WPBxBah4cDdJxPWsARmVj4u9U7oFE08TWBNuQAW0EDtDJOwgvw+55/WVj4xInUN
         qlVXsOXZAt9+j7O1Jh14UESeOdYqZvs6kmssiC+FesOMh8kYNguQkHQn+6WN5HQcww
         xzeuNSKOujIAvwZ28DqMqLW0CT8edZSY63cDMBEpr/JNUose0hE1eee1b/TucdCrDc
         RSPInLQGOZSXr6vH5mba5uVX8Xc0xOXUmv6+xyPndEU3ZjwsyZgdXNE/yCbBN/5t6m
         +XkEh6WR77fag==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
References: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced
 IPoIB over netlink
Message-Id: <167476079880.1543889.17479286618978473850.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 21:19:58 +0200
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


On Tue, 24 Jan 2023 20:24:18 +0200, Leon Romanovsky wrote:
> Make sure that non-enhanced IPoIB queues are configured with only
> 1 tx and rx queues over netlink. This behavior is consistent with the
> sysfs child_create configuration.
> 
> The cited commit opened up the possibility for child PKEY interface
> to have multiple tx/rx queues. It is the driver's responsibility to
> re-adjust the queue count accordingly. This patch does exactly that:
> non-enhanced IPoIB supports only 1 tx and 1 rx queue.
> 
> [...]

Applied, thanks!

[1/1] IB/IPoIB: Fix queue count for non-enhanced IPoIB over netlink
      https://git.kernel.org/rdma/rdma/c/e632291a2dbce4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
