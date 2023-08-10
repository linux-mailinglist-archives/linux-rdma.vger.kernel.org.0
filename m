Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6629F777FF0
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjHJSIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjHJSIx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 14:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D70E48
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 11:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8963635E7
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 18:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ADFC433C7;
        Thu, 10 Aug 2023 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691690932;
        bh=nZv6E2mt+6uhd16hMnF3qtJLtFMk5Z4Tzk4w0y3UqaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agm4Sm/vogldp/+2Ie18WRECFwuK6sOtUIdCHTJ10qATYLEmoGlr1k8/hMkJkAsia
         82Oi1AgdNtvJK0mqN8Hr3GjgtLSzLZrOlE6ywlasAQrOfretLl/4N31129eSyJ4gkD
         g79VTswCxFhO13LDUCHGI4LLoWim9OdTUluVZQzS05/KrsHqK4+yhLu1a2RsTcOQ0u
         C5DFqFaOMiqXH8BNToeysfjnxv9X7eeMHPSnI4X7IU4U/8k43AqQpHUt66AJwMFMj5
         PZhUbxFcaIomUY4b0Ak+Yd82Wr2O+gR6OB/o+jbgpjyRzGlf4A0IQKjO1sLgMZzC9D
         pwGUzfLBrIdrg==
Date:   Thu, 10 Aug 2023 20:08:48 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] RDS: IB: Remove unused declarations
Message-ID: <ZNUnsE+SuJ747yn4@vergenet.net>
References: <20230809141806.46476-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809141806.46476-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 10:18:06PM +0800, Yue Haibing wrote:
> Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
> removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
> And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
> the other functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

