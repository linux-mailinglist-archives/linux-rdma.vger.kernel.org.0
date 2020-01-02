Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF612E8C6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgABQgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 11:36:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43916 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgABQgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 11:36:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so17990621pli.10;
        Thu, 02 Jan 2020 08:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F/bpBaStoBJx7wEMAMw9Q0zSpOG40c2sgoNWvrCquug=;
        b=I+n2Zj5dJ8PiY9bn9PnSumk+pnHhH/opPdMbH5iU4/peAHMB5fbRSzF6smE2aHkzin
         IU36fpP2HGw3LCZofAZei0/c/sbbcg5iUPxlZjt8Az+u7EUz99F1w7DQQ1dR7c+xCJ7L
         kwKpPx1VvPFI+dGil14wlj/dvhDMY9LE9l7jx8YpRzDa+LHVXquJSzHfbTxqPYDU5qpv
         LbbbeHcAg9RY9ule5sHzAgF8fDtTRf1bQ2x8zLfyHDT2cSWlbUyfEvzYKM7JKB5hYfFT
         R/SR79q3m52+bl4/KNknaGr/UbfbD5qlb4ZFOZkc1W/k+uVttDIxtjsPmk23Xh/9fPMz
         I3jA==
X-Gm-Message-State: APjAAAUQH6/alexHkz8cCcvI7iiLwguZcL1ad3/sVnA156M3MEuhvKx2
        I1viBo44nNxSGI3kFAAaXQM=
X-Google-Smtp-Source: APXvYqx56IdmJiLXaMgdq04mVeR7eOhdvMcDh1NwoJiKStDEYkxTHq/VWzW4PEmmv79OI3RHbeAh4w==
X-Received: by 2002:a17:902:700b:: with SMTP id y11mr87273466plk.304.1577983007154;
        Thu, 02 Jan 2020 08:36:47 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i66sm33301772pfg.85.2020.01.02.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:36:45 -0800 (PST)
Subject: Re: [PATCH v6 02/25] rtrs: public interface header to establish RDMA
 connections
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-3-jinpuwang@gmail.com>
 <cc66bb26-68da-8add-6813-a330dc23facd@acm.org>
 <CAMGffEmdQ2SuP6JTrPYyP70ZYPC+H+GSyL2Lib7mbG4-DUN6Kg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8b070c98-a9fd-3cb1-d619-8836bf38b851@acm.org>
Date:   Thu, 2 Jan 2020 08:36:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMGffEmdQ2SuP6JTrPYyP70ZYPC+H+GSyL2Lib7mbG4-DUN6Kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/2/20 5:35 AM, Jinpu Wang wrote:
> On Mon, Dec 30, 2019 at 8:25 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>> +/**
>>> + * enum rtrs_clt_con_type() type of ib connection to use with a given permit
>>
>> What is a "permit"?
> Does use rtrs_permit sound better?

I think keeping the word "permit" is fine. How about adding a comment 
above rtrs_permit that explains more clearly what the role of that data 
structure is? This is what I found in rtrs-clt.h:

/**
  * rtrs_permit - permits the memory allocation for future RDMA operation
  */
struct rtrs_permit {
         enum rtrs_clt_con_type con_type;
         unsigned int cpu_id;
         unsigned int mem_id;
         unsigned int mem_off;
};

Thanks,

Bart.
