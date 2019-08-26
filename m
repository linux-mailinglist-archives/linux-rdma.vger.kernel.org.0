Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42059D197
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfHZOZW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 10:25:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42340 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfHZOZW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 10:25:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so14143662qkm.9
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yH5O1dgP8GrSxRTzFJVJnJBShEBRsBR+4ap9V1bWa3M=;
        b=MjZ9aKaBNkzh1cbmfNt48ousQ+Qh0sHCfm2YZ1gm9jJ7w9mK2oV6d4N4GRQWFMQWZ8
         q/AJcPLiuJ9j0F5QazEkh+WgdRtZ7YRT/R6wj4D+N2qRQJeU8gJ6Tlcz8+spLk+Tmee5
         Xq0/1UxYJPQP8Rvnz3mqMUt7V/9nrJPaFYGrjLOi6BmBV7iNQwSs1l4/LVdp2JPKIK89
         q88UMtBrhv8AzeH9HcXMzjwslAdmj8LBZXPTa/aHtgokl75w3bsNi+CV1fo6KUvLuAzx
         V7jRzHryrOguOd+pbYW/taX+Qs3VHnpxwNF0xYZZWtr5WLWfgnZ7XUKfFloxULO2XMCL
         977g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yH5O1dgP8GrSxRTzFJVJnJBShEBRsBR+4ap9V1bWa3M=;
        b=Ss+JIQ69wsFOS968MdZgDpJNW6kY4UQ2Bq56dTcxKrhkZImq9dBgLeuNamKEOyqsB2
         mqHWfjNXQB/S+VP2DSf8w9hyIXwIK0ixM3pLmgzBfQqxsZcTtsYXjBiUeJujMDcy7SM+
         ZBx97EWnWpHTrdDBnWXUCV29RtxGe6bu+5GYxH9MuKhzqhuXzzKqYpWCOyDpkCt2cWTr
         wMv5bX0jciguDKF/Kw7l9shep+CKKAZQBjxF1Z8YBtYZkrMU9mrQGqIBUKGylWtR92Ke
         lNzMRKo8AcIeSEBode+GJkzvtrJcf9E7fRbYcpbH+9+nT45BVc14JGlS1ZAHWD6XYTaa
         71eQ==
X-Gm-Message-State: APjAAAUNPXRyaODEAWnvWlNVcBpDHaTpO3QA4It/DIWuv0GXmYb1qI4U
        9DVf1yFeIQKbWxHNfa3jxkLm2w==
X-Google-Smtp-Source: APXvYqz2dj4+eSRtoWx3nI2lLFMPp1U8vqb7958J3ZF14GmdojJybTHuaCVVf5EyMrjgqT/RHoP+zg==
X-Received: by 2002:a37:9701:: with SMTP id z1mr16453747qkd.66.1566829521175;
        Mon, 26 Aug 2019 07:25:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id y47sm2120678qtb.62.2019.08.26.07.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 07:25:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2Fvs-0005tG-B7; Mon, 26 Aug 2019 11:25:20 -0300
Date:   Mon, 26 Aug 2019 11:25:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, dledford@redhat.com
Subject: Re: [PATCH] RDMA/siw: Fix IPv6 addr_list locking
Message-ID: <20190826142520.GB27349@ziepe.ca>
References: <20190826141740.12969-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826141740.12969-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 04:17:40PM +0200, Bernard Metzler wrote:
> Walking the address list of an inet6_dev requires
> appropriate locking. Since the called function
> siw_listen_address() may sleep, we have to use
> rtnl_lock() + rcu_read_lock_bh() instead of
> read_lock_bh().

What is the RCU for if you have RTNL?

Jason
