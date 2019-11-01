Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5FDEC380
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfKANFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 09:05:43 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:43135 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKANFn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Nov 2019 09:05:43 -0400
Received: by mail-qk1-f179.google.com with SMTP id a194so10550373qkg.10
        for <linux-rdma@vger.kernel.org>; Fri, 01 Nov 2019 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8XmTnDCXLPv0idp/XbQs4eS7Ipv9v+N22DpJZVOMgYM=;
        b=KYVNCNP0n+3ieHpw0oDSvBMnG/Nl7XgteQ9a/q8BTAQmBLQELkqfrFT565ZUUzBD9N
         hWY0NCkzT90QS2RfOOzhEfZBUdbcsy9gtoIXa+Oa4+KZtVyG58+jq0ei9D8mC5YVOus8
         TcDi5Ryplb+WH1NEr4ppZ1qof2igAd0OINpKpzWinFqyp5MBSM5o2POVwhs+4WnL4Vuv
         uaNSvGsjW42xeYEmJ4Rtedq2XLz8ZlBwfg1m5IDqAGjb/LRDr/+dm+oGJARDqueIIBC3
         DXqlZL6dJOlAa40iJ93qmEydF4TNE71wZQSHGTDZYyijxmI5+xXBNu43/0W2D73XPY5y
         2lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8XmTnDCXLPv0idp/XbQs4eS7Ipv9v+N22DpJZVOMgYM=;
        b=qMB4e7iuBvZXEeSalCvzXpHOz0SIr+usoNUNM391txSLdZ1iaiiaX2EyaHeJ1KzJ3y
         kaVQXJ5LM7SkkTzFVnyByLgVPg30Le76mwuzCEmcn5rO+MEBSzeRvRzB9P4rZ5pbMj79
         y/tnXKFFDf7XSU5fRNzHRRKEMuvzSGUzOH9r/rauISbabC9BL5f9fqXvZA7lB+aRLNZ9
         rei4r0D5S5rNsnt5jDfAF1IvhQKAOKrXbOjclXBf71925MHl4bAGkqywdBK5HmNHKdaB
         hhNLdsmdhY9UC6E1E1+/nGzrS0OEToPG+rOZea6tcHdfC4sA4LRNdpvoOZPdBkfR/2Ta
         JBNQ==
X-Gm-Message-State: APjAAAX2HEqBV9Idk4t3qu26+PiufBrdI0De61uTDfC3LNTqm47R0itq
        B99Mnr9sWQITXy4fDG5OFUUYNQ==
X-Google-Smtp-Source: APXvYqwHiQ51zidkuSCYs71pMjW+9xaWObhr71laQ4AT7FqU4iMdLN+YGUx/YoY/Efn+nl+uNcwEPQ==
X-Received: by 2002:ae9:de05:: with SMTP id s5mr3766859qkf.175.1572613542069;
        Fri, 01 Nov 2019 06:05:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o5sm2789294qtq.10.2019.11.01.06.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 06:05:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQWcW-0000GF-O0; Fri, 01 Nov 2019 10:05:40 -0300
Date:   Fri, 1 Nov 2019 10:05:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     oulijun <oulijun@huawei.com>, Parav Pandit <parav@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: =?utf-8?B?44CQQXNrIGZvciBoZWxw?= =?utf-8?B?44CR?= A question for
 __ib_cache_gid_add()
Message-ID: <20191101130540.GB30938@ziepe.ca>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 05:36:36PM +0800, oulijun wrote:
> Hi
>   I am using the ubuntu system(5.0.0 kernel) to test the hip08 NIC port,. When I modify the perr mac1 to mac2,then restore to mac1, it will cause
> the gid0 and gid 1 of the roce to be unavailable, and check that the /sys/class/infiniband/hns_0/ports/1/gid_attrs/ndevs/0 is show invalid.
> the protocol stack print will appear.
> 
>   Oct 16 17:59:36 ubuntu kernel: [200635.496317] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
> Oct 16 17:59:37 ubuntu kernel: [200636.705848] 8021q: adding VLAN 0 to HW filter on device enp189s0f0
> Oct 16 17:59:37 ubuntu kernel: [200636.705854] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
> Oct 16 17:59:39 ubuntu kernel: [200638.755828] hns3 0000:bd:00.0 enp189s0f0: link up
> Oct 16 17:59:39 ubuntu kernel: [200638.755847] IPv6: ADDRCONF(NETDEV_CHANGE): enp189s0f0: link becomes ready
> Oct 16 18:00:56 ubuntu kernel: [200715.699961] hns3 0000:bd:00.0 enp189s0f0: link down
> Oct 16 18:00:56 ubuntu kernel: [200716.016142] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28
> Oct 16 18:00:58 ubuntu kernel: [200717.229857] 8021q: adding VLAN 0 to HW filter on device enp189s0f0
> Oct 16 18:00:58 ubuntu kernel: [200717.229863] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28
> 
> Has anyone else encounterd a similar problem ? I wonder if the _ib_cache_add_gid() is defective in 5.0 kernel?

Maybe Parav knows?

Jason
