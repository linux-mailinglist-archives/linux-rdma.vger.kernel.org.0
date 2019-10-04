Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF0CC2C3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfJDSgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:36:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38923 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfJDSgh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:36:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so6723822qki.6
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vKnDsCYGZlDvFRjAn5od7fTwS4TxXouKqRSBFtho6T0=;
        b=a2UoJ+oYicEjda6s+QqqKvqsW5B8EZip8I4mP0O2ThGvMvX2zXZQMth3/dKBMdpszG
         f/Mp30OxuJsk8gcYbpQUFeaJm2qiO/CXfeEKW5Xrw22apkcZNA9eVdmlHaEIrXVAdB1E
         YCySRy7wIOnAa+GHav42ySmpIdXjtqr9n4WcucYwld8y61YPzGReQqgZB3j7OMd0FOPz
         wWwhgMYo5TbHua9LvxR9M+jRaSxY+R3p2Iu3Z8Jqgt/gimkaB5z/HQao7YsOzIeykwvy
         Vo/hV86M+82wg2I+tkQP4kg7qpRP+RhxwIukKBPJAfRJZEw53n0RDyhlbagEzzz/ZYdT
         v4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKnDsCYGZlDvFRjAn5od7fTwS4TxXouKqRSBFtho6T0=;
        b=Tl0PaF0xfYNkYJtgIedLv6I7NWi16vg0VTcCGNuASvopPXWp2sZkNNG68S4sfBbSzR
         5tWPZdEqUqeAR4PGPHmr+RBRlKLdVy3Ud5cJr0/yUAb7UKYdRVmhjQDBSm6Rv41xJWQH
         l+7uBAQcbLwy1M18Flv1PVaBEb9WUNaV+9Lt3+kheILYEv6emUB/VXaSSzsG1p+M1tRt
         6UQYpNWBI0/1IxzGmWiQ5rxBRut96e+OnhVbai5bMTwWa86pb2rW6wu4Z+RMcFHDHJwA
         OCiM1+lFIXME4bBKZjTAh0lplHZGWNoXit2Ud96w4NFOKeAvggnezKhVdVksAUInwwbx
         gbBQ==
X-Gm-Message-State: APjAAAV8e2gGJKCOIM0eg1G8OApsO901v1AXREau4BoLoFTSJhF/CGWo
        kGqjMTt+ISWN980b6eK08ao/Pw==
X-Google-Smtp-Source: APXvYqwyZCndnhxGxQFyHSPqAfLaz0mJ+iurtFy4mteioyOQwXsqXr/u8EhGvtEOV3F9ze2/xeLDZQ==
X-Received: by 2002:ae9:ef53:: with SMTP id d80mr11828532qkg.33.1570214196315;
        Fri, 04 Oct 2019 11:36:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id e7sm3044490qtb.94.2019.10.04.11.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:36:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGSRP-0001CN-7V; Fri, 04 Oct 2019 15:36:35 -0300
Date:   Fri, 4 Oct 2019 15:36:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/15] RDMA patches for kernel v5.5
Message-ID: <20191004183635.GA4533@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 04:16:52PM -0700, Bart Van Assche wrote:
> Hi Jason,
> 
> This patch series includes my pending RDMA kernel patches. Please consider
> these for inclusion in Linux kernel v5.5.
> 
> Thanks,
> 
> Bart.
>
> Bart Van Assche (15):
>
>   RDMA/siw: Make node GUIDs valid EUI-64 identifiers
>   RDMA/srp: Remove two casts
>   RDMA/srp: Honor the max_send_sge device attribute
>   RDMA/srp: Make route resolving error messages more informative
>   RDMA/srpt: Fix handling of SR-IOV and iWARP ports
>   RDMA/srpt: Fix handling of iWARP logins
>   RDMA/srpt: Improve a debug message
>   RDMA/srpt: Rework the approach for closing an RDMA channel
>   RDMA/srpt: Rework the code that waits until an RDMA port is no longer
>     in use
>   RDMA/srpt: Make the code for handling port identities more systematic
>   RDMA/srpt: Postpone HCA removal until after configfs directory removal

These are applied to for-next, thanks

Jason
