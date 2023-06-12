Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D172B8AF
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFLHfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjFLHfS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959910C4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E19662005
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAE6C433D2;
        Mon, 12 Jun 2023 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686553973;
        bh=3k/8TS9MX+4MH7Q6FxXV5qskd8KHZiJDATXCzmy98E8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tly+R2QNfoPV197tEYBHywKHXKNXGNy882B98qt7VQX0oJ/t4R+GxG3uR9/bCOoih
         +UeDjbPoPjMh6Qg2heonb9iqHjdm51+6m6fmIv3HKqZAPWr+gulH98w4sDFydUpTQO
         QV2d/+dUyOOybvxGLefKr+fZK0iMJN2WQ81AUT80Q1ha2kYXt/EeoxJZmgjl4HoKUM
         Kte8MAT0x72JFHCCPSsWXcUmm/Pt++hNvwofVJx43JVhZqrFbJ/kwIpibyqPtaevw5
         WBPbZ7ANyVAF3DfoGuNZYv1uRj1BvhsvEAThm9NoWpumwAV+KtghikYrV5oUqaSbGe
         NUIQoz6ZHh+3g==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        kashyap.desai@broadcom.com
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH v2 for-next 00/17] RDMA/bnxt_re: Control path updates
Message-Id: <168655396897.1341452.10993400316350894283.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 10:12:48 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 09 Jun 2023 04:01:37 -0700, Selvin Xavier wrote:
> This patch series from Kashyap includes code refactoring and some
> optimizations in the FW control path of the driver. It also address
> some of the issues seen as we scale up the HW resources.
> It also includes few bug fixes in the control path.
> 
> Please review and apply.
> 
> [...]

Applied, thanks!

[01/17] RDMA/bnxt_re: wraparound mbox producer index
        https://git.kernel.org/rdma/rdma/c/0af91306e17ef3
[02/17] RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
        https://git.kernel.org/rdma/rdma/c/3099bcdc19b701
[03/17] RDMA/bnxt_re: remove virt_func check while creating RoCE FW channel
        https://git.kernel.org/rdma/rdma/c/b021186bca9d6b
[04/17] RDMA/bnxt_re: set fixed command queue depth
        https://git.kernel.org/rdma/rdma/c/258ee04317dacf
[05/17] RDMA/bnxt_re: Enhance the existing functions that wait for FW responses
        https://git.kernel.org/rdma/rdma/c/8cf1d12ad56beb
[06/17] RDMA/bnxt_re: Avoid the command wait if firmware is inactive
        https://git.kernel.org/rdma/rdma/c/3022cc15119733
[07/17] RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
        https://git.kernel.org/rdma/rdma/c/65288a22ddd814
[08/17] RDMA/bnxt_re: Simplify the function that sends the FW commands
        https://git.kernel.org/rdma/rdma/c/159cf95e42a7ca
[09/17] RDMA/bnxt_re: add helper function __poll_for_resp
        https://git.kernel.org/rdma/rdma/c/354f5bd985af95
[10/17] RDMA/bnxt_re: handle command completions after driver detect a timedout
        https://git.kernel.org/rdma/rdma/c/691eb7c6110fe0
[11/17] RDMA/bnxt_re: Add firmware stall check detection
        https://git.kernel.org/rdma/rdma/c/b6c7256688264f
[12/17] RDMA/bnxt_re: post destroy_ah for delayed completion of AH creation
        https://git.kernel.org/rdma/rdma/c/84911cf3b2aa8d
[13/17] RDMA/bnxt_re: consider timeout of destroy ah as success.
        https://git.kernel.org/rdma/rdma/c/bb8c93618fb0b8
[14/17] RDMA/bnxt_re: cancel all control path command waiters upon error.
        https://git.kernel.org/rdma/rdma/c/a00278521c9107
[15/17] RDMA/bnxt_re: use firmware provided max request timeout
        https://git.kernel.org/rdma/rdma/c/f0c875ff629396
[16/17] RDMA/bnxt_re: remove redundant cmdq_bitmap
        https://git.kernel.org/rdma/rdma/c/bcfee4ce3e0139
[17/17] RDMA/bnxt_re: optimize the parameters passed to helper functions
        https://git.kernel.org/rdma/rdma/c/830f93f47068b1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
