Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1746876E0
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBBH7A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 02:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBH67 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 02:58:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04FB8241C
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 23:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E506185D
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 07:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BF4C433D2;
        Thu,  2 Feb 2023 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675324731;
        bh=hhbh0U9jKscVlRnfTJogmcNbhqLOvf9m4ZZIKt5SKa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U++wWE1rWsP6D9xiGCGHjputQ56M1Tw2bOQUJvUyMzOXt9gLiS1hzoEehjh2hfRu4
         nQ9W6YMra4kW2m29QM4MULD3oviCNodXw81nDnGXmUP7we6sA+zYRi888XCDUSUmb/
         aWlTdLtVBnIlMA7FUxuhrdq9lsz3RqfSziaR0BflD9OZgCID7sxyRY+QdedU/enc0K
         0P4f2M6xOCAKzK12+CSOq0sqAnoSU5ht2qNWXlebqpDceJsQgIyn7uU6mobl2uT8W9
         r+Bls3yrTrm9QjQYrbOUwey32FF2UuQWb5P0weQrs9JLDIxoFatknUqHonsyatHNsq
         N8AD7Q5ERiIxA==
Date:   Thu, 2 Feb 2023 09:58:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Vogel <jack.vogel@oracle.com>
Cc:     "mustafa.ismail@intel.com" <mustafa.ismail@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Move variable into switch case
Message-ID: <Y9ttN4tB1mwB6bSU@unreal>
References: <20230201012823.105150-1-jack.vogel@oracle.com>
 <Y9o6xnalM+R4DE3D@unreal>
 <997C66D5-3298-4F64-8784-3FDAA438C66C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997C66D5-3298-4F64-8784-3FDAA438C66C@oracle.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 12:09:50AM +0000, Jack Vogel wrote:
> Hey Leon,
> 
> Oracle switched to GCC11 in our UEK7/OL9 releases recently, leading up to that release we added the ALL_ZERO config option, and then ran into some warnings, our build treats warnings as errors and would fail. For instance this thread: 
> 
> https://lkml.iu.edu/hypermail/linux/kernel/2202.1/05558.html
> 
> A number of changes were made in the mainline code by Kees Cook and even made it into the linux-5.15.y branch, but a couple of them we have carried as specials for the past year, I was recently prodded about the matter again by an internal group, so I thought I would submit these patches upstream. 
> 
> I must apologize though, for unbeknownst to me, our tools team actually back ported the fix from gcc12 regarding these warnings and forgot to tell the UEK group about it :) It wasn’t until you asked about the warnings, I reverted the commits and did a build to capture them, then I discovered they no longer occur. So, sorry about the noise. I will be reverting our own changes as unnecessary now.

Glad to hear.

Thanks
