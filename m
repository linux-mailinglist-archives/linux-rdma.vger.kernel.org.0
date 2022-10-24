Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B160B66A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJXS5L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiJXS4h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8B8BBB4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 10:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBD7612DC
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 11:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14CDC433B5;
        Mon, 24 Oct 2022 11:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612646;
        bh=nlblTCFo4p0BzL0A+EguurykHOrA2eEzEYHVVCHEaxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lL4bKdTrdT3HQgrvaOzh3FU68z05u45GmVzXjceHTCAsiyXIR2dMcOWyQU5qbC1bw
         c3vGzkfRuQ1XKytIw0xwJMY4MNRLuqfKpQ+Sz3Cv1ad4tQ81W0b/2Ez6xzAR5Q40Ew
         lyDgqaO99aFn8+EOLpCBQAssycUqF2+xymtLtuOkUYK+wbILdqciego/s0I4yCFF49
         gJ5uvow7f65Mb9X0ElSoeMhxEkTGVJ2e0z1LSfrcptz8ZTb+Jrwhtzc+me3ERbtT+o
         0q2HA+FlHA2TQGUQFratrbecxZhO5CsQJYWWARHMVa+HT3CYOVXSVU2OsX8zR71MPh
         JZU46RSrhxWtg==
Date:   Mon, 24 Oct 2022 14:57:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Message-ID: <Y1Z9oYf+nnY6B19L@unreal>
References: <20221021134513.17730-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021134513.17730-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 21, 2022 at 01:45:17PM +0000, yangx.jy@fujitsu.com wrote:
> The member 'type' is included in both struct rxe_mr and struct ib_mr
> so remove the duplicate one of struct rxe_mr.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>  2 files changed, 8 insertions(+), 9 deletions(-)

Please fix you From field and resubmit.

71d236399160 (HEAD -> build) RDMA/rxe: Remove the member 'type' of struct rxe_mr
WARNING: From:/Signed-off-by: email name mismatch: 'From: "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>' != 'Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>'


Thanks
