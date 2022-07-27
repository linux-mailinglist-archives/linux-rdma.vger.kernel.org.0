Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995DF582662
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiG0M0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiG0M0s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 08:26:48 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A8222
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 05:26:46 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id A2525B004C6; Wed, 27 Jul 2022 14:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1658924803; bh=0Z8H8gCi9UG0wKbKlUjmLJfKCJy5LsuoTBWf6n2azD8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=a6/JhD+aT62mA5V9RnfU1H6UNapN2TVBaoi4X5w15CEa404HwPWdyCLU4vde4ElNT
         k958qog0Kwc6n9XJI6+gMYUyVwnuOU+dxMDfT5Tx4Tqa5YMm3bYx6qK79IK3WQgmwW
         4KYLPl3C5dEP5DB0oWSBXkhUP/+bhZZ+zpCCViT1cO0tkLhhrPsAIH9vUpUxh+1Y/O
         3VdMXPkrow1s7Et6/pQ6G8MktAAAcXxBhzKxp+2WrBq2kJ9pnfiUSfD1iLuEm8FjXS
         +YhaCD1W8feGUlXtmmhdqBN9MFuvizPgtVd/DTZSRCqIhqctYBt123yBmYd3Xqvs01
         lXX+DUS8tqvjA==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id A12D7B00224;
        Wed, 27 Jul 2022 14:26:43 +0200 (CEST)
Date:   Wed, 27 Jul 2022 14:26:43 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Leon Romanovsky <leonro@mellanox.com>
cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
In-Reply-To: <YuEHOM/iGFEtaGde@unreal>
Message-ID: <alpine.DEB.2.22.394.2207271426110.1244244@gentwo.de>
References: <20220726212156.1318010-1-bvanassche@acm.org> <20220726212156.1318010-4-bvanassche@acm.org> <YuEHOM/iGFEtaGde@unreal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 27 Jul 2022, Leon Romanovsky wrote:

> Please no BUG_ON() in new code.

Do we now prefer NULL pointer dereferences causing bugs?

