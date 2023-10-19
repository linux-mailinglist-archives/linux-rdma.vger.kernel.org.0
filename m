Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BDE7CF07A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344781AbjJSGxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjJSGxs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 02:53:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62040123;
        Wed, 18 Oct 2023 23:53:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDBFC433C7;
        Thu, 19 Oct 2023 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697698426;
        bh=cJ1OVpAhokDLOXU7cNv1Jcafp2E7l2apei7YyBc+Q88=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=thxY00f751+mHUGUxLpVhoV0sXHIH3h7FQMZzexdKD/DBGNKAu9nGYNqIKADwasoi
         ujJnz6d6mjn56CdOA//kCwTJppyvwLVVPy2vgHzr2eeFM7hZ7c3ZhTJDd8Eej74oCV
         ACvz4KbI9boQkWpO+T0t53jRntfQMfFL5kfN/5lYfStrKcOKJgnXkIzQm+3rmSNuSM
         CFD5V0fqmzUOJnB1rlMbJu5lM2r8vsRpipH1YWnAO4l9EDHJIq8KvMG1glkRZduBev
         VhjzKWalymH9zsxrQ2tjeqYT6XvYTfn+WFouySvc2o4j+DA1XR5W0Roq755oNXwCfk
         iaZYyCNfH1opw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
References: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/7] Bugfixes for hns RoCE
Message-Id: <169769842213.2031402.8388555441032113135.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 09:53:42 +0300
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


On Tue, 17 Oct 2023 20:52:32 +0800, Junxian Huang wrote:
> Here is a patchset of several bugfixes.
> 
> Chengchang Tang (3):
>   RDMA/hns: Fix printing level of asynchronous events
>   RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
>   RDMA/hns: Fix signed-unsigned mixed comparisons
> 
> [...]

Applied, thanks!

[1/7] RDMA/hns: Fix printing level of asynchronous events
      https://git.kernel.org/rdma/rdma/c/9faef73ef4f666
[2/7] RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
      https://git.kernel.org/rdma/rdma/c/c64e9710f9241e
[3/7] RDMA/hns: Fix signed-unsigned mixed comparisons
      https://git.kernel.org/rdma/rdma/c/b5f9efff101b06
[4/7] RDMA/hns: Add check for SL
      https://git.kernel.org/rdma/rdma/c/5e617c18b1f34e
[5/7] RDMA/hns: The UD mode can only be configured with DCQCN
      https://git.kernel.org/rdma/rdma/c/27c5fd271d8b87
[6/7] RDMA/hns: Fix unnecessary port_num transition in HW stats allocation
      https://git.kernel.org/rdma/rdma/c/b4a797b894dc91
[7/7] RDMA/hns: Fix init failure of RoCE VF and HIP08
      https://git.kernel.org/rdma/rdma/c/07f06e0e5cd995

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
