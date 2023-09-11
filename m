Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4879B5D2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 02:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357854AbjIKWGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbjIKL4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 07:56:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBC8E4;
        Mon, 11 Sep 2023 04:56:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3CC433C7;
        Mon, 11 Sep 2023 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694433390;
        bh=YzkZ2ubxHjx0CPAflDaTyDFWVsfjQjp/bIqIBv5Cya8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eqP8cpn0gfAZye+pJsJ4G/dZZAQlrgrdnCduxaEGg0Cxu5A1ieb4jpMIJOonmJG6z
         BVsa8W5oxLvHzFmtWIcSzUX7DcmmeA7noNfwu6wzR3b2lxLw6YePQlviXRRLtY90NB
         e3+/EBBlPP4BjSqVKrqhFZgRyFfdF+9jW4d3I2C56TABDM6Ul4WmIQKcbvnWrLKb2c
         VH+mT7LCeOZUc1sku4t8XQzZkcpGTrNdsyeF1bSLIj/l1zeIWBFGphdVymAmLpxv9H
         32A/IhKikZHwzErvJFtS5nktP2vyF6JUedN5f7XoEw+D/3tTMkvaV57vma/MVc9i59
         X7hWzy2rM63IA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20230905124048.284165-1-artem.chernyshev@red-soft.ru>
References: <20230905124048.284165-1-artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH v2] infiniband: cxgb4: cm: Check skb value
Message-Id: <169443338748.215131.8527925117659294333.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 14:56:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 05 Sep 2023 15:40:48 +0300, Artem Chernyshev wrote:
> get_skb() can't allocate skb in case of OOM.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied, thanks!

[1/1] infiniband: cxgb4: cm: Check skb value
      https://git.kernel.org/rdma/rdma/c/8fb8a82086f5bd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
