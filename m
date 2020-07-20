Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D52225D4C
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGTLYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 07:24:12 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:39879 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgGTLYM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 07:24:12 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 07:24:11 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EEED53F64F;
        Mon, 20 Jul 2020 13:15:33 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=gTkGdHYR;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vixtsmS5pBFA; Mon, 20 Jul 2020 13:15:33 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7B7A03F2DB;
        Mon, 20 Jul 2020 13:15:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [134.134.139.76])
        by mail1.shipmail.org (Postfix) with ESMTPSA id CCBA93605CC;
        Mon, 20 Jul 2020 13:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595243729; bh=mjlfxngBtSmrB32mu8iDZVMjrYWXXM5cA0DACfYZQ2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gTkGdHYRQjhf+Xn+mawTLz9g2cXReJ781N7XtbRK9TZGGLo4yDhimnm9Mevq/ntPQ
         uyLUhQhfiM7x08z9IjjGWSu3S+AP+bNX+mEqJyRsxaF/sP0FmGUpVvXDhY8a5dEKvZ
         LGF1OoSNnF/ZVdVaQNJHgwIeW7LViWHDfAvpN52E=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Daniel Stone <daniels@collabora.com>, linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Steve Pronovost <spronovo@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
Date:   Mon, 20 Jul 2020 13:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709123339.547390-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 7/9/20 2:33 PM, Daniel Vetter wrote:
> Comes up every few years, gets somewhat tedious to discuss, let's
> write this down once and for all.
>
> What I'm not sure about is whether the text should be more explicit in
> flat out mandating the amdkfd eviction fences for long running compute
> workloads or workloads where userspace fencing is allowed.

Although (in my humble opinion) it might be possible to completely 
untangle kernel-introduced fences for resource management and dma-fences 
used for completion- and dependency tracking and lift a lot of 
restrictions for the dma-fences, including prohibiting infinite ones, I 
think this makes sense describing the current state.

Reviewed-by: Thomas Hellstrom <thomas.hellstrom@intel.com>


