Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC226D5A33
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjDDICy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjDDICx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 04:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F67198C;
        Tue,  4 Apr 2023 01:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E1A260FC6;
        Tue,  4 Apr 2023 08:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E034C4339E;
        Tue,  4 Apr 2023 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680595372;
        bh=BGeGIQ/3c78hfuaB5DICgCXUcGmxYE4MIbvJjF1qb8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRNZbNUhOFRuWn4bTNIqS9wIWfUp2DGUXHa2/3OGdsWmywF0rJ6Aw9eYShJmaqhca
         rH3vPtrhnMzrJUm3WhyKe+khwAQXynw/2il1l6jGAwpAeWvucDb//TZjEJuilQP94Q
         aQGUdRO847d91Y9UQxyNrJaOupAh8OwRdDDC2NxK6/VZfBbLN1aGsp1uG9owME8utq
         hnMSSL104QWRMDaHti61iCPt1wVpvORNNy8+Qc1VOBJdawSWWApxLvg9Qn8oMkgRuo
         IFMEkP2xBrQ8Oatiy51JrM98md/eamhUSijvxW12/wK5xI9lhdLXCArpueR9g7khEu
         9i/pGTQQzlxrA==
Date:   Tue, 4 Apr 2023 11:02:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     xiaolinkui <xiaolinkui@126.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] RDMA/hfi: add a judgment on the availability of cpumask
Message-ID: <20230404080247.GI4514@unreal>
References: <20230404030525.24020-1-xiaolinkui@126.com>
 <20230404060522.GH4514@unreal>
 <940e1807-7e89-4de0-ee69-9346d231a59f@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <940e1807-7e89-4de0-ee69-9346d231a59f@126.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_TONAME_EQ_TOLOCAL_SHORT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 04, 2023 at 03:01:58PM +0800, xiaolinkui wrote:
> Thanks for your reply.
> 
> When CONFIG_CPUMASK_OFFSTACK=y, "ret" will be false if diff==NULL.
> 
> However, when CONFIG_CPUMASK_OFFSTACK=n, these two are not necessarily
> equivalent.

And what is the problem with that? cpumask_* API is built to handle
correctly this mode.

Reminder: please don't top post.

> 
> Thanks
