Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F46B76FD
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Mar 2023 12:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCML5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Mar 2023 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCML5M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Mar 2023 07:57:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23A49E8;
        Mon, 13 Mar 2023 04:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E141B80DFD;
        Mon, 13 Mar 2023 11:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F31C433EF;
        Mon, 13 Mar 2023 11:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678708628;
        bh=QavBPPZ0mNNEzUh/31J0LQBKpXwXqiqNCg0R9a4pGmY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SIWV2JJ/AntNt7BYwvdZSn/6HXmKgdR67KrfzbK1dBeCV1yPI3s+gmMbmpwbPQaZM
         if8+X7HCT0YfCzjS/qbSCzmRTjCisWlAA+c56xENbSWyaTJl57mAk2N7d63fr9jnRn
         m3O79+2QJGW2jko19JCabQ+w4kMyKLXjiq+YlfBkNYfjICYsnGziooeUES8p3+9LFv
         kv7L3QFkqFbknvtH0PRxHRM9qUz0vgyodYYLGMW8B5LDHocU/4YXkEDQFok7OiZtSp
         BuhBFYWLYzrhNhgRF5hJYHiro4ouKmS3t+JQYTIGII6UpfMgBGcHt0F0YLp1pB8zNR
         JRz8ps1nUCKCg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Zhang Yi <yizhan@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230218185701.never.779-kees@kernel.org>
References: <20230218185701.never.779-kees@kernel.org>
Subject: Re: [PATCH] IB/rdmavt: Fix target union member for rvt_post_one_wr()
Message-Id: <167870862523.139716.15466485320886964551.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 13:57:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sat, 18 Feb 2023 10:57:05 -0800, Kees Cook wrote:
> The "cplen" result used by the memcpy() into struct rvt_swqe "wqe" may
> be sized to 80 for struct rvt_ud_wr (which is member "ud_wr", not "wr"
> which is only 40 bytes in size). Change the destination union member so
> the compiler can use the correct bounds check.
> 
> struct rvt_swqe {
>         union {
>                 struct ib_send_wr wr;   /* don't use wr.sg_list */
>                 struct rvt_ud_wr ud_wr;
> 		...
> 	};
> 	...
> };
> 
> [...]

Applied, thanks!

[1/1] IB/rdmavt: Fix target union member for rvt_post_one_wr()
      https://git.kernel.org/rdma/rdma/c/f2f6e1661d38fb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
