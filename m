Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29CBE8DE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfIYXVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 19:21:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33512 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfIYXVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 19:21:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so387493pls.0;
        Wed, 25 Sep 2019 16:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CR1upOW5xX2pAn3Jha6f7K7kAFms+iBvfxg1E7L5y+M=;
        b=XQgM4h9wJaviNhDAQ5a+Gu4R6tdkBuc/f1MUDvhogr8OGkgtui+OmSRfocMjcH/FPz
         O0zoOlgbCyjB/1IEhA4GJtfDoJTw30zPpZzedHx+y17lc1Yv8yuLRpUuVEzzXN8EnlRG
         JMjJmltJv0DzT0hJSEYpS2OmbP4v2a7NSxrZKSHa2hjuV5lN3NO5JBBN0bapxWjK21co
         9zEThMw4pyzL3FaLMvDAyv7tEspPtPXMdnZ8XwtANliRtSOlvAQjwPi/lAcdyB8QrN/9
         bv8eHaS2MHxa2xxeB4bynnTLrFNQq1mq49iwA29iQ6AMJKeGB3pMDJQYfzoUxn+Echur
         dC5A==
X-Gm-Message-State: APjAAAVSckZ+R3RUkurGTDoc03aa2uJ27bfNG5eJyVqOBd3KcOKwbosO
        aDSFOKq63FzToE7o7YIaxTb9C9Ea
X-Google-Smtp-Source: APXvYqyLy+zVh8unk5dCItnDuZ5ST75cAe2lKEzr8R/FBPxJcSX4ogA1naBfqTHF0qgpTrMfW7jVWg==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr640563plb.326.1569453672421;
        Wed, 25 Sep 2019 16:21:12 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s141sm108635pfs.13.2019.09.25.16.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 16:21:11 -0700 (PDT)
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org>
 <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
 <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
 <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
 <CAHg0Huzuw=O2CJvUGJYO0whUE6tx34iPm7ScWRn-uRafRYp5aQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <aad75dc9-1503-3c32-5d69-2180d8abe3f7@acm.org>
Date:   Wed, 25 Sep 2019 16:21:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0Huzuw=O2CJvUGJYO0whUE6tx34iPm7ScWRn-uRafRYp5aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/19 3:53 PM, Danil Kipnis wrote:
> Oh, you mean we just need stub functions for those, so that nobody
> steps on a null?

What I meant is that the memory that is backing a device must not be 
freed until the reference count of a device has dropped to zero. If a 
struct device is embedded in a larger structure that means signaling a 
completion from inside the release function (ibtrs_clt_dev_release()) 
and not freeing the struct device memory (kfree(clt) in free_clt()) 
before that completion has been triggered.

Bart.

