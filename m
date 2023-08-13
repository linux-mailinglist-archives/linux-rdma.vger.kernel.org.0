Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C977A569
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHMH2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMH2e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 03:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03841702
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 00:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E762961965
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 07:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77F4C433C8;
        Sun, 13 Aug 2023 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691911716;
        bh=6fBHAgDL9ZmM+3od8gwstUXxx2wzK+5Usg5ZJx8sP/E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fN3aRCYAo0DdpuDLCPtPqKojngq669xSGA29wl4NcM0AwcYkUquxDKycoLRdVdSNR
         HnvsMSlMAFBhTAHXRX0DruNa7JUmuut35mGcQL6ai/fusqAEfsZmO37alW6GhntI1S
         IO9dnZX/62qZUGwa/WPJhjc/2OQjF/ZrmSS9kgTYTlCeDE7Ovs2rYQY9HfkkVKo0Lf
         ds0hEY8ZBJ/eUQmhgMkZ5Vj2YAvIXwakNMcrUAWMfnLFMuuUzt6diftrs2AEYIGrTc
         pGAXGDWgRh2/nzt6HgEcIib6B1t1li5p/zhe7zupz95B+zuQ1zIxGaR8TEwcbaQjyu
         lvQ2pcoBbpk9A==
From:   Leon Romanovsky <leon@kernel.org>
To:     bharat@chelsio.com, jgg@ziepe.ca,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230731092106.10396-1-guoqing.jiang@linux.dev>
References: <20230731092106.10396-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH] RDMA/cxgb4: Set sq_sig_type correctly
Message-Id: <169191171197.21469.5432881419827889981.b4-ty@kernel.org>
Date:   Sun, 13 Aug 2023 10:28:31 +0300
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


On Mon, 31 Jul 2023 17:21:06 +0800, Guoqing Jiang wrote:
> Replace '0' with IB_SIGNAL_REQ_WR given the sq_sig_type is either
> IB_SIGNAL_ALL_WR or IB_SIGNAL_REQ_WR per the below.
> 
> enum ib_sig_type {
> 	IB_SIGNAL_ALL_WR,
> 	IB_SIGNAL_REQ_WR
> };
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: Set sq_sig_type correctly
      https://git.kernel.org/rdma/rdma/c/25944c068139f6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
