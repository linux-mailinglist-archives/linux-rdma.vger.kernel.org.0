Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB47C9867
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Oct 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJOIwW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Oct 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOIwW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Oct 2023 04:52:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA21C5
        for <linux-rdma@vger.kernel.org>; Sun, 15 Oct 2023 01:52:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D56C433C8;
        Sun, 15 Oct 2023 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697359939;
        bh=fiN5NUy0MTPzzEoXWlR1VnXuyjKmv/Ylc7fCSPOdxs0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NqApVh8oZsigpADx0B7VPsSYFLgT03eEJYYCjCMaG8zmS9JF+zjeTYRn+9IiD/XD0
         69TesQY26L+7tHxVZLzl8SyI0zVSsHoRUMEVlInLnbSdbCdQQXo0j/TTuF3xzOvuvx
         2/lh1HPa6BXUJODBHHjdRDjHRH41kdeW4a+BFPLs8tmhGXjoagtVqf2M1yCs/CQyU6
         nf42ZwWCvQJcyhXXHhfJmgxirrtCygetsWTxDP8rhdBD+F1Lrt2Jc5Vc8CsieI/57+
         OgwSYZCH9pd0Mz5MKBCNl3oxcjxnU+gIS//5k5GAOd0uPLX9qE92Tvq3r6B+uG8ae6
         Ia9s7aqVEqf8w==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1697049097-31992-1-git-send-email-selvin.xavier@broadcom.com>
References: <1697049097-31992-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2 0/3] RDMA/bnxt_re: Async events update
Message-Id: <169735993561.75872.12541719363346694941.b4-ty@kernel.org>
Date:   Sun, 15 Oct 2023 11:52:15 +0300
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


On Wed, 11 Oct 2023 11:31:34 -0700, Selvin Xavier wrote:
> Reports async error events received from the HW.
> Please review and apply
> 
> Regards,
> Selvin
> 
> v1 -> v2:
> 	- Remove couple of unused defines in patch 1
> 	- Avoid dev_err and use ibdev_err/ibdev_dbg
> 
> [...]

Applied, thanks!

[1/3] RDMA/bnxt_re: Update HW interface headers
      https://git.kernel.org/rdma/rdma/c/d60a779673defc
[2/3] RDMA/bnxt_re: Report async events and errors
      https://git.kernel.org/rdma/rdma/c/b02fd3f79ec326
[3/3] RDMA/bnxt_re: Do not report SRQ error in srq notification
      https://git.kernel.org/rdma/rdma/c/45cfa8864cd3ae

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
