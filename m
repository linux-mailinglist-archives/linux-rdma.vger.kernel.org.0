Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C92133083
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAGUXy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 15:23:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35268 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUXy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 15:23:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so642834qka.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 12:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xIjbjwGa0UziofRw9YF/QtTcvxpNHpN43AfHat1IW8o=;
        b=Doz4MA8fXlcX7J35klGxIMxaIn8niIK+CgeY5BQl1nRtLJ1A+x/bk39CqG/LKq9JKn
         3ek/zoIP2sHAnAKGR8xWmTRCSkzQ8TT24UE6y4lFR89fKwRI96yERd+NnHYlxNvKjmAv
         BEbPQ+SKSKdyREDMVFinmt5AwQWrE0qd8oyFCzgqN7FBpzffQQl9cNIoHKttgVMT6Owq
         qeOdBR32+nx/Pp3SMIYw1w4+PqzAK5E74nWm/6rqcrLCoVMjxQ/fn1Xt5ROZh1xJvtHi
         nR11G7HXfhFWbLGJosuAH1RTv6leWHm8sFrr1tpweNxMlOvpTDjG1e/D3y2kaIX1qWXb
         AADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xIjbjwGa0UziofRw9YF/QtTcvxpNHpN43AfHat1IW8o=;
        b=XktxsI618gc3b3ZDD5MuAxrkuuk8P4fmQxBdMYKHypt9z0D62wBzemS9xbMuzQUxAa
         su5CWfhnVfo5CpOyrqm6xlLG0q0ogPfxgxnR6SsAWbzl3YCfeXDNrRHu1+nNZcejhUVt
         yHRb3Sn4mFCLYyz0uzZS03lKkl0fKf+Mx6c6FCM0ToeS3TKP6hMsdgNvhplPuP7shz8R
         clrXOdn+tT3HGTQ/Z3egjTgiFfm1gbmUb1XvQYBIHrJC7Xnc3JiNEh/9jlaKPyprem6g
         OSr0pmrT7VhphHfUywB/7agrOGvMtD/T3OkwH2+Svp25egx//rXX9fIsUQWSjZemvaXX
         qaVA==
X-Gm-Message-State: APjAAAV/QWsYjuJjDZ5Aw45LkaFwAgomG5JUrbUz017xNtsIdlm+Sv41
        OX6VLAAV+wZnoEpY5Qds9P309/KnO7k=
X-Google-Smtp-Source: APXvYqzAzjHs2WDUjv9YqwoHmrkGxRNJx5jC8xbokldD8K2AUuKqzeYafxyTyxiASQE4O87KHvopFw==
X-Received: by 2002:a05:620a:1249:: with SMTP id a9mr1130344qkl.147.1578428632978;
        Tue, 07 Jan 2020 12:23:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f23sm324121qke.104.2020.01.07.12.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:23:52 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iovOJ-0001Cx-V7; Tue, 07 Jan 2020 16:23:51 -0400
Date:   Tue, 7 Jan 2020 16:23:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v10 0/3] Proposed trace points for RDMA/core
Message-ID: <20200107202351.GA4573@ziepe.ca>
References: <20191218201631.30584.53987.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218201631.30584.53987.stgit@manet.1015granger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 18, 2019 at 03:18:04PM -0500, Chuck Lever wrote:

> Chuck Lever (3):
>       RDMA/cma: Add trace points in RDMA Connection Manager
>       RDMA/core: Trace points for diagnosing completion queue issues
>       RDMA/core: Add trace points to follow MR allocation

Well, it looks reasonable, lets try it. Applied to for-next

The usual warning applies, we don't consider trace points ABI in rdma
so please don't build tools on top of these.

Thanks,
Jason
