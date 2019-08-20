Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E890695FEF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfHTNW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 09:22:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45895 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTNW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Aug 2019 09:22:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so4424340qki.12
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqGeIJo8kRr/YBMWPZV3b70vMPm00MIxx1Q8NT477lQ=;
        b=oW8tD530IlqtdO63gXfxSVbqCXXM10INUmPilf9S87BZrYPUUkhe5JRpBXsvO1nbHS
         KV5XI5VF20pEfLoxDg+IrTTNn85En3Q600kP39p6MnR3GNS9RM/d7VBwbO/mgMFbYoz6
         xbpKStEccRJ3+F3opbWAPFzXPs7770PZtV1Rdb/r6ESSKsXHkuIDC7EQQwCCphGTMfcR
         uRfv0o/aNNwcsjYJHsuU267oyNHz0t1n7486LRjGpsB4Z8qof3APDCmpVIrsq2owa1IP
         h/KDflrbYlYnWM+wucpsZVrjH4LTcooMOWKQth0flBlh5nTx99jwPGcF8eu8R3dGOkre
         1lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqGeIJo8kRr/YBMWPZV3b70vMPm00MIxx1Q8NT477lQ=;
        b=RyiE0JGNvKYAqjuVk/ktVlmP2eEbOPnDiIjQbX56N6ypy8IRH8ypdphEa4/MTc1wc9
         5Gq81Eo7N3EbXaPs4blMLgse9p5axlaS+eB/munBoQHTCFlc+Se/dxXaWMmvG/4qj3X+
         Vwr0zAezS7e8/dRhjAjznqXxO5UvrUNGX2F5iHcNs8T4kEO3GPq6g+FYhgtYUx526wu1
         pMJpMHjO/mu1z03zAwrP2u8lZGKqdC3YUGKyk2dRiOv1uQRMyN5aowB+DlNhrMdPhWJy
         Vtgmziu8FTy//rZVAktObJJkIZXFGsX1L7nHHWcHJ93HjmmUp/+rw6VH5Mf+WDeFvAnd
         TdoQ==
X-Gm-Message-State: APjAAAV988OJE5r4yR0NE55u/yIGEaAHLuaClNHY4tgpfwOs0XZVYLl0
        bVPV5Lm4cp+VwdV8aYMx2NKiSQ==
X-Google-Smtp-Source: APXvYqyV8RNHH//lTCUcUR87Zo9o1INQ+OCbkf8johMx4B9Tesgn4Au96tTt3ZNYZ2AibA+F6YHx8w==
X-Received: by 2002:a05:620a:13bb:: with SMTP id m27mr26113160qki.88.1566307375954;
        Tue, 20 Aug 2019 06:22:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a2sm8557820qkd.76.2019.08.20.06.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 06:22:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i046B-0000Ol-7W; Tue, 20 Aug 2019 10:22:55 -0300
Date:   Tue, 20 Aug 2019 10:22:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH] siw: fix 64/32bit pointer inconsistency.
Message-ID: <20190820132255.GD29246@ziepe.ca>
References: <20190820131442.26466-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131442.26466-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 03:14:42PM +0200, Bernard Metzler wrote:
>  		} else if (c_tx->in_syscall) {
> -			if (copy_from_user((void *)paddr,
> -					   (const void __user *)sge->laddr,
> -					   bytes))
> +			if (copy_from_user(paddr,
> +				(const void __user *)(uintptr_t)sge->laddr,
> +				bytes))

This pattern should be written u64_to_user_ptr(), in fact every
place that treats a user sourced u64 should use it.

Jason
