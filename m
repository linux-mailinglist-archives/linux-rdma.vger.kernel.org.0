Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396E368BE9A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjBFNp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 08:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjBFNpN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 08:45:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A09659C;
        Mon,  6 Feb 2023 05:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 91A6ECE1AC7;
        Mon,  6 Feb 2023 13:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75942C433EF;
        Mon,  6 Feb 2023 13:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675691079;
        bh=Ujb/6P2ANHtL9hFF77fnr0gaWWNARSDY9be0pRDF3XU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a7dnuy1A5Y99Wac85h5T2Bn2WS4EPbXwdefTChmBPtwYbzRCNt4EmgHBM8vw4iCCb
         5i3ictHyRLcYZ9D8XeeYycCEK5+7VdmKfX2XeC7mpTv3t1KwlGGp+JrkhD6gSEPkyY
         mo9OUXSjyPlMQow/uNHN+u16mo0UozqnpDIXnw5gTO4EN/zPSI1v5C1I+hYi2wAIhG
         6ACPxBtM+IyLkasDrzIwlEmXHfMc9Ye65YaY1SBT7/9WWchF799BiyXGV2Wec+obMk
         3xeYAwL3Jn47zDLrFsNt4oPt7U20nmL7DIwAMNCAwO7+KAkkoY9YjGsHJ0fCtd4es9
         SQ5VQyaDkIjew==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1675328463.git.leon@kernel.org>
References: <cover.1675328463.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/2] Two small fixes to MR cache series
Message-Id: <167569107660.132054.4636386341295363708.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 15:44:36 +0200
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


On Thu, 02 Feb 2023 11:03:05 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> There are two small patches with fix and cleanup to previously accepted
> MR cache series from Michael.
> 
> [...]

Applied, thanks!

[1/2] RDMA/mlx5: Fix MR cache debugfs in switchdev mode
      https://git.kernel.org/rdma/rdma/c/828cf5936bea24
[2/2] RDMA/mlx5: Remove impossible check of mkey cache cleanup failure
      https://git.kernel.org/rdma/rdma/c/85f9e38a5ac7d3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
