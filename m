Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D35629E6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 21:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfGHTvX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 15:51:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46440 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfGHTvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 15:51:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id r3so9041446vsr.13
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ftluoj4yOlQipKAeta7Scq3+G3tgZ90e4gOgebDuX14=;
        b=L36c18po747ADd1sPVwpIiGMx9gCkWJJEa00F4vTjikPo4oJtPlivYHC1ma7UpxQ1k
         kz1Z3+K9C7SM+N53hqjlF040U/Emkl1o2sfLNaM5SNHXV3l9oHbVrAUE76Erk9TxzBnd
         zFqHctnMWCID/NYHdxsYoqfk6CylL0XCIHi06L84e0TYhWvfx4mg/CQtZbPIUbDSxFI6
         laLPt+qpHONuLUShIv0dAud2FHszVAXCtXxvmhUtTCGCqowWcB9GNC41bUJLBIHaL7/O
         AHspvE5pniqbOZg/u4E3pcIyHErFRvlqlzUkcrY9DnOAU+WPL1OZx/ZVHkS01U0HPINf
         ulZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ftluoj4yOlQipKAeta7Scq3+G3tgZ90e4gOgebDuX14=;
        b=coz3VBhvAfde0CRoof/Tav4cxk5ixuORJgrjzdgleX2fD9NQ7dTl+AAcZvqaIQjIQ+
         2FnFl7udvUfSZ5ioW28DUXraWO63gRdTUAOy303dWbvKI3EbEW5yte3n8mkbEgVJ6yBT
         lae/dHiv1CLmGQ0GmJdPRG4UGp5XgrbZglthWfwzMCh+zX6CAVZMhEPB8W9PEUyX+BMs
         pfRi9Cs+CNEHwnlxgXyzjIG94gT5bcSTRe6ZTFvkJp49agtJFOFcC65mwv4twJwMxqcJ
         MnWuAm4nP08yjwMgbABc81WlGJcN3GoVGow/6duZrjVTtDC7iyT5WzQSYCACVlL6k36Q
         tyWA==
X-Gm-Message-State: APjAAAWrW0QM1aLbZ0pqybhqafUZ/M11W9HCxRZC8Xy17nJp0u9N5zC3
        zvRt93D4XxG6vhTm9b9C2U49gpYKfVgmiQ==
X-Google-Smtp-Source: APXvYqz3m1VnklOE3Z5i199i3+QtlCOnLVzDN7wnSYovg/t3ImVLC2f6+5GZN3uRr3Jh+lMSRTR28w==
X-Received: by 2002:a67:3195:: with SMTP id x143mr12064210vsx.144.1562615481923;
        Mon, 08 Jul 2019 12:51:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a123sm5282851vka.22.2019.07.08.12.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 12:51:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkZfU-0006Xc-2L; Mon, 08 Jul 2019 16:51:20 -0300
Date:   Mon, 8 Jul 2019 16:51:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
Cc:     monis@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Make rxe driver to calculate correct byte_len on
 receiving side when work completion is generated with
 IB_WC_RECV_RDMA_WITH_IMM opcode.
Message-ID: <20190708195120.GA25113@ziepe.ca>
References: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 27, 2019 at 04:06:43PM +0200, Konstantin Taranov wrote:
> Make softRoce to calculate correct byte_len on receiving side when work completion
> is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
> 
> According to documentation byte_len must indicate the number of written
> bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.
> 
> The patch proposes to remember the length of an RDMA request from the RETH header, and use it 
> as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.
> 
> Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
