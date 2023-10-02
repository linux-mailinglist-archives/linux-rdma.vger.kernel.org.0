Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CC7B4DA0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjJBIxP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjJBIxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 04:53:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D517A4
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 01:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97581C433C7;
        Mon,  2 Oct 2023 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236792;
        bh=WcQ3PTrqQmHqZVtugKGZVgt1zwkBHJyvLmtR0gci0UU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DlL7+woGQpSIUPpoKgIKCeZtSNodFJfwZiilselwO+xiQm/t3w7E/UHVmAVP0DuuP
         r9T/6rQSBH88K1hRk0H2fHh9cTQNHnEB6W/0xr5ho77huKo/LxMS0sDwxeZTg8Zzrc
         sr5lskLRjqsT6GKpfFW3rbgHxQD/Iwlmlrt8Jh61UIBY2DfGuPR6HRlgIUr9ai3d43
         r/PG2zCB+LwNcDlubaBpkwn+dz410bxLR6LsPQGjawL6uB2jjNGuvgO+wzpZl4vUAj
         8icgZYWeHtZGhTNS0Y/lFXJUOQE/JUCS09YpLGItJd4hc0S4lMQ3nJNIUGHDb0qf7T
         ZjlidVerv3hTw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230927090511.603595-1-markzhang@nvidia.com>
References: <20230927090511.603595-1-markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next v1] RDMA/cma: Initialize ib_sa_multicast
 structure to 0 when join
Message-Id: <169623678837.26626.9443397569389736652.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 11:53:08 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 27 Sep 2023 12:05:11 +0300, Mark Zhang wrote:
> Initialize the structure to 0 so that it's fields won't have random
> values. For example fields like rec.traffic_class (as well as
> rec.flow_label and rec.sl) is used to generate the user AH through:
>   cma_iboe_join_multicast
>     cma_make_mc_event
>       ib_init_ah_from_mcmember
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Initialize ib_sa_multicast structure to 0 when join
      https://git.kernel.org/rdma/rdma/c/76ad7aca17e88e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
