Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1644078429F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjHVN6V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjHVN6V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 09:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D91B0;
        Tue, 22 Aug 2023 06:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3F862BBE;
        Tue, 22 Aug 2023 13:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5563EC433C7;
        Tue, 22 Aug 2023 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712698;
        bh=EwnaeG11T0pAgOGrR75yz5mB93DOJHKL6m0C7JpZaIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBLNwXDTz9I5hKK3HFWe02UMpfzgdtFgK3qEXrodGDUBHSotZ463/yfbQkSFF+Bws
         5Ofj8/OOmnE6yI2eYQHis4XeDmZ0I8FJeksUSnuGzAxJxN5dq5nIfAvUdfu31qIcmW
         qHuMFgjzsEj7q11RfqAYFnKQOw0G912miaGlS7dvSNi+a519Wlmj81Pa/UUE4/KlCw
         SWfOMULiEZL+r6Y23rPlI/P5AxXOHs+Hmwl83Tn/IWK99RGrOc0y5mVyMvJs8FQvWo
         TJSvYhmvK2cSs9L/brnMwwq1AtTq2Z26muBYH+TG5IuZohpwiETfFJwsIs+5GdvNEB
         W2yhb55HKTlgA==
Date:   Tue, 22 Aug 2023 16:58:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        target-devel@vger.kernel.org
Subject: Re: [PATCH rdma-next] Revert "IB/isert: Fix incorrect release of
 isert connection"
Message-ID: <20230822135814.GD6029@unreal>
References: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
 <38350699-ce4c-4298-8ebf-c9c6b5a72c2e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38350699-ce4c-4298-8ebf-c9c6b5a72c2e@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 21, 2023 at 11:25:35AM -0500, Mike Christie wrote:
> On 8/21/23 2:57 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> 
> Was the issue described in that commit just not correct? Or was it
> supposed to be for some sort of race'y error path?
> 
> It looks like that analysis was wrong for the normal login/logout path where
> we call:

I came to same conclusion when analyzed Dennis's report.

Thanks

> 
> 1. isert_init_conn sets kref to 1.
> 2. If we are connected we set kref to 2 via isert_connected_handler -> kref_get
> 3. When we logout from there then isert_wait_conn -> queue_work release_work
> and release_work does isert_put_conn so kref = 1.
> 4. Then we do isert_free_conn which does isert_put_conn to set the kref to 0
> and then free the conn.
> 
> So the patch in this mail looks ok.
> 
> I checked most of the error paths, but I might have missed some. It looks ok
> for them as well.
