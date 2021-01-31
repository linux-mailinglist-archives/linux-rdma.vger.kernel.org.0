Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1970309E61
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Jan 2021 20:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhAaTrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Jan 2021 14:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhAaTms (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Jan 2021 14:42:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D3C061797
        for <linux-rdma@vger.kernel.org>; Sun, 31 Jan 2021 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hdYHmA5C5Zp3H9TWb7SrRpj4eKyfWbzS7KrTIYuKz08=; b=PL+j/1/Lulul7xckj2qoAysZIx
        oOPWdHhE6f/G0/fg0IA+16PUcjsUoahtBe3rkWVLNEjE2b4tFXtTgksMSVBR9+q+rtZmGAVIHE+bg
        aFdu+2GVIwH15FZz+6wGv+HJNAAxGK5rq8NaKFmm4LPmGe9yQRr5G09XfzMS3oQ8xmNrqqd1+rE/Z
        3k9VhkHsQ/C3eFkr6WecxwlzERNgC0S2FM1nl4M5L2dcNcWgQ3jSMCHY/YfUUQDClKtzvs6UulXMv
        BI77QPL+4ftS282+BwDDodiu3WQKdqkjsyc5Yg3W451knSTzF1bv1mVwXptiDp/0WvahH6dDgVHBV
        42bXqsIA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6IbE-00029B-9e; Sun, 31 Jan 2021 19:41:32 +0000
Subject: Re: infiniband Kconfig question
From:   Randy Dunlap <rdunlap@infradead.org>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
References: <443b76a6-564d-4329-601c-1dec3c3ce428@infradead.org>
Message-ID: <6cae3fc8-0349-8259-b4ca-af2635928a09@infradead.org>
Date:   Sun, 31 Jan 2021 11:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <443b76a6-564d-4329-601c-1dec3c3ce428@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/31/21 9:19 AM, Randy Dunlap wrote:
> Hi,
> 
> I happened to notice this Kconfig fragment in drivers/inifiniband/Kconfig:
> 
> [from:
> commit 6fa8f1afd3373c456e556815ebc8cb2330d6c3fe
> Author: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Date:   Wed Jan 9 11:15:15 2019 +0200
> ]
> 
> 
> if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
> source "drivers/infiniband/hw/mthca/Kconfig"
> source "drivers/infiniband/hw/qib/Kconfig"
> source "drivers/infiniband/hw/cxgb4/Kconfig"
> ...
> source "drivers/infiniband/hw/qedr/Kconfig"
> source "drivers/infiniband/sw/rdmavt/Kconfig"
> source "drivers/infiniband/sw/rxe/Kconfig"
> source "drivers/infiniband/sw/siw/Kconfig"
> endif
> 
> 
> and I was hoping that you could explain to me what the "if" line
> means or does?
> 
> From all of my testing, that "if" is always true
> (when INFINIBAND is enabled).


Arnd explained this to me (or at least showed me
what it does).

thanks.
-- 
~Randy

