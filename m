Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3F5E5F1A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIVJ4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiIVJ4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 05:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA9D575F
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 02:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1691B62A82
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 09:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E4AC433C1;
        Thu, 22 Sep 2022 09:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663840509;
        bh=D6GTw1zpOqodzbILB77tzfeOxiXBkAqlMxEQnsqgSA8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eWF9RMwIbiWmdLT9DBCWKqprbloludtMljCY1ZPPq6Ejg6vwyVHLt6WBjiTAtFI2S
         LbCsTHGkLBVQpJ++G1m5TGl0di1yQcf5EuVHBD4o5amDMbrMlgRjEIoFONQ6w9NM9f
         E+LQVw97gjcFL7gbWpLwiw69zxhkTYyqmFz3/oFYICDVpTze+kundpCLyj+z2xWPbQ
         gy3Sa/C6YDE4Ek8VscZQytpCOhC3Jci4nw51iHxEpN17O3aJzAmtBKnQtS08fOnMNE
         Gq+jZstgFv0XsGZ89CQRbFEb5lXdrMocpTQbDHaay3CTu7kobPmyB3BjnkJHML5nVB
         0RUISPZ8tLV6Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, zyjzyj2000@gmail.com,
        Leon Romanovsky <leon@kernel.org>
Cc:     yishaih@nvidia.com
In-Reply-To: <20220921080844.1616883-1-matsuda-daisuke@fujitsu.com>
References: <20220921080844.1616883-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH v2 1/2] IB: Set IOVA/LENGTH on IB_MR in core/uverbs layers
Message-Id: <166384050528.1028734.983378336970814695.b4-ty@kernel.org>
Date:   Thu, 22 Sep 2022 12:55:05 +0300
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

On Wed, 21 Sep 2022 17:08:43 +0900, Daisuke Matsuda wrote:
> Set 'iova' and 'length' on ib_mr in ib_uverbs and ib_core layers to let all
> drivers have the members filled. Also, this commit removes redundancy in
> the respective drivers.
> 
> Previously, commit 04c0a5fcfcf65 ("IB/uverbs: Set IOVA on IB MR in uverbs
> layer") changed to set 'iova', but seems to have missed 'length' and the
> ib_core layer at that time.
> 
> [...]

Applied, thanks!

[1/2] IB: Set IOVA/LENGTH on IB_MR in core/uverbs layers
      https://git.kernel.org/rdma/rdma/c/241f9a27e0fc0e
[2/2] RDMA/rxe: Use members of generic struct in rxe_mr
      https://git.kernel.org/rdma/rdma/c/954afc5a8fd857

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
