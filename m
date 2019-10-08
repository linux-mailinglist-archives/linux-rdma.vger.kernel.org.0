Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC7D013B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfJHTbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:31:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33444 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfJHTbP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 15:31:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so17956521qkb.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Jp15FB74S6feOy21bfXfIJ7Ba6k05lzoCm9IhiHonE=;
        b=giRNwKIMuRhuWsUNoCkIxnNvtR/oaDCTxx+iwr8kE1fxsIEGNblKZo/VhkKDTVycgo
         UrQPtSEF96FO2kXinhYhRe6B999WbWS5hHDAr4GOumO0OgyV6nxPDXhWKXz8IHOTW4gx
         587TKj4V/B2FRCalSawQm/arOBau8nNDAut6+3D6VzBOJ+pmMWyTRpdH5TzWm5TzXEPz
         nmNvOJlNSB6ZDJH4NbjyFPDKZ9tp2s7gWGmL9cNa885Sz2afgFrNgMuEJ5LimcbcSx1Z
         cbkaUo4keIyQmF/bhUBRkSdVch6sroPk1V09k0vmG4ISWdxxMKnOk0hXvb9LraSSNclM
         QyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Jp15FB74S6feOy21bfXfIJ7Ba6k05lzoCm9IhiHonE=;
        b=tFu2EmhRC70/O7hclT3HLlhZ2jE/NPtwvYSUa6Azfmkw0lSApb81b61wqWch5UsPag
         GC6OUxWWnQ0rJid6kPhCtwqRugwDg6HXDoKwVuWwIguxLBxOCGrAhlR1KX09bkYcMpXl
         Jy2nW7wG6RF74cPRPjhZH/hCfUv6I5JxFkrA0mhlrBZ1RU3lOMcDdq/8seXwQavqiUKu
         1AkKj0A/fa1JxWgzgLcHDVnrdYOnloH3XmqrGe7q6A+QF3ATqYC8f6KpOT+ZZHqjslMj
         mq/0kMu7ZAsPGHYn0LiVWeGn05NeboRXtzOABHJjDr4V/Fio/bvxRMC0oepi4vbCTTAc
         1TsQ==
X-Gm-Message-State: APjAAAXRxU5a6fEgbx7k94iXUO0P46Saf0w2vP5Lstb/VfaknFEXBqSr
        1cJuHnNK0o8BTiKrbDnX/SfvZg==
X-Google-Smtp-Source: APXvYqwcA7swqE+EEBMnxjTnE/jdoRZ+g3JUB45XLAFA56JOcXR7K3U6CAdf6ZKnYr2soIoyiolJAA==
X-Received: by 2002:a37:9dd2:: with SMTP id g201mr30399655qke.55.1570563074755;
        Tue, 08 Oct 2019 12:31:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r7sm9853150qkf.124.2019.10.08.12.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 12:31:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHvCT-0005RZ-HY; Tue, 08 Oct 2019 16:31:13 -0300
Date:   Tue, 8 Oct 2019 16:31:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Enable SRIOV VF support on
 Broadcom's 57500 adapter series
Message-ID: <20191008193113.GA20622@ziepe.ca>
References: <1570081715-14301-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570081715-14301-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:48:35AM -0400, Devesh Sharma wrote:
> Broadcom's 575xx adapter series has support for SRIOV VFs.
> Making changes to enable SRIOV VF support. There are two
> major area where changes are done:
>  -- Added new DB location for control-path and data-path DB ring
>  -- New devices do not need to issue sriov-config slow-path command
>     thus, skipping to call that firmware command.
> For now enabling support for 64 RoCE VFs.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |   1 +
>  drivers/infiniband/hw/bnxt_re/main.c       | 133 +++++++++++++++++------------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   5 +-
>  3 files changed, 82 insertions(+), 57 deletions(-)

Applied to for-next, thanks

Jason
