Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3C67AE97F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjIZJoI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZJoH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:44:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF3BE;
        Tue, 26 Sep 2023 02:44:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A09C433C8;
        Tue, 26 Sep 2023 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695721440;
        bh=dB6sbCtc5H37TznyIQ+wI0o/JASQmuYCNLmI1Wkz8SE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DJKTqSqzNsmFkTEVnmyfSZY6crH50dRJ7EHsL7zzdmcyVClrKlybNylwtBi4KAajH
         +ysNBl5iFqYBMtQcJcO2gDkBjGX+WNv65+ArN+hH7QFy9MMJjQ9da4zepUvCH9Pj/G
         30iAf9iIY1o0D6MAha1Cp5Bfkzi5kSIHmqfvg+49d+IjDHcPiSQ3xxorC+jkm+iEmp
         0bdJqzfBq97NMYorQQ0vs25TCAMhPKhwhh/nqMFMMLr/CNU4vsK1ntZEMqwyb2MWnn
         QqwCzmDq407SbQcUcecfMZ+ZAaVECys6BJhjkwHlGIQodJ7iC1YY4cCSVifeM9Bd38
         L0q4CfWFSMLaw==
From:   Leon Romanovsky <leon@kernel.org>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        rpearsonhpe@gmail.com, matsuda-daisuke@fujitsu.com,
        bvanassche@acm.org, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230922163231.2237811-1-yanjun.zhu@intel.com>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe tasks"
Message-Id: <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 12:43:57 +0300
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


On Fri, 22 Sep 2023 12:32:31 -0400, Zhu Yanjun wrote:
> This reverts commit 9b4b7c1f9f54120940e243251e2b1407767b3381.
> 
> This commit replaces tasklet with workqueue. But this results
> in occasionally pocess hang at the blktests test case srp/002.
> After the discussion in the link[1], this commit is reverted.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "RDMA/rxe: Add workqueue support for rxe tasks"
      https://git.kernel.org/rdma/rdma/c/e710c390a8f860

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
