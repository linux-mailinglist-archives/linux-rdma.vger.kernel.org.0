Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E805EF0AF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiI2IhE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 04:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiI2Igu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 04:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26091288A0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 01:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AEF762086
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 08:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52621C433D6;
        Thu, 29 Sep 2022 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664440603;
        bh=EVXAfGrkMYF8JQFMIdoqC2JesuKuI+xRvFv1Wg1fp1c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c0tLKk+4EjcJ4DyYocNctCUUN0k0VX9kP6vOO2LfZosjO1QCqVqT7xmJLuyHnnUgt
         +bFD7TKZTU0QOY1/RhfrGGlyTydyAWfjIAruH49TU/FjA6q1TVm53rjSxriL+Yl2Mg
         BH8BIbuTgVuYOLf5o8spF3Pz7j9TudtMc2bwgWVUHqwRnEd+Pz734e0Bp4MB74QDfZ
         5l1OJWQ8UL5c/YWKQFAQcheYr+TJVbbSmqkuGQG5a03MIBE+5HzQTlfv8DPhbc0gup
         nTQ/NzjIuhnqEf0XHhkAiTlPpYbFnzb9jZVZsgxUwu88hqZNxdRJSqTh6evLAJcvCR
         iUkONUoUiFT+g==
From:   Leon Romanovsky <leon@kernel.org>
To:     umalhi@cisco.com, jgg@ziepe.ca, neescoba@cisco.com,
        roland@purestorage.com, Zeng Heng <zengheng4@huawei.com>,
        benve@cisco.com
Cc:     liwei391@huawei.com, linux-rdma@vger.kernel.org
In-Reply-To: <20220929031200.4060891-1-zengheng4@huawei.com>
References: <20220929031200.4060891-1-zengheng4@huawei.com>
Subject: Re: [PATCH -next] RDMA/usnic: fix set-but-not-unused variable 'flags' warning
Message-Id: <166444059958.357930.8164654019038558031.b4-ty@kernel.org>
Date:   Thu, 29 Sep 2022 11:36:39 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 29 Sep 2022 11:12:00 +0800, Zeng Heng wrote:
> Remove unused local variable 'flag'
> without any logic changes.
> 
> 

Applied, thanks!

[1/1] RDMA/usnic: fix set-but-not-unused variable 'flags' warning
      https://git.kernel.org/rdma/rdma/c/4b83ddc0924752

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
