Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6953C61C6E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfGHJby (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 05:31:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37487 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfGHJby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 05:31:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so4636451plr.4
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 02:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rh9tee5dcfX7miaSFIwWxIqCiQfi03IYzmMx/MjkzQU=;
        b=R6tuCznTYLJoXGthgK1ZzDFeHRwmuBIVV/EOnCYyUKx63Fp9xOTL/pBFBcbOAz1oIw
         y59hiY+y6NX+c4M5Dgtryd1IuYtPym9wlwEzoCTFI4fhnbdTElygP4qoG/znscxmkzAy
         hs/ygsfmIUM1vYz77/PMDWDLZ3DWC6Tf9SJfeMwDadmbZuRIY3QmzeXBI2i/0KB2vxuT
         /DZnEHYh2Y4EwbIx9gdkDlzCDqM4rfCYt67AXdV8IUjj41twrECfuKBXVCxZ2nKGldau
         Lbq09FKsbaBER0CPkIskMEDJW9M2ucZJXTGF4mRLoFKDTqEkPt2e4aiqNTCNNzX++t+W
         hvPw==
X-Gm-Message-State: APjAAAVw5l8CnBw1OiQkNEC9UD0PkmvI4oYHkFl528KgnWW479QSU4hj
        kBCY16d8o/c9E1SlXaYoQxM=
X-Google-Smtp-Source: APXvYqwHUfldBmp2p9xydovl4PrTDB+/u8VUy0KFPrlCxuod798A4Qc52T5t60DBYxztLeTj7Oz30g==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr24173309plp.194.1562578313839;
        Mon, 08 Jul 2019 02:31:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:7538:126a:4b71:8c7c? ([2601:647:4800:973f:7538:126a:4b71:8c7c])
        by smtp.gmail.com with ESMTPSA id i123sm22938769pfe.147.2019.07.08.02.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 02:31:53 -0700 (PDT)
Subject: Re: [PATCH rdma-next v4 2/3] RDMA/core: Provide RDMA DIM support for
 ULPs
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>
References: <20190704125743.7814-1-leon@kernel.org>
 <20190704125743.7814-3-leon@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <efdb7d5f-1cd7-fd34-0245-b494000a0954@grimberg.me>
Date:   Mon, 8 Jul 2019 02:31:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704125743.7814-3-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>   drivers/infiniband/core/cq.c      | 45 +++++++++++++++++++++++++++++++
>   drivers/infiniband/hw/mlx5/main.c |  2 ++

Can you please separate the mlx5 patch from the core?
