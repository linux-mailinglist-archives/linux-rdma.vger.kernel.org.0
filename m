Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91057138D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiGLHy0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiGLHyZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 03:54:25 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21B21812
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 00:54:19 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 7665DB00266; Tue, 12 Jul 2022 09:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1657612457; bh=EsnKVf5Q2XDAOZINRJvq5Mrh7WNXnWs5VkJGoEnhxNI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=toMqzeUsasQS8lHKxk/yv/zYUjqXKq1u+HBl1DO8PDcfmhcwbYGwluvpSuxM5g7RD
         Bi7KCkAwJVgmXuOVmBpZ/3ChoOB3mUGSaqHnE6pOJ1qnl/riCbCMAdq+zpxEDMoYbz
         B1PKh4IE7pk4uEzkw1TwxTLa8yqZDq88MNDAUzlXuk0fZFP0ZRXcPvyVcaYSEeulYq
         L1yuVsGgpgdrP8b4YO3tuEErDXMyw2wi4cwtC+i0rbs5wqt4M3U1Qs69IT4P6B1KtQ
         JU6vb0/zPvxxZWuYluD2+IOZtFDPxeo3xLbXdFOo2AkGRBzLtDPF9bE7/ToyvN65jc
         RVMpBGwsrnszg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 72455B0001D;
        Tue, 12 Jul 2022 09:54:17 +0200 (CEST)
Date:   Tue, 12 Jul 2022 09:54:17 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
cc:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Subject: Re: [PATCH for-next 2/5] RDMA/rtrs-clt: Use this_cpu_ API for
 stats
In-Reply-To: <20220707142144.459751-3-haris.iqbal@ionos.com>
Message-ID: <alpine.DEB.2.22.394.2207120953340.30202@gentwo.de>
References: <20220707142144.459751-1-haris.iqbal@ionos.com> <20220707142144.459751-3-haris.iqbal@ionos.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Use this_cpu_x() for increasing/adding a percpu counter through a
> percpu pointer without the need to disable/enable preemption.

Reviewed-by: Christoph Lameter <cl@linux.com>
