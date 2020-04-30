Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415B71C0AE4
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2020 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgD3XNP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 19:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgD3XNP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 19:13:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F8C035494
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 16:13:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m67so7666896qke.12
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 16:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydWMx7y7PGO+n7ekQ6dHaLd4bComoQSbKez50fuN6Xs=;
        b=A/grnYCDXSiT03s/9v3h3VFcdtEMt2IZmWkDzRJFbcAZp9F8EJaO7FviZ6oeLSexGK
         W+ZFRYJba+IsFK8WZbWbczRZvPcxa723QF6iICmCEBlDD2f3mXRUqOhr9KLUqaUjTQCL
         0KxRs0fb645IVo2GrR6VivfTXBvLa9MCUsZf1Xb9HyxG7PV5rnfIUDxj2qGO2VEqPzv5
         2kuyljULPiD88Xkk1o3/6SJYQEQwE50V5hqhUQoLJronp/erCZoFyWcRNnZmhmkQFxy3
         yfbeU6hwYNG4tAw+2B19oyd/nX6EPTJoQaknHELUAavLS988YdBTjfkzNhV88GHZcNDC
         MwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydWMx7y7PGO+n7ekQ6dHaLd4bComoQSbKez50fuN6Xs=;
        b=ZUYCOPzEfXtAE/znUgGZo1X5PF1DwGvJ/QmP0uIkVLyM+bi0gWVr2K+y5zsQ2cmSLW
         pbY9pHyT0PwhD0AQMx2+w/tgWAE7zRZXmkNoSkKtHH9E94NIXr/hXkLnKEFihvugb7v0
         5ieI7lH7lvFhs9JvVN5msHbYam6ISqjURsUXtpy4Nv3o97A2en1HYWAz/DU95xaTCjZ4
         APT3hXSbTllTl03cv5IBp7I9T/K5XGDIX2J8PAPyXJprIywlNcUutA0moxEE7tXPuel3
         mPhPdFGZwTWiuckX0NDqo8icIq2j/IasGlBniXx5UQx7vm+UIfgusEFsLMkhnlUvnchO
         SH+w==
X-Gm-Message-State: AGi0PuZWAmR0WYNBMtWIJqjQy+5XffwYRLAxelI91JwXSAol3wAExV5w
        wN+cqj6UR6wnx3GlFoLDkZlt1A==
X-Google-Smtp-Source: APiQypJonSeaFgCFBM0Yuqj7upL8LGHePRRuUO6Qk4KOKEYXWm3rktywZ71r/4pHy2WE5v7a+XOVyg==
X-Received: by 2002:a05:620a:814:: with SMTP id s20mr894938qks.417.1588288392719;
        Thu, 30 Apr 2020 16:13:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m7sm1364051qke.124.2020.04.30.16.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 16:13:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUIMh-00056R-8O; Thu, 30 Apr 2020 20:13:11 -0300
Date:   Thu, 30 Apr 2020 20:13:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/36] Refactor mlx5_ib_create_qp
Message-ID: <20200430231311.GA19436@ziepe.ca>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 06:46:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog
> v1: * Combined both series to easy apply
>     * Rebsed on top of rdma-next + mlx5-next
>     * Fixed create_qp flags check
> v0: https://lore.kernel.org/lkml/20200420151105.282848-1-leon@kernel.org
>     https://lore.kernel.org/lkml/20200423190303.12856-1-leon@kernel.org
> 
> 
> Hi,
> 
> This is first part of series which tries to return some sanity
> to mlx5_ib_create_qp() function. Such refactoring is required
> to make extension of that function with less worries of breaking
> driver.
> 
> Extra goal of such refactoring is to ensure that QP is allocated
> at the beginning of function and released at the end. It will allow
> us to move QP allocation to be under IB/core responsibility.
> 
> It is based on previously sent [1] "[PATCH mlx5-next 00/24] Mass
> conversion to light mlx5 command interface"
> 
> Thanks
> 
> [1]
> https://lore.kernel.org/linux-rdma/20200420114136.264924-1-leon@kernel.org
> 
> Aharon Landau (1):
>   RDMA/mlx5: Verify that QP is created with RQ or SQ
> 
> Leon Romanovsky (35):
>   RDMA/mlx5: Organize QP types checks in one place
>   RDMA/mlx5: Delete impossible GSI port check
>   RDMA/mlx5: Perform check if QP creation flow is valid
>   RDMA/mlx5: Prepare QP allocation for future removal
>   RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
>   RDMA/mlx5: Set QP subtype immediately when it is known
>   RDMA/mlx5: Separate create QP flows to be based on type
>   RDMA/mlx5: Split scatter CQE configuration for DCT QP
>   RDMA/mlx5: Update all DRIVER QP places to use QP subtype
>   RDMA/mlx5: Move DRIVER QP flags check into separate function
>   RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
>   RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
>   RDMA/mlx5: Delete create QP flags obfuscation
>   RDMA/mlx5: Process create QP flags in one place
>   RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE
>     signature
>   RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
>   RDMA/mlx5: Return all configured create flags through query QP
>   RDMA/mlx5: Process all vendor flags in one place
>   RDMA/mlx5: Delete unsupported QP types
>   RDMA/mlx5: Store QP type in the vendor QP structure
>   RDMA/mlx5: Promote RSS RAW QP attribute check in higher level
>   RDMA/mlx5: Combine copy of create QP command in RSS RAW QP
>   RDMA/mlx5: Remove second user copy in create_user_qp
>   RDMA/mlx5: Rely on existence of udata to separate kernel/user flows
>   RDMA/mlx5: Delete impossible inlen check
>   RDMA/mlx5: Globally parse DEVX UID
>   RDMA/mlx5: Separate XRC_TGT QP creation from common flow
>   RDMA/mlx5: Separate to user/kernel create QP flows
>   RDMA/mlx5: Reduce amount of duplication in QP destroy
>   RDMA/mlx5: Group all create QP parameters to simplify in-kernel
>     interfaces
>   RDMA/mlx5: Promote RSS RAW QP flags check to higher level
>   RDMA/mlx5: Handle udate outlen checks in one place
>   RDMA/mlx5: Copy response to the user in one place
>   RDMA/mlx5: Remove redundant destroy QP call
>   RDMA/mlx5: Consolidate into special function all create QP calls

Part II applies too thanks

Jason
