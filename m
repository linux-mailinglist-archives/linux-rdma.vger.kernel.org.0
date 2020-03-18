Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB8189CF0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCRN1Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:27:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43855 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCRN1Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 09:27:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so18443706qki.10
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W0V0uJQcliqEAmbFzeuij976y7OZIvrkGSoGXjwSbl8=;
        b=IkhXjLpy5dLWAD/Fepk4Sa3sktlDQbT3lkJ2+frh8p/c/4N0IradrF4wI0QDZ1UUmq
         GeOOUZl0vmTIQkSgLcpvV1dkJ5xjjb03J6fuaJIBoqG4JpGPbi3m9knDeDeU/fA/Lhq/
         caLOYwJA43vRNK8TVgNfjhEte4k4unX/awoy6pxVOhiKRUs6nUQ35bqOylau97lFGGhG
         4itBKladUKqWRPMZ43L5m/E+yFSQykm/4ME7t+TFsR6fMdrUzl1XliRVp3sayjVYlR5G
         wahvmZzxg+dceNAn2IeaG1H/mB20TiMrHyoGhPJq8WxB1bTPtQPnlk6lPVKRSdl0FmFL
         4Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0V0uJQcliqEAmbFzeuij976y7OZIvrkGSoGXjwSbl8=;
        b=kC8eh8yimjT0xftcuipoAndWxexerlt2Jcrs4+aB5pZVrvr29OYCQ4EDyH78NypVz1
         xD0wLdViT1c8AvJLfXKf3reuWw1HhPhsHqwmS6AFiaBF2Yfbe3ORy8iXUCaSLCqt6uVQ
         NyFbzEflB0TmnvteGFBH26bMgOLtdM4Q+MFIrYqM1uPY72t8ajg/6X5pKXifaQf5fsuS
         1arYAMIlv08ToM7DeiC75Zii3/ZXDVkPmNIAVjA0Sd36tlNl5bUXFOoTFC5fejYlKV8w
         ZRqv9kBj41LyJgMczGrQ5cCTNtU7cMz1Kkw3Z16MTJabCGHolxOVnEzhHmrQXwAwZiLM
         k/AQ==
X-Gm-Message-State: ANhLgQ031ph4LquoH+pN4UWsOPCSBeDBoS62Bdip3FIzUhf1V+qB6u8C
        xU5SJ3IZ38tgGv6fuE5XZ+W0Fg==
X-Google-Smtp-Source: ADFU+vvZKPqpN2B2Z+XjejSqj4wJosZr5uasZj/Qb7W9Vby/wxH6hBSqBzuc1ERGa0W+fqBOai5CXw==
X-Received: by 2002:ae9:f007:: with SMTP id l7mr4138149qkg.11.1584538041745;
        Wed, 18 Mar 2020 06:27:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c18sm3730886qka.111.2020.03.18.06.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 06:27:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEYjA-0006bF-54; Wed, 18 Mar 2020 10:27:20 -0300
Date:   Wed, 18 Mar 2020 10:27:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 0/5] RDMA/hns: Refactor wqe related codes
Message-ID: <20200318132720.GA25343@ziepe.ca>
References: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 07:17:59PM +0800, Weihang Li wrote:
> Process of wqe is hard to understand and maintain in hns, this series
> refactor wqe related code, especially in hns_roce_v2_post_send().
> 
> Previous discussion could be found at:
> - v2: https://patchwork.kernel.org/cover/11422963/
> - v1: https://patchwork.kernel.org/cover/11415395/
> 
> Changes since v2:
> - Remove a redundant assignment of "NULL" in patch 4/5.
> 
> Changes since v1:
> - Fix comments from Leon about the inplementation of to_hr_opcode() in
>   patch 3/5.
> - Patch 4/5 couldn't be applied. Just do a rebase.
> 
> Xi Wang (5):
>   RDMA/hns: Rename wqe buffer related functions
>   RDMA/hns: Optimize wqe buffer filling process for post send
>   RDMA/hns: Optimize the wr opcode conversion from ib to hns
>   RDMA/hns: Optimize base address table config flow for qp buffer
>   RDMA/hns: Optimize wqe buffer set flow for post send

Applied to for-next, thanks

Jason
