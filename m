Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503B6697AEC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 12:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBOLiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 06:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOLiF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 06:38:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B040F1;
        Wed, 15 Feb 2023 03:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73DC9B82133;
        Wed, 15 Feb 2023 11:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B727C433EF;
        Wed, 15 Feb 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676461082;
        bh=u+Sh5jJdQsY8TgnLwpyXLmlmOqfNQDY0CvGLucYe2pk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RKjbfR2hA9LyYurcKOGrfhT95Q6K7hntKxlldfcHUYcu3u/Ik7YpzTWK9cJEUe9mZ
         vWH6iOsXUO9XwwwJOClOTy8uwrLLayZQ/SQKQxWGQ4E1CEEOYic2iSHZI4tiOKyNXG
         9gxM5j5Y6uzV9+9y2e5GaSu9u5GKS5bD99Kx+2Wt47UU7613VkJknfR6YDuusSkAqx
         jyoussL6RFVtWlZtDvCL9BeHj0ynW9ajMCkd3FXIKtxSklVnbLZvE996a/GOGr8VDD
         PbOuZtATQOlmbYn4KV99Jp/ublCW3tKs0iByBnyQVhaYOiNOB422wdPGqrgax8o2Rm
         RbsFXCsv8FUvQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Steve Wise <larrystevenwise@gmail.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <Y+usKuWIKr4dimZh@kili>
References: <Y+usKuWIKr4dimZh@kili>
Subject: Re: [PATCH] iw_cxgb4: potential NULL dereference in
 c4iw_fill_res_cm_id_entry()
Message-Id: <167646107773.1505248.162196698834513565.b4-ty@kernel.org>
Date:   Wed, 15 Feb 2023 13:37:57 +0200
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


On Tue, 14 Feb 2023 18:43:38 +0300, Dan Carpenter wrote:
> This condition needs to match the previous "if (epcp->state == LISTEN) {"
> exactly to avoid a NULL dereference of either "listen_ep" or "ep". The
> problem is that "epcp" has been re-assigned so just testing
> "if (epcp->state == LISTEN) {" a second time is not sufficient.
> 
> 

Applied, thanks!

[1/1] iw_cxgb4: potential NULL dereference in c4iw_fill_res_cm_id_entry()
      https://git.kernel.org/rdma/rdma/c/4ca446b127c568

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
