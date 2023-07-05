Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A4748243
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGEKg4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGEKgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 06:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D0DD;
        Wed,  5 Jul 2023 03:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1898A614EA;
        Wed,  5 Jul 2023 10:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E759CC433C9;
        Wed,  5 Jul 2023 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688553409;
        bh=F4rFG36YSdtp+ECeALfuw2X8+DlTe4GxNPIo0OWn5BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwDCNLftMGMRa9noO9SpEbclCC5GgTVOy79ADkxYvO3d34pNhkkfK+xU/CSxkgWou
         pEZAc2XFXFbGpKtgaSTm8jBN3YdEM/ZOTSVqFiF78JbtVHG15ua+VDNVs13uDiMkrg
         +GVGHgLEVgaq/oJ/udOnEfcIVAU1V9LO1R2C4pxPllfHj6ICdZZiwZBRzIs8KE8PxL
         dhOWDnP7Ij9AZqD8fuGRY4gX2RmvRgzEbqaJokpMeYzbo5IFEfpXveYRCxJJ0QA76L
         kwc6e7aIzzMLa0lrc4mMhCwbBiKsfcKJ7igRTobPYDrlVi6w5LMbBVCMpCKVcsW10u
         1bj0AFDLHzeGA==
Date:   Wed, 5 Jul 2023 13:36:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Rock =?utf-8?B?TGko5p2O5a6P5LyfKQ==?= <lihongweizz@inspur.com>
Cc:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/iser: Protect tasks cleanup in case iser connection
 was stopped
Message-ID: <20230705103644.GL6455@unreal>
References: <45c68d6835964dcbae8fbd983696064b@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45c68d6835964dcbae8fbd983696064b@inspur.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 05, 2023 at 09:22:08AM +0000, Rock Li(李宏伟) wrote:
> > > On Tue, Jul 04, 2023 at 08:51:44AM +0800, lihongweizz wrote:
> > > From: Rock Li <lihongweizz@inspur.com>
> > >
> > > We met a crash issue as below:
> > > ...
> > >  #7 [ff61b991f6f63d10] page_fault at ffffffffab80111e
> > >     [exception RIP: iscsi_iser_cleanup_task+13]
> > >     RIP: ffffffffc046c04d RSP: ff61b991f6f63dc0 RFLAGS: 00010246
> > >     RAX: 0000000000000000 RBX: ff4bd0aalf7a5610 RCX: ff61b991f6f63dc8
> > >     RDX: ff61b991f6f63d68 RSI: ff61b991f6f63d58 RDI: ff4bd0aalf6cdc00
> > >     RBP: 0000000000000005 R8: 0000000000000073 R9:
> > 0000000000000005
> > >     R10: 0000000000000000 R11: 00000ccde3e0f5c0 R12:
> > ff4bd08c0e0631f8
> > >     R13: ff4bd0a95ffd3c78 R14: ff4bd0a95ffd3c78 R15: ff4bd0aalf6cdc00
> > >     ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
> > >  #8 [ff616991f6f63dc0] __iscsi_put_task at ffffffffc0bd3652 [libiscsi]
> > >  #9 [ff61b991f6f63e00] iscsi_put_task at ffffffffc0bd36e9 [libiscsi]
> > > ...
> > >
> > > After analysing the vmcore, we find that the iser connection was
> > > already stopped before abort handler running. The iser_conn is already
> > > unbindded and released. So we add iser connection validation check
> > > inside cleanup task to fix this corner case.
> > >
> > > Signed-off-by: Rock Li <lihongweizz@inspur.com>
> > > ---
> > >  drivers/infiniband/ulp/iser/iscsi_iser.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c
> > > b/drivers/infiniband/ulp/iser/iscsi_iser.c
> > > index bb9aaff92ca3..35dfbf41fc40 100644
> > > --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> > > +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> > > @@ -366,7 +366,12 @@ static void iscsi_iser_cleanup_task(struct
> iscsi_task
> > *task)
> > >  	struct iscsi_iser_task *iser_task = task->dd_data;
> > >  	struct iser_tx_desc *tx_desc = &iser_task->desc;
> > >  	struct iser_conn *iser_conn = task->conn->dd_data;
> > > -	struct iser_device *device = iser_conn->ib_conn.device;
> > > +	struct iser_device *device;
> > > +
> > > +	/* stop connection might happens before iser cleanup work */
> > > +	if (!iser_conn)
> > > +		return;
> > 
> > And what prevents from iser_conn being not valid here?
> > For example, in the flow:
> > 1. Start iscsi_iser_cleanup_task
> > 2. Get valid task->conn->dd_data
> > 3. Pass this if (..) check
> > 4. Context switch and release connection 5. iser_conn now points to
> released
> > memory.
> > 
> > Thanks
> 
> Hi Leon,
> Thanks for your reply:) In case iscsi_stop_conn was executed cocurrently or
> after iscsi_iser_cleanup_task, above issue would happen.
> I've confirmed the values in iscsi_cls_conn and iscsi_conn instances from
> vmcore:
> 
> iscsi_stop_conn
>   ...
>   WRITE_ONCE(conn->state, ISCSI_CONN_FAILED);      --- confirmed
>   ...
>   conn->transport->stop_conn => iscsi_iser_conn_stop
>     iscsi_conn_stop
>       ...
>       conn->c_stage = ISCSI_CONN_STOPPED;          --- confirmed
>     conn->dd_data = NULL;                          --- confirmed
> 
> The crash scene tells us that iscsi_stop_conn was executed before
> iscsi_iser_cleanup_task start, the iser_conn instance was already released. 

It is by chance, it will be better to provide a fix which is race free.

Thanks

> 
> > 
> > > +	device = iser_conn->ib_conn.device;
> > >
> > >  	/* DEVICE_REMOVAL event might have already released the device */
> > >  	if (!device)
> > > --
> > > 2.27.0
> > >


