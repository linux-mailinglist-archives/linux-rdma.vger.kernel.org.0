Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6845F67C94F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 12:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjAZK76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 05:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjAZK7l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 05:59:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F018F93E4
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 02:59:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A75B6179A
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 10:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD69C4339B;
        Thu, 26 Jan 2023 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674730779;
        bh=bMZzowhwjYovi3Na8eI/YQ/fEU+s4UmriX7xXhVd3rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0h3xWLMjY+IciGnAHtszrh5X2br8lcnesXmp23j7n4JUFqso2/htl/98xDKfM6uK
         mFxK25htfPwRidtQFZjkGwwdcqXABzrViIc5sWJnVQqCn82yI2iR0U5o4mal+FimE7
         lzNP6iEDYUi09J73nas/ehFTAqMdXVQnWtocE05kbwp3Npu/iKyGTGIAUsOQhVRQ3b
         Dv3MtmLo/93gT+COivHvYhi9W5pyp2Aa7SS2zBjU6lfToWm/i+VKaIuWckU3KedILk
         S1XAoDzWFij6BqZojM4pfEwduwmgg58Okr1JwKR8m0THeMOWuy7YIZ+GQQj4GlVZfx
         HVyPxvuJAfdgw==
Date:   Thu, 26 Jan 2023 12:59:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCHv3 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
Message-ID: <Y9JdF5b+dzIchpOg@unreal>
References: <20230116193502.66540-1-yanjun.zhu@intel.com>
 <e59c54bf-03f7-2e27-2162-91dc3f896123@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e59c54bf-03f7-2e27-2162-91dc3f896123@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 26, 2023 at 09:16:05AM +0800, Zhu Yanjun wrote:
> 在 2023/1/17 3:34, Zhu Yanjun 写道:
> > V2->V3: 1) Use netdev reverse Christmas tree rule;
> > 	2) Return 0 instead of err;
> > 	3) Remove unnecessary brackets;
> > 	4) Add an error label in error handler;
> > 	5) Initialize the structured variables;
> 
> Hi, Leon
> 
> Follow your advice, I made this patches.
> Please check it.

Everything is applied, sorry for the delay.

Thanks
