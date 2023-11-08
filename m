Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7735A7E4EFB
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 03:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjKHCiN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Nov 2023 21:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKHCiN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Nov 2023 21:38:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F6184;
        Tue,  7 Nov 2023 18:38:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39919C433C7;
        Wed,  8 Nov 2023 02:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699411090;
        bh=xQXSHY99tMn6wHTjcb9UdcPhv4XfJAyPz8gPkmjHz4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pSnFHRQ3gU8YMNY+ZGYNhtMIgaveRgUN5jKE5dKs2U6vmW+vcMW8vtLQtn6HdJzGr
         lrGpX5eZ+vsPp/kfxUNQtGtETLhx7Mo29i9IjWbb4lfo+31ljaDq5+S1TBmg8SbSGK
         acqrkpGg0HSaPI8y8cuJQUON+CZDqLM+550KFG7C+xQwatwjNp8VrINbaHkgXXlJwY
         4fuwGmWdblrZL62bdCXLG2Hxf/4YJqSpk/eWwUZ0xrsxCLkyy/Pa83Ol/QcmLhQ6xl
         OrGyMFJ21424C1ogYhJSGqOb/Zuvd9VuFub/nYXTW2GZonSy9BiT2UhBk9t+CfUSBN
         AwtHPT2VjymIQ==
Date:   Tue, 7 Nov 2023 18:38:09 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: avoid data corruption caused by decline
Message-ID: <20231107183809.58859c8f@kernel.org>
In-Reply-To: <1699329376-17596-1-git-send-email-alibuda@linux.alibaba.com>
References: <1699329376-17596-1-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue,  7 Nov 2023 11:56:16 +0800 D. Wythe wrote:
> This issue requires an immediate solution, since the protocol updates
> involve a more long-term solution.

Please provide an appropriate Fixes tag.
-- 
pw-bot: cr
pv-bot: fixes
