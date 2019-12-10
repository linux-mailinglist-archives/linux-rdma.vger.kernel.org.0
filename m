Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554FB1190EB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfLJTor (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 14:44:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46897 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJTor (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 14:44:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so10919106oii.13
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cSRVrn8feD3OQNfvTx8m2swsMDSqby5uarB5TK91UvI=;
        b=TfE54BunmMZ1b3iHwS3zdd2nF63lFRI/pCVTLjpwgslmuAQYm9tSfwJ64F80uhEAfy
         FCBcJJQzdWhAa8pWm+obj3R+3Bi/h/dRUxN6Zani/IND6/zmEWJTBAKShqBxgHvpL/Ey
         V5F8KsycbdmKbs4kEZ/Fy4JPqBWFsp7eIfITaE3KVXWUdXZggvkmpkvWoaNJxb36Cmkk
         7fYVLqoXO3ZOuIjysmXVzyy1/xzYHXEkEx5Hj36dUAnVpSyaVPxXputfCgMcQE7u7qau
         8oYSe3v+LjdK5LV2xcqcyWYyynW1mC1x2UjgMqW7dssV9YAwzSjVuBv6byI1TVgKfB8Z
         drsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cSRVrn8feD3OQNfvTx8m2swsMDSqby5uarB5TK91UvI=;
        b=h5bk58XvSg3gE4VKakECkBGhbFJ4llnHCn1gzW2uIILvAlqn/j+6dUQtUBvgmb/jAl
         ircC7kQOaXV4XRgSU1S2MVmnXUiq2ayR6XURJNn5+g84OKbdsxUEpGPUklguL4N9OU7+
         25wfdQrWbkDDRFE0KWxFrD75MCD9RbdhkkaljDFDygzxSLB2lWW+8t7s1IuhE+C3x4fN
         FyLq7BuUxmWqJYGn4aSQYJEqZpexLErDKpYOZzL1msis9DDjW2fbuTutc9D0Cq61lBs5
         e60WNWz5qgD5ZBY9o3Q29EdHXjc3Bs8qalFrOdOXqTUWfo+8OACRYnyia7yiqM311DtG
         oIGw==
X-Gm-Message-State: APjAAAVza0FbQgHm6S93afJX1I2hOBmgoIBhbGKZaRjSUTZBd+4UNO/Y
        1AloN3/JSAhupLrU31HAnRRTIA==
X-Google-Smtp-Source: APXvYqwqLm3iUij9wnL5yjOiQjWRrFFcsrbgFfyLXAjsmPxxqdUW/3jZd2xBO2Ce9dHG6tt5zHqrDQ==
X-Received: by 2002:aca:481:: with SMTP id 123mr524185oie.110.1576007086696;
        Tue, 10 Dec 2019 11:44:46 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id j130sm1727504oia.34.2019.12.10.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 11:44:45 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ielR7-000028-0A; Tue, 10 Dec 2019 15:44:45 -0400
Date:   Tue, 10 Dec 2019 15:44:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com, parav@mellanox.com
Subject: Re: [net-next v3 00/20][pull request] Intel Wired LAN Driver Updates
 2019-12-09
Message-ID: <20191210194444.GH46@ziepe.ca>
References: <20191209224935.1780117-1-jeffrey.t.kirsher@intel.com>
 <20191210172233.GA46@ziepe.ca>
 <324a6a4c7553cea5225b6f94ff224e155a252b36.camel@intel.com>
 <20191210182543.GE46@ziepe.ca>
 <a13f11a31d5cafcc002d5e5ca73fe4a8e3744fb5.camel@intel.com>
 <20191210191125.GG46@ziepe.ca>
 <46ed855e75f9eda89118bfad9c6f7b16dd372c71.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ed855e75f9eda89118bfad9c6f7b16dd372c71.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 11:23:32AM -0800, Jeff Kirsher wrote:
> > I also do not want a headache with conflicts to a huge rdma driver in
> > net, so you cannot send it to -net.
> 
> Agreed, I do not want to cause you or David Miller any headaches.  It was
> not clear on what additional changes the RDMA team would have once their
> driver got upstream.

It isn't about your changes. We often do tree-wide change the RDMA
APIs toward the driver. For instance Leon's work to add restracks and
to move allocations out of drivers. If any driver is out of the
rdma.git tree then this is all broken for us.

> > Mellanox uses a shared branch approach now, it is working well but
> > requires discipline to execute.
> 
> Wouldn't a shared branch cause issues for either you or David Miller to
> pull from, since it has changes from the RDMA and net-next tree's?

The shared tree approach requires discipline and bunch of special
considerations go into constructing it and organizing patches to make
it work. When done properly there are no issues.

> > You can also send your changes to net, wait a cycle then send the rdma
> > changes. IIRC one of the other drivers is working this way.
> 
> This sounds like the best option currently, since there is still a lot of
> work being done in the ice driver.  Since Greg wanted to see driver
> examples, using the virtual bus, I can send the RDMA driver patches as RFC
> in future submissions.  This way, we can make sure the implementation is
> acceptable and will be ready for submission, once the virtual bus and LAN
> driver changes are accepted.

OK

Jason
