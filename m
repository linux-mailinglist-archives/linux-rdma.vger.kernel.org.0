Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1A7E5997
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 15:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjKHO6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 09:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKHO6h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 09:58:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB261BE4;
        Wed,  8 Nov 2023 06:58:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2715C433C7;
        Wed,  8 Nov 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699455515;
        bh=QDjFCmHH6h+K9Er2ddj4qLmCjeHwGVRBq9EZ/5oimXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SnAKGzXDvtnJ4ZWT+2mPNjlDEpKunMDjWYVWGVwdfKFZA2nAl3qTQwEXB4+g80W+Q
         hUovz9t9cRKokw6DS6l2JZsiQkB27QXGPWTfq+hu85EGh/twT4AzJjLJY0F5gkl5Bq
         GE9lJvIuY6trGqCdAUbLm11y6u4LBZosK/wnquzMRctQ3UpDdrouOdI9B7uM//Cn/3
         pv/cF+ZuX5WVxr0wyWfDB03P0hOle1qc+dznQZXo528O6WzZ2+HWFBSIgxMe3HmxJB
         2kO5Meu/1ZyF0inBTuke86krTMRf7PP6wjKfPjoTUlN5Sxwybb8G/aJneaYYcwXtST
         jOlB1UPMF8D3A==
Date:   Wed, 8 Nov 2023 06:58:33 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
Message-ID: <20231108065833.3d6ec1c6@kernel.org>
In-Reply-To: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed,  8 Nov 2023 17:48:29 +0800 D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.

Please make sure you CC all relevant people pointed out
by get_maintainers. Make sure you run get_maintainers
on the generated patch, not just on file paths.

You seem to have missed the following people:
 pabeni@redhat.com
 guwen@linux.alibaba.com
 tonylu@linux.alibaba.com
 edumazet@google.com 
-- 
pw-bot: cr
pv-bot: cc
