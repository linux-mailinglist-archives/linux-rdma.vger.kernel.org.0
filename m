Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72257588B24
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Aug 2022 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiHCL1n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Aug 2022 07:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiHCL1l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Aug 2022 07:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD8F5275F3
        for <linux-rdma@vger.kernel.org>; Wed,  3 Aug 2022 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659526060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXCHkKJ3NiqFVPxxjTWcCdeUI1hi1Vc6RuS+UWOjl2A=;
        b=IKKB6OZsQA1NNKLXpTk4sheuCbO69Z9pu42/195oCnfdHXyA/WCUlMs+GMIK0x8pFhQeWK
        Zd8dtr41P1ph96P/pZdPC8V0JMh34D9sm4k60s87tqEdOj3kfX04CQ/XW8dJSclqNi7wgq
        Is6UN2cXS/VHws+7I+wMAyidqE2uUBI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-n1-uuVWbOXWg3ipOMJthdg-1; Wed, 03 Aug 2022 07:27:39 -0400
X-MC-Unique: n1-uuVWbOXWg3ipOMJthdg-1
Received: by mail-qt1-f199.google.com with SMTP id hf13-20020a05622a608d00b003214b6b3777so7938033qtb.13
        for <linux-rdma@vger.kernel.org>; Wed, 03 Aug 2022 04:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WXCHkKJ3NiqFVPxxjTWcCdeUI1hi1Vc6RuS+UWOjl2A=;
        b=aQ1XsDhd7Q4gvn8tWBS4INAHF9pjya6CMe9f7OP0VX1g83xp8xFZRnJfe2BEoIP8ke
         xiQKzPNzzWJgKdc6mutL/ReapigOalm9gYQtfwPtakFyit76CFSQ/S9Z1bApy1Wa5Ubv
         fP1aBLTZZOasLrq74CjrA44mr20GZbulw90zmwOdnZj4eAGQyg8ja5PqKgBBXQcc0d4N
         I8W4jRMuMit8tUMXnK7+SWhDlO95n/K/CpyPR5QaxlXcAZ22XfHjo6FmaerVWsikJmaH
         Ay+cz5vFo+R4x+NQw2BSavrUe3DbZYXXjYtfJvBT+7OCkJ924HTADE3km3lwNGEA1ysO
         qjPA==
X-Gm-Message-State: AJIora+5GR0CFQ6IhMsiDeuB77FyWbkTHaQrVXSE9zyIIPLGUYy+t+6B
        Ahbl7d63rV1r+vp07A0qCXFo6o+LJA+H2+tLf5lpAcB7Z+aH78Ap0DzX6EMb7fdiPKQS2mdbQ7/
        b5l8suYmuFDUEhFkFWZJ7ug==
X-Received: by 2002:a05:620a:29d6:b0:6b5:be51:fcf0 with SMTP id s22-20020a05620a29d600b006b5be51fcf0mr18064235qkp.705.1659526058537;
        Wed, 03 Aug 2022 04:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uy36sdA7Sh8aasUy+6BxrbC/DrMuE16xQziCA4OiQcdH+TqUbY9dg+IdQ3r5/Ko0Cx+GqURg==
X-Received: by 2002:a05:620a:29d6:b0:6b5:be51:fcf0 with SMTP id s22-20020a05620a29d600b006b5be51fcf0mr18064224qkp.705.1659526058324;
        Wed, 03 Aug 2022 04:27:38 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id fd9-20020a05622a4d0900b00304fe5247bfsm10712589qtb.36.2022.08.03.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:27:37 -0700 (PDT)
Date:   Wed, 3 Aug 2022 13:27:32 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Matthias May <matthias.may@westermo.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, roopa@nvidia.com,
        eng.alaamohamedsoliman.am@gmail.com, bigeasy@linutronix.de,
        saeedm@nvidia.com, leon@kernel.org, roid@nvidia.com,
        maord@nvidia.com, lariel@nvidia.com, vladbu@nvidia.com,
        cmi@nvidia.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-rdma@vger.kernel.org, nicolas.dichtel@6wind.com,
        eyal.birger@gmail.com, jesse@nicira.com, linville@tuxdriver.com,
        daniel@iogearbox.net, hadarh@mellanox.com, ogerlitz@mellanox.com,
        willemb@google.com, martin.varghese@nokia.com
Subject: Re: [PATCH v2 net 0/4] Do not use RT_TOS for IPv6 flowlabel
Message-ID: <20220803112732.GB29408@pc-4.home>
References: <20220802120935.1363001-1-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802120935.1363001-1-matthias.may@westermo.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 02, 2022 at 02:09:31PM +0200, Matthias May wrote:
> According to Guillaume Nault RT_TOS should never be used for IPv6.
> 
> Quote:
> RT_TOS() is an old macro used to interprete IPv4 TOS as described in
> the obsolete RFC 1349. It's conceptually wrong to use it even in IPv4
> code, although, given the current state of the code, most of the
> existing calls have no consequence.
> 
> But using RT_TOS() in IPv6 code is always a bug: IPv6 never had a "TOS"
> field to be interpreted the RFC 1349 way. There's no historical
> compatibility to worry about.

Apart from the not so informative commit messages, I'm fine with this
series. Please keep my acked-by on all patches if you send a v3.

Thanks again for fixing this.

Acked-by: Guillaume Nault <gnault@redhat.com>

> ---
> v1 -> v2:
>  - Fix spacing of "Fixes" tag.
>  - Add missing CCs
> 
> Matthias May (4):
>   geneve: do not use RT_TOS for IPv6 flowlabel
>   vxlan: do not use RT_TOS for IPv6 flowlabel
>   mlx5: do not use RT_TOS for IPv6 flowlabel
>   ipv6: do not use RT_TOS for IPv6 flowlabel
> 
>  drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 4 ++--
>  drivers/net/geneve.c                                | 3 +--
>  drivers/net/vxlan/vxlan_core.c                      | 2 +-
>  net/ipv6/ip6_output.c                               | 3 +--
>  4 files changed, 5 insertions(+), 7 deletions(-)
> 
> -- 
> 2.35.1
> 

