Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606616C2F47
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCUKmj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 06:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCUKmi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 06:42:38 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83153BB82
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 03:42:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VeMpVsn_1679395337;
Received: from 30.221.101.55(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeMpVsn_1679395337)
          by smtp.aliyun-inc.com;
          Tue, 21 Mar 2023 18:42:17 +0800
Message-ID: <8b56dfed-3e9b-8a6b-df4c-8f1d4da8a72d@linux.alibaba.com>
Date:   Tue, 21 Mar 2023 18:42:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Cheng Xu <chengyou@linux.alibaba.com>
Subject: [rdma-core v44][bug report]DEB installation failed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Jason and Leon,

I found that there is a DEB installation error in rdma-core v44.0.
The error prompt:

dpkg: error processing archive libibverbs-dev_44.0-2_arm64.deb (--install):
 trying to overwrite '/usr/lib/aarch64-linux-gnu/libmana.so', which is also in package ibverbs-providers:arm64 44.0-2

It has been fixed by commit 766f88465e32 ("debian: Exclude libmana.so from ibverbs-providers")
in master branch [1]. Today new version is released, but the commit does not present
in stable-v44 still [2].

I want to fix this issue for v44, but it seems that there is nobody creating
PRs for stable-xx branches. How to handle this?

Thanks,
Cheng Xu

[1] https://github.com/linux-rdma/rdma-core/commit/766f88465e326d6b01d4122c8172f5bb80ae2641
[2] https://github.com/linux-rdma/rdma-core/blob/v44.1/debian/ibverbs-providers.install
