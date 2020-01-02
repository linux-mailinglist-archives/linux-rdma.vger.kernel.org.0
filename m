Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB10D12EB06
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 22:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgABVHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 16:07:10 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44117 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVHJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 16:07:09 -0500
Received: by mail-pl1-f178.google.com with SMTP id az3so18256863plb.11;
        Thu, 02 Jan 2020 13:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuVv97eyIemkAMeVge7I3l88KsPUVa7tYbSHOzH+w74=;
        b=ruwpdg18c4bdhQUo/ShjXTOrQoPuACoC6kx/vl3ndkl2t9OPiEGM+zYji3HKcpxre+
         EeKFi+X7nLZTCaQTmShhovIM13SCRthOIIcHzoQMz9l7R3OOfz/Pcl/LDkOhAsKwV85Z
         37eEicrRCywzF+3foTx4dJh+koL7AlQuW+hDtXw/l+maEIHGxPgR/IJMeor65xFBGnkM
         jcD3EWXTsFUZMpAJncmsM1MwDyCtlLMdpBH6GgCB23sVTSE4gQ/QUQTOH+kk3m8Y9REW
         QIiADfTc8kZ8yhsJNXWz6t+xKuA4yTntJLu707WsV7/roGPgcAkR1fv84Dgvo02SCqMt
         XSaQ==
X-Gm-Message-State: APjAAAWz/MTJ260KrPq9reJLeLsrb+aSq9w0FaQ9lIZiGkQ4yt/EzGjG
        7iDcqt5edvYUJV6DahqYVzQ=
X-Google-Smtp-Source: APXvYqwriHRtefuZ+nTMhSzhumBpyea2cVR/jq3Ph9ToZ3xiJqe+wnu5/x48KVt8XCXSrQMwQvTeEw==
X-Received: by 2002:a17:90a:5108:: with SMTP id t8mr22376938pjh.107.1577999229189;
        Thu, 02 Jan 2020 13:07:09 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f9sm63197657pfd.141.2020.01.02.13.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 13:07:08 -0800 (PST)
Subject: Re: [PATCH v6 07/25] rtrs: client: statistics functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-8-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c4875699-68a6-9a82-4324-553f30504574@acm.org>
Date:   Thu, 2 Jan 2020 13:07:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-8-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> This introduces set of functions used on client side to account
> statistics of RDMA data sent/received, amount of IOs inflight,
> latency, cpu migrations, etc.  Almost all statistics is collected
                                                        ^^
                                                        are?
> using percpu variables.
> [ ... ]
> +static inline int rtrs_clt_ms_to_id(unsigned long ms)
> +{
> +	int id = ms ? ilog2(ms) - MIN_LOG_LAT + 1 : 0;
> +
> +	return clamp(id, 0, LOG_LAT_SZ - 1);
> +}

I think it is unusual to call the returned value an "id" in this 
context. How about changing "id" into "bin" or "bucket"? See also 
https://en.wikipedia.org/wiki/Histogram.

Thanks,

Bart.
