Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49427BCF57
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Oct 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjJHRJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Oct 2023 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHRJh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Oct 2023 13:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDBA6;
        Sun,  8 Oct 2023 10:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA73C433C7;
        Sun,  8 Oct 2023 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696784975;
        bh=hkXhovddX4SQVxh0eOgm5kAmQc92T1bvw+lkOeoZwn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNk2kZ0gCTIu5rEO9tjTZmePcAFqQLh7LpZ00CEMyAuO4Swl0SMPDe6ut82uXqbGn
         eK/0D8VRg29wjhBygQvhjAMVYeU9Zk4TEAzKdUqGZ5bkHGr72XAGQ/x9GcyMVZxurl
         42CosyKim4KKUOyB1SZ9lgNiFaMTwfKDWYjU4vAm0PgbRfuZd4kJO1XaIo2+lHlbZT
         TKpxcSmyzQNE8VIgEKMJDffwpii79k7fd77XRtjFA6AbkmA85gW27NetE4Nkr+MBWi
         EjNNLKhHG4zBMtlukvOT3laQ6bSmLsaJYSo+NOtLvRcHt+9uMtIpxU75UiBj+AHd3i
         nhIFs5CZTanGg==
Date:   Sun, 8 Oct 2023 20:09:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231008170930.GI51282@unreal>
References: <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 09, 2023 at 12:01:37AM +0800, Zhu Yanjun wrote:
> 在 2023/10/5 22:50, Bart Van Assche 写道:
> > On 10/5/23 07:21, Jason Gunthorpe wrote:
> > > Which is why it shows there are locking problems in this code.
> > 
> > Hi Jason,
> > 
> > Since the locking problems have not yet been root-caused, do you
> > agree that it is safer to revert patch "RDMA/rxe: Add workqueue
> > support for rxe tasks" rather than trying to fix it?
> 
> Hi, Jason && Leon
> 
> I spent a lot of time on this problem. It seems that it is a very difficult
> problem.
> 
> So I agree with Bart. Can we revert patch "RDMA/rxe: Add workqueue
> support for rxe tasks" rather than trying to fix it? Then Bob can apply his
> new patch to a stable RXE?

Jason, I'm fine with reverting patch.

Thanks

> 
> Any reply is appreciated.
> Warm Regards,
> 
> Zhu Yanjun
> 
> > 
> > Thanks,
> > 
> > Bart.
> 
