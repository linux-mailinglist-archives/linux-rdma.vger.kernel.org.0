Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2073BF54F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfIZOyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 10:54:51 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43189 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIZOyv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 10:54:51 -0400
Received: by mail-pf1-f173.google.com with SMTP id a2so1971528pfo.10
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 07:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUfCnZSTRUZI6HUwnYYXNwwBbXO5THKj3dz7POlxdQ8=;
        b=hpTlCRwRnIJ786jD+3ZjCsMIFUElU/O1m2X6FPeBap/hJygPXzj0kFGOpC4YKPc/nY
         EzcWbzCW1WRjUOpAA2waWePM3Gu43nWtEbmbzhr7zRpV2QIShtNKzOGt+s+NWoOqFszZ
         xMn7BHjm1FHU7wgP/Y9G6h0rBX2XUW8PwlwaL9s3vQYJ3UyPdohSQ0+cmL/EEh8jeoWK
         oVVVzlPsL8RyT6wYqFh0oBRadVklGaU6QVNXO2+0V2+qMH86pfxqD2APTpwhnLV8uwLe
         S88+fX+hvpIJ5czMaRUhrub98ApMaEfz9DoTucN7MH5PB9DzrKRJDyhdhd6eobV/rxBA
         yD9Q==
X-Gm-Message-State: APjAAAXMk/m2LeSBvAUVObzUcL4BqVD2+O5YE6ynX9gZcy36iXNBX1vb
        pATjPFCejIoNflD8MUpSniA=
X-Google-Smtp-Source: APXvYqzsmMJ8itaRsukc/j3G6Wo+rfRIZjBMjlPJX0XNCSsVdPZMLndg1Do2W7hON7zx2gWHGvdKWw==
X-Received: by 2002:a63:2062:: with SMTP id r34mr3899079pgm.48.1569509690564;
        Thu, 26 Sep 2019 07:54:50 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e1sm2293256pgd.21.2019.09.26.07.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:54:49 -0700 (PDT)
Subject: Re: SRP subnet timeout
To:     Karandeep Chahal <karandeepchahal@gmail.com>,
        linux-rdma@vger.kernel.org
Cc:     bart.vanassche@wdc.com
References: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
Date:   Thu, 26 Sep 2019 07:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/19 7:10 AM, Karandeep Chahal wrote:
> I am wondering why SRP REQ CM timeout is "subnet_timeout + 2". What was the
> reason behind adding 2 to the subnet timeout? I think it was added by Bart
> in commit 4c532d6ce14bb3fb4e1cb2d29fafdd7d6bded51c, but the commit message
> does not explain why the 2 is necessary. Would anyone happen to know?
> 
> My understanding is that adding 2 causes the CM timeout value to become 
> 4 times
> the subnet_timeout value. Hence, even if you have a reasonable 
> subnet_timeout
> the CM REQ timeout becomes too high.

Hi Karan,

I think the description of that commit explains why that change has been 
made:

     IB/srp: Make CM timeout dependent on subnet timeout

     For small networks it is safe to reduce the subnet timeout from
     its default value (18 for opensm) to 16. Make the SRP CM timeout
     dependent on the subnet timeout such that decreasing the subnet
     timeout also causes SRP failover and failback to occur faster.

Bart.
