Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84659F359
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 08:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiHXGBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 02:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiHXGBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 02:01:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FED91D04
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 23:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2E5DB82357
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 06:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2517CC433D6;
        Wed, 24 Aug 2022 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661320872;
        bh=al89lTaVu3Y5uiS5WH2s2m5dOn2iY3Zwxq7ES3erAwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdaHrQCAbc5kY6indwNi87oKtQnrmnLSt0fiu385Of7YsN4ogBAdLd7lybbtQ9JUW
         6xded4MJy26XEojeDMWnPcFigwWiga/Va/YAK9A1LzxUBCwM0l8hmnvdW7kqmGt2Y1
         PLhPwKpiDNWt2MbPVgyGXEtz4Ntn9Yw4nY1gLayqUTUtRws2zQz+B5q2O7nBgr6wX0
         No2vhJxOZucNe6RdvIbKLBFRo5Kh5kLuqJoavuWeIukcqF6tj2MGB3N57iZCjt7Xg4
         wLq8F5qWVLNi7l4ZTZSTXx2YtplTYW4wxJKWXaIaMpSGzCNmC9MFzO2K8VX7ZgGzHJ
         Me7c46YH/HcUQ==
Date:   Wed, 24 Aug 2022 09:01:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc] IB/core: Fix a nested dead lock as part of ODP
 flow
Message-ID: <YwW+pA46ydO827Jv@unreal>
References: <74d93541ea533ef7daec6f126deb1072500aeb16.1661251841.git.leonro@nvidia.com>
 <20220824002232.GD4090@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824002232.GD4090@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 23, 2022 at 09:22:32PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 23, 2022 at 01:51:02PM +0300, Leon Romanovsky wrote:
> 
> > index 90c85b17bf69..8a9e92068b15 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1225,6 +1225,7 @@ void mmput_async(struct mm_struct *mm)
> >  		schedule_work(&mm->async_put_work);
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(mmput_async);
> >  #endif
> 
> This needs to be cc'd to more lists

Right, thanks.

> 
> Jason
