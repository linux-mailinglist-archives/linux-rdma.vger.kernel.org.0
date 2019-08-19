Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B39499B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHSQRB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:17:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34674 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfHSQRB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 12:17:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id m10so1891860qkk.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/l+DQMaOiKLikOxyV6ugkYFx5NSKQR+zmDinWPzvmCE=;
        b=loiRFXqaKPiBB2/TCP9gbLF5KlHd8G7z29hNdlZtOOMG2Utd6fGM53cDju8/eZ8BYs
         e9zMxC1nsAdQe8bUCje4ytyWASFXLfa1w9bCGKvVsJL8CaVw1NNDpI8S1uCcD1IvOePf
         e2UklcC63WHz8n1AusG+jrXcYaZIma/TUCbeYKB86wcRN44qsc9c3QCI/UmB6U1P9r/6
         XJ5bJxKzF4mzfth3Zl2NkuEbziivg0RxNCRtn2bC/evdbIpR8fpPNxjZ0Wv9HIlCSsHU
         bETspX4H8S3zkApTKz7cunpXEetA18AHw5uu+h7IeJSlE4Psr/MhRnBF0U6CJeF6Jw5O
         JIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/l+DQMaOiKLikOxyV6ugkYFx5NSKQR+zmDinWPzvmCE=;
        b=lBztihyXb0JOffLEsJgy0VqYISBv+e7gQhLTblYU61FYRMlp+1lZGRjOzluJxs2h5W
         0wj0KVguusEcle2lLsO7F+b5TNSfKreWFiyw02gC+W2jPT+I7VjfvNtCAt03jroaSaml
         BqKG4ZTPAYBiWn6XhfXar89TCQgkr/uCisLoFLMUQhXvGumzQ5qGHNCIeyaCKxI0prI8
         dKqrwol0RvLgWr3g7x9jKXhyLdE7dL8WgNygZcsJppBJsh/2RCGZCEynd9RSJlrrzuN1
         a0Vy15Eq7zW5Su1MAa83P12Vv6DoILCC/AODL5eV8iIqGL2JmZF+oJCLDoXG+fmjfWZU
         ifRQ==
X-Gm-Message-State: APjAAAXzzxbB9x/8SKjGiLjfi8PkwtoksFTBBoFOa8DUn3HHlzqpWKAH
        0iqxSFyj5HiAuqeVDAwEUiuoBQ==
X-Google-Smtp-Source: APXvYqwraXzRJ/XVUPuFlRpBXHvzLkUfb/xkD9Z4Lmh8CujGh/ETFbP/u2USLJgiliVzsiWCq+ne9Q==
X-Received: by 2002:a37:4b49:: with SMTP id y70mr20068157qka.447.1566231419819;
        Mon, 19 Aug 2019 09:16:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n14sm7086078qkk.75.2019.08.19.09.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 09:16:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzkL4-0007Uk-NR; Mon, 19 Aug 2019 13:16:58 -0300
Date:   Mon, 19 Aug 2019 13:16:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
Message-ID: <20190819161658.GJ5058@ziepe.ca>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
 <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
 <20190819151722.GG5080@mellanox.com>
 <ad0d3211-bf70-d349-7e14-e4b515bb3e98@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0d3211-bf70-d349-7e14-e4b515bb3e98@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 08:45:58AM -0700, Bart Van Assche wrote:
> On 8/19/19 8:17 AM, Jason Gunthorpe wrote:
> > On Mon, Aug 19, 2019 at 08:11:21AM -0700, Bart Van Assche wrote:
> > > Does uniqueness of the I/O controller GUID only matter in InfiniBand
> > > networks or does it also matter in other RDMA networks?
> > > 
> > > How about using 0 as default value for the srpt_service_guid in RoCE
> > > networks?
> > 
> > How does SRP connection management even work on RoCE?? The CM MADs
> > still carry a service_id? How do the sides exchange the service ID to
> > start the connection? Or is it ultimately overriden in the CM to use
> > an IP port based service ID?
> 
> The ib_srpt kernel driver would have to set id_ext to a unique value if
> srpt_service_guid would be zero since the SRP initiator kernel driver uses
> the IOC GUID + id_ext + initiator_ext combination in its connection
> uniqueness check (srp_conn_unique()).

Sounds like you should just generate something random for RDMA/CM mode ?

Still a bit confused how this is usable though if the initiating side
needs the service ID?

Jason
