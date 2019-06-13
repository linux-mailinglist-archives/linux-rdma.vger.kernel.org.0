Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECB4504B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 01:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFMXqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 19:46:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39888 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfFMXqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 19:46:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so476607qta.6
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RgGAoG+EFMf//zammLV8SqiSMpUtRnVhf4DpaWCHX7A=;
        b=aWHGarpo0tIrRJnnHEvfX6dOp85DZ2yAXbWe98Gl1NCJG5FiDSUppC2+dI5ER7jYgw
         YsSgypAots/APmu4ggVN84azOxccssTNrejU4vMPnfIV1Yqcu8wgKKPXFGobIaPurl/c
         xtuA/tj/hPbjC7MKqxXRiA9dj8SNCLGjpJ51hSk7eI+7XeOqvTqtigoa5wCj964W53iz
         SY8ML6JU8pDFx8ASD0vTDJaxQUD+h3IpnITBK3xHeGW3cDRUV/sgMaTqZIi8ZikIlfG+
         Tl+RmI7ogX0qqxEJBSXZEENiSiYWVj3HxH9InOyRnOvAm0+DCx0VORB/VOkCv1xWMEtr
         L55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RgGAoG+EFMf//zammLV8SqiSMpUtRnVhf4DpaWCHX7A=;
        b=DAodP7nQUEydgw4TpRQoT0XLG7LPL2Yb9j5nKgbV5OJXZF4iEEEwOLEicWtrNyqgWB
         D8XsPHxEuLTHH0Q0b3WEeFkRPWd+piRLtFbAvhkUtYB+6enGiu6AkhLgWo0HhfDW5R7I
         l7X3vOoV0Jb6cvnighqKKR4HQgTntjXVMibghsZJJdu/krmcQUnGNrS5bOFnxU974no+
         Dkt2i3L8iriHnM0HYBM9HZy6ZDr5jpXOScgmrXDhlpU3KHis/jTrZzcJ0Pt0Tobw4EYS
         s12ULy38ZvOy3dgpoZ6s3xPZV1A/zYFuhWKN/eyxthr0dTDi+35yD9h4gMKWQ0u2I2VP
         W/ow==
X-Gm-Message-State: APjAAAWpbTf72jbNwWZBx9Ew5dajXSlxr9g2eFfO51J82hpHMwPDE7nc
        diYQmJfeBYXyYqdWlRmvJPpp0A==
X-Google-Smtp-Source: APXvYqy7v1SfVM+n642iOXecf/vv6RGRIGojTHovJbES5LjY20ZFEYPiWrYrOlaii9/jkMsM9sJAHg==
X-Received: by 2002:a0c:a902:: with SMTP id y2mr5720330qva.42.1560469594029;
        Thu, 13 Jun 2019 16:46:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h40sm996749qth.4.2019.06.13.16.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:46:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZQP-0001A4-11; Thu, 13 Jun 2019 20:46:33 -0300
Date:   Thu, 13 Jun 2019 20:46:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
Message-ID: <20190613234633.GL22901@ziepe.ca>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
 <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
 <20190613172355.GF22901@ziepe.ca>
 <1D8E6B14-3336-42B3-B572-596DD2183D89@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D8E6B14-3336-42B3-B572-596DD2183D89@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 07:39:24PM +0200, Håkon Bugge wrote:
> 
> 
> > On 13 Jun 2019, at 19:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Thu, Jun 13, 2019 at 06:58:30PM +0200, Håkon Bugge wrote:
> > 
> >> If you refer to the backlog parameter in rdma_listen(), I cannot see
> >> it being used at all for IB.
> >> 
> >> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
> >> UD receive queue length for the PF driver that can be construed as a
> >> backlog. 
> > 
> > No, in IB you can drop UD packets if your RQ is full - so the proxy RQ
> > is really part of the overall RQ on QP1.
> > 
> > The backlog starts once packets are taken off the RQ and begin the
> > connection accept processing.
> 
> Do think we say the same thing. If, incoming REQ processing is
> severly delayed, the backlog is #entries in the QP1 receive queue in
> the PF. I can call rdma_listen() with a backlog of a zillion, but it
> will not help.

backlog and queue depth are different things, we shouldn't confuse
them together..

Jason
