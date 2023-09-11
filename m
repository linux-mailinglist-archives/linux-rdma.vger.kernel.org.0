Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6C79BAA5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 02:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357882AbjIKWGp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbjIKLQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 07:16:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC55CDD
        for <linux-rdma@vger.kernel.org>; Mon, 11 Sep 2023 04:16:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6713C433C8;
        Mon, 11 Sep 2023 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694431010;
        bh=SL2L7Zw9Gn7+biHqCLNL6iFpm0hJQCJV3Yl8MqoI3WE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=npBTRtSFdXEhgDZAd+UnMoO+UELECSWvSfhyb//pdgRlDSzwGGH2X8Foa6Xng+GQz
         c6MOudfOAJcaBXP6VTaP93BLUWn2ZSxFGyCWv8RdmsAtXl2WjlsEyNLpjrI87czJgU
         MnZXaPAig4A1YSN+BAK0MwUR6okMUAfNpAWrKiVxfsTyKW+3RdwT+NhSlrpy+vnH3k
         rs4heBMZHDPXI31iee5pxggRYWtLwNE2MdpiCNYBjPJgbcuz788qCRKe3XPTPiD/wy
         0oIKtxch/Y2ulnw6IHh5R4O3Q074E163gKAlD6Z2tQ/PoGjWHY1nN7WtIjmKYjQ9T9
         WKFPfzbFiPNlw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230823205727.505681-1-bvanassche@acm.org>
References: <20230823205727.505681-1-bvanassche@acm.org>
Subject: Re: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Message-Id: <169443100708.188090.4269211286002216085.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 14:16:47 +0300
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


On Wed, 23 Aug 2023 13:57:27 -0700, Bart Van Assche wrote:
> After scmd_eh_abort_handler() has called the SCSI LLD eh_abort_handler
> callback, it performs one of the following actions:
> * Call scsi_queue_insert().
> * Call scsi_finish_command().
> * Call scsi_eh_scmd_add().
> Hence, SCSI abort handlers must not call scsi_done(). Otherwise all
> the above actions would trigger a use-after-free. Hence remove the
> scsi_done() call from srp_abort(). Keep the srp_free_req() call
> before returning SUCCESS because we may not see the command again if
> SUCCESS is returned.
> 
> [...]

Applied, thanks!

[1/1] RDMA/srp: Do not call scsi_done() from srp_abort()
      https://git.kernel.org/rdma/rdma/c/e193b7955dfad6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
