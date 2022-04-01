Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B015B4EE76E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 06:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiDAEwp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 00:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244906AbiDAEwp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 00:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE21D67E7
        for <linux-rdma@vger.kernel.org>; Thu, 31 Mar 2022 21:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A0161AF3
        for <linux-rdma@vger.kernel.org>; Fri,  1 Apr 2022 04:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A097C2BBE4;
        Fri,  1 Apr 2022 04:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648788655;
        bh=89A2NhREZllXAx5zVP14nlD16QeB8qqRlmEFxr2U/48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bydqRz1KqM2uhjq0hXjKKfeYzgve5jwPC+KZ2ZcuktO3xPXCMLGLDLlH3MvbT1TA5
         IMNkVmHgUdalaP/6Sxwhmjk/QEaz97LBxKTOBEYMGwHu6VkcNWFebtYg6tynUxLJEL
         CIIyuS839wXMskz1JD4EdzPJPpv7KTUWkQaJk0LXX8M6U/3AANIexUJKYHZT0CWh7l
         Kcpn+kBQVMbFJlL4RpMItRc2GgQNvi9TeBLNPWJfKzv7QTJ2UZwMC71gqEvaC6XhAy
         KdCTtdfDrJkoZi5txbATxdpEs/9G9MMVEcjs7Mv0TUPIN55P5ty+LqVJt1GzR7GT+v
         TwJ+WucMFb8vg==
Date:   Fri, 1 Apr 2022 07:50:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/rxe: Generate a completion on error after
 getting a wqe
Message-ID: <YkaEqgP3254QLRuS@unreal>
References: <20220331120245.314614-1-yangx.jy@fujitsu.com>
 <YkXiough/A/aGi1M@unreal>
 <8b90851c-72ba-1eb2-7e94-ee7d6a178fc7@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b90851c-72ba-1eb2-7e94-ee7d6a178fc7@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 01, 2022 at 03:52:37AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/4/1 1:19, Leon Romanovsky wrote:
> 
>         ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
>         if (unlikely(ret)) {
>                 pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
> +               if (ah)
> 
> 
> No, ah can't be NULL. This is why I proposed to clean rxe_get_av() too.
> **ahp is not NULL, as an input to that function and in all flows it is
> updated with new ah pointer. If it can't update, the NULL will be
> returned and rxe_requester() will exit.

Please use plain-text friendly email client.

> 
> Hi Leon,
> 
> If ah_num is 0 in rxe_get_av(), rxe_get_av() returns not NULL (i.e. av is not NULL) and ah is NULL.
> In this case, I think we can reach here and ah is NULL.
> BTW, I don't want to mix the fix and the change of rxe_get_av()'s logic.

ok, no problem.

Thanks

> 
> Best Regards,
> 
> Xiao Yang
