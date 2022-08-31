Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05E5A794D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiHaIqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiHaIqH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 04:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3032ABD77
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 01:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CA4619FF
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 08:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56537C433C1;
        Wed, 31 Aug 2022 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661935565;
        bh=fWqPWk9gTYmnOwQn3MU82U3/1x7Mf3PCyDgPeBtDIOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdMTNunswAag5FD3OIEiq471AFwnYTDMM3+yR5TQIZP7gekLNO6zxI5mKQHbspBO/
         aYSWunUcbCuNI0wHk1GNIUBNsDFX+1RsT8OFo18DqpQMRWk4YLxUYtXGdw6OAUEv1y
         QqQlzA3DuywoUhrkqBzki4Rinj/wOqV3KyK29MZkcxnxuP5yAV1xnq1JZfitwMvwqZ
         tENdZaMOgjhBtMAf7IsaqdPJ1N5dpx7DM4ab6k12EXtF2E7Joe9/qqshElPf8ITS7k
         O66Mo6cNbHgTPv7gh3ET+jkc0FZWdHtYt1Xm6DnwnveMKpPlgikFbCf7J4vX88PNc/
         6Z5nYwfIcWKwg==
Date:   Wed, 31 Aug 2022 11:46:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Message-ID: <Yw8fyUD0HK0Z6YEb@unreal>
References: <20220805183523.32044-1-rpearsonhpe@gmail.com>
 <TYCPR01MB93059478A187A821F8F8469AA5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
 <fa1fb86c-fd1c-d431-954b-98540299bf4a@fujitsu.com>
 <Yw7/KilXI8l+1/uA@unreal>
 <2124b2b6-8fd9-64a3-5c66-3e7ef7565606@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2124b2b6-8fd9-64a3-5c66-3e7ef7565606@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 31, 2022 at 04:05:57PM +0800, Li Zhijian wrote:
> Leon,
> 
> 
> On 31/08/2022 14:26, Leon Romanovsky wrote:
> > On Wed, Aug 31, 2022 at 01:48:08PM +0800, Li Zhijian wrote:
> > > BTW: this patch should be for-rc instead.
> > It can't be in -rc without Fixes line and more clear description.
> 
> Fixes: cf40367961d8 ("RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()") ?
> 
> IIRC, This patch fixes a kernel crash newly introduced by v6.0 merge window
> it's an alternative for my former patch: https://lore.kernel.org/all/42ec06bb-9e97-3b43-5fb9-9801407d301e@fujitsu.com/
> So if you agree it should go to for-rc, does Bob need to repost a new one with more details ?

Yes, please, especially kernel panic.

> 
> 
> > 
> > Thanks
> 
