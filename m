Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA4198964
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 03:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgCaBHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 21:07:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42610 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgCaBHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 21:07:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so9546395pgs.9;
        Mon, 30 Mar 2020 18:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZhOw+cmsFZegzfDW5fDINEwsMjwUxjfPEvGqp7eI5u4=;
        b=bo5ZEfa9Nxm/Fx6IjrFKls3j31XopQ7j2KdR/RslF+/FzrvFKfNyoKdQt5zMTLf8wo
         dYMt2gS1N53NJQmGFn1OskJLB62NTkqENx05UauPOkBUI+wFhGkuBnkLX0xO6CrtGwMX
         nMX6zxzK7R5LvbIHiBKtroRnNKQGqnuEg0H6EqdKghvbBrqKAiQvbvvTsoJM1whg9bKB
         MJx8ge9CyZtKstluw2PvYae8P/aIfbizv15JHD7Ro86XLnFZmM1KlDD6TlzgnYeo+eN3
         VUS8MhPRxIAWX54CVUgeID43waS3G+CjT4C+YhFDrU+sbzCIfrp/w/mUFMUnjKn8Sryz
         AXmw==
X-Gm-Message-State: AGi0PuafC6oghmkh/9jb2828EMxgjiN0EWtbI8/3V0ZLTfp1E9aUPy4K
        om+FW2dJ0xriC11IIHUtwhc=
X-Google-Smtp-Source: APiQypJIdVuKuKZ7Aa3Vg7gQq1G9lVCm+lr+jCVHNNN8BOlt4XPlTODgILTRDlepSvF3t5O1Nic12A==
X-Received: by 2002:a62:7d4e:: with SMTP id y75mr1984803pfc.32.1585616836680;
        Mon, 30 Mar 2020 18:07:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b015:431e:549a:54d? ([2601:647:4802:9070:b015:431e:549a:54d])
        by smtp.gmail.com with ESMTPSA id a3sm600490pjq.36.2020.03.30.18.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 18:07:15 -0700 (PDT)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <82bbbdf2-cf61-d523-29e0-d756b7f208f4@grimberg.me>
Date:   Mon, 30 Mar 2020 18:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Can you try attached patch and see if it solves your issue?
>> WARNING: very lightly tested...
> 
> I have run our tests against this patch and it is working well for our
> "basic" testing as well. The test case that previously failed, now
> passes with this patch. So that's encouraging! Thanks for the quick
> response and quick patch.

Good to know..

> One question we had is regarding the hard coded header length: What
> happens if the initiator sends an extended CDB, like a WRITE32? Are
> there any concerns with an additional header segment (AHS)?

You are absolutely correct! t10-dif is broken with this patch as
32 byte cdb would break into two buffers which is not expected
by the target core...

I take back this patch, I guess we should keep contiguous allocation but
just make the recv wr such that the data is aligned for 16 bytes cdbs,
and for 32-byte cdbs we never support immediate data anyways...
