Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95077AE97D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjIZJni (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjIZJnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:43:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76905EB;
        Tue, 26 Sep 2023 02:43:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94144C433C9;
        Tue, 26 Sep 2023 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695721411;
        bh=62Ms2RdlEUDykhXpqwiq2jDEjnzL81U/ZQEs+uHkKxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ho38iDJqkErZAlYQJAGYYewQFHKBA47CdYXunzVInFmKO29dbWXPohvw1IJWQsIii
         4gMUji6hWrJoKyIRWGHIkgPxfisKYm4MDfNuRajfQnFBbyHaM66Pd3JOvsyL6ejG8r
         25WzYYU1pRxslm4f2LzEAzEyba2f3PPktSWd4k0Ie7PiZ3/ASjnnpylDnM7T2E2jCJ
         1bwBGkZRo/9YQkSIlxW+3aRGJLIVkOeLY+Xzgz3nPp5efEjnmhyjW6ZWeD2Tr0Uspj
         IccmdORTdbeGz65lA1Sj3mUlnQPFOB16D5x+cSEh7un8izQ6/pwXPoyepTuE3SoPi8
         50vOP3CPI4hzg==
Date:   Tue, 26 Sep 2023 12:43:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        rpearsonhpe@gmail.com, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20230926094327.GI1642130@unreal>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <841c0cf2-48f6-4a3c-a991-aaa5a737a9af@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841c0cf2-48f6-4a3c-a991-aaa5a737a9af@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 22, 2023 at 09:42:08AM -0700, Bart Van Assche wrote:
> On 9/22/23 09:32, Zhu Yanjun wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > This reverts commit 9b4b7c1f9f54120940e243251e2b1407767b3381.
> > 
> > This commit replaces tasklet with workqueue. But this results
> > in occasionally pocess hang at the blktests test case srp/002.
> > After the discussion in the link[1], this commit is reverted.
> > 
> > Link: https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#t [1]
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > CC: rpearsonhpe@gmail.com
> > CC: matsuda-daisuke@fujitsu.com
> > CC: bvanassche@acm.org
> > CC: shinichiro.kawasaki@wdc.com
> 
> Shouldn't the Cc-list occur before the Signed-off-by tag? Anyway:

chackpatch didn't complain, so I took it as is.

> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks
