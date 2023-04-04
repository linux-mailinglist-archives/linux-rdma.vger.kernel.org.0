Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D526D58AE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 08:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjDDGVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 02:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjDDGVG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 02:21:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857FE67
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 23:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB9562512
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 06:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A3C433EF;
        Tue,  4 Apr 2023 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680589264;
        bh=+N39WED0T10agFsHdlUzhHPKeOkOKbaSWabMIFVDQcA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QaugL/4Mh5t4M279WXeMTvFs7dt3/HA3wQaotFV0djGKwTMUSKNaQPWFcKCbxMcWt
         UcJv2KgL6cucIJd69prTa8JvC5q/rkRdqkAM7CLi/j2fcJmozlE5SW7gqw7QNbG3FV
         +j2fiVZZUiBbdk1oR/skoknOgrnPV3BtEMdhUIkPSazQmOMI0gKAPIVKUzwg7H3XgI
         yWAJWfw78e4WALqK3fwE9jLJ9YaHKV00KMv1ZT+NXH/uMtPrgMbAR/GeBUHKQj51iG
         7nw3FlSOqCE1Dac+J3XMlVX29LgvT167xRIjATsnqBGfxWfhfVeRy3U6Shmd5wLT6r
         OiCFjqQWPlLZw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1680169540-10029-1-git-send-email-selvin.xavier@broadcom.com>
References: <1680169540-10029-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v3 0/7] RDMA/bnxt_re: Enable Congestion control
 by default
Message-Id: <168058926000.141327.4990371934819557720.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 09:21:00 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 30 Mar 2023 02:45:33 -0700, Selvin Xavier wrote:
> This series includes the code reorgnization in the
> driver control path. HW interface header file is updated
> to the latest version. Also, adds support for a new
> command format which is required for enabling RoCE
> congestion control.
> 
> This series is prepared on top of the resize_cq
> (https://lore.kernel.org/all/1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com/)
> patch which is under review.
> 
> [...]

Applied, thanks!

[1/7] RDMA/bnxt_re: Update HW interface headers
      https://git.kernel.org/rdma/rdma/c/a9a457f338e771
[2/7] RDMA/bnxt_re: Remove HW queue mapping from RoCE Driver
      https://git.kernel.org/rdma/rdma/c/b400acee0622d5
[3/7] RDMA/bnxt_re: Convert RCFW_CMD_PREP macro to static inline function
      https://git.kernel.org/rdma/rdma/c/e576adf583b525
[4/7] RDMA/bnxt_re: Reduce number of argumets to control path command APIs
      https://git.kernel.org/rdma/rdma/c/ff015bcd213b5d
[5/7] RDMA/bnxt_re: RoCE slow path TLV support
      https://git.kernel.org/rdma/rdma/c/0722f1f7bf85c8
[6/7] RDAM/bnxt_re: Use tlv apis while processing the slow path commands
      https://git.kernel.org/rdma/rdma/c/c682c6eda08140
[7/7] RDMA/bnxt_re: Enable congestion control by default
      https://git.kernel.org/rdma/rdma/c/f13bcef04ba046

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
