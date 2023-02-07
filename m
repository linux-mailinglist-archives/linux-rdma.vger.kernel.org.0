Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3968D2BD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBGJ0C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 04:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBGJZ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 04:25:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7564EF8;
        Tue,  7 Feb 2023 01:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 448C6B8184D;
        Tue,  7 Feb 2023 09:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686CFC433EF;
        Tue,  7 Feb 2023 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675761955;
        bh=kIdQEAUb5e7dtgZYMz1MhtSgopeTZ8mzR7W7ybsVRfc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mbk8lisHUr08D9VrDI3ZzZStrkEa9WaTcPuud6nA/0TjKnA1OiJ0Ynexzr+OhtPxR
         DA+G/PH+yEHfMoUyr9ICjm9M7DK66eRQs0Q+opDsn4VMUxwn7V46JXHfnvDjQywlUk
         2tirJ1RMWdfHsk05G8vgbyhjOdUa5XAY8pj3tIjoi7SLhewFvutFoWerw1BEIFW7Rd
         uNRngCwhVGKMvsuCmzjGdsjdjZ4yaFjNvB0jZD52J8yaSxKxzcRE1BNS6oQn3+LYN4
         pQYbz13sey8H2l6+TMvgrDUA2KBBLCb5DHF1THV49SE1drDuNFZLepLCFFilnVmgxd
         E61T1mjVtIJSw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Deming Wang <wangdeming@inspur.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230206085725.1507-1-wangdeming@inspur.com>
References: <20230206085725.1507-1-wangdeming@inspur.com>
Subject: Re: [PATCH] RDMA/restrack: Correct spelling
Message-Id: <167576195204.83389.8139666261783322059.b4-ty@kernel.org>
Date:   Tue, 07 Feb 2023 11:25:52 +0200
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


On Mon, 06 Feb 2023 03:57:25 -0500, Deming Wang wrote:
> We should use this replace thie.
> 
> 

Applied, thanks!

[1/1] RDMA/restrack: Correct spelling
      https://git.kernel.org/rdma/rdma/c/68e416255b29c2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
