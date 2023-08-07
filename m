Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651ED772625
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjHGNlM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjHGNlA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 09:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8010EF
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 06:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D0561B74
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 13:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A36C433C7;
        Mon,  7 Aug 2023 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415600;
        bh=8B6l5RQitVIQPqT5qRpkYC10SkpnuoLZrAsP0htrRPA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mic/eQ4zEINqjJNMeqZICIldD/FxW8kyZuXHSglgxp7gLQzMseDqizC53oh5fH4LW
         wTAoQpsnnfWJEgsmmKV7FQ+/tKd95EyJprkULnw+0QTOKm8PyqZu1q92FjN9MbEtOP
         fhe45w978FWDMzvU2+lYgLDSstvyvQVAg9UGS83N47+hcLqG68ZOisiYV5wbCadlOK
         BrtE2+fDZ1ba9c1fe5qF1H0WzDet8bkrgMjTfDtH/I/uyfHA8COfLDAFHtbFihZd61
         Q65TQlor9K5XdMvxU/sPIbbDyEaSbfSOPdvRFFE7S2jVU/9slarN77iXsugilrOsAz
         t24bz8D3Dk6sA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1691052326-32143-1-git-send-email-selvin.xavier@broadcom.com>
References: <1691052326-32143-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2 0/6] RDMA/bnxt_re: Driver minor update
Message-Id: <169141559639.89303.7018669101491490264.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 16:39:56 +0300
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


On Thu, 03 Aug 2023 01:45:20 -0700, Selvin Xavier wrote:
> Includes some of the minor cleanup and update on the driver.
> Please review and apply.
> 
> Thanks,
> Selvin
> 
> v0 -> v1:
>     - Corrected patch 2 which had unrelated changes belonging to patch 3
> 
> [...]

Applied, thanks!

[1/6] RDMA/bnxt_re: Fix max_qp count for virtual functions
      https://git.kernel.org/rdma/rdma/c/f19fba1f79dc1f
[2/6] RDMA/bnxt_re: Remove a redundant flag
      https://git.kernel.org/rdma/rdma/c/fd28c8a8c7a10e
[3/6] RDMA/bnxt_re: Fix the sideband buffer size handling for FW commands
      https://git.kernel.org/rdma/rdma/c/c9f3e4e1d862f6
[4/6] RDMA/bnxt_re: Cleanup bnxt_re_process_raw_qp_pkt_rx() function
      https://git.kernel.org/rdma/rdma/c/e59a5cec3f8ac7
[5/6] RDMA/bnxt_re: Avoid unnecessary memset
      https://git.kernel.org/rdma/rdma/c/00d0427fd8ce03
[6/6] RDMA/bnxt_re: Remove unnecessary variable initializations
      https://git.kernel.org/rdma/rdma/c/14611b9b984125

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
