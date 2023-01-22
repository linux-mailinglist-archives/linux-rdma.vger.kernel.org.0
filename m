Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8D676BD0
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jan 2023 10:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAVJOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Jan 2023 04:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVJOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Jan 2023 04:14:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A41F4BC
        for <linux-rdma@vger.kernel.org>; Sun, 22 Jan 2023 01:14:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36F53B80973
        for <linux-rdma@vger.kernel.org>; Sun, 22 Jan 2023 09:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55214C433EF;
        Sun, 22 Jan 2023 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674378857;
        bh=iMGGRQawfagRHZIHgVi/1Z9dpV+gluGSy+jBPSC6OqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX5T3isxXOFPBURakgYcBWjJi8EePsIDOm8rBpHIamrgJcXZ69XqynXpZWQmXDWtD
         t3gD+ylKPbcal2bn0c5bHOCEeI114T7CUtMVsWDKbAFI+O7oGAjgdqvPlVpzxNmC94
         ajgN6Y92OL0qQXSEjQTlk3rXfQgi0JBbUE6lJwed9ms7gNFXKBDctGKXA1chrVUpgN
         XZpEiASAIWShhpSZ5QtFVeYbII/XCM1SmehDfeWlIcRWAMJ6MfMk4MQDiMvmchmjPD
         ei+8NoCX81cMfRFl3Ztt4zKYngrP6ahhJ2cFzlKJkC+hyjtNj//PwGjDy/Qjl9X4hE
         H1e/baAUxdZ5w==
Date:   Sun, 22 Jan 2023 11:14:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y8z+ZH69DRxw+b6c@unreal>
References: <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal>
 <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 20, 2023 at 12:50:35PM -0500, Dennis Dalessandro wrote:
> On 1/20/23 12:42 PM, Jason Gunthorpe wrote:
> > On Fri, Jan 20, 2023 at 07:09:43PM +0200, Leon Romanovsky wrote:
> > 
> >> Backmerge will cause to the situation where features are brought to -rc.
> >> The cherry-pick will be:
> >> 1. Revert [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] from -next
> >> 2. Apply [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] to -rc
> > 
> > You don't need to revert, we just need to merge a RC release to -next
> > and deal with the conflict, if any.
> 
> Thanks this sounds like a good way to go.

You talked about broken -rc, but here wants to fix -next.
https://lore.kernel.org/all/bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com/
https://lore.kernel.org/all/Y8T5602bNhscGixb@unreal/

Thanks

> 
> -Denny
