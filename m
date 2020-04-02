Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D239A19CCB5
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2020 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbgDBWRA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 18:17:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54487 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWRA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 18:17:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so5124113wmd.4;
        Thu, 02 Apr 2020 15:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GMAAF1z1HDrpyRd0Ju0XEsYC0WrWOpuIWNSFdw2NHFQ=;
        b=HyESLoDBBU3/sj7clsewJVzrebqgnSsjWcp+e354WYk8EPPfv82HgylYnGlu3igxH/
         dwubjS8hjabkvAO5+45mSWbUKjRzEV7dxDsTyLv5QIm4A/qkXPIsGYa9bZexyYxisFhb
         j+sta8Bi4Vgx1w1tlGO3EXgMDGAELhSGrCQ8NY/SX0oRryoDa4ni3WHZXqmJUR3FvXOX
         jiYedamA0tol1G0xnX+uT9RKLfQ5X0ULmk8OqlO/BWnEkRcYwTyqSyhNlgayTERcb157
         17nl0K/gn4ud881Sh1YVZpNDd1v72HOin1YT1z62gljT345fzbJqFEOLnhLVKmWUbMnQ
         lDWg==
X-Gm-Message-State: AGi0PuZ29cmsmJN/DfEmX4fMiJu3OFayMH/Vytg6Rw3FUG0ubt5Domgp
        jFmXrMYNcFQ9iJQtPt2v+iM=
X-Google-Smtp-Source: APiQypJxYdZHUHEdAKxNnoT93/Q4YYR7kkFS2HmhMw+028JCYZRHf6fQt1XBj/oalhRDin/42PQmLg==
X-Received: by 2002:a1c:9652:: with SMTP id y79mr5441978wmd.89.1585865818193;
        Thu, 02 Apr 2020 15:16:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9069:e334:a021:3782? ([2601:647:4802:9070:9069:e334:a021:3782])
        by smtp.gmail.com with ESMTPSA id z12sm9478177wrt.27.2020.04.02.15.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 15:16:57 -0700 (PDT)
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p>
 <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p>
 <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p>
 <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
 <CAAFE1beqFBQS_zVYEXFTD2qu8PAF9hBSW4j1k9ZD6MhU_gWg5Q@mail.gmail.com>
 <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
 <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
 <95750c05-eb49-d1db-311f-4edf9b4fd6ec@grimberg.me>
 <CAAFE1bcmFxb6MYbicUVdVsK6QNjweaow3v+vHe6szwfFN6K-=A@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1f6bc60e-7f2b-d959-f1ce-5055752e2323@grimberg.me>
Date:   Thu, 2 Apr 2020 15:16:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAFE1bcmFxb6MYbicUVdVsK6QNjweaow3v+vHe6szwfFN6K-=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi Sagi,
> 
>> Does the attached patch work for you?
> 
> This patch _does_ work for our tests. I see all the writes aligned to
> 512 bytes as, I think, would be expected. Thanks!

Good to hear, I'll wait for your further testing before submitting
it as a patch as I don't have resources to test this thoroughly
at the moment.

Thanks,
Sagi
