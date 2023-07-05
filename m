Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A46747C85
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 07:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGEFje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 01:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGEFjd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 01:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F09134
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 22:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 669906142A
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 05:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036C5C433C8;
        Wed,  5 Jul 2023 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688535570;
        bh=nFQs5cTYuPOJh3r7igwUDZnsJ+CtGitDkjQDXqqvwWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMQpu1Olo+hPa/ure2yfSzB6W+lU51hs8oLP5LZYOXbwUOQf4YU3waL3ciPI344MA
         6JnUqRNtDzwGQvC+GarMjeEXxWKbLswFmpmVe9HTn0oYqh8C71ePOQZGsttfX39J5c
         r9e0TVIwa/UdKVEaLWVXCxykRSVpbDvprtXHd58iCKV265H4FxjKPgG9AVvUu0gBlB
         7glXl9QwT5WDE3lwvGnS1ZMDBgHkOuqpcreFDcuL6ZjyNlCQBVbndehQSgKqMBFg1D
         dEIMEFfg1/t4QtwPzleqnxyx90Bx1YQX+f0HXvHpxLLLZuQM65eSw74QWZarcIroBg
         /oQY4veRy8m6g==
Date:   Wed, 5 Jul 2023 08:39:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        raeds@nvidia.com, ehakim@nvidia.com, liorna@nvidia.com,
        nathan@kernel.org, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5e: fix double free in
 macsec_fs_tx_create_crypto_table_groups
Message-ID: <20230705053926.GF6455@unreal>
References: <20230704070640.368652-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704070640.368652-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 03:06:40PM +0800, Zhengchao Shao wrote:
> In function macsec_fs_tx_create_crypto_table_groups(), when the ft->g
> memory is successfully allocated but the 'in' memory fails to be
> allocated, the memory pointed to by ft->g is released once. And in function
> macsec_fs_tx_create(), macsec_fs_tx_destroy() is called to release the
> memory pointed to by ft->g again. This will cause double free problem.

This is perfect example, why it is anti-pattern to have one global
destroy function like macsec_fs_tx_destroy(), which hides multiple
class of errors: wrong release order, double free e.t.c

> 
> Fixes: e467b283ffd5 ("net/mlx5e: Add MACsec TX steering rules")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
