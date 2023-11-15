Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC07EC437
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKON65 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 08:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjKON64 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 08:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329C122
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 05:58:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD8C433C8;
        Wed, 15 Nov 2023 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700056732;
        bh=XgW4ggj7Ob6iqGZmppbmgiAxD83Uul0UZRJcGYl5ovk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L8ekdbSf8cEsrpx/LkBZOhv8uhB11g+CGeo9RR69S1xO2w2t9kJQUSrJkhpRHvEPu
         Mmv9ACagrxzaxCjtX9di4nKfwnPjdejG+qYpEthaO4JNaCTeJ1mHeESKXZOnnXkeYM
         DLCkWPxVR9Yc/rgCSSOQwH/lSOjBaeX9QFu+fI0fPm851gBYuGtXvioBVrCY4XCjXm
         NoyitppXfPRr492HpULNulUtPBRcBfw5Z0wCb+OME2qx0tj1iFTuMH4nLDHNRuWHWL
         0V3MkVHQOJrBPsbvUCMGVgd8y1xNuPWOd2wl0BTEf5B5lfdcGcjtbCmbVmevoj4bUI
         M8rwDNeaK1s5Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V5 00/17] Cleanup for siw
Message-Id: <170005672876.829880.1361673928158866012.b4-ty@kernel.org>
Date:   Wed, 15 Nov 2023 15:58:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 13 Nov 2023 19:57:09 +0800, Guoqing Jiang wrote:
> V5 changes:
> 1.  add Acked-by tags.
> 2.  rebase to latest rdma tree and remove one obsolete patch.
> 
> V4 changes:
> 1. add Acked-by tags.
> 2. update patch 3 and patch 12 per Bernard's review.
> 3. update patch header in patch 18.
> 
> [...]

Applied, thanks!

[01/17] RDMA/siw: Introduce siw_get_page
        https://git.kernel.org/rdma/rdma/c/3a179fe34acbd5
[02/17] RDMA/siw: Introduce siw_update_skb_rcvd
        https://git.kernel.org/rdma/rdma/c/a2b64565e8ea95
[03/17] RDMA/siw: Use iov.iov_len in kernel_sendmsg
        https://git.kernel.org/rdma/rdma/c/2109ddf032ebc5
[04/17] RDMA/siw: Remove goto lable in siw_mmap
        https://git.kernel.org/rdma/rdma/c/d248960941b71e
[05/17] RDMA/siw: Remove rcu from siw_qp
        https://git.kernel.org/rdma/rdma/c/659da08ed83a67
[06/17] RDMA/siw: No need to check term_info.valid before call siw_send_terminate
        https://git.kernel.org/rdma/rdma/c/065186d228c528
[07/17] RDMA/siw: Factor out siw_rx_data helper
        https://git.kernel.org/rdma/rdma/c/60d2136db8780b
[08/17] RDMA/siw: Introduce SIW_STAG_MAX_INDEX
        https://git.kernel.org/rdma/rdma/c/6a343cc3bf2626
[09/17] RDMA/siw: Add one parameter to siw_destroy_cpulist
        https://git.kernel.org/rdma/rdma/c/25680c1f261475
[10/17] RDMA/siw: Introduce siw_cep_set_free_and_put
        https://git.kernel.org/rdma/rdma/c/b5c91543204c34
[11/17] RDMA/siw: Introduce siw_free_cm_id
        https://git.kernel.org/rdma/rdma/c/08456d4db73bbb
[12/17] RDMA/siw: Cleanup siw_accept
        https://git.kernel.org/rdma/rdma/c/77b59bd932a026
[13/17] RDMA/siw: Remove siw_sk_save_upcalls
        https://git.kernel.org/rdma/rdma/c/a410a732787026
[14/17] RDMA/siw: Fix typo
        https://git.kernel.org/rdma/rdma/c/3beced14d1998c
[15/17] RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp
        https://git.kernel.org/rdma/rdma/c/788bbf4c2fc6e0
[16/17] RDMA/siw: Introduce siw_destroy_cep_sock
        https://git.kernel.org/rdma/rdma/c/d9a5b48681315a
[17/17] RDMA/siw: Update comments for siw_qp_sq_process
        https://git.kernel.org/rdma/rdma/c/79844118d6c1cd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
