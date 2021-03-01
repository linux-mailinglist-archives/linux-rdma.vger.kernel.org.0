Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B643282C6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhCAPq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 10:46:59 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:40875 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhCAPq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 10:46:57 -0500
Received: by mail-pg1-f174.google.com with SMTP id b21so11847799pgk.7
        for <linux-rdma@vger.kernel.org>; Mon, 01 Mar 2021 07:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l/47HLZ9kB5qhhy0TijRh8azNdiUxXzaVjJzTUsta28=;
        b=q1Lj1QlqQW7MwHJ9wVnZeiHChrGHF97Td2GzXaQkQnv7WfaAt/5w62b8fV+BDC4rvl
         4apflG4AhosnIXko0haqj5QVTFp6G+nUKj89h9ilQ4uPHjpzcYerhZWLvfvOXO94tN/A
         +F+USRMuz/+5YHi7f5MFT96jdH6sE1JKr/xIQHM6Pv4oMGLZZscF94lbHteABvXwSSif
         OFLqL2jIkOq+skOrUIZOhECv2Pi1HskOj7VuhGP9feChUAx+paGub84riQI734FdTJh0
         E8JUQyBiqkyNuujpGEiqEHBVBGTseCtQz5kbilmMWYrSw3QjKLRq4qsWurfNblQtWxkR
         nOoQ==
X-Gm-Message-State: AOAM533rD2RfwFJOboR7p93/zhAzRNgkV9Ut4z/vA8oXyC2mF8/BfvBP
        MgGg4IbOn5zaDg41+YE8JLM=
X-Google-Smtp-Source: ABdhPJz7PilpAflKfQBKQlQr5Q9Q8EKFM0yiKHRZa+UPGmrNKc8JLzAYNaHyeSWTJytLGXL2IBdY0A==
X-Received: by 2002:a62:7644:0:b029:1ee:b7ed:6391 with SMTP id r65-20020a6276440000b02901eeb7ed6391mr3085632pfc.17.1614613573140;
        Mon, 01 Mar 2021 07:46:13 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h186sm17222814pgc.38.2021.03.01.07.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 07:46:12 -0800 (PST)
Subject: Re: Regression in rdma_rxe driver?
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <7aabe495-e844-df77-05ff-491f53963816@acm.org>
 <CAD=hENdFO_mf_Ksxikev=qiHZLYM+tbU4FtbG=FvJCcQA+0W4Q@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1388ddf5-1c71-d82d-3966-09e452a98b35@acm.org>
Date:   Mon, 1 Mar 2021 07:46:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENdFO_mf_Ksxikev=qiHZLYM+tbU4FtbG=FvJCcQA+0W4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/28/21 10:01 PM, Zhu Yanjun wrote:
> On Mon, Mar 1, 2021 at 6:52 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> If I run the following command:
>>
>> (cd ~bart/software/blktests && ./check -q srp/001)
> 
> Can you show me how to reproduce this problem in my host?
> I am interested in this problem. Thanks a lot.

The blktests repository is available at 
https://github.com/osandov/blktests. You will also need the following 
patch: 
https://lore.kernel.org/linux-block/20210228223403.21685-1-bvanassche@acm.org/T/#u

Bart.
