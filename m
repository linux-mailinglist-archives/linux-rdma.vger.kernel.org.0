Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E0172299
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 16:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgB0Pxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 10:53:38 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:42312 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgB0Pxh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 10:53:37 -0500
Received: by mail-qk1-f172.google.com with SMTP id o28so3559779qkj.9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EH0SNO5Rcc4XYOUSFVK7bK7rNzgEXpv0OLPCvUs1MKM=;
        b=PMtqoD+Qorl+adIp7K03I0mEvU1rioCUSaRdmWReGiwltATTH6RJtRscNq5iIqT9cY
         JSA9CN5t7cEAsNpiP/S+TdjCZcTKeZJ7h8ZLu9IL9vsnjmxAe95o1Ckuho0hdEY+xmNL
         CEMDj98AiR3AVKxOVA67huauMos3yZqp1HaKRkhsgTyCF1cBspSyrV/tJ29QVVd5jreq
         w1KuhoOK/p1h2CGmmtI3EtJOoNYVhOHIwcABWJUfIsCW9XUbZe25fZvxtRdPN6d4SWIp
         wAezUlU0JJj25Yv2HvrdtSeIUrtAoCBHpz/VsuoRmrD7sJUQdQ9hHwbfqYD5c3XQp6ND
         1fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EH0SNO5Rcc4XYOUSFVK7bK7rNzgEXpv0OLPCvUs1MKM=;
        b=BJy67aMmgMxwI0szuCfSoX3IERtN69w6R/VP/JR0ruaxGllAxSyjLipBu/sgqyR82C
         wqBQb4sY6swTjqZKcqNZmRHnmGj+VbowueYHAYZzBlr96ADttn8+ahMfrWFh+eoU1KuB
         UeHamAeVUtfSrU3rpRDiD4NzNzcSJSSC3DlTITrH7AFGiwpY9be0xcI8R8JJM0SkIDk2
         jhXsGenVNvoeq1giw5DrcHyhu/nwTx77dvmiT031FZ2fYYLbd3Mn6RWDeUWzk8A3FI9b
         JKfyYAbEooHfNYA9JrSJ81+7meBLYmiBMpM2GLJh2k3jCBNHIvVtiawhPxfgekcZkXv2
         q2nw==
X-Gm-Message-State: APjAAAUZUwNHekNwHZn18JjaS07gEgH79C/oW1AvheZz/4jiZPt6YM13
        zp800AxIQLtWJZebGxNmKCtwpg==
X-Google-Smtp-Source: APXvYqwdqVD1HKLQD9Dk+yGMQZm/xAmaIFr/8snWfVHM3u7MryqrGdgt6o3CYFD+XYsHevMncfcZeg==
X-Received: by 2002:ae9:ed06:: with SMTP id c6mr6871655qkg.7.1582818816659;
        Thu, 27 Feb 2020 07:53:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h12sm3241397qtn.56.2020.02.27.07.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 07:53:36 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7LTj-0005VV-D2; Thu, 27 Feb 2020 11:53:35 -0400
Date:   Thu, 27 Feb 2020 11:53:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     syzbot <syzbot+55de90ab5f44172b0c90@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: possible deadlock in cma_netdev_callback
Message-ID: <20200227155335.GI31668@ziepe.ca>
References: <20200226204238.GC31668@ziepe.ca>
 <000000000000153fac059f740693@google.com>
 <OF0B62EDE7.E13D40E8-ON0025851B.0037F560-0025851B.0037F56C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0B62EDE7.E13D40E8-ON0025851B.0037F560-0025851B.0037F56C@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 10:11:13AM +0000, Bernard Metzler wrote:

> Thanks for letting me know! Hmm, we cannot use RCU locks since
> we potentially sleep. One solution would be to create a list
> of matching interfaces while under lock, unlock and use that
> list for calling siw_listen_address() (which may sleep),
> right...?

Why do you need to iterate over addresses anyhow? Shouldn't the listen
just be done with the address the user gave and a BIND DEVICE to the
device siw is connected to?

Also that loop in siw_create looks wrong to me

Jason
