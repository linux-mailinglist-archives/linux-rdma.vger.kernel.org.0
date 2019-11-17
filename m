Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965ABFFA51
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 15:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfKQOj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 09:39:26 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39816 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfKQOj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Nov 2019 09:39:26 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so5511099qvq.6
        for <linux-rdma@vger.kernel.org>; Sun, 17 Nov 2019 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cq5Ov1YK9vLmOZr3fVeR+/6ChvhhepiVxMeRQ1P/Qx4=;
        b=HynsQ1Gj4YX9qXLHkLUP1HZBgGgHX8LscoCbzVWEMdjnO6VubPie/ATcjQm0O/TY5X
         JzOYrgvQSNvMmDyUnOfaWCLk/w0xrNm2p9kzDsZ3lQpiG4wGigdjR0RoQ1L2DOGqNcOu
         WpsHRW3dKj5p6QHvTcXb/LRHYiCMJ2COC2E9d95bQplQbyZeP3y9KRI8SXmApBf4Rhvr
         XVRFNC8roaPibMEZ/+8uScjs/PKeJX+WX+DCWoqfrTRTTSgw6vHkhX474owKD5blTJS9
         p6Kt1DN4uDrIo+7H/e0zlRvhkC71ALdWp/vuUEzOQbAgdgZHNzJQfmzH/e4YEG3tkaqi
         ef5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cq5Ov1YK9vLmOZr3fVeR+/6ChvhhepiVxMeRQ1P/Qx4=;
        b=kkEAVZCnw8sQKTJ3iKvWYheYEFd7ZkfR0T5KInaMrdpEJi4eI4LK2yY1EbjG0IZ2Et
         gnqGpB2bj0mYgD8Y5A7R58mLVPdnLG1nMAoEHG8CdjhVJuk6oHT9QudLv7Dbkm6CTIsQ
         GeaM7ImAtPPUuGviIoyM15s7YyZrDVXkLzHCIA8a9wr25h+5xnHsnMThyIE21KJFn7sm
         3qE9puKVYBVFXg2zqcZliwFXKNUyGeS8w0+N1P8Vt+VV6XwtofhYQV7vg1m+3PXZwV/n
         dDJLMaAeskJs1/CzJyB5Vu95OofmdnrrL6eCV30jfHiSrQPhySbLtedn9hLxlHGaKEZq
         U4HA==
X-Gm-Message-State: APjAAAWPpNu5xKxJhpCZ9pk1FG5hquvdsBHJ3vp/Qn92kOIHkSKNhRB/
        t62Evdg75zqICunwgSMirdKxH80GYIQ=
X-Google-Smtp-Source: APXvYqy33BiJZvqVl/YsPkjxQZ3W9X8UygwmkdouxuAEZRcRA30MukHeNKrxySV6gsIEj72Ao7d4iQ==
X-Received: by 2002:a0c:9956:: with SMTP id i22mr22121740qvd.215.1574001565161;
        Sun, 17 Nov 2019 06:39:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q204sm7373013qke.39.2019.11.17.06.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Nov 2019 06:39:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iWLhz-0000xM-VL; Sun, 17 Nov 2019 10:39:23 -0400
Date:   Sun, 17 Nov 2019 10:39:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-rdma@vger.kernel.org
Subject: Re: Problem in for-next commit 6ffedfe3ae38 ("IB/umem: remove the
 dmasync argument to ib_umem_get")
Message-ID: <20191117143923.GA2149@ziepe.ca>
References: <1fda84d9-a4b7-4d3f-fec2-82344e1cb220@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fda84d9-a4b7-4d3f-fec2-82344e1cb220@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 17, 2019 at 04:30:30PM +0200, Gal Pressman wrote:
> FYI, looks like something got messed up in commit 6ffedfe3ae38 ("IB/umem: remove
> the dmasync argument to ib_umem_get"), it brings back the entire deleted
> iwch_provider.c file.

Ah, thanks git am flubbed, I fixed it up.

Jason
