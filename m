Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7318D485
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCTQeP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 12:34:15 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45811 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCTQeP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 12:34:15 -0400
Received: by mail-qt1-f172.google.com with SMTP id z8so5387647qto.12
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnpttEQdCjtFdlwNsnYig4qiNVN41QH/TS+PRlrzYUQ=;
        b=oQ516cJ+DP+bR3YjeKxzptwPDgWyWbaoFmCmBBdt+9qJrcamjAHYQguo00Dwrup1mZ
         /+BvpvstFXCS7oJ7nPdsL2ibWhhBIcxQCG/ZdES4Zm3IqTSpcbYGZGgrFXjMiiMc1iEv
         e86tO2S4AR3iZyITSKgSkhuCJEpaIs/Gq3xBUPXrRGWisAbzCijPBxVRCgHQxzPVRkm7
         7bnVOjDQYOdB0rC/mu736tKCzYTwTRkH3URbxMaw3tLm4LkTMAUCTwJryEWsu5Mnniyl
         FZiEPuar5Xovl9eEeA+3IT7QDrhLiIUUN2MhJEM0DK22DK1fqbaHdY/4VjtO2qH5q5Xx
         0MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnpttEQdCjtFdlwNsnYig4qiNVN41QH/TS+PRlrzYUQ=;
        b=nyWcIxhBmmSDWrRmIZ7JKlZV/RXBBrBJajZw3JG8KNOhOnJ2Ffwh71wcSTZZbxBWrI
         LB7GBbWXX+sUbdSF1Cy4PfToVdI/tanhjQIbVf1lntJ2AQAQx5LGheVIA6PbklAmQG2I
         ikzmTEXvEjDAgzKGfJEqMPvX5Kwt2RgsAZeLZfb6ky4eh58kPw/Sf+T2zN0xcs2Cingm
         m6bv594Gj532rQ5D4ttvzJK8k5Fb78zqdt8MwnOSstTV6nHwvJT312BavIRbcyKlCM3z
         PJv+mj28kQJXoWthxi+fQ+kuXPbBihtb1tZFUkAOxNkfZbtlX/xquwoFqwLUuIODpQ33
         jr+Q==
X-Gm-Message-State: ANhLgQ2QJrQAGtxrE93uf/B2/chFchdNxE2iELB71ehl56rWuXm12vfE
        HYFnqOWtl2yWyeMsr4Ak9DGu0A==
X-Google-Smtp-Source: ADFU+vuCFUPPorrwjBUafRrBWCuBTmAIUC2+CHGNTyq9mbpE61OPevKyw81uHj7yzNW5WpvIjVETNw==
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr9093441qtd.86.1584722052270;
        Fri, 20 Mar 2020 09:34:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x37sm5130083qtc.90.2020.03.20.09.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Mar 2020 09:34:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jFKb5-0002DU-7C; Fri, 20 Mar 2020 13:34:11 -0300
Date:   Fri, 20 Mar 2020 13:34:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Cc:     Mark Bloch <markb@mellanox.com>,
        Terry Toole <toole@photodiagnostic.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET
 and steering rule?
Message-ID: <20200320163411.GT20941@ziepe.ca>
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
 <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
 <CAOc41xGkcgDZoqPHX8uH4uG6E+FSUHMoZdB1H2cQ1X5LYkuM8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc41xGkcgDZoqPHX8uH4uG6E+FSUHMoZdB1H2cQ1X5LYkuM8g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 09:04:34AM -0700, Dimitris Dimitropoulos wrote:
> I should make the question more precise: in a peer to peer setup where
> RDMA UC can achieve line rate with no packet drops, can we expect the
> same result with UDP with IB verbs ?

I would expect UDP and UD to be similar

But verbs will be slower than dpdk.

Jason
