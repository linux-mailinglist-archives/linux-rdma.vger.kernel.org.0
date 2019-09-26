Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EABF5D2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfIZPYf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:24:35 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:34580 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZPYf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:24:35 -0400
Received: by mail-qk1-f181.google.com with SMTP id q203so2129484qke.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=BTTT4FL9/wryDpZkrFJJU9WV0fl5pQC1nCKKpwS+M80=;
        b=nMEc7SiA62R7ctC/Fe3/ar4Wykpj8be1h1TeX5YgkwPxNvv/8YvDCA2HeRaAFCmUux
         H/6kmctVqwSZudcJEsVjGFxzVsxDdhojhVzfGIS34vaYUq2REHFXx+aloYeQh3+nhf6Q
         j7+Rh5ALxXvZAc5eQrCbPa/3RATxP8T0IEkWNBChVCfNb9KN93VgD8eXT7VgFonAKZaq
         c2IrFUSSWGcfs7nzFbBRXg4mnxHqvH/uI0bPhPMCdV+1rrBcu4ketMmBWVbB+JFbdGSs
         avhsuIeBEY/C+gp4yZxzdp5tZ+2BZ4oWRrCcpg1Xd2DDLgX0DFAoS0MdFvedFOc4OTqX
         7sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BTTT4FL9/wryDpZkrFJJU9WV0fl5pQC1nCKKpwS+M80=;
        b=Mvm1o2nFrlDMuzkq0dqp8XR4W9cSv/bN5OAZEW8BgP1kiGbxg3wzidmSxofMMu8JsC
         jPnaNeHGRmvvIqg5vg6zo63g2QwNtBF+JYDD7fDZZPoILlkGFNMNUKTcrwJlh5/vLias
         wihMK4VirflVgLvf4q9fI5++E5PzCuvQKONCnkM7QymXGjEs7ujXolRFXmeiBlhllVfS
         5H9YCPqLwwJVJPajQql5bbSRXiCnAXpX5BdkXyythmD8UW2bEaWg7uwqXUOpAdJe3usC
         ltah/azD4Mua7iK3X2bKfHLKCmCFAcLO7L7C1IerQi9x+weMsd4VJp+MBoCzEmlTjSMt
         fEWw==
X-Gm-Message-State: APjAAAVGfO+9vP9zhW37f8cgG1jkIM2GTlJYPa/69VsO8MiDt7VZgczQ
        WxrHbUmmULgRCWV/lpm1XVSz9EhT
X-Google-Smtp-Source: APXvYqyKfPAmctuNmQJGC0TWbOU6B47IDtMFI6mq7NW24taWVOd9bgqVKaawnhyH0IB+pGI2i+AXew==
X-Received: by 2002:a05:620a:140b:: with SMTP id d11mr3851846qkj.22.1569511473748;
        Thu, 26 Sep 2019 08:24:33 -0700 (PDT)
Received: from [10.48.108.64] (DATADIRECT.bear1.Baltimore1.Level3.net. [4.34.0.142])
        by smtp.gmail.com with ESMTPSA id d69sm1099433qkc.87.2019.09.26.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:24:32 -0700 (PDT)
Subject: Re: SRP subnet timeout
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org
References: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
 <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
 <dbdc27d0-93bf-947c-0c6c-41f4a7d20385@gmail.com>
 <0068b947-a405-fec3-c0e4-6be4c78c7448@acm.org>
From:   Karandeep Chahal <karandeepchahal@gmail.com>
Message-ID: <683077ff-834a-1184-fbd0-28b4e6e3eeda@gmail.com>
Date:   Thu, 26 Sep 2019 11:24:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0068b947-a405-fec3-c0e4-6be4c78c7448@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/19 11:14 AM, Bart Van Assche wrote:
>
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> On 9/26/19 8:00 AM, Karandeep Chahal wrote:
>> I understand that you have made "SRP CM timeout dependent on subnet 
>> timeout", but my
>> question is, why did you add "2" to the subnet timeout? How did you 
>> come up with
>> this number?
>>
>> Forgive me but it is not obvious to me after reading the commit message.
>
> Hi Karandeep,
>
> I haven't done any kind of deep research to come up with that value. 
> My goal was to preserve the CM timeout used by the SRP initiator for 
> the default opensm subnet timeout value (18). There may be better 
> choices for the SRP CM timeout.
>
> Bart.

Hi Bart,

My apologies for top-posting.

The problem with adding 2 to SRP CM timeout is that it makes the SRP CM 
timeout value far off the subnet timeout value.
Now you can either have a reasonable subnet timeout value and an 
unreasonable SRP CM timeout value, or an unreasonable subnet timeout and 
a reasonable SRP CM timeout.

-Karan

