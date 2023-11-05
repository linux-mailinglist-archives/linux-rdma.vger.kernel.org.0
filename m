Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDD7E1302
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Nov 2023 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKEKVN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Nov 2023 05:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKVM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Nov 2023 05:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178EDE9
        for <linux-rdma@vger.kernel.org>; Sun,  5 Nov 2023 02:21:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B80C433C8;
        Sun,  5 Nov 2023 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699179669;
        bh=czuysCJ3Kxd7yvXveoV4XPQ4w6F6tnAh/OTNcSoARpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYubhvIy3jLrYk5ej+cbFenBPFwstwvMpib9ssHd9fMFis2pzkco0XW9x7mT0ZNf2
         rB3hUSOcBHh7Wdd1EujZB3DC5UHR9Xyqd4ARzzYVuHT0P7wteCDyvIZdM4xHXDG6YY
         wG+qTFOv1L5kWYy9HbdnJPExXgnB2PKm9zg+lUB4nejl0/6r2e4TUAmM/8OsbG5hIv
         2YphVrZIgxqxL3J3Wwa4tg9zioUJSqADSg0QwVjrUJRk7Zt+p1a9CpHhieLjFfwAJL
         Ec+hogLjRhFgOQopAHcn7a8lcyd7qMPW7hk59fs/Oui1g5ijuU1AD5eTkqszHejugV
         2uHk8QJ268wRA==
Date:   Sun, 5 Nov 2023 12:21:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Maxim Samoylov <max7255@meta.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] IB: rework memlock limit handling code
Message-ID: <20231105102105.GB11062@unreal>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
 <20231023055229.GB10551@unreal>
 <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
 <20231102123216.GF5885@unreal>
 <daf453fa-c834-9cf1-0ddc-04abdfa37abb@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf453fa-c834-9cf1-0ddc-04abdfa37abb@cornelisnetworks.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 02, 2023 at 04:54:22PM -0400, Dennis Dalessandro wrote:
> On 11/2/23 8:32 AM, Leon Romanovsky wrote:
> >>
> >> So, as for 31.10.2023 I still see siw_umem_get() call used in
> >> linux-rdma repo in "for-next" branch.
> > 
> > I hoped to hear some feedback from Bernard and Dennis.
> > 
> 
> Sorry about that. I thought I did respond about qib.

Dennis, qib probably needs to use ib_umem_get too.

> 
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
