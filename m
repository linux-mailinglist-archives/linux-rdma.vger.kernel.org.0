Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC05F66ED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiJFMyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiJFMy3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 08:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A5A2A9A
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 05:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42324B82088
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 12:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A482C433D6;
        Thu,  6 Oct 2022 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665060788;
        bh=qPZaXIrsv05fumHFbj7+HbY5L9yJpOdnpExbB6x2X40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/RBwrYanKgZNVvlrJ10wbaKNeraBTj71qBrETBmUJhFuqShRje9IG0UlMZWq8T+1
         PdOM1NmtE5dupI6/cDHkwqqEyjhwjm08US62oDHkzx9g+Lo5LU8Kiv8UEaxcTNRr+v
         eNia+i7zUkbb+k1gToxZgP1OJRg+c6TcKikrPZAqVC0CCAF6nXPF7oioq7NQRnk0u8
         XimyTjItXhTWMLQGwD4XlAziIEwb6Yh19o+YZkVnt3PdWCfgoE4fe1rNUWmF0eFY3N
         c5ogj7ZbAwSuWIEOdplOxA7M1oji5Wq653jJKxDD/xbsbi6hSgRNtS8VFPnychZc9w
         7iJvEbIsC0p2w==
Date:   Thu, 6 Oct 2022 15:53:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <Yz7PsMhkWMH0HXjt@unreal>
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <YzPkAGs60Kk4QCck@unreal>
 <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 30, 2022 at 03:25:00PM +0800, Yanjun Zhu wrote:
> 在 2022/9/28 14:04, Leon Romanovsky 写道:
> > On Tue, Sep 27, 2022 at 06:58:50PM +0800, Yanjun Zhu wrote:
> > > 
> > > 在 2022/9/27 18:34, Leon Romanovsky 写道:
> > > > On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
> > > > > From: Zhu Yanjun <yanjun.zhu@linux.dev>

<...>

> Is it better to append "exclusive" or "shared" in the end of the line?

No, exclusive/shared is global property, applied to all links.

Thanks
