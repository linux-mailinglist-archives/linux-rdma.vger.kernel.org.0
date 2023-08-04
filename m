Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE277098E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHDURT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHDURS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 16:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D53BE6E;
        Fri,  4 Aug 2023 13:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA0F61EC6;
        Fri,  4 Aug 2023 20:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3EC433C8;
        Fri,  4 Aug 2023 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691180236;
        bh=OcTcljePJX9c6fP6sanmFy/UWxdTl4nx+tja6jELDHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTc67s1ra5Zycend0jOp1YfLC+z9Ig1JiLAq8NGhvkWzfreLfDzo2u05Mpxfx3PO6
         4rGWjrGn86Jaa6SF/mi4YhhE+6f+Rkvz95RZ7Ta2aMyhCRvZTPGTDm4SLe98KEtM5l
         wfKWpq/YCUH/ywXCMtakNxA+NeXKQTOGOrAqZHXPwaeyMLcVlFD9Ose4p0YtYg/frq
         3d5pO3OCQMg7mZcL2NxjKhkKH+mEK0za/AMouMhnDznx6eithGPklJonb6Tqg1gUnl
         bBqw7U0orI6i5Qu0nJEqpMTzRhd/LPpPmXOd1yo1Oc4s/aldFE/zF5wWcqXNCFfVPd
         0kA7aaMp08kjA==
Date:   Fri, 4 Aug 2023 13:17:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <tariqt@nvidia.com>, <s.shtylyov@omp.ru>, <aspriel@gmail.com>,
        <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <kvalo@kernel.org>, <richardcochran@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>,
        <u.kleine-koenig@pengutronix.de>, <mkl@pengutronix.de>,
        <lee@kernel.org>, <set_pte_at@outlook.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>
Subject: Re: [PATCH -next 0/6] net: Remove unnecessary ternary operators
Message-ID: <20230804131713.09383df4@kernel.org>
In-Reply-To: <20230804035346.2879318-1-ruanjinjie@huawei.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 4 Aug 2023 11:53:40 +0800 Ruan Jinjie wrote:
> There are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.

Who cares. Please stop sending these trivial cleanups to networking
core and drivers.
-- 
pw-bot: reject
