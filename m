Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC56B4A467
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfFROsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 10:48:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37384 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFROsv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 10:48:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so15667018qtk.4
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6T3J8UAsfgYxml5+e020vrBPWHoKuu/6+zJloOmPsA=;
        b=fnScPaGZsMTFv7GFF8yQQmLRZV+rr/anaWI2IT/mNcTOAx5iqSf4gy/vpN+BPlclmL
         tMq0ln9JCyTzaF7k7fiqixCtCNHb4Pe7Gzcwzv3iW+IcYGbu0rL8kl5toIcGg+dEkPn7
         HL0uf5B+uNvpXlcoD2/ZeOJyji52c+aenjJ8R2E4YQTz6G18g+H9EpBw3Hw5nW+TmhRP
         AUmDEgm+ipP42XNhgOnM5cBOH2a1z9kVLJDd0+Uc8y2Prx0VXjlGMzCyB32AZ88WRngw
         7ca0qNMyeZf1CLDbCgvXaPD10fkJs3FdGrzzQ0mimUbROKT3Y1/ArN/eU11Jj5U7IpXJ
         n13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6T3J8UAsfgYxml5+e020vrBPWHoKuu/6+zJloOmPsA=;
        b=S+ljYtO8Fw/7kzkpCL4yLLAm2a0QPg642ZqWGmxMNdVW195TgUZF/GJGhJPN5LM4Ur
         JLMEoxDrmld2y2U9xJt73D9vCs226WFAMlpjxeSRdEl4XWZPM9/vRyRxUyt5Q3n0tr/w
         z5IzSGzHFfA7LguhoAnobb1yc4Who4dzv+eZZ60WTeOxV209LuOxPPWrvJ8b+tOUEJ2p
         Q4wxz2Q3pizL7+c4Gl9eLSBapCGNzAzCluH4plUse39o1+7Fh4caxzexWGgDZTas/UvJ
         KGjle1botA/tt/PwxMLfNniRC3WcU2LPDwwcO+CD0j9ggz4yD3jtuyZ/Ru80/lBi7Zq9
         5aeg==
X-Gm-Message-State: APjAAAUSSliE7s3CWw5Scej5IftTYhaOdq2ONAVMxibiltCU9Jm5hoor
        bJqFF5UKqBHpbbR4DWoRINbVHA==
X-Google-Smtp-Source: APXvYqyOfDJxFRNZ/f9scrToVc8/vMTYaPRTcACZHsYWjWUmJ09br/AaR8I+nEyKOEwzO7e1rDrRpw==
X-Received: by 2002:ac8:2ac5:: with SMTP id c5mr93774959qta.332.1560869330932;
        Tue, 18 Jun 2019 07:48:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e133sm6138227qkb.76.2019.06.18.07.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 07:48:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdFPl-0006Lp-Up; Tue, 18 Jun 2019 11:48:49 -0300
Date:   Tue, 18 Jun 2019 11:48:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] ibdiags: Fix linkage error on PPC platform due
 to typo
Message-ID: <20190618144849.GH6961@ziepe.ca>
References: <20190618134717.8529-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618134717.8529-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 04:47:17PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Incorrect linkage type causes to linkage errors on PPC platform.
> 
> [267/395] Linking C executable bin/mcm_rereg_test
> FAILED: bin/mcm_rereg_test
> : && /usr/bin/cc  -std=gnu11 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wmissing-prototypes -Wmissing-declarations
> -Wwrite-strings -Wformat=2 -Wformat-nonliteral -Wredundant-decls -Wnested-externs -Wshadow -Wno-missing-field-i
> nitializers -Wstrict-prototypes -Wold-style-definition -Wredundant-decls -O2 -g  -Wl,--as-needed -Wl,--no-undefined
> infiniband-diags/CMakeFiles/mcm_rereg_test.dir/mcm_rereg_test.c.o  -o bin/mcm_rereg_test  ccan/libccan.a util/librdma_util
> .a -lPRIVATE lib/libibumad.so.3.0.25.0 lib/libibmad.so.5.3.25.0 infiniband-diags/libibdiags_tools.a lib/libibumad.so.3.0.25.0
> -Wl,-rpath,/tmp/rdma-core/build/lib &&
> : /usr/bin/ld: cannot find -lPRIVATE
> collect2: error: ld returned 1 exit status

Weird that only happens on PPC, IIRC'PRIVATE' is a valid cmake keyword but
it is archaic.
 
> Fixes: 58670e0a17ba ("ibdiags: Add cmake files for ibdiags components")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  infiniband-diags/CMakeLists.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
