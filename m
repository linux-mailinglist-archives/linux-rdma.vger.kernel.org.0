Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0407A9755
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjIURWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIURW1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:22:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109844F5B
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:13:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D137EC116D6;
        Thu, 21 Sep 2023 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695286608;
        bh=jQ1EWEvBpLh3BYqFfcE9uDp6iyRI/j+mkJMj85XfgEY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rgA2oVDt8m7J63jC7EjsQ9/8tsd3j72q0wxdXrEr8v7II+rc09QUYAqfOsdX849G0
         aQHL25/pZX2HmcwGHfALYu/aWqdo4JB7TO381TdY8+MT1KqqeG9LD8Oh14fjHCXbIH
         xiraFLB0oFzu2RDgje6Yx4WWoGHgG+TZmpCPkCm1gkyIwZTHhbsMSrTUnHvrvtY3tp
         0/lH0f5bmO+C/T6ZVjmEvDQpHAx+yQM9cd6l2wCV5kjwqyFe7O07lgLeMf1b22rv3z
         OKybGJPeL1+1N70HnMsXTeCRS4YQPaakazKlBqkY9UbCxhmxu6V6Ek5d9UR+XjaGfu
         16DQfjIT+LHBw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1695199280-13520-1-git-send-email-selvin.xavier@broadcom.com>
References: <1695199280-13520-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc 0/2] RDMA/bnxt_re: Bug fixes
Message-Id: <169528660403.2412302.319180607902415174.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 11:56:44 +0300
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


On Wed, 20 Sep 2023 01:41:18 -0700, Selvin Xavier wrote:
> Couple of important bug fixes for bnxt_re driver.
> Please review and apply
> 
> Thanks,
> Selvin Xavier
> 
> Selvin Xavier (2):
>   RDMA/bnxt_re: Fix the handling of control path response data
>   RDMA/bnxt_re: Decrement resource stats correctly
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Fix the handling of control path response data
      https://git.kernel.org/rdma/rdma/c/9fc5f9a92fe689
[2/2] RDMA/bnxt_re: Decrement resource stats correctly
      https://git.kernel.org/rdma/rdma/c/a83c6927897522

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
