Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1F768F4F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 09:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGaH7t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 03:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGaH7s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 03:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A101A4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 00:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A242B60F29
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 07:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9967DC433C8;
        Mon, 31 Jul 2023 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790387;
        bh=wiRwaTiCaurGsqvdIjidE875nr13nu1RYcHanoJD6uc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=lZtcEYuHuuJHQT+qpRf43lbblk80gn59w/+5q54hDMQk50JS04zeZO9DTwxEgPP5g
         q4TYwZSLGeaqTcJ7ZYFxjmIVTz06crTBW80vdmB6YXOAzNFnHe5dx3TeGDYPl99dt6
         JAZhVLorJIhWExyTW1VaRTqw9LpLLE4TfZuLLbBekFIJSMKoCUQfXo67ESbYv+dwk+
         5zcr+LvHoY/IAmDNQ8oC0+uyC/Xq/FQUB/QcYfTqGJILrOh26dEil+a4qzTXYSM8N0
         UZfW1EAhLGC85z859c3q5X8g9C0X6OmObyFpicXpFFNZizOUe0Lj+VGDqUIWRGliv4
         IuK/6YlIaX1zQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230731065543.2285928-1-ruanjinjie@huawei.com>
References: <20230731065543.2285928-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] RDMA/mthca: remove many unnecessary NULL values
Message-Id: <169079038349.105051.11239565789002334670.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 10:59:43 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 31 Jul 2023 14:55:43 +0800, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so
> remove the NULL assignment.
> 
> 

Applied, thanks!

[1/1] RDMA/mthca: remove many unnecessary NULL values
      https://git.kernel.org/rdma/rdma/c/50f338cd884705

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
