Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7349B622C5E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 14:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKIN3D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIN3C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 08:29:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBBD1D66E
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 05:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A65861AA5
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 13:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA41C433D6;
        Wed,  9 Nov 2022 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668000540;
        bh=hkVEzAWYdd70mgBTj4oQ/NnTgpTgkCVGvJ/bt4EIHvM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f4T8F8f/TDEsxUCpP/19CDLqvEclCN/AzF7loYmb32kD84iwKNwA5SVDq6rvLZQNb
         EJbpYlSTcw8Or5CUjEeEkNtrJ7kv7VhgugUB0wFqA5byiAPfJn0p71WSeshezv9col
         EEUkJ7n20DP/QX4x6zH54PqsiJQqKV6hJ4lBt+cYGZmaXIZK7x3AkHx+kESDN6b2pq
         RrHkJkLL4fMKIKpcGq4P7vcEnWUaNk3UwX4rb3ENHwIznJI3XgbIXftLB4fD26lW9o
         XP8ukVkHYDFwZLTUiBvSQ5FgLnp1tE4orb2mqW5L8EmL8xT+qrrYS7uFRBLk0V7dTM
         jF/R5RYZX5GDQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Leon Romanovsky <leon@kernel.org>, Tom Talpey <tom@talpey.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20221107145057.895747-1-bmt@zurich.ibm.com>
References: <20221107145057.895747-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH v3] RDMA/siw: Fix immediate work request flush to completion queue.
Message-Id: <166800053674.239241.12595103401479051166.b4-ty@kernel.org>
Date:   Wed, 09 Nov 2022 15:28:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 7 Nov 2022 15:50:57 +0100, Bernard Metzler wrote:
> Correctly set send queue element opcode during immediate work request
> flushing in post sendqueue operation, if the QP is in ERROR state.
> An undefined ocode value results in out-of-bounds access to an array
> for mapping the opcode between siw internal and RDMA core representation
> in work completion generation. It resulted in a KASAN BUG report
> of type 'global-out-of-bounds' during NFSoRDMA testing.
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Fix immediate work request flush to completion queue.
      https://git.kernel.org/rdma/rdma/c/bdf1da5df9da68

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
