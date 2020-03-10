Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1160C180077
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCJOmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 10:42:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43487 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgCJOmq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 10:42:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so4713316qtv.10
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQyY4c0hJ2HYnXdvp2Ph/3HHChOtQu/WPwEIWCi1ILI=;
        b=Yio6eNCOA3ivDrIhG+yRBY8au5Wy1n4lBASht/sEpu9ga9bd4lw10ZuK8PCL5MaVqt
         6aVTCx35OKqBHkzyBBf+Cj1lvIgviJXgXBXHThEp6M+qCyBpF8ZND2SFQzkLf/6xbkF0
         2kLKRxUV7JZbTcCHpf+7GH4P/qy21+nXJZwdGmUh370NHoFuo86lOMddUgZNzRxrmZ+C
         wX9s7RBWQWHpAThc/RFKJl326KFyJvlWuuct8bFvfhPu5DwoXqOVFUeUxv2egoZlkG4z
         38X3Es2n4dvXFe3fGKhtMvGtZA60NL8h2yBi1kVWelMaFXm2IX+2sEPR0t4ZyzHHuCA+
         2oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQyY4c0hJ2HYnXdvp2Ph/3HHChOtQu/WPwEIWCi1ILI=;
        b=L6pFDtkLpV+ovN6my1Rh50mBKPrrBfoKMYMWFxQ1gAbiqkc+YL16r+5VsFmipdqA8n
         0l665wfvjAkuKiR0FDhR7ZsAL6DJre/GeIqiD+Y9BF61gf5heMnT6Nka8HI378SE/nJo
         KsUWptwTwnYPsgLlbFaIzAF5QRWYrNn66Sv5+CDzplPNMmz6qpTGYRcV5lWyj667/ZDz
         mov4BSEjJ8JL0vUNDXq+ohXSDtTtw5rmQlc3I2cDNgF395M0II1HHn8bLb+5Yyd3aOpk
         mKUcOOPvV2RqhXNT/gxfp6HT5zCMk1EebarGdzwYAYIS/4jIv9SaRpexflmHkjAszD0h
         WqHg==
X-Gm-Message-State: ANhLgQ23ZlRHXxh2YKxFTyRjfYeDVM7em8Y6EfuFpt+35YcgLaGKv1f4
        86dhU/EQbc5kBfsKnZ3xTzJe/w==
X-Google-Smtp-Source: ADFU+vvUkm6htZ0jMeMtJS/0/7NHxcQqMuc+mXyh1/68r7nH2aNsGJ5Kx8oVh7SYzqik7Fs4qj+LJg==
X-Received: by 2002:ac8:6659:: with SMTP id j25mr13075218qtp.358.1583851364916;
        Tue, 10 Mar 2020 07:42:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i11sm10264159qka.92.2020.03.10.07.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 07:42:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBg5j-0002Qw-LK; Tue, 10 Mar 2020 11:42:43 -0300
Date:   Tue, 10 Mar 2020 11:42:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 0/5] RDMA/hns: Refactor wqe related codes
Message-ID: <20200310144243.GZ31668@ziepe.ca>
References: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
 <9221956f-cbbb-213d-9031-2ca7e9b9f7d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9221956f-cbbb-213d-9031-2ca7e9b9f7d4@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 08:53:22PM +0800, Weihang Li wrote:
> Hi Jason,
> 
> Sorry, I didn't notice that the first three patches of this series had
> been applied to you for-next branch, so I sent this new version. Need
> I resend the last two patches in a new series?

Oh, something got out of sorts, I did not intend to push those four
patches, I will drop them an this v3 will supersede and the 'minimum
depth of qp to 0' should be resent with comments addressed.

Jason
