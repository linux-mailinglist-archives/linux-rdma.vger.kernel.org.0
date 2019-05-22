Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0898B26398
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfEVMPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 08:15:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33045 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVMPQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 08:15:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so2009789qtf.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9a+tzyr4S1aJenlOnUpsJAbd1rTle8vX8PhNM/blL7E=;
        b=Ejh/4aCIBqTf5uTvGb9dGrRzBXFZb/vn39w81HbBS7k4QqiMFEO/3dtbcsdMVrO1Wq
         HqgmWCa9M6SrzPzo6t8qSIEp9CZ3YP6hryuff5NLBWFrDnQWADu6tk76jAr2OUr2lQhZ
         W2gxMG0EIJwsAz+yMhEHwu6fUvRB253KgfRGLvUsZxN3KXHvnbtrN9YIA6ATIkWgqTc2
         qhyVlkUrqNjbdwJcEwjZeZnNbkgkIyAuq3kEFC3yia6Qrz6IhA6TWupDoWAbsZ2ZRckd
         6H/1EJbIlz2HXSKZmm1tPWFxAr6rz536qTWUzImnrFwTeLs7GddGD4yPBo5sYGSfbVry
         5OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9a+tzyr4S1aJenlOnUpsJAbd1rTle8vX8PhNM/blL7E=;
        b=ac1hdX5CmP7axYjGvo4tmR+S5qQBHZeTctdvjlTqYXtQJ0nXTn1h0HIGsnBKkTUzyR
         4oJKy2anltTPs3loAbb352QnA9bFfu+MycHmKR4yypvD5z63TeqtYQBtYPNMUi4Nk0mo
         JH8pdK4YnhRqnyZeFnkmZfCsHVlZeLeY+O67TZcW8MJ85D44N+KArRGEyoJHE6tHJfv4
         tsc4FEexSkZzBylZStP7Sw4U1jp6FCrxaJQEzb/DJZuzfDBjJaayP84mpuBIKfpOsFTz
         9/J5EF72nPD6Nq9wNUyXKktY6LD72XlXuZSDLnoQCiHzbZYo7E5iopFF1iWhamog8CSf
         BMVQ==
X-Gm-Message-State: APjAAAUFuHS3GLhP3s3cOYRmFITG8X6z9uxtVReOHJB/t8tmrqrhpmRW
        8QMbV/5F2nFnPOG3eGACbXW12A==
X-Google-Smtp-Source: APXvYqw3WomO6ITcyer6CPVBrQOOsY0Cg2Qgn6CsKn9Y9UICWMLSuX+MNtWFyKg83O+U0l1X7rMqug==
X-Received: by 2002:a0c:d215:: with SMTP id m21mr71181172qvh.202.1558527315440;
        Wed, 22 May 2019 05:15:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id u26sm12960356qtc.84.2019.05.22.05.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 05:15:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTQ9J-0001lW-Lz; Wed, 22 May 2019 09:15:13 -0300
Date:   Wed, 22 May 2019 09:15:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/core: Avoid panic when port_data isn't
 initialized
Message-ID: <20190522121513.GA6054@ziepe.ca>
References: <20190522072340.9042-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522072340.9042-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 10:23:40AM +0300, Kamal Heib wrote:
> A panic could occur when calling ib_device_release() and port_data
> isn't initialized, To avoid that a check was added to verify that
> port_data isn't NULL.

This is a terrible commit message, describe the case that causes this.

The check should be in ib_device_release(), not in the functions.

Jason
