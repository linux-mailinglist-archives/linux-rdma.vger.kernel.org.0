Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE9CC2EB
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfJDStQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:49:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40975 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDStP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:49:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so6727966qkg.8
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pb24NDt8PAjy3SoKTAvSXbXneneDVCO9Xx3fs5kMOeY=;
        b=oWXqHADv9RUzh3dwQwHW3BEDZRfuef/JDL6F/JxUoW33N95ZLpMIG/13IDOz9/JzX7
         7WYH9AN2ZDH+nRQ1vsRxnXpZD8UTsmRsoMkMaJVQY+NDPzAZK1vWjDsvyBMpa0DIoUCs
         q5gThucwhOoVbGuQIFgPyO6xhkYAh3BWREjaai+9msP19vDsk8F33430U8yyi0/Ql0Ci
         hLhXznoWdSyU6Az9NIBNW4e7CacxkGL8EwC7efWNASYsBTmGMNkait2AbhUpO8zUdZgX
         EAe/DdKKrcUfrGki/tdF4Kjd1cNiE7trWR3PCNHhm5DrbMScjIYksXZOzUMsGk0/niIk
         j80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pb24NDt8PAjy3SoKTAvSXbXneneDVCO9Xx3fs5kMOeY=;
        b=Qt5HJDULY4WrQ5wujwXrNjzToQc7UqPWcm4aX6mwgf6IiFAWfj4toWIvffG1/s/yFV
         W5bg1Ofqn6E6f85OpQZZ2cS1qRUp64vtfyvtiWCSEIXKK+frzgXyXIKQx7NQT4sUlH8a
         ZW1NxO0YBOo8VPFJuTPMF8oAksObnpmeg4tCrDZHnM4PA4b1otw6i3mWk7qM0a/Rl/e+
         cERbqnqQ+DMzX5P+nN6uIbbhbW4Y1xJqcVEHYiUMRO+vvpn3vJPRpkMYF+HOKgFT9g94
         tgrfIZf0C7PIe6RZ5LDlRUkeCCoXjHoveGd3c8GfJ4McsfbNbVxGp/qb91ScdcU55qRQ
         nlEA==
X-Gm-Message-State: APjAAAUrJ0AUiBxYBwXL05x2R3bcHL2Pt1MHGjdBT3iT76D4BKEtFrSn
        j1RtrxEL3R1lqMMK5Fcjfo/6xw==
X-Google-Smtp-Source: APXvYqxnz4oPJ76FyiMvNsuAxPI8x5Eu6I4wJ7mUwa6xIUZlqDpKiguapeO8hJzj4KWcxFeQ90zoIQ==
X-Received: by 2002:a37:6555:: with SMTP id z82mr9161490qkb.198.1570214954731;
        Fri, 04 Oct 2019 11:49:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m19sm3302430qke.22.2019.10.04.11.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:49:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGSdd-0001jp-TZ; Fri, 04 Oct 2019 15:49:13 -0300
Date:   Fri, 4 Oct 2019 15:49:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next 0/4] Unrelated code cleanups
Message-ID: <20191004184913.GA6622@ziepe.ca>
References: <20191002122517.17721-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002122517.17721-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 03:25:13PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> Various code cleanups.
> 
> Thanks
> 
> Erez Alfasi (2):
>   IB/mlx5: Remove unnecessary return statement
>   IB/mlx5: Remove unnecessary else statement
> 
> Leon Romanovsky (1):
>   RDMA/mlx5: Group boolean parameters to take less space
> 
> Parav Pandit (1):
>   IB/cm: Use container_of() instead of typecast

Applied to for-next, thanks

Jason
