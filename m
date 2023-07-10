Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3314E74DD79
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGJSip (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 14:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGJSio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 14:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE8137;
        Mon, 10 Jul 2023 11:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C4D061194;
        Mon, 10 Jul 2023 18:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3609CC433C7;
        Mon, 10 Jul 2023 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689014322;
        bh=fv0im7OOKhu0ZHpC2ngHTz9yoPg8xIv9FEQrluCM8SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m8JOQyM/6oOYwJYitkD5Q3rSTU1pZ6eUvfNap1vFj0x1Xd8xkx998HB4v9nwUN9wo
         7wIlI+hlVsw1UbzZIiytE+XFyRF6YLq/X65c0q4oKI66MaE3skfKYLdR+uMM/baFjB
         fYPpDFRVqmK3E5wbcJ1EWtCKbYjo0iVe9+TaS2Kx5oxAtkFpnl7kHuDCgxmZUSdULe
         36ZAZeeDVQtO0Hr+lgeNDWY1H+Fd0JgN7r8kzRMABqStvNrfD4DJHSCvFtoD4QzLX3
         NVR3jC8DFZ6G14vFHt7PWlw79IYBToRyeAjcUrbhFAX+snKh1b3pnJ0OWymjiq8FZc
         rfCw+1GKsf2Qw==
Date:   Mon, 10 Jul 2023 11:38:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <yunshenglin0825@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230710113841.482cbeac@kernel.org>
In-Reply-To: <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
        <20230707170157.12727e44@kernel.org>
        <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 9 Jul 2023 20:54:12 +0800 Yunsheng Lin wrote:
> > And the include is still here, too, eh.. =20
>=20
> In V4, it has:
>=20
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -33,6 +33,7 @@=20
>  #include <linux/mm.h> /* Needed by ptr_ring */
>  #include <linux/ptr_ring.h>
>  #include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
>=20
> As dma_get_cache_alignment() defined in dma-mapping.h is used
> here, so we need to include dma-mapping.h.
>=20
> I though the agreement is that this patch only remove the
> "#include <linux/dma-direction.h>" as we dma-mapping.h has included
> dma-direction.h.
>=20
> And Alexander will work on excluding page_pool.h from skbuff.h
> https://lore.kernel.org/all/09842498-b3ba-320d-be8d-348b85e8d525@intel.co=
m/
>=20
> Did I miss something obvious here=EF=BC=9F Or there is better way to do it
> than the method discussed in the above thread?

We're adding a ton of static inline functions to what is a fairly core
header for networking, that's what re-triggered by complaint:

 include/net/page_pool.h                       | 179 ++++++++++++++----

Maybe we should revisit the idea of creating a new header file for
inline helpers... Olek, WDYT?
