Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3AD48FBAA
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jan 2022 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiAPIdn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jan 2022 03:33:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60700 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiAPIdm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jan 2022 03:33:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD50C60DDF
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jan 2022 08:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DAEC36AE3;
        Sun, 16 Jan 2022 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642322021;
        bh=PegAv1rvHl+Y+B94u2/U7hFGy3aq5d5ddH0Hk3HEP1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvEPj4+fYi2HsnEy3LCT3vAdi+xzTfGpM05rW2zh4ozxShz0PdOBgQnk9Ou/MaqgX
         TH+gMoRZgvJbapcH9NkWc2TgsuMCAcFVV6HyfBi49T74SMbRsO8T8AJaqB+OQHsRnB
         jW3tEKNYvcfAcgYTppsQDsAgwgX91x1L1LWC0dqBEaQCYD8WYsjOu4DHj1KJCUNV+h
         1qrW4uexwK1oJnHwKKY4GZeBzJsp7I1PIeLBLgyNpnde2vpxxaRVx8uLzQbBm8c6nb
         PF7csluNSJeHXke8ybkHkrvrRGjpW3KcMs5pHu1/cjsUKIsk4Q/s2yPKWDjDrWFWyn
         7njWfpbX+0Gcg==
Date:   Sun, 16 Jan 2022 10:33:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Joshua West <josh@cayk.ca>
Cc:     ceph-users <ceph-users@ceph.io>, linux-rdma@vger.kernel.org
Subject: Re: RDMA Bridging? ("You don't know that you don't know")
Message-ID: <YePYYK0ZJ9/a7Y6s@unreal>
References: <CAMCTd2kE7M3-ECU1oyz1ZHgiK1fmfkdvJsFssLV0h=bzexiRZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMCTd2kE7M3-ECU1oyz1ZHgiK1fmfkdvJsFssLV0h=bzexiRZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 12, 2022 at 08:32:17AM -0700, Joshua West wrote:
> Hey Folks,

<...>

> What is the correct method for "routing" rdma / RoCE ?

I don't know anything about CEPH, so my answer comes from HW/kernel
perspective.

In RoCE, we use GID table entries to perform routing.

Thanks

> 
> 
> 
> Josh
