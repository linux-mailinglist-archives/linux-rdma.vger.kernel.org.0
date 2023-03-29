Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3966CF2FC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjC2TTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC2TTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:19:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E22132
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 909ACCE24E3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 19:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D0FC433EF;
        Wed, 29 Mar 2023 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680117523;
        bh=RbWwt8huH8Zp0YniunNZKSU5/Diyya0dndz1Ls+QVDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7EWAFD4ARwhYPKg/4Xl9lm6/NgvwGobYYcFq5ZihKRJbOkrHwRHDOHb/qkmkZDfw
         sK3KrU5gyj3pIpDUZWJSCEJDH26wR3D24aZT6MbdY+P6ueAlsHCSKi4p3xVj8vE1VF
         PXwybyv0k6/tZbaiAddaKUnLKY2H5cFZ0Kktte3sZ8+oM82x+emUOiCegwQgGGk5Jz
         qybyhMwE+SyklMX16j2Ghn57RKICQfemTsbUfoU1ur79f4KKsSw76G0TCOxAG7cJ4v
         bWOitVw334zkWtq+4SXUmq/0KNJ8rQ6wvzsLzteVHtFufiOJ3FoSOtQCQahzquP+Jp
         zuXlh/obWPkPA==
Date:   Wed, 29 Mar 2023 22:18:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Clean kzalloc failure paths
Message-ID: <20230329191839.GI831478@unreal>
References: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
 <88b57490-4260-42f6-88e0-ff8a3d30ce51@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b57490-4260-42f6-88e0-ff8a3d30ce51@kili.mountain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 09:44:09PM +0300, Dan Carpenter wrote:
> On Wed, Mar 29, 2023 at 09:14:01PM +0300, Leon Romanovsky wrote:
> > @@ -1287,11 +1279,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
> >  	}
> >  
> >  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> > -	if (!mr) {
> > -		err = -ENOMEM;
> > -		rxe_dbg_mr(mr, "no memory for mr");
> > -		goto err_out;
> > -	}
> > +	if (!mr)
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	err = rxe_add_to_pool(&rxe->mr_pool, mr);
> >  	if (err) {
>         ^^^^^^^^^^
> If the rxe_add_to_pool() fails then it calls:
> 
> 	rxe_dbg_mr(mr, "unable to create mr, err = %d", err);
>                    ^^
> 
> "rm" is zeroed mem and not useful at this point.  Possibly in a later
> patch though.

I will delete that line when will apply the patch.

Thanks

> 
> regards,
> dan carpenter
> 
