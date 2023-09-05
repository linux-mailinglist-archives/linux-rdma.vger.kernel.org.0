Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557D79250C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjIEQBH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354230AbjIEKMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 06:12:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0638818D;
        Tue,  5 Sep 2023 03:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA0CB8111D;
        Tue,  5 Sep 2023 10:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13680C433C7;
        Tue,  5 Sep 2023 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693908767;
        bh=ZjCDQ/N/dcrfzTLkrKNM3dWHoHgfxVCPVZZhdtBTGaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tI8+wR+qV4mjYFjLzphBj49wG/chYfuGnasxMlyP3fuqEoPzAymkLd2UqpMWcqqVt
         PgIuqHQ7xUoqA3qNZbGUAUNUyhgPYLLKjJ4NxJ8bzEd+X76v15aEae+RENql29M+m1
         oVfim/R9ifkMKdjrqZjQ2NLorNejz5xr9nvRa/hk=
Date:   Tue, 5 Sep 2023 11:12:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, benjamin.tissoires@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH] RDMA/uverbs: Fix typo of sizeof argument
Message-ID: <2023090504-tiny-deceased-980d@gregkh>
References: <20230905101021.1722796-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905101021.1722796-1-konstantin.meskhidze@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 05, 2023 at 06:10:21PM +0800, Konstantin Meskhidze wrote:
> Since size of 'hdr' pointer and '*hdr' structure is equal on 64-bit
> machines issue probably didn't cause any wrong behavior. But anyway,
> fixing of typo is required.
> 
> Fixes: da0f60df7bd5 ("RDMA/uverbs: Prohibit write() calls with too small buffers")
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>

Please read the documentation for how to use this tag properly (hint,
you didn't use it properly here...)

thanks,

greg k-h
