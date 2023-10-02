Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512E7B4D84
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJBIrj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 04:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIrj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 04:47:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684CAA6;
        Mon,  2 Oct 2023 01:47:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA23C433C7;
        Mon,  2 Oct 2023 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236455;
        bh=dsC9j/QeRMlTpYqPumGgKqkRAr5i6zSh4rRXPPxTiYU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JTa6iM3G0g6lSQcgiCX8u7pVFRiELIxIGh2xIagSKYGq8mbO4e/f3xC5ESULlTTtY
         kfifkbqhL/FpUBIUVpVwXFey4+M+GVZbYGsLJZeFfjNN07FrBxnm9YCrY8E0wCAcu2
         OQney0bw/LWD31g22j9mQ8mt8Jw8SOLP3A+qVtoYZKn1uxolaquz6tJXVKYsdMvuRw
         MtSDCpxTRE4Uqfhkpc6LdmoEvYVyg5m/kcK42zAt7oFBBaGE5UYkUVgDVud3Av3SwO
         CoIWZc1s3tHblgaoEMWu+5VxkxyRvN3xwhtCKh3C5iklmtOuCU9X9Vzk9C6jEtv2SZ
         10569c8gz73zw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926130026.583088-1-huangjunxian6@hisilicon.com>
References: <20230926130026.583088-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Support SRQ record doorbell
Message-Id: <169623645142.22236.17417658581879065374.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 11:47:31 +0300
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


On Tue, 26 Sep 2023 21:00:26 +0800, Junxian Huang wrote:
> Compared with normal doorbell, using record doorbell can shorten the
> process of ringing the doorbell and reduce the latency.
> 
> Add a flag HNS_ROCE_CAP_FLAG_SRQ_RECORD_DB to allow FW to
> enable/disable SRQ record doorbell.
> 
> If the flag above is set, allocate the dma buffer for SRQ record
> doorbell and write the buffer address into SRQC during SRQ creation.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Support SRQ record doorbell
      https://git.kernel.org/rdma/rdma/c/c9813b0b9992ea

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
