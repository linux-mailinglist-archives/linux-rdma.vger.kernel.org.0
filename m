Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29F26B8F21
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 11:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCNKB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNKB1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 06:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972778C533
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 03:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 314C9616E4
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 10:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A65DC433D2;
        Tue, 14 Mar 2023 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678788085;
        bh=H4lsA5TRTWRbavAQfXGuBzuSKmjFtOp3+squAMZUT8w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=puGnAd7LhAcv9aV7TikUK4qGvO+jgBuuZhc8sIG4zJqF5QTJnBSiB/NtM7PWU5pHT
         W6s3VKDXCSJjX/CUdVFnQi1dfZ8p129fLSvmVpMR4T4UsTmUOTGiJpgQ2z5LlWnmSd
         bSaKB3zN5XimiP3GiISSwMzqvNNKYFXDnOQ+Mm/itqcxOtNgfVsOUK03Eh8xga+Ec/
         A4pbkBjPPOs219F15NgOX5V84AhzWrl2FP1EV12AD88abJNaufWopUb5hEuuHjDnAc
         dqlMph15rytz2S04wAlYFGviEd7GgApH9HOQzewOpdAP4/b+6kAdRpwoB50peP1iMZ
         ky5iYC83xoCRQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
In-Reply-To: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
References: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
Subject: Re: [PATCH for-next 0/2] Support query vf caps
Message-Id: <167878807830.136753.8799011229827347077.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 12:01:18 +0200
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


On Sat, 04 Mar 2023 17:15:53 +0800, Haoyue Xu wrote:
> VF originally used default caps in the driver.
> The patchset add a command to query the VF's caps,
> which makes it more extensible.
> 
> Yixing Liu (2):
>   RDMA/hns: Add new cmq command to support query vf caps
>   RDMA/hns: remove set_default function
> 
> [...]

Applied, thanks!

[1/2] RDMA/hns: Add new command to support query vf caps
      https://git.kernel.org/rdma/rdma/c/faa63656fc361e
[2/2] RDMA/hns: Remove set_default function
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
