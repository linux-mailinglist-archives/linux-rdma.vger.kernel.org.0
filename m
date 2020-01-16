Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF613F8CA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437655AbgAPTU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:20:57 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45309 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437654AbgAPTU5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 14:20:57 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so9601957qvu.12
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=81kflwq1LKTJoJRd6zHjSIcQI0KmlXkcls9/tBo7nuA=;
        b=Fez1PCHqieVREo0dLSh28taNzYtPlXRUhitMndvsYDHN1n41rUz0luanpBE0vOj92m
         LurMdl64dXLzC3uruGzU/xkRJeY7AqQE73PlD2b/ATsdKAnuPIi3tRzVH7o7yVxIQUvQ
         LoxsiYQGH1au9vFIV754rPw8hKPJTFIblURKLz7ZnV8D0CFZsj4m1BbljlVQJ2t9fUHC
         YINLzw++UT+xSUxGnuGoYI2Nnyd6Lj/fwgPv+6tCws7oTJH+fltXlTITwh63inMrYFkN
         hrJaZzEt3eDunOgXw7VfGJ/Ot0SvEdBfvEQQkG+Qg6XCDoMEhxV0/8z9h/4D7rpaG7ES
         c1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=81kflwq1LKTJoJRd6zHjSIcQI0KmlXkcls9/tBo7nuA=;
        b=cP5/j6QjbbZsjGSeRRxkT08bce1vSGcxUVH5qJHPGaebygLCKXwnQ63oAnU7BPTB45
         3M1zrfvnFanMhxZ/jApoeyXw8kM4zz8+NmP8Lr1TgRLHuGRbfXHZPH/a1as1Gdu+dkr/
         wz9pOLMLqIZ6hNMT03F0/0JWW7BNfjfTHDjiXiqmSALlnNt0KwOS5eZNcd6qloVKUx2Q
         5wDu5glCB0dNsfhESvdB/2qyc1HWawgEYvNUg7TP/2GOfrECmmrCY17n0iXtNG0BnoKM
         maWGk5O9zoMEW9QsEJoOKU+teaPYjobT0Iw/kDJaXgZSdtvF5lhFs579OfGwMdSdkRzr
         YrhA==
X-Gm-Message-State: APjAAAWVN4bQxesosK65g+WC7FoeXn4CN/Ch+Lss644phJCag0r7R/6i
        rT9S8FpnG/0667TyP/p1imQzdg==
X-Google-Smtp-Source: APXvYqzn+xRkLkCNs33bv/K5N2101y0EqVzvVTH+y2BK05cdkxkk2BDyz6ambGon1fg0n2v/t2jjrQ==
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr4261496qvb.163.1579202456652;
        Thu, 16 Jan 2020 11:20:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i2sm11820744qte.87.2020.01.16.11.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 11:20:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1isAhK-0002fJ-Ma; Thu, 16 Jan 2020 15:20:54 -0400
Date:   Thu, 16 Jan 2020 15:20:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rao Shoaib <rao.shoaib@oracle.com>
Cc:     linux-rdma@vger.kernel.org, monis@mellanox.com,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] RDMA/rxe: rxe should use same buffer size for
 SGE's and inline data
Message-ID: <20200116192054.GD10759@ziepe.ca>
References: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 10:30:10AM -0800, rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> Incorportaed suggestions from Jason. There are two patches.
> Patch #1 introduces max WQE size as suggested by Jason
> Patch #2 allocates resources requested and makes sure that the buffer size
>          is same for SG entries and inline data, maximum of the two values
>          requested is used.
> 
> Rao Shoaib (2):
>   RDMA/rxe: use RXE_MAX_WQE_SIZE to enforce limits
>   RDMA/rxe: SGE buffer and max_inline data must have same size

I already took v3, with modifications

Jason
