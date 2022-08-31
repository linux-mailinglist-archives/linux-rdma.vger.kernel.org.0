Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4045A7682
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiHaG07 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiHaG06 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 02:26:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000AFA7AAC
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 23:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC248B81F1C
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 06:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F8C433C1;
        Wed, 31 Aug 2022 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661927215;
        bh=T96HxxWsof82wAQK+eLEjqdf56ru/UMqQgATlapNTCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RstXvLOyTCfqm+1RnpDPksoZypeV3g2vmst8ajq1oe3KyS49UE9MO3lniAsgzrfm/
         qRQ0pccXKIwkDJQK6kXeJf2t9TY19P+L+G8GSQbvbM4X0q0asYkmZ/dqWcOejJLRwZ
         slg4Y8urQI6c8JXjMNT9Np6Rhl1oo/Jd4ud5XqtLxRXSUQCrY2kKWHlehSvSQvhfNi
         vM19KIzUZPyhGRlJlYJJQXdo8YW8+ok5ukaNNz+yjsuKrwPTrqFQp/TcxpR3rfrX4o
         SVGSVam9qG6t5+H3NFn9QOaTzphiw4Ca1tWetpk759p3hwBKoRM0BdeAKoSSfkto/Z
         T8SB+OZgX9Q5g==
Date:   Wed, 31 Aug 2022 09:26:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Message-ID: <Yw7/KilXI8l+1/uA@unreal>
References: <20220805183523.32044-1-rpearsonhpe@gmail.com>
 <TYCPR01MB93059478A187A821F8F8469AA5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
 <fa1fb86c-fd1c-d431-954b-98540299bf4a@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1fb86c-fd1c-d431-954b-98540299bf4a@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 31, 2022 at 01:48:08PM +0800, Li Zhijian wrote:
> BTW: this patch should be for-rc instead.

It can't be in -rc without Fixes line and more clear description.

Thanks
