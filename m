Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7B778007
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjHJSMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjHJSMv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 14:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26080E4B
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 11:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7AF1664C8
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 18:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C826C433C8;
        Thu, 10 Aug 2023 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691691170;
        bh=Oxr4KXfx95/65MtHcCBNNZFIsBML7khA1Do5fH2mkIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSNQs9p0FR6bmSUGjT8jm72M0ZTW9JVkkZ6QNQG/UbmzHqoW6n0HsLPVSldq8I+XW
         ylyNW424tAktR1SitA5MxuoLly3g+WMEtv7wRrHA0FQ5PAi0hkjAsYMVdLctKB+yjk
         qQVJo1zNDydmYm/C//F0aWeUVcmDzwdnWijFIg2pD6xX7GriseAL5cOGIRPXfDUhoP
         ri/3yxCoxkUpKwlp2KRWrg9sJt/6R6FQ0h+GW0NIY8j5hx7xnSkr9OUP11yV4beqMP
         2CbWAHtpp2vr5j7LQenqmJhIAkvuaHJk+y2VQMP7vIq6UsW/tL4RPrSs6L6Y7sDEU/
         YbSbWeGvm8GHw==
Date:   Thu, 10 Aug 2023 20:12:46 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] net/rds: Remove unused function declarations
Message-ID: <ZNUongYwq7C8K7wc@vergenet.net>
References: <20230809143627.34564-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809143627.34564-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 10:36:27PM +0800, Yue Haibing wrote:
> Commit 39de8281791c ("RDS: Main header file") declared but never implemented
> rds_trans_init() and rds_trans_exit(), remove it.
> Commit d37c9359056f ("RDS: Move loop-only function to loop.c") removed the
> implementation rds_message_inc_free() but not the declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

