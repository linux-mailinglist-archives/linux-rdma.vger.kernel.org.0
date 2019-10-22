Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB26E0B9C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbfJVSln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 14:41:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35891 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJVSln (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 14:41:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so17271960qkc.3
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dk7uCgHLxccIY6fVbA7wZt6uovWWgfYi1byT7K+xYUw=;
        b=j4YYwNhpqvbJ8WnF4A3dpIcrvbmpbQ/D02OkY4ssIsAokNjY0MNGsqBqxtiviNKwPN
         xwjBIN66Nw7Rcg9ek6jFTYnWjFe/4yBU/XLuAg+9IsnBivqJKNbZkUMI3m/ABjIIER9g
         saOyPyriRqY1OFwpsc1/dNphgyGlW41wdRY4M6LQrD+YhlpEGv1axSlRuFOH87juoKh0
         CWn+eVu9EEXr5FT3XDyV2/cR83cmjk/vY7f7zHpgC7TfCFFgR99IIwKXJQvSPTJ7cKo/
         uwsL6w2T2kzicix25K+QF9xhsBMj8wAHa5JAO2lhgs2H4rqTMhuCn8lN0/yKVOUusmh4
         dtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dk7uCgHLxccIY6fVbA7wZt6uovWWgfYi1byT7K+xYUw=;
        b=Fkja52dsXmsYtRMV48hzlXifvgTFpBl/GjoaOrSA3OT2UrHrjTyu8uA9r8nylrBQ54
         uToTfAS4EtV8tcsqjbWyZHVlrJLKz9WRxZTh6XbMtNEYofOdvSNfD4WpC58Ho9FyWnLV
         e+1oJ1NvX59vs0abTLmqxRYpZI4++/gKrB6z6TKExarfnEqvuppI6kEBW+tED/rQfBtL
         2Esne2A80VyTmACt9kVUMgIebl1558dyxD0c+AMq6B6V3QlAZu7Wvk9Cmh9/YUE8W8Mc
         FGXA4G1BkMg87uP1BaFKGq1uNt5gLb7pkejyObxti7aUcyX6viD25yaDkqLTSTXwMsYU
         9g9Q==
X-Gm-Message-State: APjAAAXYshUayqWyE4tCbKOGOXujNFCiphhAsWUiczdXe0RW90N7IiLT
        Vvjn+1mowV/zfMs6a+tFonclicoCwb4=
X-Google-Smtp-Source: APXvYqzyzL7ztcnVWdSJdMTQ0Nya3gSWBKP+hFXVpxUh359dL3cb676rFx5IS0powukH5ZHNuyC7kg==
X-Received: by 2002:a05:620a:1497:: with SMTP id w23mr4400792qkj.302.1571769702173;
        Tue, 22 Oct 2019 11:41:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u189sm422776qkd.62.2019.10.22.11.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 11:41:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMz6D-0002HG-9Z; Tue, 22 Oct 2019 15:41:41 -0300
Date:   Tue, 22 Oct 2019 15:41:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v3 4/4] RDMA/nldev: Provide MR statistics
Message-ID: <20191022184141.GA8628@ziepe.ca>
References: <20191016062308.11886-1-leon@kernel.org>
 <20191016062308.11886-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016062308.11886-5-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 09:23:08AM +0300, Leon Romanovsky wrote:

> @@ -773,6 +781,25 @@ static int fill_stat_hwcounter_entry(struct sk_buff *msg,
>  	nla_nest_cancel(msg, entry_attr);
>  	return -EMSGSIZE;
>  }
> +EXPORT_SYMBOL(fill_stat_hwcounter_entry);

This is not a good name for a global symbol, I changed it to
rdma_nl_stat_hwcounter_entry

Jason
