Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337CF198CE2
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCaHXf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 03:23:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42847 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaHXe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 03:23:34 -0400
Received: by mail-il1-f193.google.com with SMTP id f16so18430847ilj.9
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYmhvetgwgJB3/SNAs9Ay4+GNdd0buNQ8ScCdL5qIAo=;
        b=NhH9Aqnwn/jz9n5nmhhg5FmBCES9+80n1eqtkI4oil9+I157ZCyWonmXousXTYXiec
         omrLkGkVIJDzsGte9wa+X1iCcmPQb+ekIWwnl3o8pR9jqYfH/7W0DGAmfG/1fLnEt+WT
         GBxOr3oPH2faNZh7vAeR4aZf5Tun1GU9IRErfuzw3NhyjxT7rPMxao3YQE+9ILjz3mRN
         UBu/L2VkTdzZC5AGHbcQlp6E+ahLF1lkNTokNwxrIs2/6sKsHdxnAel/kSgs80jOODMW
         pYrxOKsv56J8TQtn/Gxq7Cg0J4dC+UtSLAUsM1WtHf7JnQFcM2rEfhNsGrWpJ9aa1c3c
         0NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYmhvetgwgJB3/SNAs9Ay4+GNdd0buNQ8ScCdL5qIAo=;
        b=P97HidJeNyTWYzY9B7j5Axdzq9MNUZh51Zw+0aIwQW9jqCIvaSn1KWlLjf60jZwm4B
         UIxfABuG94gQcarT481Zb4mJzUh5pX754ACqtaMf5rnX/BhyTxAp4sJ9APtwvqA/3qQa
         A5kgh/lXDQtB5lqMKkveg8i0/XtspVh67K1OuTsxXLT6LScxY5d4+Tv1f/N/RATrItSx
         iDVLW0DPVD5DrVUF3Y6LqRV9lvKCx84uRQNZ5fVWoSUhumcJsXPUZnfX6+mr/BCvA5xg
         hNGuhRTfTywOtGDwP0EJvXqU/rJcojO27pps+NTwLrVv4ftgLDOswdc/TMZ0r6aRgDTj
         hD0A==
X-Gm-Message-State: ANhLgQ18IVHTLsN9Gfaq3KulRj3pDEhAyssaY0A6wRTCCItdnEp7sjLR
        uvMt4PMarONZ+mQBP6izieGorVRudRtjvCav8y4VrA==
X-Google-Smtp-Source: ADFU+vviX+IfrrdYTDhxf766mcWvYHTwA5u5Bqq+BCi0GBesPQ5JpHC7+tlOjcPdC2VP5OHwNQf7J5yyBB0Xp2sXbU0=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr14705790ili.217.1585639412583;
 Tue, 31 Mar 2020 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-25-jinpu.wang@cloud.ionos.com> <181aba74-b942-2faf-060b-89782c8f804e@acm.org>
In-Reply-To: <181aba74-b942-2faf-060b-89782c8f804e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:23:21 +0200
Message-ID: <CAMGffEnRZE-GBd8CwOsfY1YRq=fYzaX-2f+zHpy3CapZCAgfKw@mail.gmail.com>
Subject: Re: [PATCH v11 24/26] block/rnbd: include client and server modules
 into kernel compilation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 8:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > Add rnbd Makefile, Kconfig and also corresponding lines into upper
> > block layer files.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
