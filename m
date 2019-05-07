Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA716711
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEGPoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 11:44:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46018 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGPoE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 11:44:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id t1so1503383qtc.12
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X3NrUDhwWUcAQphBIhNS0sSB4SuYiHwzvMVzFe3ZErc=;
        b=TOOBPO/SqC/F2xwNjED+AC8nG0ztHxDrtZl7laFxFW9NYlGCDv2Rga8+oK43dPnz+a
         Lc07phH/S2w+vNXhStCeAFNapHTs85CUPqwoTxHypbS3hdBV5/cDbGnKVGM+lWRy1Ctv
         CcCQ/TFiFtSRvaetV6nUcuyN8GmYkzljoxxFKBPQ4slerhQ8+2ECetvS9B0hZe2bS7c6
         Y1hEwPw55CC9yARMFSPar/ecv/V4gLqAkxACdgnoz9U1jKAeD8eZvvQz4fHO0H0ZzrZN
         CME1JsZTLQxpYC1D6NCuWvSUagGbwrDo283prdxWfbhmVJvA9LcrBIxN0U3e4fn2q5WP
         Gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X3NrUDhwWUcAQphBIhNS0sSB4SuYiHwzvMVzFe3ZErc=;
        b=gaklED5BoIfzyME/Sfh3wzC02U39ucL83QXeAPqu2oy9NHY2L1hnt4eESF/nRKgO2v
         rPyS9cRffcD22MuWpvJdP6jirXe3eFgYqBPHJ5qeZfgtHPsUH86nxmBxS4haDSqitTZX
         MU9TXGkTWjEDH7pPKNFy/1iQ8q6BemcZZEHgonrUqKmZ2Xdx5y7egya9WObWIqJ3A2W4
         W2NG98uZuywCYw54aO0HFyGbKsLSd7kT+YBDHoqQN63KlQqTV87vIys0z1eMLhcVGqpP
         w6WTaKQbCABbv7LcmAejhNxKLiLQvBbiU3NsGIAb+F/Q+Nl9jbIYeRE2P+4zO+iZnxcL
         mrtA==
X-Gm-Message-State: APjAAAXEwV+2/mn6fpNz6bqd4j1NLpcsazG+vqHjl8EVBDcBxEVv+Ge0
        6XEayF8SzJVSAQBuMKMft5VinQ==
X-Google-Smtp-Source: APXvYqyZAWqiLQ0tXq+tz4MyEdBFSfw/Tz3lPxgxDOXyNbYkQ0uAMFpVxUX+ppvD2qYru8q5k3ilPA==
X-Received: by 2002:a0c:9969:: with SMTP id i38mr26889865qvd.216.1557243843010;
        Tue, 07 May 2019 08:44:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 9sm7265830qkn.38.2019.05.07.08.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 08:44:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO2G9-0002De-4i; Tue, 07 May 2019 12:44:01 -0300
Date:   Tue, 7 May 2019 12:44:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 04/12] SIW connection management
Message-ID: <20190507154401.GG6201@ziepe.ca>
References: <20190428164954.GP6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-5-bmt@zurich.ibm.com>
 <OF63ED2654.B14EF197-ON002583F3.00529A34-002583F3.00545CFD@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF63ED2654.B14EF197-ON002583F3.00529A34-002583F3.00545CFD@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 03:21:28PM +0000, Bernard Metzler wrote:

> >> +void siw_cep_put(struct siw_cep *cep)
> >> +{
> >> +	siw_dbg_cep(cep, "new refcount: %d\n", kref_read(&cep->ref) - 1);
> >> +
> >> +	WARN_ON(kref_read(&cep->ref) < 1);
> >> +	kref_put(&cep->ref, __siw_cep_dealloc);
> >> +}
> >> +
> >> +void siw_cep_get(struct siw_cep *cep)
> >> +{
> >> +	kref_get(&cep->ref);
> >> +	siw_dbg_cep(cep, "new refcount: %d\n", kref_read(&cep->ref));
> >> +}
> >
> >Another kref_get/put wrappers, unlikely needed.
> >
> It just avoids writing down the free routine in each
> put call, and I used it to add some debug info for
> tracking status. So I would remove it if it you tell me it's
> bad style...

It is common to have a put wrapper and thus usually a symetrically
named get wrapepr - this is so the free function is done consistently

The debugging might be over doing it

Jason 
