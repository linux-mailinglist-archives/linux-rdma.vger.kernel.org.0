Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E5542F73
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiFHLvO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiFHLvO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 07:51:14 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2708336170
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 04:51:12 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf10so14672790qtb.7
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jun 2022 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X4i2wcMbj/iWDHa3EccSTYi9vrb0LsIcyhzTI3HD25Q=;
        b=gsR4szaWJqjvWE20hC5hdfEdaxUcjxcYJWQqrstzu4xxiTmXOv1uhEqH0Okl+ii3Ck
         Lxef7EMPhgXETK+39Oomq7CiHlc9QXAZ9Q3min+qE8uvoxeAHzNxYWnvSZ6d5dGx9QUa
         sA3NRfIvZxYWbZI9xNZMXnviqL0VAlBULrWwqYf8avL3S7es7vDW2mzqTTlwvH8ibOe4
         +HkvVFr/RHlpoe+jaKSCsAmNTp8XoLAfDusH+jQPmjWGF6HGX3NFx4xovfK/EEHQ2/x+
         JVqwFibZxcwmbq2gu2XmaZ48HbBclMXCQEEIsE8/FrM401B3QryTk3eoboK04USp54o0
         IFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4i2wcMbj/iWDHa3EccSTYi9vrb0LsIcyhzTI3HD25Q=;
        b=XIjch5VzvgGwAbAcJLJlcH8abbLcvnAETTDGGSwWCxSFsd1qe1/buFcYC1G1Mhqlmh
         +NhxmTx1BrwKz0Nk6d22GF6sDmo81zHQZZ7lisrPL63tq5EAcrcajjlK+G1S9NmEymQv
         V9r2Ydu1B6z0IhfV3tR8TUefoZEpb6m/arNv/r/bFO5NfYBAzxi9B4xjWxjO0o3J7TKc
         jMNQFMvZnYob8xHS4HLOeK5Z4bxi8WvdF6+hiGEMB2msFQSCfEwaJFOyxbwp8NViFDps
         mBM8fu7GWa+dWsDsmq60+CyvK141ROPY3FCQWbY4VbatddZYI5bBDEJEV56DbO57wmCu
         sEXQ==
X-Gm-Message-State: AOAM531fGYxiHgsuxhSeE6KQxJNZvaYP8Mzno2Li6K5UKR0dN+X6nVOW
        B7mmqI7wRQInPgzx+5m2MBq+BA==
X-Google-Smtp-Source: ABdhPJyZ2SrePTFTfrAgIOolAeN1EAiF69BUfge2N/rLjt5z3WvnFKKO59sV3Ew1Izh2kefnWEK40A==
X-Received: by 2002:a05:622a:11c5:b0:304:d8cd:2058 with SMTP id n5-20020a05622a11c500b00304d8cd2058mr24463295qtk.324.1654689071139;
        Wed, 08 Jun 2022 04:51:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r14-20020ac87eee000000b00304ee3372dfsm5188546qtc.45.2022.06.08.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 04:51:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyuDN-003ehg-Dq; Wed, 08 Jun 2022 08:51:09 -0300
Date:   Wed, 8 Jun 2022 08:51:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>, kaishen@linux.alibaba.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/erdma: remove unneeded semicolon
Message-ID: <20220608115109.GJ3932382@ziepe.ca>
References: <20220608005534.76789-1-yang.lee@linux.alibaba.com>
 <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 08, 2022 at 11:36:07AM +0800, Cheng Xu wrote:
> 
> 
> On 6/8/22 8:55 AM, Yang Li wrote:
> > Eliminate the following coccicheck warning:
> > ./drivers/infiniband/hw/erdma/erdma_qp.c:254:3-4: Unneeded semicolon
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> 
> Thanks.
> 
> 
> Jason,
> 
> BTW, are this and other two patches for erdma posted today parts of
> the static checker reports which you mentioned in [1] ? If so, I think I
> should re-post the v10 patches including the fixes ?

Yes, and I would wait for a week or so because this is just the first
day.

Jason
