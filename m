Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0257B067
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 07:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiGTFiN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 01:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGTFiN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 01:38:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE0CE23
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 22:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A64F1CE1E56
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 05:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D4FC3411E;
        Wed, 20 Jul 2022 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658295488;
        bh=2U0ul2k9ozPWxRY0bwuBxTdN7cYl8cHrwh/WJOluX9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sISVBR8T2pSzaBQLBtXPEsuDhXqIJyeyTwp8pQoYgVbzBwG3whrHvmNafer97AbqG
         DEEOOFsP6oKdBggAdz0307W41+oaHRFdQoIcsymmJC5tAK4wnusb2fEY7RSw6rTs+/
         q7Azsm7epx6wz5YLm4RisgCN6DE5+rg5aOib3w4AnPANgruwpAsYxjGtqkZbcfwq85
         7/hoSPjbOBSzQQDVEsSVxCQ9o9N7x0f3YQTQqm9Hi/SiAIJ99pwypUBQiF2hmMvuAW
         neiQFAsjed8ZSV+T3o0u/XyOm7Nqjtl5eC/klYtjuGCTC9151RfxUX2qGCNbaj9LzM
         rED9hoeD0+A6w==
Date:   Wed, 20 Jul 2022 08:38:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH v5 0/4] RDMA/rxe: Fix no completion event issue
Message-ID: <YteUvNhKF/VH+OFW@unreal>
References: <20220704060806.1622849-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704060806.1622849-1-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 04, 2022 at 06:00:54AM +0000, lizhijian@fujitsu.com wrote:

Please fix your gitconfig to have same From/author fields as in Signed-off-by.

Thanks
