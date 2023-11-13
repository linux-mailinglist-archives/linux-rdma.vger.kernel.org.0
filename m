Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1B7E9C42
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjKMMil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 07:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMik (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 07:38:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE9D54
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 04:38:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6421BC433C8;
        Mon, 13 Nov 2023 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699879117;
        bh=8fOJp8shUPdLYAneemdhnPXWD3TpC+NzEQ6p44mVC4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZWt3mxp3VBtopO16q4lajxAWAfXB6aMdvHcQD30rvKl7Ub9N9aHxHEf7tUP9c3Ra
         MkuD6OVAUhhzNeu82rmtfAsYGjVdxPINILz0pbOlVL8/SUPNu5rwsz3T/4C4APzWrK
         JKElX6m6xa9JwRl3rd4nVQVikHU+s1ZW5c2L8FdfiGEzUbZUIvz+1JE2NdW6DvOl59
         2J9yBVZoDECH9gQW6AQ8uO94FSKQNoRiEPmoVr5U/Dnuccp0RI4xFvEEXdaDeJ3N3y
         qdQkf01mv7HRenRKLVAsWJE9E40Wp+R90l14z5QfznjaAF8X9YDbNIbPmYkUw4ENcS
         dzQU/BqOwBBPQ==
Date:   Mon, 13 Nov 2023 14:38:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     bmt@zurich.ibm.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V4 00/18] Cleanup for siw
Message-ID: <20231113123831.GB51912@unreal>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
 <20231113083826.GA51912@unreal>
 <3d34553d-f6c3-df40-56bf-db10af8472cc@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d34553d-f6c3-df40-56bf-db10af8472cc@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 13, 2023 at 07:59:27PM +0800, Guoqing Jiang wrote:
> 
> 
> On 11/13/23 16:38, Leon Romanovsky wrote:
> > On Fri, Oct 27, 2023 at 09:26:26PM +0800, Guoqing Jiang wrote:
> > > V4 changes:
> > > 1. add Acked-by tags.
> > > 2. update patch 3 and patch 12 per Bernard's review.
> > > 3. update patch header in patch 18.
> > > 
> > > V3 changes:
> > > 1. add Acked-by tags.
> > > 2. drop 2 patches and address other comments.
> > > 
> > > Appreciate for Bernard's review!
> > > 
> > > V2 changes:
> > > 1. address W=1 warning in patch 12 and 19 per the report from lkp.
> > > 2. add one more patch (20th).
> > > 
> > > Hi,
> > > 
> > > This series aim to cleanup siw code, please review and comment!
> > This series wasn't sent properly and it doesn't exist in patchworks and lore.
> > Please resend it properly.
> 
> Done.
> 
> https://lore.kernel.org/linux-rdma/20231113115726.12762-1-guoqing.jiang@linux.dev/T/#t

Thanks

> 
> Thanks,
> Guoqing
