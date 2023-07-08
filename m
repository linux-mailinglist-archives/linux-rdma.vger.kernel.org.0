Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E523974BA53
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jul 2023 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGHACD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jul 2023 20:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjGHACC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jul 2023 20:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8527126;
        Fri,  7 Jul 2023 17:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C86161AC7;
        Sat,  8 Jul 2023 00:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CC6C433C7;
        Sat,  8 Jul 2023 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688774518;
        bh=Ems+EKXwQA6oSusGgVodL1Hdfvdv/wmqk+JwPBsQFd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jhtuqCmoXo1h5jzgXUzl1AM9bdaSyQyQ3ej5jf75gP3cWlNk9CLseSnplwTyHVnMq
         /GLngSsJIF7IabzZ6UzzS67hoLbzdzD5TjSeFkxfKVK0uLIP/phopc+pQ5s5w54oTy
         kDVu0jphco0S1YQtiit4fQIE/keOdRHp5dDQxDQJTZoNDAEX5TrBKDJYOvJdpk+2gH
         NyuzXjVTZ2dA8OOgVS32XatRE7McnTtgAncd/d7iai02ihaXnyx7kF0q8CITOMtVDL
         8L+XYKfyRFBUHaKZoRMKg8HspsQP1DSbbM1Q3BvuU6FseJsPeezOpx806PpInsoAR0
         gOzSsyn3lsUxw==
Date:   Fri, 7 Jul 2023 17:01:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230707170157.12727e44@kernel.org>
In-Reply-To: <20230629120226.14854-2-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:
> -#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>

And the include is still here, too, eh..
