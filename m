Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7B5BEC91
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 20:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiITSKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiITSK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 14:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5470E0DF
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 11:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A6E7B82C08
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 18:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716DC433C1;
        Tue, 20 Sep 2022 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663697426;
        bh=kcuw0CtMPZ+9i6fyWfCv/0wsjTtddx2wbZ3VWoKPjqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=do21peB6N90So/PLyzIAuSzwwYfNrB/JQ0jkKbIQszp1DFYUtUiZ6KZ4WYZyQTQBe
         lRItRe5FXPZ3vxCyRJ8PdeCw9Z91uw06/nB50lUlSxb4O+f/p+3eSulSrmpb10qTVn
         GLUL0P57wgmDT+WiOrokDRV2B9ysHNp7W7aX7WJnkWsHHkqwM7bVtZz9Uw3xQVGZHN
         He9Ek5QnIs12TMG4oGfq7Wi5539rlb89w4eDa6ejbeoyPPDnqmdKSiiQ9NAVDexVjp
         eE8BWwLYSgFdKFakIPokwuSw+V1kths1gq9zwtXV5pH30I4bvUyebdpAFXudBTJ+Mk
         yv+WNTfz0vdag==
Date:   Tue, 20 Sep 2022 21:10:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Remove redundant num_sge fields
Message-ID: <YyoCDuh24to8k6rn@unreal>
References: <20220913222716.18335-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913222716.18335-1-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 13, 2022 at 05:27:17PM -0500, Bob Pearson wrote:
> In include/uapi/rdma/rdma_user_rxe.h there are redundant copies of
> num_sge in the rxe_send_wr, rxe_recv_wqe, and rxe_dma_info. Only the
> ones in rxe_dma_info are actually used by the rxe driver. This patch
> replaces the ones in rxe_send_wr and rxe_recv_wqe by reserved. This
> patch matches a user space change to the rxe provider driver in
> rdma-core. This change has no affect on the current ABI and new or old
> versions of rdma-core operate correctly with new or old versions of
> the kernel rxe driver.

I don't see how. Old rdma-core has rxe_post_one_recv() function that
uses num_sge in struct rxe_recv_wqe.

Thanks
