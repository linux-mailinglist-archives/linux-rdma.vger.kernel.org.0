Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2F203A2F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgFVPAU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgFVPAU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 11:00:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3842C061573
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 08:00:19 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p15so8052339qvr.9
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7qWHsC1j+rzytW5kRDQGFmoYRD1aIZmL/Kv0s0SNR6w=;
        b=YL0a1NQJXLrRL8yKCfMAe/47DWKGBphODWARq7MM9OXVK0o513cDS7pcD9Z8EgCj8E
         1zGC3nL8BsvIqH7SP1O8W2TZOZNS1GCfMZric6FfsR8YJy3ZfT/bEodq61fYAKzXpcdI
         wZx+G57vC5bYmceE+gieKZFsu5ccOXAjpzC/mDEI7K37tRPDLzVqJewIGq4Ej+InPEtP
         Jov68nuKluJUF8J/N56fmAKQz/1KOMUWQeBXZhLVVRDVPMms44j2gLYBJouGg2uzZZZB
         KGtOOsZueJTo7Mbpf6PV/9V5y3wo90um6XcTxw1MzNdL1z5jr32zWO7Hea2nRHWwkQUp
         UCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qWHsC1j+rzytW5kRDQGFmoYRD1aIZmL/Kv0s0SNR6w=;
        b=X0EMN2TwsP9rxwV5AKloVhL2X22AEMJbz8Ox1B6kIBXfWKjV/lSOcxQrNfC3hf1Uu2
         ZPjEIrKntr0mkc62nEW1wcik9mAnFExjM9W3aVY3r1icZj2ETBR4Kno/cSUuouAiE3EO
         iXy9ZDBROhi8qHjXWAJfHppFMsqvtWppQJ1gT4GcjUddY8bkH+jMiiq+k6KwGU3QYKyH
         CtiCw4xPF0eAIXA9kLtGJvbmpNS12HviW8IKFx8ncoEXbglQ1C0caSC4mHKHUmOt8/ss
         XfpxbgNVEQK40n2VS+Hc4LYqhuXGglC/a/dIxC3vIvPmYUs3dtkFbR8Dk2Zq3kfRLcc4
         t/Kw==
X-Gm-Message-State: AOAM531pqWpPNTSC4Nc9IyMbCSiW7gjjccaBRypCty5u86iaqvf4JkPL
        TWdv/TTYaxhabIWEIN+YIRYdXg==
X-Google-Smtp-Source: ABdhPJyTNT72NG7ud9VRMg9gCZT0idzwPQsN5KAs4LjYU1Hf66xUwDITX+WFZ3FF7LTT5B6lw80/Gw==
X-Received: by 2002:ad4:4763:: with SMTP id d3mr22435258qvx.232.1592838019158;
        Mon, 22 Jun 2020 08:00:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l19sm14069098qtq.13.2020.06.22.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:00:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnNvm-00BxjT-6E; Mon, 22 Jun 2020 12:00:18 -0300
Date:   Mon, 22 Jun 2020 12:00:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Subject: Re: Fwd: [PATCH] infiniband: correct trivial kernel-doc
 inconsistencies
Message-ID: <20200622150018.GV6578@ziepe.ca>
References: <5373936.DvuYhMxLoT@laptop.coltonlewis.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5373936.DvuYhMxLoT@laptop.coltonlewis.name>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 02:07:38AM +0000, Colton Lewis wrote:
> Can someone please accept or comment on this patch?
> 
> 
> Subject: [PATCH] infiniband: correct trivial kernel-doc inconsistencies
> Date: Thursday, June 11, 2020, 1:45:06 AM CDT
> From: Colton Lewis <colton.w.lewis@protonmail.com>
> To: dledford@redhat.com
> CC: trivial@kernel.org, Colton Lewis <colton.w.lewis@protonmail.com>

Patches that are not sent to linux-rdma@vger.kernel.org won't get
applied..

Applied to rmda for-next

Thanks,
Jason
