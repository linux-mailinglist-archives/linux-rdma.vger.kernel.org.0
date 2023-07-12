Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0067C7507A0
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjGLMKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjGLMKl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5E21998;
        Wed, 12 Jul 2023 05:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D731B61721;
        Wed, 12 Jul 2023 12:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3C3C433C8;
        Wed, 12 Jul 2023 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163837;
        bh=TIFHKnWWzAf+8MWM8+zyB9l3Q+WpcW7EkaoW+aoLP6E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dtxaI8BcKuyx+AHRVjUWMZx4dDMy7RS9uuXfYXiRGnVeFd554kGz9TEvhQR81T27Y
         cJ4GtX0LH731a/+91no6kcY26Aq1D40/GdpoXH571aomReJUuYpVrv5pVqAZeEqrzp
         T8Mh+nFPheXHYYnQ1qFnT3m2hKqP6wc5LPfPkggIippr4IfsORjgx69zYPZxzQKGZr
         3rZV3XzcNWxwwW1KzOn0F8VF0MhpxpnNCwQcZNWmjPnROg9cxujtJHUXV2NZ67MoqO
         LvBVSOxhPmV/S2cyzoEq94KkVsFJ5vS3IHibi+C7CgpGrcaTBb18CZaefhIXNKO2fF
         fuBVNuxH5tDVQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230706022704.1260-1-duminjie@vivo.com>
References: <20230706022704.1260-1-duminjie@vivo.com>
Subject: Re: [PATCH v1] infiniband: irdma: Remove a duplicate assignment in
 irdma_query_ah()
Message-Id: <168916383325.1207710.15479910843790374045.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:10:33 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 06 Jul 2023 10:27:03 +0800, Minjie Du wrote:
> Delete a duplicate statement from this function implementation.
> 
> 

Applied, thanks!

[1/1] infiniband: irdma: Remove a duplicate assignment in irdma_query_ah()
      https://git.kernel.org/rdma/rdma/c/34c2ce4c6e3cd2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
