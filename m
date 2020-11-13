Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E645E2B1366
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKMAmY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMAmY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 19:42:24 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C4C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:42:24 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so5637280qtj.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LFBr5bRhMYEEtwJMcdar1j30ihSHzzGASTWO2ocXRlY=;
        b=lA7P5Ij5QfK4LTiI9OvCALsrz9XW4HvEmgqrPJ0M5Bk66iYxlvTlk7tYyCnpbO7Jd+
         JCjlzmFpdziTtGpdVC4JidB+yG7iKlnoNch5HoaaDWViSXNgyaAnI/CLuH7tTqoxGWSJ
         3n/s5DyJ7gMBT3f8mTQw24M7VAO1qpJK0aH6sAjC8j5w7hMAnfl/ldaJpN0dlJIMh0VY
         MxhkeZnrJJPl/B3UYtctHRauWX5O4EFvtn1pUy1xZR2WqrmdIqOwJOAfTQ+LKYZ0kO6f
         Z6E/UBnwHyPLIE+hdRB2uBWJmv4z2g2i6cWvdU4a+sdtq6Zrrbjjcf+Ky40GTUAMGVX+
         lQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LFBr5bRhMYEEtwJMcdar1j30ihSHzzGASTWO2ocXRlY=;
        b=KwpjKZXKNc/c4fpj6nSqbZTLNfpfZx8im5RaRr4S5AhodeD/pYvgtEsSa+te69Temc
         cPZb/bNAFSyO9Se7Dn4apgtgZeTdNrE1lN6NB6Qw+CMjf9Rjj2nINRiMM/TXsu7ag1rr
         DJRffz59E/MkK2vopXxtb3maz570Ggm9K7KsdoCoqDHYT23C74Y8Hj8swrmAlxzINNf2
         k7hn+4V//12ZyAl1440k1fPP/zGF3CvQq5gwCGxt1nTwAaq+1sELBlwsDK1esa9dmsh/
         3PMYuJwMfjbZtJb18oy5bpn+RsEfLgJiVpYgn8i81gCar35IQc6TZSIpnAiQ0uHkj/Ou
         gZbw==
X-Gm-Message-State: AOAM530mE6LjWNKb2T6msdbvg/MjI4ClXEC5NcDOAZg/VEZYSQMa0g7b
        hzCsRshlXxeJfd5QN613o4N8rZE3zp6r2oep
X-Google-Smtp-Source: ABdhPJxg/ZtGpQNwWQTpd2nA5rfINiBe8BS/AHpPwnOe/vDl68OSm1f3CCo1gVhK5ykEOcTt5JkSMw==
X-Received: by 2002:ac8:4e24:: with SMTP id d4mr1908658qtw.271.1605228143332;
        Thu, 12 Nov 2020 16:42:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f202sm5257512qke.112.2020.11.12.16.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:42:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdNAU-004Cdr-0S; Thu, 12 Nov 2020 20:42:22 -0400
Date:   Thu, 12 Nov 2020 20:42:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v10 0/6] RDMA: Add dma-buf support
Message-ID: <20201113004222.GB244516@ziepe.ca>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 01:41:11PM -0800, Jianxin Xiong wrote:
> This is the tenth version of the patch set. Changelog:

So, really everything looks basically fine, other than some small
details.

The next step for this is to post the matching rdma-core changes and
the man page for how this new libibverbs API works. Like DRM we don't
merge kernel code without the userspace part as a matter of policy.

You have to address the "how to test" question in that submission.

This series should be posted to the linux-rdma mailing list and the
github:

https://github.com/linux-rdma/rdma-core

Jason
