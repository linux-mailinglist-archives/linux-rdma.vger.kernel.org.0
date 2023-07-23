Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A875E2C0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jul 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGWPA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGWPA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 11:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A337EE9
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 08:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3876060D57
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 15:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AAEC433C8;
        Sun, 23 Jul 2023 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690124454;
        bh=bIhW7dk4z34oGY8O1/BTFotGIBkFgGq3pHSZb+NybI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gi9Hdwn9kximX8yzPRlrAxwAI5/d8wGFYqycbNVLHuCtcNlgkM0YKERTL0y/fbU4v
         BrlyU2NyNArkWgIlYiB5EJ6JTXSWp/KrQEA8FZD+AhBiK48nH52mO2BMHa7xZDbcyU
         DsLNj0DsFhe6LikZp89zgEvzkSJxUA+nckZ/GWcDNfeouH4iMgn4nOiZ+ZE3JRphgn
         D8xSqIJ+hpsTzKxXXokpe6B91fOIhdxvUbZ73HGgTKmR0Z9EZLBO7rJtLA66kzangY
         qzEGfIjyp9G4QUf+8nyXVj1Q+6Svs9Qa2rDN+inVlnc8956ZmS1sTVILY04TzWt+oE
         XX6m+9IhH5zWQ==
Date:   Sun, 23 Jul 2023 18:00:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Subject: Re: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed
 objects
Message-ID: <20230723150050.GA60079@unreal>
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
 <20230718175943.16734-3-rpearsonhpe@gmail.com>
 <20230719074904.GH8808@unreal>
 <4450c401-2a02-d66d-5615-22f65e291a04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4450c401-2a02-d66d-5615-22f65e291a04@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 19, 2023 at 11:43:30AM -0500, Bob Pearson wrote:
> On 7/19/23 02:49, Leon Romanovsky wrote:
> > On Tue, Jul 18, 2023 at 12:59:44PM -0500, Bob Pearson wrote:
> >> Make rcu_read locking of critical sections with the indexed
> >> verbs objects be protected from early freeing of those objects.
> >> The AH, QP, MR and MW objects are looked up from their indices
> >> contained in received packets or WQEs during I/O processing.
> >> Make these objects be freed using kfree_rcu to avoid races.
> > 
> > Sorry, how use of RCU avoid races?
> > 
> > Thanks
> 
> The races are between destroy/deallocate/dereg verbs API calls and packets arriving or completing send
> or deferred processing of wqes. Packets and wqes contain indices/keys/numbers that refer to objects.
> The rxe driver maintains xarrays for each type of object that allow to lookup the address of the object
> from its index and then take a reference to protect the pointer. The destroy verbs defer completion
> until the reference count falls to zero and then removes the entry in the xarray. These operations
> need to be atomic. One alternative is to use spinlocks to protect them but that places a load on
> performance under heavy load which is typically dominated by the lookup function since objects tend
> to have a long lifetime. rcu readlocks are a better alternative but depend on the deferred destruction
> of the objects used in the rcu critical section. 

You rarely can replace locks with RCU without careful design changes.

Thanks
