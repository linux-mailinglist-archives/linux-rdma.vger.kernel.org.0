Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBB188E3C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQTpl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:45:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33428 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTpl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 15:45:41 -0400
Received: by mail-qk1-f172.google.com with SMTP id q17so10046714qki.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OBHqt/oiacJbNQTZit4nDVmQSDWjq4VWdwYGLRzYJAM=;
        b=bjPm9Yaxqe5tQV4lclQUvUK/5+bxOrruho6C1QTawPzaEV0pTrqnUZIGmoAu/wpK4K
         uVZ68JWDZ4+7hmbm7pXXcr2kwEe0IijkpRGlWyyC/kG+pP2JkKfs6mXIVdzXsXJ8iyxE
         eONX3B772lUHnTkjvUUdNBb21VphNnZ3XE5/Ff2Ff/WJxQty3Wol2oWN1S4/ywKGJf7a
         1YqTSGstfOiECie804MuFLlCYgNZvW1oY8vEnqLB1kpXeoOS3LGV60tVhbZ1e6V1d4VO
         iJ9kFqIWLD3fMlf/r10WcypIsj1v8eGmTNL6/Cnhz+yQ39BCemXvYlHoyVi7dQs/PkuF
         WdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OBHqt/oiacJbNQTZit4nDVmQSDWjq4VWdwYGLRzYJAM=;
        b=PoUtefX7LiJX01NO+xWNZDqm/q3A022NK4ndqpnZhpzZkBdblmAXXcKS92M9Hp0sJA
         zvoUjGKcXKcKBHGUOfNDMtcsHb2eZaw5FlWgBhrafSvJLPITkufJKnp1mpWvnOnhRnb9
         0sjGvRG6FBbkSGJxdFFePJtB4ZWJ4StUE3EkraoGy2YVrXnvbelQ2GhLkYSJ9IxfwWY0
         WUP0tOq7xTUuir124w9jhVGtTDNsVaRcW0ul4JdSo742hLArtdBKfOZcgtl8kxBNqlq+
         O+HW2HKlehsQp774rrE/PeyJHrs54KiUI4891gdv+32VjttKSWezf8gndNRo5P23xq6u
         Z1sg==
X-Gm-Message-State: ANhLgQ0jKVGkas3D4HOlkaMTYDKiKpzxNx2WjqffDe2JISp58UKhZwSC
        dRI2hljWOhoTpoxMApyJ4ldk194TPzdbvg==
X-Google-Smtp-Source: ADFU+vuvvPepH6PpNfuKoL4wBwY8KMns2xlVNswhEduNj10Q10yuduYw4+lT/FoLzkMdLn0u8Trkug==
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr522756qki.367.1584474340198;
        Tue, 17 Mar 2020 12:45:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d141sm2578972qke.68.2020.03.17.12.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 12:45:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEI9j-00023I-15; Tue, 17 Mar 2020 16:45:39 -0300
Date:   Tue, 17 Mar 2020 16:45:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ju-Hyoung Lee <juhlee@microsoft.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Find rdma-core version
Message-ID: <20200317194539.GW20941@ziepe.ca>
References: <BYAPR21MB1223A416AA7FE380D8DDFFC9DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1223A416AA7FE380D8DDFFC9DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 05:23:28AM +0000, Ju-Hyoung Lee wrote:
> Hi,
> 
> Can anyone help me find what rdma-core version I installed in the
> system? It's a set of lib and utilities, but there might be a way I
> can verify the version after the official release installation.  Any
> help?

$ ldd `which ibv_devinfo`
	linux-vdso.so.1 (0x00007ffc63bd6000)
	libibverbs.so.1 => /lib64/libibverbs.so.1 (0x00007f3de67c4000)
[..]

$ ls -l /lib64/libibverbs.so.1
lrwxrwxrwx 1 root root 22 Mar  6 19:43 /lib64/libibverbs.so.1 -> libibverbs.so.1.7.27.0*
                                                                                  ^^^^

rdma-core version is 27

Jason
