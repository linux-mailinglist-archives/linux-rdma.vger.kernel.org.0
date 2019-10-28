Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA9E72CD
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfJ1NnW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:43:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33707 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ1NnW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 09:43:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id 71so8501486qkl.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C6LZHJzRSBcECwTOl2HIhLyJhDZrr+9ou4Yj3mDuv6Q=;
        b=i+QQiGGukfrWRjw/aF02z+d0DtWCpmwIzJEu7QCdlDfZuFFmE+hN8qohv2UMpZzLrz
         4Th3jUsLhqZociIhIKFnx5DQxb091UyRg/TV3n+LAQgaVS3aO8EyAJR4CRKUieZlFlZu
         048mKpd+AFn6TEoZ3elIKDO3876FFhbJbTveZ9fOK3Ykg3xTKsieCm8vpG3H9hVeeS4d
         TIZj5Km5R774jaDXEI+YFEe8d/ctxUZ250BVEwogdTuf7gllFhmw3r000iUyCeTRqXy2
         LjPFkxyKCGwiyTgo8W/76oyW6JHotNDwSiW0s8y6PBkgftiVnJCcTYORNq8pBSUy6NEY
         j8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6LZHJzRSBcECwTOl2HIhLyJhDZrr+9ou4Yj3mDuv6Q=;
        b=tOXZWJ4JsTt9XkV8M0o+O6SS0vJyKxgHErJmZmWHmwC0Zcq/2Vu6cXGVmyRoFTunLP
         4pMrbLSMUnF6WiYMN10JydXesfvGwGOVUcIh+ueb6NrsuXIkqcRg5JCj8xNKqObEuk36
         z19Ri13nox+YtIfx5QMoHGb6k8FK/USyNPIwHNwebsHXFqdbDAP5+PELE31flyE1jzUA
         vnT5y6dxGYHO75MRlkVKFMof8AGXWviyvouqvG/qJpWj0J+dkvAdPXdKyXy4QwbYaR0E
         hZwG13O+Ts1g57uGyrlafVdnUZ0IvmhMqT7J7Z3M18sJxOqBbDYNXZvzOM7JjZnJMbUv
         Wo5w==
X-Gm-Message-State: APjAAAWh5cZiESB8QWK+4FzJOhY3uUZq03P64o/IgtYlQmZJ8OR11mOo
        T6F3QS2gPyoqFyCCTJHVHBNc8A==
X-Google-Smtp-Source: APXvYqwIHUE4i/syLsfYswPlzowoe9XQDukiLyfqjQWCwOR0ze6yKdssJTU/ZE7H8/b+YA4PrXEpjg==
X-Received: by 2002:a37:2ec5:: with SMTP id u188mr15854953qkh.94.1572270200936;
        Mon, 28 Oct 2019 06:43:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x7sm6147961qkj.74.2019.10.28.06.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 06:43:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP5Il-0008Ok-TT; Mon, 28 Oct 2019 10:43:19 -0300
Date:   Mon, 28 Oct 2019 10:43:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Subject: Re: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191028134319.GA29652@ziepe.ca>
References: <20191027052111.GW4853@unreal>
 <20191004174804.GF13988@ziepe.ca>
 <20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
 <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
 <OF7628E460.D6869428-ON002584A1.003AE367-002584A1.00455D5D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7628E460.D6869428-ON002584A1.003AE367-002584A1.00455D5D@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 12:37:38PM +0000, Bernard Metzler wrote:

> That's why siw currently saves that info to a resource
> (QP/CQ/SRQ) specific parameter 'kernel_verbs'. I agree
> this parameter is redundant, if the rdma core object
> provides that information as well. The only way I see
> it provided is the validity of the uobject pointer of
> all those resources.

The restrack stuff also keeps track of user/kernel on created objects

Jason
