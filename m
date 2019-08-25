Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2CD9C5EA
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2019 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfHYTn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Aug 2019 15:43:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37979 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfHYTn4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Aug 2019 15:43:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so12542174qkh.5
        for <linux-rdma@vger.kernel.org>; Sun, 25 Aug 2019 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=an1FIlEKWSveTYRtKx/MAhX6QOyzHQ+HmT6tijG1CoU=;
        b=H/CtL92dRjtqaqTSw5ZV8yAF7wwnoMNJDw5+1G2x1xYVO4VZ5Axmeomj9wnZjYj0Bn
         DJeBgZKNZrSGGpP23n/5gmDTErHwMcxq5clo0Ka7OjcWbyx3iOt6rLhHo3VdBM6m3S4O
         4apWmmag+k9tSp9q0N0DJsKghleivIZcC/WUKJygWOpXdFRGdKFJ3A4QIseoaPzp1y+W
         bsrWpp8MBMSXrrwxjfswhTZkAi9WdFPRChIrnZhIveybUkuJpuwjopjVoUQEsc3BK4E4
         Ffmt6RjnN2yK8JXD1JU+T/ooXcfin6oBE6oKUEAYrCuKMc7sWB+JR7LXHyOxdun80blm
         c/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=an1FIlEKWSveTYRtKx/MAhX6QOyzHQ+HmT6tijG1CoU=;
        b=My4n352ODL0iVEaaXrhWH53lJp/lJ3eNwkw4OkqaltE26U2NZkYcRs6xnp6GciEn3Z
         bwlXc4Iznb0ihvrUd3cVpR2zbRjppWwI6VFa2Wdc6rhM1pOXEMNhdHtpUr3pVDGaYMcS
         mBFXlkMKgMuZQIccsYK3dpR+5lU5jWSdHtkN9y+vtRL3I11gxCnyHemnjg3ErorCm6FP
         5UJev2ZZa9iqXyfSjyai5ANQfJ+ENDkXfOnOQONyYmxwxYo+8vrXQJQZcP0zSqgst/KE
         Th/asKL64lFsKlwq7M2mCK+SMdWwxS5JmgN2fvAdE48cyczyUWrQ7UOWR/y67vk6QHEZ
         IXUw==
X-Gm-Message-State: APjAAAVwYE0Qd0fKNWC4oDXVXpmPNIOairvkDsNNxgdyqK4jdgGQvSeQ
        LmDor7wYYHarmZWYo5uYVl9tvg==
X-Google-Smtp-Source: APXvYqyeePQR7OY4N4F1qeJT/FsWbjdRPS6PWObROL9BhBIeseBdRAEdKEA0Qhs+v4zckxA/WT6gmg==
X-Received: by 2002:a37:680e:: with SMTP id d14mr13582652qkc.207.1566762234759;
        Sun, 25 Aug 2019 12:43:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id n62sm5439100qkd.124.2019.08.25.12.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2019 12:43:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1yQc-0005rq-1g; Sun, 25 Aug 2019 16:43:54 -0300
Date:   Sun, 25 Aug 2019 16:43:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
Message-ID: <20190825194354.GC21239@ziepe.ca>
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> First, length passed to mmap is checked explicitly against
> PAGE_SIZE.
> 
> Second, if vma->vm_pgoff is passed as non zero, it would return
> error. It appears like driver is expecting vma->vm_pgoff to
> be passed as 0 always.

? pg_off is not zero

Jason
