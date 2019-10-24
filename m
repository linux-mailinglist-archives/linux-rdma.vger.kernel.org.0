Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AEE406C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 01:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfJXXxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 19:53:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35391 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJXXxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 19:53:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so616418qtq.2
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5YWlVDMQQRj45NieJDAfnNmrT+kDKmjnDW5sX3377E=;
        b=M8sIjZgCpj/RC02Il1V95dTxoqAQiPY636++cOfuRNqRyxKTUgJQXLNRmoRm1lTHz8
         7wUkLhdhTz/Nk7QKxR/NnJy2kYeEt9gn34MO1U1gyxDKxvG2qu2mXZWdBdHFvOq2AXfC
         ZMFONbpJT/XZzZ5h2/YwJa6kaFkKx15PKCoVU2r56PUvPc5P9QSc/zlTOebjYswPmpYl
         PM7gxsiJXowTtWTOJjudVeDrU6m21ZtvfK0Yhsv0jgsVPBY+MhJi/FsLpn+1svBlUzdq
         OfoWJH53M12uodsgFnL1aO/dFsUJ/JlNRghhBq0GtHrPB9A3DIkKyFqejOXF8oeufkVN
         W6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5YWlVDMQQRj45NieJDAfnNmrT+kDKmjnDW5sX3377E=;
        b=fIHvMomPDo/hsTOz5PfFvFQaYs6MoTCOds92aRxafqLxId1IYnACUBeAlGMkyATeXJ
         bsCoPqZqSxk6aordwqBbHAXe2aYO+LwvNe9SRCxvQ6HdxsFWaazLzSD7QuATB8/cEMOl
         5/dS2DmemX6Q/aosvEJaMdRZ9YJVf8Q36CCA/vzq9WVnU8Uz4aZYPB+PVXlA24AQs/bG
         j4+Ssc6OSZfG/EDBJsH20yG0/Ko+8KNjThrfQPaIzVh4ugBFk1Ga/NDbotO0/8/pt86g
         1srqk4mFEs3xKUV0MLJY7f/5KXdtMlMjhJZ7cyF5sUK6W3ccPbwf2f2gL4FdIPGIZjXj
         BHAA==
X-Gm-Message-State: APjAAAWHbgBWa9iDgQ1nDxn2d69MK0FCoChaSRGMor+J9KvNbZBKvjIe
        2Dgu5O5JEZsxZ730TJEyG8LL1SCapA8=
X-Google-Smtp-Source: APXvYqwoamvYagh6PuT1LwHoJV9Bpn0dLeuM5XSAV84M4bCmDI65/j4yWQ2w7tqcPQMx4tzmrAYaJA==
X-Received: by 2002:a0c:887a:: with SMTP id 55mr570850qvm.137.1571961185527;
        Thu, 24 Oct 2019 16:53:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x26sm254388qto.21.2019.10.24.16.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 16:53:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNmue-0000h4-Ck; Thu, 24 Oct 2019 20:53:04 -0300
Date:   Thu, 24 Oct 2019 20:53:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024235304.GG23952@ziepe.ca>
References: <20191024131743.GA24174@ziepe.ca>
 <20191024132607.GR4853@unreal>
 <20191024135017.GT23952@ziepe.ca>
 <20191024160252.GS4853@unreal>
 <20191024160810.GV23952@ziepe.ca>
 <20191024161305.GU4853@unreal>
 <AM0PR05MB4866029667184FC06C427E3BD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024183639.GA23952@ziepe.ca>
 <20191024191947.GV4853@unreal>
 <AM0PR05MB4866CA70E3711F8BE19F294ED16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866CA70E3711F8BE19F294ED16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 07:53:56PM +0000, Parav Pandit wrote:

> Jason's memory size point made be curious about the srcu_struct
> size.  On my x86 5.x kernel I see srcu_struct costs 70+Kbytes!
> Likely due to some debug info in my kernel.  Which is probably a
> good reason in this case to shift to rwsem. (rwsem is 80 bytes).

Yikes, I knew it was bad, but I didn't think that bad.. So
unbelievable I checked here and I got +4752 bytes using SRCU on my
much less debug kernel. Crazy.

> One small comment correction needed is,
> 
> -	rdma_nl_types[index].cb_table = cb_table;
> -	mutex_unlock(&rdma_nl_mutex);
> +	/* Pairs with the READ_ONCE in is_nl_valid() */
> +	smp_store_release(&rdma_nl_types[index].cb_table, cb_table);
> 
> It should be "Pairs with the READ_ONE in get_cb_table() */

Done, applied to for-rc, thanks

Jason
