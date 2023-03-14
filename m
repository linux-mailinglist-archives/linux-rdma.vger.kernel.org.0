Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E46B8FC0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 11:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCNKYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 06:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCNKYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 06:24:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B991C5A0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 03:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AC70B818DF
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 10:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4109FC433EF;
        Tue, 14 Mar 2023 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678789399;
        bh=Colmwe/i6OWYobVhwYkFbfzZHjZnyzrcBxYvy058VFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtMOZPWuupvnSG1fIiwNLMGZ/CFURsLQTvuM1EWdcnQKmiMivkJ9cA3L8LwrIkRl7
         CXChAl+us7qctLoZirei1QwBK3oUByQlhtrtLE0MmjUUFU2QxyoNG3zCfHzjQvpF4W
         ECiWbcMKs3IH4YHDhiXUdYJgrGWN2/MokQqr2w4+23UkiH5PsIPIBotRZdsK4i0RQL
         4xAxct1kBEkxHshfErJXGoHGmjrjOQ9Sqdyw7gC8ivLI5at2XdbX1UlLHsYVqh22ye
         MF2MJ539uRscbH+AkOAc1Dv+32xsjliFr9HiilWnYF70QccsWp8DUP8raR/GD9CpiU
         0v0+wENEj/8Cw==
Date:   Tue, 14 Mar 2023 12:23:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <20230314102313.GB36557@unreal>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307102924.70577-3-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 07, 2023 at 06:29:24PM +0800, Cheng Xu wrote:
> Doorbell resources are exposed to userspace by mmap. The size unit of mmap
> is PAGE_SIZE, previous implementation can not work correctly if PAGE_SIZE
> is not 4K. We support non-4K page size in this commit.

Why do you need this information in rdma-core?
Can you use sysconf(_SC_PAGESIZE) there to understand the page size like
other providers?

Thanks
