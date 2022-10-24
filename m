Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEAE60A1DD
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJXLev (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiJXLeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 07:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C0D6554E;
        Mon, 24 Oct 2022 04:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A235D61257;
        Mon, 24 Oct 2022 11:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FD7C433D6;
        Mon, 24 Oct 2022 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611175;
        bh=7BGHQHEyIWOIzS0pMtVWlxKJaXlGCMxezrqu+7yaTss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uw+hVdHKnZrYz0PuQ00ENoyyjVXg+4uc8Q3aq272bmX9jhXRbMXCygU13/ntbghJw
         XU2Pa2Fa9nwLtVX/FaFi9zDk3DdEqB/fRwyPlAQQkRfdMwCWntyuScIAltM1RWs8qH
         sDhzDiAYR/jn6KS3+xFyhfV4KvObCIA/E3Mg3vSoLHFSl0zg+QFJWANdB4xS9smUGN
         RjQ2jqfKBA9mC9NWF0/nIw6uJzi5KdIcASJcmt9iNWGYa0F7o7yJqDsXEqQQkIFB16
         gC+YfwKgt4USBsKFJPjTYwyr2MLuSgDzih+nKyE9YGt+ktpw7PHPaEJh0n8HDifmuf
         pqggHLJDRPwQQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221021173504.27546-1-colin.i.king@gmail.com>
References: <20221021173504.27546-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] RDMA/hw/qib/qib_iba6120: Remove variable freeze_cnt
Message-Id: <166661117102.858492.18326237882024365860.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 14:32:51 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 21 Oct 2022 18:35:04 +0100, Colin Ian King wrote:
> The variable freeze_cnt being incremented but it is never referenced,
> it is redundant and can be removed.
> 
> 

Applied, thanks!

[1/1] RDMA/hw/qib/qib_iba6120: Remove variable freeze_cnt
      https://git.kernel.org/rdma/rdma/c/5dc1b37d75e713

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
