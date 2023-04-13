Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742596E08D2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDMIWQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDMIWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 04:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1688D5FC6
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 01:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C6563C5A
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 08:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E437C433D2;
        Thu, 13 Apr 2023 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681374130;
        bh=TQxarXRoc0vrReNqeXc5/yfSX8gdxmZ898E2GSqQ3e0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMzxBIdP5cGV0bTECDRAKwk8S5ThFpLYG72ruulAMFPabngi/x9wCVcrNviybdEI9
         VwRG69nG6FRFaIy83nDqWXXLAfzo7oAejqBuqRvV3o6QHe5VUJ75/6+iBIdxoQh7AV
         kzoOOfaDubHENCb6K1kjXbkNOEzq570ie6XdXYlMM/UyqOULii0VqbZfgRKXszwYO2
         QJqj2fDquSkPCrZZ1d/aGtdA1sOEBqmwEdPn+NQ6fpN7Mcdc2oWbwrVvCHnoyIVF+V
         b1P3DsCRyZiCVSPuxch1OSa65kPkgD4iyYgSQ1mjROwt1IMTK3XLEts6V9qEmTSn2m
         BFlvYZvlshQIw==
Date:   Thu, 13 Apr 2023 11:22:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Nachum, Yonatan" <ynachum@amazon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        mrgolin@amazon.com, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Message-ID: <20230413082205.GB17993@unreal>
References: <20230404154313.35194-1-ynachum@amazon.com>
 <20230409073228.GA14869@unreal>
 <f738b558-f0d9-e69e-0939-a80594063d4c@amazon.com>
 <20230409172146.GJ182481@unreal>
 <0c307561-8ee1-061b-6ba3-ceb74eb3a1c8@amazon.com>
 <20230410123812.GT182481@unreal>
 <5b9f3728-1fc7-4a87-f516-286718e94dc6@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b9f3728-1fc7-4a87-f516-286718e94dc6@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 05:14:03PM +0300, Nachum, Yonatan wrote:
> 
> >>>>>>
> >>>>>>       access_flags &= ~IB_ACCESS_OPTIONAL;
> >>>>>>       if (access_flags & ~supp_access_flags) {
> >>>>>> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> >>>>>> index 74406b4817ce..d94c32f28804 100644
> >>>>>> --- a/include/uapi/rdma/efa-abi.h
> >>>>>> +++ b/include/uapi/rdma/efa-abi.h
> >>>>>> @@ -121,6 +121,7 @@ enum {
> >>>>>>       EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
> >>>>>>       EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
> >>>>>>       EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
> >>>>>> +     EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
> >>>>>
> >>>>> Why do you need special device capability while all rdma-core users
> >>>>> set IBV_ACCESS_REMOTE_WRITE anyway without relying on anything from
> >>>>> providers?
> >>>>>
> >>>>> Thanks
> >>>>
> >>>> We need to query the device because not every device supprort the same RDMA capabilities. Upper layers in the SW stack needs this supported flags to indicate which flows they can use. In addition this is identical to the existing RDMA read support in our code.
> >>>
> >>> Nice, but it doesn't answer my question. Please pay attention to the
> >>> second part of my question "while all rdma-core ....".
> >>>
> >>> Thanks
> >>>
> >>
> >> There are rdma-core users that doesn’t fail on unsupported features but fallback to supported ones. One example is Libfabric EFA provider that emulates RDMA write by read if device write isn’t supported but there are other similar examples. Correct way doing this in user code is by querying rdma-core for device supported capabilities, then selecting a suitable work flow. This is why existing and the additional capability bits are required.
> > 
> > AFAIK, RDMA write is different here as fallback is performed in the kernel and
> > not in the rdma-core provider. So why should EFA be different here?
> > 
> > BTW, Please fix your mailer to break lines, so we will be able to reply
> > on specific sentence with less effort.
> > 
> > Thanks
> 
> Can you please elaborate more on the fallback performed in the kernel?
> What kind of fallback being performed? Is it in create MR/QP?
> Does the fallback happens when providing unsupported write capability
> and to what it fallback to?

OK, looked again, "Fallback" was in my imagination, sorry about that.

But my main question is continued to be, how other vendors which support
RDMA write work without capability?

Thanks

> 
> Thanks
