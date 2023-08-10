Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0586C77801C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjHJSSU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 14:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJSSU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 14:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295711703
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 11:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A79653D9
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DBC433C7;
        Thu, 10 Aug 2023 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691691499;
        bh=LZ135UBTPZt3pIDDTVIcNZXzNUl/4m86OF1+bRutaqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJo7F5dzD/o49kmcIkU+dnKS3nexFxAOyS+y071/KIfoNc75nUpGEmI+7GGExOlP8
         Hu5e/yszcB7ASO1fobwCF2ZZM7gae2miOpmBzi4KPHE0/FT6s8+XJmWhwEZrQtTJcl
         Uc1pdElpX5Csn+yJp1sV826gg6mRQoHTxJEwZyjzd+4KpPvUkj842c4R3xCr8kvfJL
         E18RNVAoENOKBSFXK9HyZ4vixId0HLUqydCC5XaAnuFOg2bxht1DAY1ZLg9x/+Qh4n
         SBcNtRwKt+Er0L8kFAX71pqXYdSwkItCrGFYc6njOrvR+Gf060na4DOvWa5y/irwh8
         SmmoSpXeGE74A==
Date:   Thu, 10 Aug 2023 20:18:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: rdma: Remove unused declaration
 rds_rdma_conn_connect()
Message-ID: <ZNUp52ABFThqAETb@vergenet.net>
References: <20230809144007.28212-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809144007.28212-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 10:40:07PM +0800, Yue Haibing wrote:
> Since commit 55b7ed0b582f ("RDS: Common RDMA transport code")
> rds_rdma_conn_connect() is never implemented and used.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

