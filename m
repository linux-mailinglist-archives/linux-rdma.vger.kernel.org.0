Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F394159879
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgBKSZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:25:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38232 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgBKSZD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:25:03 -0500
Received: by mail-qv1-f68.google.com with SMTP id g6so5448690qvy.5
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhnCSHBaI8EAFkLJ6pmNBeEvXU24vzHrl0V0AScMnmU=;
        b=fhaFyjCojzT8SEFqKbr+9f3Vn6n6gYxNKbdvfEs4yDJOnK/3LtCKq5wz4+dYSx+yAD
         IAG3aiT9qP23quriru2ycpyw6SUA8fdnfh9ZYzkfE57ibsGVbKNH7hsLuUKRp67zgMa3
         AWYk0wdOakIkmgs3rbIF5jUwGvIrvxYOeoDExq5WXkZZmwuT899OEo1vh9p+j65lO4+L
         eGjr7XcRzTc7u/mVLujyICgGxRTVVyc25Z3yQ67CEPKho/fUkn6EHloA/3x6XyOIym2D
         mSyQWMNYSoyxKBJYUSR4ax3AbMFyIS/uwQkVqKt88a+A8+gbXQMmL4UANY2qOdU7BXOF
         7Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhnCSHBaI8EAFkLJ6pmNBeEvXU24vzHrl0V0AScMnmU=;
        b=bMbcEa6Sp1zbWOzhmyzSH4O1arEFgksrIVNDMQAOYSmFALO0O4cauYPvntrb66sLtQ
         b3usD4VZsXMTYlrsCXGBY2wBriUp0OWOD6GMN5BNnr6PPTpz1jBq5Z95CR5sECoxV1jd
         MNCh+VdrzWpWbDxu/i+3UtJ+Y+pE/vlbqCOo+2XQOpiO0TIQCcz24uG3kw3qxPmZylBc
         ClXkLE6TGzFSZMkj/+SjX5JLt6WwxvW10nmodyYtvT+ao6TPHIW/Ui8yoiQl+EuFzB1C
         br0d1lH+EAoZUgfFqkd7PIyHYOTHWWBWB0cwo+aTL5JrTctGAl9ONTlomfCKBoDlhxdJ
         3PxQ==
X-Gm-Message-State: APjAAAUkypBM8Dwn1IClzRvdABY38yd5rcD8eOuoNPDHwX+E16njr38j
        NuUg1Tjjxu9t7HhCxPmDCBpgTA==
X-Google-Smtp-Source: APXvYqx+TGxlEJOKwmTf10hofdZk6NIYZJFIXLxHN5Eq4H6NsyR2stX+7aHI+mc5w7C+Q+NeQ1OvLA==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr16441738qvy.185.1581445502277;
        Tue, 11 Feb 2020 10:25:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q21sm1474946qkj.102.2020.02.11.10.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:25:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aDV-0000wv-D7; Tue, 11 Feb 2020 14:25:01 -0400
Date:   Tue, 11 Feb 2020 14:25:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Moses Reuben <mosesr@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix invalid memory access in
 spec_filter_size
Message-ID: <20200211182501.GA3583@ziepe.ca>
References: <20200126171500.4623-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126171500.4623-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 07:15:00PM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@mellanox.com>
> 
> Add a check that the size specified in the flow spec header doesn't
> cause an overflow when calculating the filter size, and thus prevent
> access to invalid memory.
> The following crash from syzkaller revealed it.
> 
> Fixes: 94e03f11ad1f ("IB/uverbs: Add support for flow tag")
> Signed-off-by: Avihai Horon <avihaih@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/uverbs_cmd.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Applied to for-rc, thanks

Jason
