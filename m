Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099B68D2C3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjBGJ1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 04:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjBGJ1D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 04:27:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2A9EE1;
        Tue,  7 Feb 2023 01:26:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFE761228;
        Tue,  7 Feb 2023 09:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8939FC4339C;
        Tue,  7 Feb 2023 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675762014;
        bh=gk55+10cOMWj4cHfuKKWun7Q9hLRhIO+h1wjYTjZ3HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iL8CyCFgPyVLpQIveyZDi+zhFFSjupBjkOId828yT2Nm/Fg78i63ObHcCmpEM2WHB
         klXwu+MB2KFB1aPX7TwcbQgd05K0o/tFDyVzEOeRQRBe48fJ4EKEy7ECtSyWGgV9L0
         DUSDKHunju+BRuoV7rLolCfjX/WbLkU/GQqfhFgkrPZyZ74ndOF8iE8Zj4oEIcayWa
         aLPPnjMNCEyyAx8CwlDCGRZQbAjdNZgYzWw3NujS6Zhz5L+41UuV/fuSh4qh+F9lDS
         63txU5eez/u+FsJ7Hsc5g/ia1u2+fF9oEFGe3CySKt6upjDvKh2ujR/v7Z5DWJKNnY
         U3zZX0WfVPtYg==
Date:   Tue, 7 Feb 2023 11:26:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     'Deming Wang' <wangdeming@inspur.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/restrack: Correct spelling
Message-ID: <Y+IZWiRiNHtSKRdk@unreal>
References: <20230206085725.1507-1-wangdeming@inspur.com>
 <TYCPR01MB84550C2753CC434A4A3A48ADE5DA9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB84550C2753CC434A4A3A48ADE5DA9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 06, 2023 at 09:08:06AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Mon, Feb 6, 2023 5:57 PM Deming Wang wrote:
> > 
> > We should use this replace thie.
> > 
> > Signed-off-by: Deming Wang <wangdeming@inspur.com>
> > ---
> >  include/rdma/restrack.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> > index 79d109c47242..d7ee54b7b9ae 100644
> > --- a/include/rdma/restrack.h
> > +++ b/include/rdma/restrack.h
> > @@ -162,7 +162,7 @@ struct rdma_restrack_entry *rdma_restrack_get_byid(struct ib_device *dev,
> >   * rdma_restrack_no_track() - don't add resource to the DB
> >   * @res: resource entry
> >   *
> > - * Every user of thie API should be cross examined.
> > + * Every user of this API should be cross examined.
> >   * Probaby you don't need to use this function.
> 
> 'Probably' instead of 'Probaby', right?

I fixed it locally, thanks.

> 
> Daisuke
> 
> >   */
> >  static inline void rdma_restrack_no_track(struct rdma_restrack_entry *res)
> > --
> > 2.27.0
> 
