Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0066B758F80
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSHtN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 03:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGSHtL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 03:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175471997
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 00:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 127DC60C89
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 07:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA53CC433C7;
        Wed, 19 Jul 2023 07:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689752948;
        bh=R0PTRwxT7bhffP9nFZMFGlCbjMMurGSEy38G395qihE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZTs7V8i7IYRToX1QYT9f7JY8/tp3pI6sJHteadlvxtKB2o0QkvxBi/w01UJDqnsi
         psO3FgeuOSMCeTDEmTIecxb9zYsWNpOEvGtTYAW+I0u4l7kmMJs9x08tn+KO7kGUSf
         dVYv58fB5DiXnU9Vo8VOrb+p+DXWkEgBYRsZvdkpyYSRPZVoCYakxhq+8o5engJyju
         SDe6Up4DNoQjq03MOWy/PJgUCLLtPccMNK9kQtLJnXwj1h/Bt/waaubaYoypZ/6mQu
         h5Wxdl98/AZHhxLirQ7p3z9AMacQgcSLuCo+aSAc1sPJZehfuY2YBdx7ZcowVQEjm/
         k3uklpn6nWqww==
Date:   Wed, 19 Jul 2023 10:49:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Subject: Re: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed
 objects
Message-ID: <20230719074904.GH8808@unreal>
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
 <20230718175943.16734-3-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718175943.16734-3-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 18, 2023 at 12:59:44PM -0500, Bob Pearson wrote:
> Make rcu_read locking of critical sections with the indexed
> verbs objects be protected from early freeing of those objects.
> The AH, QP, MR and MW objects are looked up from their indices
> contained in received packets or WQEs during I/O processing.
> Make these objects be freed using kfree_rcu to avoid races.

Sorry, how use of RCU avoid races?

Thanks
