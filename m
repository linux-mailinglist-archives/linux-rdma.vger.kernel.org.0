Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3BB60A5F9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiJXMaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 08:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiJXMaF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 08:30:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148F5D739;
        Mon, 24 Oct 2022 05:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31FF6B81181;
        Mon, 24 Oct 2022 11:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EF5C433D7;
        Mon, 24 Oct 2022 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612070;
        bh=2Xq/Xx65ukmX6CknqA0PZRSw+qJQk8YtM6vyHsXpZA0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RFazvBS4s6P+srUXi9c1t6n9vmFmZZOwNA5B+NevoXN5TuABrk22dSuDDrhvgsDeq
         Ea0Ah1OSwctul3jvVUaLQ8HDT9r5UYlBvcgseaY8ETJE/nXSV772iuhPz6hrwazjnj
         UMjV7AhnVTZ9aDtTtUB1IwFUrSGoE4aWL7Ad/h1k14aV31CBdCuW4SaLekwa+sTqvl
         XxxLhgc96RvIIzTr6omIrG0/qkdCuNSuswYovf0T/ky3d4cz4tko/GZci76kjZQPUM
         vZmdWaQctTQ0DCab6DTKfidWbUcIW+ujUyJuwQWUukX6qsz3LGglDZorAVJqPUNN9d
         7Pq6zLtL8BVaw==
From:   Leon Romanovsky <leon@kernel.org>
To:     wangjianli <wangjianli@cdjrlc.com>, jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20221022060030.50900-1-wangjianli@cdjrlc.com>
References: <20221022060030.50900-1-wangjianli@cdjrlc.com>
Subject: Re: [PATCH] infiniband/core: fix repeated words in comments
Message-Id: <166661206651.860056.8565656174789482533.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 14:47:46 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 22 Oct 2022 14:00:30 +0800, wangjianli wrote:
> Delete the redundant word 'the'.
> 
> 

Applied, thanks!

[1/1] infiniband/core: fix repeated words in comments
      https://git.kernel.org/rdma/rdma/c/c4bb733234b0ff

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
