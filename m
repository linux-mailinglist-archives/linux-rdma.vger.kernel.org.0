Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4472BF5E9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfIZP37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:29:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41188 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZP37 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:29:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so2034706pfh.8;
        Thu, 26 Sep 2019 08:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3136Hn68PJl1UpcDcWTT6DU//8E+QjLu7I91jxB67dU=;
        b=rX7ZDLmZmrMkwPtxyl5upRUcGjtRTd8kTBOkA8O6tHB3ULvU/h2uAHff7ZnbpH8OhR
         vAORLMsAhvTQx1fUCCt6GQq7+NO0Y08+7QjfUv6vBq3jVh3uN/Aozb/TSk/tAGsC8iDO
         /eWPFDXvwNunh8KN7+d1C/o5ZcnIeu09+/nBOd/2+rAdnJrbT3WGo6PVw1ydMkvSJYLY
         SOgL954z9tavBJqIu+d/IsL5NVgubza+JPU/g+Rtvebjs4uvryA8axa6F94utNiCGWLf
         DemCjQ2+Ne6PoCERIG0arp48tmnHPthPDMKAc07DiS3+Z9fOPFp9voJ+wdkoGPuT8nMU
         v9GA==
X-Gm-Message-State: APjAAAXZAWCRbvPJ2Pc/4ZOsaCOhT0F+3JK9i1LgI9CFohCdUPMQh8x5
        IUwecaCVXy4Cli9c9ogeuds=
X-Google-Smtp-Source: APXvYqy9+qQi5bwY4W/rhILB3fkfVIfYWOMEGqFaDEWnUg1W0QCEPTY7XWOXcRhT35COF/ha0cKVFQ==
X-Received: by 2002:a17:90a:210b:: with SMTP id a11mr4080391pje.23.1569511797498;
        Thu, 26 Sep 2019 08:29:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t68sm6450954pgt.61.2019.09.26.08.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:29:56 -0700 (PDT)
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org>
 <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
 <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org>
 <CAHg0HuwJJ3LmUwOOw2Uba0Zq_c9hwUyFBrao2nzpv4y97U1Mvg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <40f69402-5f38-c78b-8922-3a77babb4c6c@acm.org>
Date:   Thu, 26 Sep 2019 08:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuwJJ3LmUwOOw2Uba0Zq_c9hwUyFBrao2nzpv4y97U1Mvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/19 8:25 AM, Danil Kipnis wrote:
> On Thu, Sep 26, 2019 at 5:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>>> This looks really weird. Why to call ibnbd_dev_blk_open() first for file
>>>> I/O mode? Why to set dev->blk_open_flags to FMODE_READ in file I/O mode?
> 
> Bart, would it in your opinion be OK to drop the file_io support in
> IBNBD entirely? We implemented this feature in the beginning of the
> project to see whether it could be beneficial in some use cases, but
> never actually found any.

I think that's reasonable since the loop driver can be used to convert a 
file into a block device.

Bart.


