Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220A0774A07
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjHHUMQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHHULu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 16:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9329892
        for <linux-rdma@vger.kernel.org>; Tue,  8 Aug 2023 11:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7549262A19
        for <linux-rdma@vger.kernel.org>; Tue,  8 Aug 2023 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AD5C433C8;
        Tue,  8 Aug 2023 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691519749;
        bh=47/2hlJ3s8h9jnVtH7pGTiP1gbLsLE/YxPNB4mNOMfk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qctXwGGQY62tiXm7gkg5dC2OGqjXW+g+fYiSnmbyxwnc6KehGKIW+e/RxszlJKUZp
         spNLrn/VMBKuuErPy1TZWqdUDFD/AaZ/rl/+rvzJDV71HbUiwhFKoabCVM01XVpl/Y
         vnhbtiIY2VLfdoSaiVjkhcscvk+USzYWx0ImN1rMFw4ITLWndDH+tgBYc/vV96oeiM
         zqkx0sMosSTp/BfMzyIC9hy6QVLbV0sAQiNBeI4DtzHoHr6IP97tN6YsmXSE+84FS3
         qY0c/OVdPji5oQzULoD+xBl0S/xl4U7trakIGtV9CIHX+gRXp8uBtD06G5rY6gbMkl
         F1AtXii4wSdIQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     xuhaoyue1@hisilicon.com, huangjunxian6@hisilicon.com, jgg@ziepe.ca,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230804130418.41728-1-yuehaibing@huawei.com>
References: <20230804130418.41728-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] RDMA/hns: Remove unused declaration hns_roce_modify_srq()
Message-Id: <169151974340.542206.15592205131101430164.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 21:35:43 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 04 Aug 2023 21:04:18 +0800, Yue Haibing wrote:
> Commit c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
> declared but never implemented this.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Remove unused declaration hns_roce_modify_srq()
      https://git.kernel.org/rdma/rdma/c/d952f54d01ec2e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
