Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74D2117128
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfLIQHL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 11:07:11 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37577 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Dec 2019 11:07:11 -0500
Received: by mail-yw1-f68.google.com with SMTP id 4so5985735ywx.4
        for <linux-rdma@vger.kernel.org>; Mon, 09 Dec 2019 08:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hJ1Rm2XXKJAPsVlE7zKM8ChfzT1hjLMkCfLQQ1dIU5c=;
        b=BCwndaVElJFKDSh54khXoUyby0y6dw4JzLsaWZNQlJEV55WukaPjB8MCUaqbCkHUne
         fmU31HpPwDtDi8/QWQSihu3LskFKAA26OVa3eC72uL4PTZTnrU72x8vlSw8gzQMOecJk
         7UGwrjkXvdr/jaRWJ0etUMcJBhWHDmfM4TbR135AWm2xAwp16r6vMCAKwHLyZXZTP7Yi
         IBNuQJBoKtmZuWjRVTDWQ8LQ/AXJlqbhbNYupbi0hpL33cAEpJASqCuwTWZUgdLddUXT
         NMd15NsLqxpnbtsX13mVru6S0L8auTMX1sMwMkGiMrufz9PXyGwSDgp/YrSZwqj78pm/
         fKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hJ1Rm2XXKJAPsVlE7zKM8ChfzT1hjLMkCfLQQ1dIU5c=;
        b=lyu1NhipWw84aOKLWoDHhCpKXFPQeFIcaZcwd4I8e0Qzt2upPxdHHP+vGuXsXFvc4S
         3nQ4Ie+eZnS6AR6i6XzzCnrnAknWiX1JIMv6Mtrsa79+1j0egVa4fg+jK27LPfgbSgkR
         ytoxjCQCHcXKg6rYInp7XUgJd/RLurX2+qeq4FjXrLQ+xCZ0Zu4dzzu/0Usl5y/7GVz9
         5e71r02im6GOUZdBhJrfvbu1x/LAFgmsSanyRDWVqGnY42vNJSqnFdAAhCQJXFM06s32
         0h7Tnx1WRP3GdwXXK5md/bzHrBBgQ9LxcmALE4mF5RpJtqzVPVZn+xp4iDChst1Ift+y
         uSkA==
X-Gm-Message-State: APjAAAWxggo0uay5Zgexa17Or3QWYnopZsiYcgC/nLUgyAiGCtLz4QvN
        BnacMWshaxQtutJprhaC6JTJXw==
X-Google-Smtp-Source: APXvYqyZEfgAfRBIpmLB987J7kQy0tf9sFkvkNfIZLg/XI2UCOunAYR2zZw+PkK3/bBmqYCw1tObKw==
X-Received: by 2002:a81:5584:: with SMTP id j126mr21570624ywb.420.1575907630194;
        Mon, 09 Dec 2019 08:07:10 -0800 (PST)
Received: from ziepe.ca ([199.167.24.131])
        by smtp.gmail.com with ESMTPSA id 189sm100522ywx.45.2019.12.09.08.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 08:07:09 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ieLYr-0001DK-6h; Mon, 09 Dec 2019 12:07:01 -0400
Date:   Mon, 9 Dec 2019 12:07:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
Subject: Re: [PATCH for-next] RDMA/siw: Simplify QP representation.
Message-ID: <20191209160701.GD3790@ziepe.ca>
References: <20191129162509.26576-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129162509.26576-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 29, 2019 at 05:25:09PM +0100, Bernard Metzler wrote:
> Change siw_qp to contain ib_qp. Use ib_qp's uobject pointer
> to distinguish kernel level and user level applications.
> Apply same mechanism for kerne/user level application
> detection to shared receive queues and completion queues.

Drivers should not touch the uobject. If I recall you can use restrack
to tell if it is kernel or user created

Jason
