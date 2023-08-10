Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B17781C9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHJTtO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHJTtO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 15:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FC02720
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 12:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421296683E
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 19:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70838C433C7;
        Thu, 10 Aug 2023 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691696952;
        bh=D3ftcslJ8YcyfvSLWosKRnrmeg4ITPNuHnd1GqSvXL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emz27WWvZZ1hiv59S5Ojs39+m6bGWpOehRnXX9Roe61sfrxb4QYqIpXAh9s8hmX/B
         V7gOkJtjnAviKdqb4XpPnL7hGxMbF5lIhafOzz9qzryy+cfBvBM3DAYrRtRec1n7qv
         d5OAkkCCzudrrK8vF8VUkcDM/FJEUrdHfG8TPVshy2tqXPfBwl4mBkXnIpp50usJz6
         gP/MVefeLRSp+d7AqYyN2S2H9nOPVgh1SNzF6hxWghcPwJyaYoT7c8hukOYl8C8Flv
         q227yWRWhqDlXTVJUidbcBnCWZPjmjQbr4J1dUlIn2lYS9kFmNcsqAEbmoxSxRm5Qy
         PHVOYeRndGadQ==
Date:   Thu, 10 Aug 2023 21:49:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: tcp: Remove unused declaration
 rds_tcp_map_seq()
Message-ID: <ZNU/M1Iot28KUYtv@vergenet.net>
References: <20230809144148.13052-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809144148.13052-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 10:41:48PM +0800, Yue Haibing wrote:
> rds_tcp_map_seq() is never implemented and used since
> commit 70041088e3b9 ("RDS: Add TCP transport to RDS").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

BTW, I think these rds patches could have been rolled-up
into a patch-set, or perhaps better still squashed into a single patch.
