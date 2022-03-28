Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D84E8E2D
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiC1G3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 02:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiC1G3F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 02:29:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575F522D7;
        Sun, 27 Mar 2022 23:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8C82B80E46;
        Mon, 28 Mar 2022 06:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF4C340F0;
        Mon, 28 Mar 2022 06:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648448842;
        bh=meJvJUNXmP1B0s8GQqdqGBbvf3SOKnU0JOh94zcvqJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdoT7pYguHNOLiSLxOctmCCd+2U3kLC328sI7xclFwpRytuAKHZP8etMkLXJjb1Os
         UdxkS9VYtJ611sIkQCf17Y+7IE0FPBaMwfKHIdIURco1dJGIe5PqcIPfyRpzdTaqkj
         dkU6BUIRJ5tx54NrchBQH/gomILpCUW7js6Ee/i71EjHcXW5RUtPJ2dHvCjJksXfBr
         2iM0BlV5NriRB7pOB4LETbiZg+6jtChcFVF5Jc2bYhM1ZSpMrmi1rMLNJ5uVJIGnhJ
         KZamH9un6jZ+vBD7Pw6uyWRtlimnZGqqZ8f9iOGVkIA6YbReeVCqLGy+23VrhhivoG
         +k1Qcpjih45cQ==
Date:   Mon, 28 Mar 2022 09:27:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH v2] IB/SA: replace usage of found with dedicated list
 iterator variable
Message-ID: <YkFVRgZpfbsbpGuH@unreal>
References: <20220327212943.2165728-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327212943.2165728-1-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 27, 2022 at 11:29:43PM +0200, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> v1->v2:
> - set query correctly (Mark Zhang)
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---

Please put changelog and Link after "---" section, as we don't need it
in git commit history.

>  drivers/infiniband/core/sa_query.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

The change itself is LGTM.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
