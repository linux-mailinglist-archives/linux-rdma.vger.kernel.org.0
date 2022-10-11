Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C805FB039
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Oct 2022 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJKKM3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Oct 2022 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKKM2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Oct 2022 06:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02D326FB
        for <linux-rdma@vger.kernel.org>; Tue, 11 Oct 2022 03:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746626116F
        for <linux-rdma@vger.kernel.org>; Tue, 11 Oct 2022 10:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B906C433D6;
        Tue, 11 Oct 2022 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665483146;
        bh=ut+CPf24xnDu/Di2W9l+Dt15v5saTJMQ/nDnos7WWrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhvcqAkbm7DL1PGTHAKopcHQ/TJjxV1ZGdpvEJvsw5kq6eMidOUb4zSN9I1XYgeZP
         YEkmz3WbaRBT4wVJyADop85riAqORUQyv0iSeTzG+LzB+x8K8C2jvBj/kdlh2Rf016
         kZCwGiR8ffZV5ILVX7gKDIl8/u/OurtzxkWQxoaw9700ok/LauA1GlodS+uErEKiom
         WrOjIggHpOet/h/mbJGA0oLFkdZjlwu7WKa05tBV1kyizbHaIdXRch5H5+loVlYpST
         bmkkT7JJOG98Counc1bz8l0mj6naweW+kNmjbf6zt7l/AIsxw5+lJ+s0svye6sIOee
         AE/7hHRJhOSyg==
Date:   Tue, 11 Oct 2022 13:12:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     yanjun.zhu@linux.dev, jgg@nvidia.com, leo@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] RDMA/core: Fix a problem from rdma link in
 exclusive mode
Message-ID: <Y0VBhhhSfzRQ8GY9@unreal>
References: <Yz/FaiYZO5Y0R7QP@unreal>
 <20221011002545.1410247-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011002545.1410247-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 10, 2022 at 08:25:45PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is not an official commit. In rdma net namespace, the rdma device
> is separate from the net device. For example, a rdma device A is in net
> namespace A1 while the related net device B is in net namespace B1.
> 
> I am curious how to make perftest and rping tests on the above
> scenario. The ip address of net device B is in net namespace B1
> while the rdma device is in net namespace A1.

Use "exclusive" mode, "shared" is legacy interface for backward
compatibility.

> 
> From my perspective, the rdma device and related net device should
> be in the same net namespace. When a net device is moved from one net
> namespace to another net namespace, the rdma device should be in the
> same net namespace with the net device.
> 
> In this commit, when all the ib devices are parsed in exclusive mode,
> if the ib devices and related net devices are not in the same net
> namespace, the link information will not be reported to user space.
> 
> This commit is a RFC.

Please don't send patches as reply-to.

Thanks
