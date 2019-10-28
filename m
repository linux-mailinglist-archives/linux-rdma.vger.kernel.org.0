Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B5E779F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbfJ1Rdg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:33:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45110 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404155AbfJ1Rdf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 13:33:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so15688922qtj.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1H212PzOib2E6VsuZM1Q1Sarzi3xGNQchhEeMUFmIHg=;
        b=Md3VlwB8wcTE9jEQuhbt6B4cXMLvNaitsGlfEHKZAFpFxBW038sM5FUDU4STdvSGVw
         3oPYX3py15qgKvQznQ9/Cqxd51QMgPLskLDxM0m8qkcutqZ25vQrZRb2kQWTmNJ7YQn+
         rCZbVzp50WaR68+XXqzC701UTQ7GZ3DYnhD1I393NnoMrCDXxcq451RpkJlq1MuESSbp
         z+cFcntK1CjdRkD5y6coZzKT6oU/S717Bv6deLSrB7EomFn9nvugSsqEmOuO5DgHKs4/
         0RS9s9/0XGKGDfOjgI+yMKo7SKvQv4fZj1fN6lMZIpYNClnYbEiAW370wzDnUDSe8C3/
         +yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1H212PzOib2E6VsuZM1Q1Sarzi3xGNQchhEeMUFmIHg=;
        b=S9llhbUIA0eUewFCGMI7ZbKBN0q4Gs7KWLwrkN3ycU0tkplyU69LUo4ZLA0f5BxMoV
         mzLhwIgM8m/EtX8cyxW7yCPu0czOSnLDh/SCMbdHg+P4/I63j8sRSYA+eXW37rBSV98+
         jAN5G6JmfQetxhGnDX0n1qvf4XWscnj0GP7dZs7kSC3vlfASDvqaWpoVYFgb2w4SV7n2
         r72zd7N7xovHuIliy5TqjL6pO2xlnfCq1GXSBrEIDaTivKF+SJiYn/Gwk31x1vfc/7+7
         HLBVcI8heggxBN/K7N+pegYBAVeODLJJPs64al1Wv+E5AA9siYvBsKTK1uCIZSU1X63c
         imhQ==
X-Gm-Message-State: APjAAAU+XD+PnIGJQlljVEvF5s0hHtOA3R8E/jLETSU9+/YbMJCAQB03
        sCFmMaXKTLGuefFUrQiy6f5+fQ==
X-Google-Smtp-Source: APXvYqxo5uxi7twd8GM8gRnp8g3mk8QLhASK8u0yOTZgl1n7EgLM/3BNSc9ylFD2lcfoPqxXShXr3g==
X-Received: by 2002:ac8:67ca:: with SMTP id r10mr3233525qtp.124.1572284014667;
        Mon, 28 Oct 2019 10:33:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id l129sm6267904qkd.84.2019.10.28.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:33:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8tZ-0003x3-Nz; Mon, 28 Oct 2019 14:33:33 -0300
Date:   Mon, 28 Oct 2019 14:33:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com, Dakshaja Uppalapati <dakshaja@chelsio.com>
Subject: Re: [PATCH for-rc] iw_cxgb4: avoid freeing skb twice in arp failure
 case
Message-ID: <20191028173333.GA15146@ziepe.ca>
References: <1572006880-5800-1-git-send-email-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572006880-5800-1-git-send-email-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 06:04:40PM +0530, Potnuri Bharat Teja wrote:
> _put_ep_safe() and _put_pass_ep_safe() free the skb before it is freed by
> process_work(). fix double free by freeing the skb only in process_work().
> 
> Fixes: 1dad0ebeea1c ("iw_cxgb4: Avoid touch after free error in ARP failure handlers")
> Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-rc, thanks

Jason
