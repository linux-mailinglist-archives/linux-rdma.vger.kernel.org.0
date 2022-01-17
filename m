Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395A2490A8E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 15:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiAQOfH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 09:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiAQOfH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jan 2022 09:35:07 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D39C061574
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 06:35:06 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u3so9674337qku.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKnEDfDOHP1Gip6gRtRx9OLQcL2NYzw8mzTYclLdF4s=;
        b=aC1EmsTewa52sMnAPMz6IQu008I9AIA+izvrBSne4wMNuUEfeyVQyEZoqhjSvFxt69
         zflOIjtNMu5Bx2dT4DYPPGjAvT4SoahXFZCL0UE4YMSnglPg3iRbiuzMIuW217NGK70g
         MufhzdXEGoR877oIRVlxS0CtcPvc2Cf4QTC9hkdAntNYSpzYblIJVftKJ2m4Fm+K0Rl6
         hmTomYyfM+TBTCs4Pd6xtw+XbsdbShU/YWqGWqybQBd6Z2SXJ4wHm4vT8y8Oown3D9Hc
         3eWJxH3N5Cjnh+wo/zhbQifR5rNWNqvroawQJfzXX0FRlDFDZ3FXjHSY+Od6FJAx/vw1
         M8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKnEDfDOHP1Gip6gRtRx9OLQcL2NYzw8mzTYclLdF4s=;
        b=GrvUvN7AAcWJIbmTUNo2Tc5+8+xOHppzKEI/TC6FtvKKUKVkEdmWJFeD/KDS1eotN0
         93SuSeJ6sCiDuuAGI77wadAyq/1vx6Ph2AoATwurAclMQ8ROiFcmX3bCzI6d4Rkh3dAu
         wxwH0tYGlgjfmMjVIXb8vuNou3TgltiGhjm5FtCrJVHTKGfI1Ix53G/UO4lxgSdsu/PI
         AnqkFk/2AhAEzOinwDkfY/KH4+hoiPnykZQTvQzB8LSjl+ojAzJxCQ8WRBTyiItD1zk6
         KTAlPPidIPs9CkCJGGygLbkCB2DlYTRuSFMe1SxgWjshhDse4LZtxErf3/oiIapaHzAl
         tawA==
X-Gm-Message-State: AOAM532hfJXLmGpEzFX1mYrPpRZXiBe+BaeG3TAFDfG2Wi2+2yX/3wUd
        HYMZyLLaQ/BiKjXNDZPmnEQ9Og==
X-Google-Smtp-Source: ABdhPJzriuj66plk0X5JWi15JmxxQS+GXJ2UdCpUt1IP9QUW1YzM4Otm0s55qIPg7xqowu6Zpf7P0w==
X-Received: by 2002:a37:9f53:: with SMTP id i80mr10948521qke.17.1642430105691;
        Mon, 17 Jan 2022 06:35:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i7sm9365037qkn.0.2022.01.17.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:35:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9T68-000JB4-7D; Mon, 17 Jan 2022 10:35:04 -0400
Date:   Mon, 17 Jan 2022 10:35:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Message-ID: <20220117143504.GA8034@ziepe.ca>
References: <20220111014145.2374669-1-yangx.jy@fujitsu.com>
 <61DCEA00.1030002@fujitsu.com>
 <326487d9-74cc-185e-1790-90730425057a@gmail.com>
 <5A111A92-427C-4FE1-BDA1-6E8877350D20@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A111A92-427C-4FE1-BDA1-6E8877350D20@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 11:12:12AM +0000, Haakon Bugge wrote:

> > The way these queues work they can only hold 2^n - 1 entries. The
> > reason for this is to distinguish empty and full.
> 
> You can simply mitigate that by having free-running counters, right?

That is generally the best design, with the cost of doing the & on
every use of queue data vs only on ++

Jason
