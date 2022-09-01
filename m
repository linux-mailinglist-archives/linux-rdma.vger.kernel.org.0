Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323835A96FA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiIAMfz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 08:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiIAMfy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 08:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474B9E886;
        Thu,  1 Sep 2022 05:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D317561DF4;
        Thu,  1 Sep 2022 12:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBE8C433C1;
        Thu,  1 Sep 2022 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662035750;
        bh=+afvwk8ga1DOFv3I2d+CwI1SBBov75nLCbpTXJsr2Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ca9JyL2YMHJPNXJY+Yy3LN4ERHKvHenlZEXs//eaaQrKhLf/rT7p6bndS+Wm9UJm8
         BTb1zu3WAroDH9dNmW8ku8hTU94VzQMwUmXcnNKG0IfZbNHhveFwl1fmypTrGgnZE7
         Cd0ARFwD1eyxO62nRr2NYhYF1jZo0VZuAPPIAmllcNGBMIbuHCCECJy8t/W7rPuVGg
         A557UjYoRomXt5+qndP8/7DgCDXf6wdfLVl4QV2YUlMgW/MfzySqorYWUNBolnhcQy
         jyvqZwNUz3TVT2wZgZCev/17TcunspBHk+0xZrM/ju4CkwAE6U61udYu1XaCvuGMqP
         tbzfpTbNjdKeQ==
Date:   Thu, 1 Sep 2022 15:35:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     jianghaoran <jianghaoran@kylinos.cn>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
Message-ID: <YxCnIYIxQllk5LBh@unreal>
References: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <3e5b573b-91c1-d9d8-cf1a-8da02ad6b568@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e5b573b-91c1-d9d8-cf1a-8da02ad6b568@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 07:26:19PM +0800, jianghaoran wrote:
> 
> 
> 在 2022/9/1 下午3:05, Bernard Metzler 写道:
> > 
> > 
> > > -----Original Message-----
> > > From: jianghaoran <jianghaoran@kylinos.cn>
> > > Sent: Thursday, 1 September 2022 07:52
> > > To: Bernard Metzler <BMT@zurich.ibm.com>
> > > Cc: jgg@ziepe.ca; leon@kernel.org; linux-rdma@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: [EXTERNAL] [PATCH] RDMA/siw: Solve the error of compiling the
> > > 32BIT mips kernel when enable CONFIG_RDMA_SIW

Please read Documentation/process/submitting-patches.rst and resubmit.

Thanks
