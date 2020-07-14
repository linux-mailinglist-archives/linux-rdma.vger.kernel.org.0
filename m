Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C521EB1A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGNIOi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIOh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:14:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56011C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:14:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so1200417wme.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eEDxR1KcK0gtx81r/VDHcPfsw1SaTdQb3yyB3j2nTDU=;
        b=SnoefJUIqVnyBDP1AmqHl/jl4WttuLT2JEEd3PJELjuWSU1q5q3CWBcZZEGXnmD5G6
         LaYwmehzrJn5Ty4MxvbF+JNnx/uHtPg2kGhTUA2To4bJjWeKkrm1zqnwFiJZw4VRHbaX
         q2AqFkkyE495A/DkqgvNvDGu4VjmDicd1fPz89Eu7tBpwshFWCqk8awAuucZWB77EAeq
         W9kbUSvJGNFztL5e3QwcErViooFkeP0c7LxNSqnwhEYGyFMvnLQbpGP+4C29hsYO09kO
         jCKoxoKLgkMGxoh3XxDkoB2I85v2uY+zbreFIGyCniEIzmimXu5CrL37wrcMkf9mj4fT
         dnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eEDxR1KcK0gtx81r/VDHcPfsw1SaTdQb3yyB3j2nTDU=;
        b=dux7QzWZ+c16MsQ6NlwUf6HSN0i7G+VfLoWwrcwuannx7gNQteQ1Ja24efrbz7PMxu
         6PNoC1eBmxGRezoX3sfzHBWcpNH9p6wR5qiIdbrdYzFwiwrGSRbKQxY24ubrFJpbukfj
         Fgnd4ItfR3p1yk5ak5IsW1Sm1jmsBJC3ypq+sYEjSZPz7QZ8RFOyRs6Fd6v/wVBrqJpE
         oSLG5VijVSs+/NZudJ33Me/Ous72cxLQCmdZv5QzucX3hVfl8iRX7c9Qq5IEE4f24Hml
         P1MLMal2AQJzZd3iGtM+8gijkDwpxlXS1lJy0vIpdDp0pKI3+cMA23rMa/tVYsoAj+5s
         /u2A==
X-Gm-Message-State: AOAM533TXv3JdKITZjepTzdYMPE55h6fkQzobGdCrbJhT5hS5fGQCReu
        auK4ffEyn0/FbLyXZ6e4aYC8CIiCcfk=
X-Google-Smtp-Source: ABdhPJxsdkOzfqiytro537GPj2T934fOrpiBVAfR/8fzWDlxBsaMt8KwPmqVROj8qAiNjdGLpW4XoQ==
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr3036285wmm.168.1594714475782;
        Tue, 14 Jul 2020 01:14:35 -0700 (PDT)
Received: from kheib-workstation (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id e23sm3126145wme.35.2020.07.14.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:14:35 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:14:33 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next v1 0/4] RDMA/rxe: Cleanups and improvements
Message-ID: <20200714081433.GA13271@kheib-workstation>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705104313.283034-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 01:43:09PM +0300, Kamal Heib wrote:
> These series include few cleanup patches to the rxe driver.
> 
> V1:
> - patch #4: Fix commit message.
> 
> Kamal Heib (4):
>   RDMA/rxe: Drop pointless checks in rxe_init_ports
>   RDMA/rxe: Return void from rxe_init_port_param()
>   RDMA/rxe: Return void from rxe_mem_init_dma()
>   RDMA/rxe: Remove rxe_link_layer()
> 
>  drivers/infiniband/sw/rxe/rxe.c       |  7 +------
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  5 ++---
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
>  drivers/infiniband/sw/rxe/rxe_net.c   |  5 -----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 24 ++++--------------------
>  5 files changed, 9 insertions(+), 38 deletions(-)
> 
> -- 
> 2.25.4
>

Hi Jason,

Could you please tell me if there is something blocking this patch set from
getting merged?

Thanks,
Kamal
