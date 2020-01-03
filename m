Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8B12FF3D
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 00:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgACXpS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 18:45:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38475 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgACXpS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 18:45:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id n15so38054936qtp.5
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNxSTncNVVfZnZZpfF7wT6SBviKRXb0ZBmM3HUe7KmM=;
        b=fDoFfyghoXPZaMsdlU8Ec2KXYWWj40ug9IiXlTLFEyxtHa+p8hTXhvCELIf1ruovEa
         v2J7NPDugD9NDUVW7LTndHddn8hDhrMLpu+6hsKUN0mZSWZGzAxZ+r6ron73nEw39Dr3
         lEEk8fniq+hSpU7eLzv7jfKdzUwc5de1L0no7S1lyCYIXCiJlgl0ZAhM1++trfOfHDr4
         5YKBYjL+CtalVyCXIobv5nkHxOrdo/ada+Mi9XFMRqq0N8GJQb5STSkVoKTRbS0AGvhp
         hxv3W5EqoMvSW4+0jNugf95RwsU5nOW5c1BD3lI2RQLHo3jACNzV09EWrfiTRVJrM9Xp
         a0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNxSTncNVVfZnZZpfF7wT6SBviKRXb0ZBmM3HUe7KmM=;
        b=UAoFuA5EbaJJS8MZ7I8OB7y54sb1dmMTrs2JViJxC5Yj7df9Zc4LpFrp9FoCAWC/1T
         SmghbdAZmXkVymc0Sf6dvBR3W6zJyo8xCkKev2IFvNABVj58XiEhuxg/AQVnkLKKEuXl
         1mafvHzzVabWo8+gEK/4P9cpahv/mrKHpa64STQ6waMwCOtpjjtY8D4c3t0Cf1FibfXd
         hzDY92t8gkVw2NwUPnP9neIIu/4ayTss7Vube5Y035vIEUP48ps+TsOLiwm2IywVHsBE
         syZINUqVOGJoX18JAhtPPZ37pMVGcy85M2+Cn/vt6xCZgsCRz+4TBLJMypo3fr3GKYeB
         etNg==
X-Gm-Message-State: APjAAAWgsD1dZPM96vpQeGKOZnRowXWw+BsVTkkf+xkSoEHb/52Hby6E
        TyEC0YC62lnPyBPRp94kjG44nw==
X-Google-Smtp-Source: APXvYqzGzQftM6nV/mlqt1VQrAxOIDXp2IjTtnuwx/4YYoTdsnAWvDwfdPPTCyGUg+I2K+DcRmKilQ==
X-Received: by 2002:ac8:7103:: with SMTP id z3mr66966871qto.172.1578095117348;
        Fri, 03 Jan 2020 15:45:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 200sm17218170qkn.79.2020.01.03.15.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 15:45:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inWd2-0004zj-HH; Fri, 03 Jan 2020 19:45:16 -0400
Date:   Fri, 3 Jan 2020 19:45:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jiewei Ke <kejiewei.cn@gmail.com>
Cc:     linux-rdma@vger.kernel.org, monis@mellanox.com, dledford@redhat.com
Subject: Re: [PATCH] RDMA/rxe: Fix error type of mmap_offset
Message-ID: <20200103234516.GA19157@ziepe.ca>
References: <20191227113613.5020-1-kejiewei.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227113613.5020-1-kejiewei.cn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 27, 2019 at 07:36:13PM +0800, Jiewei Ke wrote:
> The type of mmap_offset should be u64 instead of int to match the
> type of mminfo.offset. If otherwise, after we create several thousands
> of CQs, it will run into overflow issue.
> 
> Signed-off-by: Jiewei Ke <kejiewei.cn@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
