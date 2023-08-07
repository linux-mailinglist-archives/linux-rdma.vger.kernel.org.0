Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7A772702
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjHGOGB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjHGOFm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 10:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748E1BCA
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 07:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C73261CB7
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 13:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123ECC433C8;
        Mon,  7 Aug 2023 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691416635;
        bh=ckXFOfld9MY1kW1RZMkWY8vaVn0YxPwL48zr/gQUhg0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=G+6AqB1stnaRC6zcNFsL9JL+8hxVn2M0Eiyya9PwvrOvm4Hqs0tuZo+17XUaIR8+o
         +AG+VSlbZDXc2B01t5Fyd0+Ip2ahCSIDxzGJLBObql2Z+87+edfH1e0Y7YBCZGkrMo
         U3x0PUk1E8HCH7GlUsIZxurwG0yTb2wqoAlDJAxplngu7TTiArNhlETUm1qCr10EoB
         LPk2zdReYrI+ePp0L0uwf/UcaDrIwFJ0VyMG6Ry+aawMZMfacpePhJaJORqmYuz3R6
         est26TaRLLCISPnb8JdJu49+EDLf1RkgS/GmkYbe1j7WildGCdWKv8vuZAK1buLrvI
         Tw1YMa7IDYYyg==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230804082102.3361961-1-ruanjinjie@huawei.com>
References: <20230804082102.3361961-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] RDMA: Remove unnecessary NULL values
Message-Id: <169141663229.101594.7094278161563486474.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 16:57:12 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 04 Aug 2023 16:21:01 +0800, Ruan Jinjie wrote:
> The NULL initialization of the pointers assigned by kzalloc() first is
> not necessary, because if the kzalloc() failed, the pointers will be
> assigned NULL, otherwise it works as usual. so remove it.
> 
> 

Applied, thanks!

[1/1] RDMA: Remove unnecessary NULL values
      https://git.kernel.org/rdma/rdma/c/849b1955ade1c6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
