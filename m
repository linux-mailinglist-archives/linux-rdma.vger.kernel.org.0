Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021E63F719
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 19:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiLASFa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLASF3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 13:05:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043DB68CD;
        Thu,  1 Dec 2022 10:05:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A5A2620A5;
        Thu,  1 Dec 2022 18:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6332AC433D6;
        Thu,  1 Dec 2022 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669917927;
        bh=zLB1Nh9GGDyIWBvfvHJFIAPcZZ4kNqUaEGoqNwVteK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljUvm6l4FHjwYPLmknS6tyH13hRQrpFwTMkv4wiqFLsK2UQJlhg0gBixPkZ9qGoL0
         jiknIrw74IBNpZmoQQ6cSZg2HkrPzL/kN3a8vXuanT8Y+gyOo0nSbRrNb2X/hAHD1b
         9W2pVkiwN1/V9RCyi57e5Ixo7NQ+/g4YxDpFrKUbO+hlwp+tCQyMQCIJn7RL2Fc6ze
         M7SHCW0BsVm7NEEPkgWjwIfXm1t/7k/7xzVhI30gfKu1ZQmMQD2vTUbN2fZb7cLlaV
         Bb3HkOWD4O55K9chhSUo+FlIocFIHA7Rz6EC6UmblQ8FniZRRyMrWYeqGaFLqiWped
         oRhCqGL4VWiBA==
Date:   Thu, 1 Dec 2022 20:05:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4js47I/JjCXunzF@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
 <Y4hyPPzyQiI3i9jh@unreal>
 <Y4jhMwCox6RGI5FM@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4jhMwCox6RGI5FM@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 09:15:31AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 01, 2022 at 11:22:04AM +0200, Leon Romanovsky wrote:
> > I would advocate to add this line to whole drivers/infiniband.
> > None of RDMA code makes sense for UML.
> 
> software iWarp and RoCE absolutely make sense on UML.

Ok, to be more pedantic "none of RDMA HW code ...".
However does anybody use rxe or siw in UML?

Thanks
