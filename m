Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0AB1248D6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 15:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLROAa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 09:00:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33044 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROAa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 09:00:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so2030648qto.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 06:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8mlTcD9JJWGFmmMnGPz99+HAB6gsfEzF6DjzgexZQbU=;
        b=pPEX35zLC6OHF3fRDrh7T//zm645aUDzK8SXgIwC+rVG6XNc5KyqxaWYQmWnWYtSE2
         VAIWF9PjY/lghCn/3BoBjMG8BvrWxG35RHZxjJwtr7jsmvEo8Xv8qZY6VV3+/JfJ5nVt
         g6+oUD/lC4f/bbHse4UKrG/X6TD2dQ8jpmoBTyv3HS9McnHrQgGNTmarpa9P+2NFUELB
         /jkhxjbuKfIgXYlIUQxCAXOvGrKymCnAGlfkYvrwKrl/WTVDCPKCwx7yobqZDU2NPX5D
         8df+iu0t+lHii81hmTZaCv/+pkYtYv/feuCByv40/KG7UNQaKVnQP+VaYdC3K+26KGyB
         VlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mlTcD9JJWGFmmMnGPz99+HAB6gsfEzF6DjzgexZQbU=;
        b=kntbhfIdqEIuXn57j7He/QuHKB5z86STptmzA2lQDzNR5tefePr+DBI79HgpzsCOwX
         Y9FYO8BRl+FU1ondiXkcu3/yuXrtKJ5Fz0v8Gbg8VTUszJRNx2MF55NkXOEOfatmXVO0
         a1tevOv+2zbIfqQ6CwiXBGh/JBzdcmFrPjt2OYIpCT7cOoaG6hGqw9yocw8PMox+/nqC
         4DoksPMzWaX52A91pz2+dzBTnsQy3RtNVI3vGC2PkfCSZIektOiFb5/TxbRB3FOaBGjc
         6iAo0gCk++r619ACmN1WGYz8QxefQN0h/c2Kdb1mNaS4kbM9npgcO+unJBJLCsIMxkUm
         VMTA==
X-Gm-Message-State: APjAAAW4Logvw7T56qX2FgsbMg+jIZ8msYJkIbgxXbNovi3HdOlwCnWE
        ne4SgTHzmihf6imCIfLD1BGRAw==
X-Google-Smtp-Source: APXvYqwQEpJBQC6s3iAtAkzdTZOh3tWN1B9kREztMd9Mu9vQY5BRu3PZKgAP5FoER6CiUnP5Pv1tjg==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr2173277qtq.371.1576677629319;
        Wed, 18 Dec 2019 06:00:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k35sm728623qte.96.2019.12.18.06.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 06:00:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ihZsI-0007vJ-PI; Wed, 18 Dec 2019 10:00:26 -0400
Date:   Wed, 18 Dec 2019 10:00:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 0/2] Fix crash due to sleepy mutex while
 holding lock in post_{send|recv|poll}
Message-ID: <20191218140026.GF17227@ziepe.ca>
References: <1574335200-34923-1-git-send-email-liuyixian@huawei.com>
 <c6d0f4bb-aca6-86f6-f909-d91ed9e58216@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d0f4bb-aca6-86f6-f909-d91ed9e58216@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 16, 2019 at 08:51:03PM +0800, Liuyixian (Eason) wrote:
> Hi Jason,
> 
> I want to make sure that is there any further comments on this patch set?

I still dislike it alot.

Jason
