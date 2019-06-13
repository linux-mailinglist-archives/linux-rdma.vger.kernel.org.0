Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE64499C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfFMRX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 13:23:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41552 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbfFMRX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 13:23:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so13259020qkk.8
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GtpmeeTFCKpP6HQrilI3kSYLuVspQkmTP/uXeNzDQjo=;
        b=mT3F8J6NfzNTEEhWSzulXpOJYe2i9a0RuYZvLuz89rToDUw0iEhW0InNtPGdnBkhEK
         a+fiz8/aGS3ScKPNTOnoa0O0W9uViAdjElZYNdW8hJ20W86p4yu5MHDIwLYNA+3NZFlE
         GWNAlGdtPHRDhR7qREYLPpVVnpoR+1+ZhlssyM9eVdLnXX3y7kTm4BczGnYMLnfHl5w9
         OOGeasLQVks3ncSG3fiA0BebO5QmTQCYiJqfzK2Bo5DAZNiq4C+96flUcbb7TS89+dEx
         sK70TNR+KyjjryqnWboE0bAIloRYVP/5IZf7v0CT5LhsIhplTS5AQ0j0+4Vt8hh1bY+c
         bp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GtpmeeTFCKpP6HQrilI3kSYLuVspQkmTP/uXeNzDQjo=;
        b=iVu96lXthAd5GZ7AxObT6Cozb7I+OBFSCx7Q3Y4LRysRZX9lik246OpoS4FCK/PQbC
         sxjrj/47DqT4jSkiqkU+4wAhCPsTzWlWL0g+vi2lDlbOCyrgMSyI/Bh8pgjYQT73B8+P
         v+B0JEZIi9nclQZd8XWM2StOXhKGHb50dvc7i1siMLyi/4kIt48FewpaMzBVJWAOOlMu
         KwZ71v76UQFHAYU1qOFcRcX8VXBvXN+/nFOykpxRpWty3v+iXAVfCl/eCJrDq3imJxO2
         TDR+q8IKsLAzEJxWgHxzqQ13FMTx534zARL82O5pr1n0yHH/yvQBbkoOtLaFPAYmjZaR
         T6Yg==
X-Gm-Message-State: APjAAAWs8fsnmGDp9qRdddjtcolLeOgaYw14tEkWUkCaFXd0HMKFL5Ie
        0iNZWtfSp70Y6e454Z+Fdp6l+w==
X-Google-Smtp-Source: APXvYqzLKXkhxqXNZBleEounkqFk8bLp5EAxXSPu8B/UrrQMyawGw3NOTt9zo5Plivrl2Y2xtYnMkA==
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr72445088qkl.173.1560446636313;
        Thu, 13 Jun 2019 10:23:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c4sm98515qkd.24.2019.06.13.10.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 10:23:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbTS7-00034X-97; Thu, 13 Jun 2019 14:23:55 -0300
Date:   Thu, 13 Jun 2019 14:23:55 -0300
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
Message-ID: <20190613172355.GF22901@ziepe.ca>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
 <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 06:58:30PM +0200, Håkon Bugge wrote:

> If you refer to the backlog parameter in rdma_listen(), I cannot see
> it being used at all for IB.
> 
> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
> UD receive queue length for the PF driver that can be construed as a
> backlog. 

No, in IB you can drop UD packets if your RQ is full - so the proxy RQ
is really part of the overall RQ on QP1.

The backlog starts once packets are taken off the RQ and begin the
connection accept processing.

> Customer configures #VMs and different workload may lead to way
> different number of CM connections. The proxying of MAD packet
> through the PF driver has a finite packet rate. With 64 VMs, 10.000
> QPs on each, all going down due to a switch failing or similar, you
> have 640.000 DREQs to be sent, and with the finite packet rate of MA
> packets through the PF, this takes more than the current CM
> timeout. And then you re-transmit and increase the burden of the PF
> proxying.

I feel like the performance of all this proxying is too low to support
such a large work load :(

Can it be improved?

Jason
