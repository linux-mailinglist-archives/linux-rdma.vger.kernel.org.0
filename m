Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDA22A26D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 00:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgGVWf4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVWfz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 18:35:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB7C0619E1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 15:35:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so1936844qkn.4
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhNGI/vefCUNAfGzfX3ewpvDJYe2LrOiMX29xiUrGJc=;
        b=N01ONQS/4zclZekgvot0Yp1ETViAnVH1jD+D1f2UEb841mhu10XyFyBgULkoGBFSHZ
         LN1gp3SJ8ttov0OjYNfUBozyGunzD1hz5/Eiu1hrr22q1IJZcE0dSqjo2uA5iQJAsg6j
         +t8c7OxqTvWJ4vHlqQlF8KD6faKA7k6fAJIAgf7ZL8TBSIdBC6Uf4zXlImi71Afc+HjQ
         lkEG+KzmKKraAH0yabmUx3cS8ZXe3kuWOp30VBMmVBX4/pdZab7IwSk9b7njnA/+EuYS
         vMjwduanWcLYb70DmRABhyhK+vG1AAONKc5ZGFkEMyoi2AjD8XexcMmCjZQk/oDRbPEq
         zh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhNGI/vefCUNAfGzfX3ewpvDJYe2LrOiMX29xiUrGJc=;
        b=VUkAkmy27JXbiEos+UcR1esMk6G/UJXXMucjSRFdmp2vMqEVKleYXSz+5+ul3wvnXJ
         9JkOjmbYarno+kuuPZnbwkegPXLQFi0QM1mdtoLhsgtdUZ0zZkK0MMob7X5oGVBxg9nW
         FNNxetXyWMA7b1U0HeVxA8vhc8k/kxcCzr1QyceWltUxTdXkAC3qjYP8pw0Fj3VFP8uj
         12SdA2okDny5kimeoqOWyCAzGuSxccMIDrp0D1a4RVQn0/CE30CBUs2OVAEx8xR3M9aa
         2hut4Nz2G2fk3ktjR2o3fhmwxaPM9DGmWD8KGUtBnA+TnHtBEi/yCvKu7RsSegd+5Y0g
         TDrA==
X-Gm-Message-State: AOAM531GgfDk2s8QZ0AdQAfFSnhddq2m7G3k3tXdaA9PDpYs2I2uGFZL
        8yzzAUt+hH7DHNpghkCGfmlmpQ==
X-Google-Smtp-Source: ABdhPJymY0pjFiYFmtBSynjwEf1B841wDAKehivuxXUJzUqRKu7Abm8XcMEBA3UVvqqMrxDbZSS14g==
X-Received: by 2002:a37:8283:: with SMTP id e125mr2255480qkd.175.1595457354602;
        Wed, 22 Jul 2020 15:35:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w28sm982143qkw.92.2020.07.22.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:35:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyNL7-00E6VI-3d; Wed, 22 Jul 2020 19:35:53 -0300
Date:   Wed, 22 Jul 2020 19:35:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Lobakin <alobakin@marvell.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/15] qed, qede: improve chain API and add
 XDP_REDIRECT support
Message-ID: <20200722223553.GL25301@ziepe.ca>
References: <20200722221045.5436-1-alobakin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722221045.5436-1-alobakin@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 01:10:30AM +0300, Alexander Lobakin wrote:
> Netdev folks, could you please take the entire series through your tree
> after the necessary acks and reviews? Patches 8-9 also touch qedr driver
> under rdma tree, but these changes can't be separated as it would break
> incremental buildability and bisecting.

There is nothing significant in the rdma changes, just be wary to not
submit patches to the rdma tree that would cause conflicts

Thanks
Jason
