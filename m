Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E379BACC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 02:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357913AbjIKWGx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjIKMSj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 08:18:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330C125;
        Mon, 11 Sep 2023 05:18:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA78FC433C7;
        Mon, 11 Sep 2023 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694434715;
        bh=Uy5U8uurwFCdmj3LsyWrnSusEsLgxmXe5vcJ0qBvJ/8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mu3komRZtrpxQFRHHwe6A7HOYZJNwnlYnnEN2e43DkxQSHVTfNTCGTHf3wtSau1Tz
         Hb5NvlqbCN/YDloIR9ANoUpoBsoIvaKIWC/l2BSiypsS54B43WD11UAZ3ae6y18g7V
         M6nRyZnjRHk8nJLmWpckaEtT6Dd9vcPoLbPfpNlDibDGPQSEEJjq+KfaoUmtdCMSC4
         2TaRV5EGwabjI8xLOp67pWVlspvJLlVBGcJL3+FTdszYZQM8kMQL8fVaHTCp+YZu4K
         XFoi+2SAXs3Xk4q6Zj1B4Neh/ix3xYQsKxtobWsp/0s+0eeBehx/SiStb09rHkXSGF
         ZOZjCOL/syrJQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     gregkh@linuxfoundation.org, benjamin.tissoires@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com
In-Reply-To: <20230905103258.1738246-1-konstantin.meskhidze@huawei.com>
References: <20230905103258.1738246-1-konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH] RDMA/uverbs: Fix typo of sizeof argument
Message-Id: <169443471215.409943.2562123584922962009.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 15:18:32 +0300
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


On Tue, 05 Sep 2023 18:32:58 +0800, Konstantin Meskhidze wrote:
> Since size of 'hdr' pointer and '*hdr' structure is equal on 64-bit
> machines issue probably didn't cause any wrong behavior. But anyway,
> fixing of typo is required.
> 
> 

Applied, thanks!

[1/1] RDMA/uverbs: Fix typo of sizeof argument
      https://git.kernel.org/rdma/rdma/c/c489800e0d4809

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
